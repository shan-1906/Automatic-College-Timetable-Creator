"""Flask application configuration for College Timetable Generator."""

import os


class Config:
    """Base configuration."""
    SECRET_KEY = os.environ.get('SECRET_KEY', 'college-timetable-secret-key-2026')

    # MySQL Configuration (XAMPP defaults)
    MYSQL_HOST = os.environ.get('MYSQL_HOST', 'localhost')
    MYSQL_USER = os.environ.get('MYSQL_USER', 'root')
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', '')
    MYSQL_DB = os.environ.get('MYSQL_DB', 'college_timetable')
    MYSQL_PORT = int(os.environ.get('MYSQL_PORT', 3306))

    # Upload folder for exports
    EXPORT_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'exports')
