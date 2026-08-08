Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FA1C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7D410E064;
	Sat,  8 Aug 2026 14:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EsMV3ewK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A997E10E064
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:52:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D28D86001A;
 Sat,  8 Aug 2026 14:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C01A1F000E9;
 Sat,  8 Aug 2026 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786200732;
 bh=JXGRGi0cBLAHZ0vB2PEtYx3AOux4VBAjL8eG0OhesT4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=EsMV3ewKso9gXvhHRdMRu+1741OrYveoTBfwzajrkXY2bJx+/TBspcbxLA75yWFcB
 VWvCZfVw8zD8+nYsNKgxCyB6fDqWbUTeoF1Y/kOFC3pbpEmBb105yC23eM7+eaQluY
 qS9uoqeYN8oEPam0nXZ/80hea/t63fBl3fFvxR+QEYEdeo7ia2xCLZf9Z92Rp0V4dY
 gYvZzJ2zKDBjymyHO97UUkmWgdpCY3dduW7rsXQoX6/VfXeLRUWDXznrIl/dTGOg3a
 P8zTE1h5P1SuaElGvYzbJHGf58u0iPBwJySSfHosKppviHiE5wieIFqv4lM/Hq8Oay
 7NqK6gNIOWXAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0ABA380CFEA; Sat,  8 Aug 2026 14:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <anc0HhpSwT_c7CTg@carbonx1>
References: <anc0HhpSwT_c7CTg@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <anc0HhpSwT_c7CTg@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.2-rc7
X-PR-Tracked-Commit-Id: e033cbf3975a8465f879ebd5989dc35b04423a4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7c7074b58d28c4206d666a12aa2e33447b3c581
Message-Id: <178620069055.2671154.551609346497003543.pr-tracker-bot@kernel.org>
Date: Sat, 08 Aug 2026 14:51:30 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
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

The pull request you sent on Sat, 8 Aug 2026 15:50:22 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7c7074b58d28c4206d666a12aa2e33447b3c581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
