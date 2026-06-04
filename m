Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE229CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FD210E225;
	Thu,  4 Jun 2026 17:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="cUsswTaj";
	dkim-atps=neutral
X-Greylist: delayed 903 seconds by postgrey-1.36 at gabe;
 Thu, 04 Jun 2026 17:51:13 UTC
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DEE10E225
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594562; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gi8hkI2I4Nda4VA7U8VuJt1XQdSHr0CsdZ1/FtcAPBBZhv8/TGdQQSB8vzPe2xSKlWwqwKkLNXCtp9RpfvjxussKGFDeW4vLNBhi0RP4jmUKpElrj2kFC9km0TE96TDU53Pskw2suHKxyTrj/rq28lpgixmbxswq5xVhvABDwcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594562;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pGItgKzMIvC437rpGPy/yL1b1GrrGpxVuW/BG37KdmU=; 
 b=ICOs3FMbhEnR9eKuueGvAZkF3OtnuuBiS5E9PoxoDbI2Zf7+vW7Cv4TEgk/zGbK5ApEOqCRSp7eadYtajZzM0gI7CcgEfSnppl71UYmU6wiQvVFyPlgpUF02HrnqnXcDyghDNHrCOKuhobiBEdQX/S02KbLEi9+yUkjImYPHfN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594562; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=pGItgKzMIvC437rpGPy/yL1b1GrrGpxVuW/BG37KdmU=;
 b=cUsswTaj7MOEZoLLzW4n5RIdfbhAQIFVG3V1jIOkJu0jikIv56g6D/+a30IzatuL
 m4z+qaqSIkIqcne7kn2oyoh3Xt+ZFPyE3Z1VR2OtuEZ7Qqh+sHejW1lOYqEyeBqOTVb
 unjvtzE/0PdUJMvzQsqZiZS+oGGg8AoTFWRjPk4Y=
Received: by mx.zohomail.com with SMTPS id 1780594560725224.75170710534178;
 Thu, 4 Jun 2026 10:36:00 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v2 0/7] RPM, perfcnt and other minor fixes for Panfrost
Date: Thu, 04 Jun 2026 18:35:19 +0100
Message-Id: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw6CMBREf4XctTV9IKGu/A/D4lKuUlMpaaHRE
 P7dgnHh8mRmziwQKViKcC4WCJRstH7IIA8FmB6HOzHbZQbJZcVPUjHjcO6I3eyLIqtlyxUKVWJ
 tIE/GQHuQF9fmy3FuH2SmzbE1ehsnH977XxJb76eu/tVJMM5ERVoSYqlLfTHeOWx9wKPxT2jWd
 f0AHwtEg74AAAA=
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
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3426;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=yQFd+P6jOKn9w/gjCgOnJ7DFA+npz7xs+KhEtC2Mz0E=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8RkeENXkZsBziuKOt/jG0olQTS3YJif72F
 Bvaas/SG1KJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PTORDACDIvyhwWZwsNTQKW8d+by9/vlaNqWFw+ubmpyk5E/U1au/D5Hl13Bht23Op5RujgG/Tsw
 6+fJcqw8/djDhTpUKpVAW1g56oK8AtHSvDtYnmSvIAeRUOxXCaDWwD5ByzxIdx3fwepW9OIQD/c
 MYTdiczKgKs0HKxJu/zoNQFitb63xAwssRRJZgYk3L285zftUgL5R6BdW6ozdGX/eArhpZwfc84
 gCWQUfSrUjnNGnJDSQMjCQLyo5bdhlf60CcdlPNHTjLevNN8fvCAJ78oKyIG2H/H4SMCEZ+uHH+
 LE7TYDRjq44CHIoeomM0YDdisgg/WN+Rdj+YXzg6F8HqmP3bFenaRraw59uAIAzckTQhzccM/Ei
 eGRvyePbm5CDe3XjZY3RAKYZwyvsniPIWvjC30vQWdIoGhJ0zGnCXAPuADbj3z5yABXS39DSFvH
 1XHzamIWS3CijZ7w0ftyDurLTrmCjZsQ2fEkEpva1fsV47c2be6hDtonpKiGlyNr+CfMg=
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
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>

---
Adrián Larumbe (7):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Prevent division by 0
      drm/panfrost: Move shrinker initialization and unplug one level down
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Make reset sequence deal with an active HWPerf session
      drm/panfrost: Fix PM usage_count mishandling
      drm/panfrost: Explicitly enable MMU interrupts at device init

 drivers/gpu/drm/panfrost/panfrost_devfreq.c      |  3 +-
 drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c          | 14 ++---
 drivers/gpu/drm/panfrost/panfrost_gem.h          |  4 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 +--
 drivers/gpu/drm/panfrost/panfrost_mmu.c          | 11 +++-
 drivers/gpu/drm/panfrost/panfrost_mmu.h          |  2 +
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      | 77 ++++++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h      |  1 +
 9 files changed, 90 insertions(+), 38 deletions(-)
---
base-commit: c1079aebb4de218caa86c44f9a53700d1a582683
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

