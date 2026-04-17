Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF26F99C6B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 22:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F50010E2D4;
	Fri, 17 Apr 2026 22:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oJ0QIv2f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDEC10E2D4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:11:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 43A5943C5C;
 Fri, 17 Apr 2026 22:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3C8C19425;
 Fri, 17 Apr 2026 22:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776463891;
 bh=6Fli4/VKP9q0FZ0Kj648hFZAkrByt4FnatbFTAhvO/s=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=oJ0QIv2f3jSQb/mN1Xm/aAoiqgUYAG1Clesw2o9vgZ61OGBbeIqdV71olFFmh/ai3
 rhcRQn+Nu9TwoOrmuL03kf3OTBLy4YWiuIrNqUJcS/B3w0f71YU9QBpu1QVVOpeAZ/
 nnsGKmQAjOCk5XHb+gCmWFe/QCPQWvf2Y4rmPKW5u1QtH9caFVewI78UjvEHECmrqw
 gDmfEwElu+j8/ryO8HXmfehxvCYvVqcqwPBKVFtBroNwA64BuWEpyfc1L3JNmzlU/L
 A5dOl4D5ng6q/EyKOTKOzNUGrS2S9TiE1o68kFpTDnlJsDU2oHl/nxMdKXOhJsfW33
 lowiqaZel0yjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7F8F5380CEEC; Fri, 17 Apr 2026 22:10:59 +0000 (UTC)
Subject: Re: [git pull] drm for v7.1-rc1 (part two)
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
References: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-04-18
X-PR-Tracked-Commit-Id: 028ef9c96e96197026887c0f092424679298aae8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5e581093b1d9321cbb627dd8c209d0d4e0a988a
Message-Id: <177646385801.174807.17355005588662180189.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 22:10:58 +0000
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

The pull request you sent on Sat, 18 Apr 2026 08:07:52 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5e581093b1d9321cbb627dd8c209d0d4e0a988a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
