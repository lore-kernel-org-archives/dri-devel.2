Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9946610ED659
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D805710ED47;
	Fri, 27 Mar 2026 11:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gAroRVxD";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3461910ED47
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:10:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 53D2D1A3026;
 Fri, 27 Mar 2026 11:10:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0E9ED60230;
 Fri, 27 Mar 2026 11:10:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 208FD1045116C; Fri, 27 Mar 2026 12:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774609843; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ivVZrNHVuLE7L07Vcqm3cEhovIGG3NxlMH+ON4o2wYA=;
 b=gAroRVxDKBMWxOgvewR23uQHXW9xAU/MNSGXkPTTC23oT/5FXuA97wX7krVS4mQkGkffsN
 G/Xb+qyT7GEae1pgl+k3JxZI/Cv1pG5vNJ2/x/wV15du+QmUVb8SRk9s5VQaYfKOquoiaU
 jw81ThVsg6+0WySTK5NG+FZTWLzzykSJGpbrueHKnV5n0qeqJ3tojDkR+JQ6P/OdFKL6Nl
 +k8KWA89ojc+vsgW9zZHFmTqOskJSzpFFZ/KIX9sq5lJZdOmnNfiiKtyBdHPUE/mM7x4WC
 TCBRxoebM09VUO5rd5r++WRhx0hSFC7lkYZYcfCGGdqMQlNp81tuqcd6/jMBsg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 12:10:28 +0100
Message-Id: <DHDIOKQ7089U.2JTUDD42HN32L@bootlin.com>
Subject: Re: [PATCH 2/8] drm/mxsfb/lcdif: don't unnecessarily loop over ports
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
 <20260320-drm-lcdif-dbanc-v1-2-479a04133e70@bootlin.com>
 <299ea117-c628-4094-88f3-47c8d898e15e@nxp.com>
In-Reply-To: <299ea117-c628-4094-88f3-47c8d898e15e@nxp.com>
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

thanks for the careful and timely review of this series!

On Thu Mar 26, 2026 at 7:59 AM CET, Liu Ying wrote:
> Hi Luca,
>
> On Fri, Mar 20, 2026 at 11:46:13AM +0100, Luca Ceresoli wrote:
>> According to the bindings [0] there can be only one port. The in-tree bo=
ard
>> device trees also don't contain multiple ports (searched thos matching
>
> s/thos/those/
>
>> 'fsl,imx(23|28|6sx|8mp|93)-lcdif').
>>
>> Avoid an unnecessary loop around multipltle ports. This allows to greatl=
y
>
> s/multipltle/multiple/
>
>> simplify the code.
>>
>> [0] Documentation/devicetree/bindings/display/fsl,lcdif.yaml
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>
>> ---
>>
>> Viewing this patch with '--ignore-all-space' is recommended
>> ---
>>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 77 ++++++++++++++------------------=
-------
>>  1 file changed, 27 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/l=
cdif_drv.c
>> index 756ca96373c8..83e134c04882 100644
>> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
>> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
>> @@ -48,61 +48,38 @@ static const struct drm_encoder_funcs lcdif_encoder_=
funcs =3D {
>>  static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>>  {
>>  	struct device *dev =3D lcdif->drm->dev;
>> -	struct device_node *ep;
>> +	struct drm_encoder *encoder;
>>  	struct drm_bridge *bridge;
>>  	int ret;
>>
>> -	for_each_endpoint_of_node(dev->of_node, ep) {
>
> The single i.MX93 LCDIF may connect with a DPI/LVDS/MIPI DSI encoder.
> Each encoder maps to an endpoint in a port, hence 3 endpoints in all.
> See lcdif node in imx91_93_common.dtsi and imx93.dtsi in linux-next/maste=
r.

My bad, I hadn't realized that, perhaps because it was not yet on
drm-misc-next when I did my research. Thanks for noticing.

Luckily the fundamental reason for which I thought I needed this changed
has vanished even before I sent this v1, so I'll just drop this patch and
adapt the follwing ones as needed.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
