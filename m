Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11F606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1yjPZmD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A969110EB2E;
	Mon, 19 Oct 2026 21:58:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE54F10EB2E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:58:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70D1340684;
 Mon, 19 Oct 2026 21:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073321F000C4;
 Mon, 19 Oct 2026 21:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792447102;
 bh=sCOLSmoF9IiqP1nhjFnR3WssN+jGrWQW2hDjEU5Svis=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T1yjPZmDH87xmthg2X4GlZHaGwAAuwJIDS5LqHW+cnLiZub4NELn4SxeQ3NZtXM/5
 lFagMgfIttFmBHC/GUhD9FCcvOcd4vV9oP02RvNxwML/rE/OgJ/CGmz0hrsYCBHJRu
 Eiu1p3XBt0Ig29oohNQujTJVmSQ1dRyHeZIUFEUkVXCcfwsYbQlBbq3hmcLz5AyKyn
 RWE6Wh5oTzwZznI2so835eMqr+MgU7EAOosEKVvLUrPbRqSFxtKL11Ww3cnjg8f9QD
 jq3LmEG1CWYD53jlz22RXeFJ5s83KlS2GL5Kl5RRxoxMQCWrvoBtsMHdRhzEIgpgvZ
 ycwzVkFi56KQA==
Message-ID: <sashiko-outbox-178284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/14] drm/solomon: ssd16xx: Expose session
 management as plane properties
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019213726.4145532-11-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-11-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:58:21 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/solomon: ssd16xx: lock inversion between device->lock and drm_=
dev_enter()
- [Medium] drm/solomon: ssd16xx: session properties not synced on disable o=
r idle commits
- [Medium] drm/solomon: ssd16xx: disabling refresh_mode_init sets refresh_m=
ode to -1
- [Medium] drm/solomon: ssd16xx: fast LUT preload missed or clobbered by se=
ssion modes
- [Medium] drm/solomon: ssd16xx: runtime PM calls outside device->lock race=
 with master_drop()
--

commit 96a2ccec634e73c5b82d2f3b3b5d2292c57d3429
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Expose session management as plane properties

This commit exposes the clear_on_init, clear_on_close, clear_on_disable, and
refresh_mode_init session management settings as DRM plane enum properties.=
 It
also introduces a device mutex to serialize session state and panel access
between atomic commits and DRM master callbacks.

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> index 6037717635a48..13bd825bf3f17 100644
> --- a/drivers/gpu/drm/solomon/ssd16xx.c
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c

[ ... ]

> @@ -1576,6 +1664,24 @@ static int ssd16xx_plane_atomic_check(struct drm_p=
lane *plane,
>  						   false, false);
>  }
> =20
> +/*
> + * Copy the session properties of a plane state into the device.  Called=
 from
> + * both crtc_atomic_enable() and plane_atomic_update(): the former runs =
first
> + * in a commit, so it must not rely on values only synced by the latter.
> + */
> +static void ssd16xx_sync_session_props(struct ssd16xx_device *device,
> +				       const struct ssd16xx_plane_state *ssd_state)
> +{
> +	lockdep_assert_held(&device->lock);
> +
> +	device->refresh_mode =3D ssd_state->refresh_mode;
> +	device->color_mode =3D ssd_state->color_mode;
> +	device->clear_on_init =3D ssd_state->clear_on_init;
> +	device->clear_on_close =3D ssd_state->clear_on_close;
> +	device->clear_on_disable =3D ssd_state->clear_on_disable;
> +	device->refresh_mode_init =3D ssd_state->refresh_mode_init;
> +}
> +
>  static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
>  					struct drm_atomic_commit *state)
>  {
> @@ -1619,6 +1725,8 @@ static void ssd16xx_plane_atomic_update(struct drm_=
plane *plane,
>  	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=3D(%d=
,%d)-(%d,%d)\n",
>  		rect.x1, rect.y1, rect.x2, rect.y2);
> =20
> +	mutex_lock(&device->lock);
> +
>  	/* Diff refresh_mode against the plane's own previous state to see
>  	 * whether fast LUT preload is needed.
>  	 */
> @@ -1635,8 +1743,7 @@ static void ssd16xx_plane_atomic_update(struct drm_=
plane *plane,
>  			device->fast_lut_pending =3D false;
>  	}
> =20
> -	device->refresh_mode =3D new_ssd->refresh_mode;
> -	device->color_mode =3D new_ssd->color_mode;
> +	ssd16xx_sync_session_props(device, new_ssd);

[Severity: Medium]
Can session property updates be missed when a commit has no framebuffer
damage, detaches the framebuffer, or occurs while the CRTC is inactive?

In ssd16xx_plane_atomic_update(), ssd16xx_sync_session_props() is called
after the early exits for a NULL framebuffer and empty damage:

	if (!fb)
		goto out_exit;

	/* Nothing to draw: don't wake the panel up. */
	if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect))
		goto out_exit;

In addition, drm_atomic_helper_commit_tail_rpm() passes
DRM_PLANE_COMMIT_ACTIVE_ONLY to drm_atomic_helper_commit_planes(), which
skips ssd16xx_plane_atomic_update() whenever the CRTC is inactive.

If userspace updates clear_on_close or clear_on_disable in a property-only
commit with no damage, while fb is NULL, or while the CRTC is disabled, will
ssd16xx_device retain the stale values when ssd16xx_drm_master_drop() or
ssd16xx_crtc_atomic_disable() later runs?

[Severity: Medium]
Does fast_lut_pending account for refresh_mode_init and the clear_on_*
session modes?

In ssd16xx_plane_atomic_update(), device->fast_lut_pending is computed from
old_ssd->refresh_mode and new_ssd->refresh_mode before device->refresh_mode
is overridden by device->refresh_mode_init:

	if (old_ssd->refresh_mode !=3D new_ssd->refresh_mode) {
		if (new_ssd->refresh_mode =3D=3D SSD16XX_REFRESH_FAST &&
		    old_ssd->refresh_mode !=3D SSD16XX_REFRESH_FULL)
			device->fast_lut_pending =3D true;
		else
			device->fast_lut_pending =3D false;
	}

	ssd16xx_sync_session_props(device, new_ssd);

	saved_mode =3D device->refresh_mode;
	saved_border_waveform_idx =3D device->border_waveform_update_idx;
	if (device->init_refresh_pending) {
		device->refresh_mode =3D device->refresh_mode_init;
		device->border_waveform_update_idx =3D device->border_waveform_init_idx;
	}

	if (device->fast_lut_pending) {
		ret =3D ssd16xx_preload_fast_lut(device);
		...
		device->fast_lut_pending =3D false;
	}

If new_ssd->refresh_mode is SSD16XX_REFRESH_PARTIAL and refresh_mode_init is
set to fast, fast_lut_pending remains false and the first frame runs a fast
refresh (0xC7) without preloading the fast LUT. Conversely, if
new_ssd->refresh_mode transitions to SSD16XX_REFRESH_FAST while
refresh_mode_init is set to partial, ssd16xx_preload_fast_lut() runs and
clears fast_lut_pending before the init frame, which then runs a partial
refresh (0xFF) that overwrites the LUT in the controller, leaving subsequent
fast frames without the fast LUT.

Similarly, if clear_on_init, clear_on_disable, or clear_on_close is set to
fast, ssd16xx_clear_display() sends SSD1683_CTRL2_FAST_REFRESH without
preloading the fast LUT, and if clear_on_init is set to partial while
refresh_mode is fast, ssd16xx_clear_display_on_init() overwrites the LUT
loaded by ssd16xx_hw_init() without re-arming fast_lut_pending.

> =20
>  	/*
>  	 * When refresh_mode_init was set, use the specified mode for this first
> @@ -1693,6 +1800,8 @@ static void ssd16xx_plane_atomic_update(struct drm_=
plane *plane,
>  		device->border_waveform_pending =3D true;
>  	}
> =20
> +	mutex_unlock(&device->lock);
> +
>  	pm_runtime_mark_last_busy(device->drm.dev);
>  	pm_runtime_put_autosuspend(device->drm.dev);
> =20
> @@ -1754,6 +1863,8 @@ static void ssd16xx_crtc_atomic_disable(struct drm_=
crtc *crtc,
>  	if (!drm_dev_enter(&device->drm, &idx))
>  		return;
> =20
> +	mutex_lock(&device->lock);
> +
>  	if (device->clear_on_disable < 0 || device->cleared_on_disable)
>  		goto out;

[Severity: Medium]
Should ssd16xx_crtc_atomic_disable() also sync the session properties from
the commit's new primary plane state before checking
device->clear_on_disable?

Because the driver uses drm_atomic_helper_commit_tail_rpm(),
drm_atomic_helper_commit_modeset_disables() runs
ssd16xx_crtc_atomic_disable() before drm_atomic_helper_commit_planes(), and
drm_atomic_helper_commit_planes() skips disabled CRTCs due to
DRM_PLANE_COMMIT_ACTIVE_ONLY. If userspace sets clear_on_disable or
clear_on_close in the same atomic commit that disables the CRTC,
ssd16xx_crtc_atomic_disable() and ssd16xx_drm_master_drop() will not see the
updated plane state.

> =20
> @@ -1775,6 +1886,7 @@ static void ssd16xx_crtc_atomic_disable(struct drm_=
crtc *crtc,
>  	device->cleared_on_disable =3D true;
>  	pm_runtime_put_sync_suspend(device->drm.dev);
>  out:
> +	mutex_unlock(&device->lock);
>  	drm_dev_exit(idx);
>  }
> =20
> @@ -1782,6 +1894,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_c=
rtc *crtc,
>  				       struct drm_atomic_commit *state)
>  {
>  	struct ssd16xx_device *device =3D crtc_to_ssd16xx_device(crtc);
> +	struct drm_plane_state *new_plane_state =3D
> +		drm_atomic_get_new_plane_state(state, &device->primary_plane);
>  	int ret, idx;
> =20
>  	if (!drm_dev_enter(&device->drm, &idx))
> @@ -1797,16 +1911,28 @@ static void ssd16xx_crtc_atomic_enable(struct drm=
_crtc *crtc,
>  	drm_dbg(&device->drm, "atomic_enable: %dx%d orientation=3D%u=C2=B0\n",
>  		device->width, device->height, device->orientation);
> =20
> +	/* Serialise hw_init and session-prop setup against master_drop(). */
> +	mutex_lock(&device->lock);
> +
>  	if (!device->initialized) {
>  		ret =3D ssd16xx_hw_init(device);
>  		if (ret) {
>  			drm_err(&device->drm, "atomic_enable: hw_init failed: %d\n", ret);
> +			mutex_unlock(&device->lock);
>  			pm_runtime_put_autosuspend(device->drm.dev);
>  			drm_dev_exit(idx);
>  			return;
>  		}
>  		device->initialized =3D true;
>  	}
> +
> +	/*
> +	 * atomic_enable runs before plane_atomic_update, so pick up the session
> +	 * properties of this very commit instead of the previous one's.
> +	 */
> +	if (new_plane_state)
> +		ssd16xx_sync_session_props(device, to_ssd16xx_plane_state(new_plane_st=
ate));

[Severity: Medium]
Should ssd16xx_sync_session_props() be called before ssd16xx_hw_init() and
pm_runtime_resume_and_get()?

Inside ssd16xx_hw_init(), device->refresh_mode is checked to decide whether
to preload the fast LUT:

	if (device->refresh_mode =3D=3D SSD16XX_REFRESH_FAST) {
		...
	}

Because ssd16xx_hw_init() runs before ssd16xx_sync_session_props(), it reads
the previous commit's refresh_mode rather than the new plane state's
refresh_mode.

[Severity: Medium]
Additionally, in both ssd16xx_crtc_atomic_enable() and
ssd16xx_plane_atomic_update(), pm_runtime_resume_and_get() is called before
mutex_lock(&device->lock), and pm_runtime_put_autosuspend() is called after
mutex_unlock(&device->lock):

	ret =3D pm_runtime_resume_and_get(device->drm.dev);
	...
	mutex_lock(&device->lock);
	...
	mutex_unlock(&device->lock);

	pm_runtime_mark_last_busy(device->drm.dev);
	pm_runtime_put_autosuspend(device->drm.dev);

When the panel is runtime-suspended, pm_runtime_resume_and_get()
synchronously runs ssd16xx_pm_runtime_resume() -> ssd16xx_hw_init() and sets
device->initialized =3D true without holding device->lock, racing with
ssd16xx_drm_master_drop(). Furthermore, if a nonblocking commit in
ssd16xx_plane_atomic_update() holds the runtime PM reference while waiting =
on
mutex_lock(&device->lock), ssd16xx_drm_master_drop()'s call to
pm_runtime_put_sync_suspend() will see usage_count > 0 and fail to suspend
the panel, and once ssd16xx_drm_master_drop() releases device->lock, the
unblocked ssd16xx_plane_atomic_update() will draw over the screen that
clear_on_close just cleared.

> +
>  	device->cleared_on_disable =3D false;
> =20
>  	/* Clear display on first app launch if configured */
> @@ -1826,6 +1952,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_c=
rtc *crtc,
>  		device->init_refresh_pending =3D true;
>  	}

[Severity: Medium]
What happens when a client opens the DRM device and then sets the
refresh_mode_init plane property to disabled?

When the device is opened on a panel where refresh_mode_init >=3D 0 by defa=
ult
(such as GDEY042T81, where default_refresh_mode_init is
SSD16XX_REFRESH_FULL), ssd16xx_drm_master_set() sets
device->init_refresh_pending =3D true before the client can change plane
properties:

	if (device->refresh_mode_init >=3D 0)
		device->init_refresh_pending =3D true;

If the client then sets refresh_mode_init to SSD16XX_SESSION_DISABLED (which
maps to internal value -1), ssd16xx_sync_session_props() sets
device->refresh_mode_init =3D -1, but neither ssd16xx_sync_session_props() =
nor
ssd16xx_crtc_atomic_enable() clears device->init_refresh_pending when
device->refresh_mode_init < 0.

When ssd16xx_plane_atomic_update() subsequently runs:

	if (device->init_refresh_pending) {
		device->refresh_mode =3D device->refresh_mode_init;
		device->border_waveform_update_idx =3D device->border_waveform_init_idx;
	}

device->refresh_mode is set to -1, causing ssd16xx_fb_dirty() to fall throu=
gh
to the default partial refresh case with the init border waveform (and skip
3-color red buffer setup) instead of using the configured refresh_mode.

Conversely, if device->refresh_mode_init was -1 when ssd16xx_drm_master_set=
()
ran and the client enables refresh_mode_init in a plane update on an
already-active CRTC where ssd16xx_crtc_atomic_enable() does not run,
device->init_refresh_pending is never armed.

> =20
> +	mutex_unlock(&device->lock);
> +
>  	pm_runtime_mark_last_busy(device->drm.dev);
>  	pm_runtime_put_autosuspend(device->drm.dev);
>  	drm_dev_exit(idx);

[ ... ]

> @@ -1963,6 +2140,12 @@ static void ssd16xx_drm_master_drop(struct drm_dev=
ice *drm,
>  	struct ssd16xx_device *device =3D to_ssd16xx_device(drm);
>  	int ret, idx;
> =20
> +	/*
> +	 * Not serialized against nonblocking commits by the DRM core (e.g. on
> +	 * DROP_MASTER), so hold the lock across the panel clear too.
> +	 */
> +	guard(mutex)(&device->lock);
> +
>  	device->init_refresh_pending =3D false;
>  	device->first_clear_done =3D false;

[Severity: High]
Does acquiring device->lock before drm_dev_enter() in
ssd16xx_drm_master_drop() create a lock inversion with the atomic commit
callbacks?

In ssd16xx_drm_master_drop(), guard(mutex)(&device->lock) acquires
device->lock before calling drm_dev_enter(drm, &idx) (which acquires
drm_unplug_srcu):

	guard(mutex)(&device->lock);
	...
	if (!drm_dev_enter(drm, &idx))
		return;

However, ssd16xx_plane_atomic_update(), ssd16xx_crtc_atomic_disable(), and
ssd16xx_crtc_atomic_enable() all call drm_dev_enter(&device->drm, &idx)
before acquiring mutex_lock(&device->lock):

	if (!drm_dev_enter(&device->drm, &idx))
		return;

	mutex_lock(&device->lock);

Will this reverse locking order between device->lock and drm_unplug_srcu
trigger a lockdep circular locking dependency warning when a client commits=
 a
frame and then drops master with clear_on_close enabled?

> =20

[ ... ]

>
> --=20
> 2.34.1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019213726.4145=
532-1-devarsht@ti.com?part=3D10
