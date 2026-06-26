Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F16C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96A010E3D2;
	Fri, 26 Jun 2026 16:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="co0ZolZJ";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110D410E3D2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 16:51:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0750FC5CD6A;
 Fri, 26 Jun 2026 16:51:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F1E3460232;
 Fri, 26 Jun 2026 16:51:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 42B2D104C9D9B; 
 Fri, 26 Jun 2026 18:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782492682; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=8iEHH7+jMGAu88nTaddZ+kCu6HVN0Ooq1Pzt5v1N4lk=;
 b=co0ZolZJ858fCfOk8D33vEBCh0s9JzN/MrFxHMj1DWEl0PeQg+TvCZNcOBIk9uJm8A70aQ
 NtjIEBNc92ycLE6QVXH5Wx9qnfc0mU+Ln60OMBNf/UKB1cKvJgbLHzXBq8rEfVvugoE0zM
 L7w/q6YkjZrBjop4aIVdjCttWllHn8T8JWL94GdmmD5mJe+APArqEaM4tkXMUI0RxIwLNu
 HxDcFfDuc8rYTFZFlIqLDDa7aePw9gBvLYD3z4aBlHHR617Z7ZXOoxSDAw+0ac1YH+Hly+
 oHDEv37X29MEiyfdk4N+Jf7eQxI5P1uIuINj2LLK9d0l53+EyGdzHOue48e2CQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 18:51:14 +0200
Message-Id: <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>,
 "Stefan Agner" <stefan@agner.ch>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code
 creating the connector to a subfunction
X-Mailer: aerc 0.21.0
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-5-45e2bdb3dfb4@bootlin.com>
 <20260608-mindful-heavy-frigatebird-be9faf@houat>
 <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
 <20260624-proud-unbiased-pony-ecc3c3@houat>
 <DJHEAWSEZR79.19UFIKS8QJBQ7@bootlin.com>
 <20260626-polite-hairy-perch-25e1aa@houat>
 <DJJ1MPCEJGZD.UZM9183V6ZE5@bootlin.com>
 <20260626-classy-nightingale-of-romance-1cacad@houat>
In-Reply-To: <20260626-classy-nightingale-of-romance-1cacad@houat>
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

On Fri Jun 26, 2026 at 4:38 PM CEST, Maxime Ripard wrote:
> On Fri, Jun 26, 2026 at 04:16:39PM +0200, Luca Ceresoli wrote:
>> Hi Maxime,
>>
>> On Fri Jun 26, 2026 at 12:09 PM CEST, Maxime Ripard wrote:
>> > On Wed, Jun 24, 2026 at 05:47:10PM +0200, Luca Ceresoli wrote:
>> >> On Wed Jun 24, 2026 at 1:41 PM CEST, Maxime Ripard wrote:
>> >> > Hi,x
>> >> >
>> >> > On Fri, Jun 12, 2026 at 02:56:24PM +0200, Luca Ceresoli wrote:
>> >> >> On Mon Jun 8, 2026 at 1:40 PM CEST, Maxime Ripard wrote:
>> >> >> > On Tue, May 19, 2026 at 12:37:22PM +0200, Luca Ceresoli wrote:
>> >> >> >> In preparation to introduce bridge hotplug, split out from
>> >> >> >> drm_bridge_connector_init() the code adding the drm_connector i=
nto a
>> >> >> >> dedicated function. This will be needed to be able to add (and =
re-add) the
>> >> >> >> connector from different code paths.
>> >> >> >
>> >> >> > Same story here, explaining what you need later on that calls fo=
r that
>> >> >> > change would be nice.
>> >> >>
>> >> >> Here's a more verbose version:
>> >> >>
>> >> >>     Currently drm_bridge_connector_init() does two things:
>> >> >>
>> >> >>      * allocate and initialize the drm_bridge_connector
>> >> >>        (which embeds a drm_connector)
>> >> >>      * initialize and register the embedded drm_connector
>> >> >>
>> >> >>     For bridge hotplug we need to separate these two actions:
>> >> >>
>> >> >>      * the drm_connector needs to be added and removed at any time=
 based on
>> >> >>        hotplug events
>> >> >>      * the drm_bridge_connector is designated to create and remove=
 the
>> >> >>        drm_connector, so it must be persistent for the card lifeti=
me
>> >> >>
>> >> >>     As the lifetimes of drm_bridge_connector and drm_connector bec=
ome
>> >> >>     different, we need to create them in different moments.
>> >> >>
>> >> >>     In preparation to support that, split out from
>> >> >>     drm_bridge_connector_init() the code adding the drm_connector =
into a
>> >> >>     dedicated function. No functional changes, just moving code ar=
ound for
>> >> >>     now. A future commit will make the drm_connector be created ba=
sed on
>> >> >>     hotplug events.
>> >> >>
>> >> >> Looks good?
>> >> >
>> >> > The message itself, yes, thanks.
>> >> >
>> >> > However, I have questions now :)
>> >> >
>> >> > Do we really expect drm_bridge_connector to stick around when a bri=
dge
>> >> > gets unplugged? If so, how does it cope with having, say, an HDMI
>> >> > connector, and then swapping out the hotplugged part for an LVDS on=
e?
>> >> > Does the HDMI connector sticks around indefinitely?
>> >>
>> >> In your example, the HDMI drm_connector would be unregistered and put=
 on
>> >> hotunplug. Its allocation will stick around until the last put but th=
at's
>> >> quite irrelevant. Then, on plugging the LVDS addon, a new LVDS
>> >> drm_connector will be created and registered.
>> >>
>> >> > *Especially* if we're using overlays for this, I'd expect everythin=
g
>> >> >  after the first hotplugged bridge to be destroyed, no?
>> >>
>> >> As said, it would be unregistered immediately but might be freed late=
r on
>> >> if still refcounted.
>> >>
>> >> This is visible in patches 36+15, the path to follow is:
>> >>
>> >>  drm_bridge_connector_handle_event(event =3D DRM_BRIDGE_DETACHED) [pa=
tch 36]
>> >>  -> drm_bridge_connector_dynconn_release()                      [patc=
h 15]
>> >>
>> >> Does this solve your concern?
>> >
>> > Not really, I'm talking about drm_bridge_connector. The fact that
>> > bridges are destroyed make sense to me. The fact that
>> > drm_bridge_connector sticks around doesn't. It's supposed to be a
>> > connector for bridges. If you don't have bridges because they got
>> > destroyed, and connector, drm_bridge_connector doesn't have a reason t=
o
>> > exist anymore, unless it's drm_bridge_hotplug in a trench coat :)
>>
>> It is not a hotplug-bridge in a trench coat, no :) The code is clear abo=
ut
>> this.
>>
>> I'd say with this series a "drm_bridge_connector" is just becoming
>> something more (perhaps something else too). Somewhat as "a drm_bridge i=
s
>> either a bridge or something else". :)
>>
>>
>> But let's leave names aside for a moment. If just looking at the current
>> code, the drm_bridge_connector is "a handler, owned by the card/encoder =
and
>> having the same lifetime, which takes care of drm_connector
>> creation/destruction at card probe/removal".
>>
>> What we need now is just the same plug " and on hotplug events" appended=
.
>>
>> So in both cases there needs to be "a handler persitent with the card".
>>
>> Do we agree so far?
>
> Ish. If we go for that, then we need to update the name.

drm_connector_manager?
drm_bridge_connector_manager?

> drm_bridge_connector for something that is neither a bridge or a
> connector is not great.
>
> But even then, I'm not even sure why we need to have that "manager" in
> the first place. You want to make bridges be aware if they are the last
> in the chain or not. Use that property in attach to either create a
> drm_bridge_connector instance if you're last, or attach the next bridge
> if you aren't.

What? o_O

Several encoder drivers have been painfully converted to create a
drm_bridge_connector. Now if the bridges start doing it themselves we
should go back to those encoder drivers and ditch all the
drm_bridge_connector from there?

I must be missing something. Can you elaborate on this?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
