Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B27C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657E710E330;
	Mon, 31 Aug 2026 22:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LzBZk2vG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B803310E33C;
 Mon, 31 Aug 2026 22:28:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F6B54032D;
 Mon, 31 Aug 2026 22:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FEF1F000E9;
 Mon, 31 Aug 2026 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788215316;
 bh=NgU3hWytSFRQ+LxNdGovMmcBeCaDREXmg9P6oxyd7sU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LzBZk2vGwn8LWinyvkofDVVkf4mLf4AZ7ynv6V4rvKrppr/HM9Z57SSfcLGmIJIFz
 MOZK+aBk1oeo+OlKkiyOPKUkmzLh8AchmElr5eeZn2wlh59tmcbtxBfbcbOpYnqkj0
 d0vDMOAlhp8lDTYtPtyCXZlWpCTIIslJbhjj+ePTxsTA3CBmTqRpx6HPbDs584umcF
 g/Ay15YL+pS0JaKn0LfFPAmnQx2jKMt4xtyh3DNxnzYVIStVOkym1FUp4teuxC4d0p
 tKf+Hw1Z74ucvCSCh6Oe12vpoXpCgmECLRaQU5s31dWTdI/yCu9bA8/U8GEwLkDJcF
 onbS9xuZP3WEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/12] drm: add connector backlight (LUMINANCE)
 infrastructure
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-5-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:28:35 +0000
Message-Id: <20260831222836.48FEF1F000E9@smtp.kernel.org>
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
- [High] Use-after-free of `drm_backlight` in `drm_backlight_notify` during=
 concurrent unregistration.
- [High] Unprotected direct modification of the active DRM atomic connector=
 state from an asynchronous backlight event.
- [High] `drm_backlight_get_device()` returns an unreferenced pointer, lead=
ing to Use-After-Free in sysfs linking.
- [High] Legacy DPMS state handling erroneously dims all connectors on a CR=
TC and fails to persist the DPMS OFF state across subsequent commits.
- [High] Data race dereferencing live `connector->state` in atomic commit t=
ail instead of the captured new state.
- [High] Leaked backlight list entry and pending work item on connector cle=
anup error path causes Use-After-Free.
- [High] A TOCTOU race in `drm_backlight_do_unlink` can overwrite a concurr=
ently linked new backend pointer with NULL, leading to a NULL pointer deref=
erence.
- [High] Race condition in `drm_backlight_do_unlink` early return can lead =
to use-after-free during connector teardown.
- [Medium] Asynchronous backlight transitions violate strict display pipeli=
ne sequencing and DPMS semantics.
- [Medium] The 'backlight' sysfs symlink becomes dangling or stale on dynam=
ic backend unlink or hot-swap.
- [Medium] The `get_range` callback is invoked while holding a spinlock and=
 from the atomic commit tail, directly violating its API contract.
- [Medium] Unconditional lockdep assertion failure in `drm_backlight_connec=
tor_cleanup`.
- [Low] The drm_backlight core is hardcoded to `backlight_device`, preventi=
ng the addition of other backends without modifying the core.
--

commit a5f154fe3d2dddb5c9740e818e4993aaff0079d8
Author: Mario Limonciello <mario.limonciello@amd.com>
Subject: drm: add connector backlight (LUMINANCE) infrastructure

This commit adds a generic per-connector LUMINANCE property to allow driving
backlight brightness through the DRM atomic modeset path. It embeds a
drm_backlight structure in every connector and links it to backend devices
like the backlight subsystem via workqueues.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 285aac3554dfd..3603a8cce074e 100644
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

[Severity: Medium]
Does this sequence violate DPMS semantics and cause visual artifacts?

drm_backlight_set_luminance() schedules the backlight to turn off asynchron=
ously
via a workqueue, but drm_atomic_bridge_chain_disable() immediately disables
the display pipeline synchronously. The pipeline might turn off before the
backlight is actually off.

[ ... ]
> @@ -1744,6 +1749,10 @@ drm_atomic_helper_commit_encoder_bridge_enable(str=
uct drm_device *dev, struct dr
> =20
>  		drm_atomic_bridge_chain_enable(bridge, state);
>  		drm_bridge_put(bridge);
> +
> +		/* Restore the backlight once the pipeline is enabled. */
> +		if (connector->state)
> +			drm_atomic_helper_connector_apply_luminance(connector->state);

[Severity: High]
Can this cause data races by dereferencing the live connector state?

Because this runs asynchronously in the non-blocking commit tail, the live
connector->state might have already been swapped by a subsequent atomic com=
mit.
Should this use the captured new_conn_state instead?

[ ... ]
> +void drm_atomic_helper_connector_apply_luminance(const struct drm_connec=
tor_state *conn_state)
> +{
> +	struct drm_connector *connector =3D conn_state->connector;
> +
> +	if (conn_state->crtc && conn_state->crtc->state &&
> +	    conn_state->crtc->state->active)
> +		drm_backlight_set_luminance(connector, conn_state->luminance);
> +}

[Severity: High]
Does this unintentionally override the legacy DPMS state on subsequent comm=
its?

By relying solely on the CRTC's active state, if a single connector is set =
to
DPMS OFF (but the CRTC remains active for other cloned connectors), the next
atomic commit will incorrectly restore this connector's backlight.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1050dddadb17e..5e687600ce45e 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
[ ... ]
> +	/* Handle backlight brightness coordination with DPMS state changes */
> +	if (old_mode !=3D DRM_MODE_DPMS_OFF && mode =3D=3D DRM_MODE_DPMS_OFF) {
> +		/* DPMS ON -> OFF: dim all connectors driven by this CRTC. */
> +		if (crtc)
> +			drm_atomic_crtc_set_backlight(crtc, false);

[Severity: High]
Does this erroneously dim all connectors on the CRTC instead of just the
target connector?

When userspace sets one connector to DPMS OFF on a cloned output setup, this
will unintentionally turn off the backlight for all other active connectors
attached to the same CRTC.

> diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backli=
ght.c
> new file mode 100644
> index 0000000000000..4251cb25079c3
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_backlight.c
[ ... ]
> +/* caller must hold @drm_backlight_lock */
> +static void __drm_backlight_set(struct drm_backlight *b, unsigned int v)
> +{
> +	unsigned int max =3D 0;
> +	bool can_disable =3D false;
> +
> +	lockdep_assert_held(&drm_backlight_lock);
> +
> +	if (!b->funcs || !b->funcs->get_range)
> +		return;
> +
> +	b->funcs->get_range(b, &max, &can_disable);

[Severity: Medium]
Can this trigger a sleeping in atomic context warning?

__drm_backlight_set() is called with the drm_backlight_lock spinlock held.
However, it invokes the get_range callback, which the API contract states
is allowed to sleep and must not be called from atomic contexts.

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
> +}

[Severity: High]
Is it safe to mutate the active DRM atomic connector state directly?

The connector->state represents the committed, immutable atomic state. Modi=
fying
it outside of an atomic commit transaction could cause data races and torn =
state
when concurrent readers (like state duplication) access it.

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

[Severity: High]
Can this early return lead to a use-after-free during connector teardown?

If one thread drops the lock to call cancel_work_sync(), a concurrent thread
(e.g., connector teardown) calling drm_backlight_do_unlink() will see
!b->funcs and return immediately. This second thread will proceed to free t=
he
connector while the first thread is still executing cancel_work_sync(&b->wo=
rk)
inside the freed memory block.

[Severity: Medium]
Does this missing cleanup leave a dangling sysfs symlink?

When unlinking the backend, the backlight sysfs symlink created in
drm_sysfs_connector_add_late() is not removed, which will leave a stale
symlink pointing to a freed device object.

> +		bd =3D drm_backlight_bd(b);
> +		clients =3D b->luminance_clients;
> +		b->funcs =3D NULL;
> +		list_del_init(&b->list);
> +	}
> +
> +	cancel_work_sync(&b->work);
> +
> +	scoped_guard(spinlock, &drm_backlight_lock) {
> +		if (clients && bd)
> +			atomic_sub(clients, &bd->drm_takeover);
> +		b->backend =3D NULL;
> +	}

[Severity: High]
Can this cause a race condition resulting in a NULL pointer dereference?

After dropping the lock for cancel_work_sync(), a concurrent
drm_backlight_link() could have linked a new backend. Unconditionally execu=
ting
b->backend =3D NULL here will overwrite the newly linked backend, causing t=
he next
hardware update to dereference NULL.

> +
> +	backlight_device_unref(bd);

[Severity: Low]
Does this hardcoded unref violate the backend-agnostic design?

Resource cleanup is explicitly hardcoded to the backlight_device subsystem,
preventing the addition of other backends without modifying the core.

[ ... ]
> +void drm_backlight_connector_cleanup(struct drm_connector *connector)
> +{
> +	struct drm_backlight *b =3D &connector->backlight;
> +
> +	WARN_ON(__drm_backlight_is_linked(b));

[Severity: Medium]
Will this trigger an unconditional lockdep assertion failure?

__drm_backlight_is_linked() unconditionally asserts that drm_backlight_lock
is held, but it is being called here without acquiring the lock.

[Severity: High]
Does this error path leak memory and cause a use-after-free?

If a connector fails probe before being registered, drm_connector_cleanup()
is called, bypassing the unregister path. This function only warns but fails
to remove the backlight from drm_backlight_list or cancel its work item,
leaving a dangling pointer when the connector is freed.

[ ... ]
> +struct backlight_device *drm_backlight_get_device(struct drm_connector *=
connector)
> +{
> +	guard(spinlock)(&drm_backlight_lock);
> +	return drm_backlight_bd(&connector->backlight);
> +}

[Severity: High]
Can this lead to a use-after-free?

This returns a raw pointer to a reference-counted object without incrementi=
ng
the refcount. If the backlight is unregistered concurrently, callers
(like drm_sysfs_connector_add_late) will dereference a freed pointer.

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

[Severity: High]
Is the found pointer safe to dereference outside of the spinlock?

The spinlock is dropped before calling drm_backlight_do_unlink(found).
Concurrently, the connector embedding this backlight could be unregistered
and freed, leading to a use-after-free when found is dereferenced.

> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index ef4e923a87284..06cdfe046ca89 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
[ ... ]
> @@ -391,15 +393,33 @@ int drm_sysfs_connector_add(struct drm_connector *c=
onnector)
> =20
>  int drm_sysfs_connector_add_late(struct drm_connector *connector)
>  {
> -	if (connector->ddc)
> -		return sysfs_create_link(&connector->kdev->kobj,
> -					 &connector->ddc->dev.kobj, "ddc");
> +	struct backlight_device *bd =3D drm_backlight_get_device(connector);
[ ... ]
> +	if (bd) {
> +		int ret =3D sysfs_create_link(&connector->kdev->kobj,
> +					    &bd->dev.kobj, "backlight");

[Severity: High]
Can this cause a use-after-free when creating the sysfs link?

drm_backlight_get_device() does not take a reference on bd. If the backlight
device is concurrently unregistered and freed, dereferencing bd->dev.kobj
here will trigger a UAF.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D4
