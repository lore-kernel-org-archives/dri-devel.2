Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFD606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7VuMTU5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8962110E758;
	Fri, 23 Oct 2026 23:51:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F050410E758
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:51:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B21E543E0F;
 Fri, 23 Oct 2026 23:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3BA1F01825;
 Fri, 23 Oct 2026 23:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792799512;
 bh=X4K9p9nHIGGaDmvlVoCJ+KPKXBTKEYA6Vq+vrXxagY4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G7VuMTU5/Nz/xEH1SSjAr5muaVU700W9K4vbn07tVfPyCQiE8Pxx5qYFjYeg5ffmZ
 hSUZFi8RRlHUb2vKDNOZg8f8yiKMv5Ts8+wUSfWP5GEjCluQ1Fkj2Ej7L6Ny0BQ5A4
 X6c4zFCTOAQp6y/mpWO/miaoxWZtpJwiUN5wLv3K49gQqFC9DyGif4KjRJ2773jKvP
 moioWqMhtScOnEkVyUckPo4inDkI4VzJdHdUYtzHu+JbDbAiKGOdP9aBhTGXU/9ThJ
 p5k2cNn3RfKRQ1TsLHqjrSNYUjvbJXQDQkx+hucncFwLD8sFNnBUPJGdx1Pgr9FZUm
 5csLUYPoMWaiA==
Message-ID: <sashiko-outbox-183436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-9-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-9-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:51:52 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dpu: dpu_crtc_check_mode_changed() forces modeset on disab=
led CRTC
--

commit c3f9e050a732ed23fbcf8ea33c7cb5ebd0743f16
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dpu: only reassign resources when the encoder is reprogrammed

This commit restricts DPU CRTC resource reassignment to modeset and connect=
or
changes rather than color management updates, and moves the modeset check f=
or
DSPP reservation into dpu_crtc_check_mode_changed() while removing the CTM
modeset workaround from msm_atomic_check().

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 2ff0dab33710b..048800227ad30 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1489,6 +1489,26 @@ static int dpu_crtc_assign_resources(struct drm_cr=
tc *crtc,
>  	return 0;
>  }
> =20
> +static bool dpu_crtc_needs_dspp(const struct drm_crtc_state *crtc_state)
> +{
> +	return crtc_state->ctm || crtc_state->gamma_lut;
> +}
> +
> +static bool dpu_crtc_has_dspp(const struct drm_crtc_state *crtc_state)
> +{
> +	const struct dpu_crtc_state *cstate =3D to_dpu_crtc_state(crtc_state);
> +	unsigned int i;
> +
> +	if (!cstate->num_mixers)
> +		return false;
> +
> +	for (i =3D 0; i < cstate->num_mixers; i++)
> +		if (!cstate->mixers[i].hw_dspp)
> +			return false;
> +
> +	return true;
> +}
> +
>  /**
>   * dpu_crtc_check_mode_changed: check if full modeset is required
>   * @old_crtc_state:	Previous CRTC state
> @@ -1506,6 +1526,11 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_st=
ate *old_crtc_state,
> =20
>  	DRM_DEBUG_ATOMIC("%d\n", crtc->base.id);
> =20
> +	/* DSPPs are only reserved during a modeset */
> +	if (dpu_crtc_needs_dspp(new_crtc_state) &&
> +	    !dpu_crtc_has_dspp(old_crtc_state))
> +		new_crtc_state->mode_changed =3D true;

[Severity: High]
What happens here when ctm or gamma_lut is set on a disabled CRTC where
new_crtc_state->enable is false?

In drm_mode_atomic_ioctl() -> drm_atomic_check_only() -> msm_atomic_check()=
 ->
dpu_kms_check_mode_changed() -> dpu_crtc_check_mode_changed(),
dpu_crtc_needs_dspp(new_crtc_state) returns true whenever ctm or gamma_lut =
is
present regardless of whether new_crtc_state->enable is set.

Because dpu_crtc_assign_resources() skips resource reservation when the CRTC
is disabled:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_assign_resources() {
	...
	dpu_rm_release(global_state, crtc);

	if (!crtc_state->enable)
		return 0;
	...
}

cstate->num_mixers is 0 on a disabled CRTC, so
dpu_crtc_has_dspp(old_crtc_state) is false and dpu_crtc_check_mode_changed()
sets new_crtc_state->mode_changed =3D true.

If userspace sets CTM or GAMMA_LUT on a disabled CRTC without
DRM_MODE_ATOMIC_ALLOW_MODESET, drm_atomic_check_only() will see
drm_atomic_crtc_needs_modeset(new_crtc_state) and reject the commit with
-EINVAL.

Furthermore, even if CTM or GAMMA_LUT is initially committed on a disabled
CRTC with allow_modeset =3D true (or via legacy gamma/property ioctls or
drm_fb_helper's setcmap_atomic()), dpu_crtc_assign_resources() still returns
early without reserving mixers or DSPPs. On every subsequent atomic commit
that includes that disabled CRTC in state, dpu_crtc_needs_dspp(new_crtc_sta=
te)
&& !dpu_crtc_has_dspp(old_crtc_state) remains true, forcing
new_crtc_state->mode_changed =3D true and causing any non-modeset commit to=
 fail
with -EINVAL.

Should dpu_crtc_needs_dspp() or dpu_crtc_check_mode_changed() check
new_crtc_state->enable before requiring a modeset for DSPP reservation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-fd-kms-fix=
-smmu-v5-0-a5b0b284aead@oss.qualcomm.com?part=3D9
