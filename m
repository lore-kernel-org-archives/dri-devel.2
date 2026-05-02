Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE817CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 21:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D4510E2C2;
	Sat,  2 May 2026 21:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="knvsL8k1";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAE310E2C2
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 21:25:20 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g7LXs1LTVz9tjW;
 Sat,  2 May 2026 23:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777757117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krWvEte6rzYQK7UVqWb8Xrr0bPg1zlcGnKUfpj6lNEw=;
 b=knvsL8k12JbPXpYAlE9cBexu30rqoUtTFLzP18ypZSmRCQPvA/hch4OLnCGgip9mSiF17t
 2sFEMq2QuB84fTcucGgg+aAC1VQ/v1WOjLI4xQTvz1zpaaSH3YUELU//a2fRpHLY7DNnL0
 +01jP0ak5enIm3CWv2Zvz3YEheA7CdBHUeATtHWkFO20v1Td4XLRx38Tx4qS7uBOUvwo0N
 Qry9PMuiJ+vXurTP60Wc3kNEGqOJLdM2ckDM4IcwIZOoId2ryzCZIhDB9Vv8Jf7qa850BO
 L8PCX6o4eBHX6TmsUL5qXFs8bZx0q3skIid21QoyjqrksGWRrn0panx7kh/EYQ==
Message-ID: <321547f5-40b6-449f-8a6e-5396b70823e6@mailbox.org>
Date: Sat, 2 May 2026 23:25:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] drm/rcar-du: Add support for Renesas R-Car R8A779MD
 M3Le
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-3-marek.vasut+renesas@mailbox.org>
 <CAMuHMdUHKQwX43=c9JR67=x1EvWzdHTiXdUnPV2bDKU7PV_EnA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdUHKQwX43=c9JR67=x1EvWzdHTiXdUnPV2bDKU7PV_EnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wgjgs6jskon4uskfcndud97puhskkd3w
X-MBO-RS-ID: 03f2f67987000091c2f
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

On 4/29/26 12:10 PM, Geert Uytterhoeven wrote:

Hello Geert,

> On Sun, 19 Apr 2026 at 21:37, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>> Add support the Renesas R-Car R8A779MD M3Le SoC. This SoC is
>> similar to R-Car R8A77965 M3-N SoC, except the HDMI port@1 is
>> not present.
> 
> "and DU1 is unused." (whatever that may mean...)

Fixed in V2.

>> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
>> @@ -564,6 +564,30 @@ static const struct rcar_du_device_info rcar_du_r8a779h0_info = {
>>          .dsi_clk_mask = BIT(0),
>>   };
>>
>> +static const struct rcar_du_device_info rcar_du_r8a779md_info = {
> 
> Assuming for this review we do need a new compatible value...

I will be dropping this part in V2.

[...]

>>   static const struct of_device_id rcar_du_of_table[] = {
>>          { .compatible = "renesas,du-r8a7742", .data = &rcar_du_r8a7790_info },
>>          { .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
> 
> I also don't know where "M3Le does not support 4K output." (which is
> a VSP2 limitation) is to be handled.
R-Car Gen3 RM R19UH0105EJ0230 Rev.2.30 Aug 31, 2021
Page 2468
32.1.1.1 Features of VSPI [R-Car H3/R-Car H3-N/R-Car M3-W/R-Car 
M3-W+/R-Car M3-N/R-Car E3]
point Video processing and point Performance of VSPI
indicates R-Car E3 has similar limitation due to VSP bandwidth.

Currently, this seems to be up to user to avoid the higher resolution 
operation on hardware which has lower VSP bandwidth.
