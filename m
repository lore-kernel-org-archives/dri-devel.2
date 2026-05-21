Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695CCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F09410E4C7;
	Thu, 21 May 2026 14:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csR/xaIt";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1968210E4C7
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:36:28 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso65880045ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779374187; x=1779978987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=PTAM2OCnR/CpQqKrM7cC8oSYE2+MEWlXnrT+DWAEKJA=;
 b=csR/xaItFw+AfT1Yq0aQ1vDbP84E1P/jON9TU5RQ5xjRfcM1gj03+8InqKWgco+RXe
 2mo0+LGnHL7xDnsWm9l651hPOcYP6mRCBf0kp/ZOIo7RSojIgD9CLvDznPx8BR0gndMw
 VLua4yoK81AghiXXh6cC/nZ4vCk/wTEXjNkX0bB24Ad8eQ0TAGlGpGV47bnFlTLG411T
 xnJeh383M0EYMOss6sN/T91DuHGO4A8Q+RED4q0PltTmnzWhs0m9ff2W5vpOOk1jvRnx
 WZrq0z1kxNNvg98DdJ9pgGo9V+sJHItm5ogbpLALib/etrk+pw2BgAIycWXu4YC5fWR7
 Lcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374187; x=1779978987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTAM2OCnR/CpQqKrM7cC8oSYE2+MEWlXnrT+DWAEKJA=;
 b=WzmDJkTY9zPOjxe3MKDaWn3My7V4ERWtW6gnYQGbVSLnDJvVo107Y//iEjNME5D89A
 g7zlKOQFbL0QP/bdmU24jj4JF9UGWP5hV7PLQrnOsST+6sDtEbqlcYYb8C4y58i4CMJf
 QXgbrR9GUHzPVQkrN2dwVtAIBXSwFIN4PPKmR0+UBY/vJqis6L5top8xjN4upXE19wCV
 N5w+v7UcYM30bLTTAPgcOJggQwJwH9P5xLtOyVwDum/Z4rI8N4b6lQeOMFH8Wx/5gEhR
 WcgYvdCN9p83ah6hsB51lSDtdFQNH8WHgt7BfHaxFEQJXxaDXnVL7YUycjIwH1wigBCW
 AyTQ==
X-Gm-Message-State: AOJu0YyZ/uc/CH5I6vyppT1hw7ZaG0pIw2u6++1aLUrwPfA7xyi2cDJR
 mlcfNNgsKxIN0quoQUmS+XSFjYbsrvWxKydeaIxqvs1E0hMt3welXr4j
X-Gm-Gg: Acq92OHYP9aMAF0DF9OJ0KeLxiIEE3vELCXgUQoOyTNJBlTOMiQwmtwuhkxyyFDpVK0
 H5+cmyJOdmfFrANgihcLWTrdeLGXTOO9EtNHbGx4+6A2iFXw31iHZB6aF+CIBHUG0GGdKxLt+Fo
 hAPRWlij85rgcGUzS+ZoZJGdELaq87RN7c5W61vvL3dGhEdMAfndN03pT8ti9vz4umlCULCZKpH
 qGtN6PNe90HROawHIVwqdAqPoCjbZ6gSHiwPVvb5V7sciXCpzrYBulBNvGeYvnVTMAqNuk4fnes
 HlvyTbnNCyEqte+t/2Z3ihW8I/HEd/gB9ZB5C7zVtr4zSAEgk40TZlWd03X8kWUuhmJwRgykCS6
 X0BNgEpbH2b9Te3Lhu8tXRdgAGNB8MPl6zjCDV9hqSoGQ/YUZmsfbA+BF4A0cIBInzyur+udGV+
 I8BHtLpCQ0KbcXGyEVSFtFfCWsLh4XI4Xbcso1nVia65lBvCibCyetemJwV3JEOHLMRKNdzePr9
 RtKbpmb7Tv2f79azvEbKMAaxK8=
X-Received: by 2002:a17:902:ce92:b0:2b0:bebb:1081 with SMTP id
 d9443c01a7336-2bea339d36fmr32322615ad.28.1779374187405; 
 Thu, 21 May 2026 07:36:27 -0700 (PDT)
Received: from daeinki-virtual-machine.localdomain ([58.124.60.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea929d774sm13807245ad.32.2026.05.21.07.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:36:26 -0700 (PDT)
From: Inki Dae <inki.dae@samsung.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org
Subject: [GIT PULL] exynos-drm-next
Date: Thu, 21 May 2026 23:36:24 +0900
Message-Id: <20260521143624.56906-1-inki.dae@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Hi Dave and Daniel,

    This PR brings a cleanup and modernization series for Exynos DRM,
    focused on fbdev emulation and DMA/GEM internals.

Major changes are:
    - migrate fbdev allocation to DRM client buffers,
    - switch fbdev geometry calculations to DRM format helpers with tighter checks,
    - fix screen_buffer handling to match fb_info semantics,
    - adopt DRM core DMA tracking and remove redundant Exynos-side code.
	
Please kindly let me know if there is any problem.

Thanks,
Inki Dae

The following changes since commit 512f9f150f367176fa9e5f4613b4863409a6f686:

  Merge tag 'drm-msm-next-2026-04-02' of https://gitlab.freedesktop.org/drm/msm into drm-next (2026-04-03 18:57:00 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos tags/exynos-drm-next-for-v7.2

for you to fetch changes up to b9bb45aeaf028450c753782280922d31120b342a:

  drm/exynos: Make exynos_drm_framebuffer_init() an internal interface (2026-05-21 23:11:46 +0900)

----------------------------------------------------------------
New feature and cleanup for Exynos fbdev
- Move fbdev emulation to DRM client buffers
  . Reuses standard ADDFB2/GEM paths and simplifies cleanup.
- Use DRM format helpers for geometry and size
  . Applies 4CC-based format/pitch/size calculation with stronger checks and PAGE_SIZE alignment.
  . Sets screen_size and fix.smem_len from actual allocated size.

Exynos DRM internal cleanup
- Adopt DRM core DMA tracking and drop redundant code
  . Removes private DMA tracking, exynos_drm_gem_prime_import(), and obsolete iommu_dma_init_domain() stub.
- Reduce duplication and tighten local scope
  . Replaces MAX_FB_BUFFER with DRM_FORMAT_MAX_PLANES.
  . Drops redundant exynos_drm_gem.size and internalizes local-only helpers.

Bug fix for Exynos fbdev behavior
- Fix screen_buffer offset handling
  . Keeps screen_buffer at framebuffer base and avoids applying scanout offset.
  . Includes Fixes and stable Cc for backporting.

----------------------------------------------------------------
Chen-Yu Tsai (5):
      drm/exynos: Internalize exynos_drm_gem_free_object()
      drm/exynos: Use DRM core dedicated DMA device tracking facility
      drm/exynos: Drop exynos_drm_gem.size field
      drm/exynos: Drop MAX_FB_BUFFER in favor of DRM_FORMAT_MAX_PLANES
      drm/exynos/dma: Drop iommu_dma_init_domain() stub

Thomas Zimmermann (5):
      drm/exynos: fbdev: Remove offset into screen_buffer
      drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
      drm/exynos: fbdev: Calculate buffer geometry with format helpers
      drm/exynos: fbdev: Use a DRM client buffer
      drm/exynos: Make exynos_drm_framebuffer_init() an internal interface

 drivers/gpu/drm/exynos/exynos_drm_dma.c   |  15 ++--
 drivers/gpu/drm/exynos/exynos_drm_drv.c   |   1 -
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |   9 ---
 drivers/gpu/drm/exynos/exynos_drm_fb.c    |   9 +--
 drivers/gpu/drm/exynos/exynos_drm_fb.h    |  10 +--
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 111 +++++++++++++++---------------
 drivers/gpu/drm/exynos/exynos_drm_g2d.c   |  13 ++--
 drivers/gpu/drm/exynos/exynos_drm_gem.c   |  50 ++++++--------
 drivers/gpu/drm/exynos/exynos_drm_gem.h   |   8 ---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c   |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.h   |   4 +-
 11 files changed, 103 insertions(+), 129 deletions(-)
