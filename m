Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CA8106F311
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DFF10EAA4;
	Thu, 26 Mar 2026 10:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O2/soOYn";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D61110EA9A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:03:03 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so3256065ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774519382; x=1775124182;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3VlUYaUmk3wbdqIFNK9sLGnBuP1ZpHqxD7VT5es4j3c=;
 b=O2/soOYn6HePH2LLxiZ1KfS9r9hiGEJvJroWMfGQ5UdMTdbiMGD0Tj3soch1DBeFZp
 S9hyZkW1ryebnuOqiBHmlGjznG5KzWLYjymhgwEnw2kaK0baA3SmDzRXV47fBvpWtkZi
 9ib9kP/wG+waQsWeEcf8rKUFlovoc/HIRUwKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774519382; x=1775124182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VlUYaUmk3wbdqIFNK9sLGnBuP1ZpHqxD7VT5es4j3c=;
 b=os9ztOj8NYBFWAV8yQ0oiTpUcWC+mwx74btrQmPeesSzlRjU1+tKM23e1ghC5dU4+h
 5aQAYW9IT1y+4cUN5kLp6uhxAQfbCoPBi3FneW/6aRT7XKlG20TCZ5JHe59ap6ZYsdjt
 l0rb7FJ/aL3xJ1f9ikSkXWwO1nGAOKutb4sFe4VJ5RGCP3Ct66G31sBC8sjyLRk6kKP2
 HXB0ZGrm6GLedLLp4+QEf+DqWx4UT88Qdu+SzC76DDtpCXeJE+1AeyyGipWYrITcNRma
 Wu/sbMEKydHmwn9Mjm3C0ci2ShEhhj3Kju7RhreUdN1O/SaKDdNNEKJY6wiHqKMWJNPc
 Fe6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoxtms6Oqjljh6wSGrS09hyaVHc2cvOvRF36vsjbDF2RHseVFb+b6IrWu590U12BKqjQWXOjnucVw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBI00P2DnOQZmHy4Xh5R4nv1uVMQ5fWx9XH9HYyzqTcpeVj2iU
 LFo63ajkkWCDZQptzmuQLsZxUE/xc+9F0dNSWDW/4oNw8aiawJRTlJOlaH8ujWwMRg==
X-Gm-Gg: ATEYQzzswH9ltqTyI0cly7X6OzpFYVoiBPiRQFuetrLHNujvn3CXkkIaH8gL7L9wIhg
 WvyUFeqirXx9hqSBZbWa9SLcY8OcpKh7mToEQp3uzc/38Z2JHyZYfpJWSP787QeZ3wpqWwLHupf
 jbaNT+hcC6agYDfChwWihH7hnY9V9TGtdyZt1cKl5tKO49f1s4KmVi1t+h10tgV4dHjDfXy9obW
 j7UrGy687owfI7aHcX9ZuuHMbGXtUG4cYZmEfoSOTxvaeldaG1p2DUlhd6eJ8ZotK47werv8ETh
 eivEagE5U/8EGtU9SNIGK4rjINyXxQiNALvUq7jGG5eosIf4JKJCFi/XjLrvSGM/yJPFetAgHah
 ofEcaw2lL9t99Iv8VHKF7KcwH5ww+qu0NSBYwjIKyYtZL4nLbWMNibIKCO5h54GHLQ/VXIDvO0L
 O93LHeaC8+NqtvWkfU/t3amFZ3A3/mBLHGzJ85qFZpxngiEp1FOfOEkdcnlMTOvPfgmvmgiru+k
 GkJBhY1eErm0i5XeqY=
X-Received: by 2002:a17:903:37c3:b0:2b0:5aab:c40a with SMTP id
 d9443c01a7336-2b0b0af4c01mr75467635ad.31.1774519381942; 
 Thu, 26 Mar 2026 03:03:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7c2942sm23339435ad.36.2026.03.26.03.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:03:01 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] drm: Support DMA per allocation kernel mappings
Date: Thu, 26 Mar 2026 18:01:42 +0800
Message-ID: <20260326100248.1171828-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
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

Hi everyone,

This is v3 of the "DMA per allocation kernel mappings" series.

Changes since v2:
- Dropped rcar-du patch in favor of just using dma_get_sgtable_attrs()
  in patch 2
- Patch 1
  - Switched to drm_warn_once()
  - Moved flag definition from include/uapi/ to include/drm/drm_dumb_buffers.h
  - Reworded commit message
- Patch 2
  - Added change for rcar-du: s/dma_get_sgtable()/dma_get_sgtable_attrs()/
- Patch 3
  - Added back DRM_MODE_DUMB_KERNEL_MAP flag to all drivers calling
    drm_gem_dma_dumb_create_internal()
  - Expanded commit message to cover display drivers needing the kernel
    mapping to do scan out


This is an attempt to revive Rob Herring's "DMA per allocation kernel
mappings" [1] series from 2019. This series stacks on top of my recent
"drm/gem-dma: Support dedicated DMA device for allocation" series [2].
Many of the allocation paths are touched by both.

The 3 driver conversions from the original series are not included, as
the changes have landed in some other form.

Patch 1 adds the kernel internal DRM_MODE_DUMB_KERNEL_MAP flag.

Patch 2 adds the dma_attr field to drm_gem_dma_object, and converts
the GEM DMA helpers to use the dma_*_attrs() variant of the DMA API.

Patch 3 adds support for DRM_MODE_DUMB_KERNEL_MAP to the GEM DMA
helpers by setting the DMA_ATTR_NO_KERNEL_MAPING attribute for requests
without the DRM_MODE_DUMB_KERNEL_MAP flag.


All existing callers of drm_gem_dma_dumb_create_internal() will have
DRM_MODE_DUMB_KERNEL_MAP set to maintain existing behavior.

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

Rob Herring (3):
  drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
  drm/gem-dma: Use the dma_*_attr API variant
  drm/gem-dma: Support DRM_MODE_DUMB_KERNEL_MAP flag

 drivers/gpu/drm/adp/adp_drv.c                 |  1 +
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  1 +
 drivers/gpu/drm/arm/malidp_drv.c              |  1 +
 drivers/gpu/drm/drm_client.c                  |  2 +
 drivers/gpu/drm/drm_dumb_buffers.c            |  4 +
 drivers/gpu/drm/drm_fb_dma_helper.c           |  4 +
 drivers/gpu/drm/drm_gem_dma_helper.c          | 93 ++++++++++++-------
 drivers/gpu/drm/logicvc/logicvc_drm.c         |  1 +
 drivers/gpu/drm/meson/meson_drv.c             |  1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c |  2 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c |  5 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  1 +
 drivers/gpu/drm/stm/drv.c                     |  3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  1 +
 drivers/gpu/drm/vc4/vc4_bo.c                  |  2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                 |  2 +
 drivers/gpu/drm/verisilicon/vs_drm.c          |  2 +
 drivers/gpu/drm/xlnx/zynqmp_kms.c             |  2 +
 include/drm/drm_dumb_buffers.h                |  3 +
 include/drm/drm_gem_dma_helper.h              |  3 +
 20 files changed, 94 insertions(+), 40 deletions(-)

-- 
2.53.0.1018.g2bb0e51243-goog

