Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81BBCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F2310E7E1;
	Mon, 12 Oct 2026 12:09:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EABAF10EE8A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:09:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0ADS2275878
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=y9ZrP8rOv+ZZPiV33sAcp+pu
 UevN4wv31y+rDLa7hTw=; b=UWi2RKW2sZm6BnjUxRR2CvQBnKnxgU9HZhDsLrvi
 LzLSc6d4E0oVS9yGxgs/zaE2FTKaLwzs21iMLwwSr6/4I2WXr3Gokte81URTNt3x
 PTPSPVB/x1HppSgyVmHeQcQQRIsk7UPBheJEVEm+39QqlMgg7iCzxhjB9bJCOKSx
 sHjGOFbMCofnBqG2M3js0yJK9vwzlA7BjFnCrSDg/nLpIKyMZoDh+DVpRB5WEns1
 Gb+lSDI9qlThzyMNCZlR847MAjdUmatY0ejSIlBAaH3lsH4zVIVyuaQ9DHoQIcEr
 eqBpYSPmW1+2UKj2Ll2MKIiMUTsKzs721U6mqki7RuLFUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq17t3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:09:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso794222685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791806953; x=1792411753;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y9ZrP8rOv+ZZPiV33sAcp+puUevN4wv31y+rDLa7hTw=;
 b=jYSZet2yMRHrZfq3Hg6kmwC/FceuaExlSdvAiSA/dPPX72jUsjILbks9DKGuJ2JPi0
 6qsO/ZriRTtLbediKvzsHr0nMhuCETyQ9NUMBsaH+dBE+UGz/30OrewvvWw4GDLVhIRg
 GhIY4MHbDkWqynGati8LEOwnrujVvNCkDp0vKFCIeY7RNJZQj1iFfCUcmDvZOMIU2eyv
 BI93cepRlewxpbFDiDXDaqVtAJ9r+GAWpmNnbVr28ogeILX5MjDPug1FY7+0+hvcWE9B
 kXuWVOfqKG1d01p4uTmlkGS8/hxi04MWh1JObbTyFiIhBcf7E5tHqWR9+sg+xLgZr9GI
 tRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806953; x=1792411753;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y9ZrP8rOv+ZZPiV33sAcp+puUevN4wv31y+rDLa7hTw=;
 b=MkOHq1oKPbT4gDTth1cw5YoYrPQ5B1dnS/FBPP+47J3H6PxNuejTtEvaU4tZbCt4wm
 wxRqzwgJWYXk7JeFKLPOyccNeKfrGgr7TBDdMx0RcZv/sJd7LHHcKVcPimyEScMJSJ1f
 M5huLwOZC/oi60mV49w6mo3DL6XMQ87TDsH+bSmQSv68wl2MqTCJav2Mc40SFaAYfzH1
 zEOc0aILC2L1z91PPyvH7WNLd+7EzWwnKczIVgVVcQSTCPstSrtb859ANB4W2BQn+Kpw
 zosEBU9qNZI9rKHoZP4jy9UiKpLJ5vLBuuOdJAxY0oMj+ZNiKj728uZ7hfa4peP1C9NJ
 0AzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbLh/NYqqb6CVNAbjwkrOGY5HPuXQ+kpAPHJowNPZKyBJHa3kKIVPgYdAQlG/fEIH9zjc+GD8XCeo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/7kB4NRXhAeJ5W/Xnmoe8WfIpZ4zXZzmB5b+Ik5K0R3H11926
 cfDeE5dCOQnfJOaRESFTSPy4f8+jNAilqafMyMSqdEKzuosiep0Xz8Y/wPo7nC+DbDpwuTIExbX
 fou7uI7YyDCT8bUfJJRDKbaQyapBAObx7+RlvIFUNrBt8qHSL0zLuayxbyog2jq4IjIplb7qYgb
 ZhIEE=
X-Gm-Gg: AYBFou318C6ICuI97GZzI8n0u9I245vz9/HAEacxZGMoFDB/76GXxHrC3jGdyT/z3pC
 kdn/Qsm0QwM8tkd8RJtHxzYj8gkI8yq21xp0DBsHNdS0OzPv/MOAEBcisJGkb4ZgBpMVCGNbAeZ
 AtQ8KCA/ZUzLjdSmZQI+Qyv6TI782ZbtuHPcK3L4uJTLYIgA7yCUcKGbjaqhDhUmA0OpPtKL86J
 LC8zHRHL0aGr/TqkUfyLJsidEy5HY1AIwzGQnw8c6XNcSb6HErRiuG3QfGtqStyKzGDl6c1PUgH
 J5E6XGeT2AprM8C3nD8ZGnkKReEQIi7Str0lHy8eJQXIHIktDGeFo3JQETyGBa7Y7Sjli3HL0UZ
 Q95z3BBYhueG/tIpiOk8T3Vlt8jSZfuZBNwL/zLXuOQaQBODFZdeaNahg/1A1mdnGox+XHP78Zd
 FqaptJ2kgXyCuB
X-Received: by 2002:a05:620a:2841:b0:93e:618f:8127 with SMTP id
 af79cd13be357-93eb95e2a8dmr1542315085a.8.1791806953130; 
 Mon, 12 Oct 2026 05:09:13 -0700 (PDT)
X-Received: by 2002:a05:620a:2841:b0:93e:618f:8127 with SMTP id
 af79cd13be357-93eb95e2a8dmr1542310685a.8.1791806952605; 
 Mon, 12 Oct 2026 05:09:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3caaafbsm31078121fa.19.2026.10.12.05.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:09:09 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:09:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] drm/msm/dpu: do not assume a merged datapath when
 validating mode clock
Message-ID: <iqkzz4wnfeeul4nkkemhcvjluucot5ia7pfin5ghu3tkwkjfso@raqzz43t7lxz>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-2-fa986071c3c1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-lm_fixes_final-v4-2-fa986071c3c1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acccdea cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=7qsbTKUd7HEg1-mJ9OQA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NyBTYWx0ZWRfXwAMtBwoiZQlk
 zOwW7Jhfr03J9jqwnSpwFyjKDmgfbSVvQD1Gtseu3xmOrkmz7KLZJaIRk5a9Sr2AgnSkzW3eGaW
 UIzvpx1o6+7edChKbjcjhCDHiDipeVU=
X-Proofpoint-GUID: CaYgwm6eMlfaz0wYQ_Q1QT6x1O3Y13yF
X-Proofpoint-ORIG-GUID: CaYgwm6eMlfaz0wYQ_Q1QT6x1O3Y13yF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NyBTYWx0ZWRfXw07hyikdNpZF
 hSxfKXXit8YD7GpnLNGVoEj6kMSc2w9lAYpxldtTO9nde1gY2t0E6SKGiC7CGiugnw4zDt5fUix
 +LfoNKP6jgnOIOg+7d9hW5Jkepm3Nr6+9TkDT5iJmjpnMyV8doU5GS1rSPhd2+GAzSBYbf+RdK9
 Ec3WX2s9F06PdGe5sQNxEEl5RKeIrL/5y4JPMyqiKtn9XjYkK7/2QjwmFjdOAAHfeoYRs0DJqBo
 05MCJ9A8JaNUK9vyQybKTtRjhjykavwxS6/Sd6Wk1Ew4dEB5O3K2tSnQNq21dS9D/mR8k2HNq9e
 s1lRjTsgHJuMOmw9dRt7hAFOFPL83HsQKNIeox8bMJjUVXrNn+62Ae/RwuMQ+FCvwMsOQJay+Ij
 CkAZ430t4Phlqs2srnSauXOwpKWGl+LVSyfmy7FBMrgaqm49RaKe88Czvi+QYFhXNH6favDxFsu
 L/Wp5pWnGYflNKBNDng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120047
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

On Thu, Oct 08, 2026 at 10:53:48PM +0530, Mahadevan P wrote:
> dpu_crtc_mode_valid() halves the adjusted mode clock whenever the
> hardware has a 3d_mux block, assuming the mode will be driven by two
> layer mixers. Modes no wider than MAX_HDISPLAY_SPLIT are driven by a
> single mixer, so for those the check permits twice the pixel rate the
> datapath can sustain.
> 
> Divide by the mixer count the mode will really be driven by, as reported
> by dpu_crtc_num_lm_for_mode(). Split modes still get the halved rate,
> single mixer modes are held to what one mixer sustains, and parts
> without a 3d_mux divide by one.
> 
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 0b51a4c5db57..209b25dbeb6c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1631,8 +1631,7 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
>  	adjusted_mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
>  							    dpu_kms->perf.perf_cfg);
>  
> -	if (dpu_kms->catalog->caps->has_3d_merge)
> -		adjusted_mode_clk /= 2;
> +	adjusted_mode_clk /= dpu_crtc_num_lm_for_mode(dpu_kms, mode);

With the 64-bit division fixed, LGTM. When submitting patches to these
drivers please make sure to build for armhf as well as for the arm64.

>  
>  	/*
>  	 * The given mode, adjusted for the perf clock factor, should not exceed
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
