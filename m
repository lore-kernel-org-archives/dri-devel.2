Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89954CD343F
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 03:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10A410F626;
	Sat,  9 May 2026 03:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="DAFIRnYr";
	dkim-atps=neutral
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1F210E368
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 03:32:22 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=HVGuWGkn8qWlrD3mMTeX1j/utDqoTv5W00gDHIxi5jg=;
 b=DAFIRnYritZCMo9z+NoseYUJKkAKtKYEF5uttm3LD5ccqyNVyZFCrhqmTI/9BvjWsQWwLDbKg
 dhJeqXlmk9DYDVoncMqD35j9gk1ljsh7GwmzjNl9moY5ISYY09K6juv00Sz5OGAI36868rPCyqR
 uBoy0v0JJMFvPBb0amB0HZk=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gCBDt2bNZzLlVV;
 Sat,  9 May 2026 11:24:46 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 67F8140571;
 Sat,  9 May 2026 11:32:20 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 11:32:14 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 11:32:13 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <xinliang.liu@linaro.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v6 1/4] drm/hisilicon/hibmc: add updating
 link cap in DP detect()
Date: Sat, 9 May 2026 11:22:59 +0800
Message-ID: <20260509032302.2057227-2-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260509032302.2057227-1-shiyongbang@huawei.com>
References: <20260509032302.2057227-1-shiyongbang@huawei.com>
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

From: Lin He <helin52@huawei.com>

In the past, the link cap is updated in link training at encoder enable
stage, but the hibmc_dp_mode_valid() is called before it, which will use
DP link's rate and lanes. So add the hibmc_dp_update_caps() in
hibmc_dp_update_caps() to avoid some potential risks.

Fixes: 607805abfb74 ("drm/hisilicon/hibmc: add dp mode valid check")
Signed-off-by: Lin He <helin52@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v1 -> v2:
  - fix the checkpatch.pl warning "Unknown commit ID 'e6c7c59da494'".
  - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
    be given in public.
  - add 'drm-misc-fixes' in subject prefix.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h   | 1 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c   | 2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
index f9ee7ebfec55..f53dac256ee0 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
@@ -69,5 +69,6 @@ int hibmc_dp_link_training(struct hibmc_dp_dev *dp);
 int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp);
 int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp);
 int hibmc_dp_serdes_set_tx_cfg(struct hibmc_dp_dev *dp, u8 train_set[HIBMC_DP_LANE_NUM_MAX]);
+void hibmc_dp_update_caps(struct hibmc_dp_dev *dp);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
index 0726cb5b736e..8c53f16db516 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
@@ -325,7 +325,7 @@ static int hibmc_dp_link_downgrade_training_eq(struct hibmc_dp_dev *dp)
 	return hibmc_dp_link_reduce_rate(dp);
 }
 
-static void hibmc_dp_update_caps(struct hibmc_dp_dev *dp)
+void hibmc_dp_update_caps(struct hibmc_dp_dev *dp)
 {
 	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
 	if (dp->link.cap.link_rate > DP_LINK_BW_8_1 || !dp->link.cap.link_rate)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 616821e3c933..35dff7bfbf76 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -41,6 +41,8 @@ static bool hibmc_dp_get_dpcd(struct hibmc_dp_dev *dp_dev)
 	if (ret)
 		return false;
 
+	hibmc_dp_update_caps(dp_dev);
+
 	dp_dev->is_branch = drm_dp_is_branch(dp_dev->dpcd);
 
 	ret = drm_dp_read_desc(dp_dev->aux, &dp_dev->desc, dp_dev->is_branch);
-- 
2.33.0

