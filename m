Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D136606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVvez1b1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27E110E1C5;
	Thu, 29 Oct 2026 22:31:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 992E310E1C5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 22:31:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 981CC60267;
 Thu, 29 Oct 2026 22:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E7F1F01816;
 Thu, 29 Oct 2026 22:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793313075;
 bh=kKynRfMeyd4ry1GjXZu3dfS0+scYRKXk4/JZoEI+vkU=;
 h=Date:From:To:Subject;
 b=EVvez1b1EB47sk+UJxoqVcbHFtAUFwHpjHQkAZ1wdFeImLqzg65pJPaEeo8HmtSnz
 b/yyFopSuKL+MC6cft3xMxg9psTTDdj3c/DDP5j3I1I1YFdAmxJ6w5SmYTXoftF4jb
 mp/xgTqSI8JkvfYlZMemOhGc5SkXXbzg9I0Nnhl18Fh0XoY64dytuYcjBiLRndyZrx
 wucXrav4rX9mR/iBWeBwfnmXFuGkJoPTRzmHwFhXOZGw/CoSRnNcgQaxxVpyJYn8UQ
 lL11x+aprC9ybaznHlMbIAED344QLuM4GsewRi52l5IU53QKfhUetKTodS68tm82Ul
 MwHg9f+gO89jA==
Date: Thu, 29 Oct 2026 23:31:09 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] more fbdev fixes and updates for v7.4-rc1
Message-ID: <auPJLXQdFRtkoOCu@carbonx1>
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
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Linus,

please pull some more fbdev fixes and cleanups for kernel v7.4-rc1:

Simplify console blanking and one fix for a potential initialization
issue in atmel_lcdfb.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 21a7f44fd0765fcc5194130b28767786eba1d1e7:

  Merge tag 'devicetree-for-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2026-10-24 20:11:23 -1000)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1-2

for you to fetch changes up to 01d1204582f16e8b7bfce29648e5cf77a585d962:

  fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe (2026-10-25 08:57:27 +0100)

----------------------------------------------------------------
more fbdev fixes and cleanups for 7.4-rc1:

- atmel_lcdfb: avoid issues due to empty modelist in probe
- simplify the console-blanking interface

----------------------------------------------------------------
Thomas Zimmermann (7):
      vt: Add con_unblank callback to struct consw
      dummycon: Implement struct consw.con_unblank
      fbcon: Implement struct consw.con_unblank
      newport_con: Implement struct consw.con_unblank
      sticon: Implement struct consw.con_unblank
      vgacon: Implement struct consw.con_unblank
      vt: Remove old-style con_blank

Wang Haoran (1):
      fbdev: atmel_lcdfb: fix list_first_entry() on possibly empty modelist in probe

 drivers/tty/vt/vt.c                 | 11 ++++----
 drivers/video/console/dummycon.c    | 12 ++++++++
 drivers/video/console/newport_con.c | 24 ++++++++--------
 drivers/video/console/sticon.c      | 20 ++++++++------
 drivers/video/console/vgacon.c      | 46 +++++++++++++++++--------------
 drivers/video/fbdev/atmel_lcdfb.c   | 13 +++++++--
 drivers/video/fbdev/core/fbcon.c    | 55 +++++++++++++++++++++++++------------
 include/linux/console.h             | 10 +++++--
 8 files changed, 124 insertions(+), 67 deletions(-)
