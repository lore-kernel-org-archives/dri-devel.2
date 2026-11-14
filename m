Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB62606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kv4ajCDW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A7510E69E;
	Sat, 14 Nov 2026 16:49:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C18F10E69E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F722413D6;
 Sat, 14 Nov 2026 16:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4325A1F000C4;
 Sat, 14 Nov 2026 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794674958;
 bh=GFFDq8pJNZo/uEP/nJ8eiBqAW9Nsrz2VEU8NX0H+46E=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=Kv4ajCDWNDhAC5GBILJroZgOzx31Ur3TLYVGnIQW9sjMCYrAoqY6XUQmbMzFEe/e/
 RogjjtmMEj+IVNfa62l60XuHHbJRo3TDyV0iXp9lZHfWzUNptVLvrRVxIkLy9EYWI/
 8cpdn7t4+8j1xpcmyo3jdFiiyiIiadtycXnJhp7EW4FhgrfDoTuNDNTcDfshu7lPyb
 u6Ua0rXpdme8k6+8esDqIQGeOB5q5xtUiez7RXWicCk8cFCDtX8X6bArek3NcVq6XG
 PkOdLPLQHVnRiGDyMoiScYub/ZbEi0ZCRONg2T+xEJtpCzfMp9hYXRAaVf/4R+GGIw
 5LaJlNKbRNYMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A43C380821F; Sat, 14 Nov 2026 16:49:18 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyPUacWoB9-tqq+hNDB2RexAuTB7Whp1hMs1d4ZmeswpA@mail.gmail.com>
References: <CAPM=9tyPUacWoB9-tqq+hNDB2RexAuTB7Whp1hMs1d4ZmeswpA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyPUacWoB9-tqq+hNDB2RexAuTB7Whp1hMs1d4ZmeswpA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-11-14
X-PR-Tracked-Commit-Id: 637c4514732baa5d19bb716c00d6fd67034f238f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b21c45d2151a2ce78806b4234513a1793525611b
Message-Id: <179467495679.2233204.6522313419302052392.pr-tracker-bot@kernel.org>
Date: Sat, 14 Nov 2026 16:49:16 +0000
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

The pull request you sent on Sat, 14 Nov 2026 11:30:32 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b21c45d2151a2ce78806b4234513a1793525611b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
