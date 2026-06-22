Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9BCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF30B10E65B;
	Mon, 22 Jun 2026 11:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cr8Tapk5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0BF10E65B;
 Mon, 22 Jun 2026 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782128889; x=1813664889;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JJl24Emz4h3SZMr+NKGGApmvGaEAa8iddIdzOoS2KrE=;
 b=cr8Tapk5JuQkxCtGqbOVXaUNQLQH/dZRi0XD+IMppQvg7r/inwvpqnaw
 32H2otdeiZOw1Nsjfyry0Hn93ZZbDWFy+diSSHXGtOVLw40Kd6rAQGej2
 Bv1vbJEugl6R/XGePJ7u+Swq+to71GG5t/8HBfek0sWc2/hkf+HZ3xbMn
 CbbL0Ic1PNop/Tlw153VzvAafXDXxhHjmVtdyWU4EJeEWWUDP8Lq/Idsx
 xje3DMCzbDtH9l5Y+C3TQ0S+iWE82hPHkvMyy23kZhxhf8fS1TNj9Vfev
 RwzkJX1kyQqCZQTVGIFH4Al5y0SExpw5rj8kWbevY1Uw/h5go32iYLyGS w==;
X-CSE-ConnectionGUID: +mhPFZWTRuGjq+m1ZkmGPA==
X-CSE-MsgGUID: DY8aoCLlQMyBOQWvdyO+CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93510054"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93510054"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 04:48:09 -0700
X-CSE-ConnectionGUID: FNn8ugijSA+46XyrOl3KDA==
X-CSE-MsgGUID: iKNpXPDKRxSeMudjjY2UeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="272909378"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP; 22 Jun 2026 04:48:06 -0700
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
Subject: [PATCH v1 2/2] drm/xe/mcu_i2c: Take over control of the controller
 enabling
Date: Mon, 22 Jun 2026 13:47:59 +0200
Message-ID: <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
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
 drivers/gpu/drm/xe/xe_i2c.c | 65 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.h |  1 +
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 732ad6ee05e9c..45fa9094b6142 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -8,6 +8,7 @@
 #include <drm/drm_print.h>
 #include <linux/array_size.h>
 #include <linux/container_of.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -261,11 +262,49 @@ static void xe_i2c_remove_irq(struct xe_i2c *i2c)
 	irq_domain_remove(i2c->irqdomain);
 }
 
+#define IC_CON				0x00
+#define IC_TAR				0x04
+#define IC_SAR				0x08
+#define IC_ENABLE			0x6c
+#define IC_ENABLE_STATUS		0x9c
+
+/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
+static int xe_i2c_disable(struct xe_i2c *i2c)
+{
+	int timeout = 100;
+	u32 status;
+
+	do {
+		/* Disable.*/
+		xe_mmio_rmw32(i2c->mmio, XE_REG(IC_ENABLE + I2C_MEM_SPACE_OFFSET), 1, 0);
+
+		/* Verify. */
+		status = xe_mmio_read32(i2c->mmio, XE_REG(IC_ENABLE_STATUS + I2C_MEM_SPACE_OFFSET));
+		if (!(status & 1))
+			return 0;
+
+		/* Repeat. */
+		usleep_range(25, 250);
+	} while (timeout--);
+
+	return -ETIMEDOUT;
+}
+
 static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct xe_i2c *i2c = context;
 
-	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
+	switch (reg) {
+	case IC_ENABLE:
+		*val = i2c->ic_enable;
+		break;
+	case IC_ENABLE_STATUS:
+		*val = i2c->ic_enable & 1; /* NOTE: Checking only the enable bit */
+		break;
+	default:
+		*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
+		break;
+	}
 
 	return 0;
 }
@@ -273,8 +312,30 @@ static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
 static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct xe_i2c *i2c = context;
+	int ret;
 
-	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
+	switch (reg) {
+	case IC_CON:
+	case IC_TAR:
+	case IC_SAR:
+		/* Disable the controller. */
+		ret = xe_i2c_disable(i2c);
+		if (ret)
+			return ret;
+
+		/* Write the register. */
+		xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
+
+		/* Enable the controller. */
+		xe_mmio_rmw32(i2c->mmio, XE_REG(IC_ENABLE + I2C_MEM_SPACE_OFFSET), 0, 1);
+		break;
+	case IC_ENABLE:
+		i2c->ic_enable = val;
+		break;
+	default:
+		xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index fdbad51950423..e28279f0ebec7 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -36,6 +36,7 @@ struct xe_i2c {
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
+	unsigned int ic_enable;
 
 	struct notifier_block bus_notifier;
 	struct work_struct work;
-- 
2.50.1

