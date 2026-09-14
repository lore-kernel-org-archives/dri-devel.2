Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3211AC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E3610EE74;
	Mon, 14 Sep 2026 13:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNvp4vA/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZjWGJjA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575C910EE74
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:21:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0cVW3588235
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e2jE0G2s1QXqJo24O7Ni8kLViBPEblU5gPqHIox+cik=; b=QNvp4vA/hw71+fNq
 opu1Q6PkFnO/todSJ1WPvuJeYJsk+8gh6dCGViY9KnAf0Hl+D5SuRT1rxGb842E9
 IAZxPc2RpGBNSYbxH/1dfh+4n9OJlvtplukY3LBgOKvs+w6+Gbb3eDIfQdWpyzbB
 bjE9DfCxjJDOlEJ+ZsZgQgDpFrzmS7d0b4RrSl1Qwhq3/0gvm7IB1IiDGfZFVKf0
 aC+D9LED1dUdnVkrs/Mereszf1dfn2IRN1EAVOvQeelFu7tSxOrsx0jeVBBRL0JZ
 CmFqPW/wUGDZS8kg4ikF65kLGm4DrSpQcKXnn8l25UnvLu2WZW5phC9w2Nw6kRWA
 S7KfSA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperg8t62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:21:05 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c846dd12ccso1192370e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789392065; x=1789996865;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e2jE0G2s1QXqJo24O7Ni8kLViBPEblU5gPqHIox+cik=;
 b=dZjWGJjAGSZHmYz37CeRUY9AWkwTTpMziTFySTzjv9x5w33T/XLuK8LjrKdVcpxHMf
 Gy7cUf5T0VrCL2/oCpcRO7eXsbshT0N52CDpolvLjEX0Jv+V1UOrt7MhFMzfWtGcCPHh
 XdV/OCt47BBo+jcXmIx4v7un5w9HjCU6yLpM/NdPlh0YxOtMX7hsSDayWpfef4C0AjF4
 x6pFlfM9btAaSbzQaMbChxS18BXXy1jGg8N29ocGvl73Ujs5nAn4GvQvEnRJo7obgykv
 CH56CyYCOj6h0CZBQ4TYsPAzPvT3wakXJMNu5CFmesu+edZk98JdtzmECnxdzpKR2mSh
 rq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392065; x=1789996865;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e2jE0G2s1QXqJo24O7Ni8kLViBPEblU5gPqHIox+cik=;
 b=MbpCcS5Ks45wUDnAwQ1zJ4mFIszS1r5DsUQwyqgPDfpvcn+0NXo2bGOsq34dQA7A9f
 +4RtwkadRYLDrpsI2F/7RS8vh48wwIveQl3547kTDxyuYqOHj2bpNfjBBeFtQa+FMnPT
 FHWwGfb1x5LX1aOvzt3bf9EuQS4RPZ0SfQoXcj6mXiAcyjPj5Wo/LOUslqgI4whZPctq
 oD968eCwVhAzGLomZQTJ+nUeuJWnz8sLJsiPLm0gq/x3YxqAWfOsuWzjo97I3ku9XyXc
 nroGBtl/vLB5lPmpmS0NiynYji87WI9tvpSOUqC0GXnOQ6DUzsWsI7j5brcawzpNE5Fj
 NByQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvusqb7TlrcruZmRHPOCybDu+Z4sCEi4MtHdcsQcvCwliRhf0jYdIbSG2TyiZ5E3p2krgW1BoxmK0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nacCtaOfJQCje6MzmTRjaJdr5j4xdvLjBbNBOVKbPmfRwhLQjs
 Gm9pJ/nBPVaYlZZs3ZbGrsUh4qd6T1gJyCjKMNN3LHYXsPPes6WSJoVSfG/pokrC+XBasm1Um3e
 kjOOo8xXYaS+DL0xeP/1hmEAolP2iOmZCbjoGJ2ufEZxDiF8PHocgcZ32ghlLhz5iYZz5h8s=
X-Gm-Gg: AYBFou01jDYtIXznlm12uO9J7HdAY3K8X2NJK1UUDV1oIPsgqEzJ+4zoH/pHzvSLNTO
 daRYtUmfdYkbc0FTNCttAMH20SaYG2yGkUE6dIksT2JPZxrkNKcgK7+pQ76qmq35OQ8cPpqrbH3
 Djwv89TG1GXv6Ygyqqm8ONntWH7ZyBiqF/LxPokEoKTxIhvV30kbKFCQE+XkAqFlw2iy33gjfxb
 M3wILPhGyLRPX+wymdR/x8G2wN8PQGlX9QchWWHFvPdY17DVvBjaqGRvtXyDHEUyKdg/1QWCiDn
 XUi7wnVDJ3T/aaaWMB+EHv5QD4z7vbSO1r+HpFVR83U1qWtzWV16nLQnGscNCyZfFe2RORCAGgT
 lX38D/9zOTWYmlh7vjT0KWNCIGRZ856QYGQqezPh7+I1jUhziBSLQxXluWW4+uyW1+cJQ+UXGUH
 r8bj9p04pAE5Vo
X-Received: by 2002:a05:6122:20a3:b0:5bc:42be:f758 with SMTP id
 71dfb90a1353d-5c981b4a171mr1773113e0c.3.1789392064589; 
 Mon, 14 Sep 2026 06:21:04 -0700 (PDT)
X-Received: by 2002:a05:6122:20a3:b0:5bc:42be:f758 with SMTP id
 71dfb90a1353d-5c981b4a171mr1773000e0c.3.1789392064094; 
 Mon, 14 Sep 2026 06:21:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0470d6dsm2485419e87.56.2026.09.14.06.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:21:02 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:21:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: kavakliyigitcan@gmail.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 07/10] drm/msm/dpu: describe SM6125
 programmable-fetch delayed-start quirk
Message-ID: <6zvweenpt7x7qnyrxptzz4h3cyl7azqbekyluekhpcrb5gk6ge@pfdkjp44fhbv>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-7-0e68e63a18d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-ginkgo-submission-final-v1-7-0e68e63a18d4@gmail.com>
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa7f4c1 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=T_hHn50QQsNSpKpO-EoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: hJsad-CM4F9yXtiKgGfzz62uvq0co336
X-Proofpoint-ORIG-GUID: hJsad-CM4F9yXtiKgGfzz62uvq0co336
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5MSBTYWx0ZWRfX63K57TaB4/97
 sartUYrhO954Yw3dCez4xYtzFMPj8FdxO9oZ6zoZFEN6CXyo3lBGKAQTDIzP1JOnxZTBmPMYNQv
 eUTvJuAae7N4GfX1HQOfX/iGdLny5NGO9EtoQs/UXNM1objN4fnXq5KDDjbuYGnL5KKgQ3ZwQom
 ueGUPXcFYxmDMZJuhoPRfkqnwn8IOxF7xcx+iSIK71Qd5GHL47Con4IHhtDQmfq2jCBtbE2zxlZ
 2qPxuaVyc4vdyjZlqslPw0eXTmPUBtrYe0LbrE4S0EtOy01q9xHEVVFmZPN1Kj4xUiKWTplZP9y
 b2dDRwxwsgaQ8c33JCrpuuvGhk8oTYRed1RLxzqVrKLRxk/EiSm6F1gIZ/gSM6HZDVeE3JqfhvT
 3cUqXMRnEZqiKAoMwtCQWNJo/Yb2bKyrnrkRXmUbBBtEDlucxhYGz16iMhh76uG7L2GEd2RWMOs
 YuiPFacvWVI7CBGoPHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5MSBTYWx0ZWRfXx7MOxPS99+AT
 HINwTAPe/HJ2RmtHBb1jebdcslwonX6r/csyalJoiOh/kMpZlXjVBTqsqEvCO0ll6TSbWCZNvFJ
 XKhXSbGl2K9xfCPiWsuax4AmqX3M8Zs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140191
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

On Fri, Sep 11, 2026 at 11:51:04AM +0300, YİĞİTCAN KAVAKLI via B4 Relay wrote:
> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> On Qualcomm SM6125 (Snapdragon 665 / Trinket DPU 5.4.0), calculating the
> programmable prefetch start counter strictly as:
> 
>     (vert_total - vfp_fetch_lines) * horiz_total + 1
> 
> causes the fetch trigger to evaluate on the active-video to vertical
> front porch line boundary. In hardware, this triggers an internal line
> buffer FIFO conflict within the INTF timing generator, resulting in
> immediate DSI FIFO overflow and timeout errors (status=5) and complete
> loss of pixel output.
> 
> Qualcomm downstream display drivers mitigate this erratum via
> delay_prg_fetch_start = true, delaying the fetch start by one scanline
> (+ horiz_total) into vertical front porch line 1.
> 
> Introduce 'has_prg_fetch_delay' in struct dpu_caps, enable it for SM6125
> in its catalog entry, and throttle fetch start in programmable_fetch_config()
> when the capability is set.

'has_foo' usually means that there is an optional feature. In your case
it's more like 'needs_foo'.

> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h |  1 +

Fixes: 9b6f4fedaac2 ("drm/msm/dpu: Add SM6125 support")


>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 11 +++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h         |  2 ++
>  3 files changed, 14 insertions(+)
> 
> +		/*
> +		 * SM6125 (DPU 5.4 / Trinket) quirk matching downstream

Drop the codename, please.

> +		 * delay_prg_fetch_start = true. Throttle fetch start
> +		 * to the second line after active video (VFP line 1).
> +		 */
> +		if (catalog && catalog->caps && catalog->caps->has_prg_fetch_delay)
> +			vfp_fetch_start_vsync_counter += horiz_total;
> +
>  		f.enable = 1;
>  		f.fetch_start = vfp_fetch_start_vsync_counter;
>  	}
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index f45faf87333e89bbd463504ae3219609ef6209bd..db3cbf9fa04a13baf3ac40390757ed24120ccccd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -273,6 +273,7 @@ struct dpu_rotation_cfg {
>   * @has_dim_layer      dim layer feature status
>   * @has_idle_pc        indicate if idle power collapse feature is supported
>   * @has_3d_merge       indicate if 3D merge is supported
> + * @has_prg_fetch_delay indicate if programmable fetch start requires a 1-line delay
>   * @max_linewidth      max linewidth for sspp
>   * @pixel_ram_size     size of latency hiding and de-tiling buffer in bytes
>   * @max_hdeci_exp      max horizontal decimation supported (max is 2^value)
> @@ -285,6 +286,7 @@ struct dpu_caps {
>  	bool has_dim_layer;
>  	bool has_idle_pc;
>  	bool has_3d_merge;
> +	bool has_prg_fetch_delay;
>  	/* SSPP limits */
>  	u32 max_linewidth;
>  	u32 pixel_ram_size;
> 
> -- 
> 2.47.3
> 
> 

-- 
With best wishes
Dmitry
