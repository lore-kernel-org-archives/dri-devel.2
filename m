Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E2606A323
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJhpEMme
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF65310E7FA;
	Fri, 30 Oct 2026 18:00:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0163610E7FA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 18:00:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2537960233;
 Fri, 30 Oct 2026 18:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0441F00A1C;
 Fri, 30 Oct 2026 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793383231;
 bh=arldDgIN+DCbRWttC/pNZKTNCd0fMgl+I3NlSIduriw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=jJhpEMmeqXC0RcZsXl7WFapgrUzaX9VYlBMmNTjFqSrtS738L6LLpmt+ewFzcgoF7
 XZzgp54Pipn0MHA17YnDEQmYNYN0vQEKIOzePveG2XPy0h9UgnKcqSu+QZgHloqFQ+
 2DNj/T/HcDHQX+WfQMcCVE/drS5eRUMg6B3f+Ckr3Xszp0ij/xHqpYJ2fte3n18f7t
 lOTi8vJyrpYt1Pe4gzbzts0BPtWk7sZh5OVJFPGyD9jaMSUy8Slad+qoNqe9Nj5Pql
 R9yeNFLIrfAQV0RwBTrOWxFR4rZjhd/TTFiyhlMM7L3YT/dJX/PHKU87ElwZI57Q/W
 gLZ8beaGSe6qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 C3D7C3800471; Fri, 30 Oct 2026 18:00:31 +0000 (UTC)
Subject: Re: [GIT PULL] more fbdev fixes and updates for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <auPJLXQdFRtkoOCu@carbonx1>
References: <auPJLXQdFRtkoOCu@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <auPJLXQdFRtkoOCu@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.4-rc1-2
X-PR-Tracked-Commit-Id: 01d1204582f16e8b7bfce29648e5cf77a585d962
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67f1f9b38c15b54d257a1efc544873b53905737f
Message-Id: <179338323067.1671436.4542824899544592054.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 18:00:30 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Thu, 29 Oct 2026 23:31:09 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67f1f9b38c15b54d257a1efc544873b53905737f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
