Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE1CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132FA10E3AF;
	Thu, 15 Oct 2026 15:46:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C88A10F256
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:46:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 827B760120
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD761F000C4;
 Thu, 15 Oct 2026 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792079206;
 bh=1Zwne6JgzrNbtn6VSDLZbLiRmS89pPgledmjjbWNeo4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SdDC69WK3WcmppM2D6BbWm+uupb9whiLfWwt62VxCuQxJytpCsMxiNtbitCwyaiHa
 pu/Tfvf0IMb0hhjN5QI/x0kDUB6bW5NBSnR05chnsIzDAkRst1JxqgZUdVpJ+YC7mP
 6Mc25Ew6QCTv3L3B8X05L0jutONe1pZXn73tb9MoSq6kB02b5GCX2kpNGwlFVDQEC9
 kYnvYNqACXsP2fns4kEo2eDFN67gvJh+LjlxvhS43XpMXAz0e0oI+dpj3+HboU1m6m
 +h00Q3/XfTSHklguQc2vAyDF5txkZOaBtMiUda+k3XYPCOZq9U7IR/IX12k9LhNPmr
 HJsPYb68a/Y7g==
Message-ID: <sashiko-outbox-173096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/28] drm/atomic_sro: Create kernel parameter to
 force or disable readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-7-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-7-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:46:45 +0000
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
- [High] drm: heap out-of-bounds write in drm_atomic_sro_set_private_obj_st=
ate
- [High] drm: OOB read/write in drm_atomic_sro_state_free due to dynamic nu=
m_connector
- [High] drm: heap out-of-bounds write in drm_atomic_sro_set_connector_stat=
e()
--

commit 7fa33b0c7c68e508f3bb44a6225923e6e800d132
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Create drm_atomic_sro_state container

The SRO infrastructure needs a state container to collect the readout states
for all KMS objects. Unlike drm_atomic_commit which tracks old and new
states for atomic commits, this container only holds a single state per
object: the one read out from the hardware. Create struct
drm_atomic_sro_state with arrays for planes, CRTCs, connectors, and private
objects, along with accessors to get and set individual object states within
it.

> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomi=
c_sro.c
> new file mode 100644
> index 0000000000000..096fdb7088190
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_sro.c

[ ... ]

> +void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state)
> +{
> +	struct drm_device *dev =3D state->dev;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < state->num_private_objs; i++) {
> +		struct drm_private_obj *obj =3D state->private_objs[i].ptr;

[ ... ]

> +	kfree(state->private_objs);
> +
> +	for (i =3D 0; i < state->dev->mode_config.num_connector; i++) {
> +		struct drm_connector *conn =3D state->connectors[i].ptr;
> +		struct drm_connector_state *conn_state =3D
> +			state->connectors[i].state;
> +
> +		if (!conn || !conn_state)
> +			continue;
> +
> +		conn->funcs->atomic_destroy_state(conn, conn_state);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this code read past the end of the state->connectors[] array?

Because the loop uses the potentially updated
state->dev->mode_config.num_connector as its upper bound, what happens if a
concurrent hotplug (e.g. DP MST) increases num_connector between the
array's allocation and this free operation?

It seems this could dereference uninitialized memory.

> +		state->connectors[i].state =3D NULL;
> +		state->connectors[i].ptr =3D NULL;
> +		drm_connector_put(conn);
> +	}
> +
> +	kfree(state->connectors);

[ ... ]

> +void drm_atomic_sro_set_connector_state(struct drm_atomic_sro_state *sta=
te,
> +					struct drm_connector *conn,
> +					struct drm_connector_state *conn_state)
> +{
> +	unsigned int index =3D drm_connector_index(conn);
> +
> +	drm_connector_get(conn);
> +	state->connectors[index].ptr =3D conn;
> +	state->connectors[index].state =3D conn_state;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Can this code write out of bounds for state->connectors[]?

Since the array is sized by dev->mode_config.num_connector, but accessed
here using the sparse IDA-allocated drm_connector_index(conn), what happens
if a connector is dynamically removed (e.g. unplugging an MST display)?

If num_connector is decremented but the remaining connectors retain their
higher IDA indices, won't index exceed the allocated array capacity?

> +
> +	drm_dbg_atomic(conn->dev,
> +		       "Added [CONNECTOR:%d:%s] %p state to readout state %p\n",
> +		       conn->base.id, conn->name, conn_state, state);
> +}

[ ... ]

> +void drm_atomic_sro_set_private_obj_state(struct drm_atomic_sro_state *s=
tate,
> +					  struct drm_private_obj *obj,
> +					  struct drm_private_state *obj_state)
> +{
> +	unsigned int index =3D state->num_private_objs;
> +
> +	state->private_objs[index].ptr =3D obj;
> +	state->private_objs[index].state =3D obj_state;
> +	state->num_private_objs +=3D 1;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this code overflow state->private_objs[]?

Since state->private_objs[] is allocated in drm_atomic_sro_state_init()
strictly based on the lockless count_private_obj(dev) snapshot, what
happens if the number of private objects dynamically increases before
readout?

There doesn't seem to be a capacity check to ensure index doesn't exceed
the allocated size if a driver calls this for dynamically created private
objects.

> +
> +	drm_dbg_atomic(state->dev,
> +		       "Added new private object %p state %p to readout state %p\n", o=
bj,
> +		       obj_state, state);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D7
