Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C922FED3FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 20:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2103110E011;
	Fri, 24 Apr 2026 20:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rY/d6uTR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6754A10E011
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:37:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DBC442A08;
 Fri, 24 Apr 2026 20:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D24C2BCB0;
 Fri, 24 Apr 2026 20:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777063071;
 bh=5aNKRW3IA98Fmqf/gGTA1ueKDwOhWuxHxN9Dcs74koc=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=rY/d6uTRXF+4eglztOb9ZUOH26lipSx4u5HNafAUNn8lBRwU32k+9hbh6rIBW2rTY
 BxRlo+ELdazmNUpNVSnMCdAcOJVAlMM2xNpaphHn9G3Jhxnbf5TSq6kzjUW/gnNFHd
 J5FxFktbzuXFByEWPWrVTiqtG9j2hYTcgGGnoPI51nsgiGKJcTgeZkxKnp3J7qJPtZ
 lrZsRToLFyB/HZgS0sKOzKrvACJ6gBXWggjRIdwU9mi2qPf6OVWuRVuPCjeztKOc0X
 7LA555V89yJ3tZFmWRlPO52laedFFxii1wNcJpbaqxDZX9/4ToxRRFb9x5RY8RLdQZ
 qsoxnrZsVulHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7CF4938119C3; Fri, 24 Apr 2026 20:37:12 +0000 (UTC)
Subject: Re: [git pull] drm next fixes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txGwneUzw-Qv2P1yy9jAqJssAdm+0-5C2yL=cDm-_SJOg@mail.gmail.com>
References: <CAPM=9txGwneUzw-Qv2P1yy9jAqJssAdm+0-5C2yL=cDm-_SJOg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txGwneUzw-Qv2P1yy9jAqJssAdm+0-5C2yL=cDm-_SJOg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-04-24
X-PR-Tracked-Commit-Id: e49712ef03dbc4e282dd0e76469642279c2811e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92c4c9fdc838d3b41a996bb700ea64b9e78fc7ea
Message-Id: <177706303113.1703875.4326585826637400901.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 20:37:11 +0000
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

The pull request you sent on Fri, 24 Apr 2026 16:05:38 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92c4c9fdc838d3b41a996bb700ea64b9e78fc7ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
