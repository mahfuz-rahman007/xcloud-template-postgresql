services:
  postgres:
    container_name: postgresql-{{ site_name }}
    image: postgres:{{ app_version | default:"17" }}-alpine
    restart: always
    env_file:
      - .env
    volumes:
      - pgdata:/var/lib/postgresql/data
    ports:
      - "127.0.0.1:{{ ports.postgres }}:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
    networks:
      - {{ network_name }}

volumes:
  pgdata:

networks:
  {{ network_name }}:
    driver: bridge
