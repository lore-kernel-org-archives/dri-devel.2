Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0714C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD2610E136;
	Sat,  1 Aug 2026 00:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nypO87/9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE2710E136
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 00:57:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E20341FAA;
 Sat,  1 Aug 2026 00:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BBC1F00ACF;
 Sat,  1 Aug 2026 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785545862;
 bh=Bx9Jvw5fbKTYxXMah/RgZse6HtIsNoGyqgaonptdlJg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=nypO87/91WK3jDacnInt92+RpzAG9tGUPRSUwr8vxo5UK6nQpWhR/hjS+fIQRtV5Q
 CNJie8YHQc3PufOSFBS5ksm0Is2Cvg/Z3M7yCv+OzMxv8RZe5CP62HTAwCxek3LxmH
 KP0YB3KVQ2azr+LNvsszQDt8kT3mLHUpGg/8ftzsLEPjkCr4eoURE7n4NefEh5BMM6
 rTRrxkFyJQxrQiSQefwjbF82hjBZCpC/Y3317a5O6afmXekrBD9P0S3HdlhUFuV9QV
 vMLzEa8S2eO7krW339q1RFmh8uXGD/ugiXuoooDJ1lS119wmX3EqZT1ULHwF7+7cHm
 H26X9ebX7AZ0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 569B3392665F; Sat,  1 Aug 2026 00:57:06 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz1+pHw3py72tM-DaE6oFQUdbc9XrG9DHJnh=RQNe5+Tw@mail.gmail.com>
References: <CAPM=9tz1+pHw3py72tM-DaE6oFQUdbc9XrG9DHJnh=RQNe5+Tw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tz1+pHw3py72tM-DaE6oFQUdbc9XrG9DHJnh=RQNe5+Tw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-08-01
X-PR-Tracked-Commit-Id: 256325820a46b2d69e04b4911f0d95c0bd50fb32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 680d49d84cb83ae5836317c00d0098aee47357d9
Message-Id: <178554582492.970149.6974279889961152496.pr-tracker-bot@kernel.org>
Date: Sat, 01 Aug 2026 00:57:04 +0000
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

The pull request you sent on Sat, 1 Aug 2026 07:40:13 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/680d49d84cb83ae5836317c00d0098aee47357d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
