Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46282C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A784D10E456;
	Fri, 17 Jul 2026 09:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Gv9DBNlm";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0040010E456
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:41:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6F1634E40E17;
 Fri, 17 Jul 2026 09:41:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4030E60361;
 Fri, 17 Jul 2026 09:41:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3FDEB11BD0C84; 
 Fri, 17 Jul 2026 11:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784281302; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fAKQhH4VyjFGHOAiPzbySG52oxOlgLNotod0GK1Rg6c=;
 b=Gv9DBNlmj24qqgKf13r6OKTLvqMcvcQkJ9foBw4lnYqOj/rQ/VALitWCfWSH5/icZ5w/7G
 HyS5rAKPVKhuR+BprwNvLg6UK0lRzvutLGRb1nrzxlB57qw8vyl9ublftyLxeVW3ULwEEd
 OQoIJom7g45nMRwl7ZMBMEHlVw2qtvgZcF2W9Vn33bRI/QOJfwC44t1rVsVfM7H+6tCgzf
 nNp1QQAvc28erX3NRS0C+Te4VMkmBNNbJ3lzoF4XLYG8dtZPl0GZlnHN8je1rAZ439fs6w
 JRskRLZ0KTDfY1zC6eQBgS6HX7Ilqg67CV1vIWXTLiZlpo0u4+8BNVYSO2XOxA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 11:41:33 +0200
Message-Id: <DK0QXI6KF7PC.3DJW38KB8MJED@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code
 creating the connector to a subfunction
Cc: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>, "Stefan Agner"
 <stefan@agner.ch>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
 <20260624-proud-unbiased-pony-ecc3c3@houat>
 <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
 <20260626-polite-hairy-perch-25e1aa@houat>
 <DJJ1MPCEJGZD.UZM9183V6ZE5@bootlin.com>
 <20260626-classy-nightingale-of-romance-1cacad@houat>
 <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
 <20260707-warping-goshawk-of-swiftness-beea4a@penduick>
 <20260707123205.GB211515@killaraus.ideasonboard.com>
 <DJZUXUBO8DI4.2J2NI3S0KYNUE@bootlin.com>
 <20260716-stoic-muskox-from-asgard-c12b65@houat>
In-Reply-To: <20260716-stoic-muskox-from-asgard-c12b65@houat>
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

Hi Maxime,

On Thu Jul 16, 2026 at 3:22 PM CEST, Maxime Ripard wrote:
> On Thu, Jul 16, 2026 at 10:37:24AM +0200, Luca Ceresoli wrote:
>> >> > Now if the bridges start doing it themselves we should go back to
>> >> > those encoder drivers and ditch all the drm_bridge_connector from
>> >> > there?
>> >> >
>> >> > I must be missing something. Can you elaborate on this?
>> >>
>> >> drm_bridge_connectors bring together a (complete) bridge chain and a
>> >> connector. If you don't have either anymore, then we shouldn't keep i=
t
>> >> around.
>> >>
>> >> What I was suggesting before was only a suggestion. I guess we could
>> >> also make the encoder own the hotplug handling code and create the
>> >> drm_bridge_connector when the chain is complete, and remove it when i=
t's
>> >> no longer the case.
>> >
>> > That's an interesting option. We don't have to keep drm_bridge_connect=
or
>> > in its current form, but I don't think we should go back to individual
>> > bridge driver creating connectors, especially now that we have bridge
>> > chains where the connector ops are implemented collectively by multipl=
e
>> > bridges.
>>
>> I definitely agree we don't want to add burden back on the encoder.
>
> I don't think Laurent mentioned the encoder anywhere.

Ah, indeed, sorry! However, I think both the bridges and the encoder
drivers should equally have the minimum burden on them.

Right now the recommended practice is:

 - bridges do not create connectors (thanks to DRM_BRIDGE_ATTACH_NO_CONNECT=
OR)
 - encoders just call drm_bridge_connector_init(), which does all the
   common operations to populate a suitable drm_connector

So all common operations involved in connector creation and bridge chain
analysis are implemented in common code, not per-bridge or
per-encoder. That's good.

>> >> We can discuss alternatives too. But either way, we shouldn't have it
>> >> stick around.
>>
>> Bottom line, I roughly see three ideas mentioned:
>>
>>  1. (this series) extend the drm_bridge_connector to create the
>>     drm_connector based on bridge hotplug events [+rename it]
>>  2. - keep the drm_bridge_connector (mostly) as is
>>     - let each encoder driver add/remove it based on bridge hotplug even=
ts
>>     =3D> more burden on encoder drivers -> no
>
> Can you motivate that with *any* reason? Because I really feel like it's
> the best solution going forward.

My understanding of your idea (maybe a bit overstressed just to ensure it's
clear) is that:

 - the drm_bridge_connector should stay (almost) unmodified
 - there should be no new "manager" component (not sure this is actually
   your opinion, can you comment on this specifically?)
 - every encoder driver would have to:
   - register to receive hotplug events
   - when receiving one such event, find out whether the hardware is
     complete or not (by calling drm_bridge_connector_pipeline_is_complete(=
)
     or so)
   - create/destroy a drm_bridge_connector based on hotplug events

Is this somewhat close to what you have in mind?


To me the best solution to add hotplug support is that encoder drivers
replace the single drm_bridge_connector_init() call with a single call to
something new (let's call it a hotplug manager), which takes care of all
the common aspects: registering to receive bridge hotplug events, finding
out whether the hardware pipeline is complete or not, and add/remove the
drm_connector based on that.

In other words, the changes on encoder drivers would be similar to patch
37. In a nutshell:

  -	connector =3D drm_bridge_connector_init(lcdif->drm, encoder);
  +	drm_hotplug_manager =3D drm_hotplug_manager_init(lcdif->drm, encoder);

All the hotplug logic would be in common code, and any maintenance and
future improvements to it would stay in a single place, benefitting all
encoders at once.

What do you think about this?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
