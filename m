Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F4606A31E
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbwTPt+3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9445210E0AD;
	Sat, 28 Nov 2026 02:56:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA2510E0AD
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:56:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1EC4A4515C;
 Sat, 28 Nov 2026 02:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0244E1F00893;
 Sat, 28 Nov 2026 02:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795834595;
 bh=ELNJWFrp6A2ceYEBWbEQ7UunFlfCLSDDrYpDdL891Xs=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=UbwTPt+3Q8dmpLPqzt6hFWFIReTZempSpDftH6UvUGlbpoPC1eyhr37C0qqSQA+rr
 W1gFoDO7keuEXUr8ceAtpnErnAU6P6eYUCpLIhxctPggcBeSSiIrCZCWIyQ9m658cv
 cTACXAn+1fX4kNeGh3hxNgXAJw5z8wdqzbKSrjXEg1ae//0mh9qqfwEQankWBv2WL9
 i4hJe9Q59XJoNKlXw1nuLIf7/aT0UXVjWOUxQmv9XhAehUfKinOnseYRnZwXhXf4hs
 EMWBl7jxqgNluo/jRk133LYPp4Dpi/eHm9G8SPJ03507yju1EY6M844atb34mjxOH7
 uCKk3cM+Roz0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EB9B0392707B; Sat, 28 Nov 2026 02:56:34 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw3Esbfcq+zcZyg80J9_1FaFLKD1S-83DstzL=WfrRbpA@mail.gmail.com>
References: <CAPM=9tw3Esbfcq+zcZyg80J9_1FaFLKD1S-83DstzL=WfrRbpA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw3Esbfcq+zcZyg80J9_1FaFLKD1S-83DstzL=WfrRbpA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-11-28
X-PR-Tracked-Commit-Id: e1dc9c441d4a92a54833c85b44c1ee474afaf57b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c639ac6b9cf100b860408a3cf8d7eab268866cd7
Message-Id: <179583459350.1775590.14559442489230836761.pr-tracker-bot@kernel.org>
Date: Sat, 28 Nov 2026 02:56:33 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Sat, 28 Nov 2026 09:04:35 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c639ac6b9cf100b860408a3cf8d7eab268866cd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
