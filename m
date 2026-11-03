Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9430606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYuuwOrB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E611D10F37E;
	Tue,  3 Nov 2026 06:39:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072D610F37E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:39:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E49E9414C5;
 Tue,  3 Nov 2026 06:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AE61F000C1;
 Tue,  3 Nov 2026 06:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793687956;
 bh=lSYvc//2evcuVvvfbgkvtGMf4hbeH9dEG3g0YeldfH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JYuuwOrBIzz7fLQ67ZBuvME0tdnr7gVl0ZNb/E3fXqyFJGWYDAxE4SnCyIcTga8c1
 nKplLFcvCvy3Ah247q5rQrSoN9uOaoQX7UqIbyMpIuDycmsELciHNX4NJCq7WsVsyd
 miMIdtWz606jBZyrkZTrQSxEx5ZdiKjsBQo0OvxBVJ6W27ymZ5jNQ0vnzODm0qtlox
 75ySdzoh9D3EqdcDzSQERO5aTQBZvQWfSzSeMO+nq+a7vd6oqZgoU2sSWV2ageKFzf
 8yJ+h1nQHVT8xfDtJNVoo9sqeg4OE5dgvRDKDhuN67dTmgb473x24cxUFOGc5ncv0s
 embgxrFlB27xg==
Message-ID: <sashiko-outbox-194651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/16] drm/imx: dc-kms: Use driver specific
 .atomic_commit_tail callback
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-imx8-dc-prefetch-v9-4-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
 <20261103-imx8-dc-prefetch-v9-4-3b985e7636e2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:39:15 +0000
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
- [High] drm/imx: dc: plane disable skipped on modeset in dc_drm_atomic_com=
mit_tail()
--

commit ff022f683849ca82589cd00028c8fb7c412423dc
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc-kms: Use driver specific .atomic_commit_tail callback

This commit introduces a custom atomic_commit_tail callback for the i.MX8qxp
Display Controller KMS driver that passes DRM_PLANE_COMMIT_ACTIVE_ONLY and
DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET to drm_atomic_helper_commit_plane=
s()
to avoid accessing plane registers while clocks are disabled.

> diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-=
kms.c
> index 0e2ce6a425487..9ffa15ac43a25 100644
> --- a/drivers/gpu/drm/imx/dc/dc-kms.c
> +++ b/drivers/gpu/drm/imx/dc/dc-kms.c
[ ... ]
> @@ -30,6 +31,29 @@ static const struct drm_mode_config_funcs dc_drm_mode_=
config_funcs =3D {
>  	.atomic_commit =3D drm_atomic_helper_commit,
>  };
> =20
> +static void dc_drm_atomic_commit_tail(struct drm_atomic_commit *state)
> +{
> +	struct drm_device *dev =3D state->dev;
> +
> +	drm_atomic_helper_commit_modeset_disables(dev, state);
> +
> +	drm_atomic_helper_commit_planes(dev, state,
> +					DRM_PLANE_COMMIT_ACTIVE_ONLY |
> +					DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET);

[Severity: High]
Could passing DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET (and
DRM_PLANE_COMMIT_ACTIVE_ONLY) here leave the plane's FetchUnit source buffer
and LayerBlend enabled in hardware after the old framebuffer is cleaned up?

In drm_atomic_helper_commit_planes(), DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MOD=
ESET
skips calling funcs->atomic_disable() when the CRTC needs a modeset:

    if (disabling && funcs->atomic_disable) {
        struct drm_crtc_state *crtc_state;

        crtc_state =3D old_plane_state->crtc->state;

        if (drm_atomic_crtc_needs_modeset(crtc_state) &&
            no_disable)
            continue;

        funcs->atomic_disable(plane, state);
    }

That flag is meant for drivers where the CRTC atomic_disable callback also
disables the CRTC's planes. However, in drivers/gpu/drm/imx/dc/dc-crtc.c,
dc_crtc_atomic_disable() only disables FrameGen and calls pm_runtime_put() =
on
the Display Engine and the shared Pixel Engine without disabling the planes:

    enable_irq(dc_crtc->irq_dec_seqcomplete);
    dc_fg_disable(dc_crtc->fg);
    DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
    disable_irq(dc_crtc->irq_dec_seqcomplete);

    dc_fg_disable_clock(dc_crtc->fg);

    /* request pixel engine power-off as plane is off too */
    pm_runtime_put(dc_drm->pe->dev);

And in drivers/gpu/drm/imx/dc/dc-plane.c, __dc_plane_atomic_disable() is wh=
at
actually disables the FetchUnit source buffer and LayerBlend:

    /* disable fetchunit in shadow */
    fu_ops =3D dc_fu_get_ops(dplane->fu);
    fu_ops->disable_src_buf(dplane->fu, DC_FETCHUNIT_FRAC0);

    /* set ExtDst's source to ConstFrame */
    dc_ed_pec_src_sel(dplane->ed, dc_cf_get_link_id(dplane->cf));

When dc_crtc_atomic_enable() runs with new_crtc_state->plane_mask =3D=3D 0,=
 it
switches ed_cont's source selection to cf_cont, but it does not call
fu_ops->disable_src_buf():

    /* show CRTC background if no plane is enabled */
    if (new_crtc_state->plane_mask =3D=3D 0) {
        /* constframe in content stream shows black frame */
        dc_cf_constantcolor_black(dc_crtc->cf_cont);

        cf_link =3D dc_cf_get_link_id(dc_crtc->cf_cont);
        dc_ed_pec_src_sel(dc_crtc->ed_cont, cf_link);
    }

If an active CRTC with an enabled primary plane undergoes a modeset while
remaining active and disables its plane in the same commit,
dc_crtc_atomic_disable() calls asynchronous pm_runtime_put(dc_drm->pe->dev)
and dc_crtc_atomic_begin() immediately calls
pm_runtime_resume_and_get(dc_drm->pe->dev) before runtime suspend runs (or =
the
second CRTC on the shared Pixel Engine keeps dc_drm->pe->dev active), so
dc_pe_runtime_resume() does not reset the Pixel Engine hardware. Because
drm_atomic_crtc_needs_modeset() is true, DRM_PLANE_COMMIT_NO_DISABLE_AFTER_=
MODESET
skips dc_plane_atomic_disable(), leaving SOURCEBUFFERENABLE and LayerBlend
enabled after drm_atomic_helper_cleanup_planes() cleans up the framebuffer.

Similarly, because drm_atomic_helper_swap_state() swaps crtc->state before
dc_drm_atomic_commit_tail() runs, plane_crtc_active(old_plane_state) evalua=
tes
to false whenever a CRTC is being disabled (new_crtc_state->active =3D=3D f=
alse).
With DRM_PLANE_COMMIT_ACTIVE_ONLY, disabling a CRTC and its plane while the
second CRTC keeps the shared dc_drm->pe->dev powered on, followed by
re-enabling the first CRTC with plane_mask =3D=3D 0, also skips
dc_plane_atomic_disable() without ever calling fu_ops->disable_src_buf().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-imx8-dc-pr=
efetch-v9-0-3b985e7636e2@nxp.com?part=3D4
