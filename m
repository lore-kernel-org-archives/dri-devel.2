Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9331CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 12:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236B210E17D;
	Tue, 26 May 2026 12:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OsDazvTR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD22310E17D
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 12:51:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB54F43937;
 Tue, 26 May 2026 12:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667D11F00A3C;
 Tue, 26 May 2026 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779799860;
 bh=bteBqFYiwq3J6OuPkzqH8VWWC7H63MmZiDe/6GM4mCM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OsDazvTRCqIezJKqXfh8OOKQB1X2daHZmZ45puukpTDNAAa4h2d68mcd1v7oAsw8I
 MZ4KKRpNxXIgxjh0jblCDvZ2+6jxwbyYf3V59oGWmdB4rY61G9qHgAJQpCJrV0vQJk
 h9CljaZISKs2pvdqgaSUjb90cD7nro4md0MGNbMtpmQT19WpWsGlJjeZOzUaSTu23K
 KJdoIDobh0UiM/xCW0LO1dCP5OMGzZle4e/Gr0q0YVtfL52Cf+puvNceX1sFgRabAC
 v54+J/ynVhiK/A+BVaqxSOE6Zq0M4LLd3og9dPz1Q+bwc9SmYM9Cj4a0iZ+2sKXx7P
 OZ8f2SNyYsLvg==
Date: Tue, 26 May 2026 08:50:59 -0400
From: Sasha Levin <sashal@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: w15303746062 <w15303746062@163.com>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org, tzimmermann@suse.de, mripard@kernel.org,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to
 fix ABBA deadlock
Message-ID: <ahWXMzJ3OWea3eyX@laps>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
 <20260525131610.608273-1-w15303746062@163.com>
 <20260525231000.agent5-0001@kernel.org>
 <51ff85d2.9c25.19e642e591c.Coremail.w15303746062@163.com>
 <99f74d53-0060-4fed-b83e-955071883651@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <99f74d53-0060-4fed-b83e-955071883651@linux.intel.com>
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

On Tue, May 26, 2026 at 02:48:55PM +0200, Maarten Lankhorst wrote:
>Hello,
>
>Den 2026-05-26 kl. 14:06, skrev w15303746062:
>>
>> Hi Sasha,
>>
>>> Looking at the five commits:
>>>
>>>  - 1/5 (74afeb812850) is the one that actually fixes the ABBA
>>>    deadlock you observed under Syzkaller; it adds the generic vblank
>>>    timer that replaces the open-coded vkms hrtimer path.
>>>
>>>  - 2/5 (d54dbb5963bd) adds new CRTC helpers for "simple use cases".
>>>    No Fixes:/Cc:stable, no described bug.
>>>
>>>  - 3/5 (02e2681ffe1a) is a refactor that converts vkms to the new
>>>    helpers. No Fixes:/Cc:stable, no described bug.
>>>
>>>  - 4/5 (79ae8510b5b8) is a v7.1-rc1 timeout bump that depends on 1/5.
>>>    It is not yet in any released stable, so applying it to 6.18.y
>>>    would put it on an LTS before any LTS contains it.
>>>
>>>  - 5/5 (3946d3ba9934) is a doc fix for 1/5.
>>>
>>> Per stable-kernel-rules, what I need to queue is the minimum set that
>>> fixes the bug. Could you explain, per patch, why 2/5..5/5 are required
>>> to make 1/5 work / are required to actually fix the deadlock? If only
>>> 1/5 is needed, please resend just that one with your Signed-off-by
>>> added (the carried patches today only have Thomas's S-o-b, which
>>> breaks the chain of custody on a stable submission).
>>
>> Thanks for the quick review and for pointing out the missing Signed-off-by. I apologize for that omission; it was my mistake during the cherry-pick process.
>>
>> Regarding the dependency chain, I would like to clarify why commit 1/5 alone cannot fix the issue:
>>
>> Commits 1/5 and 2/5 introduce the new generic vblank timer infrastructure to the DRM core but do *not* touch the vkms driver at all.
>> Commit 3/5 (02e2681ffe1a) is the actual fix that modifies `drivers/gpu/drm/vkms/vkms_crtc.c`. It removes the buggy open-coded hrtimer that causes the ABBA deadlock and switches vkms to use the new infrastructure introduced in 1/5 and 2/5.
>>
>> Therefore, 1/5, 2/5, and 3/5 form an indivisible set. Applying only 1/5 would leave the deadlock in vkms completely unpatched.
>>
>> As for 4/5 and 5/5 (the timeout bump and doc fix), Maarten Lankhorst (DRM maintainer) explicitly recommended pulling in this exact 5-commit list as the proper upstream fix for this specific vkms issue (see the mailing list link in this thread).
>>
>> However, if you feel 4/5 and 5/5 introduce unnecessary risk for the 6.18.y stable tree, I can absolutely drop them and only submit 1/5, 2/5, and 3/5.
>>
>> I am preparing a v2 patch series now with my Signed-off-by added to the chain of custody. Could you let me know if you prefer the full 5-patch series as recommended by DRM maintainers, or just the minimal 3-patch series?
>>
>> Best regards,
>> Mingyu
>
>5/5 might strictly speaking not be needed as it's a documentation fix and I have no idea of the policy about those.
>
>The reporter made a bug report of an ABBA deadlock that was fixed in upstream by the first 4 patches, perhaps it's good to those attach here to this discussion.

I have no objection to taking all 5 if you're okay with it.

-- 
Thanks,
Sasha
