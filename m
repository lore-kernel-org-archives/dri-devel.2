Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EDFCD3427
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 00:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D930F10E231;
	Sat,  2 May 2026 00:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FKJs65Z9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA55E10E231
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 00:19:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CA7E740838;
 Sat,  2 May 2026 00:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC967C2BCC6;
 Sat,  2 May 2026 00:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777681163;
 bh=F3XyOGUQwRs8kGLgccqL0YdoHnv9Uolr/8co6l5mw3Y=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=FKJs65Z99VOoJGG5pfjNiHp5Dx6yJs8/c1zZ3w506wcbaYdwRtdh7EmoK9GvIBttj
 HddumlZZxfKm9B1BB1tJEhyWobgmmFiAOT6RKJJCzwsV24Mr133wFbbXzC9Si2shGr
 1/0Vzna26khhbFjQAebgC4AUSHCwQkTJUqjHjmRvzg7Ro8tfMpvfBiJJYhiVqTzjnz
 yVGDkqbF/j7B+MicawMfmF+I/VYts9VN1mpQlmU5vLFtKIYPXBw+X9ht4xKbb4kkVw
 58y5DvZNXNomMs+ArIO2ldIFyk91biIPhoJzInbdbjgOKghrINtf6FnuWXAK13DRzC
 Sb8dnPby+ef5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 02F84380CEF5; Sat,  2 May 2026 00:18:38 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw9P=MuRdcupYrm9a-gACZtq0sPOdSLjOi9HMr34K6EjQ@mail.gmail.com>
References: <CAPM=9tw9P=MuRdcupYrm9a-gACZtq0sPOdSLjOi9HMr34K6EjQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw9P=MuRdcupYrm9a-gACZtq0sPOdSLjOi9HMr34K6EjQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-05-02
X-PR-Tracked-Commit-Id: f0997a06e3e32898bcae667d6807fc46ebfd0eec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1a5e78a55ebf2b05777fd5eb738038ddae609d6
Message-Id: <177768111660.3670267.15496623489487254705.pr-tracker-bot@kernel.org>
Date: Sat, 02 May 2026 00:18:36 +0000
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

The pull request you sent on Sat, 2 May 2026 08:21:21 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1a5e78a55ebf2b05777fd5eb738038ddae609d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
