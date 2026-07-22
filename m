Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970A0C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0C610E097;
	Wed, 22 Jul 2026 09:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="z2mUyKFa";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDCA10E097
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:11:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1C60A1A1144;
 Wed, 22 Jul 2026 09:11:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DF2FE60388;
 Wed, 22 Jul 2026 09:11:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FAFF11BD0ADC; 
 Wed, 22 Jul 2026 11:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784711473; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=CVMvqT2UQr1txHFCMAIcwU7vZqub1auWVL1fnTiKFZE=;
 b=z2mUyKFafy0l5dpLU+0DGap45Kxpu05bFTufLn+AejhY8o/GNw+bsMIGqsZ+wiE4M52cUb
 tJ2kf9T2YiRxOqhr2rWzY6HX0HaZTrXAkwRwYkiIApKjq6ixTgX+STS1gkAJGd5e/6BVDK
 GToI/hX/BbykAokOk8TWHpHPFG8V07FtMaqxnbrhnkb/T4rB9QWpMae8QNrsMiy7H/LA64
 CBxKwBYvzKbIdeqwP++7cQtAxs+z3x9pM+K4I1TBW6Z2Gjrq8TuQOPUI1fgOKPRLrxeDV9
 sIjNA1KMA98U1kfDDJO4VYRUgzaOUz1xNXwlEr4Ixh4tdw5zVeqvwFdXq3uDLw==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 11:10:53 +0200
Message-Id: <DK4ZERBN7IS2.2T8E05JZI0IY8@bootlin.com>
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
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
 <20260626-polite-hairy-perch-25e1aa@houat>
 <DJJ1MPCEJGZD.UZM9183V6ZE5@bootlin.com>
 <20260626-classy-nightingale-of-romance-1cacad@houat>
 <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
 <20260707-warping-goshawk-of-swiftness-beea4a@penduick>
 <20260707123205.GB211515@killaraus.ideasonboard.com>
 <DJZUXUBO8DI4.2J2NI3S0KYNUE@bootlin.com>
 <20260716-stoic-muskox-from-asgard-c12b65@houat>
 <DK0QXI6KF7PC.3DJW38KB8MJED@bootlin.com>
 <20260720-eel-of-immense-triumph-3e24e0@penduick>
In-Reply-To: <20260720-eel-of-immense-triumph-3e24e0@penduick>
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

On Mon Jul 20, 2026 at 4:28 PM CEST, Maxime Ripard wrote:
> On Fri, Jul 17, 2026 at 11:41:33AM +0200, Luca Ceresoli wrote:
>> Hi Maxime,
>>
>> On Thu Jul 16, 2026 at 3:22 PM CEST, Maxime Ripard wrote:
>> > On Thu, Jul 16, 2026 at 10:37:24AM +0200, Luca Ceresoli wrote:
>> >> >> > Now if the bridges start doing it themselves we should go back t=
o
>> >> >> > those encoder drivers and ditch all the drm_bridge_connector fro=
m
>> >> >> > there?
>> >> >> >
>> >> >> > I must be missing something. Can you elaborate on this?
>> >> >>
>> >> >> drm_bridge_connectors bring together a (complete) bridge chain and=
 a
>> >> >> connector. If you don't have either anymore, then we shouldn't kee=
p it
>> >> >> around.
>> >> >>
>> >> >> What I was suggesting before was only a suggestion. I guess we cou=
ld
>> >> >> also make the encoder own the hotplug handling code and create the
>> >> >> drm_bridge_connector when the chain is complete, and remove it whe=
n it's
>> >> >> no longer the case.
>> >> >
>> >> > That's an interesting option. We don't have to keep drm_bridge_conn=
ector
>> >> > in its current form, but I don't think we should go back to individ=
ual
>> >> > bridge driver creating connectors, especially now that we have brid=
ge
>> >> > chains where the connector ops are implemented collectively by mult=
iple
>> >> > bridges.
>> >>
>> >> I definitely agree we don't want to add burden back on the encoder.
>> >
>> > I don't think Laurent mentioned the encoder anywhere.
>>
>> Ah, indeed, sorry! However, I think both the bridges and the encoder
>> drivers should equally have the minimum burden on them.
>>
>> Right now the recommended practice is:
>>
>>  - bridges do not create connectors (thanks to DRM_BRIDGE_ATTACH_NO_CONN=
ECTOR)
>>  - encoders just call drm_bridge_connector_init(), which does all the
>>    common operations to populate a suitable drm_connector
>>
>> So all common operations involved in connector creation and bridge chain
>> analysis are implemented in common code, not per-bridge or
>> per-encoder. That's good.
>
> I agree, but another way to phrase it is: bridges aren't aware of how
> the chain is setup, the encoder ties it all together.
>
>> >> >> We can discuss alternatives too. But either way, we shouldn't have=
 it
>> >> >> stick around.
>> >>
>> >> Bottom line, I roughly see three ideas mentioned:
>> >>
>> >>  1. (this series) extend the drm_bridge_connector to create the
>> >>     drm_connector based on bridge hotplug events [+rename it]
>> >>  2. - keep the drm_bridge_connector (mostly) as is
>> >>     - let each encoder driver add/remove it based on bridge hotplug e=
vents
>> >>     =3D> more burden on encoder drivers -> no
>> >
>> > Can you motivate that with *any* reason? Because I really feel like it=
's
>> > the best solution going forward.
>>
>> My understanding of your idea (maybe a bit overstressed just to ensure i=
t's
>> clear) is that:
>>
>>  - the drm_bridge_connector should stay (almost) unmodified
>
> Yes, and bridges should ideally remain as lightly affected as possible.

I fully agree.

> We have probably around 100 bridge drivers at the moment, having some
> kind of opt-in to enable hotplug would mean that we can't expect hotplug
> to work on a new platform, which should be a last resort.

A few changes to each bridge wanting to support hotplug will unavoidably be
needed. The .get_next_bridge callback we mentioned in the discussion for
patch 30 at least. I'm keeping any other changes, if any, to a minimum.

>>  - there should be no new "manager" component (not sure this is actually
>>    your opinion, can you comment on this specifically?)
>>  - every encoder driver would have to:
>>    - register to receive hotplug events
>>    - when receiving one such event, find out whether the hardware is
>>      complete or not (by calling drm_bridge_connector_pipeline_is_comple=
te()
>>      or so)
>>    - create/destroy a drm_bridge_connector based on hotplug events
>>
>> Is this somewhat close to what you have in mind?
>
> Yes. To make things a bit more precise, we need two things: the encoder
> to put the chain together, and "something" (that you used to call
> manager) to react to hotplug events and handle the bridge
> detach/destruction, connector creation/destruction, etc and should stick
> around when we enable hotplug.
>
> What I'm suggesting is that, since the encoder already owns and creates
> the chain in the first place, and is there forever, it's only natural
> for the encoder to be that "something", and we don't necessarily mean
> creating a new entity or piece of code. A bunch of helpers and hooks a
> probably going to be enough.

That's the idea I had reached too, yes. Except the "bunch of helpers and
hooks" could be perhaps as small as one single helper function or little
more.

> This is where the opt-in part should be, and I'd like, if possible, for
> hotplug-enabled encoders to work with any bridge.
>
>> To me the best solution to add hotplug support is that encoder drivers
>> replace the single drm_bridge_connector_init() call with a single call t=
o
>> something new (let's call it a hotplug manager), which takes care of all
>> the common aspects: registering to receive bridge hotplug events, findin=
g
>> out whether the hardware pipeline is complete or not, and add/remove the
>> drm_connector based on that.
>>
>> In other words, the changes on encoder drivers would be similar to patch
>> 37. In a nutshell:
>>
>>   -	connector =3D drm_bridge_connector_init(lcdif->drm, encoder);
>>   +	drm_hotplug_manager =3D drm_hotplug_manager_init(lcdif->drm, encoder=
);
>>
>> All the hotplug logic would be in common code, and any maintenance and
>> future improvements to it would stay in a single place, benefitting all
>> encoders at once.
>>
>> What do you think about this?
>
> From a high level point-of-view, I think we mostly agree.

Good.

> We can argue
> on the name, and if we should merge it with something else
> (drm_encoder_init, drm_bridge_attach, something else?) but that's the
> path forward I think.

OK, let's see what I can come up with in v2.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
