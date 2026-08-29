Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E850C61DB9
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 01:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 129C710F090;
	Sat, 29 Aug 2026 01:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kji/DacW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7F610F090
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 01:14:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 852C060A64;
 Sat, 29 Aug 2026 01:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B68E1F000E9;
 Sat, 29 Aug 2026 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787966070;
 bh=yfOqs4Y1GT3QzLLMm9yIBGTYHIUt4SmviDY7AGZDR0k=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=Kji/DacWZ9AkqALujfenDhd+JXoaXyrwZRmcAceVCVJ0elLr0ClTWWdfp6cD2fZ9p
 aBLsRNg0mpPDpxaacGlag7N8jTram4W9XNnQKU4U8HTcsJki6J+BrxfhrvFLf2sKQv
 iCKsus6XXhy5snKL8AOQVGiVT5gnROQRRJy3pxypBUuFpM9XvzD/Tngh0ni3PS4fNh
 oFJjlGvSm5YpDV0Iyo5vy50R535KJ7JwM+8XkQIMxgtrgnKX3qSrHteGrfs0Fj6SU9
 ioQt6oax5nfAA5sxOBoW8H3rUPJGHAHSQAX6NbjlF0QKKogiIwfvlAtrZB4G/gHZ/a
 4Ow351p1ZoS6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19C23380AA69; Sat, 29 Aug 2026 01:13:36 +0000 (UTC)
Subject: Re: [git pull] drm next / fixes for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz+KjNRJzYWKA-snStcyh8HpXEbCfWw_zwqEUQ+hANcdg@mail.gmail.com>
References: <CAPM=9tz+KjNRJzYWKA-snStcyh8HpXEbCfWw_zwqEUQ+hANcdg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tz+KjNRJzYWKA-snStcyh8HpXEbCfWw_zwqEUQ+hANcdg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-08-29
X-PR-Tracked-Commit-Id: a8b02aa825803e6c5b6b27340f583900afa0861d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a99d741df7372f2175677673d78a6335f3e0706f
Message-Id: <178796601460.2866694.15417528546708724262.pr-tracker-bot@kernel.org>
Date: Sat, 29 Aug 2026 01:13:34 +0000
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

The pull request you sent on Sat, 29 Aug 2026 07:22:05 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-08-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a99d741df7372f2175677673d78a6335f3e0706f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
