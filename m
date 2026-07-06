Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EE0C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB50410E82F;
	Mon,  6 Jul 2026 08:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBg5WWbV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MG91fgn/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5CE10E82F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:44:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641c7B3470529
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 08:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z7ewoKopFZWDSHXaKQpbm185Ui8l9dwnR4N9LGUyBmM=; b=WBg5WWbVCp2776Y0
 GL5MhGPOmGbuGB1bYx85IqFwSE/YFbWe0cwzCSx1i3UCsmY/uYq7VE5bvpvbuy2S
 cog0YFdB57IQ+RCJd5CjP54/2i2MDUtgcHLzY12hTt4iWBp5e7t54UzUxGucerVZ
 /OxxEHL/x2bp3DLwZLsCk4+HjNqFxcz7IPRV+cTW/6XjwnGkHpGyyCK0gAEnBlN/
 mDVZaZXzu6DT57CTUO77jc6AfsPXKofcXNOrlfdPrqpRTduzHt+66mSlxaaa9Baf
 AzjJR72lfUpiZHX1GVfYSkEUAavCp9yE/QHVdWMzPC6naR2UTdk5ArV0wpOixKxc
 ee/SAQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txen7kb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:44:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c27616421so10810961cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783327454; x=1783932254;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z7ewoKopFZWDSHXaKQpbm185Ui8l9dwnR4N9LGUyBmM=;
 b=MG91fgn//xlJC1eptY7un8sJjE5VAsqtC6xaYKKS9CMkzse6kgaF1V4yUfwQaBfknC
 oQvvySr5pXj4/9EmO4ENA31jjQeBLV2OJ6ZwwaRHlbVFyjYs1cZvDdnETKhhPgkr/HUF
 pgtNAL7s9KrgU4nfJVV44/T1wDMNtjaByOjlJPqwTQDl5NOPYN3kOUNusGeHgmkqUQzy
 L+nlaWT9fkX6ja2GFSBjJRo1r77LttyPQKwEe7XOdXZzdt3R2cX7myI+lcKmIA2/PnWh
 fwo3Y/1YSP0acNRiuWqDKolDGvcMQF59Drxo0RXfWvaLYjvtfZ6cy+P5clr1BfjamzTo
 9U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783327454; x=1783932254;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z7ewoKopFZWDSHXaKQpbm185Ui8l9dwnR4N9LGUyBmM=;
 b=qoCovAygTZbQVcVNiP3t8b0F5OM/SKUvz/pqmyqjz5WReCYf1/oIzw3pEMhllYJFOw
 SUg7I23TmDU94lyLpPdatvRXzT7oGPsVhmWTvBJvDQFXguaae2ICmb5+BxdhhN2cV0le
 NUgBFvqJ0OLVSnhCRHdTtYehWeaMt/AauL0P7+ZGGGSI+HB/9Zi0JtB2likB8dFOKHfl
 b8zdd6hBCutTBZyw51+Ozs8Kd4PtMSQu1Gf+1t32yTbY6WgXym8Y5TqvvQNXtvAV3AIT
 YNo63yBjy+2gnBCB7Rkj0cjYZkinZ6B1/uHAXflJUewZDkEgXfUeJ4HBl/jFAUFRzM0g
 J9lg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQDAagSHC+lh7SQvYDLNvIKwPX3ge8HZBuJTL7CLDeUt0s7jBooUqoqGeIqXGufEw2scvj7IYPFSU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkJEOXs666AlrJlKQvSii/rgVovy9kGgjaidgeqOrjcU8D8312
 94v1ofPZvohtdfyednrAnfbVf1NWUnquOMiYdBtVNrr2e9VlvmoB1dd1Mo3RPPi1uzlhX+6NjrU
 vitg44ELLYjaukxvMabzFxjvT9va0vqy1tqcf15Rnf4dh0p2iUzJ4KoWi0+172PuN1GuYhLo=
X-Gm-Gg: AfdE7cnQQiU5j9Iz0lqIly6IPzgjSzfptSfoWxPTwUtKoF0eOK8nlYjiUGSjWhaFAod
 BgHs1uaNY+AtN7dYNYd28XiiNM1q2Qh0TwY3icMbuYjq8dyZnZ0iFzHCAw9LyzQl9YiQ1sndnNA
 U/f3SPbpWbsN6Q6xy9dB3Evfgkr9jgNRlAk1bpFXezRQ7r0GXpK5TozZNR8Sbu9aNBl+Xcq0otf
 x7fUI+1af3I3MEwQPYt7DJh2cg5nP7qIBsX7n+iqwNz6XaGyzLZ/X7a6QCHYajU/aRdJZawW0wR
 W5v7rd61UwbQAe+bz68hsHfAuZ6btuNs1F0Jq0JOAIv75Kw8URKszRVgZxm3GVKfZMvIb+6xXvs
 56CsCCtIQGMwVYgBr3MhSpX0FJTQmg/K6atI=
X-Received: by 2002:a05:622a:349:b0:51c:d16:b498 with SMTP id
 d75a77b69052e-51c4bf1e961mr84275721cf.10.1783327454078; 
 Mon, 06 Jul 2026 01:44:14 -0700 (PDT)
X-Received: by 2002:a05:622a:349:b0:51c:d16:b498 with SMTP id
 d75a77b69052e-51c4bf1e961mr84275551cf.10.1783327453661; 
 Mon, 06 Jul 2026 01:44:13 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62fc72dsm702939866b.63.2026.07.06.01.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:44:12 -0700 (PDT)
Message-ID: <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX5Xbh0dCD0a/O
 YPIYWs6do9bKGD6ZRvCnWVhd4QkHbZBIrX/6BCcjZudCwxNoWNKp5bm6r4X4be/zVNBzqPrdStc
 +kNESQhNSVfWepkqxP11nywx5Zcq+38=
X-Proofpoint-GUID: S-RkUzUXuyBzXOwhFCwr-4SFxl-tIqRO
X-Proofpoint-ORIG-GUID: S-RkUzUXuyBzXOwhFCwr-4SFxl-tIqRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX5DcoPKnyU7Mb
 49sJ8KSYwl5ikow7f2LOgh2es3wUeBXXMHxtcoSwZkO59jEtIWbctkYNnqAJd+CNF0OlxfYhUSN
 zkngClRqYW2U7GLXR3BbVFtIDlaHtcyr1Mcl++pnSqHmkXSg+uKwFvvi6LsU+RXtZsfboQe8nZ9
 3wG9e3ePo2bSq69Aeilr8RUhmqi98wh34B+6zgG3kZcj63Hqx6cyAYIk5j4IQE7WrtGybWE9xnH
 L1XeVD0l9cQfkiy6GmNNkAoDHjsl8rTXRZktmXjKke0kbUyLKBBYbogN3lFeAObgHtkrXbBpFbf
 UwPRYVPFK0EogMaeIq24vnxNHbboiQMFogwQEzAjKjQUwlk1ulTpf5UMHuCJC4Isuhh4lZVBhQZ
 /N/ft5k9WX3ocU2FJ8J98xauvRYjQVai5EmlkDAugXNl2Xjz6426YP4WWwygVfYHHvj8Yf5vqpz
 BaWCzIsrFLHAUN7Giow==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b6adf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=NiyOziKYwqrvXK6gfTIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060086
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

On 7/5/26 9:13 PM, Anna Maniscalco wrote:
> Program all the register needed to start up LPAC and send initialization
> sequence.
> 
> Additionally, now that the LPAC ring is live, make the code aware of it.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---

I believe some/all of these writes need to be guarded by if (has_lpac),
as many GPUs lack these registers and there may be side effects on
others


[...]

>  		a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
> -						      sizeof(u32) * gpu->nr_rings,
> +						      sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),

Should we rename nr_rings to something like nr_XXX_rings
where XXX is some uarch-generic (i.e. not SQE because we also
support pre-a6xx) name for the main number cruncher?

Konrad
