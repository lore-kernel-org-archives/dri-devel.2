Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87DEC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE39E10E235;
	Wed, 26 Aug 2026 21:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="iwcrrr7w";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B99C10E235
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787779092; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ktSWRBBvjFTjW9vvic0xjrMgxaajBjaDg/EkKNxZbGdU3NGrz3p9RscqjriiKX20cPW3fuS5ITTwyEpPXJVKvpv11IK3XmM+JItcsenmS9x530cszUawLj5fUbXrlzydht51z/RjBxeGMasqI/Ruf/uNvDsGc5+NwsxqbFd++2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787779092;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HNekL85JDfu7UZrp0fuV5f9P7kUx27DQQ3Ok645EVVo=; 
 b=MduwtmdRaTqeV/ObS4Hx0syByFdmHHq9kNGgvb8AxwvGp3Tp+S141iieqTqOuyL44uPOZ0e8+cPeYcjroqluSFpsoKLt0ARGydrREctlHrg8imVn5JZJuEh5gmz/U8LhkvuwVIYY8gZVNyhWE2rAfZf1Z5u6QF+bCSlclm16kfA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787779092; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=HNekL85JDfu7UZrp0fuV5f9P7kUx27DQQ3Ok645EVVo=;
 b=iwcrrr7wBdNAOMQNA6VyVXjPAEiiYASYPKQxY3ZMa6RPj3LaUuuPmqNsVKt5Erx5
 kJzAflHpsvYlJ0/r0v3ysg74RDeIKDW1fHUKqKi6OXw4IHid82ioOUL9I15rTCew9DA
 p6sxw0uCWlDeU7/DG0H40a1esZfLHndF55TmYWGM=
Received: by mx.zohomail.com with SMTPS id 1787779090297473.8921003457282;
 Wed, 26 Aug 2026 14:18:10 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v6 00/16] Collection of fixes for Panfrost: Perfcnt, RPM,
 refactorings
Date: Wed, 26 Aug 2026 22:18:02 +0100
Message-Id: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTU7DMBAF4KtUXmNkj38Sd8U9EIvJeEKNQoPiN
 gJVuTtOEQpYWT7Ne9/cROYpcRbHw01MPKecxnMJ/uEg6ITnV5YplixAgVcOjKQBr5Flnz45yxY
 6ZVAbiy2JMvmY+H4oi+eXn5yv3RvTZTXWxinlyzh93f/Neu390v4/PWuppPYcgBFtsOGJxmHAb
 pzwkcZ3sfIzbIBXtgKgAK4h30VL2ju3B5gNaKAGzApYwN5r7KLq9wD7FwgVYAugdPBtD0xNg3u
 A24BW6wpwBTDRB6DAoSWogWVZvgFDfqHcwgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6120;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=btXuHyjlLmBjd0Mzf5fZCZ48f639iBfAD9Uyxf3qkzk=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqj1gLZq2buO3A6YazEvknUeO4y+fVeyAVSjatG
 qGPdGAnJKqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCao9YCwAKCRAOJn5M7lND
 PZcsC/9Q0O8uHBtPeg2G2PI02p3BDBqiOhsszHeW7h+TVJ7UmsUzmBWCWyEezSJ4wlNupUiGv+G
 G7C/sT9OxlpX1U5vP9lNA4NmDXdHEhVE1PQ5MBEHYyLeBVwZ6zjbHAcb2TnBqgQD77Yu6iLLGja
 zFd/ZWVBEvcka11BFzLgvlPHvTOjYAysE4gbSh+HwahldFkIAy10wgFRZ5S3DtlQLFPaD1VT5WG
 +kqByhZnnPeo3nEd5ENqcoiD5VCzWotTFKZ/NM+OYHaUEklrmYI5JvFabOob6D1PY22haInwDAR
 QXCrexvEBsh8JsbdJsEbv0SSytm5UlW/pcYZ4ybKHNbhwF/NNTC9mzB4xhEJwK9xSM/61lx6E9I
 15R0DakPlt5GGL5bfJ+8uOhXYwelwvQfD2Lt0pb24Mj6norvLWKIqI9dvBjpKFM/qm+qRIIyV5u
 Sn69+UlUDc3hZHOQyiF0CZeB6nh7UrtH4sdCihpN1KEjzuVNP+aCZltyvXRADTm2Ohlk0=
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
      drm/panfrost: Move all DRM device initialisation into device_init()
      drm/panfrost: Move lock and modparam initialisations into their subsystems
      drm/panfrost: Move debugfs initialisation to relevant subsystems
      drm/panfrost: Skip NULL checks for clock enable/disabling
      drm/panfrost: Consolidate device clock management and reset
      drm/panfrost: Split subsystem init/reset from interrupt enablement
      drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove
      drm/panfrost: Add warning messages to fatal error conditions
      drm/panfrost: Add debugfs knob for manually triggering a GPU reset
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Skip cache flush/invalidate when enabling perfcnt
      drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent systems
      drm/panfrost: Introduce a reset lock
      drm/panfrost: Fix races between perfcnt and reset sequence
      drm/panfrost: Bump driver minor to reflect new DUMP IOCTL req field

 drivers/gpu/drm/panfrost/panfrost_device.c       | 274 +++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_device.h       |   8 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 198 +---------------
 drivers/gpu/drm/panfrost/panfrost_drv.h          |   9 -
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  63 ++++--
 drivers/gpu/drm/panfrost/panfrost_gem.h          |  10 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |  21 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.h          |   2 +
 drivers/gpu/drm/panfrost/panfrost_job.c          | 108 ++++++++-
 drivers/gpu/drm/panfrost/panfrost_job.h          |   4 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  12 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.h          |   2 +
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 226 ++++++++++++-------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |   1 +
 include/uapi/drm/panfrost_drm.h                  |   3 +-
 16 files changed, 534 insertions(+), 416 deletions(-)
---
base-commit: 8aee06aa4c72e9bdfda81ce720b51fe0fe0f307e
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

