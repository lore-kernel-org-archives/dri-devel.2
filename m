Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC6EC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4411610ECCF;
	Tue,  8 Sep 2026 15:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yd70xKVT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB1410ECCF
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:42:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A4CDE601DB;
 Tue,  8 Sep 2026 15:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179E41F00A3A;
 Tue,  8 Sep 2026 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788882175;
 bh=T5o9XSYx6rt+S4C9apGg4KaL5b55Fd0hSoEtf2btdGE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yd70xKVTITC6/HkoNogj+Oe+Z/ZFsvHxs1mWwqb9A+hHdX0oOLPw08YjP46sC7e1/
 p2k7Slv/XLAiV1zePC/Al73zY5yMeHEYUU/01qEB4XI6fWeXvzX9llSUDloi7AAJhY
 Wmukghn38tTWDBH4mxGusOgPj5UYEnaSBUOJvCw0YKcLzoTAz6mrN5QmQUWNbD4fi3
 7r0hJvTXaFc/7ooarmFC0d89auZgViL9R5fNQIwgaxZeT9wn0vrPTL+3dgBOw7AGMH
 ltcz3/IaxeYBJGy6Ia+Zc0BJoA/q/BtcYbHqmYyB+Q+32+NAhgbKGJ80N9TudOERrs
 OHUfyejHsYJRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] drm/msm/dpu: clear the DSPP pointer when no DSPP
 is assigned
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-fd-kms-fix-smmu-v2-4-9391815742a8@oss.qualcomm.com>
References: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
 <20260908-fd-kms-fix-smmu-v2-4-9391815742a8@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:42:54 +0000
Message-Id: <20260908154255.179E41F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Stale pointers for hardware blocks (hw_dsc, hw_cwb) in persistent =
encoder state are not cleared when resource counts shrink, leading to incor=
rect hardware configuration and kernel panics.
--

commit 6954c50ce10cab5ddfb3ee7cbf148810fc5b6d78
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dpu: clear the DSPP pointer when no DSPP is assigned

This commit fixes a bug where stale DSPP pointers are retained in the CRTC
state across modesets. It assigns NULL to the DSPP pointer when there is no
DSPP for the mixer.

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
>  	}

[Severity: High]
This is a pre-existing issue, but does this same stale pointer bug also
happen with hw_cwb and hw_dsc in dpu_encoder_virt_atomic_mode_set()?

Looking at drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c, if a modeset drops
CWB or DSC features, the loops only iterate up to the new smaller num_cwb
or num_dsc:

	for (i =3D 0; i < num_cwb; i++) {
		dpu_enc->hw_cwb[i] =3D to_dpu_hw_cwb(hw_cwb[i]);
		cwb_mask |=3D BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
	}

Since trailing elements aren't cleared, dpu_enc->hw_cwb[i] and
dpu_enc->hw_dsc[i] retain stale pointers.

When dpu_encoder_helper_phys_setup_cwb() later iterates over
MAX_CWB_PER_ENC, it finds the stale pointer and attempts to read from
the uninitialized stack array rt_pp_list[i]:

	for (int i =3D 0; i < MAX_CWB_PER_ENC; i++) {
		hw_cwb =3D dpu_enc->hw_cwb[i];
		if (!hw_cwb)
			continue;

		if (enable) {
			struct dpu_hw_pingpong *hw_pp =3D
					to_dpu_hw_pingpong(rt_pp_list[i]);
			cwb_cfg.pp_idx =3D hw_pp->idx;
		...

This dereferences hw_pp->idx from stack garbage, causing a kernel panic.

Similarly, in dpu_encoder_use_dsc_merge(), stale hw_dsc pointers artificial=
ly
inflate num_dsc, which breaks topology decisions like 3D blend mode
selection:

	for (i =3D 0; i < MAX_CHANNELS_PER_ENC; i++)
		if (dpu_enc->hw_dsc[i])
			num_dsc++;

Should similar clearing logic be added to dpu_encoder_virt_atomic_mode_set()
to clear trailing hw_cwb and hw_dsc pointers?

> =20
>  	cstate->num_mixers =3D num_lm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-fd-kms-fix=
-smmu-v2-0-9391815742a8@oss.qualcomm.com?part=3D4
