Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A3BC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158B889BE8;
	Tue, 11 Aug 2026 21:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="hyWAQhee";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E9689BE8
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484539; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W8K4Lz4GRp+M+tSSkESpyKmFG5EwTY2EjwR3vTp+jkDDfousAPYOOyJaFq18hsROrVBWhkKQC6L75GCctYI+MJ1ToqFEQi6zsuPN+JczCKw0eh5Y1wr7DWMmKlXXD8J8DfosBB4kIQVKz7r93wEAgIM2epd15ad+GQc1iN+O0c4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484539;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=c23N7RV4PLiyloGGIyqxR/gcJ/3M1guJ/6z3MWQ6Ons=; 
 b=TxUX3H6YTGE3H0jcjET7Myt1gIPoLpWIa68lDeKr75lyFomuqA6/N/hMD9bJ2w1UB/TBTAnFpbYrBROcqZ+hsspwcFsgmtio+F6e9DM7xgvDf614bqmL4chihUVD9tpbaM0d60hyEBOvyGWLtiDA41IrKGUXf63dtMJWaSz/wec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484539; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=c23N7RV4PLiyloGGIyqxR/gcJ/3M1guJ/6z3MWQ6Ons=;
 b=hyWAQheeIllmWnpIq/COn/s5RNWtwJPYCP0QXDuvuIxTUiovphGoBMwEPqkJFvNU
 3IMDauEv/TL2X40MtuZTeR4AiF7OMyt5oc7XrbrrGUvNOYPsve0y954hqyrjT5bKhqZ
 Uu9u9haqNLls1BtVg7l4/23vdNyDpSlPpkgrG2s0=
Received: by mx.zohomail.com with SMTPS id 1786484538091955.2090667172398;
 Tue, 11 Aug 2026 14:42:18 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v5 00/11] RPM, perfcnt and other minor fixes for Panfrost
Date: Tue, 11 Aug 2026 22:42:09 +0100
Message-Id: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTW7DIBAF4KtErEsFw49NVrlH1cWAxw2VGyJIr
 FaR715IFKW1snya9765sEI5UmHbzYVlmmOJ6VCDedmwsMfDB/E41MxAgBUGFA8TngfiY/ymwnv
 wQqFUGvvA6uSY6Xqoi7f3Wy5n/0nh1IzW2MdySvnn+m+WrXen7X96llxwackBIWqn3S6kaUKfM
 r6G9MUaP8MDsEKvAKiA6YL1gw7SGvMMUA+ggzWgGqABRyvRD2J8Bui/gFsBugJCOtuPQKHrcA0
 sy/IL144WrIEBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5254;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=rL7c+Ia9ZmeM4N7T829jfOc2ndsiOSdtT4qVo9yvVnI=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5cyxH2KSftZCjTEmJDJE0YC/prARZRoYGVZe
 XXs92zW8HaJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMgAKCRAOJn5M7lND
 Pdw9DACDwbWqxeoUDfGguVfb97/gIYdQIrH+EqFQTtLBlq5ac82gkQBSJqivjKsNDv4UE4bavLA
 Bbi/DOVo78/fdMOxVeLr8/3rGh25csd6Xog6vlJVv/weHEIKqPIayfZZd0rmAyiYR3qj4FesgxX
 sGhK+MHBAuF5rwB3mBMNb9qkl0vnzHgzJa7OeA5J8BRxYprbM4UlcfF1aHZ2GSeZigysWZ0tbO0
 1k/WqaE6Ee853nksW2Rpi9/ZY+JT26ibffvUyOjoC4jE86Be/SxQ+8eFbtQ/pwrpLMXDOSbCWKW
 kXD5jlcz5MUFeY+/pBrnmN17RJwgStyoxH11NbOj1Ya2yUuqcBML4a786S1slHCOU+yGIIsspmY
 G5rzU71Xc8sOLS19FtPqjTpIFZj0MpLuDVp9GAaolCjex2ZX1R6uGQG9YCYd1uvXY5BP3Mm2ZBu
 o9vCrr2I/KOnmFzVmMb8AFpGeDAys3kBQ6Imd52R5OxJ+6KfUddRC2DTpStvJzx+CDcuo=
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
Changes in v5:
- Addressed more issues uncovered by Sashiko.
- Discarded two patches to avoid dealing with too many pre-existing issues at once.
- Biggest change is the re-arrangement of the start sequence, made to look like Panthor.
- Link to v4: https://patch.msgid.link/20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com

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
Adrián Larumbe (11):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Prevent division by 0
      drm/panfrost: Remove unnecessary header file include
      drm/panfrost: Move shrinker initialization and unplug one level down
      drm/panfrost: Move all device power up and down into RPM callbacks
      drm/panfrost: Explicitly enable MMU interrupts at device init
      drm/panfrost: Add debugfs knob for manually triggering a GPU reset
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Introduce a reset lock
      drm/panfrost: Fix races between perfcnt and reset sequence
      drm/panfrost: Bump driver minor to reflect new DUMP IOCTL req field

 drivers/gpu/drm/panfrost/panfrost_devfreq.c      |   2 +-
 drivers/gpu/drm/panfrost/panfrost_device.c       | 412 ++++++++++++++---------
 drivers/gpu/drm/panfrost/panfrost_device.h       |  12 +
 drivers/gpu/drm/panfrost/panfrost_drv.c          |  32 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  25 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h          |   7 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   8 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |   9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.h          |   1 -
 drivers/gpu/drm/panfrost/panfrost_job.c          |   8 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  20 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.h          |   1 -
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 249 +++++++++-----
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |   2 +
 include/uapi/drm/panfrost_drm.h                  |   3 +-
 15 files changed, 495 insertions(+), 296 deletions(-)
---
base-commit: 671b7825dbfe9ea6e3ad3001003aeee0df48d1b5
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

