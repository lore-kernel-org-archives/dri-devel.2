Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15491EBFD12
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C4C10E34C;
	Mon, 13 Apr 2026 07:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="YiF7gnnw";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7703610E34C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:59:24 +0000 (UTC)
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
 by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fvKYk34fhz67KB;
 Mon, 13 Apr 2026 09:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1776067162;
 bh=LejCnxnvuVcA8k5XFW78fIGB7kn4dCmYvIYPy1OnQd8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YiF7gnnwOaBS3LIH0gMZqDFPfFu4xTRIskTOfqdGPYQ89agnajSqWVeqqs8eTuCo4
 WvkFNzC1PG9N0zu+ugEvEXN7c+T+DLelmr5vHEQqV+7ojgNY5dsTWdlttkI6+19E4b
 6/7FHsIX18AThgKWQOR5GYB+P711WwKn/Z5ISwWE4S+3+yd1r2g4ut/NOGsq6+sHoW
 6a1b1MvJS+u1VSegaDjuXNJDO3xPSEJZgxoMhnO6o22dx4bowApYNGonZtJqH9FHuQ
 mq6Cch0TDgox1orQWDtiSh2fG2GKqFK38sZfQcupNwt8YYRezdAfUWYEBWzSJ8PGac
 OH8dN++in6oCQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fvKYG00hMz4yW8;
 Mon, 13 Apr 2026 09:58:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fvKYD5DF5z8tdJ;
 Mon, 13 Apr 2026 09:58:56 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 16478635EC;
 Mon, 13 Apr 2026 09:58:55 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <9c667182-3a9e-4fa3-a568-1cb5b1b74106@leemhuis.info>
Date: Mon, 13 Apr 2026 09:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warnings and errors in drm_mode_config_cleanup when booting
 6.19.10 and 7.0-rc5
To: Greg KH <gregkh@linuxfoundation.org>, Matt Fagnani <matt.fagnani@bell.net>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Sasha Levin <sashal@kernel.org>
References: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
 <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
 <2026040259-glacial-reversal-9a75@gregkh>
 <35ed8f9a-66c2-40c3-a545-da4af629014f@bell.net>
 <2026040609-script-perpetual-16bb@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026040609-script-perpetual-16bb@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177606713563.3612511.1360759713173666767@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 16478635EC
X-NC-CID: rWZXVsGMoy449/T/o1Pn7niXYiHQXQsBzfi/7AgSvrWrnJtBrZU=
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

[CCing Sasha]

On 4/6/26 10:17, Greg KH wrote:
> On Mon, Apr 06, 2026 at 03:54:39AM -0400, Matt Fagnani wrote:
>> On 2026-04-02 08:12, Greg KH wrote:
>>> On Sat, Mar 28, 2026 at 11:52:48AM +0100, Thorsten Leemhuis wrote:
>>>> On 3/28/26 11:30, Matt Fagnani wrote:
>>>>> I could try to bisect. The commit
>>>>> e493c135980f90c20308d1a98f2e0d1223951e94 drm: Fix use-after-free on
>>>>> framebuffers and property blobs when calling drm_dev_unplug was included
>>>>> in 6.19.10 and changed drm_mode_config_cleanup https://git.kernel.org/
>>>>> pub/scm/linux/kernel/git/stable/linux.git/commit/?
>>>>> h=linux-6.19.y&id=e493c135980f90c20308d1a98f2e0d1223951e94
>>>> Did a quick search. Turns out this is mainline commit 6bee098b914176
>>>> ("drm: Fix use-after-free on framebuffers and property blobs when
>>>> calling drm_dev_unplug") [...] is turns out that is in the
>>>> process of getting reverted:
>>>>
>>>> See https://lore.kernel.org/all/20260326082217.39941-2-dev@lankhorst.se/
>>>> or 45ebe43ea00d6b ("Revert "drm: Fix use-after-free on framebuffers and
>>>> property blobs when calling drm_dev_unplug"") [next-20260327
>>>> (pending-fixes)].
>>>> Sasha and Greg: you might want to make sure to pick this up.
>>> When it shows up in a Linus-released kernel, can someone remind us?
>> 7.0-rc7 https://lwn.net/Articles/1066405/ had the patch Revert "drm: Fix
>> use-after-free on framebuffers and property blobs when calling
>> drm_dev_unplug" https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.0-rc7&id=45ebe43ea00d6b9f5b3e0db9c35b8ca2a96b7e70 Thanks.
> 
> Does not apply on 6.6.y or 6.1.y, so can someone provide a working
> backport for those branches?

Hmm, those two got manual backports Sasha did, so he might be in the
best position to submit the reverts, too.

But to save you two a few cycles I just prepared those reverts and will
submit them in reply to this mail. Handle with care, as they are
untested. Not really sure if this was a wise idea at all. In case of
problems it might be the best if one of you could redo them from scratch
in case you have scripts to handle situations like these.

Ciao. Thorsten
