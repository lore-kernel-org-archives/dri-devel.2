Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4D7CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB64A10E559;
	Mon, 15 Jun 2026 16:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nxoelhxw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0343F10E52D
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:38:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E9786008A;
 Mon, 15 Jun 2026 16:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2641F000E9;
 Mon, 15 Jun 2026 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781541514;
 bh=QpYXdz2UEgS/WiHURzwxli5wW+WRSeWFTPVBjB8/KWc=;
 h=Date:From:To:Subject;
 b=nxoelhxwM5dzr4vG+IRKAuVR1Sgh3N7keWjRxRex2ygmOGY6VfmFNH3owYtOJ1eXK
 lM/VsVhuPNpHzcq070frUrt3TtKKTt1zuu2e6sak17lbVQ60Rb21/tizSf9Otdz/88
 m6Qeq06xAgL7ceb6wEX/Uvx9NiwWje5tXwRQOl75VRafUfHJDLmazZmvl7M2P46bBT
 50Y8TUBny9ijxVFjW0CDCLGUlGNMH//41f35r7jG/M9FyF5kD/SbTj4286Y8iKKnBx
 zMmUdKmYF1971HIaGmCnQxvbgWmeo9h6XKGlzEsvMbMKgXX/HKuaCmDgMOQXECDi0M
 mAdsMtMqq20HQ==
Date: Mon, 15 Jun 2026 18:38:30 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v7.2-rc1
Message-ID: <ajAqhsgrxtUHQdFv@carbonx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Hi Linus,

please pull the major fbdev patches for this merge window.

Beside the removal of the Hercules monochrome ISA graphics driver and
the corresponding text console driver, there is just the typical
maintanance with smaller driver fixes and cleanups as documented in the
changelog below.

Thanks!
Helge

----------------------------------------------------------------


The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc1

for you to fetch changes up to d894c48a57d78206e4df9c90d4acfaf39394806a:

  fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode (2026-06-12 23:23:43 +0200)

----------------------------------------------------------------
fbdev fixes & cleanups for 7.2-rc1:

Removal of drivers:
- Hercules monochrome ISA graphics adapter driver [Ethan Nelson-Moore]
- Hercules mdacon console driver [Ethan Nelson-Moore]

Changes affecting many drivers at once:
- possible memory leak fixes in various drivers [Abdun Nihaal]
- many conversions to use strscpy() [David Laight]
- Use named initializers in drivers [Uwe Kleine-König]

Code fixes:
- fbcon: don't suspend/resume when vc is graphics mode [Lu Yao]
- modedb: fix a possible UAF in fb_find_mode() [Tuo Li]
- modedb: Fix entry for 1920x1080-60 mode [Steffen Persvold]
- arm: Export acorndata_8x8 font symbol for bootloader [Helge Deller]
- omap2: fix use-after-free in omapfb_mmap [Hongling Zeng]

Cleanups:
- pxa168fb: use devm_ioremap_resource() [AlbertoArostegui]
- provice helpers for fb_set_var() and fb_blank() and fbcon updates [Thomas Zimmermann]
- fbcon: Use correct type for vc_resize() return value [Jiacheng Yu]
- chipsfb: add missing MODULE_DESCRIPTION() macro [Rahman Mahmutović]
- sunxvr2500: replace printk with device-aware logging functions [Rahman Mahmutović]
- sm712: Fix operator precedence in big_swap macro [Li RongQing]
- imxfb: Use of_device_get_match_data() [Rosen Penev]
- atmel_lcdfb: Use of_device_get_match_data() [Rosen Penev]

Documentation fixes:
- grvga: Fix CLUT register address offset in comment [Eduardo Silva]
- omap/dss: Fix stale modedb.c path [Costa Shulyupin]
- correct CONFIG_FB_TILEBLITTING macro name in #endif comment [Ethan Nelson-Moore]

----------------------------------------------------------------
Abdun Nihaal (13):
      fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
      fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
      fbdev: metronomefb: fix potential memory leak in metronomefb_probe()
      fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
      fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
      fbdev: i740fb: fix potential memory leak in i740fb_probe()
      fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      fbdev: s3fb: fix potential memory leak in s3_pci_probe()
      fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
      fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
      fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      fbdev: efifb: fix memory leak in efifb_probe()
      fbdev: vesafb: fix memory leak in vesafb_probe()

AlbertoArostegui (1):
      fbdev: pxa168fb: use devm_ioremap_resource() for MMIO

Costa Shulyupin (1):
      docs: omap/dss: Fix stale modedb.c path

David Laight (7):
      fbdev: atmel_lcdfb: Use strscpy() to copy device name
      fbdev: cyber2000fb: Use strscpy() to copy device name
      fbdev: rivafb: Use strscpy() to copy device name
      fbdev: sisfb: Replace strlen() strcpy() pair with strscpy()
      fbdev: mmpfb: Use strscpy() to copy device name
      fbdev: sm501fb: Fix buffer errors in OF binding code
      fbdev: s3fb: Use strscpy() to copy strings into arrays

Eduardo Silva (1):
      fbdev: grvga: Fix CLUT register address offset in comment

Ethan Nelson-Moore (3):
      fbdev: remove Hercules monochrome ISA graphics adapter driver
      console: mdacon: remove this obsolete driver
      fbcon: correct CONFIG_FB_TILEBLITTING macro name in #endif comment

Helge Deller (1):
      fbdev/arm: Export acorndata_8x8 font symbol for bootloader

Hongling Zeng (1):
      fbdev: omap2: fix use-after-free in omapfb_mmap

Jiacheng Yu (1):
      fbcon: Use correct type for vc_resize() return value

Li RongQing (1):
      fbdev: sm712: Fix operator precedence in big_swap macro

Lu Yao (1):
      fbcon: don't suspend/resume when vc is graphics mode

Rahman Mahmutović (2):
      fbdev: chipsfb: add missing MODULE_DESCRIPTION() macro
      fbdev: sunxvr2500: replace printk with device-aware logging functions

Rosen Penev (2):
      fbdev: imxfb: Use of_device_get_match_data()
      fbdev: atmel_lcdfb: Use of_device_get_match_data()

Steffen Persvold (1):
      fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode

Thomas Zimmermann (4):
      fbdev: Wrap user-invoked calls to fb_set_var() in helper
      fbdev: Wrap user-invoked calls to fb_blank() in helper
      fbdev: Wrap fbcon updates from vga-switcheroo in helper
      fbdev: Do not export fbcon from fbdev

Tuo Li (1):
      fbdev: modedb: fix a possible UAF in fb_find_mode()

Uwe Kleine-König (2):
      fbdev: matroxfb/ssd1307fb: Use named initializers for struct i2c_device_id
      fbdev: Consistently define pci_device_ids using named initializers

 CREDITS                                         |   3 +
 Documentation/admin-guide/kernel-parameters.txt |   5 -
 Documentation/arch/arm/omap/dss.rst             |   2 +-
 MAINTAINERS                                     |   8 -
 arch/alpha/kernel/io.c                          |   2 +-
 arch/arm/boot/compressed/Makefile               |   2 +-
 arch/powerpc/include/asm/vga.h                  |   4 +-
 drivers/gpu/vga/Kconfig                         |   2 +-
 drivers/gpu/vga/vga_switcheroo.c                |   6 +-
 drivers/tty/vt/vt.c                             |   3 -
 drivers/video/console/Kconfig                   |  15 -
 drivers/video/console/Makefile                  |   1 -
 drivers/video/console/mdacon.c                  | 566 --------------------
 drivers/video/fbdev/Kconfig                     |  13 -
 drivers/video/fbdev/Makefile                    |   1 -
 drivers/video/fbdev/arkfb.c                     |   4 +-
 drivers/video/fbdev/atmel_lcdfb.c               |   8 +-
 drivers/video/fbdev/aty/aty128fb.c              | 143 ++---
 drivers/video/fbdev/aty/radeon_base.c           |   3 +-
 drivers/video/fbdev/broadsheetfb.c              |   8 +-
 drivers/video/fbdev/carminefb.c                 |   6 +-
 drivers/video/fbdev/chipsfb.c                   |   1 +
 drivers/video/fbdev/cirrusfb.c                  |   2 +-
 drivers/video/fbdev/core/fb_chrdev.c            |  12 +-
 drivers/video/fbdev/core/fb_internal.h          |   1 +
 drivers/video/fbdev/core/fbcon.c                |  17 +-
 drivers/video/fbdev/core/fbcon.h                |  50 ++
 drivers/video/fbdev/core/fbmem.c                |  35 +-
 drivers/video/fbdev/core/fbsysfs.c              |   9 +-
 drivers/video/fbdev/core/modedb.c               |   5 +-
 drivers/video/fbdev/cyber2000fb.c               |  26 +-
 drivers/video/fbdev/efifb.c                     |   1 +
 drivers/video/fbdev/geode/gx1fb_core.c          |  10 +-
 drivers/video/fbdev/grvga.c                     |   2 +-
 drivers/video/fbdev/hecubafb.c                  |   6 +-
 drivers/video/fbdev/hgafb.c                     | 685 ------------------------
 drivers/video/fbdev/i740fb.c                    |   1 +
 drivers/video/fbdev/imxfb.c                     |   6 +-
 drivers/video/fbdev/kyro/fbdev.c                |   5 +-
 drivers/video/fbdev/matrox/matroxfb_base.c      |  40 +-
 drivers/video/fbdev/matrox/matroxfb_maven.c     |   2 +-
 drivers/video/fbdev/metronomefb.c               |   8 +-
 drivers/video/fbdev/mmp/fb/mmpfb.c              |   2 +-
 drivers/video/fbdev/neofb.c                     |  29 +-
 drivers/video/fbdev/nvidia/nvidia.c             |  10 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c  |   9 +-
 drivers/video/fbdev/pm2fb.c                     |  11 +-
 drivers/video/fbdev/pm3fb.c                     |   5 +-
 drivers/video/fbdev/ps3fb.c                     |   5 +-
 drivers/video/fbdev/pvr2fb.c                    |   5 +-
 drivers/video/fbdev/pxa168fb.c                  |   7 +-
 drivers/video/fbdev/riva/fbdev.c                | 128 ++---
 drivers/video/fbdev/riva/rivafb-i2c.c           |   2 +-
 drivers/video/fbdev/s3fb.c                      |  39 +-
 drivers/video/fbdev/savage/savagefb_driver.c    | 142 ++---
 drivers/video/fbdev/sh_mobile_lcdcfb.c          |   5 +-
 drivers/video/fbdev/sis/sis_main.c              |   3 +-
 drivers/video/fbdev/sis/sis_main.h              |  26 +-
 drivers/video/fbdev/sm501fb.c                   |  16 +-
 drivers/video/fbdev/sm712.h                     |   2 +-
 drivers/video/fbdev/ssd1307fb.c                 |   8 +-
 drivers/video/fbdev/sunxvr2500.c                |  19 +-
 drivers/video/fbdev/tdfxfb.c                    |  22 +-
 drivers/video/fbdev/tridentfb.c                 |  45 +-
 drivers/video/fbdev/uvesafb.c                   |   4 +-
 drivers/video/fbdev/vesafb.c                    |   1 +
 drivers/video/fbdev/vt8623fb.c                  |   4 +-
 include/linux/console.h                         |   2 -
 include/linux/fb.h                              |   3 +
 include/linux/fbcon.h                           |  55 --
 include/linux/vt_buffer.h                       |   2 +-
 lib/fonts/font_acorn_8x8.c                      |   5 +
 72 files changed, 494 insertions(+), 1851 deletions(-)
 delete mode 100644 drivers/video/console/mdacon.c
 delete mode 100644 drivers/video/fbdev/hgafb.c
 delete mode 100644 include/linux/fbcon.h
