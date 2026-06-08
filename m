Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979E0CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E801110F6F0;
	Mon,  8 Jun 2026 16:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AQE2xXfN";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DF310F6F0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:29:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gYyDd4cMlz9v04;
 Mon,  8 Jun 2026 18:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780936177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbSbELZ/qhJGz8m9PkFP4eZM/CFetLN6lwudktuynGY=;
 b=AQE2xXfNVLdb0zenRfKtc1yr7vSNa3ByjQ0rIG1J/Ql0m4lBUCNWwtIrp3znIEbEDtsn8h
 IMGOPgaK0+eCY7j1maEAItCcpQPyKJ7EnszJxY220kDYTU1J8pgWVcgvGRJmW0qTbOaB7D
 qeMglUL8Fp+gPnHx9kzN5tpB+fajuXZY5KKPH9qumH7BnQAdWg/B3XKTwzgUFL6SO75SDb
 I5g9Edd+BUNNLOAWjCxWxqIjDWMrqVw4VbJUSHIwz3efT8YHbNLMTMiFiMwwvEDuL+L9K0
 a3UnfU9QVReNX3lcogtEW1Jj6oSeI1xs5OgCPqZoaRRXyNJHAUHpGEwOl8uTtg==
Message-ID: <9ece4e08-a77f-4410-ba16-a77b9bd0aace@mailbox.org>
Date: Mon, 8 Jun 2026 18:29:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/39] Add i.MX95 DPU/DSI/LVDS support
To: Liu Ying <victor.liu@nxp.com>, Piyush Patle <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Abel Vesa <abelvesa@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251011170213.128907-1-marek.vasut@mailbox.org>
 <20260605121112.27866-1-piyushpatle228@gmail.com> <aiZzxhljfyYQ68Gl@raspi>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aiZzxhljfyYQ68Gl@raspi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yf38h31tgdjwq7mde8h8omnc7sio8pks
X-MBO-RS-ID: 587bbf07cc5c34a1000
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

On 6/8/26 9:48 AM, Liu Ying wrote:

Hello everyone,

>> I brought this series up on the i.MX95 15x15 FRDM (IT6263 LVDS-to-HDMI on
>> LVDS ch1). It mostly works, but I ran into a few issues around DI routing,
>> LVDS format handling, and DC enable sequencing which needed rework before
>> HDMI would come up reliably on the board.
>>
>> I don't see a v2 of the series and things seem to have been quiet since
>> November. Are you planning to post an updated version?
> 
> My plan was to enable prefetch engine support[1] for i.MX8QXP display
> controller and add device tree for a whole i.MX8QXP LVDS display pipeline,
> before adding i.MX95 display controller support.
> 
> Unfortunately, it seems that Marek is not a big fan of [1]

I am fine with [1] as long as it can be isolated and does not affect 
every SoC that might reuse this driver, which I think it can be done.

> and I'm busy
> with downstream development so the plan doesn't move forward well.  I still
> think [1] makes sense(maybe I need to rebase it on latest drm-misc-next),
> so I'd like to see review comments on [1] and hopefully people think that
> the overall idea of [1] is ok.

My only concern is, to keep it isolated to MX8Q, so this driver can be 
reused by MX95.

>> I've accumulated a fair amount of rework while getting this running on the
>> FRDM. If you're not planning a v2, I can clean things up and send one based
>> on the current series.
> 
> I still think that i.MX95 display controller driver should be in a separate
> driver, rather than sharing the same driver with i.MX8QXP display controller
> like this patch series does, because the two display controllers are quite
> different as I mentioned in comments on this patch series and in discussion
> in [1].  Also, the common part between the two display controllers should
> be extracted to a common helper library as I mentioned there too.
Are they really? It seems this series adds support for the MX95 DC 
without that many changes, so are the DCs really that different ? It 
seems the MX95 DC is simply a reuse/evolution of the MX8Q DC blocks, so 
duplicating the code seems like the wrong direction, it will only lead 
to disparate sets of bugs in two drivers, which isn't desired.

(I might not fully understand what you have in mind with the helper 
library though?)
