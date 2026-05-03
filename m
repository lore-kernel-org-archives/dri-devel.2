Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0975FCD13DA
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 00:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4355D10E10B;
	Sun,  3 May 2026 00:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jysqW7jA";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB57510E10B
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 00:11:37 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g7QDk6sXSz9tRD;
 Sun,  3 May 2026 02:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777767095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBbGG49lvszkSs6r+vkoyB+q5ycwyPUBvGTobwqzXCY=;
 b=jysqW7jAuDFJrbua8FgWRyjdkmFUEE3iRBd6BzYPCL/hjHNKhq/AgbzZZgkZhOUQDQU+pJ
 ahFjUj3IB9jL++70DEsokWc+NrPeaVURtK2Z0c/5MAEptyxrW23tDQph3dL7ByjW+WvowP
 iFQCCEhTJaLnIbsnHaS+ZeRkiRj89a4Cn77U2MlR6Mpd1aK7vfhF85jPwF1zJehov1wKUA
 0miMQTqWQNhbM6MQCR51Zju7C/4XvZqBeIfVlyN+F8vIDMkoV2wwbAHvIUj8iQ4W7a+z2T
 zkq1WTNX5jj6xJk5UiRQPtbvDBAv2/Y9PRv4/twjkNg7OaVNI8a6oT3qa7d5sw==
Message-ID: <7e4283f1-c179-45e4-a8ee-5026e467fd21@mailbox.org>
Date: Sun, 3 May 2026 02:11:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a779md: Add Renesas R-Car
 R8A779MD M3Le DTs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
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
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-7-marek.vasut+renesas@mailbox.org>
 <CAMuHMdV5NRFjGmLLSAFkst=y_v=haZ9_-oiZ7_3M2J1s5jiJSQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdV5NRFjGmLLSAFkst=y_v=haZ9_-oiZ7_3M2J1s5jiJSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5b19e038c16ec512322
X-MBO-RS-META: bs89hkih9ipn8s579q3adtcmkkc76bmw
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

On 4/29/26 2:16 PM, Geert Uytterhoeven wrote:

Hello Geert,

[...]

>> +/delete-node/ &pciec1;
>> +/delete-node/ &sata;
>> +/delete-node/ &sdhi3;
> 
> I am not sure disabling sdhi3 is correct.
> The R-Car M3Le documentation says:
> 
>     "M3Le does not support MMC1.
>      M3Le supports one MMC channel (MMC0) only.
>      SD3 is used only for SDHI and is not used for MMC.
>      M3Le does not support MMC HS400 class transfer rate."
> 
> The main R-Car Gen3 documentation says:
> 
>     "This LSI has four SD card interfaces (SDHI0 to SDHI3), two of
>      which can also be used as MMC interfaces (SDHI2 and SDHI3)."
> 
> So while MMC1 is indeed sdhi3, sdhi3 can still be used in SD mode?
> Do we need a new compatible value, as R-Car M3Le does not support HS400?

I think we do need new compatible string, yes, I'll include that in V2.

We can inhibit MMC support in sdhi3 with 'no-mmc' DT property, which I 
will also include in V2.

[...]

>> +/delete-node/ &vin7csi20;
>> +/delete-node/ &xhci0;
> 
> Shouldn't the following be disabled, too?
>    - ohci1, ehci1, and usb2_phy1,

Yes, they should.

>    - cmm1 and vspd1 (cfr. DU below).

Please see my response to Laurent in here in
[PATCH 6/7] arm64: dts: renesas: r8a779md: Add Renesas R-Car R8A779MD 
M3Le DTs
as well as my response to
[PATCH 1/7] dt-bindings: display: renesas,du: Document Renesas R-Car 
R8A779MD M3Le

The CMM1 and VSP1 are actually present, so I think the DT should 
describe them, even if they are not used. If only to allow the 
driver(s)to bind to those IPs and bring them to low power state.

>> +
>> +&du {
>> +       compatible = "renesas,du-r8a779md";
> 
> Assuming the DU needs a new compatible value...
> 
>> +       renesas,cmms = <&cmm0>, <&cmm3>;
>> +       renesas,vsps = <&vspd0 0>, <&vspd1 0>;
> 
> Shouldn't this be
> 
>      renesas,vsps = <&vspd0 0>, <&vspd0 1>;
> 
> ? DU1 is unused, but DU3 is used.
It should, and will be fixed in V2, thanks !

[...]
