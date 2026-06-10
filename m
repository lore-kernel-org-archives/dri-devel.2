Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1AECD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0858410ECA6;
	Thu, 11 Jun 2026 04:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HbNpwvp0";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D67010ECA6
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 04:42:32 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gbVPK5Fbvz9txK;
 Thu, 11 Jun 2026 06:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781152949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6BcnN8rdSZBC0imBDjb7WvsMQmmgBw7lE2xxGdBFAc=;
 b=HbNpwvp0Zj9yuH8o2oc0btr7NocD+4rpR36lGjssYY90zRMgEJRkepCWreP4M9Nf7FWw2G
 E9HY7rp4S1MHTyX7QMMv4fee/ekSf8lduJvfBHyzesvL6A0l+8xzJosXYM3uEd5i/B7NCU
 XmguDNfQaWWdZs542ORZ1bEfxqdHnEaIn+nV+xPx+WSbnnv1kOj/dQZ9e42m4tixPkbJYf
 XCDZ2t31PxCmC6VKwmLLgG9MPT5QYc9OJeFntCCtD4Aif4NtXPkbD4xa0jiLpOWeWwgjAT
 pYs0XO2gv848HpNsiV/Bhc9ssNxU0+H+ax/skEM2e6ZHgyZiJJuhS5Ekuv7d+A==
Message-ID: <7fc8f50f-7f6d-4b45-b172-a83d97164b40@mailbox.org>
Date: Wed, 10 Jun 2026 18:31:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/39] Add i.MX95 DPU/DSI/LVDS support
To: Liu Ying <victor.liu@nxp.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Abel Vesa <abelvesa@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251011170213.128907-1-marek.vasut@mailbox.org>
 <20260605121112.27866-1-piyushpatle228@gmail.com> <aiZzxhljfyYQ68Gl@raspi>
 <9ece4e08-a77f-4410-ba16-a77b9bd0aace@mailbox.org> <aifOQtaAi_7F9hXt@raspi>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aifOQtaAi_7F9hXt@raspi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8a541f9777ff949760e
X-MBO-RS-META: trp3ppsudps4pgwo9w4hhy1o1twon399
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

On 6/9/26 10:26 AM, Liu Ying wrote:

Hello Liu,

>>>> I brought this series up on the i.MX95 15x15 FRDM (IT6263 LVDS-to-HDMI on
>>>> LVDS ch1). It mostly works, but I ran into a few issues around DI routing,
>>>> LVDS format handling, and DC enable sequencing which needed rework before
>>>> HDMI would come up reliably on the board.
>>>>
>>>> I don't see a v2 of the series and things seem to have been quiet since
>>>> November. Are you planning to post an updated version?
>>>
>>> My plan was to enable prefetch engine support[1] for i.MX8QXP display
>>> controller and add device tree for a whole i.MX8QXP LVDS display pipeline,
>>> before adding i.MX95 display controller support.
>>>
>>> Unfortunately, it seems that Marek is not a big fan of [1]
>>
>> I am fine with [1] as long as it can be isolated and does not affect every
>> SoC that might reuse this driver, which I think it can be done.
> 
> How can it be isolated?

if (compatible("mx8q"))
   something->prefetch_op = somefunction;

And then wherever is prefetch used, do

if (something->prefetch_op)
   something->prefetch_op()

Or something along those lines ?

>>> and I'm busy
>>> with downstream development so the plan doesn't move forward well.  I still
>>> think [1] makes sense(maybe I need to rebase it on latest drm-misc-next),
>>> so I'd like to see review comments on [1] and hopefully people think that
>>> the overall idea of [1] is ok.
>>
>> My only concern is, to keep it isolated to MX8Q, so this driver can be
>> reused by MX95.
>>
>>>> I've accumulated a fair amount of rework while getting this running on the
>>>> FRDM. If you're not planning a v2, I can clean things up and send one based
>>>> on the current series.
>>>
>>> I still think that i.MX95 display controller driver should be in a separate
>>> driver, rather than sharing the same driver with i.MX8QXP display controller
>>> like this patch series does, because the two display controllers are quite
>>> different as I mentioned in comments on this patch series and in discussion
>>> in [1].  Also, the common part between the two display controllers should
>>> be extracted to a common helper library as I mentioned there too.
>> Are they really? It seems this series adds support for the MX95 DC without
>> that many changes, so are the DCs really that different ? It seems the MX95
>> DC is simply a reuse/evolution of the MX8Q DC blocks, so duplicating the
>> code seems like the wrong direction, it will only lead to disparate sets of
>> bugs in two drivers, which isn't desired.
> 
> I pointed out a lot of H/W differences between the two display controllers
> during the discussions for this patch series and my i.MX8QXP prefetch engine
> patch series[1].  Please take a look at [1], which clearly shows that the
> prefetch engine would considerably impact CRTC/plane atomic callback
> implementations.

Is the prefetch engine actually grown into the CRTC/DE or not ? I 
suspect it is separate and instead part of the built-in DMA, right ?

> Display controller internal blocks would also impact
> the implementations, e.g., DomainBlend block in i.MX95 display controller
> doesn't present in i.MX8QXP display controller.  It makes sense to use
> separate drivers for the two display controllers instead of adding 'if/else'
> checks to a single driver's atomic callbacks or introducing two pairs of
> atomic callbacks to that single driver.  I mentioned before, the code to
> simply add a DRM driver(struct drm_driver) is fairly limited.

Can't we simply have two sets of ops (one for mx8q and one for mx95) for 
those ops which are too complicated to implement as a single op with 
if/else statements ?

> I also mentioned before that separate drivers make them easier to maintain:
> we don't have to test both i.MX8QXP and i.MX95 if only one display controller
> specific code is changed.

The downside is lack of code reuse, which leads to disparate sets of 
bugs in these two drivers and code duplication. And it seems to me, that 
large parts of the MX8Q and MX95 DC are effectively identical.

>> (I might not fully understand what you have in mind with the helper library
>> though?)
> 
> I said this could be something like imx-ldb-helper.c and plus perhaps some
> callbacks like fg->dc_fg_cfg_videomode().
Do you perceive that the DC driver cannot be parametrized easily enough 
that it has to be turned into a library like that ? When I look at this 
patchset, esp. the first half which updates the various blocks, it does 
not seem to me that way.
