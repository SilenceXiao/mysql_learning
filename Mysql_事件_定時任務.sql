-- CREATE EVENT IF NOT EXISTS e_autoTotal
-- ON SCHEDULE EVERY 1 MONTH STARTS DATE_ADD(DATE_ADD(DATE_SUB(CURDATE(),INTERVAL DAY(CURDATE())-1 DAY),INTERVAL 1 MONTH),INTERVAL 1 HOUR)
-- ON COMPLETION PRESERVE ENABLE
-- DO CALL sp_icon_warehouse_snap()

-- 創建事件
DROP EVENT IF EXISTS e_autoTotal;
CREATE EVENT IF NOT EXISTS e_autoTotal
ON SCHEDULE EVERY 1 MINUTE
ON COMPLETION PRESERVE
COMMENT '新增snap信息定时任务'
DO CALL sp_icon_warehouse_snap()

-- 查看事件
SELECT * FROM information_schema.events; 

-- 查看事件调度器是否开启
SHOW VARIABLES LIKE 'event_scheduler';
SELECT @@event_scheduler;
SHOW PROCESSLIST;

-- 開啟事件調度器
SET GLOBAL event_scheduler = ON;
-- 開啟事件調度器
SET GLOBAL event_scheduler = OFF;

-- 開啟事件
ALTER EVENT e_autoTotal ENABLE;
-- 關閉事件
ALTER EVENT e_autoTotal DISABLE;
