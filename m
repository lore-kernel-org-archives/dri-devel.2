Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FA8CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B5310E9FC;
	Thu, 25 Jun 2026 12:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eZC+ZAQp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A243E10E9FC;
 Thu, 25 Jun 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782392391; x=1813928391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p5eOpW7r//XraErjRlHD4ysZvlLdU46jUFAim0sGv+M=;
 b=eZC+ZAQpmKF3uqgZ8+0G5p3oI5Uax6eZCmBS3+Pfm7nIluz+JjlnBooR
 FNwJ3/HLUfLTOFDojG1expodN/CH3hvJ4ivQOHCnIAEg6Stx8V8fBq0f/
 yb9ypsRqH5d4aXvo5dc8u9qeH5Yywv5+Za+FFauARazDiH82mkua1r6mH
 h3B/GIaUkOqHbvi6hX64ga0Cgb2CNP5GOqf9UpJyro/oNkUoJIeo6dtzI
 YlQenEquB7r6SlbRnqal+32bTcJoHD3Xyjh8UhcLaVmbUYaZHuVwGUsI5
 OvhWYsXqn1khZ0sDmXN39WV5fStTTa3cliUNg48aVv0Uw1PM5l2BQJwmH g==;
X-CSE-ConnectionGUID: Qny67l5vRGaJo43zlnVnQA==
X-CSE-MsgGUID: xXh28VRhRrCGNypAHtkKDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82287381"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="82287381"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:59:50 -0700
X-CSE-ConnectionGUID: xXMPW61eSHmd+r1ZsSMp0Q==
X-CSE-MsgGUID: lQ5PvybkRg2CPs6X5Uy+7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280857088"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 05:59:47 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andi Shyti <andi.shyti@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/xe/i2c: Handler for SMBus Alerts
Date: Thu, 25 Jun 2026 14:59:38 +0200
Message-ID: <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Some devices that are attached to the I2C controller use the
SMBus Alert signal for example to inform the host about
thermal events, so registering the default SMBus Alert
device for them. The alert device makes sure that the alert
is processed and passed to the correct I2C client driver.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/gpu/drm/xe/Kconfig            |  1 +
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h |  2 +
 drivers/gpu/drm/xe/xe_i2c.c           | 53 +++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.h           |  5 +++
 4 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b915..7045ba19943e3 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -46,6 +46,7 @@ config DRM_XE
 	select WANT_DEV_COREDUMP
 	select AUXILIARY_BUS
 	select REGMAP if I2C
+	select I2C_SMBUS
 	help
 	  Driver for Intel Xe2 series GPUs and later. Experimental support
 	  for Xe series is also available.
diff --git a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
index f2e455e2bfe45..37550e4a20f80 100644
--- a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
@@ -20,4 +20,6 @@
 #define I2C_CONFIG_CMD			XE_REG(I2C_CONFIG_SPACE_OFFSET + PCI_COMMAND)
 #define I2C_CONFIG_PMCSR		XE_REG(I2C_CONFIG_SPACE_OFFSET + 0x84)
 
+#define I2C_REG(reg)			XE_REG((reg) + I2C_MEM_SPACE_OFFSET)
+
 #endif /* _XE_I2C_REGS_H_ */
diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07d..0495b561957a2 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -9,8 +9,10 @@
 #include <linux/array_size.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/designware_i2c.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -30,6 +32,7 @@
 #include "xe_device.h"
 #include "xe_i2c.h"
 #include "xe_mmio.h"
+#include "xe_platform_types.h"
 #include "xe_sriov.h"
 #include "xe_survivability_mode.h"
 
@@ -46,6 +49,7 @@
  */
 
 static const char adapter_name[] = "i2c_designware";
+static struct i2c_smbus_alert_setup xe_i2c_smbus_setup;
 
 static const struct property_entry xe_i2c_adapter_properties[] = {
 	PROPERTY_ENTRY_STRING("compatible", "intel,xe-i2c"),
@@ -61,6 +65,37 @@ static inline void xe_i2c_read_endpoint(struct xe_mmio *mmio, void *ep)
 	val[1] = xe_mmio_read32(mmio, REG_SG_REMAP_ADDR_POSTFIX);
 }
 
+static void xe_i2c_handle_smbus_alert(struct xe_i2c *i2c)
+{
+	u32 stat;
+
+	stat = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_SMBUS_INTR_STAT));
+	if (!stat)
+		return;
+
+	xe_mmio_write32(i2c->mmio, I2C_REG(DW_IC_CLR_SMBUS_INTR), stat);
+
+	if (stat & DW_IC_SMBUS_INTR_ALERT)
+		i2c_handle_smbus_alert(i2c->client[XE_I2C_CLIENT_ALERT]);
+}
+
+static int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
+{
+	struct xe_device *xe = kdev_to_xe_device(i2c->drm_dev);
+	struct i2c_client *alert;
+
+	if (xe->info.platform != XE_CRESCENTISLAND)
+		return 0;
+
+	alert = i2c_new_smbus_alert_device(i2c->adapter, &xe_i2c_smbus_setup);
+	if (IS_ERR(alert))
+		return PTR_ERR(alert);
+
+	i2c->client[XE_I2C_CLIENT_ALERT] = alert;
+
+	return 0;
+}
+
 static void xe_i2c_client_work(struct work_struct *work)
 {
 	struct xe_i2c *i2c = container_of(work, struct xe_i2c, work);
@@ -69,8 +104,13 @@ static void xe_i2c_client_work(struct work_struct *work)
 		.flags	= I2C_CLIENT_HOST_NOTIFY,
 		.addr	= i2c->ep.addr[1],
 	};
+	int ret;
 
-	i2c->client[0] = i2c_new_client_device(i2c->adapter, &info);
+	ret = xe_i2c_register_smbus_alert(i2c);
+	if (ret)
+		dev_warn(i2c->drm_dev, "failed to register smbus alert (%d)\n", ret);
+
+	i2c->client[XE_I2C_CLIENT_AMC] = i2c_new_client_device(i2c->adapter, &info);
 }
 
 static int xe_i2c_notifier(struct notifier_block *nb, unsigned long action, void *data)
@@ -163,7 +203,7 @@ bool xe_i2c_present(struct xe_device *xe)
 
 static bool xe_i2c_irq_present(struct xe_device *xe)
 {
-	return xe->i2c && xe->i2c->adapter_irq;
+	return xe->i2c && (xe->i2c->adapter_irq || xe->i2c->client[XE_I2C_CLIENT_ALERT]);
 }
 
 /**
@@ -182,7 +222,10 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
 		return;
 
 	/* Forward interrupt to I2C adapter */
-	generic_handle_irq_safe(xe->i2c->adapter_irq);
+	if (xe->info.platform == XE_CRESCENTISLAND)
+		xe_i2c_handle_smbus_alert(xe->i2c);
+	else
+		generic_handle_irq_safe(xe->i2c->adapter_irq);
 
 	/* Deassert after I2C adapter clears the interrupt */
 	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
@@ -307,8 +350,10 @@ static void xe_i2c_remove(void *data)
 	struct xe_i2c *i2c = data;
 	unsigned int i;
 
-	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++)
+	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
 		i2c_unregister_device(i2c->client[i]);
+		i2c->client[i] = NULL;
+	}
 
 	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
 	xe_i2c_unregister_adapter(i2c);
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index 425d8160835f4..b3327db998708 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -23,6 +23,11 @@ struct xe_mmio;
 /* Endpoint Capabilities */
 #define XE_I2C_EP_CAP_IRQ		BIT(0)
 
+enum XE_I2C_CLIENT {
+	XE_I2C_CLIENT_AMC,
+	XE_I2C_CLIENT_ALERT,
+};
+
 struct xe_i2c_endpoint {
 	u8 cookie;
 	u8 capabilities;
-- 
2.50.1

