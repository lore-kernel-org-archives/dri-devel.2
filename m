Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501CECC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9DB10EAAC;
	Wed, 14 Oct 2026 18:16:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BCB10FF41
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:16:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F99E60229
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C801F000C4;
 Wed, 14 Oct 2026 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792001800;
 bh=h1PiXM+ciMdfIt9Ic+pVLyHmvXg6rlUePHHhzR+BbpM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jeeeaPjQHSYV1A2HwIY0YJiLlAAZESbJDKnXuBOiAm1w0E8noEXPtlmoXczWUkIP9
 yr5Xoyo7DHkqRBl5CY7h2kfwpOyDhmRmh3BuqlUK8vPhXXuVbLVO4lQYGPP7t4OmhC
 VPqaJaAiWNaxSxW5QJhOrjIvZrNdKwU2s6/pmEsT8brzGY6/Y7T+062sPgF3pwTrC7
 UWm8fC10QdSQoCCyiHu2odihoWZT9PNiufapfMReBiQPBVRuUj0qr/H8XbEH+vu0xj
 MI2sdektRsw9GxrgDTLB34vHvXijyvmxaqCRUYigCv6MRJB6IwlpBMMiFIWL87ANzN
 Uaead3MPSrGvA==
Message-ID: <sashiko-outbox-171687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 66/75] drm/amdgpu: dm: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 18:16:40 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/amdgpu: memory leak and ERR_PTR dereference in dm_dp_add_mst_c=
onnector()
- [High] drm/amdgpu: early return on OOM skips mandatory connector initiali=
zation
--

commit 7f186f384d1ae8ab956532945397b878e65c8386
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu: dm: Convert to atomic_create_state

The amdgpu_dm connector reset implementation creates a custom state
subclass, but only initializes a pristine state without resetting any
hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 3a4e98b08ac1f..2c22f00f521c6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
[ ... ]
> @@ -3199,8 +3195,16 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.
>  	 */
> -	if (aconnector->base.funcs->reset)
> -		aconnector->base.funcs->reset(&aconnector->base);
> +	if (!aconnector->base.state &&
> +	    aconnector->base.funcs->atomic_create_state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state =3D aconnector->base.funcs->atomic_create_state(&aconnector=
->base);
> +		if (IS_ERR(conn_state))
> +			return;

[Severity: High]
If memory allocation fails during atomic_create_state() and we return early
here, does it skip mandatory connector initialization?

Since amdgpu_dm_connector_init_helper() returns void, the caller
amdgpu_dm_connector_init() is unaware of the failure and continues executio=
n.
It subsequently calls amdgpu_dm_initialize_dp_connector(), which
unconditionally dereferences aconnector->dc_link->ddc.

Since aconnector->dc_link assignment is skipped in the aborted helper, could
this result in a NULL pointer dereference?

[ ... ]
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index a5b15bef8aa0a..cb189c098ec3e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
[ ... ]
> @@ -738,7 +738,7 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mg=
r *mgr,
>  	 * Initialize connector state before adding the connectror to drm and
>  	 * framebuffer lists
>  	 */
> -	amdgpu_dm_connector_funcs_reset(connector);
> +	connector->state =3D amdgpu_dm_connector_atomic_create_state(connector);

[Severity: High]
Can this overwrite the connector->state pointer and leak the previously
allocated state?

Earlier in dm_dp_add_mst_connector(), amdgpu_dm_connector_init_helper() is
called, which allocates and initializes a new connector state and assigns it
to connector->state. Overwriting it here appears to drop custom properties
attached to the state in the interim (such as max_requested_bpc set by
drm_connector_attach_max_bpc_property).

Additionally, amdgpu_dm_connector_atomic_create_state() can return
ERR_PTR(-ENOMEM) on allocation failure. Because this is directly assigned to
connector->state without an IS_ERR() check, will the DRM core subsequently
dereference this error pointer?

> =20
>  	drm_dp_mst_get_port_malloc(port);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D66
