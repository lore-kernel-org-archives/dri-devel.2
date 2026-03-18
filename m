Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB56FEDA09
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDEF10E076;
	Wed, 18 Mar 2026 01:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="h2a7I20Z";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="h2a7I20Z";
	dkim-atps=neutral
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D1910E076
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:22:48 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=y6Btq1FTUDwjd4MUGC/Fm/Se9UkKNdZZWeZNtggLDkA=;
 b=h2a7I20ZEyQZHY/zIfqi2IvHpcLP2dKY1Ze/hVS3dUoGi5zxmhRzsYVQI4obMNfDHRD7AAWoW
 Ch3yEYFar/I/SkgHz8qKLFLCSDB1jsTDKc/jBqM0O569GMfqhI3cK3JVgF80hy8zlHQANePetD4
 rLVzk442b+X9xmP8mU5GO84=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
 by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fb9z406gJz1BFym
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:21:52 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=y6Btq1FTUDwjd4MUGC/Fm/Se9UkKNdZZWeZNtggLDkA=;
 b=h2a7I20ZEyQZHY/zIfqi2IvHpcLP2dKY1Ze/hVS3dUoGi5zxmhRzsYVQI4obMNfDHRD7AAWoW
 Ch3yEYFar/I/SkgHz8qKLFLCSDB1jsTDKc/jBqM0O569GMfqhI3cK3JVgF80hy8zlHQANePetD4
 rLVzk442b+X9xmP8mU5GO84=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fb9tD00Knz1prLP;
 Wed, 18 Mar 2026 09:17:39 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A4DF40561;
 Wed, 18 Mar 2026 09:22:41 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 09:22:41 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 09:22:40 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes] MAINTAINERS: add Yongbang Shi for
 drivers/gpu/drm/hisilicon matainers
Date: Wed, 18 Mar 2026 09:14:26 +0800
Message-ID: <20260318011426.3130333-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.71.169]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

drivers/gpu/drm/hisilicon/hibmc driver has almost completed feature development
based on the new generation HiSilicon BMC chip. It was co-developed by
Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
maintained by Yongbang Shi.

Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Acked-by: Tao Tian <tiantao6@hisilicon.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76..ef3ff26ac1dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8604,6 +8604,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/gma500/
 
 DRM DRIVERS FOR HISILICON
+M:	Yongbang Shi <shiyongbang@huawei.com>
 M:	Xinliang Liu <xinliang.liu@linaro.org>
 M:	Tian Tao  <tiantao6@hisilicon.com>
 R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
-- 
2.33.0

