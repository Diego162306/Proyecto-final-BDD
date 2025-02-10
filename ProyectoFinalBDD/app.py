from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector
from datetime import datetime
import uuid

app = Flask(__name__)
app.secret_key = 'uuuuuuuuuu'  # Clave secreta para manejar sesiones

# Configuración de la conexión a MySQL
db = mysql.connector.connect(
     host="localhost",
    user="SIntetica",  
    password="tu_contraseña",  
    database="newschema"  
)

# Ruta principal
@app.route('/')
def index():
    if 'usuario' in session:
        return render_template('index.html', usuario=session['usuario'])
    return redirect(url_for('login'))

# Ruta para el login de usuarios
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Usuario WHERE email = %s AND password = %s", (email, password))
        usuario = cursor.fetchone()
        cursor.close()

        if usuario:
            session['usuario'] = usuario

            # Solo buscar idCliente si el usuario es un cliente
            if usuario['rol'] == 'cliente':
                cursor = db.cursor(dictionary=True)
                cursor.execute("SELECT idCliente FROM Cliente WHERE idUsuario = %s", (usuario['idUsuario'],))
                cliente = cursor.fetchone()
                cursor.close()

                if cliente:
                    session['usuario']['idCliente'] = cliente['idCliente']
                else:
                    flash('No se encontró un cliente asociado a este usuario', 'danger')
                    return redirect(url_for('login'))

            return redirect(url_for('index'))
        else:
            flash('Correo electrónico o contraseña incorrectos', 'danger')

    return render_template('login.html')

# Ruta para el registro de nuevos usuarios (solo clientes)
@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        telefono_movil = request.form['telefono_movil']
        telefono_convencional = request.form['telefono_convencional']
        email = request.form['email']
        password = request.form['password']

        # Verificar si el correo ya está registrado
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Usuario WHERE email = %s", (email,))
        usuario_existente = cursor.fetchone()

        if usuario_existente:
            flash('El correo electrónico ya está registrado', 'danger')
        else:
            # Insertar nuevo usuario con rol 'cliente'
            cursor.execute("""
                INSERT INTO Usuario (nombre, apellido, telefono_movil, telefono_convencional, email, password, rol)
                VALUES (%s, %s, %s, %s, %s, %s, 'cliente')
            """, (nombre, apellido, telefono_movil, telefono_convencional, email, password))
            db.commit()
            cursor.close()

            flash('Registro exitoso. Ahora puedes iniciar sesión.', 'success')
            return redirect(url_for('login'))

    return render_template('registro.html')

# Ruta para crear una nueva reserva
@app.route('/nueva_reserva', methods=['GET', 'POST'])
def nueva_reserva():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    if session['usuario']['rol'] != 'cliente':
        flash('Solo los clientes pueden crear reservas', 'danger')
        return redirect(url_for('index'))

    if request.method == 'POST':
        fecha_uso = request.form['fecha_uso']
        hora_uso = request.form['hora_uso']
        id_cancha = request.form['id_cancha']
        id_cliente = session['usuario'].get('idCliente')  # Usar el idCliente almacenado en la sesión

        if not id_cliente:
            flash('No se encontró un cliente asociado a este usuario', 'danger')
            return redirect(url_for('nueva_reserva'))

        # Generar un comprobante de reserva único
        comprobante_reserva = str(uuid.uuid4())

        cursor = db.cursor()
        cursor.execute("""
            INSERT INTO Reserva (fechaUso, horaUso, comprobanteReserva, fechaReserva, idCliente, idCancha)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (fecha_uso, hora_uso, comprobante_reserva, datetime.now(), id_cliente, id_cancha))
        db.commit()
        cursor.close()

        flash('Reserva creada exitosamente', 'success')
        return redirect(url_for('reservas'))

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Cancha WHERE estado = 'disponible'")
    canchas = cursor.fetchall()
    cursor.close()

    return render_template('nueva_reserva.html', canchas=canchas)

# Ruta para el logout
@app.route('/logout')
def logout():
    session.pop('usuario', None)  # Eliminar usuario de la sesión
    flash('Sesión cerrada correctamente', 'success')
    return redirect(url_for('login'))

# Ruta para mostrar usuarios (solo administradores)
@app.route('/usuarios')
def usuarios():
    if 'usuario' not in session:
        return redirect(url_for('login'))
    if session['usuario']['rol'] != 'admin':
        flash('No tienes permisos para acceder a esta página', 'danger')
        return redirect(url_for('index'))

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Usuario")
    usuarios = cursor.fetchall()
    cursor.close()
    return render_template('usuarios.html', usuarios=usuarios)

# Ruta para mostrar canchas
@app.route('/canchas')
def canchas():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Cancha")
    canchas = cursor.fetchall()
    cursor.close()
    return render_template('canchas.html', canchas=canchas)

# Ruta para mostrar reservas
@app.route('/reservas')
def reservas():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT Reserva.*, Usuario.nombre, Usuario.apellido 
        FROM Reserva 
        JOIN Cliente ON Reserva.idCliente = Cliente.idCliente 
        JOIN Usuario ON Cliente.idUsuario = Usuario.idUsuario
    """)
    reservas = cursor.fetchall()
    cursor.close()
    return render_template('reservas.html', reservas=reservas)

# Ruta para agregar una nueva cancha (solo administradores)
@app.route('/nueva_cancha', methods=['GET', 'POST'])
def nueva_cancha():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    if session['usuario']['rol'] != 'admin':
        flash('Solo los administradores pueden agregar nuevas canchas', 'danger')
        return redirect(url_for('index'))

    if request.method == 'POST':
        nombre = request.form['nombre']
        precio = request.form['precio']
        estado = request.form['estado']
        tipo = request.form['tipo']

        cursor = db.cursor()
        cursor.execute("""
            INSERT INTO Cancha (nombre, precio, estado, tipo)
            VALUES (%s, %s, %s, %s)
        """, (nombre, precio, estado, tipo))
        db.commit()
        cursor.close()

        flash('Cancha agregada exitosamente', 'success')
        return redirect(url_for('canchas'))

    return render_template('nueva_cancha.html')

# Iniciar la aplicación
if __name__ == '__main__':
    
    app.run(debug=True)