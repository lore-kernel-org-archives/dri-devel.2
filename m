Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3446FEEF31
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 12:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2A210E40C;
	Tue,  7 Apr 2026 12:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xpJfVE+D";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4915A10E40C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:44:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6EAA4C5B18E;
 Tue,  7 Apr 2026 12:44:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9CE4B603C7;
 Tue,  7 Apr 2026 12:44:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B93C104500CD; 
 Tue,  7 Apr 2026 14:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775565842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=93hW5u7kA6zQFXa6aVbYkWf1SP6enbNwj09rJ/uKnY0=;
 b=xpJfVE+DhfpK6BJKwTs6G+k4orXAFM7qXHNM122mw7BmUf/+v8aWArISlO1AxW1py4zL0D
 l3eDoGsEeqfBg1NKMbO9sgJ4S7D6zRz49ioXvYzduYmPkCOilbY5pk+yTQcDsWpiF8RnXY
 IvAdF6hzJNMVcF/WwhBVJfWIdcyNRuoSdJfleLTioAxZEyY1+v1FmsBfCjyJ+6cyfJ020Y
 nnkewI+ugG+AwkXlJxkwrmjE1GtDuuHqFU1LCKorXBcpdBQgApB3iEY9zbt66+ARnv2mi8
 OnFqql8fiZh+ZZsIEtR6zuX+LesqN6VQWFDWaZi1M8Rtn2gIZNgpSpvHjWJtHA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 14:43:51 +0200
Message-Id: <DHMXK2CNE9M8.W9BXCX4I7WR5@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 08/11] drm/bridge: imx8mp-hdmi-tx-connector-fixup:
 add an hdmi-connector when missing using a DT overlay at boot time
Cc: "Damon Ding" <damon.ding@rock-chips.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, =?utf-8?q?Herv=C3=A9_Codina?=
 <herve.codina@bootlin.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Adam Ford"
 <aford173@gmail.com>, "Alexander Stein" <alexander.stein@ew.tq-group.com>,
 "Christopher Obbard" <christopher.obbard@linaro.org>, "Daniel Scally"
 <dan.scally@ideasonboard.com>, "Emanuele Ghidoli"
 <emanuele.ghidoli@toradex.com>, "Fabio Estevam" <festevam@denx.de>,
 "Francesco Dolcini" <francesco.dolcini@toradex.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Gilles Talis" <gilles.talis@gmail.com>,
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, "Heiko
 Schocher" <hs@denx.de>, "Josua Mayer" <josua@solid-run.com>, "Kieran
 Bingham" <kieran.bingham@ideasonboard.com>, "Marco Felsch"
 <m.felsch@pengutronix.de>, "Martyn Welch" <martyn.welch@collabora.com>,
 "Oleksij Rempel" <o.rempel@pengutronix.de>, "Peng Fan" <peng.fan@nxp.com>,
 "Richard Hu" <richard.hu@technexion.com>, "Shengjiu Wang"
 <shengjiu.wang@nxp.com>, "Stefan Eichenberger"
 <stefan.eichenberger@toradex.com>, "Vitor Soares"
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
X-Mailer: aerc 0.20.1
References: <20260402-drm-lcdif-dbanc-v3-0-27cd247a0847@bootlin.com>
 <20260402-drm-lcdif-dbanc-v3-8-27cd247a0847@bootlin.com>
 <88cf4526-ca8f-4b25-acea-347d92539a2b@nxp.com>
In-Reply-To: <88cf4526-ca8f-4b25-acea-347d92539a2b@nxp.com>
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

On Fri Apr 3, 2026 at 11:28 AM CEST, Liu Ying wrote:

>> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * DTS overlay adding an hdmi-connector node to boards using the imx8mp=
 hdmi_tx
>> + *
>> + * Copyright (C) 2026 GE HealthCare
>> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&{/} {
>> +	#address-cells =3D <2>;
>> +	#size-cells =3D <2>;
>> +
>> +	fixup-hdmi-connector {
>> +		compatible =3D "hdmi-connector";
>> +		label =3D "HDMI";
>> +		type =3D "a";
>> +
>> +		port {
>> +			fixup_hdmi_connector_in: endpoint {
>> +				remote-endpoint =3D <&hdmi_tx_out>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&{/soc@0/bus@32c00000/hdmi@32fd8000/ports/port@1} {
>> +	hdmi_tx_out: endpoint {
>> +		remote-endpoint =3D <&fixup_hdmi_connector_in>;
>> +	};
>> +};
>>
>
> There is a build warning(W=3D1):
>
>   DTC     drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtbo
> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:12.6-27.3:=
 Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessar=
y #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" =
or "ranges" property

Ouch, my bad, forgot to run W=3D1 after the last edit. Fix incoming v4,
toghether with the other improvements you have suggested.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
