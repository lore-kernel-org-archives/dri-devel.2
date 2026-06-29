Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D0DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E38510E96D;
	Mon, 29 Jun 2026 15:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KyKTA+gO";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE4010E590
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:24:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EDC051A0D12;
 Mon, 29 Jun 2026 15:24:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B62B85FF96;
 Mon, 29 Jun 2026 15:24:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AB576106F18F0; 
 Mon, 29 Jun 2026 17:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782746648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=t9HMNcmuNOgHLZxwriuw4CBow1Oqe0l3xin2DE2AG/U=;
 b=KyKTA+gOIjf7GpxHnA2BZSNdQhPh/FN5WhHsijEVb+j6YeAbTaPwUR777uRBDlp/buzMQ7
 SuG/NJVdaYV2mUiMF4Up/pg3J7xmsNrmKcsky6rPxNXvY08Kvqg9e3q+jcMyO1PKybzXdy
 0or9lnIQOd2yh88sxr109v6Vp4KrCA1g2mh8Ea7iz/YGb0WK2/GuCI6qPyEjQCHP3SfQfw
 ny6brEttZe39S+lrHj7pO06RZi5KGB0oPj3Ju0dvnNMJmzIimpS8a/d2W3w2l/GtqGBpn3
 Xab86sgnBfUIISwfU4LEMd86fdtFmDNKzEb88tL7mndHgSLTloSm4RhuhOyu3A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 17:23:59 +0200
Message-Id: <DJLMXVXP93KY.1K1DUHELTRHT2@bootlin.com>
Cc: "Maxime Ripard" <mripard@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
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
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Luca Ceresoli"
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
 <DJJ4X22CJ3FG.5EYF84LVRNOG@bootlin.com>
 <20260629144443.GA3106950@killaraus.ideasonboard.com>
In-Reply-To: <20260629144443.GA3106950@killaraus.ideasonboard.com>
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

On Mon Jun 29, 2026 at 4:44 PM CEST, Laurent Pinchart wrote:
> On Fri, Jun 26, 2026 at 06:51:14PM +0200, Luca Ceresoli wrote:
>> On Fri Jun 26, 2026 at 4:38 PM CEST, Maxime Ripard wrote:
>> > On Fri, Jun 26, 2026 at 04:16:39PM +0200, Luca Ceresoli wrote:
>> >> On Fri Jun 26, 2026 at 12:09 PM CEST, Maxime Ripard wrote:
>> >> > On Wed, Jun 24, 2026 at 05:47:10PM +0200, Luca Ceresoli wrote:
>> >> >> On Wed Jun 24, 2026 at 1:41 PM CEST, Maxime Ripard wrote:
>> >> >> > On Fri, Jun 12, 2026 at 02:56:24PM +0200, Luca Ceresoli wrote:
>> >> >> >> On Mon Jun 8, 2026 at 1:40 PM CEST, Maxime Ripard wrote:
>> >> >> >> > On Tue, May 19, 2026 at 12:37:22PM +0200, Luca Ceresoli wrote=
:
>> >> >> >> >> In preparation to introduce bridge hotplug, split out from
>> >> >> >> >> drm_bridge_connector_init() the code adding the drm_connecto=
r into a
>> >> >> >> >> dedicated function. This will be needed to be able to add (a=
nd re-add) the
>> >> >> >> >> connector from different code paths.
>> >> >> >> >
>> >> >> >> > Same story here, explaining what you need later on that calls=
 for that
>> >> >> >> > change would be nice.
>> >> >> >>
>> >> >> >> Here's a more verbose version:
>> >> >> >>
>> >> >> >>     Currently drm_bridge_connector_init() does two things:
>> >> >> >>
>> >> >> >>      * allocate and initialize the drm_bridge_connector
>> >> >> >>        (which embeds a drm_connector)
>> >> >> >>      * initialize and register the embedded drm_connector
>> >> >> >>
>> >> >> >>     For bridge hotplug we need to separate these two actions:
>> >> >> >>
>> >> >> >>      * the drm_connector needs to be added and removed at any t=
ime based on
>> >> >> >>        hotplug events
>> >> >> >>      * the drm_bridge_connector is designated to create and rem=
ove the
>> >> >> >>        drm_connector, so it must be persistent for the card lif=
etime
>> >> >> >>
>> >> >> >>     As the lifetimes of drm_bridge_connector and drm_connector =
become
>> >> >> >>     different, we need to create them in different moments.
>> >> >> >>
>> >> >> >>     In preparation to support that, split out from
>> >> >> >>     drm_bridge_connector_init() the code adding the drm_connect=
or into a
>> >> >> >>     dedicated function. No functional changes, just moving code=
 around for
>> >> >> >>     now. A future commit will make the drm_connector be created=
 based on
>> >> >> >>     hotplug events.
>> >> >> >>
>> >> >> >> Looks good?
>> >> >> >
>> >> >> > The message itself, yes, thanks.
>> >> >> >
>> >> >> > However, I have questions now :)
>> >> >> >
>> >> >> > Do we really expect drm_bridge_connector to stick around when a =
bridge
>> >> >> > gets unplugged? If so, how does it cope with having, say, an HDM=
I
>> >> >> > connector, and then swapping out the hotplugged part for an LVDS=
 one?
>> >> >> > Does the HDMI connector sticks around indefinitely?
>> >> >>
>> >> >> In your example, the HDMI drm_connector would be unregistered and =
put on
>> >> >> hotunplug. Its allocation will stick around until the last put but=
 that's
>> >> >> quite irrelevant. Then, on plugging the LVDS addon, a new LVDS
>> >> >> drm_connector will be created and registered.
>> >> >>
>> >> >> > *Especially* if we're using overlays for this, I'd expect everyt=
hing
>> >> >> >  after the first hotplugged bridge to be destroyed, no?
>> >> >>
>> >> >> As said, it would be unregistered immediately but might be freed l=
ater on
>> >> >> if still refcounted.
>> >> >>
>> >> >> This is visible in patches 36+15, the path to follow is:
>> >> >>
>> >> >>  drm_bridge_connector_handle_event(event =3D DRM_BRIDGE_DETACHED) =
[patch 36]
>> >> >>  -> drm_bridge_connector_dynconn_release()                      [p=
atch 15]
>> >> >>
>> >> >> Does this solve your concern?
>> >> >
>> >> > Not really, I'm talking about drm_bridge_connector. The fact that
>> >> > bridges are destroyed make sense to me. The fact that
>> >> > drm_bridge_connector sticks around doesn't. It's supposed to be a
>> >> > connector for bridges. If you don't have bridges because they got
>> >> > destroyed, and connector, drm_bridge_connector doesn't have a reaso=
n to
>> >> > exist anymore, unless it's drm_bridge_hotplug in a trench coat :)
>> >>
>> >> It is not a hotplug-bridge in a trench coat, no :) The code is clear =
about
>> >> this.
>> >>
>> >> I'd say with this series a "drm_bridge_connector" is just becoming
>> >> something more (perhaps something else too). Somewhat as "a drm_bridg=
e is
>> >> either a bridge or something else". :)
>> >>
>> >>
>> >> But let's leave names aside for a moment. If just looking at the curr=
ent
>> >> code, the drm_bridge_connector is "a handler, owned by the card/encod=
er and
>> >> having the same lifetime, which takes care of drm_connector
>> >> creation/destruction at card probe/removal".
>> >>
>> >> What we need now is just the same plug " and on hotplug events" appen=
ded.
>> >>
>> >> So in both cases there needs to be "a handler persitent with the card=
".
>> >>
>> >> Do we agree so far?
>> >
>> > Ish. If we go for that, then we need to update the name.
>>
>> drm_connector_manager?
>> drm_bridge_connector_manager?
>
> I'm fine with a rename. When developing drm_bridge_connector I've always
> envisioned it as code that manages the creation of a connector for a
> chain of bridges. In particular, the drm_bridge_connector object is
> *not* and has never been a bridge.

That's my understanding of the drm_bridge_connector too.

> Ideally all this should move to the DRM core and be transparent to
> drivers. Drivers could set a flag somewhere to opt-in for connectors
> managed by the DRM core.

Not sure I got what you mean.

Currently drivers "opt-in" by:

 1. passing DRM_BRIDGE_ATTACH_NO_CONNECTOR to drm_bridge_attach()
 2. instantiating a drm_bridge_connector via drm_bridge_connector_init()

Do you suggest changing that, so 1 and 2 are done transparently if the
driver sets a new flag?

>> > drm_bridge_connector for something that is neither a bridge or a
>> > connector is not great.
>> >
>> > But even then, I'm not even sure why we need to have that "manager" in
>> > the first place. You want to make bridges be aware if they are the las=
t
>> > in the chain or not.
>
> I don't think bridges should be aware of whether or not they're the last
> one in the chain.

I proposed that, not because I "want" that but because for hotplug we need
a way to know whether a DRM video pipeline is complete in the hardware or
not. This is used in patch 36:

	/* Add the connector if the pipeline is now complete */
	if (drm_bridge_connector_pipeline_is_complete(bridge_connector))
		drm_bridge_connector_add_connector(bridge_connector);

In other words, on a hotplug event (some new hardware was added), check
whether the card is now complete _in the hardware_, and if it is create a
drm_connector.

In this series I proposed implementing it via a new .is_tail callback, that
has been rejected during Dispaly Next Hackfest [0].

The idea that popped up there was that bridge drivers could expose the
fwnode handler to the port@<N>/endpoint pointing to the next bridge. I
liked the idea but then I realized it would hardly fly in complex cases
like bridges with dual-LVDS-or-two-single-LVDS output, e.g. SN65DSI84.

So Maxime proposed [1]:

 ) Thanks for the notes, I think I largely agree with the discussion.
 ) Reading through it, I thought it would be nice for a new callback called
 ) get_next_bridge or something that would return either an error, NULL or =
a
 ) (refcounted) pointer to the next bridge in the chain. And have some kind
 ) of special error (ENODEV?) when the bridge should be there but isn't
 ) (and thus the chain isn't complete).

To me, "Making bridges aware if they are the last in the chain or not" is
not a goal. It is just a technique to implement
drm_bridge_connector_pipeline_is_complete().  I'm happy to implementing it
in a different way if you have better ideas, but I haven't.

[0] https://lore.kernel.org/lkml/DIXTUCXAU68V.1T7X89LMEUF2F@bootlin.com/
[1] https://lore.kernel.org/lkml/20260624-vagabond-neon-gorilla-cd6487@houa=
t/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
