Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QCWZJaqr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED32E10F6FE;
	Tue, 17 Nov 2026 13:10:34 +0000 (UTC)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0AD10F6FD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:10:23 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=jakYEPVNan32L8Ib2AhKwBu+w4MtvmYOF/9o2MK7F6w=;
 b=QCWZJaqrU5btBUOTXWFnmvAPCUZxLpVIzIITPccp6BpL0l+kZsbkbU+iXqWd2kFI5lj//IQ3z
 i6v3jkuT7IoJTQQYfeiLhH1OixOSqLASVfbGA3Y16G1p0qhTuznIyd7+uEsWVCHLLGfROSwQ7Nj
 Ship7f+TH1agkD0Xmzv4vCg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jTQ6v44tczpSyl;
 Tue, 17 Nov 2026 21:09:27 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 007E740685;
 Tue, 17 Nov 2026 21:10:16 +0800 (CST)
Received: from localhost.huawei.com (10.169.64.31) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 17 Nov 2026 21:10:15 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <shuliubin@huawei.com>,
 <chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <shiyongbang@huawei.com>,
 <helin52@h-partners.com>, <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v5 0/2] Fix some bugs in the hibmc DP
Date: Tue, 17 Nov 2026 21:00:54 +0800
Message-ID: <20261117130056.272609-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lin He <helin52@huawei.com>

Fix some bugs in the hibmc DP driver.

---
ChangeLog:
v4 -> v5:
  - Invalidate the link in the hardirq when an unplug is sampled, and
    stop clearing the latched HPD status in hibmc_dp_hpd_cfg().
    (sashiko-bot)
  - Serialize a whole AUX transfer with hibmc_dp_hpd_cfg().
    (sashiko-bot)
  - Append HIBMC_HPD_UNKNOWN to the enum instead of prepending it, so
    the existing HIBMC_HPD_OUT/HIBMC_HPD_IN values do not change.
  - Only set the enable flag when DP was initialized, clear it only when
    it was set, and do not request the DP interrupt if DP initialization
    failed. (sashiko-bot)
v3 -> v4:
  - Fix the data race on hpd_status between hardirq and process
    contexts with WRITE_ONCE()/READ_ONCE(). (sashiko-bot)
  - Delete the HPD_IN early return in encoder_enable that breaks KMS
    forced modesets. (sashiko-bot)
v2 -> v3:
  - Delete irq_status and use hpd_status directly for hotplug
    detection. (sashiko-bot)
  - Add debug logs when hpd_status is not HPD_IN in detect and
    encoder_enable.
  - Move hibmc_set_enable_flag() before drm_dev_register() and
    hibmc_set_disable_flag() after drm_dev_unregister() to narrow the
    race window. (sashiko-bot)
  - Add spinlock_t gpio_lock to hibmc_drm_private to protect all
    operations on 0x0802A4. (sashiko-bot)
v1 -> v2:
  - More states in HIBMC_DP_HPD_STATUS are added to the
    'hibmc_dp_get_hpd_status'.
  - The call to `hibmc_set_enable_flag()` has been moved before
    `drm_client_setup()`, specifically before the connector detection
    triggers the I2C bit operation. (sashiko-bot)
  - A read-modify-write operation has been implemented instead of directly
    writing to prevent clearing the I2C mask bits. (sashiko-bot)
---

Lin He (2):
  drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status
  drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver
    has been loaded

 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   | 11 +++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 40 +++++++++-----
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  6 ++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 32 +++++------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 54 +++++++++++++++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 19 +++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  |  3 ++
 9 files changed, 129 insertions(+), 40 deletions(-)

-- 
2.33.0

