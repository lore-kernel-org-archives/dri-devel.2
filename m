Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A216C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E9510F2F3;
	Fri, 21 Aug 2026 15:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O2EJ1HQi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9456710E2E3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:06:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38365402DA;
 Fri, 21 Aug 2026 15:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAA71F000E9;
 Fri, 21 Aug 2026 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787324774;
 bh=+OVfrYjn2SgfcbQVoN7iYRAKCRAMSRPR0gqOWg+0zPE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O2EJ1HQi3pp4yP3XzJ6va1W+Rvfd1K779Xz/rPDLfsQWoocJcJT+V5DYvu1Lmx0m5
 YVeMkxlWbwZ+4MT/7u1xQdrlYrRUilC7ePJos/uCDFn+7GvTQEXtV2gTCFz5QNnAdT
 tVarcmgxnvyRnWJLpKfXGypuReVHdSSt/ek4WJ7N8Pmcp/rxOLc/670UUMnbc+nD/4
 y0aAxhbmxSQb8Ospu0YCHcCubIlfbIR0GVrY42qahdOnPTWZ3wBXOvLP57lzVzNzdz
 EmMaCHEbu/F8dUedH5GUkZq9/pwN4BHuL8K6Eivg+GGEJ85VvhVuHF0li8tq6h5+iQ
 Xa2DlCesZKRxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/connector: Cache out-of-band hotplug events
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
References: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:06:13 +0000
Message-Id: <20260821150613.ECAA71F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Out-of-order delivery of OOB hotplug events due to a Time-of-Check=
 to Time-of-Use (TOCTOU) race condition during connector registration.
- [Medium] Permanent memory leak of fwnode references and drm_oob_hotplug_s=
tate structs for dynamically generated fwnodes.
--

--- Patch [1]: [PATCH] drm/connector: Cache out-of-band hotplug events ---
commit 4d3add94a455defa7c034e56e4bb755bf2de93af
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/connector: Cache out-of-band hotplug events

When the USB-C state machine finished negotiating DP AltMode before the
DRM device has been probed, the out-of-band hotplug events fired to
early and are lost. Without replugging the display or reloading the
USB-C driver, the DRM driver assumes nothing is plugged.

Link: https://lore.kernel.org/dri-devel/20767137.geO5KgaWL5@diego/
Link: https://lore.kernel.org/dri-devel/20260811211534.8618-1-royalnet026@g=
mail.com/

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 8b4baed060f3a..b69e3776b1539 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c

[ ... ]

> @@ -829,6 +859,36 @@ void drm_connector_cleanup(struct drm_connector *con=
nector)
>  }
>  EXPORT_SYMBOL(drm_connector_cleanup);
> =20
> +/**
> + * drm_connector_replay_oob_hotplug_event - send cached OOB HPD event
> + * @connector: the connector that should receive the event
> + *
> + * Send the cached out-of-band hotplug as a new out-of-band hotplug even=
t.
> + */
> +static void drm_connector_replay_oob_hotplug_event(struct drm_connector =
*connector)
> +{
> +	struct fwnode_handle *fwnode =3D connector->fwnode;
> +	enum drm_connector_status status;
> +	struct drm_oob_hotplug_state *e;
> +	bool found =3D false;
> +
> +	if (!fwnode || !connector->funcs->oob_hotplug_event)
> +		return;
> +
> +	scoped_guard(mutex, &oob_hotplug_list_lock) {
> +		list_for_each_entry(e, &oob_hotplug_list, head) {
> +			if (e->fwnode =3D=3D fwnode || fwnode->secondary =3D=3D e->fwnode) {
> +				status =3D e->status;
> +				found =3D true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (found)
> +		connector->funcs->oob_hotplug_event(connector, status);

[Severity: High]
Does this create a race condition that could result in out-of-order event
delivery?

When this function drops the oob_hotplug_list_lock after reading the state,
a concurrent hardware hotplug event could be processed by
drm_connector_oob_hotplug_event() in another thread.

If that thread updates the cache and fires the connector callback with a
new connected status, would this function then execute its callback with
the older, stale cached status, permanently desynchronizing the state?

> +}
> +

[ ... ]

> @@ -3671,6 +3737,41 @@ struct drm_connector *drm_connector_find_by_fwnode=
(struct fwnode_handle *fwnode)
>  	return found;
>  }
> =20
> +/**
> + * drm_connector_record_oob_hotplug_status - Cache OOB hotplug status
> + * @fwnode - fwnode for the DRM connector
> + * @status - out-of-band status info
> + *
> + * Cache the latest out-of-band hotplug status for a fwnode so it can be
> + * (re)played from when the DRM device is (re)registered after this event
> + * arrived.
> + */
> +static void drm_connector_record_oob_hotplug_status(struct fwnode_handle=
 *fwnode,
> +						    enum drm_connector_status status)
> +{
> +	struct drm_oob_hotplug_state *e;
> +
> +	if (!fwnode)
> +		return;
> +
> +	guard(mutex)(&oob_hotplug_list_lock);
> +
> +	list_for_each_entry(e, &oob_hotplug_list, head) {
> +		if (e->fwnode =3D=3D fwnode) {
> +			e->status =3D status;
> +			return;
> +		}
> +	}
> +
> +	e =3D kzalloc(sizeof(*e), GFP_KERNEL);
> +	if (!e)
> +		return;
> +
> +	e->fwnode =3D fwnode_handle_get(fwnode);
> +	e->status =3D status;
> +	list_add_tail(&e->head, &oob_hotplug_list);

[Severity: Medium]
Will this leak memory and fwnode references for dynamically generated fwnod=
es?

It appears that a new state object is allocated and appended to the global
oob_hotplug_list, and a reference to the fwnode is taken. However, there
does not seem to be any eviction mechanism to remove these items when a
connector is destroyed.

If dynamic fwnodes are continually added and removed, could this result in
unbounded growth of the list and eventual resource exhaustion?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-connec=
tor-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com?part=3D1
