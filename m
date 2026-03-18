Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1278103E174
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3056F10E11E;
	Wed, 18 Mar 2026 13:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="GyxUzz8P";
	dkim-atps=neutral
X-Greylist: delayed 41939 seconds by postgrey-1.36 at gabe;
 Wed, 18 Mar 2026 13:01:44 UTC
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F224610E11E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:01:44 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=as7QPDiOpQvYtWkznsJxN8W3cVVGqNEU0PZphXKKs18=;
 b=GyxUzz8Pz2tVjgeT9qbwenQv6F6/Dqn7XqFMZ3ZaSNEI7xzhOLnIRHgLN7/HqC2JLNfYpDg+Z
 bkuU2cN0iqjo+JutkYaQJXnP1il3EeGOr39UZBd4XzS3bdXj76hwZdxaeF66CynDCl69d7KfiiA
 OQQ3bi20YLgKwE3+qaXvPu0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fbTNB6Pshz12LDp;
 Wed, 18 Mar 2026 20:56:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 369F340569;
 Wed, 18 Mar 2026 21:01:42 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 21:01:41 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 21:01:41 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 for drm-misc-fixes] MAINTAINERS: split hisilicon
 maintenance and add Yongbang Shi for hibmc-drm matainers
Date: Wed, 18 Mar 2026 20:53:26 +0800
Message-ID: <20260318125326.3709098-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.71.169]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

To improve maintainability, split the maintainer information for the hibmc and
kirin drivers under the drivers/gpu/drm/hisilicon directory.

drivers/gpu/drm/hisilicon/hibmc driver has almost completed feature development
based on the new generation HiSilicon BMC chip. It was co-developed by
Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
maintained by Yongbang Shi.

Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Acked-by: Tao Tian <tiantao6@hisilicon.com>
---
 MAINTAINERS | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7241695df96..4f8dbadbe70b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8603,18 +8603,31 @@ S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/gma500/
 
-DRM DRIVERS FOR HISILICON
-M:	Xinliang Liu <xinliang.liu@linaro.org>
-M:	Tian Tao  <tiantao6@hisilicon.com>
-R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
-R:	Sumit Semwal <sumit.semwal@linaro.org>
-R:	Yongqin Liu <yongqin.liu@linaro.org>
-R:	John Stultz <jstultz@google.com>
-L:	dri-devel@lists.freedesktop.org
-S:	Maintained
-T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-F:	Documentation/devicetree/bindings/display/hisilicon/
-F:	drivers/gpu/drm/hisilicon/
+DRM DRIVERS FOR HISILICON HIBMC
+M:      Yongbang Shi <shiyongbang@huawei.com>
+M:      Xinliang Liu <xinliang.liu@linaro.org>
+M:      Tian Tao  <tiantao6@hisilicon.com>
+R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
+R:      Sumit Semwal <sumit.semwal@linaro.org>
+R:      Yongqin Liu <yongqin.liu@linaro.org>
+R:      John Stultz <jstultz@google.com>
+L:      dri-devel@lists.freedesktop.org
+S:      Maintained
+T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:      drivers/gpu/drm/hisilicon/hibmc
+
+DRM DRIVERS FOR HISILICON KIRIN
+M:      Xinliang Liu <xinliang.liu@linaro.org>
+M:      Tian Tao  <tiantao6@hisilicon.com>
+R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
+R:      Sumit Semwal <sumit.semwal@linaro.org>
+R:      Yongqin Liu <yongqin.liu@linaro.org>
+R:      John Stultz <jstultz@google.com>
+L:      dri-devel@lists.freedesktop.org
+S:      Maintained
+T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:      Documentation/devicetree/bindings/display/hisilicon/
+F:      drivers/gpu/drm/hisilicon/kirin
 
 DRM DRIVERS FOR LIMA
 M:	Qiang Yu <yuq825@gmail.com>
-- 
2.33.0

