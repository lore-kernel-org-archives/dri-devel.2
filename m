Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A723CD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 12:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D2210ED65;
	Wed,  6 May 2026 12:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VWrzPbJ6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36B710ED5B;
 Wed,  6 May 2026 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778069797;
 bh=s2rz6WBCQQLTAnI5a+CDvnoj5qWr+M9TUVuy622jV7E=;
 h=From:Subject:Date:To:Cc:From;
 b=VWrzPbJ6FcOZqnKVy9C3qqbzO/UWw1WydKijlVKnVjyqm9u1MBDBJ2Nkd0q+oKHCH
 yYwveoHyNmwYAwEMc8t+XI3eQesPyBSOb0SvwmJiFyUEvZBYmpm0BedDIy42Im/wCz
 +ohF0utsPg7ChM/qk6vrX8vGf61OwIgD/lemsBYylEpAYcJQc2/7321ZvR11c0cwlq
 dVvAE6HpgXxHrv4uCOdYOpqfk/FGElwyctgXzaWqwDb20C/AkgHTv2VdQ4MTGZ38BW
 1sgJDgtxT/W8gVvB+C8B128MVbV2hZCU/nskg4w+f2pfwWCSi9eocFQqYzfc49/2OS
 NmSPzDvMKic0g==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 91D3017E1502;
 Wed,  6 May 2026 14:16:36 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 0/3] drm/panthor: Fix a race in the shrinker logic
Date: Wed, 06 May 2026 14:16:25 +0200
Message-Id: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqAIBBA0avErBvQSImuEi3CxhwCjZmIILp70
 vLx+Q8oCZPC2DwgdLFyyRW2bSCkJW+EvFZDZzpvnPF4LPlMRVCTcN5JMPJNim4INvYuxNBbqPM
 h9If6TvP7fp9wy89oAAAA
X-Change-ID: 20260506-panthor-shrinker-fixes-58c1f45cfc41
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778069796; l=1376;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=s2rz6WBCQQLTAnI5a+CDvnoj5qWr+M9TUVuy622jV7E=;
 b=THEVnc4x1Mq4RI7yePdlKafi+stM406BVAhLHlcFjn6UsvLD2Eypts6czFRA3bjzlawp9M/xm
 EuezyTmr5S/CiWGj5okBy6X1+9FnjKHz0kQAvjitxXZfCY8pUBv9Rgh
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
drm_gem_object_release(), and the last one kills drm_gem_lru_remove()
so no one else relying on the drm_gem_lru infra gets bitten by this
race again.

Adding the MSM maintainers to the loop, since it's the only other
driver relying on drm_gem_lru.

[1]https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86

---
Boris Brezillon (3):
      drm/panthor: Don't use the racy drm_gem_lru_remove() helper
      drm/gem: Fix a race between drm_gem_lru_scan() and drm_gem_object_release()
      drm/gem: Stop exposing the racy/unsafe drm_gem_lru_remove() helper

 drivers/gpu/drm/drm_gem.c                | 63 ++++++++++++++------------------
 drivers/gpu/drm/panthor/panthor_device.h | 10 +++++
 drivers/gpu/drm/panthor/panthor_gem.c    |  5 ++-
 include/drm/drm_gem.h                    |  1 -
 4 files changed, 41 insertions(+), 38 deletions(-)
---
base-commit: 57f68ed1f08cd10f51a9091645fd5dfcc369a885
change-id: 20260506-panthor-shrinker-fixes-58c1f45cfc41

Best regards,
-- 
Boris Brezillon <boris.brezillon@collabora.com>

