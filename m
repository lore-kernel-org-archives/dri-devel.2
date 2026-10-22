Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C660A5BE3
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGlQNmbO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D31B112633;
	Thu, 22 Oct 2026 13:47:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F96112633
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:47:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E552431DF;
 Thu, 22 Oct 2026 13:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FEA1F000C1;
 Thu, 22 Oct 2026 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792676866;
 bh=OxxKOH7t6FGURuJlztIT2JeBLZQD+0wcCCE6Y7WLeZw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UGlQNmbO1kSZCqA3+rn17josT3C3IhTMDY1pDLco957Sh+CXl2Q+ENuCrEHkRLSb9
 aKGMkqCrNEo7AIKWq+/K1yFQpGdZzkw0McDwmsoI6l1zDHniLStY4DTqALu9tgNi8Y
 g7iSJf4dTwOii7tOZ6+uNz0l0s8wvZsGBXRWwIggDpV7IFdiTFviehpIs5GKXwdpmM
 84E4PQjI6bvs5oTTZEGjQUve9eT5Du8Nl1tzKgSdo5OdkDWXMaOtWDCdbx7XIaPFdw
 xJrYUau5m0R0BO5vHluXtL4bu8DG2MgxoD9RWM2BAvYJLLqgu2SdXfuHkMGMdjUfuj
 +4oe0EDDiDP0w==
Message-ID: <sashiko-outbox-181583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261022132259.240717-7-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 13:47:46 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/tegra: unlocked drm_bridge_get_current_state() call in tegra_r=
gb_encoder_enable()
--

commit 743a0ce150c28976e990ee80b4eaf7239b83fcc3
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: rgb: Parameterize configuration based on bus flags

This commit updates tegra_rgb_encoder_enable() to read bus flags from the
bridge state and configure pixel clock polarity, display enable polarity,
and data alignment accordingly.

> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index b6d09a8d8e5ea..da9e37fe36689 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c

[ ... ]

> @@ -104,14 +105,24 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder)
>  	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_rgb *rgb =3D to_rgb(output);
> -	u32 value;
> +	struct drm_bridge_state *bridge_state;
> +	u32 bus_flags, value;
> +
> +	/* Get but flags from the bridge state. */
> +	bridge_state =3D drm_bridge_get_current_state(output->bridge);
> +	if (bridge_state)
> +		bus_flags =3D bridge_state->input_bus_cfg.flags;
> +	else
> +		bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +			    DRM_BUS_FLAG_DE_HIGH |
> +			    DRM_BUS_FLAG_DATA_MSB_TO_LSB;

[Severity: High]
Is it safe to call drm_bridge_get_current_state() from
tegra_rgb_encoder_enable() during a non-blocking atomic commit?

In include/drm/drm_bridge.h, drm_bridge_get_current_state() asserts that
bridge->base.lock is held before reading bridge->base.state:

static inline struct drm_bridge_state *
drm_bridge_get_current_state(struct drm_bridge *bridge)
{
	if (!bridge)
		return NULL;

	drm_modeset_lock_assert_held(&bridge->base.lock);

	if (!bridge->base.state)
		return NULL;

	return drm_priv_to_bridge_state(bridge->base.state);
}

During a non-blocking atomic modeset commit in
drivers/gpu/drm/drm_atomic_helper.c, drm_atomic_helper_commit() queues
state->commit_work to run commit_tail() asynchronously on system_dfl_wq,
and drm_mode_atomic_ioctl() drops all modeset locks before the worker runs:

drm_mode_atomic_ioctl() ->
  drm_atomic_nonblocking_commit() ->
    drm_atomic_helper_commit()
      queue_work(system_dfl_wq, &state->commit_work);
  drm_modeset_drop_locks()

When the worker executes commit_tail() -> tegra_atomic_commit_tail() ->
drm_atomic_helper_commit_tail_rpm() ->
drm_atomic_helper_commit_modeset_enables() ->
drm_atomic_helper_commit_encoder_bridge_enable() ->
tegra_rgb_encoder_enable(), no drm_modeset_lock is held. Calling
drm_bridge_get_current_state(output->bridge) here will trigger the
drm_modeset_lock_assert_held(&bridge->base.lock) lockdep warning and perform
an unlocked read of bridge->base.state that can race with concurrent atomic
commits swapping or freeing the state.

In addition, if an attached bridge does not implement
.atomic_duplicate_state, drm_atomic_add_encoder_bridges() skips acquiring
bridge->base.lock even during blocking modeset commits, while
drm_bridge_attach() unconditionally initializes bridge->base.lock via
drm_atomic_private_obj_init().

Would it be better to switch tegra_rgb_encoder_helper_funcs to use the
.atomic_enable callback and look up the state from the drm_atomic_state via
drm_atomic_get_new_bridge_state(state, output->bridge)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022132259.2407=
17-1-clamor95@gmail.com?part=3D6
