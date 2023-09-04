use axum::{routing::get, Router};
use sea_orm::{
    entity::prelude::*, ActiveValue, ConnectOptions, ConnectionTrait, Database, DatabaseConnection,
    SqlxPostgresConnector, SqlxPostgresPoolConnection,
};

async fn hello_world() -> &'static str {
    "Hello, world!"
}

#[shuttle_runtime::main]
async fn axum(
    #[shuttle_shared_db::Postgres] pool: PgPool,
) -> shuttle_axum::ShuttleAxum {
    let conn = SqlxPostgresConnector::from_sqlx_postgres_pool(pool);
    // pool.execute(include_str!("../schema.sql"))
    //     .await
    //     .map_err(|_error| StatusCode::INTERNAL_SERVER_ERROR)?;
    let router = Router::new().route("/", get(hello_world));

    Ok(router.into())
}
