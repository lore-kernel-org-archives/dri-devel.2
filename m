Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BD8C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AEC10F397;
	Fri, 21 Aug 2026 16:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lr5Ienke";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B55E10F398
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 16:50:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1658461126;
 Fri, 21 Aug 2026 16:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27DC1F00ADE;
 Fri, 21 Aug 2026 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787331057;
 bh=Mvl2T1BbTrOWhDCADbG4Riyaf7Ewt+cG6pMYzzmX9Dw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=Lr5Ienkeqqkaj4MKN7lOKySJEiErHnIDoBCW94BXWnvGMz7oqrP+mJl1yFwEpHrFq
 m7P8dCAW5jrJJw2D2ZXFYofoDQRRWND12e7eop+7m/+sL+5FExOIZiqESD6t/9EV4k
 o+vdKYVpNEq9QwCza4SRt6fuh09xQF+GtiCvRz1JrOY2IahT+qaToaECmyFMj1TY5O
 Y6ntKYWuJxDODRriQClGLOKK46IdaySJB9UyIcxNUt5wLi3B5X3EPzl2Eh7D3pbrH2
 BH6ZFRxZN6OD+OU0BJg8by/Fx2mWvmJEPb0Qc8LmkE/23JA4HCKcnozTBYLYyr8Xnt
 7S/BMQ+0iRXAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93A7B380AAD1; Fri, 21 Aug 2026 16:50:08 +0000 (UTC)
Subject: Re: [git pull] drm for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty-79O4_Cd_cGDTg11ej2sAQgFsjjkn3sd25mUaKwQBLw@mail.gmail.com>
References: <CAPM=9ty-79O4_Cd_cGDTg11ej2sAQgFsjjkn3sd25mUaKwQBLw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty-79O4_Cd_cGDTg11ej2sAQgFsjjkn3sd25mUaKwQBLw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-08-20
X-PR-Tracked-Commit-Id: c44e278ce02efd0c4be79a8eda1ea6885c1ce5ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e69c1856bfd9ffb7e9d335a25842fa211628929
Message-Id: <178733100731.1379621.10124796703360715608.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 16:50:07 +0000
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

The pull request you sent on Thu, 20 Aug 2026 16:00:50 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-08-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e69c1856bfd9ffb7e9d335a25842fa211628929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
