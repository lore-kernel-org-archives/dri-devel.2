Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8437ECD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34A510FE0B;
	Fri, 29 May 2026 12:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IzxTSQNN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HeAuYQy4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E552110FE08
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:07:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T6LMmZ562448
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=w5W401i4KtUyBJU1xtt1ZS7P
 g3gpytfeIc6F79YZRj0=; b=IzxTSQNNRau6wTm6QjwiEcWEYWcwDUJIIOcyZDH4
 +75yNC/IEgXGrtKHTWA3JeifFlGq0izbvlwr15ZZ4YEWqSV4wqB86zL4mGAzwu+X
 JowRHucgpM493ZTCE1wWEhzdlls8AmcqjTzIrpsSo1LqotH+C+eE61ogK3fam6uF
 tmqlQsyoYH/PC5xTZE94VD8HOoAVK8qVv+1lGvgWpi74+7kxvaJs6GaTb3qzsfbT
 mOeJDpivXjKjjln/FR6FycAKLC0qh5OppYeur/bbFIoPsephGJb8soTtTvSDP/r0
 AHlYlg+ULj7289fykoKOJP7I1OAsY4p5wAfo9YMWH/pN3A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eevug3eyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:07:17 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56f6ef62af1so28705962e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 05:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780056436; x=1780661236;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w5W401i4KtUyBJU1xtt1ZS7Pg3gpytfeIc6F79YZRj0=;
 b=HeAuYQy47fkdyIrzgvV3Xa1SgGXA5ndo8kgc2L53ppM6KufSRF81W/uesDgrQOmUfZ
 qW4pJFn3xt3B8BDRpsaZRHA4Rlzsr3oX6QkBFq7qPsSVFRl2Ao5P0+DpGJuu4nw5nCNj
 +PU1NE2OwpRwK7WSmqAMrYbPYi6jbnNltTWQjgQHnoNb566rRHJpuy4NRtjdOveFCTB+
 4mXJQmC+6hESOGY4GH31drWEzqvu/3//UMTUEQvRKKsAhMdJ8Fd5cguXrWGLkvZpSDFH
 6JqMA+31s5ZUw1aq1jNoIErHMBnaThtD7bvvs7d0a37+VI0+J3Sa2tpQsSxMQfeuhQC5
 l+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780056436; x=1780661236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5W401i4KtUyBJU1xtt1ZS7Pg3gpytfeIc6F79YZRj0=;
 b=RaanUcdoz/g8Fhov2+EsuQqXIXQk2AtZR2tCsnCRY+T6gbf/fyGVdzuKfqy8c7mrVT
 M/+aaW0y/GwKHvEGc8e4hq107p98ISo/DPmR9NUmRa7MIUKpZSt/N/ljzNJKwNhQv71W
 bFNxSdhVVQ5V7pg469Hk3dY+kFbsnSWcQ+HMuv90HA6rMt0ezDxNP4dEk9TA9mgsbyVb
 vlwreFA2M37XND3g5cg+4hDm9AdW8HYU7GaLmDkD2OKsu+Y4H6gbVazlOwxzv3wFBX21
 FhFh5hZFX6Dhmr83CNrKDRT7UAQJCpM06yLO67ixZp0nFH/CSLJI1qwT7G0xl8CApAfC
 7wSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/da9/r3Urvph46x/KDF7ZHUUfMTOetSNCesSlKMgK6A3vfO1DqMlnEz9fyIyI23Z7u6dUPi1LdIM0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3TzbbGKjLDRN97wDSVWE3GyFUq6NB7Y1BcBVNE5D3tdmxp7rY
 SDb9rfg6PW11BjF0cgR225KpWX5lZu4NHAjR5iwO9UQCYNlYa6iL+NttKLGFWnGKCzJGZETe6Zj
 53OelWuGNctSUstN39XI1dqTJj+JjS2TLBhTLF1mgjgov6LMXnroWq0qDVxMCE2zueOeii+g=
X-Gm-Gg: Acq92OEi76kV2Acj37fF/pAR3NOe9snUhc+pIZF3ytu7xPavCoQMEaU/zT8aVqxgayt
 0IRjuCAF3ePtsM5yZFlneabL0irU2952vxG9Zrr53ed5YW7xCODuwrptUy6b9JL9teBRjrEGOeu
 kOJGk36D48U5Z8PesFcH4O/USbcYoyNDjXoREAnjLdneZyBVwtgZ0W6fDJ5/3J9/dK53pM/8Ppu
 H1OUe7pH6RgRk3OZ2QhnXZBVA5627+HMNCn/KO75+t9R1pGfXORghpOQtWMK0AK4yAJWqbQ3Ev6
 ki3FvQcqR7UjOJuCKzDEVAhANix6s91oQtGG6FDrsBmQTA1yGTPP3eT0mCzsQbE/33ReArA9B8o
 Gk5XhwbuVaZcj8bXjss/HC9ZBMAPW+umHHiBZ/SKVu9vuVzrilk9GxzliwwCdhhtZ32m1U3cD8L
 y0kTmi/kR1aoEU5I+Hffo6HC4klD1eCaOQ8kHmHSpIfU+gVg==
X-Received: by 2002:a05:6122:378d:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-599f6cb1402mr838118e0c.7.1780056436443; 
 Fri, 29 May 2026 05:07:16 -0700 (PDT)
X-Received: by 2002:a05:6122:378d:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-599f6cb1402mr838086e0c.7.1780056436015; 
 Fri, 29 May 2026 05:07:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b596664sm235308e87.39.2026.05.29.05.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:07:14 -0700 (PDT)
Date: Fri, 29 May 2026 15:07:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Daniel J Blueman <daniel@quora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Restore second parameter name in purge() and
 evict()
Message-ID: <6l4aqnqhmhjg35ofoofu4zkcfn5ua54wxy7vjnxnmhew5lspof@vmjkxlzb6vj5>
References: <20260518-drm-msm-fix-c23-extensions-v1-1-0833559418c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-drm-msm-fix-c23-extensions-v1-1-0833559418c7@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyMSBTYWx0ZWRfX1MmCJo4by1OC
 LVcJJ9VvN1WSD2Hu7AOArgDfGTd89raw8ocGOIQYyzbbmVrqeXB1XxgEguU+Km0sYqYTEm4Py0C
 2TlV0m6ild7/VmkyvcSccZ/igNnSm8RMXUB5TyWH3oRC5M/jjD8oPOvPGIrX2muQY9zB+EHj/9u
 bHNOmN3Nhn5fGBs/gmTY6yGi+mV6PM+FWGxCPXeSgovR/ZCrebLCNAGtuW4S0zwQvyrUqxf/wfB
 RhCCZbaJJrHa2DMV4dvo4jtYy3vcRTDiuq6HIEg1Mpl03zFJU4JBfG9So88Dydpaudnzv8BxtS4
 DtLT6lH9Xhw87KXpawO1m4HenH4TbE1bjSp9UI98F60QN5Mpnw4OwzleeMgWB3Q8ecELGYj7DyS
 Fjnqbav/UeuZRJZu8lZY2muodnsW209yxd4MnBVIuMk6Ci4ppiTx0fK8obkMxsQNCyaytXhDc6P
 8aWwZ1ZOonM1irNNfmw==
X-Authority-Analysis: v=2.4 cv=SNBykuvH c=1 sm=1 tr=0 ts=6a198175 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ooG1LIPqdb8N2y3itNcA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: ddXXBWFd-PF6qmCEEAPYSw3IXShpN73C
X-Proofpoint-GUID: ddXXBWFd-PF6qmCEEAPYSw3IXShpN73C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290121
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

On Mon, May 18, 2026 at 03:17:14PM -0700, Nathan Chancellor wrote:
> After commit 3392291fc509 ("drm/msm: Fix shrinker deadlock"), all
> supported versions of clang warn (or error with CONFIG_WERROR=y):
> 
>   drivers/gpu/drm/msm/msm_gem_shrinker.c:105:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
>     105 | purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
>         |                                                          ^
>   drivers/gpu/drm/msm/msm_gem_shrinker.c:117:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
>     117 | evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
>         |                                                          ^
>   2 errors generated.
> 
> With older but supported versions of GCC, this is an unconditional hard error:
> 
>   drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'purge':
>   drivers/gpu/drm/msm/msm_gem_shrinker.c:105:35: error: parameter name omitted
>    purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
>                                      ^~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'evict':
>   drivers/gpu/drm/msm/msm_gem_shrinker.c:117:35: error: parameter name omitted
>    evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
>                                      ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Restore the parameter name to clear up the warnings, renaming it
> "unused" to make it clear it is only needed to satisfy the prototype of
> drm_gem_lru_scan().
> 
> Cc: stable@vger.kernel.org
> Fixes: 3392291fc509 ("drm/msm: Fix shrinker deadlock")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
