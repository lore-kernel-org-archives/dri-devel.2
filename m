Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B723CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB4B10EC30;
	Thu, 15 Oct 2026 16:21:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A644E10EC30
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:21:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3ACE601EF
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B74C1F000C4;
 Thu, 15 Oct 2026 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792081294;
 bh=d8l40k7pRlLXd7cCourEHe7vL12PUrWG1iS5VMUk8dw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=onwPZGcEDmBLpf1Qe1/zLRz3iXHfcTU7SdTX7cbKJtHiDYJ2xXT1EGiqYwIyV1VuC
 3A8FFYTo61uGkHFQmLY2NZe7kdM3Yv6XO9h4LIEHzD6xuG5TZipdgwmVro1kgi/+tc
 fAytgg600I9qH8xtHfWtK/oNZd/jRItRJkTYBJY6SisjD1fFlK0MnipHlpt+9U3J1p
 K5Ex/fc2kbtzLcEyLS1SUnZoINH9kchCANKGMks9+do3caCHPm2A19fEY9BJKVOxyV
 UqPbS1/8xgVsdDv/fKd1EZ4w2ElX+I35Gqph1ppyBYjto3kawzbmYYtj6mSJaMxdTQ
 Fj+TwngAjb25Q==
Message-ID: <sashiko-outbox-173171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/28] drm/atomic_sro: Provide helpers to implement
 hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-13-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-13-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:21:33 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm: NULL pointer dereference in drm_atomic_helper_sro_readout_sta=
te() due to missing fallback
- [High] drm: NULL pointer dereference for legacy bridges in drm_atomic_hel=
per_sro_readout_bridges_state()
- [High] drm/atomic_sro: NULL pointer dereference in disabled bridge readout
- [High] drm/atomic_sro: out-of-bounds write in connector state array
- [Medium] drm: O(N^2) loop and OOB read risk in drm_atomic_sro_install_sta=
te()
- [Low] drm/atomic: error code shadowed in drm_atomic_helper_sro_build_stat=
e()
--

commit 4ec8820a89de05a3189db7a50590573132825dee
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Provide helpers to implement hardware state readout

Drivers implementing SRO need to iterate over their KMS objects,
allocate a pristine state for each, call the readout hook, and store
the result in the SRO state container. Provide helpers for each object type
and a top-level function that calls them in sequence.

> diff --git a/drivers/gpu/drm/drm_atomic_sro_helper.c b/drivers/gpu/drm/dr=
m_atomic_sro_helper.c
> new file mode 100644
> index 0000000000000..50d1af53bfc24
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_sro_helper.c
[ ... ]
> +int
> +drm_atomic_helper_sro_readout_bridges_state(struct drm_device *dev,
> +					    struct drm_atomic_sro_state *state)
> +{
> +	struct drm_encoder *encoder;
> +
> +	might_alloc(GFP_KERNEL);
[ ... ]
> +	drm_for_each_encoder(encoder, dev) {
> +		struct drm_bridge *bridge;
> +		int ret;
> +
> +		list_for_each_entry(bridge, &encoder->bridge_chain, chain_node) {
> +			struct drm_private_obj *bridge_obj =3D &bridge->base;
> +			const struct drm_private_state_funcs *bridge_obj_funcs =3D
> +				bridge_obj->funcs;
> +			struct drm_private_state *bridge_obj_state;
> +
> +			if (!bridge_obj_funcs->atomic_sro_readout_state) {

[Severity: High]
Can bridge_obj_funcs be NULL here for legacy non-atomic bridges?

Legacy (non-atomic) bridges do not call drm_atomic_private_obj_init() during
attachment. This means their embedded bridge->base is uninitialized, and its
funcs pointer remains NULL.

If this readout helper encounters a non-atomic bridge in the encoder's brid=
ge
chain, dereferencing bridge_obj_funcs unconditionally will cause a NULL
pointer dereference.

> +				drm_warn(dev,
> +					 "No bridge %s readout implementation.",
> +					 bridge->name);
> +				continue;
> +			}
[ ... ]
> +struct drm_atomic_sro_state *
> +drm_atomic_helper_sro_build_state(struct drm_device *dev)
> +{
> +	struct drm_atomic_sro_state *state;
> +	struct drm_printer p =3D drm_dbg_printer(dev, DRM_UT_ATOMIC, NULL);
> +	int ret;
> +
> +	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.\n=
");
> +
> +	state =3D drm_atomic_sro_state_alloc(dev);
> +	if (drm_WARN_ON(dev, IS_ERR(state)))
> +		return ERR_PTR(-ENOMEM);

[Severity: Low]
Does this error handling shadow the actual error pointer returned by
drm_atomic_sro_state_alloc()?

In drm_atomic_sro_state_alloc(), an allocation failure incorrectly returns
ERR_PTR(-EINVAL). Then, this function masks that error pointer and replaces
it with ERR_PTR(-ENOMEM) instead of propagating it.

While this results in a misleading error code on failure, it also violates
standard kernel error propagation patterns where the true error pointer is
typically returned directly.

> +
> +	ret =3D drm_atomic_helper_sro_readout_crtcs_state(dev, state);
> +	if (ret)
> +		goto err_state_free;
[ ... ]
> +int drm_atomic_helper_sro_readout_state(struct drm_device *dev)
> +{
> +	const struct drm_mode_config_helper_funcs *funcs =3D
> +		dev->mode_config.helper_private;
> +	struct drm_atomic_sro_state *state;
> +
> +	if (!drm_atomic_sro_device_can_readout(dev)) {
> +		drm_info(dev, "Device doesn't support hardware state readout.");
> +		return -ENOTSUPP;
> +	}
> +
> +	state =3D funcs->atomic_sro_build_state(dev);

[Severity: High]
Does this code handle cases where funcs is NULL, or where
funcs->atomic_sro_build_state is NULL?

The documentation for atomic_sro_build_state states that
drm_atomic_helper_sro_build_state() is the default implementation, which
implies drivers are not required to provide a custom hook.

If a driver does not provide this hook, or does not use helper private data,
calling funcs->atomic_sro_build_state(dev) unconditionally will result in a
NULL pointer dereference.

> +	if (IS_ERR(state))
> +		return PTR_ERR(state);
> +
> +	drm_atomic_sro_install_state(state);
> +	drm_atomic_sro_state_free(state);
> +
> +	return 0;
> +}

[Severity: High]
Is there a risk of a NULL pointer dereference during disabled bridge readout
when using drm_atomic_sro_get_crtc_state()?

If the bridge readout is called when the pipeline is inactive, a connector
state may not have an associated CRTC. The
drm_bridge_atomic_readout_priv_state() hook appears to pass this NULL CRTC
directly to drm_atomic_sro_get_crtc_state():

drm_bridge.c:drm_bridge_atomic_readout_priv_state() {
    ...
    crtc_state =3D drm_atomic_sro_get_crtc_state(state, conn_state->crtc);
    ...
}

Which unconditionally dereferences the CRTC pointer to fetch its index:

drm_atomic_sro.c:drm_atomic_sro_get_crtc_state() {
    ...
    unsigned int index =3D drm_crtc_index(crtc);
    ...
}

This can cause a kernel oops on boot if SRO is enabled and a disabled
pipeline is read out. Note that this issue was identified as being introduc=
ed
in a subsequent patch in the series and persists through the final commit.

[Severity: Medium]
Does drm_atomic_sro_install_state() have an O(N^2) loop and an out-of-bounds
read risk?

The loop condition in drm_atomic_sro_install_state() evaluates a dynamic
list count rather than the allocated array bounds:

drm_atomic_sro.c:drm_atomic_sro_install_state() {
    ...
    for (i =3D 0; i < count_private_obj(state->dev); i++) {
        const struct drm_private_state_funcs *obj_funcs;
        struct drm_private_state *obj_state;
        struct drm_private_obj *obj;

        obj =3D state->private_objs[i].ptr;
    ...
}

Because count_private_obj() iterates over a linked list on every iteration,
this creates an O(N^2) time complexity. Furthermore, if a private object is
registered between the allocation of the state->private_objs array and the
invocation of this loop, count_private_obj() will return a value larger than
the allocated array size. This would lead to an out-of-bounds read of
state->private_objs[i].ptr.

Using state->num_private_objs instead of count_private_obj() would avoid
both the complexity and the bounds risk.

[Severity: High]
Does drm_atomic_sro_set_connector_state() risk an out-of-bounds write when
connector indices exceed the active connector count?

drm_atomic_sro_state_init() allocates the state->connectors array sized
strictly to the current num_connector count:

drm_atomic_sro.c:drm_atomic_sro_state_init() {
    ...
    state->connectors =3D kzalloc_objs(*state->connectors,
                     dev->mode_config.num_connector);
    if (!state->connectors) {
    ...
}

However, drm_connector_index(conn) returns an IDA-allocated index. If
connectors are dynamically added and removed (for example, via DP MST
hot-unplug), the IDA index can be larger than the total number of currently
registered connectors.=20

drm_atomic_sro_set_connector_state() blindly uses this potentially
out-of-bounds index to write into the array:

drm_atomic_sro.c:drm_atomic_sro_set_connector_state() {
    ...
    unsigned int index =3D drm_connector_index(conn);

    drm_connector_get(conn);
    state->connectors[index].ptr =3D conn;
    state->connectors[index].state =3D conn_state;
    ...
}

This can corrupt kernel memory if state readout is performed after connector
removals.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D13
