Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA9EC98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A945110F3A5;
	Thu, 24 Sep 2026 08:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="Bg/YesFj";
	dkim-atps=neutral
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA1210F345
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:17:53 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6kjXznkOnXGtV+t4t+Sino0ktTMNsnonA1JZVorFzVc=;
 b=Bg/YesFjrCeY4YYqSRTL3qpsM4zkBYiiYhdKfu8kmoap8FzGQsToKq4C0iJjoesz/4IuVajQt
 3JWSCPlubz4q7CzKXL84AcpJOkTEFzCsRhCfaR5cGzq0fQObnWbSY0I8tydbMldKh8mUcm2nTJ3
 az3YheAWjP+ISJkZeugY5Ys=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hr5xP3N5pz12LHt;
 Thu, 24 Sep 2026 16:05:45 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1E4074057F;
 Thu, 24 Sep 2026 16:17:51 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 16:17:50 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <shuliubin@huawei.com>,
 <chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <shiyongbang@huawei.com>,
 <helin52@h-partners.com>, <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v3 2/2] drm/hisilicon/hibmc: Add a flag to
 indicate whether the OS-side driver has been loaded
Date: Thu, 24 Sep 2026 16:06:09 +0800
Message-ID: <20260924080609.3681795-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924080609.3681795-1-shiyongbang@huawei.com>
References: <20260924080609.3681795-1-shiyongbang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.71.169]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200005.china.huawei.com (7.202.194.71)
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

From: Lin He <helin52@huawei.com>

Add a flag to indicate whether the OS-side driver has been loaded to
prevent the BMC from enabling DP if the driver is not loaded, which could
lead to system failure in handling interrupts and generate error messages
like:

irq xx: nobody cared (try booting with the "irqpoll" option)
...
Call Trace:
<TRQ>
...

Fixes: 0ab6ea261c1f ("drm/hisilicon/hibmc: add dp module in hibmc")
Signed-off-by: Lin He <helin52@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v2 -> v3:
  - Move hibmc_set_enable_flag() before drm_dev_register() and
    hibmc_set_disable_flag() after drm_dev_unregister() to narrow the
    race window. (sashiko-bot)
  - Add spinlock_t gpio_lock to hibmc_drm_private to protect all
    operations on 0x0802A4. (sashiko-bot)
v1 -> v2:
  - The call to `hibmc_set_enable_flag()` has been moved before
    `drm_client_setup()`, specifically before the connector detection
    triggers the I2C bit operation. (sashiko-bot)
  - A read-modify-write operation has been implemented instead of directly
    writing to prevent clearing the I2C mask bits. (sashiko-bot)
---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 30 +++++++++++++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 19 ++++++++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  |  3 ++
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 4ab0e565cb13..9859492da5fa 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -167,6 +167,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	if (ret)
 		return ret;
 
+	spin_lock_init(&priv->gpio_lock);
+
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
 	dev->mode_config.max_width = 1920;
@@ -423,6 +425,30 @@ static int hibmc_load(struct drm_device *dev)
 	return ret;
 }
 
+static inline void hibmc_set_enable_flag(struct hibmc_drm_private *priv)
+{
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&priv->gpio_lock, flags);
+	value = readl(priv->mmio + HIBMC_ENABLE_FLAG);
+	value |= HIBMC_ENABLE_STATE;
+	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
+	spin_unlock_irqrestore(&priv->gpio_lock, flags);
+}
+
+static inline void hibmc_set_disable_flag(struct hibmc_drm_private *priv)
+{
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&priv->gpio_lock, flags);
+	value = readl(priv->mmio + HIBMC_ENABLE_FLAG);
+	value &= ~HIBMC_ENABLE_STATE;
+	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
+	spin_unlock_irqrestore(&priv->gpio_lock, flags);
+}
+
 static int hibmc_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
@@ -458,6 +484,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 		goto err_return;
 	}
 
+	hibmc_set_enable_flag(priv);
+
 	ret = drm_dev_register(dev, 0);
 	if (ret) {
 		drm_err(dev, "failed to register drv for userspace access: %d\n",
@@ -470,6 +498,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_unload:
+	hibmc_set_disable_flag(to_hibmc_drm_private(dev));
 	hibmc_unload(dev);
 err_return:
 	return ret;
@@ -480,6 +509,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(dev);
+	hibmc_set_disable_flag(to_hibmc_drm_private(dev));
 	hibmc_unload(dev);
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index dce8572bf63e..c2a82000ea7f 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -49,6 +49,8 @@ struct hibmc_drm_private {
 	struct drm_crtc crtc;
 	struct hibmc_vdac vdac;
 	struct hibmc_dp dp;
+
+	spinlock_t gpio_lock; /* protects RMW on I2C/ENABLE_FLAG (0x0802A4) */
 };
 
 static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
index 44860011855e..4ceb87efec05 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
@@ -27,7 +27,11 @@ static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
 {
 	struct hibmc_vdac *vdac = data;
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
-	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
+	unsigned long flags;
+	u32 tmp_dir;
+
+	spin_lock_irqsave(&priv->gpio_lock, flags);
+	tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
 
 	if (value) {
 		tmp_dir &= ~mask;
@@ -41,20 +45,29 @@ static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
 		tmp_dir |= mask;
 		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
 	}
+	spin_unlock_irqrestore(&priv->gpio_lock, flags);
 }
 
 static int hibmc_get_i2c_signal(void *data, u32 mask)
 {
 	struct hibmc_vdac *vdac = data;
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
-	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
+	unsigned long flags;
+	u32 tmp_dir;
+	int ret;
+
+	spin_lock_irqsave(&priv->gpio_lock, flags);
+	tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
 
 	if ((tmp_dir & mask) != mask) {
 		tmp_dir &= ~mask;
 		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
 	}
 
-	return (readl(priv->mmio + GPIO_DATA) & mask) ? 1 : 0;
+	ret = (readl(priv->mmio + GPIO_DATA) & mask) ? 1 : 0;
+	spin_unlock_irqrestore(&priv->gpio_lock, flags);
+
+	return ret;
 }
 
 static void hibmc_ddc_setsda(void *data, int state)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
index 17b30c393b10..b95add5b253c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
@@ -200,5 +200,8 @@
 
 #define HIBMC_CRT_PALETTE                       0x80C00
 
+#define HIBMC_ENABLE_FLAG			0x802A4
+#define HIBMC_ENABLE_STATE			BIT(2)
+
 #define HIBMC_FIELD(field, value) (field(value) & field##_MASK)
 #endif
-- 
2.43.0

