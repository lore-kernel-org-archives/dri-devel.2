Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70244CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDE610E333;
	Fri,  8 May 2026 10:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ug0kLtuF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B995A10E333;
 Fri,  8 May 2026 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778236872;
 bh=AyVzusdvo7gkyag9NVEBy5NipM7PG5vpfz+BPxvmftM=;
 h=From:Subject:Date:To:Cc:From;
 b=Ug0kLtuFT2743B69qDMt43ARZvCaozCkHwOD3FlW32OzOOAT2O3/+bA4jbLmqOKBB
 7tzLUgaN37kPwL+pTqnOZu+H+cTzv9zdJ2WGm8CHM9weLVa/9TfOU0zCn6ytANDSgF
 nDZ/Qa3ItpSIDNlm3cUtnOyUOoCUUS3jCYjHOmDTATtMI1vmELkres7GwJeUdaILsg
 dk5KIsL6GVKPSM4jbNN59KqOUBuarbUnTQ9QI1b7n4/brousU70hZkPGodvgog4aK0
 2wwLyOg10HnXoVwTwGYER2/Fs+0MSF50HR+iIwWLIsYQIMFgk9yyObhpLoa+h+ZKgP
 nY37DOwWJ8KOQ==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A929717E137F;
 Fri,  8 May 2026 12:41:11 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v2 0/4] drm/panthor: Fix a race in the shrinker logic
Date: Fri, 08 May 2026 12:40:46 +0200
Message-Id: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ7CIBBFr9LM2jFAClVX3sN0gXQqxArN0DSah
 ruLvYDL93/e/xtk4kAZLs0GTGvIIcUK6tCA8zY+CMNQGZRQRmhhcLZx8Ykxew7xSYxjeFNGfXJ
 ybLUbXSuhyjPTXlT31lf2IS+JP/vPKn/p38lVokDqOiW1MgOdzdWlabL3xPbo0gv6UsoXxrD2w
 8AAAAA=
X-Change-ID: 20260506-panthor-shrinker-fixes-58c1f45cfc41
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778236871; l=3348;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=AyVzusdvo7gkyag9NVEBy5NipM7PG5vpfz+BPxvmftM=;
 b=upV/5PAtIwICd9o0/5dAU6L2MQwmbnuJCMq8WufaoyP1AS2CoSAdkfvaQkwqq9SM6OWEvB0iN
 lqEvB9JscfeDI1SJZHsDSpF5IW5gzgLS68yct0WSE5vIQJftGsPw7s9
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

As reported by Chia-I [1], a race exists between drm_gem_lru_remove()
and drm_gem_lru_scan(), causing a UAF on a stack-allocated object.

This first patch fixes the problem at the panthor level by making
sure we never use drm_gem_lru_remove(). The second one fixes an
undetected race between drm_gem_lru_scan() and
drm_gem_object_release(). The third one kills drm_gem_lru_remove()
so no one else relying on the drm_gem_lru infra gets bitten by this
race again. And the last one tries to simplify the locking around
LRU updates so we can solve the chicken/egg problem where the lock
that needs to acquired is under gem->lru->lock, and gem->lru is
also supposed to be accessed with the lru->lock held.

Note that patch 1, 2 and 3 could be skipped if we go directly for the
approach in patch 4. Panthor wouldn't be impacted because the
shrinker support didn't land in Linus tree yet, so no fix to backport
there. We might still want patch 2 so it can easily be backported (if
the bug is deemed important for MSM).

Rob, I'll leave it up to you, but no matter what we decide, I'd really
like to have some fix in before the next merge window.

Liviu, Chia-I, Steve, I've intentionally dropped your R-b on patch 2
and 3 because they changed a bit.

[1]https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86

---
Changes in v2:
- Collect R-b
- Drop a useless obj->lru != NULL check in drm_gem_lru_scan()
- Fix another race introduced in patch 2
- Document why the lru != NULL check done without the lru lock held
  in drm_gem_lru_remove() is safe
- Add a patch to sanitize the GEM LRU locking: lock is now part of
  drm_device, meaning we don't have this chicken/egg problem where
  the lock that needs to acquired is under gem->lru->lock, and
  gem->lru is also supposed to be accessed with the lru->lock held
- Fix typos in commit messages and comments
- Link to v1: https://lore.kernel.org/r/20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com

---
Boris Brezillon (4):
      drm/panthor: Don't use the racy drm_gem_lru_remove() helper
      drm/gem: Fix a race between drm_gem_lru_scan() and drm_gem_object_release()
      drm/gem: Stop exposing the racy/unsafe drm_gem_lru_remove() helper
      drm/gem: Make the GEM LRU lock part of drm_device

 drivers/gpu/drm/drm_drv.c                |  2 +
 drivers/gpu/drm/drm_gem.c                | 79 +++++++++++++-------------------
 drivers/gpu/drm/msm/msm_drv.c            | 11 ++---
 drivers/gpu/drm/msm/msm_drv.h            |  7 ---
 drivers/gpu/drm/msm/msm_gem.c            | 32 ++++++-------
 drivers/gpu/drm/msm/msm_gem_shrinker.c   |  4 +-
 drivers/gpu/drm/msm/msm_gem_submit.c     |  6 +--
 drivers/gpu/drm/msm/msm_gem_vma.c        | 12 ++---
 drivers/gpu/drm/msm/msm_ringbuffer.c     |  6 +--
 drivers/gpu/drm/panthor/panthor_device.h | 11 ++++-
 drivers/gpu/drm/panthor/panthor_gem.c    | 24 +++++-----
 drivers/gpu/drm/panthor/panthor_mmu.c    | 29 ++++++------
 include/drm/drm_device.h                 |  7 +++
 include/drm/drm_gem.h                    | 21 ++++-----
 14 files changed, 120 insertions(+), 131 deletions(-)
---
base-commit: c006978163fd001fbca55e5fa57bddcf49f47ad9
change-id: 20260506-panthor-shrinker-fixes-58c1f45cfc41

Best regards,
-- 
Boris Brezillon <boris.brezillon@collabora.com>

