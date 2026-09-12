Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F25C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DD110E68D;
	Sat, 12 Sep 2026 08:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ihVIE7g7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7379410E68D
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:48:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BFC3406AE;
 Sat, 12 Sep 2026 08:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FF1F000FF;
 Sat, 12 Sep 2026 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202883;
 bh=1tk0qknEtL6ahZxQ81GjoFnTdvhRjcdA5JX5kHRZR5c=;
 h=Date:From:To:Subject;
 b=ihVIE7g7ZswI7UU3BZYJfXTIikxYRg/6sTnZ4kyPmlp4HeU8p/i1LabyK0lEFVLP/
 WmK81HJD5QK1DYd9LZQ3i5Sv7bXmDJgp6WnMRzDdhSpSBF5CD0nOBl0NVXAIuoqawP
 LIgb8Pr85daKhA9+Sssg2ltlrpNHJCwAS8qlYW2H6D3DKbDXGWoCRdtWgWUOQ5c2P/
 Fji+9pUVL+xXfyhXEhStqtS/dm0vB/Rd4k8OfpnznPm/OuzfQjwGH3ecySKFMK4Bxm
 SbLd6B8j1dM9jj6Az4iHpFzrjvSi9JhpoonMlYt7tIfXPrq/gxaoKN+v4INkINYPCB
 Sgi/prmxg0A/Q==
Date: Sat, 12 Sep 2026 10:47:58 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v7.3-rc3
Message-ID: <aqURvm8xf2oDLypa@carbonx1>
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

please pull a few fbdev fixes for kernel v7.3-rc3:

Two patches for VT core code and fbcon prevent potential out-of-bounds
reads on font or screen size changes, one fix limits the Superblitter in
atafb to supported modes only, and some minor fixes for vfb, ssd1307fb
and omapfb.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 26260251022fbc2f248a3d747a9b2b961b18d2d8:

  Merge tag 'livepatching-for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching (2026-08-21 13:11:56 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc3

for you to fetch changes up to a0a34a40ed299c9c7cff6af163a5b883ee9d6d73:

  fbdev: vfb: defer cleanup until the last reference (2026-09-10 22:52:02 +0200)

----------------------------------------------------------------
fbdev fixes for 7.3-rc3:

- vt core: prevent potential out of bounds read on font change
- fbcon: prevent out of bounds read when logo bigger than screen
- atafb: limit SuperBlitter operations to supported layouts only
- vfb: fix driver removal cleanup sequence
- ssd1307fb: fix possible NULL pointer dereference on missing match data
- omapfb: Fix sparse warning in panel_enabled()

----------------------------------------------------------------
Helge Deller (3):
      vt: hide cursor prior to font changes to avoid out-of-bound reads
      fbdev: omapfb: Fix __be32 sparse warning in panel_enabled()
      fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_prepare_logo

Linmao Li (1):
      fbdev: atafb: Restrict SuperBlitter to supported formats

Weiming Shi (1):
      fbdev: vfb: defer cleanup until the last reference

Yang Zi (1):
      fbdev: ssd1307fb: fix NULL pointer dereference on missing match data

 drivers/tty/vt/vt.c                                           |  9 +++++----
 drivers/video/fbdev/atafb.c                                   |  6 +++++-
 drivers/video/fbdev/core/fbcon.c                              |  7 +++++++
 .../video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c  |  5 +++--
 drivers/video/fbdev/ssd1307fb.c                               |  4 ++++
 drivers/video/fbdev/vfb.c                                     | 11 ++++++++---
 6 files changed, 32 insertions(+), 10 deletions(-)
