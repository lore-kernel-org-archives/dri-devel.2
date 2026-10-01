Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8151CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E4F10F554;
	Thu,  1 Oct 2026 02:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvRKvfY/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="inW0qWgk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE9D10F554
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:41:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jhD92098503
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 02:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Ghkjprac1hGwE2HrmUj6yg2z
 I5ZEjbwo3mW27+l4U7w=; b=PvRKvfY/1bUonhpvDd9QQ/hrqKiYaxUFb8gHFmFB
 ThPOeFz4qpeTor4WGlUrdwmr9QzJ5IREGcnVnbWL3Z9lX2mthrLxN/4uGIPXvoUI
 mxMYUWday3aUaOW3YCjSK97Hdy1f86elKjKfp+Rvr7vWEh8x5Ny3udRHseCPPT+j
 /0qiB/uAqWkWD4jSngjM4gLEyLrGzjpUUhoojPNTgFtYWHod44GH9d69yD463h4p
 FOKcTsDthSi5UH+6R1PnULwBYldXQdqnd5gc4OPEgfk0havfZi08GyG7C3IDvsZM
 PmZztik015SRYUNkW/6kYIeiC1TmBgTDhA6eBnoyPj5Hng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tk1t3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:41:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939c30aa9a0so642074185a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790822470; x=1791427270;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ghkjprac1hGwE2HrmUj6yg2zI5ZEjbwo3mW27+l4U7w=;
 b=inW0qWgkaREShw8dc8NrLvNP+BXrmFDrGiaR8/YgFxDKgXr533xmtVF+sb4Sv1uutW
 9Xw+7ROe9AK9Pf+CMOwV9tkiUZaeY27AMlU6LYcoB7S4ToGHsl0BxyWOQvEMOWZlFWQj
 4vOar+MtEzjcp+Yr2LWi+4K6MexgIgqflcm4m9npFt1D7cIPKt4oukATkXy8mAUj0OPX
 rJFRyzI6SfUl4Vjg5x+xpR4uD8CYsKGPipD/Ura4gqyrqRr7gDtr/uLoETUpHJGcnEJ1
 JLyHo/m2y+edGm+HplFGkpV6PEE5F6CkwvAQ1CVjZbrHNw6Y+C7JYcaZp8Njc7YRZ4Tl
 67XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790822470; x=1791427270;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ghkjprac1hGwE2HrmUj6yg2zI5ZEjbwo3mW27+l4U7w=;
 b=gU0UFOWScEVLno28npmGeeyy6bPPj8+weF1QhLe/ReKGzgH10i0dg35xlkATlFs23U
 QiZCLwhT6Ft45im4sdLf1QQ4WtWeG3WlSzZFwKMvy690Fh6fx+k7WB2fl1mn+3n4z1vw
 LwhSjeFrlbsR0tXO00/voxIwScnwR5WZ8Zk2iwZxfWteAQqTkMLwGp2We3QskEZEBZpA
 p8Ha+zBVNm1FQApjPW/abMBOFqSeMp8E2KZvRx7aCZixnOUXYY1f8HpUgJlBw++I9wcv
 GK1iJeYLWNYdxjm31D42P5Og8v1AcShct6SrI4K3+hhr9/zix9JLj56ycVm7rmwKby9N
 JB9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2l7vS7Aa2/OUd8oUMCJztJFyYnrBvZo+PhyQpvySIYBknFK1eQV4ljxBCKctHiRRFapDQjgsH+YE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l3adMpiD2oW/zaGPDCYAJxZRNrJMci+/LA9yrRuL5J4wojpyS9
 jbpJTYR7I2C0z1YpZnlDnYW0BBD11iSStPTSj2wBJ28LVYmc4i8GdoiEVF391kEY2UGfVaCRSGw
 xkMQMRN4ia5EdlaBux5o+pINYDTPn+DdxdN/jxLCTaqo8Or5SvLFkbklvrGLNPzTEfq5GOp4=
X-Gm-Gg: AYBFou2xDobfz2705WK4gV43zixbYWq7xlqmY2qZYWUCc0fObzI3ign+Dn4oMdm20HO
 etsqe0anO4lWP/0Dgc+dqq8lFvNM+Jb8POw2APWid28jph/4jtqL3xLdr4s0xiYt2A+aWAgJP8e
 RdeQvlj+0U37yhh0MLbylWbED+KPQ2UUnmpNNF9o0loX6eZHmKex8JLQmo/yVMKKnmpt39HuHkn
 cIPZ92VQGQzjgswsRBvLlTty5GAsiOO5TLLVmbRdCh2THKaMJEpRkXS0YQIgSnBohv4hFF2eJC3
 IUzBwf8l97pwzwHXxIGE5jFtyEZkUsjzBEL790NvpwLIhZbgltgMWc5jI2kxDDMqDBKjtTuQZHg
 Xl7y7XOm69RxJQ0IAJqnlkte1K2C5SUEn7A/pW2Cen+dYVPGI7AP/IZOKK45/hTx45ume/WvH+i
 HDIN7LVuAG6YLf
X-Received: by 2002:a05:620a:4448:b0:93a:824:ac8d with SMTP id
 af79cd13be357-93ca96d83a2mr651722885a.27.1790822470113; 
 Wed, 30 Sep 2026 19:41:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4448:b0:93a:824:ac8d with SMTP id
 af79cd13be357-93ca96d83a2mr651720685a.27.1790822469619; 
 Wed, 30 Sep 2026 19:41:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a77192c19csm12699581fa.29.2026.09.30.19.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:41:07 -0700 (PDT)
Date: Thu, 1 Oct 2026 05:41:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: compute the CRTC bandwidth from the state
 being checked
Message-ID: <5rpjfokvikv2m2bayq72ar4z2i72esaarwzsui3yrceh3urvil@fuopy4uqypyv>
References: <20260929130633.977-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929130633.977-1-26rote@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfX9YZEJpwqcZmz
 9IgYFbGCHH90CjTtj/Y3uE7A7ZKOcMC0dzAVFZujjz/eVgqu0a6uORo5A8CF0b4bnA+X/sNvyU3
 leRNIY03CFqr2BLAB2M5aQ35puq5czI=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abdc847 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=9aN-E-HqI_eRP4b4jg4A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: CLOmvpSMlcr5d04QxqxBhnij_hufMAk3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfX1jYxkQ4Jv/aE
 vWYvKTmucWbnabF81WoYke7g5OVssXDHG+5LZRPGdjwjFUIxYbwy/ibVWMC9Z7n5kCrlUOAqOxL
 LgR+Jy5YwN82A1jxpXpoIT1uR7J9CSQ6aJPeeSMpAkXLhFEFx0dFximN1YjY/YCFmVyzENmS6wO
 qBPjhborUFMVmtB1BfTX3qBUQ8mjpBDjJTXjOBSQg/npO5zNmPjlezRzkEz+GSt16pjHPEy9Dkm
 NYfojTyFrMFM/FBIzir1nXVjWOTjBNlzTi94q4iX6WILPRcDmgxooTx9/GQSzYqOMrbzhZYLFrs
 rA3AN0kdjdNdiVKPLqVVg2y8TAyDZDDKTMJ1hqDmJUBrywXSnTfmaIDBTZ6N/dPMaPuPoOOKFjx
 X9tgrp2RqYL8qDKbrhhUko3o/4qnOxsdK+SHe2Fj2a5uXw/11CJzwAVHcq0EawSFRMh9SNVdHhA
 eVzVN0RBu1NQWNZcXmw==
X-Proofpoint-GUID: CLOmvpSMlcr5d04QxqxBhnij_hufMAk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010010
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

On Tue, Sep 29, 2026 at 10:06:33PM +0900, Joonhoe Kim wrote:
> _dpu_core_perf_calc_bw() is called with the new CRTC state but sums
> plane_fetch_bw over drm_atomic_crtc_for_each_plane(), i.e. the planes
> of the committed state. When the CRTC is re-enabled (DPMS on, system
> resume) the committed state has no planes attached, so the check
> computes bw_ctl = 0 and the display runs without an average bandwidth
> vote on the MDP path until some later commit changes a plane -- which
> may not happen for a long time on a static screen such as a lock
> screen.
> 
> Seen on a Lenovo TB323FU (SM8850) through the interconnect and DPU
> tracepoints: after DPMS off/on or s2idle, dpu_perf_crtc_update reported
> bw_ctl=0 and qnm_mdp was left at avg_bw=0 (peak 800000) instead of the
> 3728793 kBps voted before, until the next mode change.
> 
> Iterate the plane states of the CRTC state being checked instead.
> drm_atomic_crtc_state_for_each_plane_state() falls back to the current
> plane state for planes that are not part of the commit, so the result
> is unchanged for commits that do touch the planes.
> 
> With this, bw_ctl is 3728793600 right after DPMS on and after resume.
> Only tested on this device.
> 
> Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling for display")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> _dpu_core_perf_calc_clk() walks the planes the same way; it is not
> touched here since I have not seen a wrong clock vote from it.
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> index fea173e37464..343c41550637 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> @@ -54,24 +54,26 @@ u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
>  /**
>   * _dpu_core_perf_calc_bw() - to calculate BW per crtc
>   * @perf_cfg: performance configuration
> - * @crtc: pointer to a crtc
> + * @state: the CRTC state
>   * Return: returns aggregated BW for all planes in crtc.
>   */
>  static u64 _dpu_core_perf_calc_bw(const struct dpu_perf_cfg *perf_cfg,
> -		struct drm_crtc *crtc)
> +		struct drm_crtc_state *state)
>  {
>  	struct drm_plane *plane;
> -	struct dpu_plane_state *pstate;
> +	const struct drm_plane_state *plane_state;
>  	u64 crtc_plane_bw = 0;
>  	u32 bw_factor;
>  
> -	drm_atomic_crtc_for_each_plane(plane, crtc) {
> -		pstate = to_dpu_plane_state(plane->state);
> -		if (!pstate)
> -			continue;
> -
> -		crtc_plane_bw += pstate->plane_fetch_bw;
> -	}
> +	/*
> +	 * The planes of the CRTC state being checked: iterating the committed
> +	 * state (drm_atomic_crtc_for_each_plane()) summed nothing when the CRTC
> +	 * was being re-enabled (DPMS on, resume), whose old state has no
> +	 * planes, and the display ran without a bandwidth vote until the next
> +	 * plane update.
> +	 */

This again duplicates commit message. Please drop it. The patch LGTM.

> +	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, state)
> +		crtc_plane_bw += to_dpu_plane_state(plane_state)->plane_fetch_bw;
>  
>  	bw_factor = perf_cfg->bw_inefficiency_factor;
>  	if (bw_factor) {
> @@ -131,7 +133,7 @@ static void _dpu_core_perf_calc_crtc(const struct dpu_core_perf *core_perf,
>  		return;
>  	}
>  
> -	perf->bw_ctl = _dpu_core_perf_calc_bw(perf_cfg, crtc);
> +	perf->bw_ctl = _dpu_core_perf_calc_bw(perf_cfg, state);
>  	perf->max_per_pipe_ib = perf_cfg->min_dram_ib;
>  	perf->core_clk_rate = _dpu_core_perf_calc_clk(perf_cfg, crtc, state);
>  	DRM_DEBUG_ATOMIC(
> 
> base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
