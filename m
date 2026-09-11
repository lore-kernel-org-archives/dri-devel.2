Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B594CC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA15610E533;
	Fri, 11 Sep 2026 23:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="hwRedOKh";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55C910E533
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169289; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CBalEwxepaqINRLMzEqqR/Hh9Fg7Px39qZpW5gBC5mWmMoMVQGhRScKuaky/BzIM55b3wc/Zo/U5HUbI7U1EJh+I/HVv6+u5kH6w0esXWuT68JSYxQtPpzwLbAalKpWIOHwHU4iHuekS8+TPB9KjnKyVScSXNpHMyrykvzfL6vQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169289;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qYDwKy8BPzXJQTnj+1QhdBGrZcZ6C5tbuWJIUaSbibQ=; 
 b=JjZdXU/vtVblBiSm7Qh3hHa/GmfLR4HiuvvDkm7VSQs+TSjS5rMV5sPQpjuy2DNEnciXhqdfoGfHvvukMdBNntRLcMRiGSanNpKb2cwwAJAF4AYMMR7SEpSDzbEuunV1i4eYFqGDyMFtccd6cAKCooNxe4nCacE+fq7bi1rXkK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169289; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=qYDwKy8BPzXJQTnj+1QhdBGrZcZ6C5tbuWJIUaSbibQ=;
 b=hwRedOKhwcuuiMC3CZssQnZRrLrAsunhGgZzbipkpyBXjUa7tNAPGl0+7m7m7gzO
 yiFJ3a5tleAU11duLsih5zHou09xIbXdJSCLnXvfv+QfCTf1rLzKCBCjEqVC7/LpcAK
 Ym6LAGZVoR8sOPWPgORC6nSGjK2l0dVf6VCLQp8s=
Received: by mx.zohomail.com with SMTPS id 1789169289233170.92062589464592;
 Fri, 11 Sep 2026 16:28:09 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v9 00/16] Collection of fixes for Panfrost: Perfcnt, RPM,
 refactorings
Date: Sat, 12 Sep 2026 00:28:01 +0100
Message-Id: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23RzU7DMAwH8FeZcqYocfO5E++BOCSOy4rKipqtA
 k19d5Ih1BJ6/Mv2z5J9Y4mmnhI7Hm5sorlP/XjOwT0cGJ78+ZWaPubMgIPmCtoGB3+N1HT9J6X
 GQuCtF630Flke+ZjoXsgTzy8/OV3DG+GlGKXj1KfLOH3d982i9P3S+i89i4Y3QpMD8l466Z5wH
 AYfxsk/4vjOCj/DCmguKwAyoAzqECUKrdQe0K6AgRpoCyDBd1r4EHm3B8gt4CpAZoALp20HhMb
 4PUCtgBWiAlQG2qgdoCNnEfYAvQH+HVFnwGTX+U5yR2YPMFvAVoApAOQXB0ABKu4BdgUcNxVgM
 4AQMCiyIKysgWVZvgH+ZQA9hQIAAA==
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7063;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=06DRUrtfpv8HksRK4m44p/8NMAPblElzEKSy09qQFTA=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqpI6DYpTTVIDGgFaL1aLHqkrRKvVIAI1wo34X3
 heq4h8wlLiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaqSOgwAKCRAOJn5M7lND
 PeygC/9uc3B7q4f60iBEdIydEPOMynkbCzOKhePZspgi6uaBYgH7yqkfznfiljPsAP7v3LtRvMR
 aSTUgC8RtdbFBb8sK+vKr6tL/0rVWhLCZsHuQ1IDFalbN2HnNAGWTl9ltiLk3O86tEF0if7kRyG
 Z6GPxMrbqbsDlm+pYEBGadHTBQDmWd4wNmEJrGXYlw4gU3OOtgV4cxyWy8d40ameMsWOD9eRWvT
 wFs8B1k1IIYU+i4MK3XYRbcZtdu+Xur5ku3F5I3gETDwQDRl2Q6BXC34eMCrBRhN8qa8QptJL6g
 2H85vNObTOxdHH2EkKK5DH/g08iZJB5Cs7suA1jTfQC5jGPzxzBO5K5W5i7x9eAhthtR8RyMXnZ
 9isVOkOIiuV6mwA875ebQGxs8b7JyoAg9B0KUKJjsWlNz/kK61zkBK3+jb/DfERBQYSrlArA4dd
 UH2SYse3e7pXxGk3MDZka6qlzOYvY6vul+KiY/VyeEW4qmYBG8JklF4Hnta6TPDTI54Zs=
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

This patch series began as an assortment of small fixes for some issues
uncovered by Claude. Over time, it has evolved to include many other
fixes for further problems revealed by Sashiko in successive revisions,
and also refactorings and improvements suggested by maintainer
discussions.

A subset of patches submitted in previous revisions was already merged
after they had been reviewed, to avoid this series growing to unmanageable
extents.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Changes in v9:
- Extended clk_(enable|disable) consolidation into other runtime callbacks.
- Fixed uAPI and perfcnt/reset interaction errors uncovered by Sashiko.
- Link to v8: https://patch.msgid.link/20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com

Changes in v8:
- Applied fixes for issues brought up by Sashiko.
- Rolled back some additions from v7: job stopping, IRQ consolidation.
- Applied RPM fixes before moving most driver init code into panfrost_device.c
- Brought back v6 patch that enables MMU IRQs before device is registered.
- Simplified perfcnt reset handling procedure, so that no retry is done in the kernel.
- Link to v7: https://patch.msgid.link/20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com

Changes in v7:
- Again fixed some minor issues reported by Sashiko.
- Made sure the new debugfs reset knob works even when runtime PM isn't enabled.
- Added new patch that handles job termination at driver teardown time.
- Link to v6: https://patch.msgid.link/20260826-claude-fixes-v6-0-78119af409e7@collabora.com

Changes in v6:
- Grafted trivial already-reviwed patches from previous revisions into
their own series so that they could be merged into drm-misc-next.
- Added commits with multiple refactorings, code rearrangements and simplifications.
- Addressed all issues brought up by reviwers and Sashiko in the previous revision.
- Link to v5: https://patch.msgid.link/20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com

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
Adrián Larumbe (16):
      drm/panfrost: Move shrinker initialization and unplug one level down
      drm/panfrost: Move lock and modparam initialisations into their subsystems
      drm/panfrost: Move debugfs initialisation to relevant subsystems
      drm/panfrost: Skip NULL checks for clock enable/disabling
      drm/panfrost: Consolidate device clock management and reset
      drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove
      drm/panfrost: Explicitly enable MMU interrupts at device init
      drm/panfrost: Move all DRM device initialisation into device_init()
      drm/panfrost: Add warning messages to fatal error conditions
      drm/panfrost: Add debugfs knob for manually triggering a GPU reset
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Skip cache flush/invalidate when enabling perfcnt
      drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent systems
      drm/panfrost: Introduce a reset lock
      drm/panfrost: Fix races between perfcnt and reset sequence
      drm/panfrost: Bump driver minor to reflect new DUMP IOCTL req field

 drivers/gpu/drm/panfrost/panfrost_device.c       | 222 +++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_device.h       |   5 +
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 198 +------------------
 drivers/gpu/drm/panfrost/panfrost_drv.h          |   9 -
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  64 ++++--
 drivers/gpu/drm/panfrost/panfrost_gem.h          |  10 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |   2 +
 drivers/gpu/drm/panfrost/panfrost_job.c          | 101 ++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h          |   4 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  14 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 242 +++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |   1 +
 include/uapi/drm/panfrost_drm.h                  |   8 +-
 14 files changed, 501 insertions(+), 388 deletions(-)
---
base-commit: 3ab04dcce43cd4fdaed94f08f4e6289be4921ea4
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

