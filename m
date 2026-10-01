Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B09CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFE610F689;
	Thu,  1 Oct 2026 13:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A+XTjbJy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FED10F68C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:31:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6445543F58;
 Thu,  1 Oct 2026 13:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116BE1F00899;
 Thu,  1 Oct 2026 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790861500;
 bh=YRIXMT91xwfN7EXeoTmdITQO3Y/Hp4+WgaSJVnHWCkQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A+XTjbJyGnuqzzPTpS+JJF/gp0L1VD45EBwWvPnbI1eTNx9fOZWimAPCdLnvshpoD
 6o+BZWatmmdhV8x5jYlmoOIbt3MZnT5gNpF4cmS7nXtum+eU5McwOvFiE97ijK9ytt
 Bm2h1l9QysOzUUOBzTcCKRiygxoAUrcL8hDKo1flEL3EbfcQB2St3NZcECIPj4JYgD
 3PENBLAakJiyT2k8VCxWt1g44hozitW4XEiwga+O2GqL9Btr1b4dpNN4P8RGgCSsqv
 CXbIo5RWxD7VGTsemgYUXRHOsFsvtla7A3w97X39Pyys2+kYbC5GbLe1jT+eAFe4mq
 uOvAx8p1YPQHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 23/24] drm: drm_hotplug_helper: new helper to
 implement bridge hotplug
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20261001-drm-bridge-hotplug-v2-23-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-23-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:31:39 +0000
Message-Id: <20261001133140.116BE1F00899@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm: NULL pointer dereferences of last_bridge and optional attach =
callback
- [High] drm: refcount underflow on bridge returned by drm_bridge_get_next()
- [Medium] drm: drmm_hotplug_helper_init returns NULL on success violating =
API contract
- [Medium] drm: data race on hotplug_helper->connector outside of connector=
_mutex
- [Medium] drm: duplicate invocation of attach callback bypassing drm_bridg=
e_attach()
- [Medium] drm: TOCTOU race misses hotplug events due to late notifier regi=
stration
- [Low] drm: spurious drm_WARN_ON triggered on normal teardown of incomplet=
e pipeline
--

commit 251bdf083a0bf54162b14a9598f43ad560284a46
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm: drm_hotplug_helper: new helper to implement bridge hotplug

This commit adds a new helper to support cards implementing hotpluggable
DRM bridges. It registers to get notified of relevant events and reacts
by creating a bridge if the pipeline is complete, and destroying it on
bridge removal.

> diff --git a/drivers/gpu/drm/display/drm_hotplug_helper.c b/drivers/gpu/d=
rm/display/drm_hotplug_helper.c
> index 0000000000000..1b89b14b52aa2
> --- /dev/null
> +++ b/drivers/gpu/drm/display/drm_hotplug_helper.c

[ ... ]

> +static bool drm_hotplug_helper_pipeline_is_complete(struct drm_hotplug_h=
elper *hotplug_helper)
> +{
> +	struct drm_bridge *last_bridge __free(drm_bridge_put) =3D
> +		drm_bridge_chain_get_last_bridge(hotplug_helper->encoder);
> +
> +	/* We expect at least one bridge */
> +	if (!last_bridge) {
> +		drm_dbg_driver(hotplug_helper->drm, "no bridges in pipeline (yet)\n");
> +		return false;
> +	}
> +
> +	struct drm_bridge *next_bridge __free(drm_bridge_put) =3D
> +		drm_bridge_get_next(last_bridge);

[Severity: High]
Does this code cause a refcount underflow? The pointer returned by
drm_bridge_get_next() directly returns the pointer from the callback without
incrementing its kref reference count.

When the function returns, drm_bridge_put() executes and decrements the
reference count. Since a reference was never acquired, this leads to an
underflow and a use-after-free vulnerability.

[ ... ]

> +static void drm_hotplug_helper_connector_remove(struct drm_hotplug_helpe=
r *hotplug_helper)
> +{
> +	guard(mutex)(&hotplug_helper->connector_mutex);
> +
> +	if (drm_WARN_ON(hotplug_helper->drm, !hotplug_helper->connector))
> +		return;

[Severity: Low]
Will this trigger a spurious kernel warning during normal device teardown?

drmm_hotplug_helper_init() registers drm_hotplug_helper_fini() to run
unconditionally on teardown, which calls this function. If a bridge was
never hotplugged or the pipeline was incomplete, hotplug_helper->connector
legitimately remains NULL.

[ ... ]

> +static void drm_hotplug_helper_try_complete(struct drm_hotplug_helper *h=
otplug_helper)
> +{
> +	int err;
> +
> +	/*
> +	 * drm_connector already present, the new bridge must be for
> +	 * another card
> +	 */
> +	if (hotplug_helper->connector)
> +		return;

[Severity: Medium]
Can this unprotected read lead to a data race on hotplug_helper->connector?

The connector pointer is documented as protected by the connector_mutex.
Since the DRM event notifier uses a blocking notifier chain, concurrent
events could locklessly observe the connector as NULL before the addition
path completes, potentially leading to duplicate bridge attach attempts.

> +
> +	/* Propagate the attach call chain to newly hotplugged bridge(s) */
> +	struct drm_bridge *last_bridge __free(drm_bridge_put) =3D
> +		drm_bridge_chain_get_last_bridge(hotplug_helper->encoder);
> +	err =3D last_bridge->funcs->attach(last_bridge, hotplug_helper->encoder,
> +					 DRM_BRIDGE_ATTACH_NO_CONNECTOR);

[Severity: High]
Can this code cause a NULL pointer dereference?

drm_bridge_chain_get_last_bridge() returns NULL if the chain is empty,
which can occur if an unrelated global DRM_MIPI_DSI_ATTACHED event triggers
this on an empty pipeline. Unconditionally dereferencing last_bridge->funcs
would crash.

Additionally, the attach callback in struct drm_bridge_funcs is documented
as optional. Unconditionally dereferencing it will crash for bridges that
omit it.

[Severity: Medium]
Could this also lead to a duplicate invocation of the attach callback?

Because last_bridge is already in the bridge chain, it has already been
attached during initialization. Bypassing the standard drm_bridge_attach()
API and manually calling the internal attach callback on the same bridge
breaks driver state expectations, potentially causing memory leaks or
hardware state corruption.

[ ... ]

> +struct drm_hotplug_helper *drmm_hotplug_helper_init(struct drm_device *d=
rm,
> +						    struct drm_encoder *encoder)
> +{
> +	struct drm_hotplug_helper *hotplug_helper;
> +	int ret;
> +
> +	hotplug_helper =3D drmm_kzalloc(drm, sizeof(*hotplug_helper), GFP_KERNE=
L);
> +	if (!hotplug_helper)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&hotplug_helper->connector_mutex);
> +	hotplug_helper->drm =3D drm;
> +	hotplug_helper->encoder =3D encoder;
> +	hotplug_helper->drm_event_nb.notifier_call =3D drm_hotplug_helper_handl=
e_event;
> +
> +	if (drm_hotplug_helper_pipeline_is_complete(hotplug_helper)) {
> +		ret =3D drm_hotplug_helper_connector_add(hotplug_helper);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	ret =3D drmm_add_action_or_reset(drm, drm_hotplug_helper_fini, hotplug_=
helper);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret =3D drm_event_notifier_register(&hotplug_helper->drm_event_nb);

[Severity: Medium]
Does the gap between evaluating pipeline completeness and registering for
notifications create a time-of-check to time-of-use race?

If a bridge is hotplugged in the exact window between the pipeline check
above and this notifier registration, the DRM_MIPI_DSI_ATTACHED event is
missed, leaving the pipeline permanently incomplete.

> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret =3D drmm_add_action_or_reset(drm, drm_hotplug_helper_notifier_unreg=
ister,
> +				       &hotplug_helper->drm_event_nb);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return 0;

[Severity: Medium]
Does returning 0 violate the API contract?

The function signature and kernel-doc state it returns a struct
drm_hotplug_helper pointer on success, or an error pointer on failure.
The success path executes return 0, returning a NULL pointer. Callers
correctly checking IS_ERR() will assume success and any subsequent
dereference of the returned pointer will crash.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D23
