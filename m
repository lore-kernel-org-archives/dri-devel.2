Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED966CD8C88
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 01:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285F7112C9D;
	Sat,  6 Jun 2026 01:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mZDLtSU/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3576112C9D
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 01:36:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9142543D1C;
 Sat,  6 Jun 2026 01:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FFE1F00893;
 Sat,  6 Jun 2026 01:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780709818;
 bh=3ngt6tXRp8KW9cmShoW4vLcGJn3uzF2bAOmm8/wXMxo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=mZDLtSU/xJpC+OmUp6MRjw7FWIfHGzKpbiJe3MxDquq7qseQJo4jEAv30Eg4mNJ2B
 o2zoGzSpixC3qzrlUqI/WHC2HJyJgBipU0x5w3aFTZX2tb8xYkVoAwz/yW1TO240em
 hdnDnp9rcWppgL60iCv84qAGncCzSL6GdbGujyzlRg1+KaJ7vpiNOsjy7gIiIdIjFz
 oGcbd9O5AofD2qoEFcJT/bDsYccwoVA1xY0puRO1VeOfxTB0SCWgtfceWZQ69Drd8I
 6oFWIQcdoMmTaM0zXtQrOUWZmUSg1DnyFe/4ktnbU8WKNXgp6rOhniiO2mkA4pzzy8
 SsIfPRqhCcT3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0C1C3930A9C; Sat,  6 Jun 2026 01:36:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx-LsD-MVyNdO4uQ-of16HNt2JsbJYQqRCOMUzzH5bVrg@mail.gmail.com>
References: <CAPM=9tx-LsD-MVyNdO4uQ-of16HNt2JsbJYQqRCOMUzzH5bVrg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx-LsD-MVyNdO4uQ-of16HNt2JsbJYQqRCOMUzzH5bVrg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-06-06
X-PR-Tracked-Commit-Id: 1a4f03d22fb655e5f192244fb2c87d8066fcfca2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e65320d91cdc3b241d4b94855c88459b91abf66
Message-Id: <178070981856.3986214.7853730944242902201.pr-tracker-bot@kernel.org>
Date: Sat, 06 Jun 2026 01:36:58 +0000
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

The pull request you sent on Sat, 6 Jun 2026 09:14:18 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-06-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e65320d91cdc3b241d4b94855c88459b91abf66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
