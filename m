Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4A8CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3530F893ED;
	Thu, 15 Oct 2026 15:56:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6988310EC16
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:56:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C51A601EF
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292481F000C4;
 Thu, 15 Oct 2026 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792079782;
 bh=geSppEnyrS4XctjEv4hYmL1bh9OfzdwVLpBkSwqc2rs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RYQ9OtuIymQT4QCdxp+c6qX3SzX3Rc7C+fGToQTGNrYX98tWHwkntcOlubfyoPV8G
 qczV5n9tvyXOIFIQkDL4ZKPsE+jtkvLGWamFkvg3da+S1W0qrVgKrjM8JIXG5N/faU
 rB8eaGMaq1X/Ovmw8YIZw0nwuVYSoSpJr6B1ML4DL4yfbRAIpXDH7sMvDVid7x6+95
 mneyXOlei9Bza/mbGFN+w9tXOxvnm8QfML3wj4aMGbc/iQlSNknG6A2MGVm6kfZPL2
 nnURvmGK4/U87mOjLDqoStRwAkooYYQiavB/PqD9YZnW7HKu83rEBufV8txCFxVtiP
 D4Wfz7KFeZtPQ==
Message-ID: <sashiko-outbox-173116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/28] drm/atomic_sro: Add function to install state
 into drm objects
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-9-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-9-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:56:21 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm: NULL pointer dereference in drm_atomic_sro_state_free() on er=
ror path
- [High] drm: state corruption due to destroying object state before checki=
ng replacement
- [High] drm: heap OOB read and O(N^2) loop in drm_atomic_sro_install_state
- [Medium] drm: memory leak of uninstalled private states due to count zero=
ing
- [Medium] drm: connector reference leak when state installation is skipped
--

commit e822513db05b3712029cac237b3eaca7c2373096
Author: Maxime Ripard <mripard@kernel.org>
Subject: drm/atomic_sro: Add function to install state into drm objects

Introduces drm_atomic_sro_install_state() to assign SRO readout states to
KMS objects. It also adds an atomic_sro_install_state hook in the plane,
CRTC, connector, and private object function vtables.

> diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomi=
c_sro.c
> index 6921af73eb697..14fddd7601658 100644
> --- a/drivers/gpu/drm/drm_atomic_sro.c
> +++ b/drivers/gpu/drm/drm_atomic_sro.c
[ ... ]
> @@ -548,3 +549,145 @@ void drm_atomic_sro_set_private_obj_state(struct dr=
m_atomic_sro_state *state,
> +void drm_atomic_sro_install_state(struct drm_atomic_sro_state *state)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < state->dev->mode_config.num_connector; i++) {
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this loop condition risk a heap out-of-bounds read? If objects are add=
ed
dynamically between drm_atomic_sro_state_alloc() and here, the loop bound w=
ill
exceed the allocated array size.

> +		const struct drm_connector_funcs *conn_funcs;
> +		struct drm_connector_state *conn_state;
> +		struct drm_connector *conn;
> +
> +		conn =3D state->connectors[i].ptr;
> +		if (!conn)
> +			continue;
> +
> +		conn_funcs =3D conn->funcs;
> +		if (!conn_funcs)
> +			continue;
                 ^^^^^^^^

[Severity: High]
Can this defensive continue lead to a NULL pointer dereference later?
If we skip installation here, the connector is left in the state array.
When drm_atomic_sro_state_free() is subsequently called to clean up
uninstalled states, it checks if conn and conn_state are present but
unconditionally dereferences conn->funcs:

drm_atomic_sro_state_free()
	if (!conn || !conn_state)
		continue;
	conn->funcs->atomic_destroy_state(conn, conn_state);

This would panic because conn->funcs was NULL.

> +
> +		if (conn->state) {
> +			conn_funcs->atomic_destroy_state(conn, conn->state);
> +			conn->state =3D NULL;
> +		}
> +
> +		conn_state =3D state->connectors[i].state;
> +		if (!conn_state)
> +			continue;
                 ^^^^^^^^

[Severity: High]
Does this logic leave the connector in a corrupted state if conn_state is
missing? The existing valid state is destroyed and set to NULL just before
this check. If we continue here, the object is left permanently with a NULL
state pointer.

[Severity: Medium]
Additionally, does continuing here skip the drm_connector_put(conn) at the
end of the loop body? If so, when drm_atomic_sro_state_free() is later invo=
ked,
it skips its cleanup block because it checks if (!conn || !conn_state),
bypassing drm_connector_put(conn) again and leaking the connector reference.

> +
> +		if (conn_funcs->atomic_sro_install_state)
> +			conn_funcs->atomic_sro_install_state(conn, conn_state);
> +
> +		conn->state =3D conn_state;
> +		state->connectors[i].state =3D NULL;
> +		state->connectors[i].ptr =3D NULL;
> +		drm_connector_put(conn);
> +	}
[ ... ]
> +	for (i =3D 0; i < count_private_obj(state->dev); i++) {
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Similar to the connector loop, does using count_private_obj() dynamically
risk a heap out-of-bounds read if a private object is added after allocatio=
n?

Also, since count_private_obj() traverses the list on each iteration, doesn=
't
this result in an O(N^2) complexity loop?

[ ... ]
> +	}
> +	state->num_private_objs =3D 0;
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Does zeroing this counter cause a memory leak of uninstalled private states?

If a private object fails to install during hardware state readout, it rema=
ins
in the state->private_objs array. By setting the counter to 0 here,
drm_atomic_sro_state_free() will bypass its cleanup loop entirely:

drm_atomic_sro_state_free()
	for (i =3D 0; i < state->num_private_objs; i++) {
		...

This would permanently leak any uninstalled private object states.

> +}
> +EXPORT_SYMBOL(drm_atomic_sro_install_state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D9
