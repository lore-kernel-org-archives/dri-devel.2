Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F2EC5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D1210E292;
	Fri, 21 Aug 2026 16:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HME5CV05";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD0110E292
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 16:56:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EEB361126;
 Fri, 21 Aug 2026 16:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4650F1F000E9;
 Fri, 21 Aug 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787331393;
 bh=LU6lUdJZu7Xg+V0AStShUedGkhyFT7zl6U/m5ST954I=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=HME5CV05j3WUvoBpTjWHslotu8f4QngXMecLV3FIXhDaHKL8rEQ4G3tslTU9pBmi0
 SUKYZZD7nhxBsmQkgrIPz7qfuM1XCX4pD1pzjQKGjRMR+jB+YkNFHSTgVd6injzPqI
 VFUCYkLJX7k19RDilHMO17u5Lo9P8eyPFEUblt9FbWwGfqrP3fkM5ecWGLVzXd3dNi
 2HHEmsM0t3q9y4xFuTAxNxnBX1kTXy1w6niI9548pdrTnYFEVzTSJP4FGyeIxlJwR3
 6f0ft4r788F4bH//lLFcgrT/ymc7wsEW1KFdca6RMGbkYXagNtyxj8feYj3B5lpuW8
 3OBosucenbYrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19AD1380AA76; Fri, 21 Aug 2026 16:55:44 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoh0QXTIQbgDjAB_@carbonx1>
References: <aoh0QXTIQbgDjAB_@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <aoh0QXTIQbgDjAB_@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.3-rc1
X-PR-Tracked-Commit-Id: d463633d63e6aa10384683bf39971a4b00780c56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531ed942bb0df04f6747983fecdedce76a22d07f
Message-Id: <178733134265.1393585.15591611200509777280.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 16:55:42 +0000
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

The pull request you sent on Fri, 21 Aug 2026 17:52:33 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531ed942bb0df04f6747983fecdedce76a22d07f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
