Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAA6F55123
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC1310E249;
	Sun,  5 Apr 2026 14:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="cN1q54fZ";
	dkim-atps=neutral
X-Greylist: delayed 567 seconds by postgrey-1.36 at gabe;
 Sun, 05 Apr 2026 14:12:26 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [194.59.206.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5E910E249;
 Sun,  5 Apr 2026 14:12:26 +0000 (UTC)
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fpZ0R0M6jz47BV;
 Sun,  5 Apr 2026 16:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1775397751;
 bh=cKzuIgeDBU3ZyhWnV/CAe2lNW8KqWU8uBkels6cjCs0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cN1q54fZW4mW+ZRP4aUnt1OqY5xQafpKebpbrfSRfvsEJVrHj5GVooKvK16UTF2Q6
 RA6auk7uSZ+M45o2SFOQ3/2oJ1JVUwMbvoG11y8k13+o8Aq8NURGACGHCrO63tUx44
 Z/K/JnkY4yACTryz0pLkWA94XQrkVZDXfSf/1aumEd5i7Mg5skndv7bgnoqEJta0jJ
 Qp8zy92gb7FExhkfNkGkmlBy9t4upG4MV4qeOTA2hUpPcFXPhUH3C8WOFaxixZuqnq
 lVv+8rOxRxMwgP+vme5SN8fLTkiujwyBo3NdCM+s7gRTmMYRBxA3UcIon0PoBKt8Ao
 7A5B1Hl+DzspQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fpZ0Q6mdZz7wyW;
 Sun,  5 Apr 2026 16:02:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fpZ0P5dmtz8tXc;
 Sun,  5 Apr 2026 16:02:29 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id B1DB6635B4;
 Sun,  5 Apr 2026 16:02:28 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7030db14-ebd5-4652-9301-b9c8bec441a8@leemhuis.info>
Date: Sun, 5 Apr 2026 16:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression fix for audio issues with pre-DCN401 chips
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 airlied@gmail.com, simona.vetter@ffwll.ch,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>
References: <20260401184456.3576660-1-alexander.deucher@amd.com>
 <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
 <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
 <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177539774908.2651097.9426432284176448955@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B1DB6635B4
X-NC-CID: bpLxq1lRUm9IT/FhFIMUMnXK3SBA4YVK1sN9piAdri4zX8+noXc=
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

On 4/2/26 21:01, Linus Torvalds wrote:
> On Thu, 2 Apr 2026 at 11:27, Alex Deucher <alexdeucher@gmail.com> wrote:
>> There are always new fixes.  Worse case it ends up in 7.0.1.  If it
>> causes other regressions, then we end up introducing a new regression
>> in rc7.
> This was a regression in rc1, that was reported several weeks ago.
> Anything that gets reported that early in the release cycle is bound
> to hit lots of people, because the number of people testing early rc
> kernels is relatively small.
> 
> So why pointlessly delay *known* regressions for fear of a potential new one?
> 
> And why point out rc7, when dammit, this could have been fixed long
> before and *not* be that late in the release? [...]

Thx for jumping in there. While at it: I see situations like this all
the time (I'll reply to this mail with a few current examples), except
in a few subsystems that do a good job (Jens, for example, does). Which
makes me wonder:

What can we/I do to improve things so maintainers more often handle
regressions like you want them to?

Because right now I feel like running around spending (wasting?) a lot
of time on tracking regressions and upsetting maintainers when speaking
up -- without making much of a difference in the end, unless you reply
when I CC you. But even that often just helps in the particular
situation without improving problematic workflows and habits much or at
all. The issue discussed in this thread is a pretty good example of
that, as we just at the beginning of this cycle discussed[1] an amdgpu
regression where a fix for a 6.19-rc6 regression affecting various
stable series could easily have gone into 6.19, but in the end was only
mainlined at the end of the 7.0 merge window. So without me complaining
again (which only helped after you jumped in), something pretty similar
could have been the outcome this cycle again, too.

> So  honestly, there are exactly two choices: apply the fix, or just
> revert the commit that caused the problem in the first place.

BTW, Alex, thanks for pushing the fix upstream in between! Ohh, and
please don't take the above personally: what I say there is in no way
specific to amdgpu and/or the drm subsystem. It from what I see handles
regressions better than quite a few some other subsystems . But here it
coincidentally served as a good example for a general problem.

Ciao, Thorsten

[1]
https://lore.kernel.org/all/b4f8ca7a-02b1-4e72-896b-87a00db6338b@leemhuis.info/
Fun fact: the fix (f7afda7fcd169a ("drm/amd: Fix hang on amdgpu unload
by using pci_dev_is_disconnected()")) was posted and committed in a
subsystem tree within two days, but the regression in the end was
present 54 days in the 6.6.y series, 48 days in the 6.18.y and 6.12.y
series, and 45 days in 6.19.y (or three weeks more if you started
counting at 6.19-rc6, which was the first version containing the
culprit), as it took three (6.18.y and 6.12.y) to five weeks (6.19.y and
6.6.y [the two extra weeks were due to a mistake afaics]) from mainline
to affected stable trees.
