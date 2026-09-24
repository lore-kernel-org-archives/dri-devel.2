Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C60C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2C910F6F4;
	Thu, 24 Sep 2026 18:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="azF1ZUyT";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1934910F6EA
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790273377; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KgtZFs12af8RojbDsVnRbS2nepQ2WXjbb3LLmRVSBZ3nZ7fvSbmnFU4qXdxa6bj+GDuHKddqUoSPPzg9M7gJySUkzbbWDnkLfGIU6WYXCdihNF/JMgQ4VHqZViMALy1LNuZoUewa9kwNjLhbWrJ2KGBi8fQO3QB8o1sfgmHOolM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790273377;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XJghPhycc8eLcD5JgLM91zEBdVYCBiop68SBv7k5ghI=; 
 b=MWX6sElEAuBADgPH9hAPiy6y9K6ZOqRr2aRhN6/K79GiXrVq/SyEJOPcKH7fF5Yy3xCUNy1hwEC+pnsGjjPDU8krlrPZGMhx4XNoAaySQ01btlvB+t7Oou09N4zxLx2HkHBf8clbhvOOTrEe8xbLM6ZmvQ+LwLqlujzEpdlULAc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790273377; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=XJghPhycc8eLcD5JgLM91zEBdVYCBiop68SBv7k5ghI=;
 b=azF1ZUyTIBHACv4cuqtbxv4Nil7kvldTgRl/JXc+FUHDAfzsalw3ttgqRmH0XgJC
 2rsn4M40GGRU7wpUo4MfybGg0Ab/QGLJ9xtFBolT7o0Fkz+w9ZugIi5AclJSWRnP1Sc
 fzjqH+hMZOLMINGthoZbFwdxrmMrs8LPRO0wLl/k=
Received: by smtp.zohomail.com with SMTPS id 179027337613491.99857568666687;
 Thu, 24 Sep 2026 11:09:36 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v10 00/15] Collection of fixes for Panfrost: Perfcnt, RPM,
 refactorings
Date: Thu, 24 Sep 2026 19:09:17 +0100
Message-Id: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzU7DMAwA4FeZcqYodvPLifdAHBLXZUVlRe1Wg
 aa+O+kQaslydGx/luxcxcRjx5N4OlzFyHM3dcMpBSAfDoKO4fTGVdekB4ESjdRYV9SHS8NV233
 xVDmMsg5Qq+BIpJbPkW+J1PHy+htPl/jOdF6NteLYTedh/L4NnGGt+6PNf3qGSlZg2COHoLzyz
 zT0fYjDGB5p+BArP+MGGKkyABOgLZnYKAKjdQmoN8BiDtQroDC0BkJsZFsC1B7wGaASIMEb1yK
 TtaEE6A1wABmgE1A3xiN59o6wBJgdcLdEkwCbXB9aJT3bEmD3gMsAuwKYThyRAHVTAtwGeGkzw
 CWAMFLU7BCcKgF+BwBmgE8Aa+fa9A8M8N0VlmX5Aewsm2nHAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7490;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=sPUdChjqeOyyU296lXP4tUeen/Ed0Pc/Vt3vppsRbHc=;
 b=kA0DAAoBDiZ+TO5TQz0ByyZiAGq1Z1LIX0cA+kxLdY850jnhAcHzErxvtT2QSCM2rWAxEUG80
 4kBswQAAQoAHRYhBDJAMOjABRdd+TcHpA4mfkzuU0M9BQJqtWdSAAoJEA4mfkzuU0M9EboMAIfq
 YjcOHvLc0zPSo+ylWPQ0naXsKs016ATiJJuAWUyEJ60G7n0IqgRF9YRAfi9Sdh0Wj/bOHqjVszr
 QpGrLPG9M5mL7KBkBcYRGUsGSsTWY17Ua6VF+aBsndw/uHhHb3PhTevVfJnZH7H0ZgX+VRfYuha
 OFIWryCDQFhCkz0lW1JwRgyShlbQqdguFhTllyu/dPgxDjqfPRG29ecB7GUgTl49UhiDcKR0LKB
 bjErgknUL4XZexv5mITJaJXXpXAk5zerdBJch3zDhAJCsrBicEr+odjE2R4DCwTl4MYbKNFMPMO
 dvbVcTC0PeCm2WLCQtZb1amU1FUX7poyuDnmVQCcEDlLWzX566RWfy+QgnAldTD67dtKPf9w7US
 SClgJs7O2nsAa3eQ36wR5Muw9Sv0wweyqicjMniT8pIaYUq6liWhSRqpmd7GfwF+85Syt9cQGq2
 eTkETzZOdbW32QFGU+FN4DOcd/KrzjJzxbasZ2XTGJrx5JJLkcQIBJMiRbFA==
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

 drivers/gpu/drm/panfrost/panfrost_device.c       | 231 ++++++++++++++-------
 drivers/gpu/drm/panfrost/panfrost_device.h       |   5 +
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 198 +-----------------
 drivers/gpu/drm/panfrost/panfrost_drv.h          |   9 -
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  64 ++++--
 drivers/gpu/drm/panfrost/panfrost_gem.h          |  10 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |   2 +
 drivers/gpu/drm/panfrost/panfrost_job.c          | 103 +++++++++-
 drivers/gpu/drm/panfrost/panfrost_job.h          |   4 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  14 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 245 +++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |   1 +
 include/uapi/drm/panfrost_drm.h                  |   8 +-
 14 files changed, 515 insertions(+), 388 deletions(-)
---
base-commit: 3ab04dcce43cd4fdaed94f08f4e6289be4921ea4
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

