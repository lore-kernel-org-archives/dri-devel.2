Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A66FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 23:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9C010E088;
	Tue,  5 May 2026 23:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WadBA/rB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C08410E088
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 23:56:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F19F6024D;
 Tue,  5 May 2026 23:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56117C2BCB4;
 Tue,  5 May 2026 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778025402;
 bh=SKxPzwOs2LUU6XS+S+cwge8LKnZfV+kTiCd5PwTtSI8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=WadBA/rBzHYS46Pec0DntriiezSHraNm6KxHDixqZSe/fu3WK+UIJqXHmDyIJn4PL
 xKE/Q2jqJzyNDNzIVKp5q+gskYTP7e1nn5JKe560rFGASnisTaujcscUHoZRC2m/AW
 S9J71ns2z0tPbg+SEH6sv4aGPCjWjIk+vKLQ2tEIcLXCPTcpA698oTFJb5rB5opPCS
 5Fw7bbYXoXAst9aaOTN3HDl32HDaGF5Dt1kiX+01UWng/20yFf/KOwgrxnG4rdQZS+
 Z/zFQPz35V0JEMHSDe3fIEmdPgMhLq6iv+1qgCHM/L3u+3NsopOsmAkje17ze2HWTR
 eQR1SVpLzIBig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9FE439302FF; Tue,  5 May 2026 23:55:53 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <afpYkddCLxIsicwb@carbonx1>
References: <afpYkddCLxIsicwb@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <afpYkddCLxIsicwb@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.1-rc3
X-PR-Tracked-Commit-Id: 8de779dc40d35d39fa07387b6f921eb11df0f511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13ad98eaabef611f042d49a9077be060ad03284d
Message-Id: <177802535232.2314843.2129849224623926149.pr-tracker-bot@kernel.org>
Date: Tue, 05 May 2026 23:55:52 +0000
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

The pull request you sent on Tue, 5 May 2026 22:52:33 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13ad98eaabef611f042d49a9077be060ad03284d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
