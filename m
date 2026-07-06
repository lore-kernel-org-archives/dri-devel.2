Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12084C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DBB10E12D;
	Mon,  6 Jul 2026 11:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pX48h7Ta";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWPX9gIp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F9810E12D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:09:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxUCd387550
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 11:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OfCbzrTcTzIGJaYxsh7AivF35GEsErrQAAwwonLRtdM=; b=pX48h7Tawms+LHRc
 QZc63peXyBM/dHemiteAjFnn/Dm2atMcCHHtHjAIGSpEwCzEX76VoWqNvieJ7rMj
 jhuLKOBhmpaOeHAlo947z/JyekqWGxbqJGELhYB7aQA33Ur3W4V81uTtJuQt6aUe
 /MxPQB6y04jxto9wPJ01Rgrks3cr9GydohIvzflZsmnyRbMnQw7jtzRkiFDuO2i0
 o4XEylXqicGHOBXUX7bspiKuK0uPsI9/0CDU3rDpVvoFSZJx8iBq2eX0+T5ex/dL
 cDQSYLJvAwrDYvPQOzv+bINABbftfw0HftfrJn7TStgNXU9IsFNkO1wHHqQxsbyO
 gqyJ+Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r09a7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 11:09:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfa45b280so7956101cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783336185; x=1783940985;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OfCbzrTcTzIGJaYxsh7AivF35GEsErrQAAwwonLRtdM=;
 b=bWPX9gIpTZUQfIt0KOke6n9iw/gP9DpoGZAgel+LoM726Z4ry+qJWxUIUWRgu1Syzj
 btgYjxL3dkeLylI+/EG40cQvsQWduYvFLesPBrxzFubLRhnxFIlSg1/dCoy7gmNoYxM1
 Fk7k1X1BDrykG+bKT1EQlGnX+rmLHUcHuybHko0KxGOHjZCvM578TV5DxmDhcj6RcVMC
 0BsCSQB5Bf8AlVom/PwkPqJqZ1IfE1HrVhndzXyf4URPt2HRh8bAdM5c2LJtIwALFffV
 ctusrGYo4CUsyQLSfXoHUOWhS+2BZ9p8xQG5Jk0kI0R7kSPrz2gnC88UR9/Maey9TlB6
 QEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783336185; x=1783940985;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OfCbzrTcTzIGJaYxsh7AivF35GEsErrQAAwwonLRtdM=;
 b=oeUYYVx7lGBF1Q1obrlRrQuPQTQZ4KdutgQtLvcYSWrVbBpNV9Strz7czI9g1or3Ju
 NAUN12Jt5OKq0x4iduzb0mfphAFPsYuZ1KmMyP7pLnDgTk6tYoMq5u0V5KtH12ERKrX2
 xysZ9PG7qboSQAQGVNQxRG+Ly65MR27Fue5nxgIWOjtXlocEdNWuwbh9YyVkEE8GR2UC
 9NWhxa2EhV5TdPT1+IQ4ZOwke6MGE4A74UJKisN1wGi5rTY1hLt8DxJatbsWXh+qTeuR
 gLIlMR1K0r+9zUrJm8+lNY7OYfgtUhzoPDce7q5lo4GQyiUKb+YNl8/UKjdROWOhg7BO
 gGRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rosy1t4tVTrheYS3exF50WlxGlTTJ+3esOurErkcRyX8MPVnYSASa9HM5fHQqGCYaaiEnlA7vG1jb4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/PNE+Mc6MUgb9r3Jm1mK68lVT8hY/LEKvuKpcz/cyDxfyspsK
 GiRmQGpu1gf7EEAANqsuH0DPlpUSbIY26ibXgaxtLVLLLJoGGQL3AdPa8Y7MTgUPf6QOa90oqno
 O8JBje1xBp/82XQ1PSu9eU0bijX+8k42nnV5TMQbGB915MlI0NUUHaagRgWNROWM9L4qtYbE=
X-Gm-Gg: AfdE7ck2Y6iBAfNAA4/R2o8gjm4vlzqg1tI1wuS5rGBGuB/d3H/UNGezsbouv5idgTJ
 EY4vrZIZ17JPO5mhp7M4qhdPTtthv/wNcjTe6Wsn7ieap2m+WDDjB8lukvPhIxKCaj/Eo6XnfLM
 viNy3xC1SKufrNJYdzNQrKqqQ13N/6Puqp303ehAvWZEoyEAKDtcsGhpo/CQfVJKp2vnLk38LIP
 t5mS273bXGbC/Jyp35mj36TkM9zz0w0cmQ6CW4scyzEC9T5hNmcbSD3tnFgt17bdGwEwijXQWLL
 2Bo7IO+4bM7oFMKQxDs1hu6NgZiEZ8TWKYu8U4A5oJ/iDWJug5uagP7/0LLUJyqdkCJ61DkWogO
 mRJ16wYFrdyBWSJ/Fww4lVIuH38u4cjI3Buk=
X-Received: by 2002:ac8:5d0a:0:b0:517:5d21:9899 with SMTP id
 d75a77b69052e-51c4bdf1baamr92272841cf.5.1783336184798; 
 Mon, 06 Jul 2026 04:09:44 -0700 (PDT)
X-Received: by 2002:ac8:5d0a:0:b0:517:5d21:9899 with SMTP id
 d75a77b69052e-51c4bdf1baamr92272611cf.5.1783336184315; 
 Mon, 06 Jul 2026 04:09:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c4b52sm721233166b.47.2026.07.06.04.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:09:43 -0700 (PDT)
Message-ID: <13522517-8e40-436a-b6bd-5ed5f68f1da6@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:09:39 +0200
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
 <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
 <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX4EoSYr3C5qJ0
 Pk0xkONURN0zO0d5L/PCvafjvWvDmKCLWXBfjJ9hekv8oeCfqW7OFo42oqpAgTJ1qGTlUp7425d
 Oc0BioxyIauE+JrxF1a5wtNnJpTSJzalU/7wcu+lIJLEQ64E8Rq88miTy4KYG7ex4lcuNmvwv2j
 HsuNPuEI9+WGy6nWu+S1mxayXeZKsWOPWxZwlla4rr6FPQ9ui41iFJyRTXacyNvvkHEPgRUC9FO
 uaAOP9NNJBKWlAJEldER3Kgx2pI9gHuv2k2ZrGwTLYvBbBuqjSM1BS1LaYyASZcvKC6jjNI1YsR
 NQGRJ3N00jAB2e/iaHoOq9vYUfJcQUUJOioYxuxDARaV/+5JS7/IG7/KfYCiYlddL8+HfncZIZj
 joqtLiaZ7uHsXQtGYWdRnkKd63IOamWQTKnRwHL6fEhgF2tYVUqDMw6q/F223HKVUSzL84gnox/
 fYZIMWynajiHyAV/hrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX9U4A1emmvtFE
 ZcEK8V4XC2ihiTEPPhlMaIgIR4HkOiluHkhgTNsQpWz3jVl/Z+2xo7pSRymF3QYPf1II0uSMfT4
 KV88YzVCQi3Wu10ZydHjxcrhAuPF5So=
X-Proofpoint-GUID: Kmmr-YAI9syoONgk4zRNNe3LWxbzNQ7p
X-Proofpoint-ORIG-GUID: Kmmr-YAI9syoONgk4zRNNe3LWxbzNQ7p
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4b8cf9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=mx_oZ8J27MAni7-wUjsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113
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

On 7/6/26 1:07 PM, Anna Maniscalco wrote:
> On 7/6/26 10:44 AM, Konrad Dybcio wrote:
>> On 7/5/26 9:13 PM, Anna Maniscalco wrote:
>>> Program all the register needed to start up LPAC and send initialization
>>> sequence.
>>>
>>> Additionally, now that the LPAC ring is live, make the code aware of it.
>>>
>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>> ---
>> I believe some/all of these writes need to be guarded by if (has_lpac),
>> as many GPUs lack these registers and there may be side effects on
>> others
> 
> That's correct yeah. I'm not sure what has_lpac should be though.
> 
> Something we add to catalog? Or checking if it is a gen that has LPAC?

'Generation' is very much an umbrella term that we can't put too
much trust in in the feature department, kgsl defines it in the
catalog, per-GPU. I think that's the right thing to do.

> 
>>
>>
>> [...]
>>
>>>           a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>>> -                              sizeof(u32) * gpu->nr_rings,
>>> +                              sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),
>> Should we rename nr_rings to something like nr_XXX_rings
>> where XXX is some uarch-generic (i.e. not SQE because we also
>> support pre-a6xx) name for the main number cruncher?
> Qualcom calls it GC so nr_gc_rings perhaps?

I'm not in the right part of Qualcomm to know, I'll let others comment

Konrad
