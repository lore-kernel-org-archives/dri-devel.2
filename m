Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45C010E06E;
	Tue, 14 Jul 2026 13:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="UoB+rUNV";
	dkim-atps=neutral
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D51CF10E06E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:31:19 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=T14jDMdWfXXoTZIAhrguaPaxwFo7Anbv8ly8ipNex5s=;
 b=UoB+rUNVoN9XEEquBKy/82/sVsSdRypd++jLJyyWR1igeMYEloqbv6jjp43MRD0dlQly57mzM
 uXxbFtl6HzTmRf8QdUp6SL3sERW2+TpA+iU4PLmsXnaijZFdioEg8ilrirW7H4qgTrLBXv6veRF
 hGGBK8kJ8grot/6qiqdKVIA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h00Mg0zgDz1T4HL;
 Tue, 14 Jul 2026 21:22:07 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 94F064056D;
 Tue, 14 Jul 2026 21:31:16 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 21:31:16 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 21:31:15 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <xinliang.liu@linaro.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes 0/2] Fix some bugs in the hibmc DP
Date: Tue, 14 Jul 2026 21:20:49 +0800
Message-ID: <20260714132051.993356-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.43.0
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

Fix some bugs in the hibmc DP driver.

Lin He (2):
  drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status
  drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver
    has been loaded

 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 -
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 31 ++++++++++++-------
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  4 ++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 29 ++++++++++-------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 14 +++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  |  3 ++
 6 files changed, 58 insertions(+), 24 deletions(-)

-- 
2.43.0

