Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EAFEF4EC2
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 09:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1135710E220;
	Mon,  6 Apr 2026 09:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bell.net header.i=@bell.net header.b="1WPpa+t9";
	dkim-atps=neutral
X-Greylist: delayed 369 seconds by postgrey-1.36 at gabe;
 Mon, 06 Apr 2026 08:00:55 UTC
Received: from cmx-mtlrgo001.bell.net (mta-mtl-008.bell.net [209.71.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C3810E1F4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1;
 t=1775462455; bh=ee/ibGxRB7ZMYV1LgEYDA/tCFpV2VxAtOGiEdEyBcsk=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
 b=1WPpa+t9OdVfWJu1FH7Hm60f2ss1ixu9e37UQjlpxiKW3+csgp4SLp19r75OXdAWYrIyyQRMPY8GxBwCpPJaDoU6r/MHKsFtfA9kludx9EYMus7fWHgZKWIT03nHX1FgZPXjYZ0qo/78RbinGSZUXAv8eDn+hvqv6XVnoYNVJQ3Z2NF5+wYAeeYmboJATkK3QFuBTSfjHO3+fL/55rK0VzSGRXKfY0sZyx0un/FW/iOHzyoqxb+c6H9eP3ZMGjOtbR5kjU8NlLy4lovBZs2yX9tCEhbvaIWgJWWQXHqzkqsdtJxBjPf1RKv7IXFW5eKgbfuITYZBu64NFlpD/uBTcg==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-Originating-IP: [70.48.33.60]
X-RG-Env-Sender: matt.fagnani@bell.net
X-RG-Rigid: 69BEEF93021C3F91
X-RazorGate-Vade: dmFkZTEwdeOu4RFMK0bgxNPhFO6olhcTTPjSXyYQ4ESBdvLEPeNsUtn3i7fQCRLygdbADflYYybHj4BpueTVDOTen5ln1JzbdbKHPhTdhhNQSLcVDkQSvwmtB/nskwz+3ltD5Q4mkjsTsd44WDJx1Jhf04HOzT6Ahy/SdkZI0bV6rpHFmy+ylGlX1Z/lGDxd60P3IDn0oOGXtbd2LRu0Um5eAc4M6dlHsFDZidudjBt0ahqdC5utZ/5K7NDOTgENJ1od7VGPqDLexbGrCoMXBY2VQfhP6dD6OAOtl99YVPkXE+61JFCnh9u7Rt5zAqM7b4+ccpVjxoUeCXYCtD260Ovj9xE9Zh9xUyJqBzI9lUKyzNqutU5h61q5RpyLOHEkjL2DJt4oOPz12sZWcUuphO+RzrqtWpyGMw7Lb4+pvFsT79hg57kJipIFSkdxxGjGKbKdZkXEk8q4EGLdoIzqmUA4DgL9AvydlmkO0iucHSlsTgLYIKxCV7hVeIGSsb/0U2YNHu4JjpgTb/f00JtrAgZQOOf6HQKWegpwNVQUzr5pv612elDG4/EKQRPgDmND7CmfaAxsrsqMINDk5op5S34PrkGxlfG/dAgolhSXJ/fiLatEaTSgTm4fJI9m6Z4N3W97Iqo7D/V+hAZOn+ch4vKeNyvFE9N9CLbSw/SAvzo5EppQyw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.10] (70.48.33.60) by cmx-mtlrgo001.bell.net
 (authenticated as matt.fagnani@bell.net)
 id 69BEEF93021C3F91; Mon, 6 Apr 2026 03:54:40 -0400
Message-ID: <35ed8f9a-66c2-40c3-a545-da4af629014f@bell.net>
Date: Mon, 6 Apr 2026 03:54:39 -0400
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: Warnings and errors in drm_mode_config_cleanup when booting
 6.19.10 and 7.0-rc5
To: Greg KH <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
 <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
 <2026040259-glacial-reversal-9a75@gregkh>
Content-Language: en-US
From: Matt Fagnani <matt.fagnani@bell.net>
In-Reply-To: <2026040259-glacial-reversal-9a75@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 09:22:48 +0000
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

On 2026-04-02 08:12, Greg KH wrote:
> On Sat, Mar 28, 2026 at 11:52:48AM +0100, Thorsten Leemhuis wrote:
>> Matt, thx for the report.
>>
>> On 3/28/26 11:30, Matt Fagnani wrote:
>>> I could try to bisect. The commit
>>> e493c135980f90c20308d1a98f2e0d1223951e94 drm: Fix use-after-free on
>>> framebuffers and property blobs when calling drm_dev_unplug was included
>>> in 6.19.10 and changed drm_mode_config_cleanup https://git.kernel.org/
>>> pub/scm/linux/kernel/git/stable/linux.git/commit/?
>>> h=linux-6.19.y&id=e493c135980f90c20308d1a98f2e0d1223951e94
>> Did a quick search. Turns out this is mainline commit 6bee098b914176
>> ("drm: Fix use-after-free on framebuffers and property blobs when
>> calling drm_dev_unplug") -- and when searching for that (FWIW, this is
>> not widely known, but that is really helpful in case like this, as the
>> mainline commit id is way more relevant) is turns out that is in the
>> process of getting reverted:
>>
>> See https://lore.kernel.org/all/20260326082217.39941-2-dev@lankhorst.se/
>> or 45ebe43ea00d6b ("Revert "drm: Fix use-after-free on framebuffers and
>> property blobs when calling drm_dev_unplug"") [next-20260327
>> (pending-fixes)].
>>
>> Sasha and Greg: you might want to make sure to pick this up.
> When it shows up in a Linus-released kernel, can someone remind us?
>
> thanks,
>
> greg k-h

7.0-rc7 https://lwn.net/Articles/1066405/ had the patch Revert "drm: Fix 
use-after-free on framebuffers and property blobs when calling 
drm_dev_unplug" 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.0-rc7&id=45ebe43ea00d6b9f5b3e0db9c35b8ca2a96b7e70 Thanks.

Matt


