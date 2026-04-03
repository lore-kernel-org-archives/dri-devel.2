Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB6BE85389
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 19:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5A410E121;
	Fri,  3 Apr 2026 19:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kUlM7EhH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C1910E121
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 19:52:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DEA1600CB;
 Fri,  3 Apr 2026 19:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0262C4CEF7;
 Fri,  3 Apr 2026 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775245965;
 bh=qCQySB0SCjS+YBVi9bki1b+wHG0OXtdM1hhmcA9QdS0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=kUlM7EhHM/iBDB3qVOrpwrrbjPSEAA34rwOwpuBluudSntU2mqnC9vS1tzZ3rpXQq
 XbGRBANfw2z1cKSJi/f4payhKICKUxsBrUiDuykFqjCYnDc5MFmB8ytWSe82ns3Eq5
 t87AXi9CWCG0kMvcz4qtPW2ntWqyjnxdRNUZX6b7uuPDQhbrwthBZNmfbwxkY5czsI
 CdqINQuG7+nqi/4UlGnM+XSG8+CsRCCkmO7EpTjChYb6Y12OSrun65/sxRf62iRifn
 MEdn8T1SaMNTK3e0Mm9DqgIO7ZrnyFfauS1UpCk4YwPoOOHWm7S+lgXkR1TDJbveT+
 yFT5XQjQEZZOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 9CBD23809A14; Fri,  3 Apr 2026 19:52:28 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyDYx6BAWV_KzJJ2h3LfxvmNgBj0DqV4qfEz7XvChVjaA@mail.gmail.com>
References: <CAPM=9tyDYx6BAWV_KzJJ2h3LfxvmNgBj0DqV4qfEz7XvChVjaA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyDYx6BAWV_KzJJ2h3LfxvmNgBj0DqV4qfEz7XvChVjaA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-04-03
X-PR-Tracked-Commit-Id: 75f53c4b2dbca831bf91e9befe06c9ad58f29352
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60d9212c6932376a337507b20fc45b2c2785b5ac
Message-Id: <177524594734.1431632.4101716344432339794.pr-tracker-bot@kernel.org>
Date: Fri, 03 Apr 2026 19:52:27 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>,
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

The pull request you sent on Fri, 3 Apr 2026 19:32:38 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60d9212c6932376a337507b20fc45b2c2785b5ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
