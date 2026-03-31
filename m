Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEBE10F92EF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6DE10E95F;
	Tue, 31 Mar 2026 19:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqwJKJBE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ml1aX0zh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EE210E9C3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:01:34 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VIH7cS3081559
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VexKsPWO3vps9Z0Pir1xUCYsBIZHKwRIOnURGtzdHUA=; b=mqwJKJBEFFCzPiGh
 PJ7vcx9I0XzTmXiCx0OcIssii6PcE4sbvWAf/8OkSveH0tb1sJ61Ov3vakpk/XOa
 FLVtCLpu/yx2307WNEjHsLYxRybnzZcJ4imeKdKPbbAyDUGqhNSQzjTYnzNegv4J
 n1fUnEfncgcmRkCESmpb4uvlvKwAwEOxPvpzdf46hzgEDGITvVa88Ww6/xopJLJ+
 dz/qEkMRZCvoNhp0VxX7yXAlpaMvC9Gf9hdaOAzQWuPFTsH3j8iCA6fL4PxLy3oG
 BleJO/PzKP5PFoBZmnQx7YRZu/SrVfLL9Ktq4fq93xor29wfE8Sdofi2s4oENcik
 Od650A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kdkr57x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 19:01:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82cd9fa609aso772307b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774983693; x=1775588493;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VexKsPWO3vps9Z0Pir1xUCYsBIZHKwRIOnURGtzdHUA=;
 b=Ml1aX0zhid/NdYqN4UBMCylNOeY7N3hp4dndntue6BgnCAXDSEKmDbvfZpAFBgskfg
 yNFVwxb8x2VcHfJvQCcb355yftAeJ4Jw3WES6CsDWLcrnu7k6alIScS9988KZ5YUeTeg
 BXTvCkaDkvZ56FHVaMDM2N5GXHDlUA66IhlsoXn1YK7D+D2nCBFJ84pww/lfZT+e9rwA
 +0uK6hry/Jon2U+YhKpDGt0R/YUZcQWDcJbA2YTpsmkq8EsBKfi6zCBGsXEietimfyk0
 Gb3TrWWNWuUUNPtJ27dxwhbt6xrh3j9mu+XFsfVyICisnwaTph0/Ms0r0M75Q9yDG8Es
 vrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774983693; x=1775588493;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VexKsPWO3vps9Z0Pir1xUCYsBIZHKwRIOnURGtzdHUA=;
 b=QhpQVURPU5cry1WBsf3BCuBOqFByub7JW/LRQxuOXnwTKSiZTnorYFwEnx4odF15y9
 i1D6Jc2dh7Km/saeb4LKGnbkTJazlIVh0iLlowX/ukSuyB82baGd4i53neA3u1y8Pj29
 PkUF/6h51UOpAP0jQGGvFl6W0GdMrHJQ4bwepuGFwe5usu84B8Zd2n0/9wc58cCt3ROg
 D6JjDkZwkAfDcCy/ylQCUf/gBLTh4sJ4JSO8NXeIYyI/Hul6p60jP7k7IcotBCd39fL2
 MiOYkewLnnIHx7wPzLA/jXABJWnTM934qyWHotsEl7KuIRlydPM2nCC5FhTsArv5fDPr
 maOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJoJyg4PmkkD6qEzPD4r0HBO84Lk7OBw5UGxa2NacUgDJ5ycuUb8WUCakE/ro+Hh3LdVwMOYf8uhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yys8hSxiXWzMILptGrslfYPNKGeeXzg4xn4kYMgK/bfU4OZpVkr
 mZ77SbMQFGA0wyKzqNdBRaHk4uyivWUWp1CSG8pqPNqaBc1jjAY/U4DoNb6NA+mr9UWWrcThBCi
 2PfMgxLer4Owvss7bqW3awPpmvKmdCZHTK/AKtFSZvuxhQkEMAcfjsfzyP0dOPiBU2MgDGCQ=
X-Gm-Gg: ATEYQzwoSv1b0zAoSeQKtTDrnaN/aMkIxzfhKc/Fxi0HrupgNufHNW4rQ3w2R13Np8h
 trNv1NhFDXTqil9C5crjoEA4+p+bV5PY6VobvIaqO/UplN2ecZZG4P6J9VUNj2pAgOaGM+88Yce
 Fsech0rYhWNkPlPQoxYP4x90095ZbeZcZ+CP+9sC3ypdDX8SOHSuTgevbmLNRGxC8w+0BepDVaC
 Hxi/p7F7wLHegkexGhfu26uV977263P+bHWxjsr6TzVagmrvP6kpgGOTA6xrKCj4/X3YFMCy3Ve
 5wnx2x9Q3gNGo2BOExpV0jxF5oFB8UPe0Hx1SHSg7qTlDqzGIvmD70On2csWB1auXUm8lumTDN2
 zwIEk02kX4hOJz1bmrz/Hu/LfvKcL6VKq1RJagDFFHdbkCQ==
X-Received: by 2002:a05:6a00:130f:b0:81c:446d:6bd0 with SMTP id
 d2e1a72fcca58-82ce899bea4mr680178b3a.23.1774983693337; 
 Tue, 31 Mar 2026 12:01:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:130f:b0:81c:446d:6bd0 with SMTP id
 d2e1a72fcca58-82ce899bea4mr680122b3a.23.1774983692639; 
 Tue, 31 Mar 2026 12:01:32 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.231.116])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca849849fsm13471709b3a.26.2026.03.31.12.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 12:01:31 -0700 (PDT)
Message-ID: <da57e66d-cc65-4c2b-be3d-51fe15376062@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 00:31:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Fix dumping A650+ debugbus blocks
To: Connor Abbott <cwabbott0@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260325-drm-msm-a650-debugbus-v1-1-dfbf358890a7@gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260325-drm-msm-a650-debugbus-v1-1-dfbf358890a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE4MyBTYWx0ZWRfXw/IY7blLA3KZ
 wUhd0L5Z/rwKgbsNMwfUu7fXz8d6gljhAksQfIlr4ILuz7WPHUDVRB6izYIMvLrE+UYErs/mriv
 awAMLl1KJTggtgUM1DKLodJtoZ1KqO4wVnbRDP7ZFtuTTdt3d3fIxW19vFkyuPO+iDEwsSgKkMW
 p7vz8abtIEidY6KRQP5xTuCMhMf2lGwaTPCWpZ3EMwUtYv6B8aonF7gsb+1TRJviUBrVy6gj2Bu
 wXXM5hM6dg1sWw+SXg92yhiWrmecG31KG7Dmw/eo5dyr2eoKdbdPYa/xd85lmV/J0SQBpl9r2/j
 zS+BLa0pagpYfrfOIyPDY2EGHot8OMV4gdIlzpCeJSWkYMN/M/QtQ8Nr2fkLGHVE2YrpZjquJlL
 ehZmSj7NmvBSAXT4ZQHsT/mCVTv8w+fwpJNTP10sF3odwzV1H5Ovtv7DQBEUSNltD09qkE0OZi+
 /VFC1RACVkCpgxkQnzA==
X-Proofpoint-GUID: yLK8M0HrhqW_ctYn-VuwiowUwFh-P_41
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=69cc1a0e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=YUf46QchBRIYdusOZX0V1g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=DpCW-ZSMgoX-IK26rl4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: yLK8M0HrhqW_ctYn-VuwiowUwFh-P_41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310183
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

On 3/26/2026 2:28 AM, Connor Abbott wrote:
> These should be appended after the existing debugbus blocks, instead of
> replacing them.
> 
> Fixes: 1e05bba5e2b8 ("drm/msm/a6xx: Update a6xx gpu coredump")
> Signed-off-by: Connor Abbott <cwabbott0@gmail.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index d2d6b2fd3cba303959bd037b60796341315079a1..9699a5b4754628023b67f0eecafcda728953e8d2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -361,7 +361,7 @@ static void a6xx_get_debugbus_blocks(struct msm_gpu *gpu,
>  			sizeof(*a6xx_state->debugbus));
>  
>  	if (a6xx_state->debugbus) {
> -		int i;
> +		int i, j;
>  
>  		for (i = 0; i < ARRAY_SIZE(a6xx_debugbus_blocks); i++)
>  			a6xx_get_debugbus_block(gpu,
> @@ -369,8 +369,6 @@ static void a6xx_get_debugbus_blocks(struct msm_gpu *gpu,
>  				&a6xx_debugbus_blocks[i],
>  				&a6xx_state->debugbus[i]);
>  
> -		a6xx_state->nr_debugbus = ARRAY_SIZE(a6xx_debugbus_blocks);
> -
>  		/*
>  		 * GBIF has same debugbus as of other GPU blocks, fall back to
>  		 * default path if GPU uses GBIF, also GBIF uses exactly same
> @@ -381,17 +379,19 @@ static void a6xx_get_debugbus_blocks(struct msm_gpu *gpu,
>  				&a6xx_gbif_debugbus_block,
>  				&a6xx_state->debugbus[i]);
>  
> -			a6xx_state->nr_debugbus += 1;
> +			i++;
>  		}
>  
>  
>  		if (adreno_is_a650_family(to_adreno_gpu(gpu))) {
> -			for (i = 0; i < ARRAY_SIZE(a650_debugbus_blocks); i++)
> +			for (j = 0; j < ARRAY_SIZE(a650_debugbus_blocks); i++, j++)
>  				a6xx_get_debugbus_block(gpu,
>  					a6xx_state,
> -					&a650_debugbus_blocks[i],
> +					&a650_debugbus_blocks[j],
>  					&a6xx_state->debugbus[i]);
>  		}
> +
> +		a6xx_state->nr_debugbus = i;
>  	}
>  }
>  
> 
> ---
> base-commit: e4eb11b34d6c84f398d8f08d7cb4d6c38e739dd2
> change-id: 20260325-drm-msm-a650-debugbus-80119b64056a
> 
> Best regards,

