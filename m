Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C71F45A12
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 04:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7872C10E175;
	Sat, 11 Apr 2026 04:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gL0PmcWM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A5B10E175
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 04:04:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0570D42E2B;
 Sat, 11 Apr 2026 04:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA402C4CEF7;
 Sat, 11 Apr 2026 04:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775880297;
 bh=59rBxXDfX9cYFdTwkWYzDhmWqa04ncnSD+hnBsKnQQo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=gL0PmcWM1pJl5jrGkoVt8ozfcCODdXOTYJM1UvHLoMJ6SjF3CveInAE1Kjez3e8DR
 gUXYaGhNhUHm0gCCOmRe1+wqnNkBeJuNZv9LNi7Wc+C65wbw/PypTo58gM7UYo2OGb
 cunuoKxABFiAZvEutSfRRAK0ubZ5kGHPjiyXyUUOT78tcJrKpKQh796hw/vsJFK0la
 7cQntptbGsvxw0UxX4SXeWbjeYO6+M3OiJojhC7e2yz6w29+ox7pTJ9GMyhXSA1sl8
 uXB69z9T5EHI0uZKXFLBveTTzzCPU7Mrrc4rtEursgwGCRVxhNZ6oWDfNm4PM9sReg
 ocyZ9gP3we55w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FD1B3809A88; Sat, 11 Apr 2026 04:04:33 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.0 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txY3LS3UxiixDHoWkdiyM7N=mHoEAGXr3TSWeqt-zUYhg@mail.gmail.com>
References: <CAPM=9txY3LS3UxiixDHoWkdiyM7N=mHoEAGXr3TSWeqt-zUYhg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txY3LS3UxiixDHoWkdiyM7N=mHoEAGXr3TSWeqt-zUYhg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-04-11
X-PR-Tracked-Commit-Id: b3be33f2c18f7e3663d103a92cdd00b4771b4aa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c43adb3613a8b1be0396d0a38a8ab6be633d48d8
Message-Id: <177588027182.2835532.12381879395130682498.pr-tracker-bot@kernel.org>
Date: Sat, 11 Apr 2026 04:04:31 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
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

The pull request you sent on Sat, 11 Apr 2026 07:49:32 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c43adb3613a8b1be0396d0a38a8ab6be633d48d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
