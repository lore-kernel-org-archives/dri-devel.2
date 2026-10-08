Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DC0CA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3209010E68B;
	Thu,  8 Oct 2026 17:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U/NssbIS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B058A10E68B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:31:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBB74601FD;
 Thu,  8 Oct 2026 17:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B101F000FF;
 Thu,  8 Oct 2026 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791480698;
 bh=Rm8IXSEUB3BGIfIkwI/RE3Eh7RBGY1hIpNGB8c/wYk4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U/NssbISAplA88tSfQdofYmtD5pcPNJH0t675VZ15oNe3lAkvvHacOg3kY+ZaaT1c
 du8SSo6WgMC9AsLFRpPwADsTnLBoXb09DSaGO9mn94uyTfbfeTpvPYPj5WLd+LU8qd
 qgfFDmJEB/np9pN5k603bewt7ErfMwXqIFkZsvTWsB/Eko032uZvwx/uGV9c9h3qqC
 cb78kII3XGog+7NhXwgwnxXYPMAh7e+XTWLP9YNc8+jLvY9v8Dk61MKbWPsmwkTx6l
 eH9c5Azc0MS3C9XAAl9Weuwce7cAJRdw3/jVeXvoGjRefRo7S/JvJbRIORKsPTVUDG
 owLahbxM/4maQ==
Message-ID: <sashiko-outbox-164414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] drm/msm/dpu: do not assume a merged datapath
 when validating mode clock
To: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-lm_fixes_final-v4-2-fa986071c3c1@oss.qualcomm.com>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-2-fa986071c3c1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 17:31:37 +0000
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
- [Low] drm/msm: 64-bit division causes build failure on 32-bit architectur=
es
--

commit a2eae50c59c6c00875971ea5d298ddc98b93dc84
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>
drm/msm/dpu: do not assume a merged datapath when validating mode clock

This commit changes the mode clock validation logic in dpu_crtc_mode_valid()
to divide by the actual number of layer mixers used, rather than always
halving it when 3d_mux is present.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_crtc.c
> index 0b51a4c5db577..209b25dbeb6c8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1631,8 +1631,7 @@ static enum drm_mode_status dpu_crtc_mode_valid(str=
uct drm_crtc *crtc,
>  	adjusted_mode_clk =3D dpu_core_perf_adjusted_mode_clk(mode->clock,
>  							    dpu_kms->perf.perf_cfg);
> =20
> -	if (dpu_kms->catalog->caps->has_3d_merge)
> -		adjusted_mode_clk /=3D 2;
> +	adjusted_mode_clk /=3D dpu_crtc_num_lm_for_mode(dpu_kms, mode);

[Severity: Low]
Does this code introduce a linker error on 32-bit architectures?

The variable adjusted_mode_clk is declared as a u64, and it is being divided
by the u32 result of dpu_crtc_num_lm_for_mode(). In the kernel, using the
direct division operator with a non-constant on a 64-bit variable emits
compiler built-in functions that are not linked on 32-bit architectures
like ARM32, leading to a build failure.

Could this be changed to perform the division using kernel macros like
do_div() or div_u64() instead?

> =20
>  	/*
>  	 * The given mode, adjusted for the perf clock factor, should not exceed

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-lm_fixes_f=
inal-v4-0-fa986071c3c1@oss.qualcomm.com?part=3D2
