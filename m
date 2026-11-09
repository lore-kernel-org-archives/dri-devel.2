Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50365606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVd/TSEC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dDRnl+bC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A921910E74A;
	Mon,  9 Nov 2026 07:49:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62F210E222
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 07:49:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A969wnA2668074
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 07:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qDe2ce+Ek0Yzko5s6AlNc0B4Fxdld4KLI1y6EiIO2yk=; b=PVd/TSECefMO65S2
 2dQwe6AfFV1D3yxIAIvTeQEn9ecvrgb4Ew8IJluoZySBvMuX9pgYBQzW99Gb8wq7
 XTxdGKAQNBl0CVp6lbkhAak4JKDcUVfet+Ocu/chEndTwDbKzahMhgSVOLGs3o3m
 o0iu5wpPtwDIcySUTbBO7dMzFcUxXk5bx5wZjGDcU7RCZULSOd5EBJflmFRh4wsB
 YmCujcXMJFCjsBji00JO3jz2ePEgSuA/gDhvioTwKEubLDK6QbM6n4crc1XxLAaX
 1lZNeBPNxspl0hFQG/eq3UGmDErmHRQzLFsFsgaGnhgmjLu4Q8IBewCdiFj1XVTI
 jq/dNw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99n33n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 07:49:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b0c7ab2427so555873a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 23:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794210570; x=1794815370;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qDe2ce+Ek0Yzko5s6AlNc0B4Fxdld4KLI1y6EiIO2yk=;
 b=dDRnl+bC1epPQMiL1297Ud9DI98wxmkWQR9mLFc1NR7i8cDwj4UoVQP7sB+A0HwMe/
 2K1E9hh9jOOhWrKkKuet7VyflBBz0i1H6/gG4LVC0V4O18dLk54kXItDjZafA7mPddpB
 pj0rCyQNAXnGjXs1ymm3vhDwbaj37LBiTT2biE8ZFolATf/hRPL4Jpu2SgpwqlREnrXQ
 x3wWwew8nTNN4t2injudeawXjTfYdEUdmfbk6qlcg/mOL6UYJxod1A1J8BRXF7ZO2WTv
 weTmNTZthz+P9pWwGGy6TklJlJeLkEr1HpQn0KxwJnjEnxAf9U025EQ3bC4v5F6g19t7
 opMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794210570; x=1794815370;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qDe2ce+Ek0Yzko5s6AlNc0B4Fxdld4KLI1y6EiIO2yk=;
 b=jWwupQEgMuHOooYXDm2ci3tqFjy/rfptzjUIb3D/uCAdim9l0+KUPfAB5YOeLYWcVX
 Sj1soVI2e+JEuD9uc8Et/vCGuGmEsREhNg8YFeNWuuPivieG1EqFTqb4mEWW13AlsCKV
 Y6ibMIRQrDnfnIt1MPk0sRNkseRqRRPCpoxWCmDXmtXqK6TgrUC3kL67gDzYr54F7InU
 VZIdC9YdOvF4dwxyzhzAcqaeM4mMRu/t3lzs7UrkiOaLn8g2SCQRugxB4BfsxFANYQpk
 XoA4UF5A+7dzE5S/PK+OpAcp3j1jHsvc2wUKuknGpMdeQkCo6vvlgjOsRUAdrgunO2sl
 zutg==
X-Forwarded-Encrypted: i=1;
 AL+hErE4rDQS2R4RsZFAtNGzOoGUI02Bw027g00b1uyc6xkxawDJtJpLxoFyNP/lFpne8ssdVdlhhK3qTS4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z83Oeex9rrcYbeudjvFSGBhKPjf1mmRupu9w6rtSVmV1UGFJajw
 RGXoCisxtb9Sp+/l2tkTSuZg1pB9rt7QHaeP/VQ60RN3gnYp+nDpjqnS5b5mXCxV3ZCDiv5GKuF
 kDSon6QljV5C6dYLQEDAC+lUlPiEWkLRPHkghizoRy4SoIvKT7ntE0BilqR1P4eAnlarILqM=
X-Gm-Gg: AYBFou1JiT3ikbAZikhy0hpKbtJFczcBBv6F5HWIgBYAquMcg4yDXrKKg9+Pptn0SC/
 gJ8jOCnuXZ3KTEeZp0JmIM5Czvefwz6ryjIk/b6fN4ym1seN1PbpXZ+PVXOWob56HtGBUR7vzDX
 PiRmYbIMt6Of2KDS5vHc2ryax3ycuWMwtT6vcjsJMJoBkCd79tR68d4oElgXeX3xuO8VjiXbjOv
 TliYAkQXBHMFfU5mFh/3N9J+90Ccuwl/aKhvUMHW/t0AbH4tevRjZVM8OX1oE47tu+lCxyd0oGl
 QPI7drYJITWPbzySaewOYf2BcjKNC3EVFb0r6WIemVzsyFdNFCDy+u6agbbkmoiarHRSywdo+e7
 vScKw0dLHk0Xgf74CEyfOaCnxVdhCIr5W+wFmMcCLbwbbJf9u8z7u6EKojpE7RY9ZRvXoj57Z6c
 Y=
X-Received: by 2002:a17:90a:e705:b0:3ab:de4:7fa5 with SMTP id
 98e67ed59e1d1-3b12d5c4412mr3197725a91.56.1794210570494; 
 Sun, 08 Nov 2026 23:49:30 -0800 (PST)
X-Received: by 2002:a17:90a:e705:b0:3ab:de4:7fa5 with SMTP id
 98e67ed59e1d1-3b12d5c4412mr3197697a91.56.1794210569988; 
 Sun, 08 Nov 2026 23:49:29 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b12797095fsm5758248a91.16.2026.11.08.23.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 23:49:29 -0800 (PST)
Message-ID: <13c25823-0adf-4ad9-83dc-24ebcba39ca9@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 15:49:20 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
 <20261023-msm_gdsc2-v4-1-40b6a71d4e3f@oss.qualcomm.com>
 <20261026-vagabond-macho-sawfly-9c02dc@quoll>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261026-vagabond-macho-sawfly-9c02dc@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ncvp4zCNDwrGhTHzZHK48wgwMajoA_Vb
X-Proofpoint-GUID: Ncvp4zCNDwrGhTHzZHK48wgwMajoA_Vb
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af17b0b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=msBFRUBLE_5BgBVHHWUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzMCBTYWx0ZWRfX5pdaGGxNx/RU
 0a1t954YVcOpwSIXx/PKVCTnk4mQ4gwcAOFMy3q2V/pC5zF/4P8gSk52DW/rrjuIMc93GVqh07w
 KQuHF2J1x/zC06Mk9Cl6Sk9bMvL+Nuc9yzhH9DCLdYVPgkGzQ4381QsyCBwmATKOncgiOL3+tVE
 TlehZhxZvVioxfbU6dbL5oEauYVAqjTlxRY+l8lOnGhhu3agJqf1D8XZwDLu/iu/4e+dWvAsXxn
 x5CSw+iKg4Ok3UESS0Wiu5P/zJXrjGEvj9CmVJg4BghG/3EGmyGHMn+5HbNXKg26fr8hjrNir1A
 fMMh5XIu4PVYYuUENwuR9roo5OIup5dnK8Kf8oA1LtD1cnIdmx2S88AZf+mOlmlQp7C4pPS2vEa
 PodF8vWZCphLJ3y4k33h00EApGogZiv6Mp/3xN7a7V8wyEJYFZxAdWG8yrJs4jhLdVrhKSPTroW
 aAKev/GjZBRFWPoUaeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzMCBTYWx0ZWRfX3b3WEktgT6pB
 M9G7QEIMvIpNNU0h6dRaFNnLVw18myBgziDGs7Fc3X+0iqteFBH/6ZUXapUOtWDCaPTeE4bf3ks
 h1cgl316O94VbOtyBJi0pIj8IY3O71Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090030
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/26/2026 4:09 PM, Krzysztof Kozlowski wrote:
> On Fri, Oct 23, 2026 at 04:13:11PM +0800, Yongxing Mou wrote:
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> index aa0cf0ec5b93..7f8e52d52078 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> @@ -61,6 +61,32 @@ required:
>>     - clocks
>>     - clock-names
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
> 
> here should be contains:
> 
Got it, thanks.>> +          const: qcom,kaanapali-dpu
>> +      required:
>> +        - compatible
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          minItems: 2
>> +
>> +        power-domain-names:
>> +          items:
>> +            - const: core
>> +            - const: int2
> 
> Drop power domain names or move it to the top. Here you only provide
> constraints, not define new properties.
> 
Got it, will move the items definition to the top-level properties block.
>> +
>> +      required:
>> +        - power-domain-names
>> +    else:
>> +      properties:
>> +        power-domains:
>> +          maxItems: 1
>> +
>> +        power-domain-names: false
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>>
>> -- 
>> 2.43.0
>>

