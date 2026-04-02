Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51CCCC6B1B
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4790C10EFA2;
	Thu,  2 Apr 2026 07:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EEw2+Eoh";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00ED810EFA2
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:47:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B1E1F1A30E6;
 Thu,  2 Apr 2026 07:47:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E717C5FDEB;
 Thu,  2 Apr 2026 07:47:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 893CB10450FD5; 
 Thu,  2 Apr 2026 09:46:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775116020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jP1S9CLoFCyCnLNLDQLchVG1x47qmcvo35n8094xxtc=;
 b=EEw2+EohuHWiQDl0euKZWW9UvzVB0BjVykwNv503S8nlKVpQN8iO41I6vgPKyBo5EaqANG
 dHxRujC0ptwCSuEY5mrJQ/YBd6blGZ7OPFKtVvN38VrXhi0ghaz/PxMkf4AjGGe3mLy9HO
 vGRHIT8mjoWC6BXHAu/YOpNA04JoHlv8rUzDXBx8KXQIcZhct7MD9aTTkvlzpIUS8Qa/6A
 uWMqp5ocQhYgvE3QXhkSTFk3eKQz98zTgdqLS6OGU3hoNohhNuWD1QL6Kg2lMpSa9O9vYv
 GKDTTAg+/Z2byYELg/JAPNn72lkY1568inHalpeAh2QtKr9jq2NvacA7fe7NeA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 09:46:46 +0200
Message-Id: <DHII3VS5NVEC.179WKXX8C8SOO@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 05/10] drm/bridge: dw-hdmi: document the output_port
 field
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, "Adam Ford" <aford173@gmail.com>, "Alexander
 Stein" <alexander.stein@ew.tq-group.com>, "Christopher Obbard"
 <christopher.obbard@linaro.org>, "Daniel Scally"
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
To: "Damon Ding" <damon.ding@rock-chips.com>, "Marek Vasut" <marex@denx.de>,
 "Stefan Agner" <stefan@agner.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Liu Ying"
 <victor.liu@nxp.com>, "Rob Herring" <robh@kernel.org>, "Saravana Kannan"
 <saravanak@kernel.org>
X-Mailer: aerc 0.20.1
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-5-c7f2af536a24@bootlin.com>
 <cd0acf08-de24-4fec-a4de-0cd5b1eeeb28@rock-chips.com>
In-Reply-To: <cd0acf08-de24-4fec-a4de-0cd5b1eeeb28@rock-chips.com>
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

Hello Damon,

On Tue Mar 31, 2026 at 9:21 AM CEST, Damon Ding wrote:
> On 3/31/2026 3:25 AM, Luca Ceresoli wrote:
>> The meaning of this flag may not be obvious at first sight.
>>
>> Reviewed-by: Liu Ying <victor.liu@nxp.com>
>> Tested-by: Martyn Welch <martyn.welch@collabora.com>
>> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL=
/MBa8MPxL
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks for looking at this series!

>> @@ -126,6 +126,12 @@ struct dw_hdmi_phy_ops {
>>   struct dw_hdmi_plat_data {
>>   	struct regmap *regm;
>>
>> +	/*
>> +	 * The HDMI output port number must be 1 if the port is described
>> +	 * in the device tree. 0 if the device tree does not describe the
>> +	 * next component (legacy mode, i.e. without
>> +	 * DRM_BRIDGE_ATTACH_NO_CONNECTOR flag when attaching bridge).
>> +	 */
>>   	unsigned int output_port;
>>
>>   	unsigned long input_bus_encoding;
>>
>
> Tested-by: Damon Ding <damon.ding@rock-chips.com> (on rk3399)

Uhm, I'm not sure what can be tested in a patch only adding a comment. Did
you mean 'Reviewed-by' maybe?

Also, I _think_ the best syntax for a comment would be using a '#', not
parentheses, so that would be

| Tested-by: Damon Ding <damon.ding@rock-chips.com> # on rk3399

This is the recommended syntax for the 'Cc: stable' lines [0], at
least. Additionally b4 keeps comments with the '#' as those in [1], while
is discards the ones in parentheses.

[0] https://docs.kernel.org/process/stable-kernel-rules.html
[1] https://lore.kernel.org/all/2948177.mvXUDI8C0e@steina-w/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
