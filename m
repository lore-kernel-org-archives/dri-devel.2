Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2A5C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1D610E647;
	Sat, 12 Sep 2026 12:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X4M2fonZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B152310E647
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:59:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35D4A60236;
 Sat, 12 Sep 2026 12:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26C61F00893;
 Sat, 12 Sep 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789217990;
 bh=5JUutj+qZr6wPnOdhXJdMVyK1ZmwCQSwKKEYlFJzAKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X4M2fonZ+qfbZ/ldUWkktJsa0i/xqyh+/88UJppJFoG5kl96PI8vYBoTH8i7kyqWy
 KTJr9yO5xVOQudTV9j+po3hbODW2R8y3KaEqKCJPyyxAV+A0clh+PVum1e1XCPELQR
 C+DcfJWFAP2VOni0pTRMDos89jBDayE7SUgv9IKv55WhDnglRwpszzmkQkU2F/5sdw
 i0spGkC6XWjboBinND59s+cPGdyzyc1kQa8u/EAn/y39vmDryUQ3TGa1uhErLN9/NI
 TRPPsByCc1U/HfyBpgDHcMB5dFNIJ7PZv5DtawkP5XQrXfCjdmIm2vaWwEqcnENJX1
 zUjOkM04gHVaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] drm/msm/dpu: clear the DSC blocks left by a
 previous reservation
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-6-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
 <20260912-fd-kms-fix-smmu-v3-6-a7ddc6fe2032@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 12:59:50 +0000
Message-Id: <20260912125950.C26C61F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Uninitialized stack memory dereference due to stale `hw_cwb` point=
ers.
- [High] Stale `hw_cdm` pointer leads to hardware state corruption.
--

commit 21c6c86adbc8ec970742702720e70e53d2f08f5c
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dpu: clear the DSC blocks left by a previous reservation

This commit fixes an issue in dpu_encoder_virt_atomic_mode_set() where stale
DSC blocks from previous reservations were not cleared by writing NULL to t=
he
remaining elements in the hw_dsc array.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 1f20695f81e35..50c49259a23e9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1222,9 +1222,10 @@ static void dpu_encoder_virt_atomic_mode_set(struc=
t drm_encoder *drm_enc,
>  	num_dsc =3D dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
>  						drm_enc->crtc, DPU_HW_BLK_DSC,
>  						hw_dsc, ARRAY_SIZE(hw_dsc));
> -	for (i =3D 0; i < num_dsc; i++) {
> -		dpu_enc->hw_dsc[i] =3D to_dpu_hw_dsc(hw_dsc[i]);
> -		dsc_mask |=3D BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
> +	for (i =3D 0; i < MAX_CHANNELS_PER_ENC; i++) {
> +		dpu_enc->hw_dsc[i] =3D i < num_dsc ? to_dpu_hw_dsc(hw_dsc[i]) : NULL;
> +		if (dpu_enc->hw_dsc[i])
> +			dsc_mask |=3D BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
>  	}
> =20
>  	dpu_enc->dsc_mask =3D dsc_mask;

[Severity: High]
This is a pre-existing issue, but does the hw_cwb array suffer from the same
problem just above this block?

In dpu_encoder_virt_atomic_mode_set(), hw_cwb is populated up to num_cwb:

	for (i =3D 0; i < num_cwb; i++) {
		dpu_enc->hw_cwb[i] =3D to_dpu_hw_cwb(hw_cwb[i]);
		...
	}

Elements beyond num_cwb are not cleared to NULL. Later, in
dpu_encoder_helper_phys_setup_cwb(), it iterates over the entire
MAX_CWB_PER_ENC array:

	for (int i =3D 0; i < MAX_CWB_PER_ENC; i++) {
		hw_cwb =3D dpu_enc->hw_cwb[i];
		if (!hw_cwb)
			continue;
		...
		if (enable) {
			struct dpu_hw_pingpong *hw_pp =3D
					to_dpu_hw_pingpong(rt_pp_list[i]);
			cwb_cfg.pp_idx =3D hw_pp->idx;

Could a stale hw_cwb pointer bypass the !hw_cwb check and access
rt_pp_list[i]? If i >=3D num_pp, it seems this would lead to dereferencing
uninitialized stack memory.

[Severity: High]
This isn't a bug introduced by this patch, but does hw_cdm have a similar
lifecycle issue in the same function?

Just below the hw_dsc clearing, dpu_encoder_virt_atomic_mode_set() handles
hw_cdm:

	if ((dpu_enc->disp_info.intf_type =3D=3D INTF_WB && conn_state->writeback_=
job) ||
	    dpu_enc->disp_info.intf_type =3D=3D INTF_DP) {
		struct dpu_hw_blk *hw_cdm =3D NULL;

		dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
					      drm_enc->crtc, DPU_HW_BLK_CDM,
					      &hw_cdm, 1);
		dpu_enc->cur_master->hw_cdm =3D hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
	}

If a modeset drops the writeback_job, this block is skipped entirely, leavi=
ng
the old pointer in dpu_enc->cur_master->hw_cdm.

Later, dpu_encoder_helper_phys_cleanup() unconditionally uses this pointer:

	if (phys_enc->hw_cdm) {
		if (phys_enc->hw_cdm->ops.bind_pingpong_blk && phys_enc->hw_pp)
			phys_enc->hw_cdm->ops.bind_pingpong_blk(phys_enc->hw_cdm,
								PINGPONG_NONE);
		...
	}

Can this stale pointer cause the cleanup path to alter a hardware block that
might now be owned by a different CRTC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-fd-kms-fix=
-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com?part=3D6
