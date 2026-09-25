Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E3DC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 20:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6694A10FC6B;
	Fri, 25 Sep 2026 20:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QGfDl3Bm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K7UZ3uKG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D680410FC6B
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 20:35:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIo3fP2036025
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 20:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A78khGmA9qUjc85WT541K4/S4eJFRAYnFuzWGW94HHc=; b=QGfDl3BmFP6eS54p
 VdvF6CjQXuQ6nYZOAfMU6xfFfMPTZVSTYW1YJ5JgLqZH75KtmnCQOt9lOLVE/j3E
 5gJdAqeA14u1Azw+7KSArq/UO2map/B1Z6nvXTgfWtQU9CxeAO+QzZQMqpQXkxGV
 t5pEdnuyYyyX2hwRzFYBd+EqRMRp9asqnu0zk1J3tEfnnF7wF3H5oqo3CfSvqIT5
 JNBHfbgqo3lXuc4fBCDOXrUoQZ2WvL0GU8Q/MXo46yUMrPtkJWkkLwpHkpLaPaO2
 3swkjvvcY4j7PyG74TeVfLr58Zdj1se8tlhbtuaHTTyfSnzOiseT/7y+p6rtlvvb
 ToxmFw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvd3rwwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 20:35:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-342b66c0b06so282003eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790368545; x=1790973345;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A78khGmA9qUjc85WT541K4/S4eJFRAYnFuzWGW94HHc=;
 b=K7UZ3uKG/RyuEiEF0m4nSYWm0mfiOosOVteOuIIJyvc2PezBRU+Iy9aAG3cpsXyU+e
 JQgn9V7ypYB+Xr5aAb22UnN90WSHyMAUuR7D/iM0ooNUsmtkgM8JvEMKnXPrLPRhQwR2
 Q9JY6FFa3byWwamwKvTOUdegXxh2qlCgPJb6nnPHJhpqRuYBFGOqTz8ctWbB5y35Tzih
 6ACh4gjS83Ea+Kkm7HrzySCHxEaamjh7Nib/fMtCQHzCvRjEwpwuHmlCQ/Z9uH3xyRDa
 c9ZOVVLUKw6fdjt2yzwNuNFqM7AO861TbgtLPLtYKJSF4C1RK+5EUzScO2KXNBILdp4i
 wpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790368545; x=1790973345;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A78khGmA9qUjc85WT541K4/S4eJFRAYnFuzWGW94HHc=;
 b=m9NwPhAGV1/uldg8brmgk2umznAJT8pbgK5QN1tO95kTmfTnok6dC9Wp791Xfurgmn
 GWCfMOm+xRLXp7R5qnVF3B8kcB2m2bF0zruj7qozOJXTWjUY91hjFR7uQhwBWpV4HmEx
 8DKdUEkwxTS/JoNnNKXvg+p2z+C/UoOf9AfnaRpUcxxYi8J8zbiL9FgErIEJMYaYoduA
 K49UFZvMzgyNAJcmRoOd/fFm7+ZUsJMZzM3NxOPgJ5IcujwlHOvxh3/hr4iR77NjWzxt
 gE7VJBFQi9EGm/pbTtH6/D6EdQIZRllUTyhEv/QjMJupg7NXRRXg8gvwPobL9QbPr2hF
 4fdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxN+wgWD1pgUBkw/aiQ2jHe5QFHNxuwLiTHg+i0fLPkKj675CIO6MGxcpogUNNlcD5tk4F7aqtumxk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXuvbXkYRwRdCe07hQ27kOhN5UPdEmdog2Qgxi27NRE8j6IO6H
 mKfMUo8o8YV4V6DG5J3M89twjckCAcSnjwGAjKLdttZprNHBYK/E7lewHwBscEs65EsSzHqeBAc
 0ZhSnswsj8drb0cP3LKqKTHxZLHKTxSErkv3h04ZPYUA9MOtirtZ+wSaNp3L04mGF89kB1Rw=
X-Gm-Gg: AYBFou1Qj773KyP0QSSGAKPSMv3K8DjBh9zzS/PnJhZE5hKKk3cMDUmHLmg4l5KvwhJ
 Idqxiq9BKKC4A/BQZD2IFTTN5E+Qp1w4w3FwBJa5XWcz4b3aO1gHqwiGpQBx/1fbaGnC0ZGo2q9
 tROwzAU6aq+sWgs5aDABjereocpdeFFm8Wl/Zdd8FH4pOtwxHtuRG0+KZa9Ih9e9myrokYjF11d
 rTybGTK4B1rZ8glanrvFoRc6eW11cZY2X1O9j1XB0e+r6Vl1H+8RWdmWpauO83DIFYG3DcDitfo
 MwILBTfPQpuviU4R5Yx4b+nppTohQGYPk772ERxbdSvDIrPzMzSFup8JlsSoimDThpRYoVmoKbY
 1wCeDEO/PEHUELK/XfDiD/1hq
X-Received: by 2002:a05:7301:7183:b0:33c:34b4:85d4 with SMTP id
 5a478bee46e88-34270ab91a3mr949098eec.10.1790368545248; 
 Fri, 25 Sep 2026 13:35:45 -0700 (PDT)
X-Received: by 2002:a05:7301:7183:b0:33c:34b4:85d4 with SMTP id
 5a478bee46e88-34270ab91a3mr949065eec.10.1790368544367; 
 Fri, 25 Sep 2026 13:35:44 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341451457d0sm8858485eec.21.2026.09.25.13.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 13:35:43 -0700 (PDT)
Message-ID: <680e632b-c919-4c25-8f25-a6bd9550ba6c@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 02:05:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] dt-bindings: display/msm: Document A850 GPU and GMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
 <20260923-hawi-gpu-v1-10-0c3c79a1a470@oss.qualcomm.com>
 <6c8aa567-6ad9-4aed-a7ec-5d2cb6979384@kernel.org>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <6c8aa567-6ad9-4aed-a7ec-5d2cb6979384@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zrFONTZXX5KXsInCDIs0pXlvBlSMRVUt
X-Proofpoint-ORIG-GUID: zrFONTZXX5KXsInCDIs0pXlvBlSMRVUt
X-Authority-Analysis: v=2.4 cv=YL4KWhGx c=1 sm=1 tr=0 ts=6ab6db22 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=SG-BlJrJjKrpKyBIS-0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4MiBTYWx0ZWRfX8iA36bOytAwJ
 ycGvkcKNIGqcKuXxlKr+lMUYzuhx5AGt71T6e+PhuWuMHUPz9bcYyiaTX3ZT6Kv665UXgwV4Qct
 U/8XE1c3ztSTI5msJdyw1zgtwRtXHD75U1dOGAaep60fvdT5dfO7H7wwZvFc9fphOwZd2ual+m9
 AO08SvkKuZBT71qAiFBuomKJ9Da89a6BrhtXkZr4zK+4nSu7UJy7TrkKJnhppdYGoOTToEejoCU
 r4rTirgxREr6rzlbc6vQAA6LQjSZALIrU9VLi3fQE0BIPhre3dmQCe0CmghhZTvjHaHwkfVL/1H
 Z8fmriF24tp3lbuQq3ToFzJu0CNssy0xCb6RJgt+yysf+r1zqM+XYAY5RHw8FhgN6JsL0qvF8Ye
 k60ekDkVcr7CFm7Nj5RNItI+5oarWEUzUmfAu3ryPf1aVTs3/QtBnFm0azrbtLtsGBpOxqsMju5
 e5B0Qo7sQKbJIV3yIXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4MiBTYWx0ZWRfX6TXiruSQBmTR
 jfMT4k81s5pVZ8o+Z6SjmZI7IyUEREpfyCR5HMyvyjdtoI6ByqhrnUwj88i7N3UvXCowy5Oh7h9
 k1bVGkWnrQm0O09xCwzkcUkYgRRhXB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250082
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



On 9/23/2026 6:30 PM, Krzysztof Kozlowski wrote:
> On 23/09/2026 12:25, Akhil P Oommen wrote:
>> Adreno A850 GPU found in Hawi SoC belongs to the A8x family and is
>> the successor to A840. Like A840, its clocks are described in the GMU
>> node and it has the following power related updates:
>>   1. GMU is now powered via a dedicated GDSC connected to MxG rail
>>   2. An additional power rail called Bx
> 
> I don't see the updated related to (2) above

This rail is voted and managed by the GMU HW directly. I will update the commit
text there to make it more clear.
> 
>>
>> Describe this GPU/GMU along with the new compatible strings.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/display/msm/gmu.yaml       | 44 ++++++++++++++++++++++
>>  .../devicetree/bindings/display/msm/gpu.yaml       |  2 +
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> index 9e459f12ce3f..875fd1242528 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> @@ -55,14 +55,18 @@ properties:
>>        - const: gmu
>>  
>>    power-domains:
>> +    minItems: 2
>>      items:
>>        - description: CX power domain
>>        - description: GX power domain
>> +      - description: GMU MX power domain
>>  
>>    power-domain-names:
>> +    minItems: 2
>>      items:
>>        - const: cx
>>        - const: gx
>> +      - const: gmu_mx
> 
> Your commit msg said mxg. Or mx, because this is GMU, so saying that
> it's power domain is GMU is redundant.

This is a GDSC that sits between GMU and the MxG rail. On a second
thought, I think we can call it just 'mxg'.
> 
>>  
>>    iommus:
>>      maxItems: 1
>> @@ -359,6 +363,46 @@ allOf:
>>              - const: memnoc
>>              - const: hub
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,adreno-gmu-850.1
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: Core GMU registers
>> +        reg-names:
>> +          items:
>> +            - const: gmu
>> +        clocks:
>> +          items:
>> +            - description: GMU clock
>> +            - description: GPU CX clock
>> +            - description: GPU MEMNOC clock
>> +            - description: GPU AHB clock
>> +            - description: GPU MXG AHB clock
>> +            - description: GMU HUB clock
>> +        clock-names:
>> +          items:
>> +            - const: gmu
>> +            - const: cxo
>> +            - const: memnoc
>> +            - const: ahb
> 
> Keep existing order. ahb is first.

Ack.

> 
>> +            - const: mxg_ahb
>> +            - const: hub
>> +        power-domains:
> 
> Just minItems

Ack

> 
>> +          items:
>> +            - description: CX power domain
>> +            - description: GX power domain
>> +            - description: GMU MX power domain
>> +        power-domain-names:
> 
> minItems
> 
> But OTOH you need to restrict power domains for every other variant

Okay. For every other entries here, will add the following:

power-domains:
  minItems: 2
  maxItems: 2

power-domain-names:
  items:
    - const: cx
    - const: gx

-Akhil

>> +          items:
>> +            - const: cx
>> +            - const: gx
>> +            - const: gmu_mx
>> +
>>    - if:
> Best regards,
> Krzysztof

