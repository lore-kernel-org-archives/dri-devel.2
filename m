Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D95606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrA1lHl4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CF010E99A;
	Sat, 21 Nov 2026 17:00:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF8710E41C
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:59:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DCD1438F2;
 Sat, 21 Nov 2026 16:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBE31F000C6;
 Sat, 21 Nov 2026 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795280395;
 bh=HxFQ2qa/MmVsd7tMIBT1v4526ip7d+VB96nm/kUeU0c=;
 h=Date:From:To:Subject;
 b=XrA1lHl4gnn2kw/Bz9DfiQwty3vdVgUUmcCpbnNE5YokCOeCyK9ut/VNAUd+/LI7F
 ny/GwGPeF9RR/9wExG7twav6NXRbpAVE9dxPYHoC5nRWVY9bQgZbN5g/3CkH2smJg5
 Tpzf8iGI/7pKH0AiQiuxl4D7IBRPe7mvJQ4hgcAddeG4J9e6bqRd+H0H/mx3gAYd8+
 CGAkSDk7YlsxZXLi0yCdMivpTQUzIquIFlm2QT8+VHu4XNE8E2fFWYqxx1S20Ry17p
 WmMcSIWogeY2Uu1Gppxt6mmwjbPSGil5+hTpKK3UJm0/Poub821WFMZtWmNGPzAhmE
 R17rjA13cn9NA==
Date: Sat, 21 Nov 2026 17:59:51 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v7.4-rc4
Message-ID: <awHOB8hdCRXVd--I@carbonx1>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Linus,

please pull some more fbdev fixes for kernel v7.4-rc4.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc4

for you to fetch changes up to b3f1631d362539cfe14571ccfd7db919ffbc08c7:

  fbdev: radeonfb: reject a zero pixclock in radeonfb_check_var() (2026-11-19 17:57:11 +0100)

----------------------------------------------------------------
fbdev fixes for 7.4-rc4:

Various small fixes, all scheduled for backport, which fix out-of-bound
accesses, improves the parameter checks or fix use-after-free accesses in
fm2fb, radeonfb, cobalt_lcdfb, valkyriefb, sstfb.
vgacon now falls back to the dummy console if mapping the VGA memory
fails, which fixes a crash on Alpha, and fix one sleep-in-atomic-context
bug which is triggered by the blinking cursor.

----------------------------------------------------------------
Jianqiang Zou (1):
      fbdev: radeonfb: reject a zero pixclock in radeonfb_check_var()

Matt Turner (1):
      vgacon: Fall back to the dummy console if mapping VGA memory fails

Miro Kropacek (1):
      fbdev: atafb: Restrict SuperVidel handling to the Falcon

Steffen A. Mork (1):
      fbdev: fm2fb: Fix iomem access

Suyuan Wang (1):
      fbdev: cobalt_lcdfb: Don't read info after framebuffer_release()

Tim Douglas (2):
      fbdev: macmodes: compare the pixel clock of each candidate mode
      fbdev: valkyriefb: keep the framebuffer mapping size fixed

Weiming Shi (1):
      fbdev: vfb: Validate framebuffer geometry and memory size

Xue Haolin (1):
      fbdev: sstfb: Error out if pixclock equals zero

Yao Yiqi (1):
      fbcon: Avoid cancel_delayed_work_sync() in atomic context

YuanZhe Liu (3):
      fbdev: smscufx: don't free registered framebuffer on probe error
      fbdev: smscufx: keep the usb_device alive while ufx_data is in use
      fbdev: smscufx: allocate the size advertised in smem_len

 drivers/video/console/vgacon.c        |  2 ++
 drivers/video/fbdev/atafb.c           | 18 ++++++++++-----
 drivers/video/fbdev/aty/radeon_base.c |  3 +++
 drivers/video/fbdev/cobalt_lcdfb.c    |  3 ++-
 drivers/video/fbdev/core/fbcon.c      | 41 ++++++++++++++++++++++++++++++-----
 drivers/video/fbdev/core/fbcon.h      |  1 +
 drivers/video/fbdev/fm2fb.c           |  2 +-
 drivers/video/fbdev/macmodes.c        |  2 +-
 drivers/video/fbdev/smscufx.c         | 26 +++++++++++++++++-----
 drivers/video/fbdev/sstfb.c           |  3 +++
 drivers/video/fbdev/valkyriefb.c      |  3 +--
 drivers/video/fbdev/vfb.c             | 18 +++++++++++++--
 12 files changed, 99 insertions(+), 23 deletions(-)
