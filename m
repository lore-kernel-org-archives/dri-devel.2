Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7859606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr5hWgfR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268E4112D6B;
	Fri,  6 Nov 2026 13:33:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13F8112D6B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35D0A601BF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF651F0089F;
 Fri,  6 Nov 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972006;
 bh=91WPCTMTURhFd1rmronRkKC0V4XnM5tXBAJyCtSHYfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jr5hWgfRtvistS7tlO2oDsZs+80clOwOovLxZkWb/wQYfoPZ3PEl3ccvXjISnhR3B
 v//0LA35ywsXKbSmIVPbsX81u+f7cqDXlsdlNBlaFPif7eibAXJb3cIwSIFzfkOJet
 gEOtUICIDTigYhBiM/+FxBVwKbsUeJu1C7k9Us3NOf7dHIjz2l3ERcip7L7w1gGy2n
 mebqY07Cc1UeSPRbDu+vLO6W2kZAwSqF0Su8C78bKxbSJbyofxTIblmNBhAZHtKWnA
 IBn9bTMPmBmz3IYO1ybzBNdmWpOqb7GO8j7zgyFjPLn36WGMe0bj2wxgLvfimfmUv0
 nrOlAPwpPFfpg==
Message-ID: <sashiko-outbox-201475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/39] drm/bridge: Handle bridges with hardware state
 readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-18-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-18-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:33:26 +0000
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
- [Medium] drm/bridge: missing bridge detach on init failure in
  drm_bridge_attach()
--

commit 0fb1d1b23ec990c1a040f81e5f14e9c95302ae67
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: Handle bridges with hardware state readout

This commit adds hardware state readout support for DRM bridges by
providing a private state readout callback and a dedicated
drm_private_state_funcs table for bridges implementing
atomic_sro_readout_state.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index b6cdbc172f689..c0224dcc8aa50 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c

[ ... ]

> @@ -677,8 +760,17 @@ int drm_bridge_attach(struct drm_encoder *encoder, s=
truct drm_bridge *bridge,
>  			goto err_reset_bridge;
>  	}
> =20
> -	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
> -				    &drm_bridge_priv_state_funcs);
> +	if (bridge->funcs &&
> +	    bridge->funcs->atomic_sro_readout_state)
> +		ret =3D drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> +						  bridge->name,
> +						  &drm_bridge_priv_state_funcs_with_sro);
> +	else
> +		ret =3D drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> +						  bridge->name,
> +						  &drm_bridge_priv_state_funcs);
> +	if (ret)
> +		goto err_reset_bridge;
> =20
>  	return 0;

[Severity: Medium]
Does jumping to err_reset_bridge when drm_atomic_private_obj_init() fails
leave bridge->funcs->attach() un-undone?

bridge->funcs->attach() has already succeeded at this point, and
err_reset_bridge unlinks bridge->chain_node and clears bridge->dev and
bridge->encoder without calling bridge->funcs->detach(bridge):

drivers/gpu/drm/drm_bridge.c:drm_bridge_attach() {
    ...
	if (bridge->funcs->attach) {
		ret =3D bridge->funcs->attach(bridge, encoder, flags);
		if (ret < 0)
			goto err_reset_bridge;
	}
    ...
err_reset_bridge:
	bridge->dev =3D NULL;
	bridge->encoder =3D NULL;
	mutex_lock(&encoder->bridge_chain_mutex);
	list_del(&bridge->chain_node);
	mutex_unlock(&encoder->bridge_chain_mutex);
    ...
}

Because the bridge is removed from encoder->bridge_chain, subsequent
drm_encoder_cleanup() will not detach it either, leaking or leaving
dangling whatever bridge->funcs->attach() registered (such as connectors,
DP AUX channels, or downstream bridges).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D18
