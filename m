Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2F8CC6B33
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B6610F1B4;
	Thu,  2 Apr 2026 08:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="Y3nDwJQq";
	dkim-atps=neutral
X-Greylist: delayed 447 seconds by postgrey-1.36 at gabe;
 Thu, 02 Apr 2026 08:47:49 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [185.244.194.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C69F10F1B4;
 Thu,  2 Apr 2026 08:47:49 +0000 (UTC)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4fmb041Nyyz99lM;
 Thu,  2 Apr 2026 10:40:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1775119220;
 bh=b7IYk2CCpldXfIysblUswTo2KkLaHsOSsojnuIXRDP0=;
 h=Date:From:Subject:To:References:Cc:In-Reply-To:From;
 b=Y3nDwJQqb+LeqhNodKwJx3cPwINl8MpTKS9WDx7UZXP4TDJm+v9/iGpio6vAOzOp7
 eQ3yc/uPTkZxWAg8ljxJHCulaxNuo7qK46UV3ZNVJjL+7ViKKfIwXCjs3GZ4d1uc4i
 KXNWa+6CJjQiIf3YSsodVF5/jMkeUkSAL7BINgyJOX586Kt7mJrBPZ28zJQFuTVCI6
 JgwcBf0HdKocK485Lkr1uWC1jb4E+DkvUEDMYnq1P+vHhrVLk1tJOlojApPhGp6aAW
 9Io7o4zDDioGh8qVZrcQbXuPje0Z+owOLJpARfTCzW2dKXlB2a+ooBUDOTXXfjo1xG
 ApKeRXAQVr+5A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4fmb040gSnz7wYj;
 Thu,  2 Apr 2026 10:40:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fmb01579bz8sbl;
 Thu,  2 Apr 2026 10:40:17 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 01A3E635B4;
 Thu,  2 Apr 2026 10:40:16 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
Date: Thu, 2 Apr 2026 10:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Regression fix for audio issues with pre-DCN401 chips (was: Re:
 [pull] amdgpu, amdkfd drm-next-7.1)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 airlied@gmail.com, simona.vetter@ffwll.ch
References: <20260401184456.3576660-1-alexander.deucher@amd.com>
Content-Language: de-DE, en-US
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260401184456.3576660-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177511921734.1118730.14775591535665344992@mxe9fb.netcup.net>
X-NC-CID: HXD6nnGI0L3eL6adBXj/cKAE12weFgoTISz9rOMsO/HdM7XzJFI=
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

Lo! Me again, sorry for pestering you folks about workflow issues again
after doing so just a few weeks ago. :-/

On 4/1/26 20:44, Alex Deucher wrote:
> 
> More stuff for 7.1.
> 
> The following changes since commit a51973c5dff8a0f01cc7d1b2007306ea0004fa16:
> 
>   Merge tag 'drm-xe-next-2026-03-26-1' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2026-03-30 06:04:59 +1000)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-2026-04-01
> [...]

I noticed that this lacks "drm/amd/display: Wire up
dcn10_dio_construct() for all pre-DCN401 generations", which is a fix
that was posted 10 days ago[1] for a 7.0-rc1 regression that at least
three people hit[2]; a fix that now seems to be in "this week's display
driver promotion cycle before merging"[3] at AMD.

Is this delay really needed / worth it for a regression fix at this
point of the our devel cycle?

And yes, I understand that this might be shared code that AMD wants to
test internally first. Still asking, because at the same time it would
be nice to (a) fix the regressions rather sooner than later and (b) not
fix in the last minute.

Are "pre-DCN401" chips even tested in this "driver promotion cycle"? And
how often does it find problems anyway? Can't we just apply the fix and
revert it quickly later in case AMD find problems (yes, I understand
that this complicates things, but I wonder if that might be worth it if
this is rare)?

Ciao, Thorsten

[1]
https://lore.kernel.org/all/20260323211343.263909-1-sunlightlinux@gmail.com/

[2]
https://lore.kernel.org/all/CAOKSTBs1VNBdjRZe3M2v-nC%2BpLZZ0-KQtRUZUj6ACqb4Xe7LDg@mail.gmail.com/
https://gitlab.freedesktop.org/drm/amd/-/work_items/5052

[3]
https://lore.kernel.org/all/22eb66d8-b74a-4e0a-9851-7e39c7f950cd@amd.com/
