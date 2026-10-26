Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB5606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQFcYCJa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0945910E05A;
	Mon, 26 Oct 2026 19:24:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EAB10E05A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:24:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E238601EF;
 Mon, 26 Oct 2026 19:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0421F01828;
 Mon, 26 Oct 2026 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042652;
 bh=MYsX7CE4CECx1LdUuB5DRh+KbNBKFqgTouF5svnDZyQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hQFcYCJaVRlNitzs0ubqQchOznqRIP6Qq7KNdz78YKeW0929BF1d0eAMZqwQbhmLd
 avmPrdECtnFO1beDCyVEjargv7SSjzR9l8R65MugWxT+pM9Z50rwsFGP6UlyUGr4kx
 ioO4w7oeOZ+lNEw5lEJBe0gm3OnV6LiBr2Qre7Qv471Ncb9rmNPzDhpl2Ysp7Fgglj
 RHkS8O9AJQVRnuDqIucHxuqqdPIyOIn5CCxwtbqlRhQO4CmTTo8M+yjE6HFT2PXxhx
 USxK4GTx515/H8PP3QM7jW3KSuhwxeHSm0Mni7+QpWWn8QuSQwhjm3ESKz0MxbLyNg
 oywM7Y3njry+A==
Message-ID: <sashiko-outbox-185667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] drm/msm/dpu: use cached PINGPONGs from mode set in
 cwb setup
To: "Xi Zhang" <xz.ca.cn@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-msm-dpu-res-clean-v1-5-f46130a8a717@gmail.com>
References: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
 <20261026-msm-dpu-res-clean-v1-5-f46130a8a717@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 19:24:11 +0000
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
- [High] drm/msm/dpu: wrong pingpong index in dpu_encoder_helper_phys_setup=
_cwb()
--

commit 43be42587de24c595bae6d488f5806f627560896
Author: Xi Zhang <xz.ca.cn@gmail.com>

drm/msm/dpu: use cached PINGPONGs from mode set in cwb setup

This commit replaces the global state lookup of DPU_HW_BLK_PINGPONG blocks =
in
dpu_encoder_helper_phys_setup_cwb() with the cached dpu_enc->hw_pp array fr=
om
dpu_encoder_virt_atomic_mode_set().

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 7d092398fc991..f1d2482b787b0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2363,11 +2363,6 @@ void dpu_encoder_helper_phys_setup_cwb(struct dpu_=
encoder_phys *phys_enc,
>  	struct dpu_hw_ctl *hw_ctl;
>  	struct dpu_hw_cwb_setup_cfg cwb_cfg;
> =20
> -	struct dpu_kms *dpu_kms;
> -	struct dpu_global_state *global_state;
> -	struct dpu_hw_blk *rt_pp_list[MAX_CHANNELS_PER_ENC];
> -	int num_pp;
> -
>  	if (!phys_enc->hw_wb)
>  		return;
> =20
> @@ -2379,33 +2374,20 @@ void dpu_encoder_helper_phys_setup_cwb(struct dpu=
_encoder_phys *phys_enc,
>  		return;
>  	}
> =20
> -	dpu_kms =3D phys_enc->dpu_kms;
> -	global_state =3D dpu_kms_get_existing_global_state(dpu_kms);
> -	num_pp =3D dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
> -					       phys_enc->parent->crtc,
> -					       DPU_HW_BLK_PINGPONG, rt_pp_list,
> -					       ARRAY_SIZE(rt_pp_list));
> -
> -	if (num_pp =3D=3D 0 || num_pp > MAX_CHANNELS_PER_ENC) {
> -		DPU_DEBUG_ENC(dpu_enc, "invalid num_pp %d\n", num_pp);
> -		return;
> -	}
> -
>  	/*
>  	 * The CWB mux supports using LM or DSPP as tap points. For now,
>  	 * always use LM tap point
>  	 */
>  	cwb_cfg.input =3D INPUT_MODE_LM_OUT;
> =20
> -	for (int i =3D 0; i < MAX_CWB_PER_ENC; i++) {
> +	for (int i =3D 0; i < ARRAY_SIZE(dpu_enc->hw_cwb); i++) {
>  		hw_cwb =3D dpu_enc->hw_cwb[i];
>  		if (!hw_cwb)
>  			continue;
> =20
>  		if (enable) {
> -			struct dpu_hw_pingpong *hw_pp =3D
> -					to_dpu_hw_pingpong(rt_pp_list[i]);
> -			cwb_cfg.pp_idx =3D hw_pp->idx;
> +			cwb_cfg.pp_idx =3D i < ARRAY_SIZE(dpu_enc->hw_pp) && dpu_enc->hw_pp[i=
] ?
> +					dpu_enc->hw_pp[i]->idx : PINGPONG_NONE;

[Severity: High]
Does using dpu_enc->hw_pp[i]->idx here pass the dedicated CWB pingpong index
(PINGPONG_CWB_*) instead of the real-time display's pingpong index into
cwb_cfg.pp_idx?

dpu_encoder_helper_phys_setup_cwb() only configures CWB blocks when called =
on
a writeback encoder where dpu_enc->hw_cwb[i] is populated. In
dpu_encoder_virt_atomic_mode_set(), whenever dpu_enc->hw_cwb is populated
(is_cwb_encoder is true), dpu_enc->hw_pp is populated with
DPU_HW_BLK_DCWB_PINGPONG rather than DPU_HW_BLK_PINGPONG:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:dpu_encoder_virt_atomic_mode_se=
t() {
	...
	if (is_cwb_encoder) {
		num_pp =3D dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
						       drm_enc->crtc,
						       DPU_HW_BLK_DCWB_PINGPONG,
						       hw_pp, ARRAY_SIZE(hw_pp));
		num_cwb =3D dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
						       drm_enc->crtc,
						       DPU_HW_BLK_CWB,
						       hw_cwb, ARRAY_SIZE(hw_cwb));
	} else {
		num_pp =3D dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
						       drm_enc->crtc,
						       DPU_HW_BLK_PINGPONG, hw_pp,
						       ARRAY_SIZE(hw_pp));
	}
	...
}

In dpu_rm_get_assigned_resources(), DPU_HW_BLK_PINGPONG and
DPU_HW_BLK_DCWB_PINGPONG return mutually exclusive sets of pingpong blocks:

drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:dpu_rm_get_assigned_resources() {
	...
		if (type =3D=3D DPU_HW_BLK_PINGPONG) {
			struct dpu_hw_pingpong *pp =3D to_dpu_hw_pingpong(hw_blks[i]);

			if (pp->idx >=3D PINGPONG_CWB_0)
				continue;
		}

		if (type =3D=3D DPU_HW_BLK_DCWB_PINGPONG) {
			struct dpu_hw_pingpong *pp =3D to_dpu_hw_pingpong(hw_blks[i]);

			if (pp->idx < PINGPONG_CWB_0)
				continue;
		}
	...
}

However, dpu_hw_cwb_config() expects the real-time display's pingpong index
when programming the CWB_MUX register:

drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.c:dpu_hw_cwb_config() {
	...
	/*
	 * The CWB_MUX register takes the pingpong index for the real-time
	 * display
	 */
	if ((pp !=3D PINGPONG_NONE) && (pp < PINGPONG_MAX))
		cwb_mux_cfg =3D FIELD_PREP(CWB_MUX_MASK, pp - PINGPONG_0);
	...
}

By replacing the DPU_HW_BLK_PINGPONG lookup with dpu_enc->hw_pp[i]->idx on
the CWB writeback encoder, won't this program CWB_MUX with the dedicated CWB
pingpong block index instead of the real-time display's pingpong index?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-msm-dpu-re=
s-clean-v1-0-f46130a8a717@gmail.com?part=3D5
