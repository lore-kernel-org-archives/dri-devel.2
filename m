Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5F3C5AD05
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 22:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B62610E473;
	Fri,  7 Aug 2026 22:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DFMO09xJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FBD10E473
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 22:53:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B9844377A;
 Fri,  7 Aug 2026 22:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE431F000E9;
 Fri,  7 Aug 2026 22:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786143202;
 bh=i41oma5Ja4PWnv/hM+9O68L6lAk3EUk46AY6Mh0OmsA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=DFMO09xJuPM9m/JrH5YaW3v5mdkU7VdIpT8Bbvh7mByfonLzoUDmlpSswbXKl6iAP
 eFi9IY8NxzrpFbXrNdxALcTIVkPRyiAhyB065ZKqjw+OIgeEjigebDDlCMsC2YCrIM
 nO+8O1U6Tg0lim4GmtlPsMJS+sAykv3eZ6EQN/agn5lxGwkXpgSGQsfDv8sURfcGyn
 Abx3bssMlkVylvIg/ujmTeQQIkFRkxoTRM/SINtozwrkaCPHdrVnHcpRPtM0qA4YPY
 M5nliApzCjjr7fm6WeLNwWng43kWhomj2deY07qSKfGZIdHBPINYSBv17yNsMckYQK
 Hb/n8lTiOclGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198BC380CEF9; Fri,  7 Aug 2026 22:52:42 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty7AHCg=yvFJzcet0E8EJaW39ZWTBXcMjKfRv5gn_qKTg@mail.gmail.com>
References: <CAPM=9ty7AHCg=yvFJzcet0E8EJaW39ZWTBXcMjKfRv5gn_qKTg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty7AHCg=yvFJzcet0E8EJaW39ZWTBXcMjKfRv5gn_qKTg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-08-08
X-PR-Tracked-Commit-Id: 5fb210754ed66ce2dbd3ccffd508df769ff0bcdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcc44b6785f216eb939226ade6e3910baa30516b
Message-Id: <178614316086.2450666.8388885512321965812.pr-tracker-bot@kernel.org>
Date: Fri, 07 Aug 2026 22:52:40 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
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

The pull request you sent on Sat, 8 Aug 2026 07:08:17 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-08-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcc44b6785f216eb939226ade6e3910baa30516b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
