Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8FCCD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED06810E659;
	Mon, 22 Jun 2026 11:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WCSt0c2H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9B010E658;
 Mon, 22 Jun 2026 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782128886; x=1813664886;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GmmxGQc7x2JxDKWtGBQfRIK+YCbxiDdz4W8e5n4QgjQ=;
 b=WCSt0c2H+uOe0z25W0ptbELud51tk+Smu/8KEXJ90OP6A1NlJ+dfy6sI
 AJx3AdAMFwOJLgbdn8Ip3IpgkUdcyaSf3p7axeTDJZdVk1vnAlWoKBCaI
 ckT0FK6tm7eQ5GMHbKsC8RiOxKoMUmCB3vXaLVfPRfsBe6s/4WTQeASxu
 vrhWgANnmwKWh631Aa7Nl2dzqEP5vTHyZWSEZ2wNiduZtE0+72t94J3aB
 gYtRKeYNZDtbmDM7im7IzRE4EQZ9o/f9G19pi+ua/BeXHZCx9Ce5/H+oa
 nYPxGkM6FVsqzFvXOgqPtBa4PvNlYwX05kDEpCkJ09n26pd6zcFCcQ8hp g==;
X-CSE-ConnectionGUID: cSU1+0xlRdan3EvXry/tuQ==
X-CSE-MsgGUID: GWHvwruIQD+GdZdrxvq8HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93510049"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93510049"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 04:48:06 -0700
X-CSE-ConnectionGUID: PvCt/RY2Sy2zCmMC01ZElg==
X-CSE-MsgGUID: C0txd8HRQaKfuHUFhpoWdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="272909371"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP; 22 Jun 2026 04:48:03 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] drm/xe/i2c: Handler for SMBus Alerts
Date: Mon, 22 Jun 2026 13:47:58 +0200
Message-ID: <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
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
device device for them. The alert device makes sure that
the alert is processed and passed to the correct I2C client
driver.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/gpu/drm/xe/Makefile       |  1 +
 drivers/gpu/drm/xe/xe_i2c.c       | 21 +++++++----
 drivers/gpu/drm/xe/xe_i2c.h       | 15 ++++++++
 drivers/gpu/drm/xe/xe_i2c_smbus.c | 59 +++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_i2c_smbus.c

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 8e7b146880f46..9c8af00cf37fd 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -153,6 +153,7 @@ xe-y += xe_bb.o \
 	xe_wopcm.o
 
 xe-$(CONFIG_I2C)	+= xe_i2c.o
+xe-$(CONFIG_I2C_SMBUS)	+= xe_i2c_smbus.o
 xe-$(CONFIG_DRM_XE_GPUSVM) += xe_svm.o
 xe-$(CONFIG_DRM_GPUSVM) += xe_userptr.o
 
diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07d..732ad6ee05e9c 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -30,6 +30,7 @@
 #include "xe_device.h"
 #include "xe_i2c.h"
 #include "xe_mmio.h"
+#include "xe_platform_types.h"
 #include "xe_sriov.h"
 #include "xe_survivability_mode.h"
 
@@ -163,7 +164,7 @@ bool xe_i2c_present(struct xe_device *xe)
 
 static bool xe_i2c_irq_present(struct xe_device *xe)
 {
-	return xe->i2c && xe->i2c->adapter_irq;
+	return xe->i2c && (xe->i2c->adapter_irq || xe->i2c->smbus_alert);
 }
 
 /**
@@ -182,7 +183,10 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
 		return;
 
 	/* Forward interrupt to I2C adapter */
-	generic_handle_irq_safe(xe->i2c->adapter_irq);
+	if (xe->i2c->smbus_alert)
+		xe_i2c_handle_smbus_alert(xe->i2c);
+	else
+		generic_handle_irq_safe(xe->i2c->adapter_irq);
 
 	/* Deassert after I2C adapter clears the interrupt */
 	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
@@ -232,6 +236,9 @@ static int xe_i2c_create_irq(struct xe_device *xe)
 	    xe_survivability_mode_is_boot_enabled(xe))
 		return 0;
 
+	if (xe->info.platform == XE_CRESCENTISLAND)
+		return xe_i2c_register_smbus_alert(i2c);
+
 	domain = irq_domain_create_linear(dev_fwnode(i2c->drm_dev), 1, &xe_i2c_irq_ops, NULL);
 	if (!domain)
 		return -ENOMEM;
@@ -244,6 +251,9 @@ static int xe_i2c_create_irq(struct xe_device *xe)
 
 static void xe_i2c_remove_irq(struct xe_i2c *i2c)
 {
+	if (i2c->smbus_alert)
+		i2c_unregister_device(i2c->smbus_alert);
+
 	if (!i2c->irqdomain)
 		return;
 
@@ -327,7 +337,6 @@ int xe_i2c_probe(struct xe_device *xe)
 {
 	struct device *drm_dev = xe->drm.dev;
 	struct xe_i2c_endpoint ep;
-	struct regmap *regmap;
 	struct xe_i2c *i2c;
 	int ret;
 
@@ -354,9 +363,9 @@ int xe_i2c_probe(struct xe_device *xe)
 	/* PCI PM isn't aware of this device, bring it up and match it with SGUnit state. */
 	xe_i2c_pm_resume(xe, true);
 
-	regmap = devm_regmap_init(drm_dev, NULL, i2c, &i2c_regmap_config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	i2c->regmap = devm_regmap_init(drm_dev, NULL, i2c, &i2c_regmap_config);
+	if (IS_ERR(i2c->regmap))
+		return PTR_ERR(i2c->regmap);
 
 	i2c->bus_notifier.notifier_call = xe_i2c_notifier;
 	ret = bus_register_notifier(&i2c_bus_type, &i2c->bus_notifier);
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index 425d8160835f4..fdbad51950423 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -3,6 +3,7 @@
 #define _XE_I2C_H_
 
 #include <linux/bits.h>
+#include <linux/errno.h>
 #include <linux/notifier.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -12,6 +13,7 @@ struct fwnode_handle;
 struct i2c_adapter;
 struct i2c_client;
 struct irq_domain;
+struct regmap;
 struct platform_device;
 struct xe_device;
 struct xe_mmio;
@@ -40,6 +42,8 @@ struct xe_i2c {
 
 	struct irq_domain *irqdomain;
 	int adapter_irq;
+	struct i2c_client *smbus_alert;
+	struct regmap *regmap;
 
 	struct xe_i2c_endpoint ep;
 	struct device *drm_dev;
@@ -65,4 +69,15 @@ static inline void xe_i2c_pm_suspend(struct xe_device *xe) { }
 static inline void xe_i2c_pm_resume(struct xe_device *xe, bool d3cold) { }
 #endif
 
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+void xe_i2c_handle_smbus_alert(struct xe_i2c *i2c);
+int xe_i2c_register_smbus_alert(struct xe_i2c *i2c);
+#else
+static inline void xe_i2c_handle_smbus_alert(struct xe_i2c *i2c) { }
+static inline int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_i2c_smbus.c b/drivers/gpu/drm/xe/xe_i2c_smbus.c
new file mode 100644
index 0000000000000..185a6d2f0a508
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_i2c_smbus.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Intel Xe SMBus handling
+ *
+ * Copyright (C) 2026 Intel Corporation.
+ */
+
+#include <linux/i2c-smbus.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "xe_i2c.h"
+
+/**
+ * DOC: Handler for SMBus Alerts
+ *
+ * If the I2C controller on the platform supports the SMBus extensions, a
+ * dedicated SMBus alert device needs to be registered for it. The alert device
+ * handles the standard SMBus alert processing and forwarding of the alert to
+ * the correct I2C client driver. On most platforms the i2c client device that
+ * generates the alerts will be the AMC.
+ */
+
+#define DW_IC_SMBUS_INTR_STAT			0xc8
+#define DW_IC_CLR_SMBUS_INTR			0xd4
+
+#define DW_IC_SMBUS_INTR_ALERT			BIT(10)
+
+void xe_i2c_handle_smbus_alert(struct xe_i2c *i2c)
+{
+	u32 stat;
+
+	if (!i2c->smbus_alert)
+		return;
+
+	regmap_read(i2c->regmap, DW_IC_SMBUS_INTR_STAT, &stat);
+	if (!stat)
+		return;
+
+	regmap_write(i2c->regmap, DW_IC_CLR_SMBUS_INTR, stat);
+
+	if (stat & DW_IC_SMBUS_INTR_ALERT)
+		i2c_handle_smbus_alert(i2c->smbus_alert);
+}
+
+static struct i2c_smbus_alert_setup xe_i2c_smbus_setup;
+
+int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
+{
+	struct i2c_client *alert;
+
+	alert = i2c_new_smbus_alert_device(i2c->adapter, &xe_i2c_smbus_setup);
+	if (IS_ERR(alert))
+		return PTR_ERR(alert);
+
+	i2c->smbus_alert = alert;
+
+	return 0;
+}
-- 
2.50.1

