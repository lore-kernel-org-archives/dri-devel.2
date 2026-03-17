Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD21F33806
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D983F10E0E3;
	Tue, 17 Mar 2026 06:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M0idnlBs";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9467710E0E3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:41:19 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c739561f0d3so3437722a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773729679; x=1774334479;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KlUueF1GSw5ohqS7H/vwWeUHzvF9pIfX9HHJ4AwXcpg=;
 b=M0idnlBsjueLBY3COoutwlXXivfc9v1iQ+mdRjMaymqTWsO6FdQRtlx4PUAtkiyPMF
 u1BLShOALMRoU1wXeTE6YkiLN/0xaxdU43ioBeyvsgJrnBWvjf+mjQnq7XjKM96OSrfg
 4UY2VCvgJl4R8qSW4sBBteYzP0izg7uk+fj4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773729679; x=1774334479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlUueF1GSw5ohqS7H/vwWeUHzvF9pIfX9HHJ4AwXcpg=;
 b=lRFrQHj0DZXNtig5PYJhPKZ1G+emLmB0otxquengxOTOu+0M7H5SnPDYC8I6K84HmM
 zzcXXL6i7h3BFkwLcJ/XhVVTYMh6YQMFJenpE1UPdBAZiIUjqZ1/FLFORSi9bNOdGJAi
 xem0wUQ5P+IzQ2L8qa6WUBaNcIA6sDkVvvXfX2OTNVIqlIx4f5mebCgMKiDUSfRdR74g
 ++6boJkTaTvAYMZVFrNGZipBh7uPnSMIK5lOUFmb0vsk5FNS5nUl90lB59glhHBPrFjN
 fEDZitR6jZauMQBxV3yxlA9qtBwBEfkJNl2u+SIf57hUj5h12gBY97Fq+smZ0kbQ8yVz
 LSCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0Nlox2aYqQzrNG3DRjBi2GH1ikD89x6wwajS5UJQzknDrxc67Eh8xA0WuRrlQthAh/IcC04TehF0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzweE9/ZuAvBeoCIL8PB2HeiOREkpYFp9tgo9AUhf9+OVLWL7mi
 UEUgx8MicckudIGZ+HKNdoexn+KwhRkeRo7lbDx7lgKq119/aKXdIZAqOoZ/x4jMcQ==
X-Gm-Gg: ATEYQzwD88v56kQ/c8j8QSF4gkc+dQSwssErKL2MvyJIT1l5eNPvS8nHUcMI7tbiu8k
 R6TC+hfIl5gTnlbborxbG9E2dM7fuaRYmjFUxV1sTzkF/ie025d+6BseCgyzoqBnOir2GXIN2uy
 gVCMG7esGTBvn7fkBIj1g56SlzezCgW+yaGihm1aGods7hYsVun871YELfaodbx1VaE84y4wFGM
 1eLQKpF69oyKUjbEAd4OPww9pDsL0Mc9wV7QIOX8G59l2sJHXJ24eRIP4aLUT+P5AKWewJOt2VL
 XP7E/k5ewTJCzNRU89f8jgkkVlhwlHJeQUAdjxMd3uUfi9COeZd/L80NBID+zolR+2u5tsXWKfg
 2O0hQKTM9mXDkdKTiiou9W3t94x5c+AF9F7T8BBk//TSQ1GOfByTBHwWIi5O9ZjLyWiGsphe9XF
 YnQ/0MGKuHJDVcgg6C/zczGpmebBaFziuOQ6F6MC+tgcV0DPT6mXCi8Wa0dif2KGL4T3vo0lgaa
 SfjYwJl
X-Received: by 2002:a17:902:cccb:b0:2b0:5903:140a with SMTP id
 d9443c01a7336-2b0590316d9mr69517575ad.10.1773729679022; 
 Mon, 16 Mar 2026 23:41:19 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:a064:c65d:a199:5cb6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece605231sm124269425ad.27.2026.03.16.23.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 23:41:18 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 asahi@lists.linux.dev
Subject: [PATCH v2 0/4] drm: Support DMA per allocation kernel mappings
Date: Tue, 17 Mar 2026 14:40:42 +0800
Message-ID: <20260317064049.696795-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
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

Hi everyone,

This is an attempt to revive Rob Herring's "DMA per allocation kernel
mappings" [1] series from 2019. This series stacks on top of my recent
"drm/gem-dma: Support dedicated DMA device for allocation" series [2].
Many of the allocation paths are touched by both.

The 3 driver conversions from the original series are not included, as
the changes have landed in some other form.

Patch 1 makes the rcar-du driver use one of the GEM DMA helpers to get
a scatter gather table, instead of calling dma_get_sgtable() directly.
This reduces one location where the DMA APIs are directly used with
drm_gem_dma_object outside the helpers.

Patch 2 adds the kernel internal DRM_MODE_DUMB_KERNEL_MAP flag.

Patch 3 adds the dma_attr field to drm_gem_dma_object, and converts
the GEM DMA helpers to use the dma_*_attrs() variant of the DMA API.

Patch 4 adds support for DRM_MODE_DUMB_KERNEL_MAP to the GEM DMA
helpers by setting the DMA_ATTR_NO_KERNEL_MAPING attribute for requests
without the DRM_MODE_DUMB_KERNEL_MAP flag.


Existing callers of drm_gem_dma_dumb_create_internal(), with the
exception of adp, all use the DRM client API, and otherwise do not have
any direct use of the kernel mapping. Thus only the adp driver gains
setting DRM_MODE_DUMB_KERNEL_MAP before calling
drm_gem_dma_dumb_create_internal().


I have also started to convert the exynos driver to use the GEM DMA
helpers. I also plan on looking into the rockchip driver, but that one
has a separate IOMMU path that needs to be handled. I might copy the
approach used in the exynos driver to deal with it.


Changes compared to the original version from Rob (v1):
- Link to original v1:
  https://lore.kernel.org/dri-devel/20191021214550.1461-1-robh@kernel.org/
- Rebased onto renamed GEM DMA helpers
- New patch for rcar-du
- Patch 2
  - Make drm_mode_create_dumb_ioctl() emit warning if args->flags is not zero
- Patch 3
  - Made vc4_bo_purge() use dma_free_attrs(); this is the other location
    of DMA API used with drm_gem_dma_object outside the helpers
  - Expanded commit message
- Patch 4
  - Added kernal mapping check in drm_fb_dma_get_scanout_buffer() and
    drm_gem_dma_vmap().
  - Made drm_gem_dma_print_info() show "vaddr=(no mapping)" for objects
    allocated without kernel mapping
  - Dropped existing DRM_MODE_DUMB_KERNEL_MAP flag addition in various
    drivers
  - Added DRM_MODE_DUMB_KERNEL_MAP flag to adp_drm_gem_dumb_create()
  - Added flags field kerneldoc for drm_gem_dma_create_with_handle()

I dropped all the original Reviewed-by tags, as it's been 5 years since
the changes were first posted, and also because the code has changed a
lot.

Please have a look.


Thanks
ChenYu

Original cover letter from Rob:

This series adds support for CMA/DMA users to skip kernel mappings for
GEM allocations. The DMA API only guarantees a kernel mapping at
allocation time. Creating mappings with vmap() after allocation may or
may not work as not all allocations have a struct page. As virtual
memory space is limited on 32-bit systems some drivers will skip kernel
mappings when possible. This prevents those drivers from using CMA
helpers and the generic fbdev emulation which results in a lot of
duplicated code.

In order to distinguish between kernel and userspace allocations,
a new flag, DRM_MODE_DUMB_KERNEL_MAP, for drm_mode_create_dumb() is
introduced. This allows drivers to override the default behavior for
CMA helpers of always creating a kernel mapping.

Mediatek is converted to CMA helpers and Rockchip is converted to generic
fbdev support. I also have patches to convert Rockchip to CMA and shmem
helpers, but they need a bit more work. Exynos can also probably be
converted to use CMA helpers.

Compile tested only. I did test fbdev on Rockchip, but the h/w I have
has an IOMMU, so the CMA code path doesn't get tested.

- end quote -

[1] https://lore.kernel.org/dri-devel/20191021214550.1461-1-robh@kernel.org/
[2] https://lore.kernel.org/all/20260311094929.3393338-1-wenst@chromium.org/

Chen-Yu Tsai (1):
  drm/rcar-du: Use drm_gem_dma_get_sg_table() helper to get scatter
    gather table

Rob Herring (3):
  drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
  drm/gem-dma: Use the dma_*_attr API variant
  drm/gem-dma: Support DRM_MODE_DUMB_KERNEL_MAP flag

 drivers/gpu/drm/adp/adp_drv.c                 |  1 +
 drivers/gpu/drm/drm_client.c                  |  1 +
 drivers/gpu/drm/drm_dumb_buffers.c            |  4 +
 drivers/gpu/drm/drm_fb_dma_helper.c           |  4 +
 drivers/gpu/drm/drm_gem_dma_helper.c          | 93 ++++++++++++-------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 12 ++-
 drivers/gpu/drm/vc4/vc4_bo.c                  |  2 +-
 include/drm/drm_gem_dma_helper.h              |  3 +
 include/uapi/drm/drm_mode.h                   |  2 +
 9 files changed, 82 insertions(+), 40 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

