Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDD606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcaGd+ci
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429E910E5D2;
	Sat, 31 Oct 2026 00:10:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F6D10E5D2
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 00:10:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2B5F600AA;
 Sat, 31 Oct 2026 00:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889051F000C1;
 Sat, 31 Oct 2026 00:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793405418;
 bh=kw6LiuI/yFNgi/Lnc9mIFGKZx3wlY1r4nAoe3+F1OCk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=IcaGd+ci470vvA7ks+1L73yg3DCJTk0aJ2EJjl7jo1tV3j+ZpSOBwFNV2iBhv5+6U
 duWAdK5V0/qix/sVBw2ejf0/2DoIRyjbFt9Dnj/xBBgafFZ9GYDGaM+RdMK8Z+hh+J
 VyrtB/VocdOTZBfyr0rlL91hkSk4VISSCfUkA9WrnoHVqpa918GhDP/1agfrG055jb
 TUShKa+b9DviGc63X2nAhnW2y2+S8lJhp0sGYBvjIyzQZm4gNSWTwN6VlY8G1otToE
 q/36PrVJ1eBv0hAd2iO8AKhbmJDPZknG2eDxuCARU+JNn2eA5JtNGQSwwUDC9IYosW
 dVnCk7WdpA4MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D3533800478; Sat, 31 Oct 2026 00:10:18 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txuHS0rd7POC2gReGGnD0gmA-NrPzh1Gy4QC9824Qc4sA@mail.gmail.com>
References: <CAPM=9txuHS0rd7POC2gReGGnD0gmA-NrPzh1Gy4QC9824Qc4sA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txuHS0rd7POC2gReGGnD0gmA-NrPzh1Gy4QC9824Qc4sA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-10-31
X-PR-Tracked-Commit-Id: f94ed3d7cba3c83eef50b1a96d630d63cf54f69c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b92f6e90cf056ec80bafb858d5749829a55ac75e
Message-Id: <179340541701.1842115.2059104542542869130.pr-tracker-bot@kernel.org>
Date: Sat, 31 Oct 2026 00:10:17 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Sat, 31 Oct 2026 07:37:55 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b92f6e90cf056ec80bafb858d5749829a55ac75e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
