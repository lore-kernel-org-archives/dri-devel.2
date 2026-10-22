Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inhfF01t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 813D01125D2;
	Thu, 22 Oct 2026 12:48:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFF81125D2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:48:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 356B360200
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94271F000C2;
 Thu, 22 Oct 2026 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673289;
 bh=Z2abz3CdCAJip/8QDfY2tASpHpyXc0wq7A1fJhiSEA4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=inhfF01tJjY3XNd+zuGx7gzUyedysVU0Rb1op6H9HObOkkII4h/APyD0f/zGSKkWl
 3IEZMxCqjuhNn5DDqrXjaNufqVYtX225tvtQFExsSKNiQsGcWI/pX9HoVSnVek/cpm
 gpWdAsODMSznTns2m23KKbb7/pZYJaeG0xUOPa0aQnSitkdV4jH6g8aJjf3oW4129L
 idwiQvckb3ZPj3KwQBCnNIqZERHGQXFJfZ4WqYkUcyV+ZZ7z4SyiorBQpW13Rz1bwm
 CMCctOmNkRBn1yyQ3uBZYnVGcVjW4T1fZ0pY5TTAbuJG8d6Fa5yWJTycztQ8d3cG/7
 bkqu/PUns2tBQ==
Message-ID: <sashiko-outbox-181501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 58/59] drm/connector: Remove
 __drm_atomic_helper_connector_reset()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-58-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-58-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:48:09 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm: build failure from removing __drm_atomic_helper_connector_r=
eset()
--

commit ec915c4081ebec2a7cd348c5409dae402f04f843
Author: Maxime Ripard <mripard@kernel.org>

drm/connector: Remove __drm_atomic_helper_connector_reset()

This commit removes the __drm_atomic_helper_connector_reset() helper
function, its prototype, and its documentation reference after converting
connector reset hooks to atomic_create_state.

> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/=
drm_atomic_state_helper.c
> index 5efda28bb2b07..267f443306295 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -412,29 +412,6 @@ __drm_atomic_helper_connector_state_init(struct drm_=
connector_state *conn_state,
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
> =20
> -/**
> - * __drm_atomic_helper_connector_reset - reset state on connector
> - * @connector: drm connector
> - * @conn_state: connector state to assign
> - *
> - * Initializes the newly allocated @conn_state and assigns it to
> - * the &drm_connector->state pointer of @connector, usually required when
> - * initializing the drivers or when called from the &drm_connector_funcs=
.reset
> - * hook.
> - *
> - * This is useful for drivers that subclass the connector state.
> - */
> -void
> -__drm_atomic_helper_connector_reset(struct drm_connector *connector,
> -				    struct drm_connector_state *conn_state)
> -{
> -	if (conn_state)
> -		__drm_atomic_helper_connector_state_init(conn_state, connector);
> -
> -	connector->state =3D conn_state;
> -}
> -EXPORT_SYMBOL(__drm_atomic_helper_connector_reset);

[Severity: Medium]
Does removing __drm_atomic_helper_connector_reset() in
drivers/gpu/drm/drm_atomic_state_helper.c and its prototype in
include/drm/drm_atomic_state_helper.h cause a build regression when
CONFIG_DRM_MALI_DISPLAY, CONFIG_DRM_RCAR_WRITEBACK (under
CONFIG_DRM_RCAR_DU), or CONFIG_DRM_VMWGFX is enabled?

The commit message states that all drivers implementing the connector reset
hook using __drm_atomic_helper_connector_reset() have been converted to
atomic_create_state, but three in-tree drivers still call
__drm_atomic_helper_connector_reset() from their drm_connector_funcs.reset
callbacks.

In drivers/gpu/drm/arm/malidp_mw.c:malidp_mw_connector_reset():

	if (mw_state)
		__drm_atomic_helper_connector_reset(connector, &mw_state->base);

In drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c:rcar_du_wb_conn_rese=
t():

	state =3D kzalloc_obj(*state);
	if (state =3D=3D NULL)
		return;

	__drm_atomic_helper_connector_reset(connector, &state->state);

In drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:vmw_du_connector_reset():

	vcs =3D kzalloc_obj(*vcs);

	if (!vcs) {
		DRM_ERROR("Cannot allocate vmw_connector_state\n");
		return;
	}

	__drm_atomic_helper_connector_reset(connector, &vcs->base);

None of these three drivers are converted in the subsequent patch in the
series, commit 86331e69eb719274bf362ebe2870d757866546bb ("drm/connector:
Remove reset").

Should malidp_mw_connector_reset(), rcar_du_wb_conn_reset(), and
vmw_du_connector_reset() be converted to atomic_create_state before
__drm_atomic_helper_connector_reset() is removed so that building those
drivers does not fail with implicit function declaration and undefined
symbol errors?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D58
