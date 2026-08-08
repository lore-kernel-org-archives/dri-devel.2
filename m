Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CE7C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02CB10E1B3;
	Sat,  8 Aug 2026 13:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kJMd9i9P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489E310E1B3
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:50:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 716E960054;
 Sat,  8 Aug 2026 13:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C853C1F000E9;
 Sat,  8 Aug 2026 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786197027;
 bh=3zxx3/PzGwASfboZ9qvWP2qPW71D1PeGodgREbdfyV0=;
 h=Date:From:To:Subject;
 b=kJMd9i9PdZRXVQzMMeLTNSmjm/F0485RN+i1aVWNghmTI5yzQJPGNxEyGPIZM9jJA
 maA/DNy3g4XzGkVnHZo+so2Myai0f5JTkZFk31USfOX8jnJUPOB8SxQc9MnHVrlvKg
 R2v7Rx3q5J5mprgBGcU6RqsX0pWQscNVDmeD5O1oyr2F0My2lC7GOAiUCAMfRo7KOK
 t1c0CTS9JZ1UawZMOh7Zo/16lYHsjLFjwNUi8KAUBBUUhXYTeCy1+Ep7/h/uk+msa9
 KPtDbj5hsXg91kOubrl5F8srDzHA+dorERetv4zDDTSpKUhPO6ESuWe4pKxiFrtr2x
 6+pCwbs48Azhg==
Date: Sat, 8 Aug 2026 15:50:22 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v7.2-rc7
Message-ID: <anc0HhpSwT_c7CTg@carbonx1>
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

please pull a few important fixes for the core fbdev layer for kernel v7-2-rc7.
All patches are tagged for stable, and most of them have been in for-next
for some weeks.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc7

for you to fetch changes up to e033cbf3975a8465f879ebd5989dc35b04423a4d:

  fbdev: bitblit: bound-check glyph index in bit_cursor() (2026-08-08 08:08:58 +0200)

----------------------------------------------------------------
fbdev core fixes for 7.2-rc7:

A few patches for the core fbdev layer which stabilize or fix potential
issues with text font rendering after screen rotation or after user
initiated font changes and locking fixes for sysfb during modifications
of the graphics mode database.

----------------------------------------------------------------
Melbin K Mathew (3):
      fbdev: bound mode sysfs output to the sysfs buffer
      fbdev: clear fb_info->mode before deleting a videomode
      fbdev: serialize mode sysfs access with lock_fb_info()

Mingyu Wang (1):
      fbdev: core: Fix pointer desynchronization in fb_io_read()

Rik van Riel (1):
      fbdev: bitblit: bound-check glyph index in bit_cursor()

Zizhi Wo (1):
      fbdev: Fix out-of-bounds access when rotating console after font resize

 drivers/video/fbdev/core/bitblit.c    |  9 ++++--
 drivers/video/fbdev/core/fb_io_fops.c |  8 +++++
 drivers/video/fbdev/core/fbcon.c      | 25 +++++++++++++++
 drivers/video/fbdev/core/fbmem.c      |  5 ++-
 drivers/video/fbdev/core/fbsysfs.c    | 59 ++++++++++++++++++++++++++++-------
 5 files changed, 91 insertions(+), 15 deletions(-)
