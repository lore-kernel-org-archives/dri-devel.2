Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277AFCA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623C110E69A;
	Thu,  8 Oct 2026 17:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nf1/Hlg8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D173A10E69A
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:33:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2912E43ACA;
 Thu,  8 Oct 2026 17:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00A31F00893;
 Thu,  8 Oct 2026 17:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791480820;
 bh=1BRVzNnkzfZqynQSQbBLDbrs37JH53/7W92vfG1N9bY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nf1/Hlg8tlFEKXRoTNFNe/x7eLfU2J//8kivxZWN+EDVqWgFSzFjPaR1R7bv/BSdV
 eT3MslzZqWVXPCQOtsv1O6s6xUUhwED4IsVTbKsOGyULJpKZWhsxAtio4xCr8Yghqr
 VfBIkRju57lbTNzE17Leoss7w1neqwVGUkJCsITXaSdhtIHlr7Fz8uctsdaVoz5L0r
 SS+tH8RejjoqdYectIiDqWZntFNJetrpX41lhklB7ZVlDhot9IMjBNKLyeBhM7bs0V
 P4MmE/ciaCsGpe9QTwoeW9tt1bcqNgtNQW1asnPbdQe71z+zXcPQApGxvT+69tuxX8
 EcDnQ9zY9sFVg==
Message-ID: <sashiko-outbox-164416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] drm/msm/dpu: check mode against PINGPONG or DSC
 max width
To: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-lm_fixes_final-v4-3-fa986071c3c1@oss.qualcomm.com>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-3-fa986071c3c1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 17:33:39 +0000
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
- [High] drm/msm/dpu: DSC max width limits are bypassed and threshold logic=
 is dead code
--

commit f43daa2877be8ec1ed9bc6b650068210b82d6ffb
Author: Jessica Zhang <jesszhan0024@gmail.com>

drm/msm/dpu: check mode against PINGPONG or DSC max width

This commit replaces the hardcoded max_mixer_width and MAX_HDISPLAY_SPLIT
limits with dynamically determined pingpong or DSC buffer widths. It aims to
support higher refresh rate modes by passing the derived split threshold to
the layer-mixer count logic.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 209b25dbeb6c8..41f986ca2a683 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -765,13 +781,14 @@ static int _dpu_crtc_check_and_setup_lm_bounds(stru=
ct drm_crtc *crtc,
>  	struct drm_display_mode *adj_mode =3D &state->adjusted_mode;
>  	u32 crtc_split_width =3D adj_mode->hdisplay / cstate->num_mixers;
>  	struct dpu_kms *dpu_kms =3D _dpu_crtc_get_kms(crtc);
> +	int max_pingpong_width =3D msm_display_get_max_pingpong_width(dpu_kms);
>  	int i;
> =20
>  	/* if we cannot merge 2 LMs (no 3d mux) better to fail earlier
>  	 * before even checking the width after the split
>  	 */
>  	if (!dpu_kms->catalog->caps->has_3d_merge &&
> -	    adj_mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
> +	    adj_mode->hdisplay > max_pingpong_width)
>  		return -E2BIG;
> =20
>  	for (i =3D 0; i < cstate->num_mixers; i++) {
> @@ -783,7 +800,7 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct=
 drm_crtc *crtc,
> =20
>  		trace_dpu_crtc_setup_lm_bounds(DRMID(crtc), i, r);
> =20
> -		if (drm_rect_width(r) > dpu_kms->catalog->caps->max_mixer_width)
> +		if (drm_rect_width(r) > max_pingpong_width)
>  			return -E2BIG;
>  	}

[Severity: High]
Does this inadvertently allow DSC modes to exceed their narrower hardware
limits?

Because the bounds checks in _dpu_crtc_check_and_setup_lm_bounds() no longer
consider max_dsc_encoder_width, a DSC mode with a split width exceeding the
DSC hardware limit (e.g., width 3000 on a single DSC) will incorrectly pass
validation against the wider max_pingpong_width instead of returning -E2BIG.

This could lead to hardware configuration failures when programmed. None of
the follow-up patches in the series appear to resolve the bypassed DSC boun=
ds.

[ ... ]

> @@ -1410,6 +1428,19 @@ static struct msm_display_topology dpu_crtc_get_to=
pology(
> =20
>  	topology.cwb_enabled =3D drm_crtc_in_clone_mode(crtc_state);
> =20
> +	max_hdisplay_split =3D msm_display_get_max_pingpong_width(dpu_kms);
> +
> +	if (topology.num_dsc > 0) {
> +		u32 max_dsc_encoder_width;
> +
> +		if (dpu_kms->catalog->mdss_ver->core_major_ver < 6)
> +			max_dsc_encoder_width =3D DPU_1_x_MAX_DSC_ENCODER_WIDTH;
> +		else
> +			max_dsc_encoder_width =3D DPU_8_x_MAX_DSC_ENCODER_WIDTH;
> +
> +		max_hdisplay_split =3D min(max_hdisplay_split, max_dsc_encoder_width);
> +	}
> +
>  	/*
>  	 * Datapath topology selection
>  	 *
> @@ -1438,7 +1469,8 @@ static struct msm_display_topology dpu_crtc_get_top=
ology(
>  		topology.num_lm =3D 2;
>  	else if (dpu_kms->catalog->caps->has_3d_merge &&
>  		 topology.num_dsc =3D=3D 0)
> -		topology.num_lm =3D dpu_crtc_num_lm_for_mode(dpu_kms, mode);
> +		topology.num_lm =3D dpu_crtc_num_lm_for_mode(dpu_kms, mode,
> +							   max_hdisplay_split);
>  	else
>  		topology.num_lm =3D 1;

[Severity: High]
Is the max_hdisplay_split threshold logic for DSC topologies dead code here?

In dpu_crtc_get_topology(), max_hdisplay_split is clamped to
max_dsc_encoder_width when topology.num_dsc > 0. However, this updated
variable is exclusively passed to dpu_crtc_num_lm_for_mode() which is only
called in the branch where topology.num_dsc =3D=3D 0.

As a result, the computed max_hdisplay_split for DSC topologies is entirely
dead code and never actually utilized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-lm_fixes_f=
inal-v4-0-fa986071c3c1@oss.qualcomm.com?part=3D3
