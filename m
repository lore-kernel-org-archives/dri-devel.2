Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA00FCD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE9D10E21F;
	Tue,  9 Jun 2026 10:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DX9lWzMv";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFCF210E21F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:10:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 572EB4E415AE;
 Tue,  9 Jun 2026 10:10:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 101935FFC1;
 Tue,  9 Jun 2026 10:10:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0C1C3106A2B16; 
 Tue,  9 Jun 2026 12:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780999849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2wKmJGWh+F/mw2sMZdDF/3ANgln0RLhLSsGBS838lO4=;
 b=DX9lWzMvivOBeg+GA03lKvb3KNdMdhFWLKfjXhllejwmqUQ7C9eS9CPE8QdPl85nuh0Pue
 MgMHk8tX/g/lr+tI2K0EuziD0qUqlG+5AmZ+QH20iwZ1Fh9JhI8NqQ9VD+YEND61FFA1F1
 1Mt7n9zYGUK9+/yVbkFaN4PaiNcXxhlGv4kOx1Y9xTZ3eMtE7GhZrvpAJzshsRnx6Jg+og
 n+xVtN9FJYhc1J0E2IbclZzXKCdP3XN6ZA8MAlKhk89H8jqQJjE31Xlb8aPoPpi8lbkSKd
 R4UhXvPSwRqH0pID4b3q3nj8BSAwvv6e5plzY8znNj9xjnLUx7Ao35jlDQOGKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 12:10:39 +0200
Message-Id: <DJ4FR339GCKY.21P0315EZLRJU@bootlin.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 23/37] drm/encoder: add drm_encoder_cleanup_from()
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
X-Mailer: aerc 0.21.0
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-23-45e2bdb3dfb4@bootlin.com>
 <20260608-mighty-woodlouse-of-reading-162bca@houat>
In-Reply-To: <20260608-mighty-woodlouse-of-reading-162bca@houat>
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

On Mon Jun 8, 2026 at 2:10 PM CEST, Maxime Ripard wrote:
> On Tue, May 19, 2026 at 12:37:40PM +0200, Luca Ceresoli wrote:
>> Supporting hardware whose final part of the DRM pipeline can be physical=
ly
>> removed requires the ability to detach all bridges from a given point to
>> the end of the pipeline.
>>
>> Introduce a variant of drm_encoder_cleanup() for this.
>>
>> Take care to not try detaching non-attached bridges. This is needed beca=
use
>> when two or more bridges are removed not in the backwards order,
>> drm_encoder_cleanup_from() is called more than once for bridges closer t=
o
>> the panel.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>
>> ---
>>
>> Note: in theory drm_encoder_cleanup() is now a superset of
>> drm_encoder_cleanup_from() and may be simplified to just call
>> drm_encoder_cleanup_from() and then do the extra actions. However the
>> common code is subtly different in terms of locking and checks, so this
>> would complicate the code in this patch and has thus been kept separate =
for
>> the time being to make reviewing sompler. Reimplementing
>> drm_encoder_cleanup() by using drm_encoder_cleanup_from() cvacn be done
>> later on.
>>
>> A much simpler and now obsolete version of this patch (missing locking a=
nd
>> checks) previously appeared in
>> https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-13-9d6f2c9c3=
058@bootlin.com/
>> ---
>>  drivers/gpu/drm/drm_encoder.c | 38 ++++++++++++++++++++++++++++++++++++=
++
>>  include/drm/drm_encoder.h     |  1 +
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder=
.c
>> index 0d5dbed06db4..40ece477b302 100644
>> --- a/drivers/gpu/drm/drm_encoder.c
>> +++ b/drivers/gpu/drm/drm_encoder.c
>> @@ -179,6 +179,44 @@ int drm_encoder_init(struct drm_device *dev,
>>  }
>>  EXPORT_SYMBOL(drm_encoder_init);
>>
>> +/**
>> + * drm_encoder_cleanup_from - remove a given bridge and all the followi=
ng
>> + * @encoder: encoder whole list of bridges shall be pruned
>> + * @bridge: first bridge to remove
>> + *
>> + * Removes from an encoder all the bridges starting with a given bridge
>> + * and until the end of the chain.
>> + *
>> + * Does nothing if the bridge is not attached to an encoder chain.
>> + *
>> + * This should not be used in "normal" DRM pipelines. It is only useful=
 for
>> + * devices whose final part of the DRM chain can be physically removed =
and
>> + * later reconnected (possibly with different hardware).
>> + */
>> +void drm_encoder_cleanup_from(struct drm_encoder *encoder, struct drm_b=
ridge *bridge)
>> +{
>> +	struct drm_bridge *next;
>> +	LIST_HEAD(tmplist);
>> +
>> +	/*
>> +	 * We need the bridge_chain_mutex to modify the chain, but
>> +	 * drm_bridge_detach() will call DRM_MODESET_LOCK_ALL_BEGIN() (in
>> +	 * drm_modeset_lock_fini()), resulting in a possible ABBA circular
>> +	 * deadlock. Avoid it by first moving all the bridges to a
>> +	 * temporary list holding the lock, and then calling
>> +	 * drm_bridge_detach() without the lock.
>> +	 */
>> +	mutex_lock(&encoder->bridge_chain_mutex);
>> +	if (!list_empty(&bridge->chain_node))
>> +		list_for_each_entry_safe_from(bridge, next, &encoder->bridge_chain, c=
hain_node)
>> +			list_move_tail(&bridge->chain_node, &tmplist);
>> +	mutex_unlock(&encoder->bridge_chain_mutex);
>> +
>> +	while (!list_empty(&tmplist))
>> +		drm_bridge_detach(list_first_entry(&tmplist, struct drm_bridge, chain=
_node));
>> +}
>> +EXPORT_SYMBOL(drm_encoder_cleanup_from);
>> +
>
> The name is super confusing, because it doesn't clean up anything.
> drm_encoder_cleanup is called that way because it cleans up the encoder.
> This function doesn't.
>
> Unlike what's being documented, it doesn't remove any bridge either. It
> just detaches bridge, so let's just call it that way?

Good point.

What about:

 * rename to drm_bridge_detach_from()
 * drop the @encoder argument (get if from bridge->encoder)
 * maybe even move to drm_bridge.c?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
