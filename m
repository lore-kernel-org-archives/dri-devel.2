Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A1AFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C827510E9B3;
	Wed, 29 Apr 2026 13:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WUmCWDUL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F7410E3D1;
 Wed, 29 Apr 2026 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rjD3vHRhB7ZvQTRvyQpEWW7zvgXKCVf8WWT2trJiZec=; b=WUmCWDULHcfE+6wzWYmOd1dL6r
 7ynW233fH3jPm6meum0EFboCJ9iKIu8ydlkKJtMoZH3vmjbIJsSnM6JHUUw+10py9cYAC2fBTrkWj
 pK7KvB+BQ6fcxCTHuikHgkIPepX+NIpFF9/rVVxIpclLgM5j3z0uaywp+1ZHAaDroozq64v69hjbx
 F0Yn2KPPk5Y9aI76tHU49dDHtMb5GHV3vjIzCLsTEnt9EJAvVhSqkU/UUESRPnlEPdsa8qRAJDYHu
 vYPN2REBodwxhgh46x6/QhMzhhMBzxR9HRYDPnwwSni8ubVwo3V7dQqZ3aF2S9+DipwdFhWQJpGTY
 QZL+ijZQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wI4d4-003wV3-4D; Wed, 29 Apr 2026 15:07:01 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 0/2] DRM standardized memory stats
Date: Wed, 29 Apr 2026 14:06:51 +0100
Message-ID: <20260429130653.73854-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Floating a simple idea born from an user interest to be able to correctly size
the swap space during OS installation, based on the size of the VRAM a discrete
GPU might have. And to be able to do it in a vendor agnostic way.

Idea is to expose a standardized scheme in sysfs, under the DRM class card, and
under a new 'memstat' directory. Such as, example from amdgpu:

/sys/class/drm/card1/memstat/
├── gtt
│   ├── total_mb
│   └── used_mb
└── vram
    ├── total_mb
    └── used_mb

Or with concrete numbers:

$ grep -Hr . /sys/class/drm/card1/memstat/
/sys/class/drm/card1/memstat/vram/total_mb:1024
/sys/class/drm/card1/memstat/vram/used_mb:445
/sys/class/drm/card1/memstat/gtt/total_mb:7394
/sys/class/drm/card1/memstat/gtt/used_mb:71

Drivers need to implement a simple DRM driver level callback which needs to
report a stable list of interesting memory regions and their respective stats.
The region names then become sub-directory names under the new 'memstat'
directory, with each region exposing the total size and the current usage.

Similar data can already be queried if the dmem cgroup controller is enabled,
also only for the participating drivers, by querying the root cgroup. But
perhaps sysfs is easier, or perhaps it is too much code for too little benefit.
I am curious to hear any opinions.

Tvrtko Ursulin (2):
  drm: Allow drivers to report standardized memory stats
  drm/amdgpu: Wire up DRM memory stats reporting

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  40 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  37 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   3 +
 drivers/gpu/drm/drm_drv.c                  |  10 ++
 drivers/gpu/drm/drm_sysfs.c                | 123 +++++++++++++++++++++
 include/drm/drm_device.h                   |  19 ++++
 include/drm/drm_drv.h                      |   8 ++
 include/drm/drm_file.h                     |   9 ++
 include/drm/drm_sysfs.h                    |   4 +
 11 files changed, 248 insertions(+), 13 deletions(-)

-- 
2.52.0

