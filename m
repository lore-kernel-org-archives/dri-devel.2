Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46357CD98CF
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 00:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7463510E728;
	Sat, 13 Jun 2026 00:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OzXDcYgt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B33C10E728
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 00:55:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34C894095B;
 Sat, 13 Jun 2026 00:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F611F000E9;
 Sat, 13 Jun 2026 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781312145;
 bh=8eDS5x8qEvQ1BGyRWxttMIoyL3CwuR9WwCwXJqq8C4s=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=OzXDcYgtZGUAXpZDGfQgcVAHl1Hp4mFYzNzJ7ZM6ZtP2QfKWQWOnChaIOXsTsYgzg
 izMvrBgBjyILlwYd3N5i6z9y7GA7e6mGziR1Ehi9il+tdb5RLvuOoIi3RfNG/0W/nA
 n2RFGCdkWfOeuJxgciclZl2hjOMsk+UZKMvRkUb+wieD4unhVVszjAueiJo7PiBDyj
 dfptkUd40nzjYZCYZCyFsXhrk6KWnd7nU3pNWDRlB64vj9xLftZn8jVHYV7vhtwsbL
 Yz2VVIx9Ft4hde0KJiY9+Li8hapk1AeYWJb+9HtzDC+F6KS1J84cwoLGm2gWxZj4p7
 B4ZSGPuze/U8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D14EB39E9609; Sat, 13 Jun 2026 00:55:42 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.1-rc8/final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twRD5OAYencEyAtjTq7uqWek9C2CcrWrV1Bmtz8EpJFcA@mail.gmail.com>
References: <CAPM=9twRD5OAYencEyAtjTq7uqWek9C2CcrWrV1Bmtz8EpJFcA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twRD5OAYencEyAtjTq7uqWek9C2CcrWrV1Bmtz8EpJFcA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-06-13
X-PR-Tracked-Commit-Id: 7c62657a10625e4e113de248d41f543d5a2f3a1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fa048ed72531d6c2a2147fa9b52b6a5451213a2
Message-Id: <178131214247.1313529.3598595060713954755.pr-tracker-bot@kernel.org>
Date: Sat, 13 Jun 2026 00:55:42 +0000
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

The pull request you sent on Sat, 13 Jun 2026 08:17:04 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-06-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fa048ed72531d6c2a2147fa9b52b6a5451213a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
