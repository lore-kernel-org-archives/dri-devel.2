Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413DCC4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 04:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7738310E18A;
	Sat, 18 Jul 2026 04:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="exStg6Kb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F20510E18A
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 04:55:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0019043ACE;
 Sat, 18 Jul 2026 04:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87481F000E9;
 Sat, 18 Jul 2026 04:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784350499;
 bh=Md7GpkWQUaZSLMs25qETRNQ4a7FZ9JqNeV+AycsGUtQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=exStg6Kb0/8h3ucTdf5FKFYZcPQjg8LiEL/oQDzRCPKP+KkEzngT+wbfCGHGD21qE
 7Xk/NEULHOfSm+1iiFlhUFXafdR4ICCG+Ogmoj6EEaWNzXEwMAtYR3qJHWj5nBBAfr
 rbVMhgWLPDFrSbOO6hCUFZVRpL7W4Wm6Spt87efQ7Pfo7WzDOJxiHAL0ZcOFcMgPY8
 AUzf850XZSESPTxUU1xd916vdI7AEttjOclFuITbGhOL5V8+QFrMbHSwodNESGkxJB
 p+SHzleRVeRe84SHUGsvamaxFtMWeFl03pqo5eeGo3WiM9dh9o+qMJgXTbx9ZjopaU
 d8a1VstyRXm4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19AAF3811955; Sat, 18 Jul 2026 04:54:33 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw1j=WYsQjs8Empd1G0CorM-YHFDD87coJSBSXfxOOoXA@mail.gmail.com>
References: <CAPM=9tw1j=WYsQjs8Empd1G0CorM-YHFDD87coJSBSXfxOOoXA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw1j=WYsQjs8Empd1G0CorM-YHFDD87coJSBSXfxOOoXA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-07-18
X-PR-Tracked-Commit-Id: 5554e0599c960a2b320a78ef1429ddb1a1d94aec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 973fd9493ec21f12e760fbbedeb7b0b2317c02f4
Message-Id: <178435047156.2413748.15112336208678705879.pr-tracker-bot@kernel.org>
Date: Sat, 18 Jul 2026 04:54:31 +0000
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

The pull request you sent on Sat, 18 Jul 2026 07:31:54 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/973fd9493ec21f12e760fbbedeb7b0b2317c02f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
