Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06221C624DB
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 03:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206BC10E1A6;
	Sun,  6 Sep 2026 03:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EhxabHLE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397B810E1A6
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 03:52:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0350E417C6;
 Sun,  6 Sep 2026 03:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB891F00A3A;
 Sun,  6 Sep 2026 03:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788666740;
 bh=R2nPnXC2ajLzr4IbYwpXX1FqJlbrGMpt9Vngky1idUk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=EhxabHLELmiOpDFywTv+iqMxmnVyyfqBu0xzV20ar1FJybfEXVa80G8nFRkgeaY8f
 E/TJJUAPmVZK3lb/C/bv+xcmD3OHx3kFhloKXRgeTLi8SkwX70GGg54uBrQIjxoo+A
 SG89hLW0QFuEzncIABBiyPMw6jlUx1RnqdwTi8waqTCGhj6ZxGchP+LWjR9Ue5YBbB
 5aQR/T8t1O18nND0GOP0Tz8pNII6XCXhKwX1XyBC/MucI8pzHFrsiR5r2Tdvn7VgZn
 /S1l9nvjVPIEJ7NoqbnHqQFfZEMz8/Vi3PkEOFBATtncx/QvbTpbdetfvelIEP8yIA
 zHM6WZfR5zKsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 199E139253CE; Sun,  6 Sep 2026 03:51:22 +0000 (UTC)
Subject: Re: [GIT PULL] kmalloc_obj() conversions for v7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <202609042302.CE61BD262@keescook>
References: <202609042302.CE61BD262@keescook>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <202609042302.CE61BD262@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/kmalloc_obj-v7.3-rc2
X-PR-Tracked-Commit-Id: 3a2c4d55e32ad65efebdb6de44eef3bfa08bb49d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fc5a74b108fc90951890ec513ac81869f5eaff1
Message-Id: <178866668057.1434849.11544433788861142262.pr-tracker-bot@kernel.org>
Date: Sun, 06 Sep 2026 03:51:20 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Kees Cook <kees+treewide@kernel.org>, Manuel Ebner <manuelebnerli@mailbox.org>
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

The pull request you sent on Fri, 4 Sep 2026 23:13:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kmalloc_obj-v7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fc5a74b108fc90951890ec513ac81869f5eaff1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
