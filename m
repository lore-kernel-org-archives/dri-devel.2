Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EC9CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF97C10E146;
	Tue, 29 Sep 2026 11:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="iT/bF8t/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqTCPQpm";
	dkim-atps=neutral
Received: from flow-a1-smtp.messagingengine.com
 (flow-a1-smtp.messagingengine.com [103.168.172.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF6310E146
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:27:29 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailflow.phl.internal (Postfix) with ESMTP id 2486C1380204;
 Tue, 29 Sep 2026 07:27:25 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Tue, 29 Sep 2026 07:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790681244;
 x=1790688444; bh=wTvvV6l4+D0DDEvQZ4FQw43WlY8/FKGuhNm/go7qrHc=; b=
 iT/bF8t/sH7Stz7uph9Y0fcqw3GQUD8oTyj95WXxH6cZxaVv3l9+WqCLaDFyvNn3
 j+3rERPsaqANGRlvCdUCN5FnYn5X7RWVmHG71amN9KfthA7WDQmyeFx0mkQAWFeS
 hAwUdDBzAVLyPNJsUYjilQsn4DmG0C61IiM0kN9mrhHPIwcKUZrk21f64cCVQAIJ
 ZCPvafg8lkk1eEgHa4xjhqGFDLEI3r6bpRG1/BOXWz1mZ0mKSpfn2SDRYQOJQo9s
 KboHWddWz8BDd8SyhZ+8bRol37acP1auXwa2KkURVSXlvfVbC69oOrHGGhD9mYgX
 UpBmkhDrJ4TKc+XFgh6XDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790681244; x=
 1790688444; bh=wTvvV6l4+D0DDEvQZ4FQw43WlY8/FKGuhNm/go7qrHc=; b=K
 qTCPQpmyqsQFARj6k0N20Mz6aA92TcwRzMupe1fF3O8d6CjX4yHaOOFqAwv4r9mY
 zcpRWpTz28gdEf3NM2V9ouc/6PiTM4hqEQl2fus5hlwqiLh9fhQvBlQhp7juqEws
 hFYGjTCdGsja8lDlPj5OPz5V75P7jeBx/00a8ds4t2QHkoV10ZnrM3L+LfboKOag
 WjgXSx0B22B2caV5SU4GvBz5Fk31dLClKF1rocoPqZx4uYl3LFOb6MqhPYvt9mLb
 hRHVJFVZISxlSaKQWaX7TatUJ+3M2yy2XOA6FYobMwwUxdxHASjQPvvZXoaLuiFv
 ax4cqIlMGs5/BQW6azJQA==
X-ME-Sender: <xms:i6C7aoI-jpEAOdaBrVX5V_qYGxK08UamsTSaBMWg8tQGWLV4Jr20bg>
 <xme:i6C7ai89IP0_SvJFrBUZdec9wW34sz22E1wmIEJsy9dwJN-q9ESldYdloRuY7GNi7
 6uGIDXChIwXimeyWcGg8SXdCHD4fYGk204A1fPewtHXTAAkSEroEeqs>
X-ME-Proxy-Cause: dmFkZTGEQyTqpDFAht/OKgejp9f8hYWmA/2GICdCvkSdg3uuYP50Haf1z67CR8BM6faFlK
 NALY3BpxgNxHIjm780QOA8qhvsbITTo9wOUnM2zMrM36EsLjvtjeJiitynZv8QTCkXD3DE
 DM0ToVVumES1jOvjudMBBTa0yOLxpqU4PQGgxpsfchLGW6y1+626bx82qpocXbtCqMJoxR
 Z1Z4EdQVrtimSPxQrOQJFLyKJn0lqc7NKABI6P2gFUwnL5KHmdLokQQDAU4r9w2jkSob6p
 +cTwJmxH8jt/ydTJUUKL52z+IeMzPNVguKInT5ePuqAP01yOUDEyPfdVaSaNNCwL8rSRrh
 oPMn/YZcvJAllqQrr7bh80UCmQAJXKnopk52y5QhfKN+dU36OohTX3A/kQFo1d3FuKjQo+
 pUcbL19ybCxrOQ+YKG36iqPjepZekmleiPK2hw86h8eVXh7Jw+Jj6VjAuo4bapmN3JoLCU
 P2uXGQ4nocZOhtDXMQrcCdwMEXpeV9i1x6KfBlj90X9lPGgNv0/+KEhnwtXmwqSx76U/3I
 zf1jj01trO1052OTFaHOgwP43HPP17CobSeubsQUvgQteYY2ixiNnvThNYLiEwih4phlzi
 DElpzYTGokMCKMp6UmnL2FJ7naxtXcoA3h6orVOircv3zTiW9VSHhDbGEytQ
X-ME-Proxy: <xmx:kqC7amhcIvecj-ULK3l7n1TynvTXBl3_PvAatfksP4zzZJq9_Wi4sw>
 <xmx:kqC7ah59wSovxYe-98CML8954xHqOcg9DghZMo88o64o_eav3dr9_g>
 <xmx:kqC7ag9WV4hjEw5rIME_K9ZWON8Z4Z7j8avngkl5_zIESNokRzPNDw>
 <xmx:kqC7ao_T9qYlnLb7BNo6saZ9-_4P0gz0ILr4GttKO_dUMdx2a7Rv_g>
 <xmx:nKC7amE87G7xekMefKYKvjgHTV8kmgxCxo1RxbL6blpJS_s0NTCmDbhg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 2F97632A008D; Tue, 29 Sep 2026 07:27:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AxWFZG7AZFUJ
Date: Tue, 29 Sep 2026 13:26:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>
Cc: "Sasha Finkelstein" <k@chaosmail.tech>, "Janne Grunau" <j@jannau.net>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Manikandan Muralidharan" <manikandan.m@microchip.com>,
 "Dharma.B" <dharma.b@microchip.com>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Jagan Teki" <jagan@amarulasolutions.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>,
 "laurent.pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Liu Ying" <victor.liu@nxp.com>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Doug Anderson" <dianders@chromium.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Chun-Kuang Hu" <chunkuang.hu@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Rob Clark" <robin.clark@oss.qualcomm.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>,
 "Marijn Suijten" <marijn.suijten@somainline.org>,
 "Marek Vasut" <marex@denx.de>, "Stefan Agner" <stefan@agner.ch>,
 "Orson Zhai" <orsonzhai@gmail.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Chunyan Zhang" <zhang.lyra@gmail.com>, "Jyri Sarha" <jyri.sarha@iki.fi>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Icenowy Zheng" <zhengxingda@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Message-Id: <4a566036-af8c-494e-9749-cd713d952d39@app.fastmail.com>
In-Reply-To: <DLRMF4TI56I2.3PTB24KN9ORJ3@bootlin.com>
References: <20260928161605.2271412-1-arnd@kernel.org>
 <DLRMF4TI56I2.3PTB24KN9ORJ3@bootlin.com>
Subject: Re: [PATCH] drm/bridge: add missing drm/drm_panel.h inclusions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

On Tue, Sep 29, 2026, at 09:27, Luca Ceresoli wrote:
> On Mon Sep 28, 2026 at 6:04 PM CEST, Arnd Bergmann wrote:

>
> So I see two option for a better fix:
>
>  * Option 1 -- fix the really affected drivers by switching from the
>    deprecated API to the one they recommended one. Based on quick analysis
>    there are about 6.
>
>  * Option 2 -- a quick surgical fix:
>
>    In drm_of.h:
>
>      #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
>       #include <linux/of.h>
>       #include <drm/drm_bridge.h>
>      -#include <drm/drm_panel.h>
>       #endif
>      +#include <drm/drm_panel.h> /* Temporary for *_of_get_bridge() */
>
>    This can easily be tracked and reverted once all
>    devm_drm_of_get_bridge() users are converted to
>    of_drm_get_bridge_by_endpoint().
>
> I'm working right now on option 1, hoping to get a series in a few hours
> from now.

Sounds good to me.

> I can switch to option 2 in case of unexpected issues with option
> 1, or if a fix "really right now" is wanted.

It's only really a problem for randconfig build bots, so as long as
you are fine with getting more reports (and possibly patches from
others) until your fix is in linux-next, I don't think we need
another workaround first.

I've added your new series on my randconfig tree in place of my
patch and will let you know if something comes up. 

     Arnd
