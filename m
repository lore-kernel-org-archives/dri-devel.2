Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF56C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2062910E60B;
	Thu, 23 Jul 2026 23:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Kzo6Uq+C";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3BE10E374
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851185; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lpz6zZLY8ygxqq78GHaBxDYC0vCWQnKUsjc9uv8B/4ehU1gtlCkKn9wGMoQ8ptIu2xSIsVA7uDdo2x+kgPDgqAwXeGX9iRAyyepf4eqh7oio/GTQQ4IC0M6/1XBmtx2XjJT5pZWx8P6Px5ZSDtbsYGgFvcL1lQ7MBdghPOfcLsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851185;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ge4xMXDgl/MKk7vaG/kkcahbXZ2pRI9XWq9OdK5/y6o=; 
 b=ddCtMyxPMmIMD8dODcMEhHko6qiSmIdYJm1k5XNUkD30hxSNCPMoGqIXQMnBWAlRLKXqWVIJ+FRrV1sWOtCFTa9A0dMiE4WyoAkmpk9Ab/ibaOp+fyPyu8ZZ89rmjhbNUac6DCD/8eDY2eqA2377GU3pPgXgNWaZlRavkDTjMm0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851185; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=ge4xMXDgl/MKk7vaG/kkcahbXZ2pRI9XWq9OdK5/y6o=;
 b=Kzo6Uq+C38DfHotf/tULsy9PZgf2A5VzTEioxZfHSsQhhBfD2P+Sw5sSzfiujw5T
 mlbu40mnEbyjXC2Rp4IsBKLsY7fPQWDXpG7uF/ElwslVWLDa5KpChCyH1SEgosvR4Ly
 jhW7KouOmHPDm79k0Q1Q8oexHxMrpc6HXJTbX1y8=
Received: by mx.zohomail.com with SMTPS id 1784851183045209.96610715417205;
 Thu, 23 Jul 2026 16:59:43 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v3 00/13] RPM, perfcnt and other minor fixes for Panfrost
Date: Fri, 24 Jul 2026 00:58:53 +0100
Message-Id: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13NTQ7CIBAF4KsY1mL4t3XlPYwLoKPF1GKgJZqmd
 xdqjLHLl3nvmwlFCA4iOmwmFCC56HyfA99ukG11fwXsmpwRI0wRyTi2nR4bwBf3hIgrZgjXlAt
 dWZQnjwDLIS9O50+Oo7mBHYpRGq2Lgw+v5V+ipfel1T+dKCaYKqgZaC1qUR+t7zptfNA76++o8
 In9AEXECmAZkHurTCMsVVKugXme33nuSJz/AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=yHpb9ICxDm9fmvxMArtlTsSp5g/2Uk+giQ1VlHucM08=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqrohRCGGN4lkgDMzoF6SZbogy+ePnY/phzir
 YRAzNaai9+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 Pb8oC/4zqS9Ujcjrs0tKeo7mUefECnMz/qXBZH9vZcY5PD7vCufHgeyUtC2S85AsTSbES+5mavk
 jy0BFIXubcJ1sMbpHcfkVIo2LZ/3R8N997QATUpWRyE9ihYSvVpViCi2LGFiexZ5Yr9LQAS1ITx
 /5QBKx5hlBeUSC4Q43X7FWkFDwiLz2cm0br4SnvbpC9i/X0lAwxLGIHXKjIcjVVnU31y91g67jD
 ZwPEwO5lKeJK0wjlSs+HqtI5qiWlmMQ8TGFQrDGKxKF4+urru0IVlC9uqPW8xiBe4fqfU3S9RhY
 FXiag7cbhXYCztWJnezHECX3IbLvepgdUmDkujn7wZQh+LyAXUeOkdfyr5N7JEzpliHd95hc1ao
 dpgQmN+DDk3oYAN0F9qgpPciXp5BXo9YdBb0ZM0zN8qWeuzfmbsAL8fQNTfxPNarQ8EurqHtH9C
 v6zY2cfToEaF4QU282sOeNSRwXEuyhh44MyEJ4TGNLDj6J5q29swrMHmbhegAVcoLGGqQ=
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
 drivers/gpu/drm/panfrost/panfrost_device.c       | 401 +++++++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_device.h       |  12 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c          |  34 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c          |   6 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h          |   6 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   8 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c          |   7 +-
 drivers/gpu/drm/panfrost/panfrost_job.c          |  18 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  22 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 225 ++++++++-----
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |   2 +
 include/uapi/drm/panfrost_drm.h                  |   3 +-
 13 files changed, 476 insertions(+), 270 deletions(-)
---
base-commit: 671b7825dbfe9ea6e3ad3001003aeee0df48d1b5
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

