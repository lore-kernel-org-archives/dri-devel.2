Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02B606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcieJFso
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDD710F14F;
	Mon,  2 Nov 2026 18:35:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E7310E13B;
 Mon,  2 Nov 2026 18:34:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B0A160609;
 Mon,  2 Nov 2026 18:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8F01F00A17;
 Mon,  2 Nov 2026 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793644497;
 bh=6qIDn35Yo4W/SbtUA+gH/kviba5Fsv5JPHIsFCS+2EA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BcieJFso4J6eOAsGIVYP8chCDXUN/ExDAph7mO5kPGJ2UrfQ8+CMxBUfS8AZmlIvE
 qH1otO3eGfhQJY6NK4nnFzuLUWHCo2HPaoLi3WUaW2WXr5Wc3qus1MbuwkzUuqfick
 f129Fq9svuaGw6ZZldpU9i5qz7xjPacZg2liAwW36ulq4lkXAYKV7JnhUX7pkxv/Ot
 fiesvhnYQQFlsjR2MIJ50/8pV1O6RtkmRbqMaQPynUZW9O52GxHFHYZv7u+X3G/Cc9
 iiXhAVKk7N7WIVmijOyGGawpOTIxoBKjrj70J8Xk712eYoLUtybYcp+Zfe606hhs5y
 1ptzVVUFG7nFQ==
Message-ID: <sashiko-outbox-193948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/15] drm/panel: add connector luminance forwarding
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-8-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-8-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:34:57 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] drm/panel: invalid container_of cast to panel_bridge in lumina=
nce callbacks
- [High] drm/panel: drm_panel_disable_luminance() and drm_panel_set_luminan=
ce() break PSR and blank state
- [Medium] drm/panel: missing drm_connector_cleanup() on error in panel_bri=
dge_attach()
- [Low] drm/panel: unintended removal of panel bridge stubs from drm_panel.h
--

commit 3eac0878c8a6609d8eb6adf67569604a16f5b3e4
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/panel: add connector luminance forwarding

This commit adds helpers to expose a panel backlight via the DRM connector
luminance property and hooks them into panel bridges that create their own
connector.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index c00529bfb706b..a5706edad9735 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -38,6 +38,19 @@ static LIST_HEAD(panel_list);
>   * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
>   */
> =20
> +struct panel_bridge {
> +	struct drm_bridge bridge;
> +	struct drm_connector connector;
> +	struct drm_panel *panel;
> +	u32 connector_type;
> +};
> +
> +static inline struct panel_bridge *
> +drm_connector_to_panel_bridge(const struct drm_connector *connector)
> +{
> +	return container_of(connector, struct panel_bridge, connector);
> +}
> +
>  static inline struct drm_panel *
>  drm_bridge_to_panel(const struct drm_bridge *bridge)
>  {
> @@ -50,13 +63,6 @@ drm_connector_to_panel(const struct drm_connector *con=
nector)
>  	return container_of(connector, struct drm_panel, connector);
>  }
> =20
> -struct panel_bridge {
> -	struct drm_bridge bridge;
> -	struct drm_connector connector;
> -	struct drm_panel *panel;
> -	u32 connector_type;
> -};
> -
>  static int panel_bridge_connector_get_modes(struct drm_connector *connec=
tor)
>  {
>  	struct drm_panel *panel =3D drm_connector_to_panel(connector);
> @@ -64,9 +70,29 @@ static int panel_bridge_connector_get_modes(struct drm=
_connector *connector)
>  	return drm_panel_get_modes(panel, connector);
>  }
> =20
> +static void
> +panel_bridge_connector_set_luminance(const struct drm_connector_state *c=
onn_state)
> +{
> +	struct panel_bridge *panel_bridge =3D
> +		drm_connector_to_panel_bridge(conn_state->connector);
> +
> +	drm_panel_set_luminance(panel_bridge->panel, conn_state->luminance);
> +}
> +
> +static void
> +panel_bridge_connector_disable_luminance(const struct drm_connector_stat=
e *conn_state)
> +{
> +	struct panel_bridge *panel_bridge =3D
> +		drm_connector_to_panel_bridge(conn_state->connector);
> +
> +	drm_panel_disable_luminance(panel_bridge->panel);
> +}

[Severity: Critical]
Since commit b7797081ccfe ("drm/panel: embed a drm_bridge into every
drm_panel"), the bridge and connector are embedded directly inside struct
drm_panel, and struct panel_bridge is an unused leftover definition that is
never allocated.

In panel_bridge_attach(), the connector initialized with
panel_bridge_connector_helper_funcs is &panel->connector:

	struct drm_panel *panel =3D drm_bridge_to_panel(bridge);
	struct drm_connector *connector =3D &panel->connector;

Calling drm_connector_to_panel_bridge(conn_state->connector) in
panel_bridge_connector_set_luminance() and
panel_bridge_connector_disable_luminance() computes container_of() for stru=
ct
panel_bridge on a struct drm_panel instance, so reading panel_bridge->panel
reads the fields following connector in struct drm_panel (connector_type and
list) as a struct drm_panel pointer.

Won't passing that pointer to drm_panel_set_luminance() or
drm_panel_disable_luminance() dereference an invalid panel->backlight addre=
ss,
and should these callbacks use drm_connector_to_panel(conn_state->connector)
instead?

>  static const struct drm_connector_helper_funcs
>  panel_bridge_connector_helper_funcs =3D {
>  	.get_modes =3D panel_bridge_connector_get_modes,
> +	.set_luminance =3D panel_bridge_connector_set_luminance,
> +	.disable_luminance =3D panel_bridge_connector_disable_luminance,
>  };
> =20
>  static const struct drm_connector_funcs panel_bridge_connector_funcs =3D=
 {
> @@ -101,6 +127,10 @@ static int panel_bridge_attach(struct drm_bridge *br=
idge,
> =20
>  	drm_panel_bridge_set_orientation(connector, bridge);
> =20
> +	ret =3D drm_panel_attach_luminance_property(panel, connector);
> +	if (ret)
> +		return ret;

[Severity: Medium]
In panel_bridge_attach(), drm_connector_init() has already succeeded and
linked &panel->connector into bridge->dev->mode_config.connector_list before
drm_panel_attach_luminance_property() is called.

When bridge->funcs->attach() fails in drm_bridge_attach(), the error path
resets the bridge without calling bridge->funcs->detach().

Should this error path call drm_connector_cleanup(connector) before returni=
ng
ret so that &panel->connector is not left linked on mode_config.connector_l=
ist
if drm_panel_attach_luminance_property() fails?

[ ... ]

> @@ -861,6 +891,61 @@ void drm_panel_disable(struct drm_panel *panel)
>  }
>  EXPORT_SYMBOL(drm_panel_disable);
> =20
> +/**
> + * drm_panel_attach_luminance_property - expose a panel backlight throug=
h DRM
> + * @panel: panel whose backlight is controlled
> + * @connector: connector on which to expose the property
> + *
> + * The backlight class device remains the internal hardware backend. Whe=
n the
> + * luminance UAPI is enabled, userspace controls that backend through th=
e DRM
> + * connector property instead.
> + *
> + * Return: 0 on success or a negative error code
> + */
> +int drm_panel_attach_luminance_property(struct drm_panel *panel,
> +					struct drm_connector *connector)
> +{
> +	struct backlight_device *backlight;
> +
> +	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) || !panel)
> +		return 0;
> +
> +	backlight =3D panel->backlight;
> +	if (!backlight)
> +		return 0;
> +
> +	return drm_connector_attach_luminance_property(connector, 0,
> +					backlight->props.max_brightness,
> +					backlight->props.brightness);
> +}
> +EXPORT_SYMBOL(drm_panel_attach_luminance_property);
> +
> +/**
> + * drm_panel_set_luminance - set a panel backlight's relative luminance
> + * @panel: panel whose backlight is controlled
> + * @luminance: relative luminance level
> + */
> +void drm_panel_set_luminance(struct drm_panel *panel, unsigned int lumin=
ance)
> +{
> +	if (!panel || !panel->backlight)
> +		return;
> +
> +	panel->backlight->props.brightness =3D luminance;
> +	backlight_update_status(panel->backlight);
> +}
> +EXPORT_SYMBOL(drm_panel_set_luminance);
> +
> +/**
> + * drm_panel_disable_luminance - turn off a panel backlight
> + * @panel: panel whose backlight is controlled
> + */
> +void drm_panel_disable_luminance(struct drm_panel *panel)
> +{
> +	if (panel)
> +		backlight_disable(panel->backlight);
> +}
> +EXPORT_SYMBOL(drm_panel_disable_luminance);

[Severity: High]
How do drm_panel_disable_luminance() and drm_panel_set_luminance() interact
with panel self-refresh and the backlight blank state?

In drm_panel_disable_luminance(), backlight_disable() sets:

	bd->props.power =3D BACKLIGHT_POWER_OFF;
	bd->props.state |=3D BL_CORE_FBBLANK;

whereas drm_panel_set_luminance() only updates props.brightness and calls
backlight_update_status() without clearing BL_CORE_FBBLANK or restoring
BACKLIGHT_POWER_ON.

In panel_bridge_atomic_disable() and panel_bridge_atomic_enable(), the brid=
ge
checks self_refresh_active and returns early so that drm_panel_disable() and
drm_panel_enable() are skipped during self-refresh:

	new_crtc_state =3D drm_atomic_get_new_crtc_state(atomic_state, crtc);
	if (new_crtc_state && new_crtc_state->self_refresh_active)
		return;

However, disable_outputs() still runs drm_atomic_helper_commit_luminance_di=
sables()
when entering self-refresh, which calls panel_bridge_connector_disable_lumi=
nance()
and turns the backlight off via backlight_disable(). When exiting
self-refresh, panel_bridge_atomic_enable() skips drm_panel_enable() (so
backlight_enable() is never called), and drm_panel_set_luminance() leaves
BACKLIGHT_POWER_OFF and BL_CORE_FBBLANK set, keeping the backlight blanked.

Also, on a normal modeset disable, drm_atomic_helper_commit_luminance_disab=
les()
runs before drm_atomic_helper_commit_encoder_bridge_disable(), which disabl=
es
the backlight before panel_disabling followers run in drm_panel_disable(), =
and
on modeset enable drm_panel_enable() calls backlight_enable() with the old
props.brightness before drm_panel_set_luminance() updates it.

Could drm_panel_set_luminance() unblank the backlight (or use
backlight_enable()), and should panel luminance disable/enable respect
self-refresh and panel sequencing?

> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 58113ea7d63a0..76d49d4485ff0 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h

[ ... ]

> @@ -418,40 +423,6 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(s=
truct device *dev,
>  struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
>  					 struct drm_panel *panel);
>  struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *brid=
ge);
> -#else
> -static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
> -{
> -	return false;
> -}
> -
> -static inline int drm_panel_bridge_set_orientation(struct drm_connector =
*connector,
> -						   struct drm_bridge *bridge)
> -{
> -	return -EINVAL;
> -}
> -#endif
> -
> -#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
> -struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct dev=
ice_node *node,
> -					  u32 port, u32 endpoint);
> -struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm, struct dev=
ice_node *node,
> -				      u32 port, u32 endpoint);
> -#else
> -static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *d=
ev,
> -							struct device_node *node,
> -							u32 port,
> -							u32 endpoint)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
> -
> -static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *d=
rm,
> -						    struct device_node *node,
> -						    u32 port,
> -						    u32 endpoint)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
>  #endif

[Severity: Low]
Was this removal of the fallback stubs and the devm_drm_of_get_bridge() /
drmm_of_get_bridge() declarations in include/drm/drm_panel.h an unintended
rebase artifact against commit aa8a8c7e4641 ("drm/bridge: panel: move all c=
ode
to drm_panel.c")?

It looks like the preceding patch in the series re-added these blocks to
include/drm/drm_bridge.h, and this hunk removes only the #else half and the
of_get_bridge block from include/drm/drm_panel.h while leaving the #ifdef
CONFIG_DRM_PANEL_BRIDGE declarations duplicated in both headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D8
