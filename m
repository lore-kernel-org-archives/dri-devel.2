Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB55606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m32+gmS1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eszqnGML
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F475112395;
	Thu, 22 Oct 2026 07:19:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971FB112397
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 07:19:27 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M70Jik3026421
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 07:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nf3jSk7w1j+okvpezp41LPgG6BghIMDC87ldAfN1ggo=; b=m32+gmS1Ymgq9JAz
 909NtzQRlLitABxi+BEbDuyTVdl0Tfme/4QwK7FCvNftCP5Ro+9ZqYZoH5KdhcXe
 2l0fewiOP9qDBRoBHxPQD9+yeoahvjMqNb0gZghc3DC/t7RxBSwEYemaMi0KmsxP
 JKuZiMMl2L8o1VlUE9MaQ7nw/HEpUf9FKwnyKPx7lJc8ObyytvsYG/uWQAaYckhY
 HVVi2rYzJ7hbE3C0ZnliDhzGigHl+qsz7YtfrIw3gJb4skPLHpv1n1dLakzb90e4
 oIOqlnzo11KIZrSj1XGscGwf0RtpkIUiUJvIeQgVY4a4lWwpi+ggExICml39zqpI
 bLKhZQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93as54p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 07:19:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53568f05f8bso4192131cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792653566; x=1793258366;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nf3jSk7w1j+okvpezp41LPgG6BghIMDC87ldAfN1ggo=;
 b=eszqnGMLQRuFXhBhN0Gmf3+08eEm+4qlphAEb1s9ga5YQkuVALN67r9yV1eQCKIIuA
 wwNJR1oD9ltao3MvFjTqtyxZoFSOgDn5lFu/L8kzKvtQvFjPSQzIGfWmVC2+/omTRYb1
 1b1Rzt+nlMCAmatwuzyf7b5A1/IuC5iQi7eMygytvvuhR+wh6Yo9yVMUZXliSeU+S6JJ
 0X5YATK10NvPdxj4Cc9f+c3/eQJAib56wds2xxZi4C3NmHeh/ZDBXZD8o4jq5KM2sAtB
 oDPyOELOgUA/698uiqfvf6JmehfHxUnmg2HWAPFpi7mDzHAMHwODzAyRrQPK9DWY6ncx
 YDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653566; x=1793258366;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nf3jSk7w1j+okvpezp41LPgG6BghIMDC87ldAfN1ggo=;
 b=er5/+QqsUUZBG+yVoycgOwIC87yuGbpekqF5NbtJlyOjHp1UXMABy+XxnO0xA1Dvci
 ga2eqy0CC1xkrmdDTlhjcZouaQSJgZFdRMHEZI56o3M/hv6IMALK6uTP9Q9VAuW1zmRe
 szElhHCUJAI0rcLfEqCaqgoZTESsHejyf0iEE1Fz8PyT0AdBhA0CxG/aqExqpkh4YtYC
 ldc2n3yIV7PMsFHr6rVFymt4XMLxxYheEyb35Y/UG8rl5SqOFeocrRcgFSIPfGbPECP5
 JTEczrX/ESR89OvLTFmbTpqEmxvrlhykra2L1sXSCPkDmAwuXjDckzFyHpot6wndPUAE
 U0Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7p1Pa2qjRUIr577v8FSkB6J7btfu5rqIhLFu/z7IwFaNq4k9Rq3xJpwFE69rwa6Al4iha7FmyiEo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI+2FtsUOeqRp6ueVZdeDmJCU2VMGRnbrWqDNKn7hA4pFFfHQsH
 i/e+7RVP5Y+OsVTL6u5rLPGO7Kck4y1fzY76jzRjPOTmxlrgrPbcWuWrd/8GLUvNLnfSAnyGrtL
 Ire3YK471M0nvPjnCjimoshXUdJW0K+Zuz2g29R7mVIiA+4at/iNZbYphK1r84KLhxk9O6e0=
X-Gm-Gg: AYBFou1pV2//OqgMOqdkVB3YK3h7eVmfbv+yJA4qV71BKq/hQmCMjj4gm5snWLYvUDK
 JLBY3F+l9xK4rtz9iM5K1uO6rKse8p76h0OzCiMPS3Hn8A3DSnTW21u3eaCdY8S4iPFq0kuKPm+
 Kiz337jQvH6b46+/BjOdFpoyfIYoLMVZ+YXgZ4IXKno/LVxNWhOftXV7Y3jVDZAXu7OQW8TvZeC
 CEfjMpqa19snoBkeQo5banBQ+zZQY49QKnflGngr/iUBR6ssyBeAeU3lky3w/7oew9EcZYUGSLr
 1a7QXp1Mn03IVFDb4g0bxmrJuNnYyefVwUWm4dTkLIgyMKf8t1n3KZ5oQa97h+RS7xsHBb5U/lb
 PDGyyH1qHIrvuTr9OI8anKg==
X-Received: by 2002:ac8:5d15:0:b0:535:496:56ab with SMTP id
 d75a77b69052e-5369b1c0348mr85871981cf.0.1792653565756; 
 Thu, 22 Oct 2026 00:19:25 -0700 (PDT)
X-Received: by 2002:ac8:5d15:0:b0:535:496:56ab with SMTP id
 d75a77b69052e-5369b1c0348mr85871531cf.0.1792653565233; 
 Thu, 22 Oct 2026 00:19:25 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a59b91asm76726866b.52.2026.10.22.00.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 00:19:24 -0700 (PDT)
Message-ID: <aa6dda5b-419f-425f-a9b5-198a9bf7eac2@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 09:19:21 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] drm/msm/a8xx: Add missing a850 ifpc reglist
 entries
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <20261021204244.67160-6-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261021204244.67160-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAyOCBTYWx0ZWRfX3oN6xAKYu2U4
 Q/H2HoXek1/K6myaw/6g754oWy2MTkS7+AfzKaYBpL9tKuqpxgfC5S2oRp6nVYbSpgwo6EX6MSZ
 oYuH5CV5et+WCUHXeCAqrvowJya0K2LXo0RIDJLpjs3ErO6FJnCecAEJxqN4vOKDoOt3/5Dd0VA
 dP2KSxQMWYJugxOtiKHTKtW2qbMpZvZuzPQoOTfej7GQLLkHq93Z4uxd/X75Z940y+CNmc323Gm
 VfmuFLJzhP5OQsaifp5Bd/czBxTW6oy9d6KcbyslcN7FGWSiFFaG0DfDITulvZkweiU5KrNk2ya
 LnmkAWZBQxqYq+JBSRTdORUSjpp3SZAOLh6ZSOB5dzmOJXaBQ3PrgkoX1Pm7E4sHuVj7aiBzzOK
 7CDY61vXylORgJWWKzIfGw0ghk0WQv8rb3q8xqVGaQgcYElMo5WWQJjjqdpGoS2RiB11oHmM3go
 MZSAYFzx84WCOoSUoMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAyOCBTYWx0ZWRfX4tm7cVi4MxsX
 ZqfrOEiy5QhSYsWzJEZnb57voGDkXMDyTWQnyoo201SpkfhusMnkYTmnFMpEMRTmh2YaApHZIGw
 YCk0cq3KU3g+136YA4jOOInjyNgx4GY=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ad9b8fe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZG9rikoeVC3lgFHVExcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: PEtBUtdRY5rdOwCYXShFXpFdOQiM0vlZ
X-Proofpoint-ORIG-GUID: PEtBUtdRY5rdOwCYXShFXpFdOQiM0vlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220028
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 10:41 PM, Rob Clark wrote:
> We want to save/restore all of the CP_PROTECT regs across IFPC.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---


>  drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> index 55a805ab438c..45cd986ad4b5 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> @@ -1477,6 +1477,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
>  	REG_A8XX_CP_PROTECT_GLOBAL(53),
>  	REG_A8XX_CP_PROTECT_GLOBAL(54),
>  	REG_A8XX_CP_PROTECT_GLOBAL(55),
> +	REG_A8XX_CP_PROTECT_GLOBAL(56),
> +	REG_A8XX_CP_PROTECT_GLOBAL(57),
> +	REG_A8XX_CP_PROTECT_GLOBAL(58),
> +	REG_A8XX_CP_PROTECT_GLOBAL(59),
> +	REG_A8XX_CP_PROTECT_GLOBAL(60),
> +	REG_A8XX_CP_PROTECT_GLOBAL(61),
> +	REG_A8XX_CP_PROTECT_GLOBAL(62),
>  	REG_A8XX_CP_PROTECT_GLOBAL(63),

Sounds like we should autogen this part of the list?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
