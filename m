Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD60C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 02:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC31A10E408;
	Sat, 27 Jun 2026 02:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TSyOwE5C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC7F10E408
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 02:00:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 738EE600AB;
 Sat, 27 Jun 2026 02:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4DE1F000E9;
 Sat, 27 Jun 2026 02:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782525637;
 bh=wdZx1Yw+PFdT78UOG9xCuw7J8wGubvwT7b1f2inZv1s=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=TSyOwE5ChhGh2bcJ5nVmsM70ukJi8NXZPex+OCUn2jUOJmSf7U+r004gaORSveI3l
 ERs79VSzTnzYMvtEQMoexygAQo1HOthH2MVVQAINUf+6Khmgez+o8ysfEjNRsU6Fd3
 3tDHmHj1FJpdKlzf2/2nAWI9M9gZjS4yj+FqTFkcKOCdTW1qAGkeihCquSeNKpjpd3
 Mo2HALKOtSJqqeeJLCDqFgQUwqHXYcc1xjhf9dzlEv6CTW8XWRiUhn3ed1Z6h6iAu/
 dKkitUZpkwxqkCA1TJeciOWPPEYSt04XSepEQKn3+fXxuk1kqIFQfDKkqiU4TpT3j3
 gOxyRi3okQ46Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A9A3938C77; Sat, 27 Jun 2026 02:00:24 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzvPeeEuOKpq+Lh1Zu19nx+-Fpz6-h8huqw=Tm8LN+uaA@mail.gmail.com>
References: <CAPM=9tzvPeeEuOKpq+Lh1Zu19nx+-Fpz6-h8huqw=Tm8LN+uaA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzvPeeEuOKpq+Lh1Zu19nx+-Fpz6-h8huqw=Tm8LN+uaA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-06-27
X-PR-Tracked-Commit-Id: f24ba334afafc70c3149e9db9c0cf8ecc6d52a09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a66900afbd6b2a063eebad35294038a654de2b0
Message-Id: <178252562369.1167646.17438324553170836105.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2026 02:00:23 +0000
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

The pull request you sent on Sat, 27 Jun 2026 07:16:03 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-06-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a66900afbd6b2a063eebad35294038a654de2b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
