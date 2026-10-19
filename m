Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD2CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3B310E972;
	Mon, 19 Oct 2026 10:15:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57AC10E972
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:15:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2B5F601FB;
 Mon, 19 Oct 2026 10:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEB41F000C4;
 Mon, 19 Oct 2026 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792404948;
 bh=s8uPFbfuXkdZ/EpuWrCDF4v11srdurwJ2Jr6jRmmNPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DGz+dDvI7gojnK3RX32pfaAg3u+ImEfOb17EcAueGwhQQxdmOt2OwBRGP+zdPIOSF
 6iuhXD9SRCui+llA3M9TmkCZagywbnxcazTudzoSDSxNT/2pwfLWyXgWBv5VD2q7pI
 +aELTCThyx/fPsq0sjn8zRS1XNFTLJsxPaSqdPGIHQNWpY1n3wRnALqF2pphJ6/yZy
 ABMgd1VlAuDIKbEVd2dV3t2lA8ctZ2m6xSgE5C947gmtsjV+k5FfDGQ+oAGSXHjaUf
 jASUq+CfgcI9qs+Untsoiu/dVpTYSatNYWELNyz6DeB9WFcOYDdAp95m+FOOIorjBE
 MH7RKPA6F5mtg==
Message-ID: <sashiko-outbox-176969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] drm/tegra: rgb: Parameterize configuration based
 on bus flags
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019095705.91062-3-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
 <20261019095705.91062-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:15:47 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/tegra: rgb: unlocked drm_bridge_get_current_state() in encoder=
 enable
--

commit 62888cceae72e28c0425a5560b48d0bf56dccc9e
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/tegra: rgb: Parameterize configuration based on bus flags

This commit parameterizes the Tegra RGB encoder configuration based on bus
flags from the bridge state, including pixel clock polarity, display enable
polarity, and data alignment.

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
tegra_rgb_encoder_enable()?

Looking at include/drm/drm_bridge.h, drm_bridge_get_current_state() asserts
that bridge->base.lock is held:

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

When userspace submits a non-blocking atomic modeset commit
(DRM_MODE_ATOMIC_NONBLOCK | DRM_MODE_ATOMIC_ALLOW_MODESET),
drm_atomic_helper_commit() swaps the state and schedules commit_work on
system_dfl_wq, after which drm_mode_atomic_ioctl() drops all modeset locks.

The worker thread then executes without holding bridge->base.lock:

commit_work() ->
  commit_tail() ->
    tegra_atomic_commit_tail() ->
      drm_atomic_helper_commit_tail_rpm() ->
        drm_atomic_helper_commit_modeset_enables() ->
          drm_atomic_helper_commit_encoder_bridge_enable() ->
            tegra_rgb_encoder_enable()

Won't calling drm_bridge_get_current_state(output->bridge) here trigger a
lockdep warning when CONFIG_PROVE_LOCKING is enabled and read
bridge->base.state without synchronization against concurrent atomic state
swaps?

Should this encoder implement .atomic_enable and retrieve the bridge state =
via
drm_atomic_get_new_bridge_state(state, output->bridge), or cache bus_flags
during .atomic_check instead?

[ ... ]

>
>  	tegra_dc_commit(rgb->dc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019095705.9106=
2-1-clamor95@gmail.com?part=3D2
