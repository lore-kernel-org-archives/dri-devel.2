Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636D4CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417A510E3A4;
	Thu, 15 Oct 2026 15:41:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B580610E28E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:41:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 695BD408E1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DABA1F000C4;
 Thu, 15 Oct 2026 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792078882;
 bh=XA2t6w+BUSrtJbEmBrIdFa9fvjLSKvlH+IbWQ+2ttw8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gxwVk2YndHYCR1igJhxX+OFuNbSR0wIisYp90n7nRYF6VAcq7X9jlVGIN913wRJce
 g+8HtihcJoWqgcKMh8oifWXjARbh7NGDjZzeI1X/hd9DNDF8r3wtdRtSpjUR9ezYJS
 jvUHyvj97Qep7TmUeU3UbZvkygt7Y1ZZYLLtuTNx/NDTaIEUxTJ6r2rS10SLe1bD3L
 OfDqOPvZmj9X5FUJKVqci7E68X4Uo8+sLyemttsyDNMDNwN8mnA39srFHhvY2ASMkQ
 hoWEezSy/0zV1Axm0XHWDRZtVHbypcGs+IvJ4A5NQ+R9f0G2uK56PICKRV06qfsMHn
 zM0D7Wcm9mayg==
Message-ID: <sashiko-outbox-173085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/28] drm/atomic_sro: Create drm_atomic_sro_state
 container
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-6-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-6-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:41:21 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/atomic_sro: heap out-of-bounds array access due to sparse conn=
ector IDA
- [Medium] drm: connector reference leak in drm_atomic_sro_state_free() whe=
n conn_state is NULL
- [Low] drm: incorrect error code -EINVAL on OOM in drm_atomic_sro_state_al=
loc()
--

commit 7fa33b0c7c68e508f3bb44a6225923e6e800d132
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Create drm_atomic_sro_state container

The SRO infrastructure needs a state container to collect the readout states
for all KMS objects. Unlike drm_atomic_commit which tracks old and new stat=
es
for atomic commits, this container only holds a single state per object. Th=
is
commit creates struct drm_atomic_sro_state with arrays for planes, CRTCs,
connectors, and private objects.

> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomi=
c_sro.c
> new file mode 100644
> index 0000000000000..096fdb7088190
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_sro.c
[ ... ]
> +static int drm_atomic_sro_state_init(struct drm_device *dev,
> +				     struct drm_atomic_sro_state *state)
> +{
> +	int err;
> +
> +	state->planes =3D
> +		kzalloc_objs(*state->planes, dev->mode_config.num_total_plane);
> +	if (!state->planes)
> +		return -ENOMEM;
> +
> +	state->crtcs =3D kzalloc_objs(*state->crtcs, dev->mode_config.num_crtc);
> +	if (!state->crtcs) {
> +		err =3D -ENOMEM;
> +		goto err_free_planes;
> +	}
> +
> +	state->connectors =3D kzalloc_objs(*state->connectors,
> +					 dev->mode_config.num_connector);

[Severity: High]
Does allocating the array using num_connector account for sparse IDA indice=
s?
Connector indices are allocated dynamically and can exceed the active
connector count if connectors are hotplugged or removed. Using num_connector
as the size limits the array, which may cause out-of-bounds access when
indexed directly.

> +	if (!state->connectors) {
> +		err =3D -ENOMEM;
> +		goto err_free_crtcs;
> +	}
> +
> +	state->private_objs =3D
> +		kzalloc_objs(*state->private_objs, count_private_obj(dev));
> +	if (!state->private_objs)  {
> +		err =3D -ENOMEM;
> +		goto err_free_connectors;
> +	}
> +
> +	state->num_private_objs =3D 0;
> +
> +	drm_dev_get(dev);
> +	state->dev =3D dev;
> +
> +	return 0;
> +
> +err_free_connectors:
> +	kfree(state->connectors);
> +err_free_crtcs:
> +	kfree(state->crtcs);
> +err_free_planes:
> +	kfree(state->planes);
> +	return err;
> +}
> +
> +/**
> + * drm_atomic_sro_state_alloc - allocate an SRO state container
> + * @dev: DRM device to allocate the state for
> + *
> + * Allocates and initializes a &struct drm_atomic_sro_state that can hold
> + * readout states for all KMS objects on @dev.
> + *
> + * The returned state must be freed with drm_atomic_sro_state_free().
> + *
> + * RETURNS:
> + *
> + * A new &struct drm_atomic_sro_state on success, an error pointer on
> + * failure.
> + */
> +struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_devic=
e *dev)
> +{
> +	struct drm_atomic_sro_state *state;
> +	int ret;
> +
> +	state =3D kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-EINVAL);

[Severity: Low]
Should this return -ENOMEM instead of -EINVAL when memory allocation fails?

> +
> +	ret =3D drm_atomic_sro_state_init(dev, state);
> +	if (ret) {
> +		kfree(state);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return state;
> +}
> +EXPORT_SYMBOL(drm_atomic_sro_state_alloc);
> +
> +/**
> + * drm_atomic_sro_state_free - free an SRO state container
> + * @state: SRO state to free
> + *
> + * Frees a &struct drm_atomic_sro_state previously allocated with
> + * drm_atomic_sro_state_alloc().
> + */
> +void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state)
> +{
> +	struct drm_device *dev =3D state->dev;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < state->num_private_objs; i++) {
> +		struct drm_private_obj *obj =3D state->private_objs[i].ptr;
> +		struct drm_private_state *obj_state =3D state->private_objs[i].state;
> +
> +		if (!obj || !obj_state)
> +			continue;
> +
> +		obj->funcs->atomic_destroy_state(obj, obj_state);
> +		state->private_objs[i].state =3D NULL;
> +		state->private_objs[i].ptr =3D NULL;
> +	}
> +
> +	kfree(state->private_objs);
> +
> +	for (i =3D 0; i < state->dev->mode_config.num_connector; i++) {

[Severity: High]
Does iterating up to the live num_connector cause out-of-bounds reads?
Since num_connector can increase after the SRO state was allocated if
connectors are added, this loop might read past the end of the originally
allocated state->connectors array.

> +		struct drm_connector *conn =3D state->connectors[i].ptr;
> +		struct drm_connector_state *conn_state =3D
> +			state->connectors[i].state;
> +
> +		if (!conn || !conn_state)
> +			continue;

[Severity: Medium]
Does this skip drm_connector_put() and leak the reference if conn is valid =
but
conn_state is NULL?=20
In drm_atomic_sro_set_connector_state(), drm_connector_get() unconditionally
takes a reference on conn and stores it. If conn_state is NULL during clean=
up,
the early continue bypasses drm_connector_put() completely.

> +
> +		conn->funcs->atomic_destroy_state(conn, conn_state);
> +		state->connectors[i].state =3D NULL;
> +		state->connectors[i].ptr =3D NULL;
> +		drm_connector_put(conn);
> +	}
> +
[ ... ]
> +/**
> + * drm_atomic_sro_set_connector_state - store a connector state into an =
SRO state
> + * @state: SRO state container
> + * @conn: connector the state belongs to
> + * @conn_state: connector state to store
> + *
> + * Takes a reference on @conn which is released when the state is
> + * installed or freed.
> + */
> +void drm_atomic_sro_set_connector_state(struct drm_atomic_sro_state *sta=
te,
> +					struct drm_connector *conn,
> +					struct drm_connector_state *conn_state)
> +{
> +	unsigned int index =3D drm_connector_index(conn);
> +
> +	drm_connector_get(conn);
> +	state->connectors[index].ptr =3D conn;

[Severity: High]
Can this write out of bounds?
Since the connectors array was allocated using num_connector rather than
accommodating sparse indices, a connector with an index greater than or equ=
al
to num_connector will cause this write to overwrite heap memory.

> +	state->connectors[index].state =3D conn_state;
> +
> +	drm_dbg_atomic(conn->dev,
> +		       "Added [CONNECTOR:%d:%s] %p state to readout state %p\n",
> +		       conn->base.id, conn->name, conn_state, state);
> +}
> +EXPORT_SYMBOL(drm_atomic_sro_set_connector_state);
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D6
