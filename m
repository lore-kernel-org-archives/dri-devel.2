Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A926DCDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2EFB10E6A5;
	Thu, 25 Jun 2026 13:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="as/4kRlJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5246110EAA5;
 Thu, 25 Jun 2026 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782392394; x=1813928394;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ju3gfzFeBeams+3Iev1BlEjXoqqkURWq1dmcBXf0Gac=;
 b=as/4kRlJR8JJYKBvLFUQwjKrpExIgArLZ54zyXj/Bog75xmMY1ry0u/6
 1kze4B0ZwGTkKGmcQihwc0vgVhu3cNogtY9p3YQAZwBCx3qYB0z9HbCF6
 HLgvhmVqHDVmVBLqXk8BRoET11pVDChuf7sF07PpcfFdYsoWhpYtWlL6J
 XQnw4tPjqLuxQ/9cvHfhWANsrNCmvJoXGxFPJqdF7IgY5eRUoTbmsbi1X
 F+cNdgUlDGF9fmSvKpoHsvbfbXuR8ycy626gLQ3JAXvSIMe01IuJF7PUM
 JqmkBWx3vaxsQfBc2MJvHyRLqanEihJZQVJXO94rA3c4nX2CFVihDFj2A g==;
X-CSE-ConnectionGUID: i4uDSgtiRpCBGjwWxL4keA==
X-CSE-MsgGUID: yXyCaomCTHO2uzSbkjQYvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82287398"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="82287398"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:59:54 -0700
X-CSE-ConnectionGUID: iyYEnqxrRCqiMDSh7gcxFQ==
X-CSE-MsgGUID: JDi4aJs1SZSPji3+mUzr0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280857128"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 05:59:50 -0700
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
Subject: [PATCH v2 3/3] drm/xe/mcu_i2c: Take over control of the controller
 enabling
Date: Thu, 25 Jun 2026 14:59:39 +0200
Message-ID: <20260625125939.429078-4-heikki.krogerus@linux.intel.com>
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

Some platforms make an assumption that the i2c controller's
enabled state indicates also the power state of the
controller. This can create a problem when the controller is
in disabled state, because the hardware may assume
incorrectly that it is then also in low-power state.

To fix this, the controller is kept enabled by taking over
the IC_ENABLE register. The controller has to be disabled
when the configuration is updated and when the target
address or the slave address are assigned, so disabling it
when IC_CON, IC_TAR or IC_SAR registers are programmed, and
then re-enabling it again.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 55 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.h |  1 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 0495b561957a2..e2d8e77653cf2 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -8,6 +8,7 @@
 #include <drm/drm_print.h>
 #include <linux/array_size.h>
 #include <linux/container_of.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/designware_i2c.h>
 #include <linux/err.h>
@@ -294,11 +295,40 @@ static void xe_i2c_remove_irq(struct xe_i2c *i2c)
 	irq_domain_remove(i2c->irqdomain);
 }
 
+/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
+static void xe_i2c_disable(struct xe_i2c *i2c)
+{
+	int timeout = 100;
+	u32 status;
+
+	xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 1, 0);
+
+	do {
+		status = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_ENABLE_STATUS));
+		if (!(status & 1))
+			return;
+		/* Can't sleep here. */
+		udelay(25);
+	} while (timeout--);
+
+	dev_warn(&i2c->adapter->dev, "timeout in disabling adapter\n");
+}
+
 static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct xe_i2c *i2c = context;
 
-	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
+	*val = xe_mmio_read32(i2c->mmio, I2C_REG(reg));
+
+	switch (reg) {
+	case DW_IC_ENABLE:
+	case DW_IC_ENABLE_STATUS:
+		FIELD_MODIFY(DW_IC_ENABLE_ENABLE, val,
+			     i2c->ic_enable & DW_IC_ENABLE_ENABLE);
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -307,7 +337,28 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct xe_i2c *i2c = context;
 
-	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
+	switch (reg) {
+	case DW_IC_CON:
+	case DW_IC_TAR:
+	case DW_IC_SAR:
+		/* Disable the controller. */
+		xe_i2c_disable(i2c);
+
+		/* Write the register. */
+		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
+
+		/* Enable the controller. */
+		xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 0, 1);
+		break;
+	case DW_IC_ENABLE:
+		i2c->ic_enable = val;
+		/* Other fields can be updated except the enable bit. */
+		val |= DW_IC_ENABLE_ENABLE;
+		fallthrough;
+	default:
+		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index b3327db998708..231e36df09017 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -39,6 +39,7 @@ struct xe_i2c {
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
+	unsigned int ic_enable;
 
 	struct notifier_block bus_notifier;
 	struct work_struct work;
-- 
2.50.1

