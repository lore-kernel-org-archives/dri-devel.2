Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172E606A322
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9h0KzME
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF4010E19C;
	Sat, 24 Oct 2026 05:30:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9140510E19C
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 05:30:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AE8C601DE;
 Sat, 24 Oct 2026 05:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C61F01829;
 Sat, 24 Oct 2026 05:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792819835;
 bh=Dh97gih9aT0Yo7bMvplVYEJ4VBEfmnBHPPAVkbiXI60=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=J9h0KzMEsDoUNBMST/J9upJ11zYX9B+pcPL6uqiTtep5beDRZfmZXggi0mWeezslP
 GhqaNfvLG0WK+RGGIlcpnLqEuyHt2m5aByChs8eoYZHItz6jEQgRqo2V/5bSkVGGi4
 WHYbd6fMZrc3z8V0FGQvHKGGAy7bGZt1EfClJvwJZI3rf0VWhe7nMemggb0FlgDe3U
 l9cPMEYHlKXhjHOmt7CTpCLNd/AiFpk4572QgKfhVHH/l0CdhGOwW4Qnc/wxmw2DJ+
 2CKPVKAkC6+xgRgCqIcXscSQaZzD+hjGf2ywzGQyE6u2Llf7BaecxFLuOc/kdl6KHy
 8TtMg9DrvNLiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 05A10391B17E; Sat, 24 Oct 2026 05:30:35 +0000 (UTC)
Subject: Re: [git pull] drm for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twkDYDGdznUrXk8c-t1tXD52Df2LsdnF6KFDz_0xoYv7Q@mail.gmail.com>
References: <CAPM=9twkDYDGdznUrXk8c-t1tXD52Df2LsdnF6KFDz_0xoYv7Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twkDYDGdznUrXk8c-t1tXD52Df2LsdnF6KFDz_0xoYv7Q@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-10-21
X-PR-Tracked-Commit-Id: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
Message-Id: <179281983374.1490995.11409284564633418898.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 05:30:33 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Thu, 22 Oct 2026 10:24:59 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-10-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
