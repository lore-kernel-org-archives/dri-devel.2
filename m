Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DFFED3FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 20:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC5810E057;
	Fri, 24 Apr 2026 20:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d5TczMLt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74BE10E011
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:37:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BFA1942E0C;
 Fri, 24 Apr 2026 20:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C05C2BCB6;
 Fri, 24 Apr 2026 20:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777063072;
 bh=2iYIFjvdwueCbldFU5YVo9LbBogzHjQ1S7d81wt807g=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=d5TczMLt5o61noPPHDn+LEik7LL6bHWle9e5AiJhUVpUQ8wzSUG3Eoz1I9cYg3V9U
 IAgeaCw+XUVsovpuKNpabgkrAhWwEj16DOZPEKJN03PuaUvMwPcFSAnjzglDLdQ8Pg
 0T6Cvu14bNQOpqPRrCV4IiFuYn2eZyZdPooMWGlxpifgC0QeILNbBp/xjorSCPsjH0
 HI+PGSIsLc6NakHJnhtWDQmr96lEFtjGMx9vhB1ovqM3I2zZot5DuGvRdvMTeKxqs/
 wqgXFSmdhwNgGeHK2rKlZXN4R63ozJnTKkiFZtQz5/797+i5gYhWx67UsmyV7s/s35
 OifZ43iv4bG7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FCBA38119C3; Fri, 24 Apr 2026 20:37:14 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twXGyOZMh2k20wFnVXH5tpbX8DRhNRv6rMBw1oMyPoQ_g@mail.gmail.com>
References: <CAPM=9twXGyOZMh2k20wFnVXH5tpbX8DRhNRv6rMBw1oMyPoQ_g@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twXGyOZMh2k20wFnVXH5tpbX8DRhNRv6rMBw1oMyPoQ_g@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-04-24
X-PR-Tracked-Commit-Id: 56d0a0b38faa13836568d425f6ea806e27f3a69e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf950766e96e36c90871d955cfd2a2c1feddba37
Message-Id: <177706303274.1703875.14195108363337550474.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 20:37:12 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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

The pull request you sent on Fri, 24 Apr 2026 16:11:23 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf950766e96e36c90871d955cfd2a2c1feddba37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
