Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012E606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmZttzRc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372CC10F18D;
	Mon,  2 Nov 2026 19:02:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DDF10F17F;
 Mon,  2 Nov 2026 19:02:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A76C440483;
 Mon,  2 Nov 2026 19:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591761F00A1B;
 Mon,  2 Nov 2026 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793646147;
 bh=Npr8mo0kpFcFHzFdvS8bnH5roxx1REoEZUHU2KKWOvU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DmZttzRc6musLLlTnY4Y++ketEgb91wMNlN+BYtmpitB+vJAOkDuz2BZFl757+Ecj
 clsBWCp/+6FjV71SYZwglAo4RG0IOE0h/whjcNFCQnrB7OEwXMu+bKUsCujZDlazqi
 6ch7MXUAefsdQfd6ZgRdjhIAiT3jM/zrDvaaBXqssuhTgmPIjzNiHKLJq4DABiTYiN
 NCltJN/Erdc087H/cfANv+qPoGBRQPi2PtHww4nnO9PP/H9vI8TL/Qvg/TDWQ4NwtI
 YUdWZ4dKmPM/vGoQDsuwWfjmxsreaX3L24MyyFhVSkslv/eNN6UT8q8bYse+sDAsuj
 Tl6ZNUzHa5xWw==
Message-ID: <sashiko-outbox-193969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/15] drm/gud: add connector luminance support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-11-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-11-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:02:26 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] drm/gud: use-after-free on disconnect via gud_connector_disabl=
e_luminance()
- [High] drm/gud: infinite commit loop in gud_connector_set_luminance()
- [High] drm/gud: brightness clobbered to 0 in gud_connector_disable_lumina=
nce()
- [Medium] drm/gud: late property creation in gud_connector_backlight_regis=
ter()
- [Low] drm/gud: undefined reference to backlight_device_unregister()
--

commit 58c61672659ddff3d1dca17855a27dcf7212a5b6
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/gud: add connector luminance support

This commit exposes GUD display brightness through the connector LUMINANCE
property when CONFIG_DRM_LUMINANCE is enabled, storing brightness state on
struct gud_connector and reusing the asynchronous backlight workqueue path.

> diff --git a/drivers/gpu/drm/gud/Kconfig b/drivers/gpu/drm/gud/Kconfig
> index b4d2136942f0e..6c250d3d5e203 100644
> --- a/drivers/gpu/drm/gud/Kconfig
> +++ b/drivers/gpu/drm/gud/Kconfig
> @@ -7,7 +7,7 @@ config DRM_GUD
>  	select DRM_CLIENT_SELECTION
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_SHMEM_HELPER
> -	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
>  	help
>  	  This is a DRM display driver for GUD USB Displays or display
>  	  adapters.
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index 8141c3a1e30ad..bd7688676e9e1 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c

[ ... ]

> @@ -84,7 +86,7 @@ static void gud_connector_backlight_update_status_work(=
struct work_struct *work)
>  	}
> =20
>  	/* Reuse tv.brightness to avoid having to subclass */
> -	connector_state->tv.brightness =3D gconn->backlight->props.brightness;
> +	connector_state->tv.brightness =3D READ_ONCE(gconn->brightness);
> =20
>  	ret =3D drm_atomic_commit(state);
>  out:

[ ... ]

> @@ -132,6 +136,19 @@ static int gud_connector_backlight_register(struct g=
ud_connector *gconn)
>  		.brightness =3D gconn->initial_brightness,
>  	};
> =20
> +	gconn->brightness =3D props.brightness;
> +
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		int ret;
> +
> +		ret =3D drm_connector_attach_luminance_property(connector, 0, props.ma=
x_brightness,
> +							      props.brightness);
> +		if (ret)
> +			return ret;
> +
> +		return 0;
> +	}

[Severity: Medium]
Won't attaching the LUMINANCE property in gud_connector_backlight_register()
trigger a WARN_ON in __drm_mode_object_add() on every probe when
CONFIG_DRM_LUMINANCE is enabled?

During gud_probe(), drm_dev_register() registers the DRM minor nodes and se=
ts
dev->registered =3D true before calling:

  drm_modeset_register_all()
    -> drm_connector_register_all()
      -> drm_connector_register()
        -> gud_connector_late_register()
          -> gud_connector_backlight_register()
            -> drm_connector_attach_luminance_property()
              -> drm_property_create_range()
                -> drm_property_create()
                  -> drm_mode_object_add()
                    -> __drm_mode_object_add()

In drivers/gpu/drm/drm_mode_object.c:__drm_mode_object_add():

	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);

Because gud_drm_driver.load is NULL, dev->registered is already true, and
obj_free_cb is NULL for DRM properties, this warning fires unconditionally =
and
mutates dev->mode_config.property_list, connector->base.properties, and
connector->state->luminance after userspace already has access to the DRM
device. Should drm_connector_attach_luminance_property() be called during
connector initialization in gud_connector_add_properties() before
drm_mode_config_reset() and drm_dev_register() instead?

> +
>  	name =3D kasprintf(GFP_KERNEL, "card%d-%s-backlight",
>  			 connector->dev->primary->index, connector->name);
>  	if (!name)
> @@ -314,12 +331,37 @@ static int gud_connector_atomic_check(struct drm_co=
nnector *connector,
>  	return 0;
>  }
> =20
> +static void gud_connector_set_luminance(const struct drm_connector_state=
 *conn_state);
> +static void gud_connector_disable_luminance(const struct drm_connector_s=
tate *conn_state);
> +
>  static const struct drm_connector_helper_funcs gud_connector_helper_func=
s =3D {
>  	.detect_ctx =3D gud_connector_detect,
>  	.get_modes =3D gud_connector_get_modes,
>  	.atomic_check =3D gud_connector_atomic_check,
> +	.set_luminance =3D gud_connector_set_luminance,
> +	.disable_luminance =3D gud_connector_disable_luminance,
>  };
> =20
> +static void gud_connector_set_luminance(const struct drm_connector_state=
 *conn_state)
> +{
> +	struct drm_connector *connector =3D conn_state->connector;
> +	struct gud_connector *gconn =3D to_gud_connector(connector);
> +	unsigned int luminance =3D conn_state->luminance;
> +
> +	WRITE_ONCE(gconn->brightness, luminance);
> +
> +	/* The workqueue will apply it to the hardware */
> +	queue_work(system_long_wq, &gconn->backlight_work);
> +}

[Severity: High]
Does queueing gconn->backlight_work from gud_connector_set_luminance() cause
an infinite loop of atomic commits on system_long_wq whenever the connector=
 is
active on a CRTC?

When gconn->backlight_work runs gud_connector_backlight_update_status_work(=
),
the workqueue core clears WORK_STRUCT_PENDING_BIT before invoking the work
callback. gud_connector_backlight_update_status_work() then adds the connec=
tor
to a new commit state via drm_atomic_get_connector_state(state, connector) =
and
calls drm_atomic_commit(state) synchronously:

  gud_connector_backlight_update_status_work()
    -> drm_atomic_commit()
      -> drm_atomic_helper_commit_tail_rpm()
        -> drm_atomic_helper_commit_modeset_enables()
          -> drm_atomic_helper_commit_luminance_enables()
            -> gud_connector_set_luminance()

In drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_commit_luminance_e=
nables():

	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
		const struct drm_connector_helper_funcs *funcs;

		if (!connector->luminance_property || !new_conn_state->crtc ||
		    !new_conn_state->crtc->state->active)
			continue;

		funcs =3D connector->helper_private;
		if (funcs && funcs->set_luminance)
			funcs->set_luminance(new_conn_state);
	}

Because the connector is in the commit state, connector->luminance_property=
 is
non-NULL, and new_conn_state->crtc->state->active is true,
drm_atomic_helper_commit_luminance_enables() unconditionally invokes
gud_connector_set_luminance() again during the work item's own
drm_atomic_commit() call. That re-queues gconn->backlight_work while the wo=
rk
function is still executing, so system_long_wq immediately runs
gud_connector_backlight_update_status_work() again in an unbounded loop.

In addition, when old_state->tv.brightness !=3D new_state->tv.brightness,
gud_connector_atomic_check() sets new_crtc_state->connectors_changed =3D tr=
ue,
causing drm_atomic_helper_commit_modeset_disables() to also call
drm_atomic_helper_commit_luminance_disables() ->
gud_connector_disable_luminance() before
drm_atomic_helper_commit_luminance_enables() runs.

> +
> +static void gud_connector_disable_luminance(const struct drm_connector_s=
tate *conn_state)
> +{
> +	struct gud_connector *gconn =3D to_gud_connector(conn_state->connector);
> +
> +	WRITE_ONCE(gconn->brightness, 0);
> +	queue_work(system_long_wq, &gconn->backlight_work);
> +}

[Severity: Critical]
Can gud_connector_disable_luminance() re-queue gconn->backlight_work after
gud_connector_early_unregister() has already canceled it, leading to a
use-after-free of struct gud_connector on USB disconnect?

In drivers/gpu/drm/gud/gud_drv.c:gud_disconnect():

	drm_kms_helper_poll_fini(drm);
	drm_dev_unplug(drm);
	drm_atomic_helper_shutdown(drm);

First, drm_dev_unplug() runs:

  drm_dev_unplug()
    -> drm_dev_unregister()
      -> drm_modeset_unregister_all()
        -> drm_connector_unregister()
          -> gud_connector_early_unregister()
            -> cancel_work_sync(&gconn->backlight_work)

Next, drm_atomic_helper_shutdown() disables all active outputs:

  drm_atomic_helper_shutdown()
    -> drm_atomic_helper_disable_all()
      -> drm_atomic_commit()
        -> drm_atomic_helper_commit_modeset_disables()
          -> disable_outputs()
            -> drm_atomic_helper_commit_luminance_disables()
              -> gud_connector_disable_luminance()
                -> queue_work(system_long_wq, &gconn->backlight_work)

When gud_disconnect() finishes and devres releases the drm_device,
drm_mode_config_cleanup() calls gud_connector_destroy(), which cleans up the
connector (zeroing connector->dev) and calls kfree(gconn) without canceling
gconn->backlight_work. If gud_connector_backlight_update_status_work() is
still queued or running on system_long_wq, won't it access freed gconn memo=
ry
and dereference a NULL or freed connector->dev in drm_dev_enter()?

[Severity: High]
Also in gud_connector_disable_luminance(), doesn't setting gconn->brightness
to 0 and queueing gconn->backlight_work clobber connector_state->tv.brightn=
ess
and send an unpaired GUD_REQ_SET_STATE_CHECK over USB when a CRTC enters DP=
MS
off?

When a CRTC is set to DPMS off (new_crtc_state->enable =3D=3D true,
new_crtc_state->active =3D=3D false), drm_atomic_helper_commit_luminance_di=
sables()
calls gud_connector_disable_luminance(), whereas
drm_atomic_helper_commit_luminance_enables() does not run because
new_crtc_state->active is false.

When gud_connector_backlight_update_status_work() subsequently runs on
system_long_wq, it sets connector_state->tv.brightness =3D 0 and commits:

1. gud_connector_atomic_check() sees old_state->tv.brightness !=3D
   new_state->tv.brightness and sets new_crtc_state->connectors_changed =3D=
 true.
2. Because crtc_state->enable is still true, gud_plane_atomic_check()
   serializes connector_state->tv.brightness =3D 0 into GUD_REQ_SET_STATE_C=
HECK
   and sends it to the USB device.
3. Because new_crtc_state->active is false,
   drm_atomic_helper_commit_crtc_enable() skips gud_crtc_atomic_enable(),
   leaving GUD_REQ_SET_STATE_CHECK unpaired with GUD_REQ_SET_STATE_COMMIT.
4. When a later commit re-enables the CRTC (active =3D true),
   gud_plane_atomic_check() and gud_crtc_atomic_enable() run before
   drm_atomic_helper_commit_luminance_enables(), so the display is first
   enabled with tv.brightness =3D=3D 0 before gud_connector_set_luminance()=
 queues
   a second full modeset commit to restore conn_state->luminance.

> +
>  static int gud_connector_late_register(struct drm_connector *connector)
>  {
>  	struct gud_connector *gconn =3D to_gud_connector(connector);
> @@ -334,7 +376,9 @@ static void gud_connector_early_unregister(struct drm=
_connector *connector)
>  {
>  	struct gud_connector *gconn =3D to_gud_connector(connector);
> =20
> -	backlight_device_unregister(gconn->backlight);
> +	if (gconn->backlight)
> +		backlight_device_unregister(gconn->backlight);
> +
>  	cancel_work_sync(&gconn->backlight_work);
>  }

[Severity: Low]
Will gud_connector_early_unregister() fail to link when CONFIG_DRM_LUMINANC=
E=3Dy
and CONFIG_BACKLIGHT_CLASS_DEVICE is disabled (or when CONFIG_DRM_GUD=3Dy a=
nd
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm)?

The Kconfig change updates DRM_GUD to:

	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE

However, include/linux/backlight.h declares backlight_device_unregister() as
an external function without an inline stub when CONFIG_BACKLIGHT_CLASS_DEV=
ICE
is not enabled. Because if (gconn->backlight) is a runtime check on a struct
member rather than !IS_ENABLED(CONFIG_DRM_LUMINANCE), the compiler cannot
eliminate the call to backlight_device_unregister() at compile time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D11
