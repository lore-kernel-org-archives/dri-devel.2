Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC9CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7C810E2AA;
	Wed, 30 Sep 2026 18:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QJG6Rbqk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kmD6mCRS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A4E10E2AA
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:54:15 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UILhLd3655859
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gnnRitNHQsGGZhY39Q2WfcsA
 gBctnLcpoJur/qokc8I=; b=QJG6RbqkWltaOXjdWTCf37r8Jt47ICQMxogyCmWu
 1Pz2SKFiT32S09RpePoOLYEAMOc95KUtX3ELA8b/wk2qLDBRI8DDWGMhiVlR1DOF
 WF5eCQ5NeSo7x6ekXDtMGJzF17qEfb794vdPLbQaRcCNPk1ue4YZ1ej14knc2lmE
 QtIEwfRyw6x5PW+g1k1Myf1MSzsO6DBgngl0wWWU6s5ho+Yc/LCGRnbWdQN3MpxL
 8hX4LvFyBUys7r2nrI2guUqoGtQOZEUWNG69zrYpjORWBXosS3i76JAIaK+VbvDC
 /fxvlr61OYa+vTYIpO5Ytf3yRJIvjtUHccm9fK1oafd+Gg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvr4c3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:54:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939f248907fso550864485a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790794454; x=1791399254;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gnnRitNHQsGGZhY39Q2WfcsAgBctnLcpoJur/qokc8I=;
 b=kmD6mCRSydQd1jwpe3nY5bTs4UiSplOWHt1GgKO+WbtrBpV7QjFuoYiztHVuEZwUE/
 YHh+e8djgX6TclRZgvGMTe2D6WpjTZnOqhIwEfEFVSRpFI1TC3+GWwvHyhWF+ElaWtqU
 V8qJNFc8inmj80+VNfUQZAojKwvwCc8wqGuE3qfb9HBTJnkDXgbw+wfxq5mPUaioL9ER
 04ZI62MtCP/LcrvmYhx0RhQjEmT34QFgkZ+jLh/+lehnXjcDJbJVIQdMUCFhcanTPUxk
 1Vp2kaMhj/Vq/xr+vmvwZyw0wWle6piUk3Q+RN4KQWTFeEvBiL4OSE/511qk5G+QfA/E
 nWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794454; x=1791399254;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gnnRitNHQsGGZhY39Q2WfcsAgBctnLcpoJur/qokc8I=;
 b=mrbrvY4UP0Ft7nw494d9luTihLmzSkxwcTjmlOn+0knayYbJUuV3litjB1yoed7iJK
 of2xvgJPmxb95lah2PY5V2qrCjIQwZ498AZOaf9OKLY/0CBbkI+9Mi3T2QZh9KkSZWN8
 YkibYpxregHNgOQxtAuYp0Lq/Z6CRyGpVu9HE6l53oPZVs84GaGB1n0AcWhHs3X3x+MB
 Z1y8VpMCMcs4epVcTG+KA8k6yw2z8f2J/DsLo7lmJnl6OFc/LdojUm+s6UBQ2NFnH8Fx
 pW7FL/5bvO4Ii0FZ7zjSbb+3rFVEKEE9/EB2ObVD1qeJyVPW2CB9F+gXe4vyup3/1aHS
 +Xmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk1mz2cz/ooIVUvzOOtumVsH3xJLMnFiufPqI/AZ69bxpULdQSWVrjykTzPuPV8RY1uFyo5kex9KU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lNgIeC4ho7AQQqb9xiyWixjpzreGgivS2F/MLQ/kdiUMGHa9R9
 z1ESVSFWWpTMUfLd1kJXxEbpHQpREG7G0s13Wxy+JPB2kfnrxGrL+cuNr/q90JaYimFgCQFjF25
 WypE5AQ37FB9jrReFMvYXvWYlIUhtTq7Ja33sxzfQyy2NL1906oFxSP+j7onkRlNBveLVT1M=
X-Gm-Gg: AYBFou0GrP1m3uIScJPKUvXN0pEqvObhEDdyvXXo8gcqoqSPqd5smyF9QWJa/egan0K
 UexHFKPfmzvVG1WdsFeUTndeSq6Pe5IZZUKdA9m/vWcFRKvvRVGbGuLqCLJjlO7ptf/hKOeks4D
 d5ShCMCpsxJh37T3NYzmPZ5nufBudAa/9GEpc3mFr3p9ZzvA7FG4dEh/4FcEpYRaacpbMHt8Hv3
 YuydTNs18toQf3UHsCAaON+8QMg6bK1tSmS7j+kHvHm4I1iKR6xiQxBTu3GPvN+tmEagmYItGwT
 IwgaymizUkXoYDr4Njs7KacPUutOXrx9TETZX3Yqy3MYGIunClQK1DzbQIMHWaWypmRFqAad+Kb
 2E9o5ppJKogiUCFx6J4ilFHcWsJJ6aChxiAUc1dfqSGusoJf3YjFGEczpuw/C7oBk9iN72fZHqT
 yJ7BdWk9ispm//
X-Received: by 2002:a05:620a:838e:b0:93b:c581:2e16 with SMTP id
 af79cd13be357-93ca96f18cbmr421034285a.30.1790794454208; 
 Wed, 30 Sep 2026 11:54:14 -0700 (PDT)
X-Received: by 2002:a05:620a:838e:b0:93b:c581:2e16 with SMTP id
 af79cd13be357-93ca96f18cbmr421029985a.30.1790794453655; 
 Wed, 30 Sep 2026 11:54:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbf388sm163284e87.75.2026.09.30.11.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:54:12 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:54:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 13/13] drm/msm/dp: Add static HDR metadata support for DP
 and eDP
Message-ID: <uaqcvnjhzcj3d6zoq2begzhu6ld4ehfmmsedoc725ubodmmuxv@mjpvzey6ysuz>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-13-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-13-dbbf8b2b42bc@radxa.com>
X-Proofpoint-ORIG-GUID: nVZJC_ftW2_j7PKjFf5ZyP_k05my5F7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3NyBTYWx0ZWRfX+VDoD+t8kZcH
 4RntotxZ6CO204eojSKHNTGaGxMzlMNiZSm6UQy4gGNiqyPFbbBeuCGccTuDtIujtXghpwj74YQ
 gD1SNBv1DLy6BE2PwKaQvlsRSGt/EvscVZZCNudaa+1YqAmW/KX1oeNOB9+r1hsoyKV/DWHJu2j
 tlZlO91bsmXOd6KD+cCwjwSIQY3i/o6jSgA/QQJrlYGLBlmTIg7PRycA5BiRNXLrGQuKAj9Go0Z
 dsgIK90vZ2oLxQwL//KvbcYra/R0OTVw7bXgd1YM92wQXu/HVwLFhywiiPyVeumrNo396ZIOefC
 Unn/uaAHakVttDuuGiGRWkJsLAd439Fx0PERraN4ighiR2I7KkLbhieIqFnEK2MlEmzlhBa92c6
 RLPRgbzNmYRIT3kxMpTATfS7x/+Is8CM/IxC44TFZJtwerce2iR8Gz+tZhLk0yeu0TBOFnqlKJL
 TmI5rsIEL4FAgxvu4yQ==
X-Proofpoint-GUID: nVZJC_ftW2_j7PKjFf5ZyP_k05my5F7y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3NyBTYWx0ZWRfX0fRVqkhtR0RU
 jjm1fRi7ZMPEzSQl8Nps6HSSxHIvLw1VeFc//IBivYqsCWoGjgh3j+6l86xTzMegZFB40JvxLBx
 s1jeWKxjXGXNa8a16Sbbq5ZS1ApS06o=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abd5ad7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=ksxQWNrZAAAA:8
 a=CHs-XZVRUtj_WxdIW8AA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300077
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

On Wed, Sep 30, 2026 at 08:41:57PM +0800, Xilin Wu wrote:
> Expose HDR_OUTPUT_METADATA and validate and pack it during atomic check.
> Program Generic2 from the checked bridge state on every stream enable.
> Reuse the DRM metadata conversion and infoframe packing helpers, omit
> the HDMI checksum when constructing the DP SDP, and zero reserved bytes.
> 
> Require 10 bpc for HDR transfer functions and reject insufficient
> bandwidth after link training instead of silently reducing color depth.
> Revalidate sink HDR capabilities after powering up an eDP panel, using
> the stream enable failure path if the requested output is unsupported.
> 
> Force a modeset for metadata changes and include metadata enable and
> disable in peripheral flush requests. Keep HDR streams out of PSR and
> clear Generic2 enable state when disabling the stream. Preserve the
> software metadata across teardown so that every stream rebuild restores
> the checked packets.
> 
> Give checked HDR modesets precedence over SDR video-pattern tests. Reject
> new test requests with NAK while HDR is configured and return -EBUSY from
> the debugfs test control. Clear the test override under plugged_lock when
> applying HDR so that a request arriving after atomic check cannot replace
> the checked output depth. Keep pending test colorimetry from overriding
> HDR signalling. Atomic checks leave the running test state untouched.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/Kconfig         |  1 +
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 ++++--
>  drivers/gpu/drm/msm/dp/dp_display.c | 39 +++++++++++++++++++++---
>  drivers/gpu/drm/msm/dp/dp_drm.c     |  4 ++-
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 33 ++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  3 ++
>  drivers/gpu/drm/msm/dp/dp_utils.c   | 61 ++++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/dp/dp_utils.h   |  5 ++-
>  9 files changed, 145 insertions(+), 12 deletions(-)
> 
> @@ -717,17 +727,25 @@ int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
>  
>  	guard(mutex)(&dp->plugged_lock);
>  
> +	ret = msm_dp_utils_pack_hdr_sdp(conn_state, &state->hdr_sdp);
> +	if (ret)
> +		return ret;
> +
> +	state->hdr_enabled = !!conn_state->hdr_output_metadata;

This should be done in atomic_check. Also please make sure that we don't
copy data from the state to the long-term structures. I'd rather pass
state pointer around.

>  	bpp = msm_dp_utils_select_bpp(info->bpc, conn_state->max_requested_bpc,
>  				      clock, dp->panel->link_caps_valid ?
>  				      dp->panel->link_info.rate : 0,
> -				      dp->panel->link_info.num_lanes);
> +				      dp->panel->link_info.num_lanes,
> +				      state->hdr_enabled && state->hdr_sdp.db[2] !=
> +				      HDMI_EOTF_TRADITIONAL_GAMMA_SDR);
>  	if (bpp < 0)
>  		return bpp;
>  
>  	state->bpp = bpp;
>  	state->colorspace = conn_state->colorspace;
>  	state->vsc_enabled = drm_mode_is_420_only(info, mode) ||
> -			     state->colorspace != DRM_MODE_COLORIMETRY_DEFAULT;
> +			     state->colorspace != DRM_MODE_COLORIMETRY_DEFAULT ||
> +			     state->hdr_enabled;
>  	if (!state->vsc_enabled)
>  		return 0;
>  

-- 
With best wishes
Dmitry
