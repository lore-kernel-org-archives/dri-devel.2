Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E6606A32E
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejaKenlE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8F510E2E7;
	Sun,  1 Nov 2026 10:15:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFCA10E2E7
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 10:15:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CAECB600E2;
 Sun,  1 Nov 2026 10:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9071F000C1;
 Sun,  1 Nov 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793528103;
 bh=VMJo6AIrDaa2hTdjJsS3pk3BTn6zKbYewo2nSv51Sxc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ejaKenlE7VVNgJHOX/scwGPHRpAhXT2Jlyd+4N8IAzLIoYkPG1MhJ375H+DCs749C
 kz689mOBI128hlWR9LaN0SmwdCx3f77gkj5lL0AyMbx1VMenN3xPAFJuUX4F88Geq5
 mKuXWGQRUAV6cNZJcTzHZV/T6M8TWvQ0qCpS3cK3OK56ME3RcbJGgBH2co/bgG91IO
 PuTKL3QiMf9T9dPUW0h0BHGxZxDQIF3LoDpBywWXOExUjrcYOvdCmjpaySEpuqqGm7
 Oat1TEphtECKf2WHAaUQGT/Lv8jfZHNj/NjPf5U38Jku7g1zBkUTQIoJzfpASRF+6c
 nE8rj0m4MUNJg==
Message-ID: <sashiko-outbox-192352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: don't reassign resources on color
 management changes
To: "Beat M. Liechti" <beat@softbase.tech>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261101095754.33840-1-beat@softbase.tech>
References: <20261101095754.33840-1-beat@softbase.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 10:15:02 +0000
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
- [Medium] drm/msm/dpu: legacy CTM check in msm_atomic_check() overrides dp=
u_crtc_check_mode_changed()
--

commit d6607b12584d4668388dbb5415d60630f0aba092
Author: Beat M. Liechti <beat@softbase.tech>

drm/msm/dpu: don't reassign resources on color management changes

This commit stops reallocating hardware resources in dpu_crtc_atomic_check()
on plain color_mgmt_changed updates, and instead forces a full modeset in
dpu_crtc_check_mode_changed() when the combined CTM or GAMMA_LUT requirement
for DSPP blocks changes on an enabled CRTC.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 77a2d1f6700d0..d1cd3c6e2e3ab 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1516,6 +1516,20 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_st=
ate *old_crtc_state,
>  	    (!clone_mode_requested && clone_mode_enabled))
>  		new_crtc_state->mode_changed =3D true;
> =20
> +	/*
> +	 * DSPP blocks are reserved only when CTM or GAMMA_LUT is set (see
> +	 * dpu_crtc_get_topology()), so enabling or disabling color management
> +	 * changes the hardware topology. Changing resources on an active CRTC
> +	 * requires a full modeset; otherwise the CTL/LM blocks get swapped
> +	 * underneath a running pipeline.
> +	 */
> +	if (new_crtc_state->enable &&
> +	    (!!(old_crtc_state->ctm || old_crtc_state->gamma_lut) !=3D
> +	     !!(new_crtc_state->ctm || new_crtc_state->gamma_lut))) {
> +		new_crtc_state->mode_changed =3D true;
> +		new_crtc_state->state->allow_modeset =3D true;
> +	}

[Severity: Medium]
In dpu_crtc_check_mode_changed(), this check tests the combined
(ctm || gamma_lut) state on an enabled CRTC so that a modeset is only forced
when DSPP block reservation in dpu_crtc_get_topology() actually changes.

However, msm_atomic_check() in drivers/gpu/drm/msm/msm_atomic.c runs right
before kms->funcs->check_mode_changed() and still contains the earlier
CTM-only loop:

drivers/gpu/drm/msm/msm_atomic.c:msm_atomic_check() {
	/*
	 * FIXME: stop setting allow_modeset and move this check to the DPU
	 * driver.
	 */
	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
				      new_crtc_state, i) {
		if ((old_crtc_state->ctm && !new_crtc_state->ctm) ||
		    (!old_crtc_state->ctm && new_crtc_state->ctm)) {
			new_crtc_state->mode_changed =3D true;
			state->allow_modeset =3D true;
		}
	}

	if (kms && kms->funcs && kms->funcs->check_mode_changed)
		ret =3D kms->funcs->check_mode_changed(kms, state);
}

Because msm_atomic_check() unconditionally sets new_crtc_state->mode_changed
and state->allow_modeset whenever ctm is toggled, won't toggling ctm while
gamma_lut is already active still force an unnecessary full modeset and
resource reallocation even though DSPP blocks are already reserved, and also
bypass the new_crtc_state->enable guard when disabling a CRTC that had ctm
set?

Since DPU is the only sub-driver in drivers/gpu/drm/msm/ that enables color
management via drm_crtc_enable_color_mgmt(), should that CTM loop in
msm_atomic_check() be removed now that dpu_crtc_check_mode_changed() handles
both ctm and gamma_lut?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101095754.3384=
0-1-beat@softbase.tech?part=3D1
