Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085B606A336
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWfQLN+P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29F010E16F;
	Sun, 25 Oct 2026 05:50:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B736E10E16F
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 05:50:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51CE5601FB;
 Sun, 25 Oct 2026 05:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0850B1F01825;
 Sun, 25 Oct 2026 05:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792907439;
 bh=6zElpvh8J3K9HT4cCQP7Rv5mxb8/Eqdt7hOMmMt8fCU=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=FWfQLN+PCTMgOJ+zcHsSHwpWPLUHBFtAaazkx3/Jr/+MN+e0KOL1+iaVyCGrw+Akd
 SX+F4vULnITOppPkwO8STFrq7l4G3tGrFx57XMxphJZezkPBSBgKDAce9aQ8u2+j4e
 2Y1OBq6R/T8vtVQzybqWcq7NO2LUz9+Lq4PnAZcGzmZY/aUnVYxae++jbfwuaYGhUG
 Amjrjh42BBT8B3g/pKZYjH+YKfuo+dGoe/SOiQsNoQKyurQo5+VzsMsVNdgO0zIk4K
 VM1PBkZDoYdtgvAOZ4JcE34c/JG5HKKRTM3mDXRbvg3SqdWEtkqL30WqZMaiuWkh0F
 bkgvWlWD6tTmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F1F9D392ED67; Sun, 25 Oct 2026 05:50:38 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atp9GlM3gE8uF0xo@carbonx1>
References: <atp9GlM3gE8uF0xo@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <atp9GlM3gE8uF0xo@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.4-rc1
X-PR-Tracked-Commit-Id: 61e1a43ca5825acb137a10ac7d52746632bfb124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dfc0090b925243490b5b71bc9a229517cda499a
Message-Id: <179290743751.1990210.1431048982093416527.pr-tracker-bot@kernel.org>
Date: Sun, 25 Oct 2026 05:50:37 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
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

The pull request you sent on Thu, 22 Oct 2026 23:16:10 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dfc0090b925243490b5b71bc9a229517cda499a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
