Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A34F8A145
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54FFF10E873;
	Thu, 16 Apr 2026 09:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="3UKwCqkQ";
	dkim-atps=neutral
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E21010E84D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 09:14:31 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=c0rKBCh6RzznalYxOCcftlL2h9gXq9vFxkliOpSjT7E=;
 b=3UKwCqkQr0zvTuA9qqdDXW+pOhXzHkXQrCSsZY+lbC8qmrwm6gIeX2mcLrWxQ8ehFoztZoAsq
 UbWl0QFLA+drGSS9Biv6hqutCKVltGdJhd4s9Wy/g74MTXR7X64PbAWTyTTl1qqyaAVFMzQV0sX
 K1/kKBVi3b6QsO/KbXtAx+I=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fxBxk4XdTz1cyTg;
 Thu, 16 Apr 2026 17:08:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id C5E9C4058D;
 Thu, 16 Apr 2026 17:14:28 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:14:28 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:14:27 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <xinliang.liu@linaro.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v2 0/4] Fix some bugs in the hibmc driver
Date: Thu, 16 Apr 2026 17:05:38 +0800
Message-ID: <20260416090542.1984002-1-shiyongbang@huawei.com>
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

From: Lin He <helin52@huawei.com>

There are some bugfix for hibmc-drm driver.

---
ChangeLog:
v2 -> v3:
  - remove unused macro CLOCK_TOLERANCE.
v1 -> v2:
  - fix the checkpatch.pl warning "Unknown commit ID 'e6c7c59da494'".
  - fix the checkpatch.pl warning "line length of 83/85 exceeds 80 columns".
  - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
    be given in public.
  - add 'drm-misc-fixes' in subject prefix.
---

Lin He (4):
  drm/hisilicon/hibmc: add updating link cap in DP detect()
  drm/hisilicon/hibmc: fix no showing when no connectors connected
  drm/hisilicon/hibmc: move display contrl config to hibmc_probe()
  drm/hisilicon/hibmc: use clock to look up the PLL value

 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 78 +++++++++++--------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 35 ++++++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 14 ++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 67 ++++++++--------
 8 files changed, 118 insertions(+), 81 deletions(-)

-- 
2.33.0

