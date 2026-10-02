Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F80CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B09E10E5F2;
	Fri,  2 Oct 2026 14:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ESPwCmmb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473CB10E5F2;
 Fri,  2 Oct 2026 14:38:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3797F60A70;
 Fri,  2 Oct 2026 14:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA141F000FF;
 Fri,  2 Oct 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790951901;
 bh=vr/kXgpSdbluBG408YmUZzV6TEB4wE4HF3eq4todiMw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ESPwCmmbvS4roqugTIjMlpxH6T7COA9RFBZ5x5GlWxxrYfETOQs+QuLGJTMILlBcq
 XNbEM2umzd5MAT3Ct/QxjCLZDAtkj6A0GW3e3syo4KV4YpNWJEvE2midCyrfSAhDSy
 YR3PzUERnsH/x9+7ZWoRKdgRw+oeWyfB/RQurPIW+WEvwW+kS5tUyMkHsX1xj6A1P5
 HpzBKAEfw3hdg/nUsNNyaT5csu1xQjmHGzS6GgNYCBXw8JPOXk3bPddtNl45109dnK
 C3o8fumCA6enXzeiyzkpCoVIuAqNAvGqzLEL9KR1ADhuUbgIgy0mwIZJhvoNANzxUD
 gdgK/Uqe4DoJw==
Date: Fri, 2 Oct 2026 09:38:18 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
Message-ID: <ar_AuRr1eaZzOfw9@baldur>
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
 <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, May 16, 2026 at 01:37:51AM +0530, Akhil P Oommen wrote:
> Add the CLX domain table and the IFF/PCLX limits tables to the catalog to
> enable CLX feature support on Adreno X2-85 GPU present in the Glymur
> chipset.
> 

This patch landed in next-20261001 and while it works on my Glymur CRD
(COB), on the Asus Zenbook A14 I see the following failure during boot:

[    4.843643] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt [msm]] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for response
[    4.853804] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
[    4.853878] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -110
[    4.863980] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
[    4.864038] platform 3d6c000.gmu: [drm:a6xx_hfi_stop [msm]] *ERROR* HFI queue 2 is not empty
[    5.128548] ------------[ cut here ]------------

And then as one can expect there's no more GPU.

Reverting this single patch makes next-20261001 work again.

#regzb introduced: 93b6c8d10fad ("drm/msm/a8xx: Enable CLX feature on Adreno X2-85")

Regards,
Bjorn

> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 86 +++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index c503912a61c7..9ad13eb173de 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1799,6 +1799,90 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
>  };
>  DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
>  
> +static const struct a6xx_hfi_clx_table_v2_cmd x285_clx_tbl = {
> +	.version = (2 << 16) | 1,
> +	.domain = {
> +		/* GX DOMAIN */
> +		{
> +			.data = CLX_DATA(60, 11, 0, 1),
> +			.clxt = 0,
> +			.clxh = 0,
> +			.urg_mode = 1,
> +			.lkg_en = 0,
> +			.curr_budget = 100,
> +		},
> +		/* MXG DOMAIN */
> +		{
> +			.data = CLX_DATA(60, 3, 1, 1),
> +			.clxt = 0,
> +			.clxh = 0,
> +			.urg_mode = 1,
> +			.lkg_en = 0,
> +			.curr_budget = 100,
> +		},
> +	},
> +};
> +
> +struct a6xx_hfi_limits_tbl x285_limits_tbl[] = {
> +	{
> +		.feature_id = GMU_MIT_IFF,
> +		.domain = GMU_GX_DOMAIN,
> +		.feature_rev = 0,
> +		.cfg = {
> +			.enable = 1,
> +			.msg_path = 0,
> +			.lkg_en = 0,
> +			.mode = 0,
> +			.sid = 12,
> +			.mit_time = 5,
> +			.curr_limit = 18000,
> +		},
> +	},
> +	{
> +		.feature_id = GMU_MIT_IFF,
> +		.domain = GMU_MX_DOMAIN,
> +		.feature_rev = 0,
> +		.cfg = {
> +			.enable = 1,
> +			.msg_path = 0,
> +			.lkg_en = 0,
> +			.mode = 0,
> +			.sid = 18,
> +			.mit_time = 2000,
> +			.curr_limit = 6000,
> +		},
> +	},
> +	{
> +		.feature_id = GMU_MIT_PCLX,
> +		.domain = GMU_GX_DOMAIN,
> +		.feature_rev = 0,
> +		.cfg = {
> +			.enable = 1,
> +			.msg_path = 0,
> +			.lkg_en = 0,
> +			.mode = 0,
> +			.sid = 6,
> +			.mit_time = 3,
> +			.curr_limit = 66000,
> +		},
> +	},
> +	{
> +		.feature_id = GMU_MIT_PCLX,
> +		.domain = GMU_MX_DOMAIN,
> +		.feature_rev = 0,
> +		.cfg = {
> +			.enable = 0,
> +			.msg_path = 0,
> +			.lkg_en = 0,
> +			.mode = 0,
> +			.sid = 6,
> +			.mit_time = 3,
> +			.curr_limit = 18000,
> +		},
> +	},
> +};
> +DECLARE_ADRENO_LIMITS_TABLE(x285_limits);
> +
>  static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
>  	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
>  	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
> @@ -2227,6 +2311,8 @@ static const struct adreno_info a8xx_gpus[] = {
>  				},
>  				{ /* sentinel */ },
>  			},
> +			.clx_tbl = &x285_clx_tbl,
> +			.limits_tbl = &x285_limits,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
> 
> -- 
> 2.51.0
> 
> 
