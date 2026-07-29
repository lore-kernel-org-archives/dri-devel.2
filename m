Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D37C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D6510E43C;
	Wed, 29 Jul 2026 02:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Qfnv8jxU";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806C510E43C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293663; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GVSB6t+o8OjYKWboHautr49I1O/NpfvWrh22JmaJLiZTd8/fKWfk6n9LWXs3avhHjD623l0lknd/Qdkcnuw1hbCEFAbzdGGcX/jGq7a2NUo/Z+v6oYzKSNfSp9wXYAoCoAL5yB91kU/W/QZwaB4OUjpmgPmYddhsGb413n96BUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293663;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dAW1Yogx0jEsRsHzqm2ZkIFIc9lJ90pD4v6q7J+OUM4=; 
 b=H60w/jEfFJ5gpkejMB5Q+5ee5gNcTIDUkkXrb8DD6dTTmVt11MogFhfX8VPOhyLSh37b9RN4xUbdpqi4CEz5+7Ey3f8RCcHX/HJCP5UZk0f1D9mrhB4nQbNJYv1q7wWK9jkVhHk3kaOTU2EgO8UxQNXOiBlmRbocyBEx9T07z4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293663; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=dAW1Yogx0jEsRsHzqm2ZkIFIc9lJ90pD4v6q7J+OUM4=;
 b=Qfnv8jxU0KYqj76F7IYdg94TeYfk44E7vqOrgCiYWhS241ztV1dTShXpxZgDIE5t
 viamu65AKongR2O6BBxpwzQxwgHwQeTmZvL706xOzBmHxO+8qiXR9wBuId2MBr6xNl9
 PUSN9XwyHqMuukngYNgkKFNFJMpT3zoAE9ry3fdU=
Received: by mx.zohomail.com with SMTPS id 1785293660758312.743392826211;
 Tue, 28 Jul 2026 19:54:20 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v4 00/13] RPM, perfcnt and other minor fixes for Panfrost
Date: Wed, 29 Jul 2026 03:54:12 +0100
Message-Id: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ7CIBAF0KsY1mJgoGhdeQ/jYqBTxdRiQBuN6
 d0FjTE2Ln/m/zcPlih6Smw9e7BIg08+9Dno+Yy5A/Z74r7JmYEAIypQ3HV4bYi3/kaJr8AKhVJ
 pXDmWJ+dIr0NebHfvnK72SO5SjNI4+HQJ8f76N8jS+9Dmlx4kF1waqoEQda3rjQtdhzZEXLhwY
 oUf4AsYoScAZKBaOmMb7aSpqn+A+gJLmAKqABqwNRJtI9opMI7jE42ZACpAAQAA
X-Change-ID: 20260523-claude-fixes-82b03a134a8c
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4938;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=I1sN5UnrCjjhktuRj3g+m0O+H3Zy0NNozAeXZCn2u2w=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtW6Gs4eLP2UUcDjQk0YLgDxP6rd1LjlpvJu
 3VCxx7QYdOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVgAKCRAOJn5M7lND
 PaRIDACnffxhVTK7y/g5XxyQoHB5sxif3oLRnkOeBFww5IxYJM05RtXmaBTpqjMcZG/RkjqLb4U
 5APBPoZ27HI/NNoI/i912+pUWRm201kHFkzyhE4Ufofi7Gec6XDtBwxEeFfuIVr7eRfxvTpaJx9
 wS0GVtmht6i2q1KP9X2RekAa5qebKo6r4vlENEDLxWwOWZMkJtCKa3YogFU5z1HA2NfE8mUjg0n
 jmtBDB3G8HWMV1k8pCoeSFcpHDddrkb7X5ImO+wQFFkSP4CX9L+Nlzpi692Xxs4hfPl+hFaQj5o
 MBPN4/hlrB0qqZhCyKE4KRCj5E8jpHF1PBPIifcT23e8cnHgoFe42voJV+U+wwf3ChdjLtnv5bN
 fUXN/7iykzdfSLSmDvz4tFjzEBqtYnW3Z/u9bsc9sNjTELwsPVVx45rIYqZ3LmRLKupgmo/N7XG
 o3Gwf/EOPSJUKgkEHfrlnXhhoaIOdsmTfHMz5zAQSM+H3CB7qLtTUHl+ADiDvz2B8jxQ8=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

This patch series comes with some minor fixes for Panfrost. Some of the
issues addressed were uncovered by LLM tools, while the one about RPM was
traditionally debugged.

The only proper bug fixes are the ones for perfcnt and RPM, and the others
are more about ensuring robustness. perfcnt bug was never observed in the
open, because no one had faced a HW reset when a perfcnt session was
ongoing. RPM fix addresses a well-known issue I had been observing for
quite some time, but that I had completely misunderstood.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Changes in v4:
- Fixed errors and issues uncovered by Sashiko in the previous revision.
- Changed the way RPM checks whether the device is initialised when resuming.
- Simplified perfcnt treatment of potential resets.
- Link to v3: https://patch.msgid.link/20260724-claude-fixes-v3-0-542af61abd0f@collabora.com

Changes in v3:
- Applied some minor suggestions for the first couple of patches in the series.
- Moved shrinker initialisation into gem initialisation.
- Fixed RPM bugs by moving all clock and power initialisation into RPM resume.
- Added patch for reset sequence fixes and also a userspace knob to trigger it.
- Reworked perfcnt fix by having the reset sequence restore its initial state.
- Link to v2: https://patch.msgid.link/20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com

Changes in v2:
- Fixed race conditions introduced by the previous revision, in the RPM and
HWPerf commits specifically. These can be consulted at [1]
- Don't attempt to suspend the device unconditionally at the end of
probe(), and do it through autosuspend instead.
- Broke the RPM patch into one that fixes PM refcnt proper and another one
for MMU enablement at device init time.
- Moved perfcnt GPU disable helper into its own commmit. Same for
transplating shrinker initialisation and unplug.
- Added 'Fixes' and 'Reported-by' tags to all the relevant commits
- [1] https://sashiko.dev/#/patchset/20260526-claude-fixes-v1-0-16e92eaa4949%40collabora.com
- Link to v1: https://patch.msgid.link/20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Herring <robh@kernel.org>
To: Steven Price <steven.price@arm.com>
To: Adrián Larumbe <adrian.larumbe@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Faith Ekstrand <faith.ekstrand@collabora.com>
To: "Marty E. Plummer" <hanetzer@startmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Eric Anholt <eric@anholt.net>
To: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To: Robin Murphy <robin.murphy@arm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>

---
Adrián Larumbe (13):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Prevent division by 0
      drm/panfrost: Remove unnecessary header file include
      drm/panfrost: Move shrinker initialization and unplug one level down
      drm/panfrost: Move all device power up and down into RPM callbacks
      drm/panfrost: Explicitly enable MMU interrupts at device init
      drm/panfrost: Sync with IRQ before MMU disable and reset
      drm/panfrost: Rewire reset sequence to avoid concurrent attempts
      drm/panfrost: Add debugfs knob for manually triggering a GPU reset
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Introduce a reset lock
      drm/panfrost: Fix races between perfcnt and reset sequence
      drm/panfrost: Bump driver minor to reflect new DUMP IOCTL req field

 drivers/gpu/drm/panfrost/panfrost_devfreq.c      |   2 +-
 drivers/gpu/drm/panfrost/panfrost_device.c       | 400 +++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_device.h       |  18 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c          |  31 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  19 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h          |   6 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   8 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |   7 +-
 drivers/gpu/drm/panfrost/panfrost_job.c          |  19 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  25 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 236 ++++++++-----
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |   2 +
 include/uapi/drm/panfrost_drm.h                  |   3 +-
 13 files changed, 498 insertions(+), 278 deletions(-)
---
base-commit: 671b7825dbfe9ea6e3ad3001003aeee0df48d1b5
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

