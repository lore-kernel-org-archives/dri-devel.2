Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD55CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77DB10E0E7;
	Wed, 24 Jun 2026 17:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iFZNIvLU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277EB10E0E7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:12:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E797402ED;
 Wed, 24 Jun 2026 17:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E5C1F000E9;
 Wed, 24 Jun 2026 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321136;
 bh=zyLYGfweowdXpuEys+3wlr9xWImQR5/1MUMZWHyITpw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iFZNIvLUR3Q0mz4rwholWcIQb2BE6Nm56KJG6U9iAbjCKg/+Ra1uP1sJe409kBYGX
 Qp4CFzSFP1s4w7YEhlYk/ObE0iPMQlsCc4WqA6HUrg2yJmM5R/GYtj/Y+AEMtPDr4F
 sq3euI1I4EgpPO17RgIXyncVcO9IIU6EFrdXQMYadg0OTNxvkS267qRyJV9DJfXcfZ
 toJw8faGOzDkRAE853LUuq5K8sjZPU6207lK2c99IlpTE20RatmQNVS+ID4iwt8PTs
 AgBHH3wAr8afvcwLHkFJPAGeCeYVHjYiTf3d9Jb4tEGfr+VDlh9sa1HUhhhoueqWFR
 XfpoW5KzmeBqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] DRM: Add support for client indicating support
 for luminance
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-5-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:12:16 +0000
Message-Id: <20260624171216.D0E5C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] drm_atomic_connector_set_property() synchronously modifies the phy=
sical hardware backlight, violating the DRM atomic TEST_ONLY contract.
- [High] Concurrent DRM_IOCTL_SET_CLIENT_CAP calls can leak luminance_clien=
ts references, breaking legacy sysfs backlight control.
- [High] Missing dynamic tracking of hotplugged/unplugged connectors causes=
 unbalanced capability inhibit counters, triggering kernel WARN_ON panics.
- [High] drm_atomic_connector_commit_dpms() incorrectly modifies physical b=
acklight state before atomic commit execution, failing to rollback on error=
s.
- [High] drm_backlight_link() calls a sleeping function (kobject_uevent_env=
) while holding a spinlock.
- [High] __drm_backlight_update_prop_range() mutates a device-wide shared p=
roperty object, corrupting bounds for multi-monitor setups.
- [High] __drm_backlight_real_changed() mutates the committed atomic state =
directly, introducing data races and potential Use-After-Free.
- [High] A sleeping function (drm_backlight_set_luminance) is called from a=
tomic encoder enable/disable callbacks.
- [Medium] drm_atomic_helper_commit_encoder_bridge_enable() accesses global=
 connector->state instead of new_conn_state.
--

commit 8af77079789b2e380cebbf99913aa0db9fe6c3ef
Author: Mario Limonciello (AMD) <superm1@kernel.org>
Date:   Wed Jun 24 16:57:44 2026 +0000

    DRM: Add support for client indicating support for luminance

This commit introduces a DRM client capability to indicate support for a
luminance property on connectors. When the capability is enabled, the kernel
inhibits the legacy sysfs backlight control to allow the DRM client to
manage backlight brightness via atomic state.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 51f39edc31edc..17492ff6c5579 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1224,6 +1225,8 @@ drm_atomic_helper_commit_encoder_bridge_disable(str=
uct drm_device *dev,
>  		 * it away), so we won't call disable hooks twice.
>  		 */
>  		bridge =3D drm_bridge_chain_get_first_bridge(encoder);
> +		if (connector->backlight)
> +			drm_backlight_set_luminance(connector->backlight, 0);

[Severity: High]
Does this code call a sleeping function from atomic context?
During a DRM atomic commit, drm_atomic_helper_commit_encoder_bridge_disable=
()
executes in atomic context where sleeping is strictly prohibited. Calling
drm_backlight_set_luminance() from here will acquire a mutex (bd->ops_lock),
which could lead to system instability or lockdep warnings.

>  		drm_atomic_bridge_chain_disable(bridge, state);
>  		drm_bridge_put(bridge);
> =20
> @@ -1738,6 +1741,10 @@ drm_atomic_helper_commit_encoder_bridge_enable(str=
uct drm_device *dev, struct dr
> =20
>  		drm_atomic_bridge_chain_enable(bridge, state);
>  		drm_bridge_put(bridge);
> +
> +		if (connector->backlight && connector->state)
> +			drm_backlight_set_luminance(connector->backlight,
> +						    connector->state->luminance);

[Severity: High]
Can this sleeping function safely be called from the atomic encoder enable
callback? Like the disable hook above, this runs in atomic context, but
drm_backlight_set_luminance() attempts to take a mutex.

[Severity: Medium]
Could accessing the global connector->state instead of new_conn_state cause
a race condition here?
If commit_tail runs asynchronously for non-blocking commits, a subsequent
commit could swap the state pointers, causing the hardware to be programmed
with an invalid or future brightness value.

>  	}
>  }
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 6441b55cc2740..ebf434bbd963b 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -935,6 +937,14 @@ static int drm_atomic_connector_set_property(struct =
drm_connector *connector,
>  		state->privacy_screen_sw_state =3D val;
>  	} else if (property =3D=3D connector->broadcast_rgb_property) {
>  		state->hdmi.broadcast_rgb =3D val;
> +	} else if (property =3D=3D config->luminance_property) {
> +		state->luminance =3D val;
> +		/* Update hardware backlight only when DPMS is ON.
> +		 * Property value is always updated to remember the user's
> +		 * desired brightness.
> +		 */
> +		if (connector->dpms =3D=3D DRM_MODE_DPMS_ON)
> +			drm_backlight_set_luminance(connector->backlight, val);

[Severity: High]
Does this synchronously modify the physical hardware backlight?
Calling drm_backlight_set_luminance() directly in the atomic property
assignment phase appears to break the DRM atomic TEST_ONLY contract, where
TEST_ONLY or failed commits should guarantee no side effects on the hardwar=
e.

>  	} else if (connector->funcs->atomic_set_property) {
>  		return connector->funcs->atomic_set_property(connector,
>  				state, property, val);
> @@ -1126,9 +1163,29 @@ int drm_atomic_connector_commit_dpms(struct drm_at=
omic_commit *state,
>  	if (connector->dpms =3D=3D mode)
>  		goto out;
> =20
> +	crtc =3D connector->state ? connector->state->crtc : NULL;
> +
> +	/* Handle backlight brightness coordination with DPMS state changes */
> +	if (old_mode !=3D DRM_MODE_DPMS_OFF && mode =3D=3D DRM_MODE_DPMS_OFF) {
> +		/* DPMS ON -> OFF: dim all connectors driven by this CRTC. */
> +		if (crtc)
> +			drm_atomic_crtc_set_backlight(crtc, false);
> +		else
> +			drm_atomic_connector_set_backlight(connector, 0);
> +	}

[Severity: High]
Does this modify the physical backlight state before the atomic commit
is executed?
If the subsequent drm_atomic_commit() fails, it looks like the hardware
state won't be rolled back, leaving the physical backlight off but the
software state unchanged.=20

Also, does dimming all connectors driven by this CRTC incorrectly affect
active displays in cloned setups when only one display was targeted by DPMS?

> =20
>  	connector->dpms =3D mode;
> diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backli=
ght.c
> index b1ec470be86ca..2cddf209d5088 100644
> --- a/drivers/gpu/drm/drm_backlight.c
> +++ b/drivers/gpu/drm/drm_backlight.c
> @@ -71,6 +71,7 @@ static bool __drm_backlight_is_registered(struct drm_ba=
cklight *b)
>  /* caller must hold @drm_backlight_lock */
>  static void __drm_backlight_real_changed(struct drm_backlight *b, uint64=
_t v)
>  {
> +	struct drm_connector *connector =3D b->connector;
>  	unsigned int max, set;
> =20
>  	lockdep_assert_held(&drm_backlight_lock);
> @@ -85,6 +86,15 @@ static void __drm_backlight_real_changed(struct drm_ba=
cklight *b, uint64_t v)
>  	set =3D v;
>  	if (set >=3D max)
>  		set =3D max;
> +
> +	/* Update the atomic state directly.
> +	 * For atomic drivers, the luminance value is stored in
> +	 * connector->state->luminance, not in the legacy property array.
> +	 * We update it unconditionally to reflect the hardware state,
> +	 * regardless of DPMS.
> +	 */
> +	if (connector->state)
> +		connector->state->luminance =3D set;

[Severity: High]
Could this directly mutate the committed atomic state, introducing data
races or a Use-After-Free?
A concurrent atomic commit might swap and free connector->state while this
function modifies connector->state->luminance holding only drm_backlight_lo=
ck
instead of the connection_mutex.

>  }
> =20
>  /**
> @@ -100,18 +110,22 @@ static void __drm_backlight_update_prop_range(struc=
t drm_backlight *b)
>  	struct drm_device *dev =3D b->connector->dev;
>  	struct drm_property *prop =3D dev->mode_config.luminance_property;
>  	unsigned int max =3D 0;
> +	bool can_disable =3D false;
> =20
>  	lockdep_assert_held(&drm_backlight_lock);
> =20
> -	if (b->link && b->link->props.max_brightness > 0)
> +	if (b->link && b->link->props.max_brightness > 0) {
>  		max =3D b->link->props.max_brightness;
> +		can_disable =3D b->link->props.can_disable;
> +	}
> =20
>  	/* Update property range to match hardware capabilities.
>  	 * Range of 0-0 indicates no backing device.
> -	 * Range of 1-max for normal operation (0 reserved for display off).
> +	 * Range of 1-max for normal operation.
> +	 * Range of 0-max means that the display would turn off at 0
>  	 */
>  	if (prop->values[1] !=3D max) {
> -		prop->values[0] =3D max ? 1 : 0;
> +		prop->values[0] =3D max ? (can_disable ? 0 : 1) : 0;
>  		prop->values[1] =3D max;
>  	}

[Severity: High]
Does this mutate a globally shared device-wide property based on a single
connector's backlight bounds?
Modifying dev->mode_config.luminance_property values directly could corrupt
the acceptable bounds for other displays in a multi-monitor setup where each
display has different max_brightness limits.

>  }
> @@ -228,11 +253,18 @@ EXPORT_SYMBOL(drm_backlight_unregister);
>   */
>  void drm_backlight_link(struct drm_backlight *b, struct backlight_device=
 *bd)
>  {
> +	static const char * const ep[] =3D { "BACKLIGHT=3D1", NULL };
> +	bool send_uevent =3D false;
> +
>  	if (!b)
>  		return;
> =20
>  	guard(spinlock)(&drm_backlight_lock);
> -	__drm_backlight_link(b, bd);
> +	send_uevent =3D __drm_backlight_link(b, bd);
> +
> +	if (send_uevent)
> +		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE,
> +				   (char **)ep);

[Severity: High]
Can kobject_uevent_env() sleep while the drm_backlight_lock spinlock is hel=
d?
The guard(spinlock) macro holds the lock for the entire scope, and
kobject_uevent_env() dynamically allocates memory with GFP_KERNEL and may c=
all
user-mode helpers, potentially causing a scheduling while atomic panic.

>  }
>  EXPORT_SYMBOL(drm_backlight_link);
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ec820686b3021..4d2520de7614c 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -252,6 +253,10 @@ void drm_file_free(struct drm_file *file)
>  	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
>  		drm_fb_release(file);
>  		drm_property_destroy_user_blobs(dev, file);
> +		if (file->supports_luminance_control) {
> +			drm_backlight_uninhibit_legacy_all(dev);
> +			file->supports_luminance_control =3D false;
> +		}
>  	}

[Severity: High]
Could a lack of dynamic tracking for hotplugged or unplugged connectors
cause unbalanced inhibit counters?
If a display connector is hotplugged or unplugged after a DRM client sets
DRM_CLIENT_CAP_LUMINANCE, iterating over the current connector list on file
close will apply unmatched decrements or leak references, eventually trigge=
ring
the WARN_ON panic in drm_backlight_uninhibit_legacy().

> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ff193155129e7..fdae36b13300a 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -380,6 +382,19 @@ drm_setclientcap(struct drm_device *dev, void *data,=
 struct drm_file *file_priv)
>  			return -EINVAL;
>  		file_priv->plane_color_pipeline =3D req->value;
>  		break;
> +	case DRM_CLIENT_CAP_LUMINANCE:
> +		if (!file_priv->atomic)
> +			return -EINVAL;
> +		if (req->value > 1)
> +			return -EINVAL;
> +		if (req->value =3D=3D file_priv->supports_luminance_control)
> +			break;
> +		if (req->value)
> +			drm_backlight_inhibit_legacy_all(dev);
> +		else
> +			drm_backlight_uninhibit_legacy_all(dev);
> +		file_priv->supports_luminance_control =3D req->value;
> +		break;

[Severity: High]
Does this check-and-set logic lack locking?
Concurrent threads invoking DRM_IOCTL_SET_CLIENT_CAP with
DRM_CLIENT_CAP_LUMINANCE on the same file descriptor could bypass the check
and unbalancedly increment the inhibit counter, leaking references and
breaking legacy sysfs backlight control.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D4
