Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CB2C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E6010ED3B;
	Tue, 14 Jul 2026 13:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="eVfFvSXU";
	dkim-atps=neutral
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BC210ED36
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:31:21 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=K2iPeyHYe6O+EKii8NogFWeD3VFFPpQFx3+0JQTwAwg=;
 b=eVfFvSXUyJ2PNvDrrV8EAlwmzZGcroG1idoLiJ00XGYBSsYfj/FDcicl2fGBZ/CiSBBdFh558
 iR4lB3bSf/rAya67dkIBB4YiykByMYgy0o+lZPjJYwRuN23C1juJkmJfvqKmWnYlpGjq06m2MZZ
 9pEXXEAzynXUia26s/bbT/Y=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h00MZ0xQJzRhRv;
 Tue, 14 Jul 2026 21:22:02 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id B582B40593;
 Tue, 14 Jul 2026 21:31:18 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 21:31:17 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 21:31:16 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <xinliang.liu@linaro.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes 2/2] drm/hisilicon/hibmc: Add a flag to
 indicate whether the OS-side driver has been loaded
Date: Tue, 14 Jul 2026 21:20:51 +0800
Message-ID: <20260714132051.993356-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714132051.993356-1-shiyongbang@huawei.com>
References: <20260714132051.993356-1-shiyongbang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.71.169]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 13 +++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index e5cca7b63b78..6436263a6c03 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -424,6 +424,16 @@ static int hibmc_load(struct drm_device *dev)
 	return ret;
 }
 
+static inline void hibmc_set_enable_flag(struct hibmc_drm_private *priv)
+{
+	writel(HIBMC_ENABLE_STATE, priv->mmio + HIBMC_ENABLE_FLAG);
+}
+
+static inline void hibmc_set_disable_flag(struct hibmc_drm_private *priv)
+{
+	writel(0, priv->mmio + HIBMC_ENABLE_FLAG);
+}
+
 static int hibmc_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
@@ -468,6 +478,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 
 	drm_client_setup(dev, NULL);
 
+	hibmc_set_enable_flag(priv);
+
 	return 0;
 
 err_unload:
@@ -480,6 +492,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	hibmc_set_disable_flag(to_hibmc_drm_private(dev));
 	drm_dev_unregister(dev);
 	hibmc_unload(dev);
 }
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

