Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474EFCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5AA7112417;
	Thu, 15 Oct 2026 16:53:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E670F112417
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:53:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E6FB60200
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5121F000C4;
 Thu, 15 Oct 2026 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792083197;
 bh=ZdA3CvjrQKJiW+IGFwuMJDcPPfwTMa7Z0brZZllLwlI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OUGOHtgmQI6MxxLNXBDrwd3RJ7/uNc54RdpJBUINf9Xw06GKmyEgaLmMkSG20Gmp1
 tgeN3FZ8kh8heED9fQ2Ka4zs0QK2hMQOsRBFAGv97aF+vj7gNRWJutJ1ERLFVDqH0a
 rK8AGUAgOsjwCXGCEdEaqOY7jmSGpJtaYV9CaBLOgIGGjRaaoYq9Zlf+ZnaQAqSC9T
 1Oz1lJsQ4f57c61omBxxUTBGxE4feCO10kX1/CD5o9Gk+y4bVsJJzG2yvjtXSZzE+e
 RNeGXvwcotUaZttixs5UV/Yws988t0br+wlUXBFCE6bq2XS+PhqvoI21wQ16ezTmlp
 kYijXhcYRCpVQ==
Message-ID: <sashiko-outbox-173209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/28] drm/atomic-helper: Document State Read-Out as
 a state initialization approach
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-19-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-19-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:53:17 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] drm/atomic: global SRO readout in commit_tail causes NULL dere=
fs and data races
- [High] drm: SRO omits drm_colorop objects breaking initialization
- [High] drm: list corruption on bridge detach due to ignored init failure
- [Medium] drm: drm_mode_config_create_initial_state omits encoder reset
--

commit 5a139aeb014c8ea3fdfb3bca244ee293e5da8224
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-helper: Document State Read-Out as a state initialization approa=
ch

This commit updates the atomic state reset and initialization documentation
to describe the State Read-Out (SRO) infrastructure as a solution for
reconstructing software state from hardware registers. It cross-references
the new SRO section and mentions drm_mode_config_create_initial_state()
as a combined approach.

> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomi=
c_sro.c
> --- a/drivers/gpu/drm/drm_atomic_sro.c
> +++ b/drivers/gpu/drm/drm_atomic_sro.c
[ ... ]
> struct drm_atomic_sro_state {
> 	struct drm_device *dev;
> 	struct __drm_atomic_sro_plane *planes;
> 	struct __drm_atomic_sro_crtc *crtcs;
> 	struct __drm_atomic_sro_connector *connectors;
> 	struct __drm_atomic_sro_private_obj *private_objs;
> 	unsigned int num_private_objs;
> };

[Severity: High]
Does this struct lack a colorops array?

Since drm_colorop objects do not embed drm_private_obj, omitting them here
cascades into all the readout and install functions missing colorop process=
ing
entirely.

When drivers use drm_mode_config_create_initial_state() and successfully re=
ad
out state via SRO, they skip drm_mode_config_reset(). This means
drm_colorop_reset() is never called and colorop->state remains uninitialized
(NULL).

Subsequent atomic commits will call drm_atomic_get_colorop_state(), which c=
alls
drm_atomic_helper_colorop_duplicate_state(). This helper encounters
WARN_ON(!colorop->state) and returns NULL, causing the atomic commit to fail
consistently with -ENOMEM.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
[ ... ]
> @@ -2087,6 +2088,45 @@ static void commit_tail(struct drm_atomic_commit *=
state, bool nonblock)
> =20
>  	drm_atomic_helper_commit_cleanup_done(state);
> =20
[ ... ]
> +	if (!nonblock)
> +		drm_atomic_sro_readout_and_compare(state);
> =20
>  	drm_atomic_commit_put(state);
>  }

[Severity: Critical]
Is this regression causing a NULL pointer dereference on unsupported driver=
s?

This path directly calls funcs->atomic_sro_build_state(dev) without verifyi=
ng if
funcs or the function pointer is non-NULL.

For supported drivers, atomic_sro_build_state reads the hardware state for =
all
CRTCs, planes, and connectors device-wide. Because blocking commits only lo=
ck
the specific objects being modified, reading unrelated objects can cause da=
ta
races with concurrent non-blocking commits that are mutating them.

Does this also risk MMIO hangs by accessing powered-down objects without ta=
king
appropriate power management references?

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
[ ... ]
> +int drm_mode_config_create_initial_state(struct drm_device *dev)
> +{
> +	int ret;
> +
> +	if (dev->mode_config.funcs->atomic_sro_readout_state) {
> +		ret =3D dev->mode_config.funcs->atomic_sro_readout_state(dev);
> +		if (!ret)
> +			return 0;
> +	}
> +
> +	/* Reset the hardware first ... */
> +	if (dev->mode_config.funcs->hw_reset)
> +		dev->mode_config.funcs->hw_reset(dev);
> +
> +	/* ... then allocate a new pristine state */
> +	return drm_mode_config_create_state(dev);
> +}

[Severity: Medium]
Does this fallback path omit iterating over encoders to call their .reset
hooks?

When drm_mode_config_create_initial_state() falls back to hardware reset,
hw_reset() defaults to CRTC-only resets via drm_mode_config_helper_hw_reset=
(),
and drm_mode_config_create_state() skips encoders.

Without a generic reset path, drivers relying on encoder->funcs->reset (like
loongson) will fail to reset encoder registers, which is a regression that
potentially causes display failures.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
[ ... ]
> @@ -649,8 +751,14 @@ int drm_bridge_attach(struct drm_encoder *encoder, s=
truct drm_bridge *bridge,
>  			goto err_reset_bridge;
>  	}
> =20
> -	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> -				    &drm_bridge_priv_state_funcs);
> +	if (bridge->funcs &&
> +	    bridge->funcs->atomic_sro_readout_state &&
> +	    bridge->funcs->atomic_sro_compare_state)
> +		drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
> +					    &drm_bridge_priv_state_funcs_with_sro);
> +	else
> +		drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
> +					    &drm_bridge_priv_state_funcs);
> =20
>  	return 0;

[Severity: High]
Can ignoring the return value of drm_atomic_private_obj_init() here lead to=
 a
double list_del() and kernel crash upon teardown?

If drm_atomic_private_obj_init() fails, it deletes and poisons the list nod=
e:

drivers/gpu/drm/drm_atomic.c:drm_atomic_private_obj_init() {
    ...
	if (IS_ERR(state)) {
		ret =3D PTR_ERR(state);
		goto err_list_del;
	}
    ...
err_list_del:
	list_del(&obj->head);
    ...
}

Because drm_bridge_attach() unconditionally returns 0, the bridge remains
registered with a poisoned private object list head.

When drm_bridge_detach() is later called, it calls
drm_atomic_private_obj_fini(&bridge->base), which performs a blind second
list_del() on the poisoned node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D19
