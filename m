Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6540CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 16:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A4D10E0CE;
	Fri, 19 Jun 2026 16:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jY8Egj58";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145FA10E0CE;
 Fri, 19 Jun 2026 16:25:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A99E91A3A21;
 Fri, 19 Jun 2026 16:25:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6D0F4601AD;
 Fri, 19 Jun 2026 16:25:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08E5B106C81BC; 
 Fri, 19 Jun 2026 18:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781886299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Xrx5VoO25eYm5EH6Wc6vNdgK+6vpuoEcmvN4eX6Cvok=;
 b=jY8Egj58zUWOmsPwj9vynk2NQy9hCh/a+LGJvBDk3DqRfyL+FJQIuyDJQRRohvDhOBXcnW
 //AvVJmy/V7tylN+21mDLl593BLUfcG3dz090WmD7UcN98JIRVRLQ/m5l7+EC2wkNUXoNu
 OY3r/fPM8V0Ey5z04hzY+MHXR+FXcsckzsiV8jrezwluFXHT8MZBukmQNizYV+LllFdQFg
 Nq8mjjsoK8DWc4IXuaLUWlBpL/WCM0pLIK5BmeG/ZousyZJb+/ny8SsYGoB3m1Nbz1HyNz
 3bGNW8rAc8osqfVrmerKyh25ch/VkV9XZdD23tG58EnuIwQFtxnCNKSDDWhrYg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 18:24:46 +0200
Message-Id: <DJD5YZ2K1047.3UJ5QMMLQO6UY@bootlin.com>
Subject: Re: [PATCH v6 15/19] drm/connector: Add new atomic_create_state
 callback
Cc: <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Daniel Stone" <daniels@collabora.com>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Jyri Sarha" <jyri.sarha@iki.fi>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Simon Ser"
 <contact@emersion.fr>, "Harry Wentland" <harry.wentland@amd.com>, "Melissa
 Wen" <mwen@igalia.com>, "Sebastian Wick" <sebastian.wick@redhat.com>, "Alex
 Hung" <alex.hung@amd.com>, "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Samuel Holland" <samuel@sholland.org>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, "Raspberry Pi Kernel
 Maintenance" <kernel-list@raspberrypi.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260526-drm-mode-config-init-v6-0-852346394200@kernel.org>
 <20260526-drm-mode-config-init-v6-15-852346394200@kernel.org>
In-Reply-To: <20260526-drm-mode-config-init-v6-15-852346394200@kernel.org>
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

Hello Maxime, Dmitry, all,

On Tue May 26, 2026 at 6:46 PM CEST, Maxime Ripard wrote:
> Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> to drm_private_obj") introduced a new pattern for allocating drm object
> states.
>
> Instead of relying on the reset() callback, it created a new
> atomic_create_state hook. This is helpful because reset is a bit
> overloaded: it's used to create the initial software state, reset it,
> but also reset the hardware.
>
> It can also be used either at probe time, to create the initial state
> and possibly reset the hardware to an expected default, but also during
> suspend/resume.
>
> Both these cases come with different expectations too: during the
> initialization, we want to initialize all states, but during
> suspend/resume, drm_private_states for example are expected to be kept
> around.
>
> reset() also isn't fallible, which makes it harder to handle
> initialization errors properly. This is only really relevant for some
> drivers though, since all the helpers for reset only create a new
> state, and don't touch the hardware at all.
>
> It was thus decided to create a new hook that would allocate and
> initialize a pristine state without any side effect:
> atomic_create_state to untangle a bit some of it, and to separate the
> initialization with the actual reset one might need during a
> suspend/resume.
>
> Continue the transition to the new pattern with connectors.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

As I'm rebasing another series on current drm-misc-next, which now includes
this patch, I ran into troubles and I'm not sure what is the right thing to
do. I hope you can help me clarify this. See below for my question.

FTR the series I'm rebasing is "drm bridge hotplug", but the question is
not specific to that series.

> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -616,11 +616,19 @@ int drmm_connector_hdmi_init(struct drm_device *dev=
,
>
>  	/*
>  	 * drm_connector_attach_max_bpc_property() requires the
>  	 * connector to have a state.
>  	 */
> -	if (connector->funcs->reset)
> +	if (connector->funcs->atomic_create_state) {
> +		struct drm_connector_state *state;
> +
> +		state =3D connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(state))
> +			return PTR_ERR(state);
> +
> +		connector->state =3D state;
> +	} else if (connector->funcs->reset)
>  		connector->funcs->reset(connector);

Here a state is added to connector->state, and that's fine.

However non-HDMI connectors don't get a state created by default.

I was hit by this with the drm_bridge_connector which it can add either an
HDMI or a non-HDMI connector [0]. In the former case it calls
drmm_connector_hdmi_init(), which creates the state (in the hunk quoted
above). In the latter case, as I experienced at runtime and confirmed by
code inspection, it does not create a state: no one calls
connector->funcs->atomic_create_state.

I suspect this is related to patch 19/19 which converted the
drm_bridge_connector from drm_atomic_helper_connector_reset() to
drm_atomic_helper_connector_create_state(), and only the former sets
'connector->state =3D conn_state'.

Generally speaking, looks like a state is created only for HDMI
connectors.

The hardware I have uses the drm_bridge_connector in the non-HDMI case, so
the state is not created and this results in a NULL pointer deref later on,
in my case it's in in drm_atomic_connector_get_property().

Am I missing anything obvious?

For now I've come up with a quick workaround, adding (roughly after
connector init at [1]):

        if (!connector->state)
                connector->state =3D drm_bridge_connector_create_state(conn=
ector);

I'm not sure which would be the best solution. Maybe taking the whole
atomic_create_state/reset state creation calls [2] from
drmm_connector_hdmi_init() and hoist them up into
drmm_connector_init(), so all connectors benefit?

Let me know what you think.

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/7a921d11181065267=
2e02c392b35fdcefa4d5030/drivers/gpu/drm/display/drm_bridge_connector.c#L995=
-1029
[1] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/7a921d11181065267=
2e02c392b35fdcefa4d5030/drivers/gpu/drm/display/drm_bridge_connector.c#L103=
0
[2] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/7a921d11181065267=
2e02c392b35fdcefa4d5030/drivers/gpu/drm/drm_connector.c#L617-631

Kind regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
