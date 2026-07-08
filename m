Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EEEC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A652189F1B;
	Wed,  8 Jul 2026 07:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="Ytoxyc2O";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A479689E9E;
 Wed,  8 Jul 2026 07:26:10 +0000 (UTC)
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
 by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gw8lh34ZRz8jSJ;
 Wed,  8 Jul 2026 07:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1783495568;
 bh=5LY8bT/imNZ0hDGVYBvbl9k4q5/qGxMeYoSJ3UOyGZc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ytoxyc2OPyMSmUmUMu7ZeFnUOUzZncMUH40tlVsTO8Li29lqsDrRbUWH3oSTMioOb
 VehXUIwJdz99wPIW1QW5cP0eTW4YDcvGq6BvyLIpoGQt5n0paxWQHm+8jfPDITyU+P
 clwrLO+UPjxDBtdtRe0hZazd2NkzQQYBNQsIZ4UcXslzcjQRgSkrpHN/5p/0kCGM7T
 1dMNhrMM4jK/1n+8QXoFb+ZP2t8Xz3MUMxslfDk/uXNN/+VpBI2m7+o/8vnqpW/B0O
 U+1x3V1tedRHtmYBzqvsZL4u1coYa/60fZUjbIRYbJWxLjtYOSlbs+AR340HJFaQ+/
 ELwOep5dT5J3w==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gw8lh2M55z8jS3;
 Wed,  8 Jul 2026 07:26:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gw8ld5ZtWz8tcn;
 Wed,  8 Jul 2026 09:26:05 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 15ED960387;
 Wed,  8 Jul 2026 09:26:05 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <493b8d4c-164e-43c9-93c8-40cc251b1c3b@leemhuis.info>
Date: Wed, 8 Jul 2026 09:26:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL init
 in bonded mode"
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, vishnu.saini@qualcomm.oss.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
 <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
 <wrhuksrzlxw2pjlvjm37dwjuztcv7qs5t6mqiav4ujecwqdkwj@ozbfxpbgaimt>
 <CAJfMnmEVwUwt=wMJ-8HKH1yz9+erWLrRGB+6wVYCdSGDK+_T_Q@mail.gmail.com>
 <114b9be8-1fca-4762-822e-1d53838d5de5@leemhuis.info>
 <o64cxeq5f4ffqpdmbai5cvsmxei2cnw3p6acvu55xl3cj5w3z3@6o6kokszvng7>
 <akt6z1irWlXA5UIy@hu-mdsor-hyd.qualcomm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <akt6z1irWlXA5UIy@hu-mdsor-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178349556544.3070247.15236089481411826401@mxe9fb.netcup.net>
X-NC-CID: RfHKFpT+VIRJGSr9fXRLCpQG9SZhPbl2OkmSxD8gg/EiR9ID1hk=
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

On 7/6/26 11:52, Mohit Dsor wrote:
> On Wed, Jun 03, 2026 at 03:11:34PM +0300, Dmitry Baryshkov wrote:
>> On Wed, Jun 03, 2026 at 11:56:15AM +0200, Thorsten Leemhuis wrote:
>>> On 5/4/26 22:09, Mohit Dsor wrote:
>>>> Sorry for the late reply. I am attaching clk_summary and reg_dump in
>>>> working and non working case. Lilliput is just a normal display working
>>>> with hdmi and has 720p as preferred mode. Yes, I was talking about RB3
>>>> Gen2 only.
>>>
>>> Neil, Dmitry, and Mohit: what's the status here? From the outside it
>>> looks like this regression is still unfixed with nothing happening for
>>> weeks now. Or has progress been made and I just missed it?
>>
>> Thanks as a reminder. Unfortunately, it takes some more time (and I've
>> been a bit overloaded lately). Worst case I will send a revert soon.
>>
> Just wanted to check if you had a chance to look into this issue and whether there's any update on the investigation from your side.
Hmm, no reply. Given that we are entering holiday season and are way
past what Linus expects in a situation like this[1] I'd say we should go
for a revert, unless some fix shows up really soon now.

Ciao, Thorsten

[1] To quote Linus statements from
https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed

"""
From 2026-01-22:

 But a user complaining should basically result in an immediate fix -
 possibly a "revert and rethink".

With a later clarification on 2026-01-28:

 It's also worth noting that "immediate" obviously doesn't mean "right
 this *second* when the problem has been reported".

 But if it's a regression with a known commit that caused it, I think
 the rule of thumb should generally be "within a week", preferably
 before the next rc.
"""
