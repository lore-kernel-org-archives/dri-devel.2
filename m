Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527A606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MShqbXqK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F2A112A42;
	Fri, 20 Nov 2026 13:15:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7FE112A41
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:14:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6442042A89
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0EA1F000C6;
 Fri, 20 Nov 2026 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180495;
 bh=z3wKsUTj4x8+9RW9X9fkzEX8payT1ljMMhtQq7d2qJY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MShqbXqKrwHfYDd7bdyN2LFQ67ccWcHamIYvQsCYiBrnlKaYhKcdWrRqzgZQSrEJ1
 WHBIIdJgeLdyckkOJT7y0Hrh+tX75anEtKrLXPgVK73mOtA64Ye0b80MfdybXTgKQ9
 KtzNk+V3rVLAY2ViT6WETd96PkfFuwB71SNNzjgq4ZbVRDZnsvM74aeJaQk09CkB9z
 7iVOeD3M4xBm6+XC7RbnNs0/z8+YyPCoUaf/2xCYaOTgnumHToIlj8l0aPB3EK8ZOz
 zcurbp9/y1+NgPTRDouBfjg9BhPixDWCh96OU6AU3F/DD/eEmmF7K1z81prR7doPDm
 1dcVTSxMnARuw==
Message-ID: <sashiko-outbox-225202@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 32/42] drm/tidss: crtc: Implement hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-32-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-32-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:14:54 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/tidss: build failure due to undeclared dispc_vp_*() readout
  helpers
- [Medium] drm/tidss: unchecked tidss_runtime_get() in
  tidss_crtc_readout_state()
--

commit 9881c280c684258267a1385984e8908b2bf1845f
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: crtc: Implement hardware state readout

This commit implements the hardware state readout, state installation, and
state comparison hooks for tidss CRTCs.

> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index d2664bda53a99..c72194e93bde1 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c

[ ... ]

> @@ -372,6 +376,131 @@ static struct drm_crtc_state *tidss_crtc_create_sta=
te(struct drm_crtc *crtc)
>  	return &tstate->base;
>  }
> =20
> +static int tidss_crtc_readout_state(struct drm_crtc *crtc,
> +				    struct drm_atomic_sro_state *state,
> +				    struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_device *ddev =3D crtc->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	struct dispc_device *dispc =3D tidss->dispc;
> +	struct tidss_crtc_state *tstate =3D to_tidss_crtc_state(crtc_state);
> +	struct tidss_crtc *tcrtc =3D
> +		to_tidss_crtc(crtc);
> +	struct drm_display_mode mode =3D {};
> +	int ret;
> +
> +	tidss_runtime_get(tidss);

[Severity: Medium]
Should tidss_crtc_readout_state() check the return value of
tidss_runtime_get() before reading DISPC registers, as
tidss_crtc_install_state() does below?

tidss_runtime_get() wraps pm_runtime_resume_and_get(), which drops the
usage count on failure.  Continuing on error accesses DISPC registers while
the DSS power domain and functional clock are disabled, and then
unconditionally calls tidss_runtime_put() on exit, underflowing the runtime
PM usage counter.

> +
> +	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
> +		goto out;
> +
> +	tstate->base.active =3D 1;
> +	tstate->base.enable =3D 1;
> +
> +	ret =3D dispc_vp_readout_mode(dispc, tcrtc->hw_videoport, &mode);
> +	if (ret)
> +		goto err_runtime_put;
> +
> +	ret =3D drm_atomic_set_mode_for_crtc(&tstate->base, &mode);
> +	if (WARN_ON(ret))
> +		goto err_runtime_put;
> +
> +	drm_mode_copy(&tstate->base.adjusted_mode, &mode);
> +
> +	tstate->bus_flags =3D dispc_vp_get_bus_flags(dispc, tcrtc->hw_videoport=
);
> +	ret =3D dispc_vp_get_bus_format(dispc, tcrtc->hw_videoport,
> +				      &tstate->bus_format);

[Severity: High]
Does this commit fail to build when CONFIG_DRM_TIDSS is enabled?

dispc_vp_is_enabled(), dispc_vp_readout_mode(), dispc_vp_get_bus_flags(),
dispc_vp_get_bus_format(), and dispc_vp_set_dpi_output() (called in
tidss_crtc_install_state() below) are neither declared in tidss_dispc.h nor
defined in tidss_dispc.c at this point in the series.  They are only added
later in commit "drm/tidss: dispc: Add hardware state readout helpers",
which breaks compilation and bisection here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D32
