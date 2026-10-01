Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D64CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CB010F27E;
	Thu,  1 Oct 2026 14:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q9t7s0gk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dTXG3dT/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BF110F27C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:52:43 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Dk6aF1857002
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 14:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+iF3uPEmgMCgIUnS2IvHI32Q
 7kQFVUfGG8r74lHA8/8=; b=Q9t7s0gkGeDDuh/txskwTFX3eCOS59ef4lHXrzDD
 glvj/rT9sCmgTh9kQO3wTvexY9SlTYWtlMp9sBcNAsbduoEr9PfiYbwoI83W+aiR
 q3idWncivINgzAQQUMJMonCYM1utjKzv5Ni6fKlV94v3txUIJ0m0+yUWzQNCoTib
 RUHBrB7KENnfZtisxxs9CE4a5He5XTKd7KXgGt414o4jT7Dje1P3BBDNUGbwECtX
 R3AwZIeGAzuGZoppztDC7NaZASJDjyI4/ISH2Tjqvq+oPaB4L/FD6AJ/N5cZ+sYy
 G/sczsoSjPmQ4Sd4jFRJvnkmsYlwbtEDBV6bz3xXfoR7Gw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcvt8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 14:52:42 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-989cd936d30so135040241.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790866362; x=1791471162;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+iF3uPEmgMCgIUnS2IvHI32Q7kQFVUfGG8r74lHA8/8=;
 b=dTXG3dT/LpR/cjl0LoIhxHTQZCSAp5kv88/uG+Utq/7J/41aGCNdVmAnz4mqbT2km6
 ixXwqI7nvySIx39+0+zL/ekWVGYXsce0bje43qyEGZ7izqQ+uqB+k58JlwoWEEUJouop
 k01s8k+YfderWt3CN2XaD/osB9Annc27R1/mlunVaY49zJnZBNibGw+woNpMEw5I9/DN
 CB7TAjBdUXXSHH4VQdBjI1SOOl9e/G9tS6K7mKLRmkCs8RVk+jYDq5TW2v2VUIDoqoMm
 6paKl4IrzcYhmWK2V70uOYZ0/NHejXhpUWUl5EyZIt6ThrjCFviuwG5HlkaqRjI5UpN+
 tKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790866362; x=1791471162;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+iF3uPEmgMCgIUnS2IvHI32Q7kQFVUfGG8r74lHA8/8=;
 b=XcwuOLGqkTm9zk4+hnRtInA2EYOsI9nhcWI1ouRvnWioBZZfTc7w7kuRipNsB0UzP7
 dOGkbwsH3svWbVaeYAMK9WdlFSMY8Bc7LJEtPK2FINkrIH2IVlVXQdfDfbzObOc4Av43
 syf6siZLTeOx75WPJ1aLPX1zcKDjnFsk0ATN+tJjnK6N/TfDtWVoGi4boyZlO978PM3t
 GSSwGlFJLGRRs4z0eX0uj5IlvYUEUM6P+dDqwRtoaXXZHEkkH9aHGIFo1aRVvkPTnYOs
 Hc7Fg3hpQpdm+N5jfQ9u5CBeVk2o+hbSxNjbsECoxvbuLVP31ltX7BDt33TQUK5ZeHkj
 iJQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP2vJMme4SaWam+rKs3GQHO8GjxftCpMDLTGY/99ABuCU2Ke3jVLiF6TwWP2nggY2w+PbztwerWiM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJRupxaqt/7kY15Ysdf40gTZdRq+pddZtCD1Uoh0FxmPrD0LEhD
 +RQ080l69jZPW4xJ2Q8ygldnXd+sD3DT7O4idjIwu23d/VZNY3ZmNFEt+V7ERFx6WBim2OBWte/
 CXjZu/1BMou+8HpAfaGydhwUAhPMzAp6LtActdHnShTZ5qi6iZj5XRbc79kZPDQ+MrgNYwTM=
X-Gm-Gg: AYBFou2BjSlzDnTmO+PJXFQHc9CzA65EJeGlKkkge37R7Ehp/YBLXA0xeqlkyI+GgxS
 QJwjpJqBH+Dw/1x5sDrnpMPbewMirNjBUwwhc8U9+WM6metw0E37YvZRlOYywYu7Xts859A+Qh8
 N4hQw6FoorieRCVjL0MNPCZ5+LPf5ACRw0KQvMXWKMrkXu5CJir+9vKVjSHxpJw8PvtW/gBKRYX
 PnTI4jrjVH+GvUU7UX0WGuMVA3h5lc1+/BLLBNJ7p65/MhOB294TbyarAtOMO8Sf9BC4GP/6q1g
 Ly3sxY73DXWjAJiQeMrPqTiCivAfWRsDDwWANFe6Bkv13jRhvWJcQn1OC6CEUrF6hFVIDzW6Zmx
 z8H+X4VqX/bL0S3s2qfIY75V1NwoRbRI4sMrJFE2SuTaizs9NrOQo0D0FFQ0GZCs0H8UprgCe7t
 GagNEZM1hqKSLz
X-Received: by 2002:a05:6102:148e:b0:7a7:196a:84ea with SMTP id
 ada2fe7eead31-7be7428e894mr1337144137.34.1790866361629; 
 Thu, 01 Oct 2026 07:52:41 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:7a7:196a:84ea with SMTP id
 ada2fe7eead31-7be7428e894mr1337122137.34.1790866360841; 
 Thu, 01 Oct 2026 07:52:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7bf038b1sm10900e87.47.2026.10.01.07.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:52:39 -0700 (PDT)
Date: Thu, 1 Oct 2026 17:52:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
Message-ID: <zgig74ptxcqnyzl7pvlecnnf6j2br6uz72ywcjbvhj2ccsljgr@n7rqpxpvwiu3>
References: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3geDzmNx5pLa
 RBgt5EY8cIq5OJg+xAgSAkS6GNNkfWOoKzlRu4X7YrRg0hINiij4wD3AmPWYT8zWCSYsCiDtN8o
 6RUenVN3BFMT5/4xX46V5vjhPbERIMmXbwSYqAU8viP2ESS9sEvesfPQcdpD2rTQvJU9Eh7At8V
 Y9KpZtGRZEfRCmHDqVWgWWjhxyvYgPn91AG+HLbXYeRkO4E74qJcnushp5fguJK0g9DuyF4v/is
 U4FVXjJIWGHu7nYrQUMzy3OuesVdxIwOlsrY9XG2y1w1JZGoWvKi8MfSYa5ZquxSJaR1yfb1c5M
 35aZTrsaCp69zB65HdEmiZxOvsaRrAYJkPaKAIeZV3OusPjbHLFcHbY08tax7WsX+VBLrUxrRKJ
 o3LjtaYi9MFq9XFPPy5Va0/oIS2k2nKRw6QLAf3bEZr7K8IdBc6kxh9GfdvsG50MovW9YCN4vGV
 ao2X8zgDFAVxOnnKQDQ==
X-Proofpoint-GUID: 2r3va3i4B22IX4TAV3kpJUQztC1alwP8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX8WPwTIfqhzPe
 Lza6v2bag7kgwzb2OSBYNQrg6QyG8q7LwRsmb3MXEBN8r1d/sB83MkY4NwDhNDchL2f0P3HkPxF
 CslvUSIkCwljA6bjb26h0H0oh8q7I8k=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abe73ba cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=T8Yxk-s-iGYFq7mrDv8A:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2r3va3i4B22IX4TAV3kpJUQztC1alwP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010059
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

On Mon, Jul 27, 2026 at 05:33:26PM +0800, Jun Nie wrote:
> To support high-resolution cases that exceed the width constrain
> or scenarios that surpass the maximum MDP clock rate, additional
> pipes are necessary to enable parallel data processing within
> the width constraints and MDP clock rate.
> 
> Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> high-resolution cases where dual interfaces are enabled for virtual
> plane case. More use cases can be incorporated later if quad-pipe
> capabilities are required.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Patchwork: https://patchwork.freedesktop.org/patch/675418/
> Link: https://lore.kernel.org/r/20250918-v6-16-rc2-quad-pipe-upstream-4-v16-10-ff6232e3472f@linaro.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> 2 or more SSPPs and dual-DSI interface are need for super wide panel.
> And 4 DSC are preferred for power optimal in this case due to width
> limitation of SSPP and MDP clock rate constrain. This patch set
> extends number of pipes to 4 and revise related mixer blending logic
> to support quad pipe. All these changes depends on the virtual plane
> feature to split a super wide drm plane horizontally into 2 or more sub
> clip. Thus DMA of multiple SSPPs can share the effort of fetching the
> whole drm plane.
> 
> The first pipe pair co-work with the first mixer pair to cover the left
> half of screen and 2nd pair of pipes and mixers are for the right half
> of screen. If a plane is only for the right half of screen, only one
> or two of pipes in the 2nd pipe pair are valid, and no SSPP or mixer is
> assinged for invalid pipe.
> 
> For those panel that does not require quad-pipe, only 1 or 2 pipes in
> the 1st pipe pair will be used. There is no concept of right half of
> screen.
> 
> For legacy non virtual plane mode, the first 1 or 2 pipes are used for
> the single SSPP and its multi-rect mode.
> 
> This patch set drop the merged heading 8 patches of v16, only the last
> 2 are revised and split into 4 patches here.
> 
>     Changes in v21:
>     - Add active-CTL constrain to quad-pipe case.

I'm going to post a patch to drop this condition, but anyway.

>     - adjust high clock rate constrain to quad-pipe case so that 4K@30Hz
>       still use 2 LMs.

Why is it only 4k@30? 4k@60 also can and should use 2LMs.

At this point I'd probably prefer 'use 2LMs unless you have to use
4LMs'.

For example, there is one more fix for dpu_crtc_assign_resources():
    int ctl_idx = i * num_ctl / num_lm

>     - Link to v20: https://lore.kernel.org/all/20260415-msm-next-quad-pipe-split-v20-1-bc1fdf140b81@linaro.org/
> 
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index bd0e720b484fd..d586825015906 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -200,7 +200,7 @@ static int dpu_crtc_get_lm_crc(struct drm_crtc *crtc,
>  		struct dpu_crtc_state *crtc_state)
>  {
>  	struct dpu_crtc_mixer *m;
> -	u32 crcs[CRTC_DUAL_MIXERS];
> +	u32 crcs[CRTC_QUAD_MIXERS];
>  
>  	int rc = 0;
>  	int i;
> @@ -1384,6 +1384,9 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>  	struct msm_display_topology topology = {0};
>  	struct drm_encoder *drm_enc;
> +	struct msm_drm_private *priv = crtc->dev->dev_private;
> +	struct dpu_kms *kms = to_dpu_kms(priv->kms);

There is already a dpu_kms being passed to this function. Please drop.

> +	u32 num_rt_intf;
>  
>  	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
>  		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
> @@ -1396,32 +1399,48 @@ static struct msm_display_topology dpu_crtc_get_topology(
>  	 *
>  	 * Dual display
>  	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
> +	 * 4 LM, 2 INTF ( Split display using 2 interfaces and stream merge
> +			  to support high resolution interfaces if virtual
> +			  plane is enabled)
> +	 * If DSC is enabled, use 2:2:2 for 2 LMs case, and 4:4:2 for 4 LMs
> +	 * case.
>  	 *
>  	 * Single display
>  	 * 1 LM, 1 INTF
>  	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
>  	 *
> -	 * If DSC is enabled, use 2 LMs for 2:2:1 topology
> +	 * If DSC is enabled, use 2 LMs for 2:2:1 topology for single display
> +	 * to support legacy devices that use this topology. Use 1:1:1 topology
> +	 * if there is only one DSC engine in SoC.
>  	 *
>  	 * Add dspps to the reservation requirements if ctm or gamma_lut are requested
> -	 *
> -	 * Only hardcode num_lm to 2 for cases where num_intf == 2 and CWB is not
> -	 * enabled. This is because in cases where CWB is enabled, num_intf will
> -	 * count both the WB and real-time phys encoders.
> -	 *
> -	 * For non-DSC CWB usecases, have the num_lm be decided by the
> -	 * (mode->hdisplay > MAX_HDISPLAY_SPLIT) check.
>  	 */
>  
> -	if (topology.num_intf == 2 && !topology.cwb_enabled)
> -		topology.num_lm = 2;
> -	else if (topology.num_dsc == 2)
> -		topology.num_lm = 2;
> -	else if (dpu_kms->catalog->caps->has_3d_merge &&
> -		 topology.num_dsc == 0)
> -		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
> -	else
> -		topology.num_lm = 1;
> +	num_rt_intf = topology.num_intf;
> +	if (topology.cwb_enabled)
> +		num_rt_intf--;
> +
> +	if ((mode->hdisplay > (dpu_kms->catalog->caps->max_mixer_width * num_rt_intf)) ||
> +	    ((u64)mode->hdisplay * mode->vtotal * drm_mode_vrefresh(mode) >
> +	     kms->perf.max_core_clk_rate))
> +		topology.num_lm = num_rt_intf * 2;
> +	else {
> +		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ?
> +				  2 : num_rt_intf;

This becomes unreadable. Replace ternary with the if, make it a chain of
if-else.

> +	}
> +
> +	if (!dpu_use_virtual_planes ||
> +	    dpu_kms->catalog->mdss_ver->core_major_ver < 5)
> +		topology.num_lm = min(2, topology.num_lm);
> +
> +	if (!dpu_kms->catalog->caps->has_3d_merge)
> +		topology.num_lm = min(num_rt_intf, topology.num_lm);
> +
> +	if (topology.num_dsc) {
> +		if (num_rt_intf == 1)
> +			topology.num_lm = min(2, dpu_kms->catalog->dsc_count);
> +		topology.num_dsc = topology.num_lm;
> +	}
>  
>  	if (crtc_state->ctm || crtc_state->gamma_lut)
>  		topology.num_dspp = topology.num_lm;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> index 6eaba5696e8e6..455073c7025b0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> @@ -210,7 +210,7 @@ struct dpu_crtc_state {
>  
>  	bool bw_control;
>  	bool bw_split_vote;
> -	struct drm_rect lm_bounds[CRTC_DUAL_MIXERS];
> +	struct drm_rect lm_bounds[CRTC_QUAD_MIXERS];
>  
>  	uint64_t input_fence_timeout_ns;
>  
> @@ -218,10 +218,10 @@ struct dpu_crtc_state {
>  
>  	/* HW Resources reserved for the crtc */
>  	u32 num_mixers;
> -	struct dpu_crtc_mixer mixers[CRTC_DUAL_MIXERS];
> +	struct dpu_crtc_mixer mixers[CRTC_QUAD_MIXERS];
>  
>  	u32 num_ctls;
> -	struct dpu_hw_ctl *hw_ctls[CRTC_DUAL_MIXERS];
> +	struct dpu_hw_ctl *hw_ctls[CRTC_QUAD_MIXERS];
>  
>  	enum dpu_crtc_crc_source crc_source;
>  	int crc_frame_skip_count;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index eba1d52211f68..058a7c8727f7c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -55,7 +55,7 @@
>  #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
>  	(MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
>  
> -#define MAX_CHANNELS_PER_ENC 2
> +#define MAX_CHANNELS_PER_ENC 4
>  #define MAX_CWB_PER_ENC 2
>  
>  #define IDLE_SHORT_TIMEOUT	1
> @@ -661,7 +661,6 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
>  	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
>  	struct msm_drm_private *priv = dpu_enc->base.dev->dev_private;

Unused (and triggers a warning).

>  	struct msm_display_info *disp_info = &dpu_enc->disp_info;
> -	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
>  	struct drm_connector *connector;
>  	struct drm_connector_state *conn_state;
>  	struct drm_framebuffer *fb;
> @@ -675,22 +674,12 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
>  
>  	dsc = dpu_encoder_get_dsc_config(drm_enc);
>  
> -	/* We only support 2 DSC mode (with 2 LM and 1 INTF) */
> -	if (dsc) {
> -		/*
> -		 * Use 2 DSC encoders, 2 layer mixers and 1 or 2 interfaces
> -		 * when Display Stream Compression (DSC) is enabled,
> -		 * and when enough DSC blocks are available.
> -		 * This is power-optimal and can drive up to (including) 4k
> -		 * screens.
> -		 */
> -		WARN(topology->num_intf > 2,
> -		     "DSC topology cannot support more than 2 interfaces\n");
> -		if (topology->num_intf >= 2 || dpu_kms->catalog->dsc_count >= 2)
> -			topology->num_dsc = 2;
> -		else
> -			topology->num_dsc = 1;
> -	}
> +	/*
> +	 * Set DSC number as 1 to mark the enabled status, will be adjusted
> +	 * in dpu_crtc_get_topology()
> +	 */
> +	if (dsc)
> +		topology->num_dsc = 1;
>  
>  	connector = drm_atomic_get_new_connector_for_encoder(state, drm_enc);
>  	if (!connector)
> @@ -2180,8 +2169,8 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
>  {
>  	int i, num_lm;
>  	struct dpu_global_state *global_state;
> -	struct dpu_hw_blk *hw_lm[2];
> -	struct dpu_hw_mixer *hw_mixer[2];
> +	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
> +	struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
>  	struct dpu_hw_ctl *ctl = phys_enc->hw_ctl;
>  
>  	/* reset all mixers for this encoder */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index 61b22d9494546..09395d7910ac8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -302,7 +302,7 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
>  
>  	/* Use merge_3d unless DSC MERGE topology is used */
>  	if (phys_enc->split_role == ENC_ROLE_SOLO &&
> -	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS &&
> +	    (dpu_cstate->num_mixers != 1) &&

I think here you should be comparing to 'phys_enc->split_role ==
ENC_ROLE_SOLO ? 1 : 2'. Add separate variable for it.

>  	    !dpu_encoder_use_dsc_merge(phys_enc->parent))
>  		return BLEND_3D_H_ROW_INT;
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index ba04ac24d5a9e..b1ac84c0b52db 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -24,7 +24,7 @@
>  #define DPU_MAX_IMG_WIDTH 0x3fff
>  #define DPU_MAX_IMG_HEIGHT 0x3fff
>  
> -#define CRTC_DUAL_MIXERS	2
> +#define CRTC_QUAD_MIXERS	4
>  
>  #define MAX_XIN_COUNT 16
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 0e65bf5ddc4a6..fd1f3e7982062 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -34,7 +34,7 @@
>  #define DPU_MAX_PLANES			4
>  #endif
>  
> -#define STAGES_PER_PLANE		1
> +#define STAGES_PER_PLANE		2
>  #define PIPES_PER_STAGE			2
>  #define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)
>  #ifndef DPU_MAX_DE_CURVES
> 
> ---
> base-commit: a913d08e5ea9a491b806e64a24410f6722ddc9b3
> change-id: 20260121-msm-next-quad-pipe-split-ab95b6e3ffd3
> 
> Best regards,
> -- 
> Jun Nie <jun.nie@linaro.org>
> 

-- 
With best wishes
Dmitry
