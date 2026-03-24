Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DD3FEC11C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 22:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117BB10E496;
	Tue, 24 Mar 2026 22:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kuTpNkYk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AoWcNIcU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E970710E496
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:20:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCfOL989052
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nC1F48L2QH5dJUwh3gKzYBcd
 pGv34qmixGco/4UyRYA=; b=kuTpNkYkDzLV8DqxWQfemsFCPxlVBlrZ4Oy+FzK8
 fPhpTc5DlB4TSxVH5Ku5nkO21oBV6jrpzMeMa6Uzd7n1jJZ852SP9dGZWXlZV3Ef
 8/Iaeeg1Bd3qZ6LXhhQ+OTTkBJM/Zx6geppv+u34r/oyWEPD0j+5tsd2RLYykR0q
 hJtyeSZPfIrWY23jnybL6kAeMT0AduBZbGdGShFoj+gzRfznE83KEesHrR5Z7Ig2
 0DxAIgyInMMG9kwzVy+Ke8cUpEBPxNUrRt8vwbE8+AnoqoM3O0bCcL6I1b9jIFTT
 GZ39Vhy1peCIrAPh94rGNMitenQKBJeEWIs4Rhga6uj4jQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m22v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:20:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso16739471cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774390857; x=1774995657;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nC1F48L2QH5dJUwh3gKzYBcdpGv34qmixGco/4UyRYA=;
 b=AoWcNIcUMxAYMcap4X/ar4rmruwj1i7/1wobuzS6MiFjn3W2mExpNU2jOsaNyYKiKe
 +Aof/cRT4SvaNAevyBxCHXlcmfi2HlhgzTTH90KaexDI3nRd/eTE4wGo25NNV+IAx+T5
 BKdp5Ofp36bkzHmnRUBESyizMCmjGwKhzRrlc/rB0C0cloem5/+eLLFw8cjxL7L6DTEY
 iutmaI06GBqmTrxBl9AmMXi05PXiMNJMOZVBwrUqS1N3ptQ9a5LHvd2zt0D0Hi6M5Eja
 rrGk1JFwLeJqVDoJFWsqLadmTSnXz3MAAcXqWc2As2WDspjyWVCtPim0w51/BOpVqEP6
 BrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774390857; x=1774995657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nC1F48L2QH5dJUwh3gKzYBcdpGv34qmixGco/4UyRYA=;
 b=TqY8k4j1V9FYn0H83XWrBWlIHdZIR5bZKhtwznTyZjknE7XCxrTzQFhO9C2YnAf9+9
 m0VU5irQt+GTPNWQFvItEHFi8RnowwkNeqbspQhvUxgXNGlw9440B9zPj07MCoSiMmmM
 sh82MSkthcM0kZsuPIbYd9iuTWfqcA6rA3dbhXDG8HTekxtqlyle7TcfaRjl3+4IgK9r
 M+UF9v+umLPcWkAfFMx+fgkrZ9UfdGOWPKrU1OCUms/GrDzyzELRTetf7H9eZyrtbpq3
 TaqRUaVjJH+w77PdKM4Jk7Ywvhhn40Qczc0/6QAFBgEXxJrGdFJhtYliU0C1033S2nnf
 8hAA==
X-Gm-Message-State: AOJu0Yzwhrj2Ak36edOIawBbn7aEyqMp9nOaHn4KXTZTywZCaszKdYC5
 bF/pdgYXm7Pk6TvfMu6/+9I/wLD0jd+c/ZivT87+Qn7KBO1dIQWT2BXnOJRIYRonUV1C9XMnnke
 Ro6Jyzwk+zEy+zMy0J6xzCqK2pxR7f+lCcgBm1LYZ0+eVThKI5rN1rfBgujgr3ozt3Xp2SBQ=
X-Gm-Gg: ATEYQzxXQ1fNBoRSyPHDVeJbaAESeP071OtJDOJTfYrFVjbsRdxj7O9QhLvffsg+ymR
 T6KZVv7SHS5Zxv2dD/9KAI2KGhxDut0jf7RBcjahptW3vwmvy77O4hdcBK9Wln/qBW15xnU6Zt3
 y5wNSMT3Hu2d4/l0rQfsdPe5xri/25RYUz/HuEd/XqD99hxmQ/Dru8BabCtyasKdLyZt1JqzcnU
 25jpTZiCty2Ukk9cY39ElDeGDOB4NedC+G4fQbPtcNXB/fJ1+M5qREVZPr0rXI4vgRPtN8hbZNT
 DeqdEaiPr8YLyCVNehUmFnxdCKxJebUztuGTHMKzFXIDxsM521kSXT9j5Tch5/F2M9cRj+8j4Xk
 Sltuyc7y22PMMsyFIQ4l5LFDBh7B1+LhwL/+Afv5fibo9/S4qnz9VaQ+qjGCm40zZc1ksZx1qQh
 uzM8276CsmAhWJAAs3kOy+q9GGcWU/l2NRtPU=
X-Received: by 2002:a05:622a:153:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50b80e6d3a2mr20749061cf.48.1774390857402; 
 Tue, 24 Mar 2026 15:20:57 -0700 (PDT)
X-Received: by 2002:a05:622a:153:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50b80e6d3a2mr20748711cf.48.1774390856912; 
 Tue, 24 Mar 2026 15:20:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a28530ce19sm3428047e87.78.2026.03.24.15.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 15:20:55 -0700 (PDT)
Date: Wed, 25 Mar 2026 00:20:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/msm: Disallow foreign mapping of _NO_SHARE
Message-ID: <u45hgj7ypgf4jzbqxlaxihskk7gmfy675ez7lcxnkm4mg2sxiu@skqnmucupa5m>
References: <20260324220519.1221471-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324220519.1221471-1-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c30e4a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=6PLYApUQGsxqbbX7wAIA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 9GPvKpm7vKKpQqo0M5P_quj_uH5s-WXy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3MiBTYWx0ZWRfX9wex7KCSGDlK
 9tQGxZ7aZj67IxppuLmV37826OBMtul/HwN536nEOJxkUtkEVHCE4lx46cQ+0OBBfla2LmNnSPy
 JwBAyd+1YfBImKjYziCSp2MwQDlqChpmXnOJ+JLD81Tq0qZz0foB7vb7zYBkALhiOZWt/dwLRui
 yQc9Ier89eBM7y7foLbetbOUwVBP4EpcO7PK3u6InAMbducjrKpOTg6CGiqcaGWR89wP3fZixg9
 r06qkrsFLD5loJq9jH5E7YPbeHrILib+gcevU19kscbmfku9N8SorB9PBPQFmQ3dGZT8/vL6cy/
 f36s2MtpEZKIqYZ9U/b6hVnZVBAsxx/1orU53ebeX9zpCFgezHpB4ehxrIm/R5zCpa21LykCy74
 U1SnBQgMGKBw0MASLRe9rkWKtXf4TP04yRRNT0gLsR/1Hp3SDx/b+VzSnULtxvmjxmTTySiRtWs
 BQWEiX+FkbdJb32uBGw==
X-Proofpoint-GUID: 9GPvKpm7vKKpQqo0M5P_quj_uH5s-WXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240172
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

On Tue, Mar 24, 2026 at 03:05:17PM -0700, Rob Clark wrote:
> This restriction applies to mapping of _NO_SHARE objs in the kms vm as
> well as importing/exporting BOs.  Since the DPU has it's own VM, scanout
> counts as "exporting" a BO from outside of it's host VM.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
> v2: Fix issue with MAP_NULL
> 
>  drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index 1c6b0920c0d8..43d61e0919bd 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -373,6 +373,12 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
>  	struct msm_gem_vma *vma;
>  	int ret;
>  
> +	/* _NO_SHARE objs cannot be mapped outside of their "host" vm: */
> +	if (obj && (to_msm_bo(obj)->flags & MSM_BO_NO_SHARE) &&
> +	    GEM_WARN_ON(obj->resv != drm_gpuvm_resv(gpuvm))) {

Can this be used to spam the logs?

> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	drm_gpuvm_resv_assert_held(&vm->base);
>  
>  	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
