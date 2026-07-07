Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0417C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330A910EE53;
	Tue,  7 Jul 2026 16:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mMpXVMxd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8610B10EE53
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:17:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA026600C3
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E981F000E9;
 Tue,  7 Jul 2026 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783441059;
 bh=kwn489otgY2LOn+hrZoBTLpPLn/cvixHqbgtNMa8SLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mMpXVMxdlrurUzMuU7pAfa2obeMitTalkweJEK2vPZmkjmXvj2CpoM3x3pLX8UJAN
 G0kP4rkrBChEV6gr613NGp8SHlBbSeESWTqItlpQ9/86jCojdRMlWsy16gd0M9P985
 3c2i9gu7ETokPXtnG/Y843gWTNBujicjB86aUFkWj0MHU3jmC5Tw1DEThl/TEFBGIG
 RP+9Egx6SK1oSSxENG6K8HWJy3FmGSDQixguaQSCpzRaPbSmtWNFvxJZr/GZwgDj2s
 bTfdlqleoINZyDoVE3OPsz+70LsyRkZK7DN3lAoRt9ikhV1cV54hzinn79yiQ9BYr8
 ELsFB7ZIefC0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 37/37] drm/bridge: Remove legacy bridge callback support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-37-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-37-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:17:38 +0000
Message-Id: <20260707161739.46E981F000E9@smtp.kernel.org>
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

New issues:
- [High] Unconditional NULL pointer dereference for bridges missing atomic =
state callbacks.

Pre-existing issues:
- [High] Lockless modifications of `encoder->bridge_chain` and `dev->mode_c=
onfig.privobj_list` cause list corruption.
--

--- Patch [37]: [PATCH v2 37/37] drm/bridge: Remove legacy bridge callback =
support ---
commit 7f35866581b3c5c247d4a1cdd1535127f3999993
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: Remove legacy bridge callback support

This commit removes legacy bridge callback support, as all bridge drivers
are expected to have been converted to atomic variants. The private object
state is now initialized unconditionally at attach time.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 6ead9b75ae3de..6fb443984dff3 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -629,9 +624,8 @@ int drm_bridge_attach(struct drm_encoder *encoder, st=
ruct drm_bridge *bridge,
>  			goto err_reset_bridge;
>  	}
> =20
> -	if (drm_bridge_is_atomic(bridge))
> -		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> -					    &drm_bridge_priv_state_funcs);
> +	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> +				    &drm_bridge_priv_state_funcs);

[Severity: High]
Does this unconditionally crash for bridges that don't implement atomic sta=
te
callbacks?

If a bridge (like aspire_ec_bridge_funcs in
drivers/platform/arm64/acer-aspire1-ec.c) is missing .atomic_create_state,
drm_atomic_private_obj_init() will call drm_bridge_atomic_create_priv_state=
()
which blindly executes bridge->funcs->atomic_create_state(bridge).

Could this result in a NULL pointer dereference during initialization?

>  	return 0;

[ ... ]

> @@ -664,8 +658,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  	if (WARN_ON(!bridge->dev))
>  		return;
> =20
> -	if (drm_bridge_is_atomic(bridge))
> -		drm_atomic_private_obj_fini(&bridge->base);
> +	drm_atomic_private_obj_fini(&bridge->base);

[Severity: High]
This is a pre-existing issue, but does drm_bridge_detach() remove the bridge
from the encoder's bridge chain list locklessly?

Looking at drm_bridge_detach() just below this block:

	list_del(&bridge->chain_node);

It performs this deletion without acquiring encoder->bridge_chain_mutex.
Could this race with list iterations like drm_atomic_bridge_chain_disable()
that do hold the mutex?

Additionally, drm_atomic_private_obj_fini() modifies
dev->mode_config.privobj_list without synchronization. Can this cause list
corruption if a bridge driver is unbound via sysfs during active modesets?

>  	if (bridge->funcs->detach)
>  		bridge->funcs->detach(bridge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D37
