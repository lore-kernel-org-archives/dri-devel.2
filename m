Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EFBFF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850E110E05F;
	Tue, 31 Mar 2026 10:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="M+B7mJwU";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9503610E05F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:54:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D39991A30BF;
 Tue, 31 Mar 2026 10:54:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9BF5A602CD;
 Tue, 31 Mar 2026 10:54:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4F8B6104505CA; 
 Tue, 31 Mar 2026 12:54:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774954487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qDgz531RmkefuEvnhqpL6F+0n4jtWlVFpT0D9ukPSnc=;
 b=M+B7mJwUdJ737gkyUjDrg4ZfLPjmt2IDlaNDsNRqt54vtdI6gQ+Mkj7hI5XdBJLv54LuIU
 yKINAVdHwdzszU0t/NgEZa7ZLOBl7sXd09v3YNE8YBbRhw05IhDgj5pN4ps+2y/+7XSGo3
 10YtEYZeSjABRSgWpzAOCRT2V8tiyJxh/HjFPMWsYWpFAYJYu5k8ti0GTQd9afDQzp2MmK
 cwbhFdWF/EU6zuWYHMtdLN2McxBSEtoU9p0z6cHWy+U9bPXOAyUja5yp5FLrYF8uuhIaKr
 rYRCm3ByzO+YyFf4cubFsULwxKDH2mZRHZ6qhyCRouk+aHMfCMxhEd5MCZVaRQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 12:54:30 +0200
Message-Id: <DHGWUIUIKETI.1F1636GUBB3VI@bootlin.com>
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
X-Mailer: aerc 0.20.1
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-7-479a04133e70@bootlin.com>
 <544112ab-8ca0-4622-b680-233457198e3e@nxp.com>
 <DHDNA5HLQPIB.3F21G9QPBUQG8@bootlin.com>
 <5f06ea5a-5388-440f-91d6-cebb0bee0a88@nxp.com>
 <DHG8G8FMXA6C.U6LU563OZ8NR@bootlin.com>
 <9a6e74ed-d4ab-4f11-ab17-25e1a2b64b2d@nxp.com>
In-Reply-To: <9a6e74ed-d4ab-4f11-ab17-25e1a2b64b2d@nxp.com>
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

On Tue Mar 31, 2026 at 5:03 AM CEST, Liu Ying wrote:
> Hi Luca,
>
> On Mon, Mar 30, 2026 at 05:47:23PM +0200, Luca Ceresoli wrote:
>> Hello Liu,
>>
>> On Mon Mar 30, 2026 at 5:02 AM CEST, Liu Ying wrote:
>
> [...]
>
>>>>>> +	fixup-hdmi-connector {
>>>>>> +		compatible =3D "hdmi-connector";
>>>>>> +		label =3D "HDMI";
>>>>>> +		type =3D "a";
>>>>>
>>>>> What if a board uses another type?
>>>>
>>>> For boards affected by this patch, currently the connector is created =
by
>>>> dw_hdmi_connector_create() which hardcodes type A [0], so there would =
be no
>>>> difference.
>>>
>>> Yes, that's from driver's PoV.  However, userspace may get the type
>>> from /sys/firmware/devicetree/base/fixup-hdmi-connector/type and use it
>>> to do something.
>>
>> I'd say this is incorrect, the device tree is not an API for that. The
>> connector type might be known to the driver by other means (ACPI, DP MST=
,
>> whatever). So I think this is a non-problem.
>
> I just feel that it's not great to report potentially wrong type to users
> through the above sys node ...
>
>>
>> If userspace needs to know the connector type, that should come from the
>> ioctl (DRM_IOCTL_MODE_GETCONNECTOR perhaps).
>>
>>> Maybe, that's trivial.
>>
>> Not sure I got what you mean here, sorry. What are you referring to?
>
> ... with the above potentially wrong type being said, I think maybe this
> drawback is not a big deal and could be ignored.  Sorry for not being
> clear in my last reply.

Ah, clear now. No problem!

>>>> Boards with a different connector should describe the connector in the
>>>> device tree, if they need to instantiate the exact type.
>>
>> I think this is the only valid solution. It's very easy to do, nothing n=
ew
>> to invent.
>>
>> Maybe on top of that we could add a warning when the overlay is applied,
>> e.g. "imx8mp-hdmi-tx used without a connector described in device tree;
>> adding a type A connector as a fallback; please add a valid description =
to
>> your device tree".
>
> I'd say this doesn't sound a bad idea but I hope the message is clear and
> short.

What about:

  Connector description not found in device tree, please add one. Falling b=
ack to Type A.

>> Maybe pointing to a TODO entry in the documentation.
>
> To parameterize the HDMI connector type?  If so, I'm okay with that.

I was meaning a TODO entry to suggest people to add a connector description
to the dts. E.g., expanding on the above suggested warning:

  Connector description not found in device tree, please add one. See https=
://docs.kernel.org/gpu/todo.html#<...>

And of course adding a TODO entry describing what one needs to do (add an
hdmi-connector node and link it to port@1 of the hdmi-tx).

The drawback of the TODO is that items in todo.rst are supposed to be
removed eventually when done in the code, but this one cannot be removed
until some kernels printing the above logging message will be around,
i.e. potentially for decades.

So maybe the simplest solution is just the first warning message + a
comment in the code right before the warning line, so it easily found with
grep or a web search by who sees the warning.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
