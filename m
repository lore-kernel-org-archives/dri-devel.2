Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E649606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VauuwfZs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79856112D7D;
	Fri,  6 Nov 2026 13:36:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F59112D7D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:35:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56FF1601E3
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5C21F0089F;
 Fri,  6 Nov 2026 13:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972156;
 bh=Qbm5eIH2JVZxrFZqmIJMKs0/XTsI42FLQxhLjpHeC5o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VauuwfZsWHEUdDLiXJKehu4vro/K7PoAiFQ7DmNXVoGihZtDc1qavkxqdLsgbaKtb
 C6usNMWKvvqOH0A9S3UqZK1W1TkrV+eZandJatctHmG/sHEcnyOOyofeK3xWMCQ01R
 OvBxVO8ZkZxyuo7M90SVzNVCwyll9YzG/ueAPUmaOcw7JfK8Z/jKAdpMWEeG1+fg8n
 KZgC0gFciAbBxYDpdAYQQCFTFwgwszi4AIKpyqe0KUz9GPkyxEzubGe+OmTND8f8ww
 Xf+qEA12knDHebFLAuMagLmbCfQDD3NNCGi6ts4l+QqBp530u85SnM0cvggmteZMFr
 0T97ZHGAUyTqA==
Message-ID: <sashiko-outbox-201479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/39] drm/atomic: Add drm_private_obj name
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-7-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-7-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:35:55 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/atomic: leak and uninitialized state if
  drm_atomic_private_obj_init() fails
--

commit f4a0998ec2ff1c620aa6e4e7d195fce0e092e47a
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Add drm_private_obj name

This commit adds a human-readable name field to struct drm_private_obj,
initialized via drm_atomic_private_obj_init() and updated via
drm_atomic_private_obj_set_name(), and updates callers to provide a name.

[ ... ]

> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/di=
splay/drm_dp_tunnel.c
> index d29ad4116e641..5f30f82b2ebb2 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -389,6 +389,14 @@ lookup_or_alloc_group(struct drm_dp_tunnel_mgr *mgr,=
 u8 drv_group_id)
>  		 tunnel_group_drv_id(drv_group_id) & ((1 << DP_GROUP_ID_BITS) - 1),
>  		 tunnel_group_id(drv_group_id) & ((1 << DP_USB4_DRIVER_ID_BITS) - 1));
> =20
> +	/*
> +	 * The private object was named after the group index when it
> +	 * was initialized, since the group identifier wasn't known
> +	 * yet. Refresh it now that we have one. The name is only used
> +	 * for debug messages, so ignore any allocation failure.
> +	 */
> +	drm_atomic_private_obj_set_name(&group->base, group->name);
> +
>  	return group;
>  }
> =20
> @@ -1727,11 +1735,22 @@ EXPORT_SYMBOL(drm_dp_tunnel_atomic_get_new_state);
> =20
>  static bool init_group(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_tunn=
el_group *group)
>  {
> +	char name[32];
> +
>  	group->mgr =3D mgr;
>  	group->available_bw =3D -1;
>  	INIT_LIST_HEAD(&group->tunnels);
> =20
> -	drm_atomic_private_obj_init(mgr->dev, &group->base,
> +	/*
> +	 * The group identifier, and thus the group name, is only known
> +	 * once a tunnel has been added to the group. Name the private
> +	 * object after the group index until then,
> +	 * lookup_or_alloc_group() will refresh it.
> +	 */
> +	snprintf(name, sizeof(name), "dp-tunnel-group-%d",
> +		 (int)(group - mgr->groups));
> +
> +	drm_atomic_private_obj_init(mgr->dev, &group->base, name,
>  				    &tunnel_group_funcs);
> =20
>  	return true;
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index a1f18fc96b4ca..63647dd3204f6 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1048,6 +1048,7 @@ static void drm_atomic_plane_print_state(struct drm=
_printer *p,
>   * drm_atomic_private_obj_init - initialize private object
>   * @dev: DRM device this object will be attached to
>   * @obj: private object
> + * @name: human-readable name for debug messages
>   * @funcs: pointer to the struct of function pointers that identify the =
object
>   * type
>   *
> @@ -1059,6 +1060,7 @@ static void drm_atomic_plane_print_state(struct drm=
_printer *p,
>   */
>  int drm_atomic_private_obj_init(struct drm_device *dev,
>  				struct drm_private_obj *obj,
> +				const char *name,
>  				const struct drm_private_state_funcs *funcs)
>  {
>  	struct drm_private_state *state;
> @@ -1077,6 +1079,12 @@ int drm_atomic_private_obj_init(struct drm_device =
*dev,
> =20
>  	obj->dev =3D dev;
>  	obj->funcs =3D funcs;
> +	obj->name =3D kstrdup(name, GFP_KERNEL);
> +	if (!obj->name) {
> +		ret =3D -ENOMEM;
> +		goto err_lock_fini;
> +	}
> +
>  	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
> =20
>  	state =3D obj->funcs->atomic_create_state(obj);
> @@ -1091,6 +1099,9 @@ int drm_atomic_private_obj_init(struct drm_device *=
dev,
> =20
>  err_list_del:
>  	list_del_init(&obj->head);
> +	kfree(obj->name);
> +	obj->name =3D NULL;
> +err_lock_fini:
>  	drm_modeset_lock_fini(&obj->lock);
>  	return ret;
>  }
> @@ -1118,6 +1129,7 @@ drm_atomic_private_obj_fini(struct drm_private_obj =
*obj)
> =20
>  	list_del_init(&obj->head);
>  	obj->funcs->atomic_destroy_state(obj, obj->state);
> +	kfree(obj->name);
>  	drm_modeset_lock_fini(&obj->lock);
>  }
>  EXPORT_SYMBOL(drm_atomic_private_obj_fini);
> @@ -1151,6 +1163,37 @@ static int drm_atomic_commit_set_private_obj_state=
(struct drm_atomic_commit *com
>  	return 0;
>  }
> =20
> +/**
> + * drm_atomic_private_obj_set_name - update the name of a private object
> + * @obj: private object
> + * @name: new human-readable name for debug messages
> + *
> + * Replaces the name of @obj previously set at
> + * drm_atomic_private_obj_init() time. This is meant for callers that
> + * only get a meaningful name well after the object has been
> + * initialized.
> + *
> + * RETURNS:
> + * Zero on success, a negative error code on allocation failure. The
> + * name is only used for debug messages, so callers can safely ignore
> + * the return value.
> + */
> +int drm_atomic_private_obj_set_name(struct drm_private_obj *obj,
> +				    const char *name)
> +{
> +	char *new_name;
> +
> +	new_name =3D kstrdup(name, GFP_KERNEL);
> +	if (!new_name)
> +		return -ENOMEM;
> +
> +	kfree(obj->name);
> +	obj->name =3D new_name;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_atomic_private_obj_set_name);

[Severity: Medium]
Can this leak obj->name or dereference a NULL obj->state when
drm_atomic_private_obj_init() fails in init_group()?

init_group() ignores the return value of drm_atomic_private_obj_init() and
returns true.  If kstrdup() or atomic_create_state() fails, group->base is
left with an empty obj->head and obj->state set to NULL.  When a tunnel is
later added to the group, lookup_or_alloc_group() calls
drm_atomic_private_obj_set_name(), which allocates a new obj->name even
though obj->head is empty, and cleanup_group() ->
drm_atomic_private_obj_fini() returns early on list_empty(&obj->head)
without freeing obj->name.  Duplicating the group's atomic state in
tunnel_group_duplicate_state() will also dereference the NULL obj->state.

Also, drm_atomic_private_obj_fini() does not reset obj->name to NULL after
kfree(obj->name), leaving a dangling pointer if the object is inspected or
renamed after finalization.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D7
