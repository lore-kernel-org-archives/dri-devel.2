Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FA606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kloOvU+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721D2112022;
	Thu, 29 Oct 2026 07:56:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1260111201F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:56:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13414602C3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985CC1F01829;
 Thu, 29 Oct 2026 07:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260597;
 bh=vccbyNN8JJDlphISZurfyn/4M0qu2PkZvYZiNmCv3I0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kloOvU+GoRHjHqHal89rUTGaXn7go+0WWGmLart2R+ExZ/eDeR3YmzXOj4n8bsKyA
 bBtUF06xhlwmzQ3sdRTuV/UL/P8eko/+MsVLm146OpKWDvRNqYTOTy9rGXZ6SddOxm
 xHrH+dMMs+qDgQwZHBBcFl1Ug2jfFmkEKyS+msf/M2fzUSyiQM9+EWk6/ZG+KEHpgI
 x3nr+/h4wfvXqIu+33lL5fff9Gine878nuS2LUNruWFrUCEtIH2QvAxLqKEr8bkjOk
 n07kKffx95GOAeLWAZhRBcD1GL7lHnXD3rq0FbTnclKUAAZrWy8zVsYz0LyRIVDKva
 ZX8cLC/4yVNvw==
Message-ID: <sashiko-outbox-188925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/34] drm/atomic: Add drm_private_obj name
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-5-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-5-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:56:37 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: NULL bridge->name causes drm_atomic_private_obj_init()=
 failure
- [Medium] drm/dp_tunnel: empty group->name duplicated in init_group()
--

commit 4d9e18eb9a2836a0d646f48abba1d11dfdce7d31
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Add drm_private_obj name

This commit adds a human-readable name field to drm_private_obj,
allocated in drm_atomic_private_obj_init() and freed in
drm_atomic_private_obj_fini(), and updates existing callers to pass a
name.

> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/di=
splay/drm_dp_tunnel.c
> index d29ad4116e641..391d643793eb3 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -1732,6 +1732,7 @@ static bool init_group(struct drm_dp_tunnel_mgr *mg=
r, struct drm_dp_tunnel_group
>  	INIT_LIST_HEAD(&group->tunnels);
> =20
>  	drm_atomic_private_obj_init(mgr->dev, &group->base,
> +				    group->name,
>  				    &tunnel_group_funcs);
> =20
>  	return true;

[Severity: Medium]
Is group->name populated when init_group() runs?

In drm_dp_tunnel_mgr_create(), mgr->groups is zero-allocated via
kzalloc_objs() immediately before init_group() is called on each element:

drivers/gpu/drm/display/drm_dp_tunnel.c:drm_dp_tunnel_mgr_create() {
	mgr->groups =3D kzalloc_objs(*mgr->groups, max_group_count);
	...
	for (i =3D 0; i < max_group_count; i++) {
		if (!init_group(mgr, &mgr->groups[i])) {
}

Because drm_atomic_private_obj_init() duplicates the passed string with
kstrdup(), group->base.name is initialized to "" while group->name is only
formatted later when a tunnel is added in lookup_or_alloc_group():

drivers/gpu/drm/display/drm_dp_tunnel.c:lookup_or_alloc_group() {
	...
	snprintf(group->name, sizeof(group->name), "%d:%d:*",
		 tunnel_group_drv_id(drv_group_id) & ((1 << DP_GROUP_ID_BITS) - 1),
		 tunnel_group_id(drv_group_id) & ((1 << DP_USB4_DRIVER_ID_BITS) - 1));
}

Won't this leave group->base.name permanently set to an empty string for
every DP tunnel group?

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index e7f9e6d589272..ac65ac9416919 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -317,6 +317,7 @@ static void __drm_bridge_free(struct kref *kref)
> =20
>  	drm_bridge_put(bridge->next_bridge);
> =20
> +	kfree(bridge->name);
>  	kfree(bridge->container);
>  }
> =20
> @@ -418,6 +419,13 @@ void *__devm_drm_bridge_alloc(struct device *dev, si=
ze_t size, size_t offset,
>  		return ERR_PTR(-ENOMEM);
> =20
>  	bridge =3D container + offset;
> +
> +	bridge->name =3D kasprintf(GFP_KERNEL, "bridge-%s", dev_name(dev));
> +	if (!bridge->name) {
> +		kfree(container);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	INIT_LIST_HEAD(&bridge->list);
>  	bridge->container =3D container;
>  	bridge->funcs =3D funcs;
> @@ -649,7 +657,7 @@ int drm_bridge_attach(struct drm_encoder *encoder, st=
ruct drm_bridge *bridge,
>  			goto err_reset_bridge;
>  	}
> =20
> -	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> +	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
>  				    &drm_bridge_priv_state_funcs);
> =20
>  	return 0;

[Severity: High]
What happens in drm_bridge_attach() if a bridge was not allocated via
devm_drm_bridge_alloc() and therefore has bridge->name =3D=3D NULL?

For example, ingenic_drm_bind() allocates struct ingenic_drm_bridge via
drmm_encoder_alloc() and attaches &ib->bridge:

drivers/gpu/drm/ingenic/ingenic-drm-drv.c:ingenic_drm_bind() {
		ib =3D drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
					NULL, DRM_MODE_ENCODER_DPI, NULL);
		...
		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
		ib->next_bridge =3D bridge;

		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
}

When bridge->name is NULL, kstrdup(name, GFP_KERNEL) in
drm_atomic_private_obj_init() returns NULL and aborts with -ENOMEM before
adding bridge->base to dev->mode_config.privobj_list or calling
atomic_create_state() to initialize bridge->base.state:

drivers/gpu/drm/drm_atomic.c:drm_atomic_private_obj_init() {
	obj->name =3D kstrdup(name, GFP_KERNEL);
	if (!obj->name) {
		ret =3D -ENOMEM;
		goto err_lock_fini;
	}
}

Because drm_bridge_attach() ignores the return value of
drm_atomic_private_obj_init(), attach succeeds with bridge->base.state =3D=
=3D
NULL, causing subsequent atomic commits via
drm_atomic_add_encoder_bridges() -> drm_atomic_get_bridge_state() ->
drm_atomic_helper_bridge_duplicate_state() to trigger
WARN_ON(!bridge->base.state) and fail with -ENOMEM. Can
drm_atomic_private_obj_init() or drm_bridge_attach() handle a NULL bridge
name gracefully?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D5
