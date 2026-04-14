Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612ABF9D0DA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D3710E0AE;
	Tue, 14 Apr 2026 16:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iO5IumJi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59EE10E0AE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:10:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7699C43D86;
 Tue, 14 Apr 2026 16:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD75C19425;
 Tue, 14 Apr 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776183004;
 bh=1za778zNO3OO7HMnjD8+sUjWeHTYGwcTBA90LnV48/8=;
 h=Date:From:To:Cc:Subject:From;
 b=iO5IumJi9pXaDjiONnanzDjwKQvq9bL9FHhjajZcUvRNvB9RWf66icUllEJ/Rx2nA
 w0kPB6gDwIcfUnEfNb/7ZAoWplVpQXqrxL0oW5xguJ5JTvsSE8bccCF6umE3OOOjG7
 p3Ee1Qgf0zdMzmHn1W78nFvxgix+fmrgscBhW/Y8dLpXzmpMUisrWzZWhPGrx4hHy4
 E9MxJ11dpiWnXErqFPjIYmil1WH008K193Zo0yfGCw7khP3iu0uEsYnVq8JmpP1gax
 jNuCaNlzbj3PVY1VLztEZVuNSBPSH1W7SxiugtUb8YAiU00D+QR6DSxkN+SMz/x05T
 RVQ5Xk+M7seQw==
Date: Tue, 14 Apr 2026 18:09:59 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [GIT PULL] fbdev fixes and updates for v7.1-rc1
Message-ID: <ad5m1zGyRSJFwoC8@carbonx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

please pull fixes and updates for fbdev for kernel 7.1-rc1.

A major refactorization regarding console font handling and the usual
smaller fixes and cleanups.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1

for you to fetch changes up to a31e4518bec70333a0a98f2946a12b53b45fe5b9:

  fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO (2026-04-10 16:54:38 +0200)

----------------------------------------------------------------
fbdev fixes & cleanups for 7.1-rc1:

A major refactorization by Thomas Zimmermann from SUSE regarding handling of
console font data, addition of helpers for console font rotation and split into
individual components for glyphs, fonts and the overall fbcon state.

And there is the round of usual code cleanups and fixes:

Cleanups:
- atyfb: Remove unused fb_list [Geert Uytterhoeven]
- goldfishfb, wmt_ge_rops: use devm_platform_ioremap_resource() [Amin GATTOUT]
- matroxfb: Mark variable with __maybe_unused [Andy Shevchenko]
- omapfb: Add missing error check for clk_get() [Chen Ni]
- tdfxfb: Make the VGA register initialisation a bit more obvious [Daniel Palmer]
- macfb: Replace deprecated strcpy with strscpy [Thorsten Blum]

Fixes:
- tdfxfb, udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO [Greg Kroah-Hartman]
- omap2: fix inconsistent lock returns in omapfb_mmap [Hongling Zeng]
- viafb: check ioremap return value in viafb_lcd_get_mobile_state [Wang Jun]

----------------------------------------------------------------
Amin GATTOUT (2):
      fbdev: goldfishfb: use devm_platform_ioremap_resource()
      fbdev: wmt_ge_rops: use devm_platform_ioremap_resource()

Andy Shevchenko (1):
      fbdev: matroxfb: Mark variable with __maybe_unused to avoid W=1 build break

Chen Ni (1):
      fbdev: omapfb: Add missing error check for clk_get()

Daniel Palmer (1):
      fbdev: tdfxfb: Make the VGA register initialisation a bit more obvious

Geert Uytterhoeven (1):
      fbdev: atyfb: Remove unused fb_list

Greg Kroah-Hartman (2):
      fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO

Hongling Zeng (1):
      fbdev: omap2: fix inconsistent lock returns in omapfb_mmap

Thomas Zimmermann (28):
      fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info
      fbdev: defio: Keep module reference from VMAs
      fbdev: defio: Move variable state into struct fb_deferred_io_state
      fbdev: defio: Move pageref array to struct fb_deferred_io_state
      fbdev: Declare src parameter of fb_pad_ helpers as constant
      vt: Remove trailing whitespaces
      vt: Store font in struct vc_font
      vt: Calculate font-buffer size with vc_font_size()
      lib/fonts: Remove trailing whitespaces
      lib/fonts: Remove FNTCHARCNT()
      lib/fonts: Store font data as font_data_t; update consoles
      lib/fonts: Read font size with font_data_size()
      lib/fonts: Manage font-data lifetime with font_data_get/_put()
      lib/fonts: Compare font data for equality with font_data_is_equal()
      lib/fonts: Create font_data_t from struct console_font with font_data_import()
      lib/fonts: Store font data for user space with font_data_export()
      lib/fonts: Remove internal symbols and macros from public header file
      fbcon: Avoid OOB font access if console rotation fails
      vt: Implement helpers for struct vc_font in source file
      lib/fonts: Provide helpers for calculating glyph pitch and size
      lib/fonts: Clean up Makefile
      lib/fonts: Implement glyph rotation
      lib/fonts: Refactor glyph-pattern helpers
      lib/fonts: Refactor glyph-rotation helpers
      lib/fonts: Implement font rotation
      fbcon: Fill cursor mask in helper function
      fbcon: Put font-rotation state into separate struct
      MAINTAINERS: Add dedicated entry for fbcon

Thorsten Blum (1):
      fbdev: macfb: Replace deprecated strcpy with strscpy

Wang Jun (1):
      fbdev: viafb: check ioremap return value in viafb_lcd_get_mobile_state

robgithub (1):
      fbdev: update help text for CONFIG_FB_NVIDIA

 MAINTAINERS                                    |  23 +++
 drivers/tty/vt/vt.c                            |  34 +++
 drivers/video/console/newport_con.c            |  61 ++----
 drivers/video/fbdev/Kconfig                    |  10 +-
 drivers/video/fbdev/aty/atyfb_base.c           |   4 -
 drivers/video/fbdev/core/bitblit.c             |  46 +----
 drivers/video/fbdev/core/fb_defio.c            | 266 +++++++++++++++++-------
 drivers/video/fbdev/core/fbcon.c               | 242 +++++++++-------------
 drivers/video/fbdev/core/fbcon.h               |  18 +-
 drivers/video/fbdev/core/fbcon_ccw.c           |  70 ++-----
 drivers/video/fbdev/core/fbcon_cw.c            |  70 ++-----
 drivers/video/fbdev/core/fbcon_rotate.c        |  88 +++-----
 drivers/video/fbdev/core/fbcon_rotate.h        |  71 -------
 drivers/video/fbdev/core/fbcon_ud.c            |  67 ++----
 drivers/video/fbdev/core/fbmem.c               |   6 +-
 drivers/video/fbdev/goldfishfb.c               |  14 +-
 drivers/video/fbdev/macfb.c                    |  38 ++--
 drivers/video/fbdev/matrox/g450_pll.c          |   2 +-
 drivers/video/fbdev/omap/hwa742.c              |   4 +
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c |   2 +-
 drivers/video/fbdev/tdfxfb.c                   | 112 +++++-----
 drivers/video/fbdev/udlfb.c                    |   3 +
 drivers/video/fbdev/via/lcd.c                  |   3 +
 drivers/video/fbdev/wmt_ge_rops.c              |  18 +-
 include/linux/console_struct.h                 |  33 ++-
 include/linux/fb.h                             |  19 +-
 include/linux/font.h                           | 166 +++++++++++----
 lib/fonts/Makefile                             |  36 ++--
 lib/fonts/font.h                               |  38 ++++
 lib/fonts/font_10x18.c                         |   2 +-
 lib/fonts/font_6x10.c                          |   3 +-
 lib/fonts/font_6x11.c                          |   2 +-
 lib/fonts/font_6x8.c                           |   3 +-
 lib/fonts/font_7x14.c                          |   2 +-
 lib/fonts/font_8x16.c                          |   3 +-
 lib/fonts/font_8x8.c                           |   2 +-
 lib/fonts/font_acorn_8x8.c                     |   4 +-
 lib/fonts/font_mini_4x6.c                      |  10 +-
 lib/fonts/font_pearl_8x8.c                     |   2 +-
 lib/fonts/font_rotate.c                        | 275 +++++++++++++++++++++++++
 lib/fonts/font_sun12x22.c                      |   3 +-
 lib/fonts/font_sun8x16.c                       |   3 +-
 lib/fonts/font_ter10x18.c                      |   4 +-
 lib/fonts/font_ter16x32.c                      |   4 +-
 lib/fonts/fonts.c                              | 232 ++++++++++++++++++++-
 45 files changed, 1328 insertions(+), 790 deletions(-)
 create mode 100644 lib/fonts/font.h
 create mode 100644 lib/fonts/font_rotate.c
