Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B30CC6B30
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5101110EF8A;
	Thu,  2 Apr 2026 08:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TNUHH2pA";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FDB10EF8A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 08:29:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BAD8A4E428AA;
 Thu,  2 Apr 2026 08:29:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 837475FDEB;
 Thu,  2 Apr 2026 08:29:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 94AD710450221; 
 Thu,  2 Apr 2026 10:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775118541; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PUXno5TxkjpeBoSqZm65CbuO+h64L2SVBgOxOmu2oIo=;
 b=TNUHH2pAZPAMP4NGLsz+uJewT7ce/5mkiukpdC9e/GF/cCgcQr2XiVigjiYOaiqLn0jVFV
 MT7V55Gngp/p+G3cUIgeeaGjdsunI4FxxTXZV1VCvaZp8Fu1NmDMH4fpCoySsakeh4UzpF
 lX48nkRylKWcwrlYejZxz4eLsr/mNruwRWad4ESyVHvE9nUIrx3Bx2UJfAcE1I0nEmmVXa
 l6SnamIUZgMY5xRvEVj9Yq2kwWG4Du2bg3fbFoea5Ew5M1g5zMxgDAAnIdY63ggTOMOue5
 +WOpPf9dvsdGz8Qf5D4+FLkyjNYPxNRVRz6lM1LRBcgO1HZxCQRpeH0WvglegQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 10:28:45 +0200
Message-Id: <DHIJ00VZ2O0H.1550LBTEFNT83@bootlin.com>
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
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 10/10] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
X-Mailer: aerc 0.20.1
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-10-c7f2af536a24@bootlin.com>
 <1a8b1a34-89bd-436e-8b5c-64ea71e8f333@nxp.com>
In-Reply-To: <1a8b1a34-89bd-436e-8b5c-64ea71e8f333@nxp.com>
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

On Thu Apr 2, 2026 at 6:55 AM CEST, Liu Ying wrote:
> Hi Luca,
>
> On Mon, Mar 30, 2026 at 09:25:51PM +0200, Luca Ceresoli wrote:
>> Convert this driver to DRM_BRIDGE_ATTACH_NO_CONNECTOR and to the
>> drm_bridge_connector framework which is the current DRM bridge best
>> practice.
>>
>> Tested-by: Martyn Welch <martyn.welch@collabora.com>
>> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL=
/MBa8MPxL
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

>> @@ -86,11 +88,23 @@ static int lcdif_attach_bridge(struct lcdif_drm_priv=
ate *lcdif)
>>  					     "Failed to initialize encoder for endpoint%u\n",
>>  					     of_ep.id);
>>
>> -		ret =3D drm_bridge_attach(encoder, bridge, NULL, 0);
>> +		ret =3D drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO=
_CONNECTOR);
>
> It seems that only analogix-anx6345.c, analogix-anx78xx.c and analogix_dp=
_core.c
> don't allow DRM_BRIDGE_ATTACH_NO_CONNECTOR, since they error out when att=
aching
> the bridge with the flag:
>
> if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
>          DRM_ERROR("Fix bridge driver to make connector optional!");
>          return -EINVAL;
> }
>
> Looks like i.MX8MP platforms don't use these drivers.

Exactly. I have checked all the drivers involved with the i.MX8MP and all
of the support DRM_BRIDGE_ATTACH_NO_CONNECTOR.

While converting all drivers is surely a good goal, converting all of them
at once is not realistically doable. So the approach I took was to convert
one specifically (lcdif_drv.c) plus all those which would break because
they are used with the LCDIF.

> But, are we completely safe here by adding the flag?  You also mentioned
> "pitfalls" in commit mesg, which makes me a bit more worried.

I mentioned potential pitfalls in the cover letter mainly because of the DT
overlay insertion patch, which is somewhat tricky as it impacts many
boards.

Additionally it's not easy to spot all usages of this component by parsing
dozens of dts files, so I might have missed some.

So overall every patch sent has a potential for pitfalls, but for the
reasons above I think this series has a bit more.

Does this reassure you? :)

>>  		if (ret)
>>  			return dev_err_probe(dev, ret,
>>  					     "Failed to attach bridge for endpoint%u\n",
>>  					     of_ep.id);
>> +
>> +		connector =3D drm_bridge_connector_init(lcdif->drm, encoder);
>
> Also, kernel doc of drm_bridge_connector.c says:
>
>  * To make use of this helper, all bridges in the chain shall report brid=
ge
>  * operation flags (&drm_bridge->ops) and bridge output type
>  * (&drm_bridge->type), as well as the DRM_BRIDGE_ATTACH_NO_CONNECTOR att=
ach
>  * flag (none of the bridges shall create a DRM connector directly).
>
> Are you sure that we are safe to use this helper?

Yes. I have checked all in-tree dts[i] files for all the 3 LCDIFs.

For the LCDIF3, the pipeline is:

  LCDIF3 -> fsl,imx8mp-hdmi-pvi -> fsl,imx8mp-hdmi-tx -> HDMI connector

And the involved bridges are:

 * fsl,imx8mp-hdmi-pvi has ops =3D 0 (it doesn't set it) because it
   implements none the optional features mentioned by those flags, and it
   honors the DRM_BRIDGE_ATTACH_NO_CONNECTOR by propagating it

 * fsl,imx8mp-hdmi-tx is implemented based on dw-hdmi, which sets ops as
   appropriate and also propagates the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag

 * display-connector (enabled via the DT overlay if needed) sets ops and
   makes DRM_BRIDGE_ATTACH_NO_CONNECTOR mandatory

The LCDIF2 involves the panel-bridge, display-connector and lvds-decoder
which also set ops as needed and propagate DRM_BRIDGE_ATTACH_NO_CONNECTOR
or make it mandatory.

The same applies to the drivers used with the LCDIF1: adv7511, tc358767 and
the panel bridge.

I assume this answers your doubts. Let me know if it doesn't.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
