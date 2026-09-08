Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB28C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0DD10EA08;
	Tue,  8 Sep 2026 04:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NsGkgKzj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A814A10EA06;
 Tue,  8 Sep 2026 04:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F93840B3C;
 Tue,  8 Sep 2026 04:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C27E1F00A3A;
 Tue,  8 Sep 2026 04:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843279;
 bh=nTFRMthvxpUktdyJLzXkqEIv9kj2vXpAA8inm3e5ZSs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NsGkgKzjJUUZoig/GTcSs2pw07QA3BH63imV+8V2L22j942U3soShz7o3cguzktYE
 Tv/Maf/5OXS17g7jHF6jPuJudOMyv7kISMmD73UHZ9EVpVLkaPjn5TU4L2sHlGqCXx
 FhhAc7Ti4X2I8KqtF6ONSVKrX3SB+YFdBPv7HQa6Vxpj2bggZbdff5h5vvXca3augI
 F2QEhpxEaB0yJQV5MacZoX3jngDIOxabwl3z0lONSF6Tw9cYYV4+Ka9QVSwvrC5ftj
 6LhRPjgOOVZXTPxFH8SB7lEwFjKDDbeHLfeLyf6I0etV8LoPYWXJmYlzPlrtMRHsDD
 DjIPWADbHJZqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/14] drm: add connector backlight (LUMINANCE)
 infrastructure
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-5-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:54:38 +0000
Message-Id: <20260908045439.3C27E1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [Critical] Concurrent backlight unlinking and connector teardown causes a=
 Use-After-Free due to missing references and early return bypassing `cance=
l_work_sync`.
- [High] Turning off the backlight asynchronously during pipeline disable b=
reaks hardware shutdown sequencing, risking screen corruption.
- [High] Backlight hardware state is mutated asynchronously before atomic c=
ommit validation, failing to roll back on commit failure.
- [High] Lockless, in-place modification of `connector->state->luminance` f=
rom asynchronous notifier context causes Write-After-Free.
- [High] Lockless read of `crtc->state` in `drm_atomic_helper_connector_app=
ly_luminance` causes a Use-After-Free.
- [High] Lockless read of `connector->state` of unrelated connectors in `dr=
m_atomic_crtc_set_backlight` causes a Use-After-Free.
- [Medium] Concurrency between `drm_backlight_inhibit_legacy_all` and `drm_=
backlight_link` leads to double-counted or overwritten `luminance_clients`.
- [Medium] Triggering a `WARN_ON` for routine hardware communication failur=
es allows trivial kernel log spam and potential system panics.
- [Medium] Legacy DPMS changes incorrectly dim all connectors on shared CRT=
Cs, and conflict with the atomic commit tail logic.
- [Medium] Backlight is enabled on disconnected/un-driven panels during DPM=
S ON.
- [Low] The fallback brightness assignment in `drm_backlight_bd_set_luminan=
ce` is mathematically guaranteed to fail due to a hardcoded `U16_MAX`.
- [Low] Property bounds are not updated when dynamically linking a backend =
with a different brightness range.
- [Low] Broken teardown symmetry leaves the backlight sysfs symlink unremov=
ed, resulting in dead code.
--

commit 4014f9d380d34194182229a03855db38075d5806
Author: Mario Limonciello <mario.limonciello@amd.com>
Subject: drm: add connector backlight (LUMINANCE) infrastructure

This commit introduces a per-connector LUMINANCE range property to control
backlight brightness through the DRM atomic modeset path. It embeds a
backlight state in each connector and synchronizes brightness changes
asynchronously via a workqueue.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 285aac3554dfd..110cd81e5d6db 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
[ ... ]
> @@ -1230,6 +1231,10 @@ drm_atomic_helper_commit_encoder_bridge_disable(st=
ruct drm_device *dev,
>  		 * it away), so we won't call disable hooks twice.
>  		 */
>  		bridge =3D drm_bridge_chain_get_first_bridge(encoder);
> +
> +		/* Turn the backlight off before disabling the pipeline. */
> +		drm_backlight_set_luminance(connector, 0);
> +
>  		drm_atomic_bridge_chain_disable(bridge, state);
>  		drm_bridge_put(bridge);

[Severity: High]
Does this sequence break the display hardware shutdown requirements?

By queuing the backlight off operation asynchronously via
drm_backlight_set_luminance() and immediately disabling the bridge chain,
the pipeline might be shut down before the backlight actually turns off.
Could this lead to screen corruption or panel damage?

[ ... ]
> @@ -1775,6 +1780,24 @@ void drm_atomic_helper_commit_modeset_enables(stru=
ct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
> =20
> +/**
> + * drm_atomic_helper_connector_apply_luminance - apply connector luminan=
ce from atomic state
> + * @conn_state: atomic connector state to apply luminance for
> + *
> + * Updates the backlight luminance from the atomic connector state. If t=
he
> + * connector has a linked backlight and is associated with an active CRT=
C,
> + * push the luminance value to hardware.
> + */
> +void drm_atomic_helper_connector_apply_luminance(const struct drm_connec=
tor_state *conn_state)
> +{
> +	struct drm_connector *connector =3D conn_state->connector;
> +
> +	if (conn_state->crtc && conn_state->crtc->state &&
> +	    conn_state->crtc->state->active)

[Severity: High]
Can a concurrent CRTC modeset free the CRTC state while it is being accessed
here?

Since the CRTC lock might not be held during pure connector property
commits, reading conn_state->crtc->state->active could result in a
use-after-free if the CRTC state is swapped and freed simultaneously.

> +		drm_backlight_set_luminance(connector, conn_state->luminance);
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_connector_apply_luminance);
> +
[ ... ]
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 5ea593b3a98ec..07d4bcb16cd23 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
[ ... ]
> @@ -1133,6 +1144,22 @@ static struct drm_pending_vblank_event *create_vbl=
ank_event(
>  	return e;
>  }
> =20
> +static void drm_atomic_crtc_set_backlight(struct drm_crtc *crtc, bool ac=
tive)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +
> +	drm_connector_list_iter_begin(crtc->dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (!connector->state || connector->state->crtc !=3D crtc)
> +			continue;

[Severity: High]
Could this lockless read of connector->state trigger a use-after-free?

This function iterates all connectors and reads their states while holding
only the connection_mutex. If another connector receives a concurrent
property update, its state could be swapped and freed while being read here.

> +
> +		drm_backlight_set_luminance(connector,
> +					    active ? connector->state->luminance : 0);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +}
> +
>  int drm_atomic_connector_commit_dpms(struct drm_atomic_commit *state,
>  				     struct drm_connector *connector,
>  				     int mode)
> @@ -1155,9 +1182,29 @@ int drm_atomic_connector_commit_dpms(struct drm_at=
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

[Severity: Medium]
Will this cause unintended dimming or flickering on cloned displays?

When one connector on a shared CRTC transitions to DPMS OFF, calling
drm_atomic_crtc_set_backlight() queues an OFF request for all connectors
driven by that CRTC, even if the other connectors are still supposed to
remain active.

> +		else
> +			drm_backlight_set_luminance(connector, 0);
> +	}
> +
>  	connector->dpms =3D mode;
> =20
> -	crtc =3D connector->state->crtc;
> +	/* DPMS OFF -> ON: restore brightness to property value */
> +	if (old_mode =3D=3D DRM_MODE_DPMS_OFF && mode =3D=3D DRM_MODE_DPMS_ON &&
> +	    connector->state) {
> +		if (crtc)
> +			drm_atomic_crtc_set_backlight(crtc, true);
> +		else
> +			drm_backlight_set_luminance(connector,
> +						    connector->state->luminance);

[Severity: Medium]
Is it safe to turn on the backlight for a disconnected panel?

If a connector is turned on (DPMS ON) but has no active CRTC (crtc is NULL),
this branch restores the committed luminance. Illuminating a panel that isn=
't
receiving a video signal could violate hardware sequencing constraints and
stress the panel.

[Severity: High]
Does this rollback path properly revert the physical backlight changes?

The physical backlight state is mutated asynchronously before calling
drm_atomic_commit(state). If the commit fails (for example, due to=20
validation failure), the software DPMS state is rolled back at the out
label:

out:
	if (ret !=3D 0)
		connector->dpms =3D old_mode;

However, the physical backlight might remain turned off since the
asynchronous work was already dispatched and cannot be rolled back here.

> +	}
> +
>  	if (!crtc)
>  		goto out;
>  	ret =3D drm_atomic_add_affected_connectors(state, crtc);
[ ... ]
> diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backli=
ght.c
> new file mode 100644
> index 0000000000000..dd02d1878727e
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_backlight.c
[ ... ]
> +static void __drm_backlight_worker(struct work_struct *w)
> +{
> +	struct drm_backlight *b =3D container_of(w, struct drm_backlight, work);
[ ... ]
> +	/*
> +	 * The backend stays valid here: drm_backlight_do_unlink() clears
> +	 * @backend and drops its reference only after cancel_work_sync(), so an
> +	 * in-flight worker always sees a live backend.
> +	 */
> +	if (funcs && funcs->set_luminance)
> +		WARN_ON(funcs->set_luminance(b, v));

[Severity: Medium]
Could this WARN_ON() be triggered by routine hardware communication failure=
s?

If the backend communicates over I2C or similar buses, transient timeouts=20
or disconnections might routinely return error codes. Using WARN_ON() could=
=20
allow local userspace to spam the kernel log or cause a system panic if=20
panic_on_warn is enabled.

[ ... ]
> +/* caller must hold @drm_backlight_lock */
> +static void __drm_backlight_readback(struct drm_backlight *b, unsigned i=
nt v)
> +{
[ ... ]
> +	/*
> +	 * Reflect a hardware-side brightness change (firmware hotkeys, or a
> +	 * legacy sysfs write while not inhibited) back into the connector's
> +	 * committed luminance so a read-back returns the real value.
> +	 */
> +	if (connector->state)
> +		connector->state->luminance =3D min(v, max);

[Severity: High]
Can this in-place modification of connector->state cause a write-after-free?

Since this function is called asynchronously from a sysfs handler holding=20
only drm_backlight_lock, a concurrent atomic commit could duplicate, commit=
,=20
and free the connector->state object, causing this write to corrupt memory.

> +}
[ ... ]
> +static void drm_backlight_do_unlink(struct drm_backlight *b)
> +{
> +	struct backlight_device *bd;
> +	unsigned int clients;
> +
> +	/*
> +	 * Stop new work first, but leave @backend in place so an in-flight
> +	 * worker keeps a valid backend to operate on. Capture the linked
> +	 * backlight_device (if any) while @funcs is still set.
> +	 */
> +	scoped_guard(spinlock, &drm_backlight_lock) {
> +		if (!b->funcs)
> +			return;

[Severity: Critical]
Does this early return leak a pending or running worker?

If b->funcs is NULL, the function returns immediately without calling
cancel_work_sync(&b->work). This could leave the worker operating on
memory that might be subsequently freed.

> +		bd =3D drm_backlight_bd(b);
> +		clients =3D b->luminance_clients;
> +		b->funcs =3D NULL;
> +		list_del_init(&b->list);
> +	}
[ ... ]
> +int drm_backlight_link(struct drm_connector *connector,
> +		       struct backlight_device *bd)
> +{
[ ... ]
> +	max =3D bd->props.max_brightness;
> +	if (max && !connector->luminance_property) {
> +		ret =3D drm_backlight_create_property(connector, max, false);

[Severity: Low]
Will the LUMINANCE property bounds remain stale if a new backend is linked?

If a backend is unlinked and a new one is linked with a different=20
max_brightness range, the property is not recreated because=20
connector->luminance_property already exists. This might artificially=20
clamp the new backend to the old backend's maximum brightness.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	scoped_guard(spinlock, &drm_backlight_lock) {
> +		b->funcs =3D &drm_backlight_bd_funcs;
> +		b->backend =3D bd;
> +		backlight_device_ref(bd);
> +		list_add(&b->list, &drm_backlight_list);
> +		/*
> +		 * Inherit the device-wide inhibit level so a connector linked
> +		 * (or hotplugged) while luminance-aware clients are active also
> +		 * has its legacy sysfs control inhibited.
> +		 */
> +		b->luminance_clients =3D connector->dev->mode_config.luminance_clients;

[Severity: Medium]
Is there a race condition here that could double-count luminance_clients?

If a new connector is linked concurrently with drm_backlight_inhibit_legacy=
_all(),
it might inherit the already-incremented global dev->mode_config.luminance_=
clients
count here.

> +		if (b->luminance_clients)
> +			atomic_add(b->luminance_clients, &bd->drm_takeover);
[ ... ]
> +void drm_backlight_inhibit_legacy_all(struct drm_device *dev)
> +{
> +	struct drm_connector_list_iter iter;
> +	struct drm_connector *connector;
> +
> +	scoped_guard(spinlock, &drm_backlight_lock)
> +		dev->mode_config.luminance_clients++;
> +
> +	drm_connector_list_iter_begin(dev, &iter);
> +	drm_for_each_connector_iter(connector, &iter)
> +		drm_backlight_inhibit_legacy(connector);

[Severity: Medium]
Since the lock is dropped between incrementing the global luminance_clients
count and iterating the connectors, the iterator could hit the newly linked
connector and increment its count a second time. This double-count would
prevent the legacy sysfs interface from ever being uninhibited.

> +	drm_connector_list_iter_end(&iter);
> +}
[ ... ]
> +static int drm_backlight_bd_set_luminance(struct drm_backlight *b,
> +					  unsigned int value)
> +{
> +	struct backlight_device *bd =3D b->backend;
> +	int rc;
> +
> +	rc =3D backlight_set_brightness(bd, value, BACKLIGHT_UPDATE_DRM);
> +	if (rc)
> +		backlight_set_brightness(bd, U16_MAX, BACKLIGHT_UPDATE_DRM);

[Severity: Low]
Is this fallback brightness assignment guaranteed to fail?

Because backlight_set_brightness() strictly bounds-checks the requested
value against bd->props.max_brightness (which is typically around 255),
passing U16_MAX (65535) will mathematically guarantee an -EINVAL failure,
making this error recovery path ineffective.

> +
> +	return rc;
> +}
[ ... ]
> +static int drm_backlight_notify(struct notifier_block *self,
> +				unsigned long event, void *data)
> +{
[ ... ]
> +		for (;;) {
> +			struct drm_backlight *found =3D NULL;
> +
> +			scoped_guard(spinlock, &drm_backlight_lock) {
> +				list_for_each_entry(b, &drm_backlight_list, list) {
> +					if (drm_backlight_bd(b) =3D=3D bd) {
> +						found =3D b;
> +						break;
> +					}
> +				}
> +			}
> +			if (!found)
> +				break;
> +			drm_backlight_do_unlink(found);

[Severity: Critical]
Is there a risk of the connector being freed concurrently here?

The notifier iterates the list under the lock, finds a match, drops the=20
lock, and then calls drm_backlight_do_unlink(found). Without holding a=20
reference to the connector, a concurrent teardown (like a hardware hotplug)
could free the connector memory, resulting in a use-after-free when=20
drm_backlight_do_unlink accesses found->funcs.

> +		}
> +		break;
[ ... ]
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 8b4baed060f3a..92ed0c1879d53 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -944,6 +948,8 @@ EXPORT_SYMBOL(drm_connector_dynamic_register);
>  void drm_connector_unregister(struct drm_connector *connector)
>  {
>  	mutex_lock(&connector->mutex);
> +	drm_backlight_unregister(connector);
> +
>  	if (connector->registration_state !=3D DRM_CONNECTOR_REGISTERED) {

[Severity: Low]
Does unregistering the backlight here break the sysfs teardown symmetry?

Because this clears the backend link before drm_sysfs_connector_remove_earl=
y()
is called, the latter will fail to fetch the backlight device and miss
calling sysfs_remove_link(&connector->kdev->kobj, "backlight").

[ ... ]
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index ef4e923a87284..2f4ce7d040f9d 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
[ ... ]
>  void drm_sysfs_connector_remove_early(struct drm_connector *connector)
>  {
> +	struct backlight_device *bd =3D drm_backlight_get_device(connector);
> +
> +	if (bd) {
> +		sysfs_remove_link(&connector->kdev->kobj, "backlight");

[Severity: Low]
Because drm_backlight_unregister() has already been called in=20
drm_connector_unregister(), drm_backlight_get_device() will return NULL,=20
leaving this cleanup path unreachable.

> +		backlight_device_unref(bd);
> +	}
> +
>  	if (connector->ddc)
>  		sysfs_remove_link(&connector->kdev->kobj, "ddc");
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D4
