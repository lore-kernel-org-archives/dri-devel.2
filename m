Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D924F94CA2
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DCB10EDFE;
	Wed, 22 Apr 2026 00:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pa1B8KsF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F6010EDFE
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:45:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 13A3460018;
 Wed, 22 Apr 2026 00:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFA1C2BCB0;
 Wed, 22 Apr 2026 00:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776818729;
 bh=0+lD1M+dekh11zqg5ftYA0my+o6aHPds9ommVvlpxME=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Pa1B8KsF1/OFh+zqP68OP7bfSmq3BPNHJ0Y/ZdLtwWlwdqYhgLVL/+7v6+6NVQFUi
 Ng1u0NnsSJvBkqYUQO50xh2JNvhNyw3iILueGOxx0q5vmezH0teQwQYvUlMfkYHCxW
 uVXSMwngzPU7eMeXmJdpi66XpqO8E619wS0qkCz3zTVPGUVqHChNg5KYXA/5XE6E0e
 LrngNkzng5SoScSWeMSNNA3C3hPS0sPCD9fuM/dxqccAYCnx2ZXOjXBgHY6d1RK0An
 nXxy+2tyLQ2gY/x7DCJLH/R7bXmNpTqw3X9ux7Aowm2Q/SRwvAtM5A91UPuX4uFkCG
 +j0Wd42KU+8HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1D36D3930018; Wed, 22 Apr 2026 00:44:54 +0000 (UTC)
Subject: Re: [git pull] drm for 7.1-rc1 (part two again...)
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyROdmL71Qe+2gLbCEogPDFwLyHhkUoW3H3tfKsKK4qMw@mail.gmail.com>
References: <CAPM=9tyROdmL71Qe+2gLbCEogPDFwLyHhkUoW3H3tfKsKK4qMw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyROdmL71Qe+2gLbCEogPDFwLyHhkUoW3H3tfKsKK4qMw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-04-22
X-PR-Tracked-Commit-Id: a7756371e57f69a137f295a418fb56f15ff2c10f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6596a02b207886e9e00bb0161c7fd59fea53c081
Message-Id: <177681869283.3068898.17285631486094948192.pr-tracker-bot@kernel.org>
Date: Wed, 22 Apr 2026 00:44:52 +0000
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

The pull request you sent on Wed, 22 Apr 2026 07:50:35 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-04-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6596a02b207886e9e00bb0161c7fd59fea53c081

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
