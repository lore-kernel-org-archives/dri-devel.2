Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7758CC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D7B10F32A;
	Fri, 21 Aug 2026 15:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dmMLEt5j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7A610F32A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:52:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79B2261126;
 Fri, 21 Aug 2026 15:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C686F1F000E9;
 Fri, 21 Aug 2026 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327558;
 bh=7UmAnCQSK9yiznSJ1ZPkH/Vy/lG/hCl4RASG9HOF5ho=;
 h=Date:From:To:Subject;
 b=dmMLEt5jTgQ0+XzhzDE5SVC9Y/gH2pCQUk9SyeUfxgkQzLatTgf1lzyzixf97a2hD
 QqiKbv06fSTr4qZFry76Qfv8454B94HRswp8389d4mZlL4mep4c2FqLcxBs0XLD/Tz
 tEcNeWxYF40WA1IqgQrwCgPB/DhYed14GV2TD+Wc+3/agK2ICo3ClUQN73CdR3HDU+
 Yv93wjXpiMiQnk0dvZIRElE+DDoIpeOAAbJna836+vGeLJMgBtTKIO2YmOYR177ecp
 r6BDo7G7hsSJNjr5vxCbY1CsXXSpV7lwVWpKwApPhiMjuCArRKnns0oB8RdVWM+Y3X
 MGk4xPzJQTc4A==
Date: Fri, 21 Aug 2026 17:52:33 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v7.3-rc1
Message-ID: <aoh0QXTIQbgDjAB_@carbonx1>
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

Dear Linus,

please pull the fbdev patch collection for kernel v7.3-rc1:

The usual bunch of many small fixes in various fbdev drivers, but more
interestingly the Vodoo3/4/5 cards will now be initialized even without PC BIOS
support and vintage Atari computers gain more color depths and console
acceleration on SuperVidel's SuperBlitter chips.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc1

for you to fetch changes up to d463633d63e6aa10384683bf39971a4b00780c56:

  fbdev: atafb: Add support for SuperVidel's SuperBlitter (2026-08-21 00:02:41 +0200)

----------------------------------------------------------------
fbdev code updates for 7.3-rc1:

New features:
- tdfxfb: Allow Vodoo3/4/5 card to be initialized without PC-BIOS [Daniel Palmer]
- atafb: Add support for SuperVidel's SuperBlitter [Miro Kropacek]
- atafb: Add further video bit depths [Miro Kropacek]
- sticon/parisc: Detect default graphics card for console output [Helge Deller]

Fixes:
- kyro: Validate overlay viewport coordinates [Danila Chernetsov]
- platinumfb: add error checking for ioremap calls [BingKun Yue]
- ssd1307fb: damage callback fixes [Hui Su]
- maxine: fix 64-bit build error and code cleanups [Randy Dunlap]
- omapfb: panel-dsi-cm: initialize lock before registering display [Runyu Xiao]
- core: Clamp total_size to smem_len in read/write functions [Mingyu Wang]
- uvesafb, tdxfb: failure path cleanups [Myeonghun Pak]
- udlfb: validate DisplayLink vendor descriptor items before usage [Pengpeng Hou]

Cleanups:
- Convert multiple drivers to managed PCI and ioremap API [Shixiong Ou]
- Remove redundant dev_err() from multiple drivers [Pan Chuang]
- omap2: do not copy isr table [Andreas Kemnade]
- pvr2fb: correct user pointer annotation and sentinel initializer [Florian Fuchs]
- mb862xxfb: silence possibly unused functions [Helge Deller]
- au1100fb: drop unneeded semicolon [Julia Lawall]
- clps711x-fb: remove unreachable code [Karl Mehltretter]
- viafb: refactor strcpy call [Ajith P V]
- sstfb: add missing MODULE_DEVICE_TABLE() [Pengpeng Hou]
- mb862xx: replace dead Kconfig select with dependency [Julian Braha]

Documentation fixes:
- fonts: fixup font.h kernel-doc warnings [Randy Dunlap]

----------------------------------------------------------------
Ajith P V (1):
      fbdev: viafb: refactor strcpy and viafb_name

Andreas Kemnade (1):
      fbdev: omap2: dsi: do not copy isr table

BingKun Yue (1):
      fbdev: platinumfb: add error checking for ioremap calls

Daniel Palmer (5):
      fbdev: tdfxfb: Add helper to read config table from BIOS
      fbdev: tdfxfb: Attempt to detect if the card wasn't booted
      fbdev: tdfxfb: Manually boot unbooted cards
      fbdev: tdfxfb: Wake the VGA core before programming the CRTC
      fbdev: tdfxfb: Program the initial video mode

Danila Chernetsov (1):
      fbdev: kyro: Validate overlay viewport coordinates

Florian Fuchs (1):
      fbdev: pvr2fb: correct user pointer annotation and sentinel initializer

Helge Deller (2):
      sticon/parisc: Detect default STI graphics card for console output
      fbdev: mb862xxfb: Silence possibly unused functions

Hui Su (1):
      fbdev: ssd1307fb: defer I2C transfers from damage callbacks

Julia Lawall (1):
      fbdev: au1100fb: drop unneeded semicolon

Julian Braha (1):
      fbdev: mb862xx: replace dead select with dependency

Karl Mehltretter (1):
      fbdev: clps711x-fb: Remove unreachable unregister_framebuffer() call

Mingyu Wang (1):
      fbdev: core: Clamp total_size to smem_len in read/write functions

Miro Kropacek (3):
      fbdev: atafb: Give atafb proper parent
      fbdev: atafb: Add support for further video bit depths on atafb:external
      fbdev: atafb: Add support for SuperVidel's SuperBlitter

Myeonghun Pak (2):
      fbdev: uvesafb: unregister connector callback on init failure
      fbdev: tdfxfb: fix PCI enable cleanup with pcim_enable_device()

Pan Chuang (7):
      fbdev: mmp: Remove redundant dev_err()
      fbdev: omapfb/dsi-cm: Remove redundant dev_err()
      fbdev: pxa168fb: Remove redundant dev_err()
      fbdev: pxa3xx-gcu: Remove redundant dev_err()
      fbdev: pxafb: Remove redundant dev_err()
      fbdev: s3c-fb: Remove redundant dev_err()
      fbdev: sa1100fb: Remove redundant dev_err()

Pengpeng Hou (2):
      fbdev: sstfb: add missing MODULE_DEVICE_TABLE()
      fbdev: udlfb: validate vendor descriptor items

Randy Dunlap (6):
      fonts: fixup font.h kernel-doc warnings
      fbdev: maxine: make functions static
      fbdev: maxine: elide an unused function
      fbdev: maxine: fix 64-bit build error
      fbdev: maxine: fix maxinefb_init() return value
      fbdev: maxine: use MODULE_LICENSE() unconditionally

Runyu Xiao (1):
      fbdev: omapfb: panel-dsi-cm: initialize lock before registering display

Shixiong Ou (5):
      fbdev: aty128fb: Convert to managed PCI and ioremap API
      fbdev: nvidia: Convert to managed PCI and ioremap API
      fbdev: savage: Convert to managed PCI and ioremap API
      fbdev: matrox: Convert to managed PCI and ioremap API
      fbdev: atyfb: Convert to managed PCI and ioremap API

 drivers/video/fbdev/Kconfig                        |   3 +-
 drivers/video/fbdev/atafb.c                        | 458 +++++++++++++++++----
 drivers/video/fbdev/aty/aty128fb.c                 |  40 +-
 drivers/video/fbdev/aty/atyfb_base.c               |  47 +--
 drivers/video/fbdev/au1100fb.c                     |   2 +-
 drivers/video/fbdev/clps711x-fb.c                  |   2 -
 drivers/video/fbdev/core/fb_io_fops.c              |  16 +
 drivers/video/fbdev/core/fb_sys_fops.c             |  16 +
 drivers/video/fbdev/kyro/fbdev.c                   |  24 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |  30 +-
 drivers/video/fbdev/maxinefb.c                     |  15 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c         |   6 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |   2 -
 drivers/video/fbdev/nvidia/nvidia.c                |  19 +-
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |   8 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |   9 +-
 drivers/video/fbdev/platinumfb.c                   |  35 +-
 drivers/video/fbdev/pvr2fb.c                       |   4 +-
 drivers/video/fbdev/pxa168fb.c                     |   1 -
 drivers/video/fbdev/pxa3xx-gcu.c                   |   4 +-
 drivers/video/fbdev/pxafb.c                        |   1 -
 drivers/video/fbdev/s3c-fb.c                       |   4 +-
 drivers/video/fbdev/sa1100fb.c                     |   4 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |  16 +-
 drivers/video/fbdev/ssd1307fb.c                    |  72 +++-
 drivers/video/fbdev/sstfb.c                        |   1 +
 drivers/video/fbdev/tdfxfb.c                       | 157 ++++++-
 drivers/video/fbdev/udlfb.c                        |  22 +-
 drivers/video/fbdev/uvesafb.c                      |   2 +
 drivers/video/fbdev/via/viafbdev.c                 |   3 +-
 drivers/video/sticore.c                            |  22 +-
 include/linux/font.h                               |   4 +-
 include/video/maxinefb.h                           |   4 +-
 33 files changed, 797 insertions(+), 256 deletions(-)
