Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB61AD35159
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5017610E077;
	Wed,  1 Apr 2026 07:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jWk6Fnxj";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C807F10E077
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:51:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 15C8A4E42894;
 Wed,  1 Apr 2026 07:51:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D6800602BF;
 Wed,  1 Apr 2026 07:51:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48FAD104512AE; 
 Wed,  1 Apr 2026 09:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775029906; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uT7sfHLuVPP3pEA5gLyzkA2Moxay1BQG8R6pq63tpdQ=;
 b=jWk6FnxjhGu2HcFc6zGL1OGj6IL5Zs7/Fl2Q686nDDtC28o/cBxZ0B5lnUgMb37DGCL/Uk
 rAjgfnUYQptI93q8MJ004w4xbAb0+iSNuMQn9BXWLFmJ0E+TwO5ks3CpK3aS4oCSxnCKRU
 QXYU3b5/LY3B0NwZS5vOTSmfYsZ2wWNaStVw9fQjBhfWXkjntmhhB5fsLoGxV9ESHBvuX4
 CJxuDmkRLmRKssspV9E+L5j8UlAdYdS0YRJjLFpjzXOjdxfqUwFKGxr09Kpv1Y0sAvTKxM
 aadA789/nx2gmTp7hmC5i/xOnlgXKhPoYHWGW6hvDd7p6XHfczcQNgIyNyDbzg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 09:51:32 +0200
Message-Id: <DHHNKZK3NYI0.34BT204KH2VLS@bootlin.com>
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
 <DHGWUIUIKETI.1F1636GUBB3VI@bootlin.com>
 <246ca728-1be6-4dd9-b228-7d99f28e1abe@nxp.com>
In-Reply-To: <246ca728-1be6-4dd9-b228-7d99f28e1abe@nxp.com>
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

On Wed Apr 1, 2026 at 8:45 AM CEST, Liu Ying wrote:
>>>>>> Boards with a different connector should describe the connector in t=
he
>>>>>> device tree, if they need to instantiate the exact type.
>>>>
>>>> I think this is the only valid solution. It's very easy to do, nothing=
 new
>>>> to invent.
>>>>
>>>> Maybe on top of that we could add a warning when the overlay is applie=
d,
>>>> e.g. "imx8mp-hdmi-tx used without a connector described in device tree=
;
>>>> adding a type A connector as a fallback; please add a valid descriptio=
n to
>>>> your device tree".
>>>
>>> I'd say this doesn't sound a bad idea but I hope the message is clear a=
nd
>>> short.
>>
>> What about:
>>
>>   Connector description not found in device tree, please add one. Fallin=
g back to Type A.
>
> Maybe:
> Please add a hdmi-connector DT node for imx8mp-hdmi-tx. A fixup node in t=
ype a is added for now.
>
>>
>>>> Maybe pointing to a TODO entry in the documentation.
>>>
>>> To parameterize the HDMI connector type?  If so, I'm okay with that.
>>
>> I was meaning a TODO entry to suggest people to add a connector descript=
ion
>> to the dts. E.g., expanding on the above suggested warning:
>>
>>   Connector description not found in device tree, please add one. See ht=
tps://docs.kernel.org/gpu/todo.html#<...>
>>
>> And of course adding a TODO entry describing what one needs to do (add a=
n
>> hdmi-connector node and link it to port@1 of the hdmi-tx).
>>
>> The drawback of the TODO is that items in todo.rst are supposed to be
>> removed eventually when done in the code, but this one cannot be removed
>> until some kernels printing the above logging message will be around,
>> i.e. potentially for decades.
>
> Not a big fan of adding a TODO entry, because those DT blobs without a
> hdmi-connector node could be out there forever, meaning the added TODO
> entry can never be removed.
>
>>
>> So maybe the simplest solution is just the first warning message + a
>> comment in the code right before the warning line, so it easily found wi=
th
>> grep or a web search by who sees the warning.
>
> +1.

Agreed. I've already sent v2, so I'll queue this for v3.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
