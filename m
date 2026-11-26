Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AC606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aftWduW6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EB311214E;
	Thu, 26 Nov 2026 08:35:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754B911214E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:35:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2BAD61F76;
 Thu, 26 Nov 2026 08:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870041F000C4;
 Thu, 26 Nov 2026 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682112;
 bh=wT8QXpwcP2n3iQmDfT8n4NS0xnmkikjZbsHrHU08MdY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=aftWduW6zCSPowUWz5JHEMitZJt18UQxUWgEVfsKljb872KUwPMENoPwvFfPWsgv7
 1Ftm+DrJW95KjqZEN2jHCBbD0cAMbx+vt/Vte/zXeWzPJtVK/lzGlyAxXh2qnwjMRT
 8BF+j3/1+R2zg52LIeUpamL5kUeMBWcPY0nd8qzYMQvio+xQfIxo/+bI9idEVgZsqB
 tqp+EMEC93aE2WQyTyUN/q5zwmt61Ykx+GhD2svyngRhMw5+zqSOCYfldF8ZMjA0Af
 TUA3WEUWq1YsWvzpanfeEJeMd0bRuBxnKZfCNKPwpM+fkrgB9EyONijrnDN7TsL1wj
 gvy0HtF8HnXkw==
Message-ID: <sashiko-outbox-235038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/sti: gdp: set the pixel clock from
 .atomic_update()
To: "Minseo Park" <hiyoukou@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261126024710.33401-3-hiyoukou@gmail.com>
References: <20261126024710.33401-1-hiyoukou@gmail.com>
 <20261126024710.33401-3-hiyoukou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:35:12 +0000
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
- [High] drm/sti: skipped GDP clock update on modeset in
  sti_gdp_atomic_update()
- [Medium] drm/sti: clock enabled before rate setup and leaked in
  sti_gdp_atomic_update()
--

commit d592a33824a375f249463d88ff389958a6b8400e
Author: Minseo Park <hiyoukou@gmail.com>

drm/sti: gdp: set the pixel clock from .atomic_update()

This commit moves the GDP pixel clock reparenting and rate configuration
from sti_gdp_atomic_check() to sti_gdp_atomic_update(), using
clk_round_rate() in sti_gdp_atomic_check() to validate the mode clock
when the parent clock does not change.

> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> index d0c886029c570..4a01bc64f4ab0 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
[ ... ]
> @@ -757,6 +760,32 @@ static void sti_gdp_atomic_update(struct drm_plane *=
drm_plane,
>  	}
> =20
>  	mode =3D &crtc->mode;
> +
> +	/* Set gdp clock */
> +	if (mode->clock && gdp->clk_pix) {
> +		struct sti_mixer *mixer =3D to_sti_mixer(crtc);
> +		int rate =3D mode->clock * 1000;
> +		struct clk *clkp;
> +
> +		/*
> +		 * According to the mixer used, the gdp pixel clock
> +		 * should have a different parent clock.
> +		 */
> +		if (mixer->id =3D=3D STI_MIXER_MAIN)
> +			clkp =3D gdp->clk_main_parent;
> +		else
> +			clkp =3D gdp->clk_aux_parent;
> +
> +		if (clkp)
> +			clk_set_parent(gdp->clk_pix, clkp);
> +
> +		if (clk_set_rate(gdp->clk_pix, rate) < 0) {
> +			drm_err_once(drm_plane->dev,
> +				     "Cannot set rate (%dHz) for gdp\n", rate);
> +			return;
> +		}
> +	}

[Severity: High]
Can sti_gdp_atomic_update() skip this clock update when a modeset changes
mode->clock or moves the plane to another CRTC without changing the plane's
framebuffer or coordinates?

Earlier in sti_gdp_atomic_update(), the function returns early if fb and
the crtc_* and src_* coordinates are unchanged:

drivers/gpu/drm/sti/sti_gdp.c:sti_gdp_atomic_update() {
    ...
	if ((oldstate->fb =3D=3D newstate->fb) &&
	    (oldstate->crtc_x =3D=3D newstate->crtc_x) &&
	    (oldstate->crtc_y =3D=3D newstate->crtc_y) &&
	    (oldstate->crtc_w =3D=3D newstate->crtc_w) &&
	    (oldstate->crtc_h =3D=3D newstate->crtc_h) &&
	    (oldstate->src_x =3D=3D newstate->src_x) &&
	    (oldstate->src_y =3D=3D newstate->src_y) &&
	    (oldstate->src_w =3D=3D newstate->src_w) &&
	    (oldstate->src_h =3D=3D newstate->src_h)) {
		/* No change since last update, do not post cmd */
		DRM_DEBUG_DRIVER("No change, not posting cmd\n");
		plane->status =3D STI_PLANE_UPDATED;
		return;
	}
    ...
}

Previously, sti_gdp_atomic_check() always ran clk_set_parent() and
clk_set_rate() when the CRTC mode or CRTC assignment changed.  With the
clock setup placed after this early return, a refresh-rate change at the
same resolution or a switch between STI_MIXER_MAIN and STI_MIXER_AUX with
the same fb and coordinates returns before updating gdp->clk_pix, leaving
the plane scanning out with the old pixel clock rate or wrong parent clock.

[Severity: Medium]
When a disabled GDP plane is first enabled (!gdp->vtg), does returning on
clk_set_rate() failure leak the VTG client registration and gdp->clk_pix
enable count?

Just above the new clock block, sti_gdp_atomic_update() sets gdp->vtg,
registers gdp->vtg_field_nb, and calls clk_prepare_enable(gdp->clk_pix):

drivers/gpu/drm/sti/sti_gdp.c:sti_gdp_atomic_update() {
    ...
	if (!gdp->vtg) {
		struct sti_compositor *compo =3D dev_get_drvdata(gdp->dev);
		struct sti_mixer *mixer =3D to_sti_mixer(crtc);

		/* Register gdp callback */
		gdp->vtg =3D compo->vtg[mixer->id];
		sti_vtg_register_client(gdp->vtg, &gdp->vtg_field_nb, crtc);
		clk_prepare_enable(gdp->clk_pix);
	}
    ...
}

Besides enabling gdp->clk_pix before its parent and rate are configured,
sti_gdp_atomic_check() skips clk_round_rate() when the parent clock
changes, so clk_set_rate() can fail here.  Returning early leaves
gdp->clk_pix enabled and gdp->vtg_field_nb registered while plane->status
remains STI_PLANE_DISABLED, so disabling the CRTC will not call
sti_gdp_disable() to clean them up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126024710.3340=
1-1-hiyoukou@gmail.com?part=3D2
