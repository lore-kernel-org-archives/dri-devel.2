Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02532C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 13:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4530310E49A;
	Sat, 12 Sep 2026 13:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VDhCwb8D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C6710E49A
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 13:02:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA07E60236;
 Sat, 12 Sep 2026 13:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9AC1F000FF;
 Sat, 12 Sep 2026 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789218161;
 bh=PizVomd7Z8/s2/d67SISiFuoutzM81MpYbQfMAFV8v4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VDhCwb8DYfdeV3OwODgV582CYXIb3yBLxeS+SzVQyPdBK9DcWP2XoIhPT4Xok+Ibz
 VPDIvfVvy0n5CE8ChuCCv14ncoy2Urclg7fPl7jPT12GtjVz22nA9dSAPHV4oyTzhr
 sEnb//mKWJH1NlwdrmHs/XC0y1wT42lVHYkGEc0JpnEDNYxUHHqZ7mPW1TVELI4U9o
 4emegCsa6wds2tp11UgyCVBcNIdKCR3oQPx+Evw0L+PfhJDd64QD/r1WhRHGH9NoIP
 UGLzG2OpYS/sjsDbDrkXC8Vq5PQIhP+mDrbXM9mfKccCAV58QF2bzZ3+PngiNuCtOx
 FiMSTuk/WcV2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] drm/msm/dpu: clear the DSPP pointer when no DSPP
 is assigned
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-5-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
 <20260912-fd-kms-fix-smmu-v3-5-a7ddc6fe2032@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 13:02:41 +0000
Message-Id: <20260912130241.7D9AC1F000FF@smtp.kernel.org>
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
- [High] Stale pointers in dpu_enc->hw_cwb array causing uninitialized stac=
k memory dereference
- [High] Stale pointer in dpu_enc->cur_master->hw_cdm causing hardware stat=
e corruption
--

commit 50e668cb47f95334a8bcced939d0916fe0531def
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dpu: clear the DSPP pointer when no DSPP is assigned

dpu_crtc_assign_resources() only stores mixers[i].hw_dspp when the new
topology has a DSPP for that mixer, and dpu_crtc_duplicate_state() copies
the state with kmemdup(), so a crtc which once used a DSPP keeps a pointer
to it for the rest of its life -- across reservations which no longer own
that block.

Assign NULL when there is no DSPP for the mixer.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index bf593020e8e45..5dc0c9aeaa5d7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1480,8 +1480,8 @@ static int dpu_crtc_assign_resources(struct drm_crt=
c *crtc,
> =20
>  		cstate->mixers[i].hw_lm =3D to_dpu_hw_mixer(hw_lm[i]);
>  		cstate->mixers[i].lm_ctl =3D to_dpu_hw_ctl(hw_ctl[ctl_idx]);
> -		if (i < num_dspp)
> -			cstate->mixers[i].hw_dspp =3D to_dpu_hw_dspp(hw_dspp[i]);
> +		cstate->mixers[i].hw_dspp =3D i < num_dspp ?
> +			to_dpu_hw_dspp(hw_dspp[i]) : NULL;

[Severity: High]
This is a pre-existing issue, but does this same stale pointer problem exist
for hw_cwb in dpu_encoder_virt_atomic_mode_set() when the number of CWB
blocks decreases during a modeset?

If userspace submits a DRM commit that assigns fewer CWB blocks than the
previous state, trailing elements in dpu_enc->hw_cwb are not cleared:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:dpu_encoder_virt_atomic_mode_se=
t() {
    ...
	for (i =3D 0; i < num_cwb; i++) {
		dpu_enc->hw_cwb[i] =3D to_dpu_hw_cwb(hw_cwb[i]);
		cwb_mask |=3D BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
	}
    ...
}

Later, when dpu_encoder_helper_phys_setup_cwb() is called, it iterates over
MAX_CWB_PER_ENC and processes any non-NULL pointer. Could this cause the
driver to read from rt_pp_list[i] (an uninitialized stack array beyond
num_pp), cast the garbage value to a pointer, and dereference it via
hw_pp->idx, leading to a kernel crash?

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be another
stale pointer issue in dpu_encoder_virt_atomic_mode_set() with hw_cdm:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:dpu_encoder_virt_atomic_mode_se=
t() {
    ...
	if ((dpu_enc->disp_info.intf_type =3D=3D INTF_WB && conn_state->writeback_=
job) ||
	    dpu_enc->disp_info.intf_type =3D=3D INTF_DP) {
		struct dpu_hw_blk *hw_cdm =3D NULL;

		dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
					      drm_enc->crtc, DPU_HW_BLK_CDM,
					      &hw_cdm, 1);
		dpu_enc->cur_master->hw_cdm =3D hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
	}
    ...
}

If a modeset occurs where the encoder had a CDM block (e.g., from an active
writeback job), but the new state lacks a writeback job, the if-condition
evaluates to false and the pointer remains uncleared.

During dpu_encoder_helper_phys_cleanup(), the driver attempts to unbind the
stale CDM block by calling bind_pingpong_blk(..., PINGPONG_NONE) and
configures a flush. Can this corrupt the hardware state of a block that no
longer belongs to this reservation and may now be assigned to another displ=
ay?

>  	}
> =20
>  	cstate->num_mixers =3D num_lm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-fd-kms-fix=
-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com?part=3D5
