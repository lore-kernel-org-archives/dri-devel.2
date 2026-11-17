Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96922606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=W8PuUYuI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E613C10F6FA;
	Tue, 17 Nov 2026 13:10:28 +0000 (UTC)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354D710F6FA
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:10:22 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=yUxBLeSqBFW1tZQEpDjbqNslMJVyyB3QNLgXK8Yfnus=;
 b=W8PuUYuID/+yon+tC0FkdQANXOubdsfuuCc1vDNawbBGD78TZ+vgr13/DZoHcAYXdnbJMUPym
 NWlULPZzPBbYjdZUc9Dn8keDsWCw5Fy91Gg2+gSkK6wePUf4KGXKjekMHX21CjXYbitg1vNVQDS
 96OV4+rEb79z++ASGK+TVCM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jTQ7T5Qp2zLlTR;
 Tue, 17 Nov 2026 21:09:57 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C3C7B40561;
 Tue, 17 Nov 2026 21:10:16 +0800 (CST)
Received: from localhost.huawei.com (10.169.64.31) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 17 Nov 2026 21:10:16 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <shuliubin@huawei.com>,
 <chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <shiyongbang@huawei.com>,
 <helin52@h-partners.com>, <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v5 2/2] drm/hisilicon/hibmc: Add a flag to
 indicate whether the OS-side driver has been loaded
Date: Tue, 17 Nov 2026 21:00:56 +0800
Message-ID: <20261117130056.272609-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117130056.272609-1-shiyongbang@huawei.com>
References: <20261117130056.272609-1-shiyongbang@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200005.china.huawei.com (7.202.194.71)
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

The flag is set only after hibmc_dp_init() succeeded, so it also means
that the DP block is ready.  If DP initialization fails, only the vblank
MSI vector is requested, so the DP interrupt is not registered at all.

Fixes: 0ab6ea261c1f ("drm/hisilicon/hibmc: add dp module in hibmc")
Signed-off-by: Lin He <helin52@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v4 -> v5:
  - Only set the enable flag when DP was initialized, clear it only when
    it was set, and do not request the DP interrupt if DP initialization
    failed. (sashiko-bot)
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
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 45 ++++++++++++++++++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 19 ++++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  |  3 ++
 6 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 84faa1a7439d..10772cddcfc8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -57,6 +57,7 @@ struct hibmc_dp {
 	struct hibmc_dp_cbar_cfg cfg;
 	int hpd_status;
 	int phys_status;
+	bool initialized;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 6ea70c31d1a9..9fa49a2ba093 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -256,6 +256,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
 	dp->phys_status = connector_status_disconnected;
+	dp->initialized = true;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 7920f03895fe..7ea050e89005 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -174,6 +174,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	if (ret)
 		return ret;
 
+	spin_lock_init(&priv->gpio_lock);
+
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
 	dev->mode_config.max_width = 1920;
@@ -346,12 +348,17 @@ static void hibmc_unload(struct drm_device *dev)
 static int hibmc_msi_init(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
+	int max_vectors = HIBMC_MIN_VECTORS;
 	int valid_irq_num;
 	int irq;
 	int ret;
 
-	ret = pci_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS,
-				    HIBMC_MAX_VECTORS, PCI_IRQ_MSI);
+	if (priv->dp.initialized)
+		max_vectors = HIBMC_MAX_VECTORS;
+
+	ret = pci_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS, max_vectors,
+				    PCI_IRQ_MSI);
 	if (ret < 0) {
 		drm_err(dev, "enabling MSI failed: %d\n", ret);
 		return ret;
@@ -430,6 +437,36 @@ static int hibmc_load(struct drm_device *dev)
 	return ret;
 }
 
+static inline void hibmc_set_enable_flag(struct hibmc_drm_private *priv)
+{
+	unsigned long flags;
+	u32 value;
+
+	if (!priv->dp.initialized)
+		return;
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
+	if (!priv->dp.initialized)
+		return;
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
@@ -465,6 +502,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 		goto err_return;
 	}
 
+	hibmc_set_enable_flag(priv);
+
 	ret = drm_dev_register(dev, 0);
 	if (ret) {
 		drm_err(dev, "failed to register drv for userspace access: %d\n",
@@ -477,6 +516,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_unload:
+	hibmc_set_disable_flag(priv);
 	hibmc_unload(dev);
 err_return:
 	return ret;
@@ -487,6 +527,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
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
2.33.0

