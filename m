Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EEAC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF1B10FBDF;
	Fri, 25 Sep 2026 18:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jYDe/Fc+";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7204A10FBDF
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790361929; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MJR1tAOgOv+PNp5bBM3AvmWcIY8591JJJH/osnxrexDpCbqbLDjygvaNiu9lvH1XTx17Izq4H0MR5ETY10b/pu0T2wI2U7Yjwwo+upsu7hYryTO7v4w3LUrBFuSiXBgomkrspdgxmQ4DUPYHurG4WiEXfGI/uqlz18VULFgC+ac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790361929;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZC2uSeX+ReJs5Nof+3r87ZSm4Xof9woJZs+HQw8pGrE=; 
 b=jK3Tm4YlTaRgwzWiQLJjvb/RnKKV3PIR3DjNkzuJ4wflVm8YA9h3i6SmAb181PgYNTxlYPyU7OUfpwhHvcwpcK6F3SUTl+FnaOWpLUlTf9dnGEkQzgRHBYUPTyYLMLduxJLfesKm7ebhJLkDDd/b65XJy4n6LqHHOqvVLNvHaFU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790361929; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=ZC2uSeX+ReJs5Nof+3r87ZSm4Xof9woJZs+HQw8pGrE=;
 b=jYDe/Fc+e5avqknOXsQsix+K3VwK5DlTmK++sHLEYS9YRERMJdmU2Wyqfodze9+4
 fo0giHtJC2fsvGQdMUUUBYUeQtZ/xhLWJ/+GTAXyc4ylzAoTLeuWNyGV9ZSL0lFlO3E
 y8bBmRl9WqmyHx2IvHv40R2MN/Jr4WIGldDLdiHY=
Received: by smtp.zohomail.com with SMTPS id 1790361929639509.6917716892872;
 Fri, 25 Sep 2026 11:45:29 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v11 00/15] Collection of fixes for Panfrost: Perfcnt, RPM,
 refactorings
Date: Fri, 25 Sep 2026 19:45:21 +0100
Message-Id: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzU7DMAwA4FeZeqYodvNnTrwH4pC4LisaK2q3C
 jTt3UmGUEuXoxP7ixz7Uk0y9jJVT7tLNcrcT/1wTAHAw67ifTi+Sd236aBChVYZbGo+hHMrddd
 /yVR7jKoJ0OjguUoln6PcLlLFy+tvPJ3ju/ApGzlj30+nYfy+PThDzvuj7X96hlrVYIVQQtCk6
 ZmHwyHEYQyPPHxUmZ9xAazSGwATYBzb2GoGa0wJaBbA4RZoMqAxdBZCbFVXAvQaoA2gE6CArO9
 Q2LlQAswCeIANYBLQtJaQScgzlgC7Au4+0SbAJZdCpxWJKwFuDfgN4DKAacQRGdC0JcAvACm3A
 XwCGCNHIx7B6xJAKwBwA1ACxHjfpT2wIMUpgFoJd3MElZswhpBiwwx3q3S9Xn8AlXv0oAoDAAA
 =
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7825;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=GHkhy0pLkEHWk0Sn13qrTpLI+F6hIbaLndeXv3kZrxw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFDvm/2XVGGGjGyRWwZZmG0h/rGW5kpc63Y7
 sbktkRVHf6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBQwAKCRAOJn5M7lND
 PVKxDACfQ3kEtmgw9MPFxx2fdJjlLTbvYNh0nx5CY+FDTboF02IjVVPDCcy9TWiTjxgu9HQ0Kam
 oLczDUe+byk2XQsAV5MSsqnoFeg3677qtouSckANb023DMJiuc0BWAdk0iY7j8lx8dGyGmezfEK
 +GYRtXbe9OyLr/cxeCub1SjKaW3I05lkd9K4ipqaKnKuRONPhR94Rg9KX01Ion5nP+EzaQCdLk+
 PDc8HXFJUOqmOjfNe5ES4qMFeoZrPW/1i6VEh31nWNy1q0l2Rks/d5/PW09Aju/O5gfzPjw35JV
 kYjSexiCYcDCWR2vvwb3QuhD1jsgDsaUmFn9mFTY/hMkvj1VIXRNGkwZSxUfRO85kQa25KcuChG
 JD4/3P7ZS6/M7VsL2XPL5andm221zMa1WxcK+b56CtXE9Ktx8bdkyl/AFoRDYkBUwTuac+LuJkr
 4SFboRL7dv4v04PmLH82JWmiVOqLr0qycGlIEFj8WFmw8Bs8roMu4xxmRwptgDU3MeNQU=
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
Changes in v11:
- Fixed bugs about user_count and PM device status at driver init and remove time.
- Documented new uAPI for perfcnt dump ioctl that depends on reset status.
- Fixed issues about internal perfcnt bookkeeping in case of reset.
- Link to v10: https://patch.msgid.link/20260924-claude-fixes-v10-0-755929b3cc19@collabora.com

Changes in v10:
- Improved the logic for the debugfs reset knob.
- Changed perfcnt reset race commit message to reflect true HW behaviour.
- Improved logic of perfcnt reset handling with a state variable instead of booleans.
- Added comments explaning how we handle PM status and references at device init time.
- Fix RM resume clock disable bug uncovered by Sashiko and also changed function naming.
- Link to v9: https://patch.msgid.link/20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com

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
Adrián Larumbe (15):
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

 drivers/gpu/drm/panfrost/panfrost_device.c       | 236 +++++++++++------
 drivers/gpu/drm/panfrost/panfrost_device.h       |   5 +
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 198 +--------------
 drivers/gpu/drm/panfrost/panfrost_drv.h          |   9 -
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  64 +++--
 drivers/gpu/drm/panfrost/panfrost_gem.h          |  10 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |   2 +
 drivers/gpu/drm/panfrost/panfrost_job.c          | 103 +++++++-
 drivers/gpu/drm/panfrost/panfrost_job.h          |   4 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  14 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 306 +++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |   1 +
 include/uapi/drm/panfrost_drm.h                  |  29 ++-
 14 files changed, 578 insertions(+), 412 deletions(-)
---
base-commit: 3ab04dcce43cd4fdaed94f08f4e6289be4921ea4
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

