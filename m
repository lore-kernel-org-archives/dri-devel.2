Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F689CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C5310E4E4;
	Tue, 13 Oct 2026 16:37:51 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F1910F4A8
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791909466; x=1823445466;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=a8M0pwMdwzgcqpPLP7WjWUinEtCYKyax0Lc2mzN8idA=;
 b=0/lOCHseEUTaOo8rKSjP6cbNIF24NvuTmz2HuxmaG9saImKXW1jRkg6U
 YUxlL02qinMH1iMBUnpWODiar0GMEbNc5nv8t8JASRimmsv+ixa7vE+VT
 nElk5dtEzcR2XnCYCIouA29dSxNbMHgI3NAKrNP+i5JDc+YMNKCkeKF4n
 glLlpdfBWYQjqTH2NXXzg8sNf/tN6eeV2NRPZgnFS1BxHj2pKrVt6vPWy
 lloXJEHMd5Gkeirzrzz1y8q14OZrFRQYT9qRagahL9qE+LOxLMDl6vew0
 0DQ0HTnVXbuCW/pVQx4ZrUajmhiX+EY0keMW7xXtzYRjQ63KsMyvTDaMl Q==;
X-CSE-ConnectionGUID: v9lvrJ0AQPOdc6eYrw/1ng==
X-CSE-MsgGUID: +GuKnf65Tj2pAotOX3k1KQ==
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; d="scan'208";a="296388287"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Oct 2026 09:37:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 09:37:42 -0700
Received: from ROU-LL-M19942.mpu32.int (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 09:37:38 -0700
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Subject: [PATCH v11 0/5] drm/microchip: add GFX2D support for SAM9X60 and
 SAM9X75
Date: Tue, 13 Oct 2026 18:37:22 +0200
Message-ID: <20261013-cpitchen-mainline_gfx2d-v11-0-7527f2efab0a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XS22rDMAwA0F8Zfl6GJN/3tP8YYzi+NIY1KUkJH
 aX/PqewNgyne5RAR0LSmU1xzHFir09nNsY5T3noS4D4/MR85/pdbHIoCUZAEixi4w/56LvYN3u
 X+6/cx89dOlFolOIYLZfkkmal+jDGlE9X+v2jxF2ejsP4fe0045L935yxgSbo5Fp03GCMb/vsx
 8F3+fDihz1b3JnWltm2qFjKJ+dtkEoh1Sx+sxBJbFt8sUAn4wVoMqpmiV9LQcG2LVGsRAgg0AU
 ueM2Sa4tvW7JY1gfXmuSUtW3NUiuLYNtSxUKHygcMGlpTs/TdIrDbli4WeKSohAMroWaZu2Xow
 R1Nsbg2XAsprebVuezNKntV25YtlhZt4CFRRFPdPcIaezAYwvIV2jsSWrc8yL/a5XL5AV/5C01
 xAwAA
X-Change-ID: 20250911-cpitchen-mainline_gfx2d-6631e9352af7
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Russell King <linux@armlinux.org.uk>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, Conor Dooley
 <conor.dooley@microchip.com>, Manikandan Muralidharan
 <manikandan.m@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11007;
 i=cyrille.pitchen@microchip.com; h=from:subject:message-id;
 bh=a8M0pwMdwzgcqpPLP7WjWUinEtCYKyax0Lc2mzN8idA=;
 b=owGbwMvMwCXmf6yzKqEsVIbxtFoSQ9a5OPfvBb/d53Fw+cupSLHdbPj3cZG2+MJdAeYrdid63
 jhR+a6go5SFQYyLQVZMkeXQm629mcdfPbZ7JSoFM4eVCWQIAxenAExEQ4qR4dcdfYE5M6eFdRu9
 NvLa8nbagu5XK0UY3/f66Oy5xXrRMpmRobWrWPPVsr8MbHJfWHZ1n75vaLLW5+wVr1OrH/F+8Q/
 7yQYA
X-Developer-Key: i=cyrille.pitchen@microchip.com; a=openpgp;
 fpr=7A21115D7D6026585D0E183E0EF12AA1BFAC073D
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

Hi all,

This series of patches adds GFX2D support.
The GFX2D is a 2D GPU embedded in some Microchip SoCs such as the
SAM9X60 and SAM9X75.

Patches have been developped on top the 'linux-6.12-mchp' branch of the
https://github.com/linux4microchip/linux.git repository and tested on
mainly on a sam9x75-curiosity board and also on a sam9x60-ek board.

Later, the patches have also been rebased on the 'linux-6.18-mchp'
branch of the https://github.com/linux4microchip/linux.git repository
then tested on a sam9x75-curiosity board.

Finally, they have been rebased on top of the 'drm-misc-next' branch
of the https://gitlab.freedesktop.org/drm/misc/kernel.git repository
for mainlining. Hence, they have been tested on a sam9x75-curiosity
board running a linux4microchip 26.04 image where the kernel + DTB
have been replaced with the new kernel compiled from the 'drm-misc-next'
branch (currently based on linux 7.3.0-rc4).

About the tests, the GFX2D driver was used with the M2D (Multi 2D)
library: https://github.com/linux4sam/libm2d

This is an open source library that abstracts 2D GPUs like the Microchip
GFX2D and the Vivante GC520UL, providing graphics applications or
libraries with a unified API, inspired from OpenGL but focused on 2D GPUs.
The libm2d library itself relies on the libdrm library to send commands to
the relevant DRM driver in the Linux kernel.
The libm2d library has not been designed to be thread-safe. Indeed, it is
intended to be used by a single thread for better performances.

M2D comes with a m2d_test program to run basic unitary tests.
In addition, libm2d has been integrated to two graphics frameworks:
- EGT: https://github.com/linux4sam/egt
- LVGL: https://github.com/lvgl/lvgl/pull/8729

Tested the system suspend with the 'systemctl suspend' command.
Tested the runtime pm with the 'egt_boards' application.

BR,

Cyrille

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
Changes in v11:
- Reworked patch 2 based on sashiko comments:
  + Checked the return code of pm_runtime_resume_and_get() in
    mchp_gfx2d_thread().
  + Set 'cmd->id' once the 'cmdlist_mutex' is held.
  + Didn't make mchp_gfx2d_interrupt() return IRQ_NONE.
  + Didn't lock GEM object mutex in non-blocking mchp_gfx2d_wait().
  + Removed implementation of ROP4 for now.
  + Validated the userspace 'tv_nsec' value.
  + Initialized all 'struct mchp_gfx2d_gem_object' fields from
    mchp_gfx2d_gem_create_with_handle() before calling
    drm_gem_handle_create().
  + Called drm_dev_{enter,exit}() from ioctls and drm_dev_unplug() from
    mchp_gfx2d_remove().
  + Included "linux/slab.h" for the kzalloc_obj() macro definition.
  + Added a mchp_gfx2d_stop() function to share code between
    mchp_gfx2d_{runtime_suspend,remove}() functions.
  + Reworked probe, remove and suspend/resume to release resources
    without races.
  + Flushed the data cache only with exported functions (but still
    needed to solve the alias issue of VIVT cache on ARM926).
- Link to v10: https://lore.kernel.org/r/20261008-cpitchen-mainline_gfx2d-v10-0-67ca2477b3d5@microchip.com

Changes in v10:
- Reworked patch 2 based on sashiko comments:
  + Fixed mchp_gfx2d_cleanup_command_queue() to correctly release
    resources from both the running and free command lists.
  + Replaced pm_runtime_get_no_resume() with pm_runtime_resume_and_get()
    in mchp_gfx2d_thread().
  + Added locks to handle races between the IRQ handler/thread and the
    suspend/resume/remove functions.
  + Added a comment to explain why flush_cache_mm() is called from
    mchp_gfx2d_ioctl_sync_for_gpu().
  + Replaced enums with __u32 and added explicit padding fields in UAPI
    structures.
  + Called drm_gem_handle_delete() in all error paths within
    mchp_gfx2d_ioctl_import_buffer().
- Link to v9: https://lore.kernel.org/r/20261006-cpitchen-mainline_gfx2d-v9-0-74bd3df2e183@microchip.com

Changes in v9:
- Rebased onto the 'drm-misc-next' branch on 2026-10-06.
- Reworked patch 2 mainly based on sashiko comments:
  + Used 'struct drm_gem_dma_object' as the new base for 'struct
    mchp_gfx2d_gem_object'.
  + Removed useless initialization of 'ret' in mchp_gfx2d_schedule().
  + Changed type of 'struct drm_mchp_gfx2d_submit.num_rectangles' from
    '__kernel_size_t' to '__u32'.
  + Added missing support of special blend functions in blend commands.
  + Added helper functions to {en,de}queue commands in the running list.
  + Enabled the EXEND interrupt when partial or pending commands are
    scheduled to make sure such commands can actually progress.
  + Replaced pm_runtime_resume_and_get() with pm_runtime_get_noresume()
    in mchp_gfx2d_thread().
  + Added a comment about the 'BLEND_SREG' GPU internal register that
    could be overwritten on SAM9X60 SoCs.
  + Fixed integer truncation of the ROP mode in
    mchp_gfx2d_set_rop_params() to prevent userspace from bypassing mask
    validation.
  + Added upper bound check for the number of rectangles in SUBMIT ioctl.
  + Fixed mchp_gfx2d_cleanup_command_queue() to access hardware
    registers only if the peripheral clock is enabled.
  + Fixed potential corrumption of 'priv->wlist' by concurrent WAIT ioctls
    on the same GEM object.
  + Kept imported surface metadata immutable after first import.
  + Changed type of 'next_id' from 'static uint32_t' to 'static
    atomic_t' to avoid potential races.
  + Replaced atomic_dec() with atomic_dec_return() in
    mchp_gfx2d_gem_unref().
  + Fixed potential corruption of the shared per-file 'rectangles' buffer
    by concurrent SUBMIT ioctls on the same file descriptor.
  + Fixed the potential Use-After-Free of GEM object in
    mchp_gfx2d_ioctl_alloc_buffer().
  + Made mchp_gfx2d_ioctl_sync_for_cpu() invalidate the CPU cache for
    non-coherent buffers by calling dma_sync_single_for_cpu().
  + Made mchp_gfx2d_ioctl_sync_for_gpu() clean the CPU cache for
    non-coherent buffers by calling dma_sync_single_for_device().
  + Replaced flush_cache_range() with flush_cache_mm() in
    mchp_gfx2d_ioctl_sync_for_gpu() to manage the cache aliasing issue
    on SAM9 (ARM926) without copying a 'struct vm_area_struct'.
- Link to v8: https://lore.kernel.org/r/20260828-cpitchen-mainline_gfx2d-v8-0-378374559738@microchip.com

Changes in v8:
- Rebased onto the 'drm-misc-next' branch on 2026-08-28.
- Collected Reviewed-by tags from Manikandan Muralidharan on patches 3
  and 4
- Replaced kzalloc() with kzalloc_obj() in patch 2 as suggested by
  checkpatch.pl.
- Link to v7: https://lore.kernel.org/r/20260209-cpitchen-mainline_gfx2d-v7-0-0c12e64a0950@microchip.com

Changes in v7:
- Rebased onto the 'drm-misc-next' branch on 2026-02-09.
- Rewored patch 2:
  + Reworked the former valid_pixel_format() function into the new
    mchp_gfx2d_valid_buffer_params() function, which is called from both
    the mchp_gfx2d_ioctl_{alloc,import}_buffer() functions and now checks
    the `width` and `stride` parameters in addition to the `format` one.
  + Added the mchp_gfx2d_valid_size() function, which is called from both
    the mchp_gfx2d_ioctl_{alloc,import}_buffer() functions and checks
    (`stride` * `height`) against `size` as suggested by Daniel Stone.
- Link to v6: https://lore.kernel.org/r/20260120-cpitchen-mainline_gfx2d-v6-0-1a16cd1d70b8@microchip.com

Changes in v6:
- Shrank the size of the register set in the device tree from 0x4000
  down to 0x100 (patches 1, 3 and 4).
- Collected Reviewed-by and Acked-by tags from Nicolas Ferre on patches
  1 and 5.
- Rebased onto the 'drm-misc-next' branch on 2026-01-20.
- Link to v5: https://lore.kernel.org/r/20260113-cpitchen-mainline_gfx2d-v5-0-9cdab8fa699b@microchip.com

Changes in v5:
- Fixed compilation issues in patch 2:
  + Included <drm/drm_print.h> from mchp_gfx2d_cmd.c, mchp_gfx2d_drv.c
    and mchp_gfx2d_gem.c.
  + Replaced '.remove_new' with '.remove' in definition of 'struct
    platform_driver mchp_gfx2d_platform_driver' to match the latest
    definition of 'struct platform_driver'.
  + Removed the '.date' member from the definition of 'struct drm_driver
    mchp_gfx2d_drm_driver' since this 'date' member has been removed from
    'struct drm_driver'.
- Fixed typos in doxygen documentations of two functions:
  + mchp_gfx2d_process_completed_commands()
  + mchp_gfx2d_init_command_queue()
- Link to v4: https://lore.kernel.org/r/20260112-cpitchen-mainline_gfx2d-v4-0-f210041ad343@microchip.com

Changes in v4:
- Rebased onto the 'drm-misc-next' branch on 2026-01-12.
- Link to v3: https://lore.kernel.org/r/20251124-cpitchen-mainline_gfx2d-v3-0-607f8c407286@microchip.com

Changes in v3:
- Collected Acked-by tag from Conor Dooley on patch 1
- Rebased onto the 'drm-misc-next' branch on 2025-11-24.
- Link to v2: https://lore.kernel.org/r/20250918-cpitchen-mainline_gfx2d-v2-0-6cfac9d56612@microchip.com

Changes in v2:
- Renamed microchip,gfx2d.yaml into microchip,sam9x60-gfx2d.yaml.
- Removed the 'clock-names' property from the DT bindings.
- Renamed the GPU node from 'gfx2d' to 'gpu' in sam9x{60,7}.dtsi files.
- Link to v1: https://lore.kernel.org/r/20250911-cpitchen-mainline_gfx2d-v1-0-d7fab1a381ee@microchip.com

---
Cyrille Pitchen (5):
      dt-bindings: gpu: add bindings for the Microchip GFX2D GPU
      drm/microchip: add a driver for the Microchip GFX2D GPU
      ARM: dts: microchip: sam9x60: Add GFX2D GPU
      ARM: dts: microchip: sam9x7: Add GFX2D GPU
      ARM: configs: at91_dt_defconfig: enable GFX2D driver

 .../bindings/gpu/microchip,sam9x60-gfx2d.yaml      |   46 +
 MAINTAINERS                                        |   10 +
 arch/arm/boot/dts/microchip/sam9x60.dtsi           |    8 +
 arch/arm/boot/dts/microchip/sam9x7.dtsi            |    8 +
 arch/arm/configs/at91_dt_defconfig                 |    1 +
 drivers/gpu/drm/Kconfig                            |    1 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/microchip/Kconfig                  |   22 +
 drivers/gpu/drm/microchip/Makefile                 |    8 +
 drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c         | 1891 ++++++++++++++++++++
 drivers/gpu/drm/microchip/mchp_gfx2d_cmd.h         |  181 ++
 drivers/gpu/drm/microchip/mchp_gfx2d_drv.c         |  427 +++++
 drivers/gpu/drm/microchip/mchp_gfx2d_drv.h         |  152 ++
 drivers/gpu/drm/microchip/mchp_gfx2d_gem.c         |  184 ++
 drivers/gpu/drm/microchip/mchp_gfx2d_gem.h         |   77 +
 drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c       |  423 +++++
 drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.h       |   17 +
 include/uapi/drm/microchip_drm.h                   |  288 +++
 18 files changed, 3745 insertions(+)
---
base-commit: 4f2fb106c459e6b96ddfa542de40e517b5274c44
change-id: 20250911-cpitchen-mainline_gfx2d-6631e9352af7

Best regards,
-- 
Cyrille Pitchen <cyrille.pitchen@microchip.com>

