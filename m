Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237E0CD4851
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 00:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779AD10E182;
	Sat, 16 May 2026 00:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EaHrnVcK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C8B10E182
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 00:06:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 86EBF436AC;
 Sat, 16 May 2026 00:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D7C2BCB0;
 Sat, 16 May 2026 00:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778889964;
 bh=iokcqk6AWA1If6v0webce9Q2w865pnx+fIz7nLCG+o0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=EaHrnVcKMnIfHD3yjFlnvsYlZOgLvcSG7aje65X5kcmgEm90shX7ei7GIX+XK5jdf
 ZmLdYDEEHqphTLb91HfOqScBSFr5nXpuk3PP0tZCkgamSo90NF9IbFzlfnTtwTK0PR
 M34EIWOBHRVSGMmTalc3t5oHSuVIqhBdCvAXOCpMTn53d4rosR672AyJrJkjM82MCi
 TJLiwQopMR0AqJA5gKK80EFq2cpVImfTD9AbpyaX6smUq9hlmxvs9qf7sDtiYTqWqU
 xqK2CV8pM6I4w/6KEzqO6ix2KAyC19ktjtmvpZQOHSgx8qfAULyb3mopYTuWIDoMdN
 8Ikn0rti+DZIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A4C3930A23; Sat, 16 May 2026 00:06:18 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tysLUnY240+JBoYG8QVo=cVDCxai4kkS-an9_1n6qnA2A@mail.gmail.com>
References: <CAPM=9tysLUnY240+JBoYG8QVo=cVDCxai4kkS-an9_1n6qnA2A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tysLUnY240+JBoYG8QVo=cVDCxai4kkS-an9_1n6qnA2A@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-05-16
X-PR-Tracked-Commit-Id: dc366607c41c45fd0ae6f3db090f31dd611b644a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
Message-Id: <177888997753.203181.1711494996251427161.pr-tracker-bot@kernel.org>
Date: Sat, 16 May 2026 00:06:17 +0000
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

The pull request you sent on Sat, 16 May 2026 09:47:35 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6916d5703ddf9a38f1f6c2cc793381a24ee914c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
