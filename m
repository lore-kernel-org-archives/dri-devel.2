Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B3CD98DE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CC410E7F2;
	Tue, 16 Jun 2026 03:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Iu73EJEH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADD710E48A
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 03:10:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A779600AB;
 Tue, 16 Jun 2026 03:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EEE1F00AC4;
 Tue, 16 Jun 2026 03:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781579440;
 bh=Dtej1D3OJgueLvzfSfIXgzcNjGnEErEqNbrsgY+1CjE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=Iu73EJEHii83jRXnVKhFp8O4qMxSFqRS4GTI/YTwGa590LTA9SbWC7czS0ZMePXVC
 rVlFINbtQYPE82lJE4IRsOV5h0Q7LiQw+u89FkzxV23l7l4ZxIk9IzW+/jTl6iorRn
 nXBFhTNIjiaa8asBQciq7lIS+pEPWHjafP89Z+If4I2MpvXhjaxgwCeAtfgeSSOBXW
 /HFqRC+PqKOG7XuOrVrH0643AqqZxR7ChNBl8hhcLe9XJEMtlkjh1qVBsAM3yahnwz
 8I4DBoXAYDXEl2w+/H2V5F/aaGftDXYV0MXLmpekevgt5iRLKSUiZkOZeK1xf0f20N
 yaBX9ma0kMKGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1C44C383BF4D; Tue, 16 Jun 2026 03:10:36 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajAqhsgrxtUHQdFv@carbonx1>
References: <ajAqhsgrxtUHQdFv@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ajAqhsgrxtUHQdFv@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.2-rc1
X-PR-Tracked-Commit-Id: d894c48a57d78206e4df9c90d4acfaf39394806a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd77e50c9a70f844d6073499f3d1a6fd193eae73
Message-Id: <178157943496.413763.1174494062218662923.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 03:10:34 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
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

The pull request you sent on Mon, 15 Jun 2026 18:38:30 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd77e50c9a70f844d6073499f3d1a6fd193eae73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
