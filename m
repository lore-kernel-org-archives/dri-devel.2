Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DF2C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C85510F329;
	Thu, 24 Sep 2026 07:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VfDv7S7f";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24F810F329
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:01:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 2A3521A0FF5;
 Thu, 24 Sep 2026 07:01:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EA2AA5FB45;
 Thu, 24 Sep 2026 07:01:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B2EEF103294A6; 
 Thu, 24 Sep 2026 09:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790233298; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3oGwBuyJVzkAjrauN/FxJTxwMCY3sLnXn9ixXjUrD2A=;
 b=VfDv7S7faDApBOx+DPqMCyWHBKUPlODcB1xuNfsFjM3RNlzyRMcdJhIP0bigttbKx1o5jy
 +B3mEF8B/s9ysd2wfnmGpCg4NZheR3VGvS94Ic0SKnLPviSK0O4PMC4viKTqfmdCj+9vMX
 uaR7ncMHlkENvjrtg1sfppR2+2rB1w3yNHl15P3vTuCFyK7Bv7Ut1MV2dfvSol7696XXmK
 vqgt//ttjMMGzJqmyWKqUW/+naiLm3TqTzPFnvGHAOfowEfbjOv664AYGg+P4m03YFGXZS
 W/ZrKJoYs3u+wZqS+nmUIHWaVMRI8biPPQkNoSk2GzQUV+7Bbe8V7J315PgOJg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 09:01:18 +0200
Message-Id: <DLNCQEG62F5N.O98WAO4U2FJO@bootlin.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Jessica Zhang" <jesszhan0024@gmail.com>, "Laurentiu
 Palcu" <laurentiu.palcu@oss.nxp.com>, "Lucas Stach"
 <l.stach@pengutronix.de>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Paul
 Cercueil" <paul@crapouillou.net>, "Paul Kocialkowski" <paulk@sys-base.io>,
 "Linus Walleij" <linusw@kernel.org>, "Inki Dae" <inki.dae@samsung.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Sean Paul" <sean@poorly.run>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Albert Esteve" <aesteve@redhat.com>,
 "Anusha Srivatsa" <asrivats@redhat.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <asahi@lists.linux.dev>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <linux-tegra@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
X-Mailer: aerc 0.22.0
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-12-83afb4f1a707@bootlin.com>
 <arInho2bsfJiCgjV@houat>
In-Reply-To: <arInho2bsfJiCgjV@houat>
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

Hi Linus, Maxime,

On Tue Sep 22, 2026 at 9:09 AM CEST, Maxime Ripard wrote:
> On Wed, Sep 16, 2026 at 03:45:36PM +0200, Luca Ceresoli wrote:
>> Now a panel_bridge is automatically created for every drm_panel and the
>> panel-bridge API is just a deprecated wrapper to access it.
>>
>> Update and simplify the code by just getting a reference to the
>> already-existing bridge using of_drm_find_and_get_bridge().
>>
>> Also keep the "connected to non-panel bridge (unsupported)\n" error logi=
c
>> by using the drm_bridge_is_panel() function.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

[...]

>> @@ -1102,40 +1100,21 @@ static int mcde_dsi_bind(struct device *dev, str=
uct device *master,
>>
>>  	/* Look for a panel as a child to this node */
>>  	for_each_available_child_of_node_scoped(dev->of_node, child) {
>> -		panel =3D of_drm_find_panel(child);
>> -		if (IS_ERR(panel)) {
>> -			dev_err(dev, "failed to find panel try bridge (%ld)\n",
>> -				PTR_ERR(panel));
>> -			panel =3D NULL;
>> -
>> -			bridge =3D of_drm_find_and_get_bridge(child);
>> -			if (!bridge) {
>> -				dev_err(dev, "failed to find bridge\n");
>> -				return -EINVAL;
>> -			}
>> +		bridge =3D of_drm_find_and_get_bridge(child);
>> +		if (!bridge) {
>> +			dev_err(dev, "failed to find bridge\n");
>> +			return -EINVAL;
>>  		}
>>
>> -		if (panel || bridge)
>> -			break;
>> +		break;
>>  	}
>> -	if (panel) {
>> -		bridge =3D drm_panel_bridge_add_typed(panel,
>> -						    DRM_MODE_CONNECTOR_DSI);
>> -		drm_panel_put(panel);
>> -		if (IS_ERR(bridge)) {
>> -			dev_err(dev, "error adding panel bridge\n");
>> -			return PTR_ERR(bridge);
>> -		}
>> -		drm_bridge_get(bridge);
>> -		dev_info(dev, "connected to panel\n");
>> -		d->panel =3D panel;
>> -	} else if (bridge) {
>> +	if (!bridge) {
>> +		dev_err(dev, "no bridge\n");
>> +		return -ENODEV;
>> +	} else if (!drm_bridge_is_panel(bridge)) {
>>  		/* TODO: AV8100 HDMI encoder goes here for example */
>>  		dev_info(dev, "connected to non-panel bridge (unsupported)\n");
>>  		return -ENODEV;
>
> I wonder if we still need that branch. Every panel is a bridge now, and
> it looks like we don't have any specific panel handling in this driver,
> so I guess it supports bridges already?
>
> Linus, do you know why this condition was here in the first place?

I had the same thought while writing the patch, but I chose to be
conservative.

Linus, unless you have more info I'm going to apply the patch as
is. Removing this special case would be welcome as a later patch.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
