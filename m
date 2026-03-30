Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CED11061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C048110E7C9;
	Mon, 30 Mar 2026 15:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xW8RPQAX";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03ED910E6A0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 15:47:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 079984E42871;
 Mon, 30 Mar 2026 15:47:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C7EB55FFA8;
 Mon, 30 Mar 2026 15:47:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8693104505B1; 
 Mon, 30 Mar 2026 17:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774885657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1aTpyd+0/mSU/s+c0fNfX3pIn8QwVOQZDTaD5Bg1dRU=;
 b=xW8RPQAXdsgEPWs8JAXpw7qKfhkRJwFTssKu/pCYpXKdD0k3EpKzzFUMSC4jTPa6ha01OP
 ell4Cyq42Pef0NFr1nkLE9wFav3TJ0wNOIBoHEnRkxxVhcpemnPRAR3tSCfpSs6Ey7VkHr
 TOdEUjvFf5phGcGYzOoxQwf5Ifg+s7hMaf63HnEo8Q18bSj8gjgWkzMkzyG0tOVOZbgRil
 BTTi+uv98pOhS29laOmj8YfGLErilsrSZN2gU7edGsqDRBmp9el03ejLQiHrBqbKsfFhGa
 a0i4TpnHjLdS8Bci2iz0h3DuF34ACgZEomSMpODsX5K4HB5gv1c+LN22Cq49kw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 17:47:23 +0200
Message-Id: <DHG8G8FMXA6C.U6LU563OZ8NR@bootlin.com>
To: "Liu Ying" <victor.liu@nxp.com>, "Marek Vasut" <marex@denx.de>, "Stefan
 Agner" <stefan@agner.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 7/8] drm/bridge: imx8mp-hdmi-tx: add an hdmi-connector
 when missing using a DT overlay at boot time
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, "Adam Ford" <aford173@gmail.com>, "Alexander
 Stein" <alexander.stein@ew.tq-group.com>, "Anson Huang"
 <Anson.Huang@nxp.com>, "Christopher Obbard"
 <christopher.obbard@linaro.org>, "Daniel Scally"
 <dan.scally@ideasonboard.com>, "Emanuele Ghidoli"
 <emanuele.ghidoli@toradex.com>, "Fabio Estevam" <festevam@denx.de>,
 "Francesco Dolcini" <francesco.dolcini@toradex.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Gilles Talis" <gilles.talis@gmail.com>,
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, "Heiko
 Schocher" <hs@denx.de>, "Joao Paulo Goncalves"
 <joao.goncalves@toradex.com>, "Josua Mayer" <josua@solid-run.com>, "Kieran
 Bingham" <kieran.bingham@ideasonboard.com>, "Marco Felsch"
 <m.felsch@pengutronix.de>, "Martyn Welch" <martyn.welch@collabora.com>,
 "Oleksij Rempel" <o.rempel@pengutronix.de>, "Peng Fan" <peng.fan@nxp.com>,
 "Philippe Schenker" <philippe.schenker@toradex.com>, "Richard Hu"
 <richard.hu@technexion.com>, "Shengjiu Wang" <shengjiu.wang@nxp.com>,
 "Stefan Eichenberger" <stefan.eichenberger@toradex.com>, "Vitor Soares"
 <vitor.soares@toradex.com>
X-Mailer: aerc 0.20.1
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-7-479a04133e70@bootlin.com>
 <544112ab-8ca0-4622-b680-233457198e3e@nxp.com>
 <DHDNA5HLQPIB.3F21G9QPBUQG8@bootlin.com>
 <5f06ea5a-5388-440f-91d6-cebb0bee0a88@nxp.com>
In-Reply-To: <5f06ea5a-5388-440f-91d6-cebb0bee0a88@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Liu,

On Mon Mar 30, 2026 at 5:02 AM CEST, Liu Ying wrote:
>>>> --- a/drivers/gpu/drm/bridge/imx/Kconfig
>>>> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
>>>> @@ -25,6 +25,23 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>>>>  	  Choose this to enable support for the internal HDMI encoder found
>>>>  	  on the i.MX8MP SoC.
>>>>
>>>> +config DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP
>>>> +	bool "Support device tree blobs without an hdmi-connector node"
>>>> +	default y
>>>
>>> depends on DRM_IMX_LCDIF ?
>>
>> If the imx hdmi-tx is not enabled then HDMI won't work anyway, so users =
are
>> not affected and the overlay is not needed. Am I missing something?
>
> I meant I'm fine with "default y" and think that this could also depend o=
n
> DRM_IMX_LCDIF, because no display controller driver other than the LCDIF
> driver needs the fixup.

Ah, I see your point. OK, I'll add 'depends on DRM_IMX_LCDIF'.

>>> I see build warnings(W=3D1):
>>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:25.8-37.=
4: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0: node has a=
 unit name, but no reg or ranges property
>>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:26.16-36=
.5: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c000=
00: node has a unit name, but no reg or ranges property
>>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:27.18-35=
.6: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c000=
00/hdmi@32fd8000: node has a unit name, but no reg or ranges property
>>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:29.13-33=
.8: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c000=
00/hdmi@32fd8000/ports/port@1: node has a unit name, but no reg or ranges p=
roperty
>>
>> AFAIK the device tree checkes just can't work on overlays. The tools jus=
t
>> cannot know on which base tree the overlay can be applied, so they canno=
t
>> know the existing properties. That might change in the future, but for n=
ow
>> my understanding is that it is OK to have overlays which produce such
>> harmless warnings, at least for driver-specific overlays like the tilcdc
>> one [0] which is already in linux-next since a few weeks.
>
> Hmm, not sure a few weeks in linux-next is long enough ;)
> I'd say, I saw the warnings, so simply reported along with a fix to suppr=
ess
> them.  TBH, build warnings make me nervous, especially this DT overlay is
> under the "DRM DRIVERS FOR FREESCALE IMX BRIDGE" umbrella.

That's fine, I'll add the lines needed to suppress the warnings then.

>>>> +	fixup-hdmi-connector {
>>>> +		compatible =3D "hdmi-connector";
>>>> +		label =3D "HDMI";
>>>> +		type =3D "a";
>>>
>>> What if a board uses another type?
>>
>> For boards affected by this patch, currently the connector is created by
>> dw_hdmi_connector_create() which hardcodes type A [0], so there would be=
 no
>> difference.
>
> Yes, that's from driver's PoV.  However, userspace may get the type
> from /sys/firmware/devicetree/base/fixup-hdmi-connector/type and use it
> to do something.

I'd say this is incorrect, the device tree is not an API for that. The
connector type might be known to the driver by other means (ACPI, DP MST,
whatever). So I think this is a non-problem.

If userspace needs to know the connector type, that should come from the
ioctl (DRM_IOCTL_MODE_GETCONNECTOR perhaps).

> Maybe, that's trivial.

Not sure I got what you mean here, sorry. What are you referring to?

>> OTOH how can a common module know the specific connector?
>
> Hmm, maybe add a module parameter or let users set the type through Kconf=
ig

I'm afraid none of this would work for distribution kernels, where who
configures the distribution has no idea on how many different hardware it
will run.

> or even define an unknown type to honestly tell users that we don't know =
it?

This sounds like a potentially valid idea, even though I'm not fully
convinced. Also I suspect it would be a pretty large change, and also
adding "unknown type" in the device tree seems not compliant with the rule
that DT describes the hardware (not the lack of info about the hardware).

But definitely it's not needed for this specific case, because:

 * with current code, every imx8mp-hdmi-tx usage adds a type-A connector [0=
]
 * with this patch the correct type will be created when described in DT,
   and type-A will be used only as a fallback when the DT is lacking

So after the patch we'd do sometimes better, never worse in this respect.

Based on the above I'm sending v2 soon, but don't hesitate in following up
in case I may be missing something (this topic is tricky).

[0] https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/gpu/drm/bridge=
/synopsys/dw-hdmi.c#L2601

>> Boards with a different connector should describe the connector in the
>> device tree, if they need to instantiate the exact type.

I think this is the only valid solution. It's very easy to do, nothing new
to invent.

Maybe on top of that we could add a warning when the overlay is applied,
e.g. "imx8mp-hdmi-tx used without a connector described in device tree;
adding a type A connector as a fallback; please add a valid description to
your device tree". Maybe pointing to a TODO entry in the documentation.

What do you think about this?

Thanks again for your careful review!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
