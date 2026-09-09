Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06C8C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C264610F030;
	Wed,  9 Sep 2026 09:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5MkzCNf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ar4zMhVO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABE010F02B
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:06:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6896c3tM482265
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 09:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oLPtpvb5yV7GW2CVT7bLRhge7vNl77o0SOVL4Mkt9ak=; b=R5MkzCNfXOLTy4zr
 njn+glFqrnLbIc84z1tp7TRk1KEjGyV2AYNg/OMx3LV5ZnTDf6mL4XcNiBXkbB+S
 nie37pqqzLE7wBPNgDete+WZJwcEdpe6r5BIVBU4W4SbC+5g3JCPj+gBNZXA1+ci
 zFxtJtkGkJVZ4LI98OZZopq++yMYUFB1dRXmIPEwjMi/SNW6OdvtfcXkPDVyDAxW
 f1menFYcbVEpxf8dGacC6RpfYUXzan46UNq2TcdntElKtICAE/hrcesOvlp3WDwv
 vF/GOWSzbHziz+lGz9M3Q5qHjHztm3C69OHUPQyzXmHBUeMf+mJ5EQ7zlbzmBE95
 qLkAyQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqf1k510-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 09:06:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9103db79014so16544726d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788944787; x=1789549587;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oLPtpvb5yV7GW2CVT7bLRhge7vNl77o0SOVL4Mkt9ak=;
 b=Ar4zMhVOIdT4pI5FPR6OvS7FXPM6Hevdqiz0XAfjYeAaCJr9zyZ73d9C4QlBAyviXr
 +3lFtazKjNA2zGqJSo/62VcCA2kXT2chaEnm79xL5GTxNhjL786ZUtsHo16PgihgNBgd
 cuvJ8NzXHCRtxs8WmXySvubt66HIZw/53ikwq52ZoV/21I6kFqxJqcTjFu6QqUC9blG6
 8LP2VwPbTWifsdbELlYgmxlqRkU7ibVtNxfIbxDazALPAPNyehpdLb8WIHqZYzGbS1sN
 DLa40ypWPjvrqIKbqRcmrqYT67SDcFzDx5EVmG0XcVMKj4VseRK18p007vOIJq78FfVX
 HjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788944787; x=1789549587;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oLPtpvb5yV7GW2CVT7bLRhge7vNl77o0SOVL4Mkt9ak=;
 b=M09elLxAzmIS66QJ493uG4vuNsVFYozoEwospnDS8C9EveavFwINB9Db6rUNU2qNFW
 L14P0+rvPToF4B8BCEeJ6xZphTNtEGwrqfr7LuYQ8mLz5KdZvqpJAxZTNVHXBiB7oDfd
 EmS7/QDVFrOcwZnAOD5zE/LpRU5WoTaZrYlJIe1tapk3fqxiSsOvD5uOPMB8wqd19BDR
 dvDmQHuYRJqMh66aN308AB2ajHhr5Ui3oL9eTueOw1Iq803J/ymEQw9iGGm6p79Ub88R
 UWlEYhLsngr2oWD6KGbEYrlFgrqpDbj0Xjg0CKyeRwc3okMKsm8LupXhvljaosaIyzWD
 +nAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU9ksVpZp1AbBEGI6FWw5uCnKrricaQlRmiQ0SO8lGPB9NqSbhsz78Gtzowfm2IhiwFnANJyitspk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ldlNer2u0V7+o+9NfN4E5mIUg82t4ObrcsGHhlPSsEKNZZNfAW
 KypUN+/wuM1hGaspvtY61/OwPJzJyyZRjyQrZsAX9Fla5guCTB6AAoOm6/7vR9HeictNfj9VY09
 pz+mNvqaCwHHNsVkhcq7QlZMR1gcxjpGK0ypMKY9b8mPXsSkjIj32qVow/Z+CIdtqTJridZ0=
X-Gm-Gg: AYBFou1CBOISpF5P2d5DXLpz53mI/Bsgu1ctyPZ8XvEqSgamTd32b9885qCkd7+p4+G
 EvCs26J/F8FyEOKOLVHswFvAJkwK4/9/H5pFWF5rl3xeMt0mB64zM3qyWAB59jYlFM7fVxRyhJ8
 AvHt1KvCxRw70VPSF+9FcEZp0mpBFKIAzhtiCAmTDHQJRSEvYg0vj6W//LtWkN34/u3a4V6UThh
 kCdNYrzMAwgjJhoUb3E4ZQEwmAR7UShWiXzDVyT7bu3nFsz2MpwDviDmqMuytui6vVrVI6tmI56
 9hUTrVpqtaJafC27FEDCOTeas3LtVCw001hc57RaXDboD6r7wG2dBK7dA7UUALjt9qv4Bv6ccKD
 Irb4uOetoVChBSGbdBex9vg==
X-Received: by 2002:ad4:596f:0:b0:90e:9952:82e4 with SMTP id
 6a1803df08f44-9104795fc63mr261666706d6.4.1788944787093; 
 Wed, 09 Sep 2026 02:06:27 -0700 (PDT)
X-Received: by 2002:ad4:596f:0:b0:90e:9952:82e4 with SMTP id
 6a1803df08f44-9104795fc63mr261666156d6.4.1788944786500; 
 Wed, 09 Sep 2026 02:06:26 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c26204ecdbcsm648279666b.25.2026.09.09.02.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 02:06:24 -0700 (PDT)
Message-ID: <47f0399d-bb31-48bc-b69d-4abd445727b4@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 11:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfX2XIUrtKbriCY
 qcTgzLu0IHJCG6D4nLavrtvzKa/rRuKHcHq0xEfDsumaw0rR1PxUBUWSPIuiA1mfzPACv1kLFiQ
 s7QPz5Z4hf0JG182T8kZy1kKyCUQGivicKXm9F1PH8jLn+jxTNliO5ZiyzClzqu6NLbBhOXhZ7z
 QAq37nWUj3SkdoBQqeaiBJl8UyJoAxAC+hvJMTKZYWSErTXO/6mBHjF1d6O//AeOnpYJ5q6UaJN
 4a3bYdP6GUK1DP9cka1wKLNP3iz13u2BQAQiNeWFUIm2uo8ghSVjASfOlIa4o0q5kLq8GvwUaCx
 OguDDCIJkKFUooltIxQ5+poRN24K5cyagVV4nUABQaxQHzyLlozwxRQTpJ5FrDd/mgQ12Z55xoI
 AbCsHRvEJ7wxfforBt2xkO0AeQiqaJhLjD9suGjWHPayQ4UzUwfort+yOWnKwYcEtVz2O/5Bgkm
 NNWfQcRLx7hsrWzmQGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfX/neaaUPFb+cp
 Kfj6DbwEZyYMs2n/Tk/hjeBd34BZiZEYoPei/3t9pRBkFG+7TuAkf0grkrogroFqx0CP9NwTnrR
 PsKdoDAuOCKZ09fgm+qvW7nN85aZkX4=
X-Proofpoint-GUID: Kzrzh4a2iKBbvaI1UuxoQGm14thKqDSr
X-Authority-Analysis: v=2.4 cv=JY2Ma0KV c=1 sm=1 tr=0 ts=6aa12193 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=ubtBxe2QYwUAodWgXbcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Kzrzh4a2iKBbvaI1UuxoQGm14thKqDSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090100
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

On 9/8/26 3:24 PM, Neil Armstrong wrote:
> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
> register on A6xx and other A7xx GPUs, use it when running a A750 GPU.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index f9de9329dee3..081e79ea4652 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
>  	u64 count_hi, count_lo, temp;
>  
>  	do {
> -		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> -		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
> -		temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +		if (adreno_is_a750_family(adreno_gpu)) {
> +			count_hi = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
> +			count_lo = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_L);
> +			temp = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);

KGSL apparently *writes* the system time to these registers, is that
an idiosyncrasy regarding how the vendor userland drivers then use
this counter?

Konrad

P.S. looks like a8xx also has this counter

