Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA50BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 17:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0DC210E023;
	Sat, 27 Jun 2026 17:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TgKDEKhw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D80810E023
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 17:50:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D97D6001A;
 Sat, 27 Jun 2026 17:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2991F000E9;
 Sat, 27 Jun 2026 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782582628;
 bh=TcA5077Fg50GxF9pJDTFxugH2HQC+j8KYXX8dfnXUk8=;
 h=Date:From:To:Subject;
 b=TgKDEKhwZXMypoWehkfq4m2pnu9/J8xbiENBChcSGfSenc1bAfNuGmOd4InvrsUUu
 NEAMC3PTD0pZv0TFRiE7XuiTE2jLQtjVl73aX+F7pNNRxOaSohmF11NOP3HQxl+Mbd
 8ZnCoflT3TzSe6DM8dKFWypDmtP6f4EYndGpy99C15QOXViQ6N/BMIjIy700K6qX/9
 iRygKczHBzNTSarmpLKhqZ9Xk5jAmRjEtaQ7zfV4+6vCJUqZI6sGCMIQ+oCz9iZ4e3
 VjUFD/VJd41k8uZSD0VNJPkhhHr7Bkqkoi+CO95sBl4n597Hx5uaeZOFsYJFz9WFqD
 /irQDOPbxllCg==
Date: Sat, 27 Jun 2026 19:50:23 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] additional fbdev fixes and updates for v7.2-rc1
Message-ID: <akANXx5Fr4vBRhwg@carbonx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
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

please pull the second half of fbdev fixes for this merge window:

Two patches for generic fbdev & fbcon code which fixes the handling of
modelists and prevents a potential NULL ptr dereference in the console code.

Five patches fix various missed cleanups in the error path of various fbdev
drivers.

And Uwe Kleine-König contributed one cleanup patch to use named initializers
in the vga16fb driver.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit 4708cac0e22cfd217f48f7cec3c35e5922efcccd:

  Merge tag 'staging-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging (2026-06-22 12:43:16 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc1-2

for you to fetch changes up to 7f08fc10fa3d3366dc3af723970bd03d7d6d10e3:

  fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var (2026-06-26 15:12:45 +0200)

----------------------------------------------------------------
additional fbdev fixes & cleanups for 7.2-rc1:

Fixes:
- fbcon: fix NULL pointer dereference for a console without vc_data [Ian Bridges]
- fbdev: fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var [Ian Bridges]

Fixes in failure paths:
- pm2fb: unwind write-cache setting on probe failure [Haoxiang Li]
- goldfishfb: fail pan display on base-update timeout [Pengpeng Hou]
- viafb: return error on DMA copy time-out [Pengpeng Hou]
- fbcon: fix out-of-bounds read in error path of fbcon_do_set_font() [Mingyu Wang]
- fbdev: fix modelist use-after-free in store_modes() [Ian Bridges]

Code cleanup:
- vga16fb: clean up platform_device_id table [Uwe Kleine-König]

----------------------------------------------------------------
Haoxiang Li (1):
      fbdev: pm2fb: unwind WC setup on probe failure

Ian Bridges (3):
      fbdev: fix use-after-free in store_modes()
      fbcon: fix NULL pointer dereference for a console without vc_data
      fbdev: Fix fb_new_modelist to prevent null-ptr-deref in fb_videomode_to_var

Mingyu Wang (1):
      fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()

Pengpeng Hou (2):
      fbdev: goldfishfb: fail pan display on base-update timeout
      fbdev: viafb: return an error when DMA copy times out

Uwe Kleine-König (1):
      fbdev: vga16fb: Drop unused assignment of platform_device_id driver data

 drivers/video/fbdev/core/fbcon.c   | 14 +++++++++++---
 drivers/video/fbdev/core/fbmem.c   | 12 ++++++++++++
 drivers/video/fbdev/core/fbsysfs.c | 10 +++++++++-
 drivers/video/fbdev/goldfishfb.c   | 13 +++++++++----
 drivers/video/fbdev/pm2fb.c        |  1 +
 drivers/video/fbdev/vga16fb.c      |  4 ++--
 drivers/video/fbdev/via/via-core.c |  7 +++++--
 7 files changed, 49 insertions(+), 12 deletions(-)
