Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EB606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jazGjcAO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K8Xk9utZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11B610E57D;
	Thu, 12 Nov 2026 07:13:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBAD10E563
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:13:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZVb6597313
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9nxCH1icZ5d38W7PQLiQh/Z+YfmZLqkO+OjM8UBgv8Q=; b=jazGjcAOqRmdO8Xh
 O790Fya1/sTIHC4jP8JVwGjzkiO67C4LEP9GHm4C8LmkZl5qFKxcy4DvEe/9pGf3
 q62ANSz+htC+FoKAeeGodPMELa/nHOGthJBeo05X5EnZjPSIcwjBUMt64r6Y9rAn
 Bhv5L9PRyd8l9YPHW87DfmnL3HcKCoHBsOVQkqr259uARPHCrdpcCKyVX2/thdJb
 +di3Ot+f2SQ/5T9xEHlEW+1t6MYFcFgyhhskoKcorjcf5n5UjqvJvwfvDl5vedFs
 MZacteqZnRl8BMQln3DcrWkM8azyJLZdxy65Ecr12gMUPqo/df01eFseTwulpsA5
 gWKxYg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt153jp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:13:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b0a13ae043so4718134a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794467612; x=1795072412;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9nxCH1icZ5d38W7PQLiQh/Z+YfmZLqkO+OjM8UBgv8Q=;
 b=K8Xk9utZlnFE7k7Jesy4k7RgX8oARGm5zIfM6STkJ6YF/U8f4ExfAeihityoXjFimA
 ykyOpEa88Bg15frA81DLedHpvgjZmPB8ZmpAnb3sB5V03YDFFv7LDNtXjukLZ1nRtlpI
 0+eQcb1kcuz60+Xdm5BhTkZz6Uyd1qEdXm6hYM1qoySxLawq8rT2++TLyno0PDraPGN5
 T0q8bGAefeEuB3tKVc4+iXHzCw16YGF71G60gPWPf2cmYj7hJ1JanWjYkaCglAoKVAes
 QNm7MxQcQtKLwu8mo2LLmPa0cYMY0bI/PKsEEmlmp6UZ875GihQc/jA0RqlEOPOSxIti
 Wc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794467612; x=1795072412;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9nxCH1icZ5d38W7PQLiQh/Z+YfmZLqkO+OjM8UBgv8Q=;
 b=qdohqqYaadSe4+b2dAUOgs+EIcipolHnR2jVY7v7oDaAMKtv4VvDMN4s3WExcH3Qqu
 9aBOkgIFXrdtk9xFhHSaROFETlKdsWqJZm5nChrykiL/GhDkojqEjBgQ1ZNpNjpPQA+Q
 jao8dscZAuRPbfArNWrBJYauO2EsczRIrhrVZmzx721DL8GlPHKrsBBUJp98Tq8H5ejG
 nLmevBEsA4YOh+YiZufHEek1GO8oA++kVZp3r10ezqUZdwRoGIhoItZAjsaifX12e0Nv
 tf4ElGi7x+mRCjVvWHxpM8VQbZGz1unMFiNcmGSKL1QHFSFwfsmJi9+ZBhrZWEXnEM+n
 BL+w==
X-Forwarded-Encrypted: i=1;
 AL+hErGc4k8uP97CPIp2ClcyFfY8n9FhNzgdAmgXFtqx6t+klu89LP979Jops2t6GsCQvrdJX9CV80BKO+8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jjhSn+Aln5H2Tf0MXXokYKyajfYtOKV4EsTJsQZExBjjxEIzw
 Fv4D8VYrDAFQf6Xbm9HxmmH+HvrgDaOOzPlPQoiLeyCffBdHJHpRfMGClI9brduR4rEeaHQRuLg
 ZXYuJyVbI+dU7lGe3TOY5prUobwXNobUvNWjX9/DpT1X2gByxyAuBUA4BFpaB0Im3j59ncNk=
X-Gm-Gg: AYBFou1kXXJn4CHixr9VyY945pr9Lyp0RWKzfC5IostRywAVU6/IIZHs/8YP3c9YIz/
 I+seZwsCn+cwCgG3APY5i6mOl5ruC9MzOaz0GSOtNJO8/saA/uXovhDDAPnXqGPIlVuJR5HVE9F
 0x2IG6M5M+U0UqlbR2Q0suDnRX7cgmgjxOsYP7lODYMGlroMC/F+t9vqS+vCFscSD2w+kEq3O6a
 recbLf6IoQ3hg1a3A1PxwEZqouRd6Ukp2cnOeVcAEfEy2ZcCQepu4AC61HhYplA9qRc7zaoLZtH
 1uJp9suvdYxXBacDtfQg5CQx15c3t+aDssmOfBKWpiQcvxKmYxSue4Esj+FefJcPk2Xiox9BPt7
 3ceC87hoiQbnvG86/bS2XY/qgjjZe8NMIzA/6K9mNz9psjpXxAI627+q99+C8s2CcTMbjW6jJyt
 7E
X-Received: by 2002:a17:90b:4ecc:b0:3ac:eeb:e0ed with SMTP id
 98e67ed59e1d1-3b182eec2f2mr4479572a91.36.1794467611980; 
 Wed, 11 Nov 2026 23:13:31 -0800 (PST)
X-Received: by 2002:a17:90b:4ecc:b0:3ac:eeb:e0ed with SMTP id
 98e67ed59e1d1-3b182eec2f2mr4479529a91.36.1794467611476; 
 Wed, 11 Nov 2026 23:13:31 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197c768e8sm3143116a91.11.2026.11.11.23.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 23:13:31 -0800 (PST)
Message-ID: <01f33d97-ce2f-4cf9-8672-63effc90fbe5@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:13:21 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: display: msm: Add INT2 GDSC to
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-msm_gdsc2-v5-1-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-mammoth-of-delightful-potency-b1ede2@quoll>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261109-mammoth-of-delightful-potency-b1ede2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfX+071bVdwSW/C
 5aWcju2PABgfCf7iBgyiIvIqTdRHgwrlxvCWnz4UW8Rs1bDJrsbaGSFgFj7hCl/n2HOsUMl6TJk
 +f+wrnnj7zpuQJ9R1OTz8iTDxJFA0ew=
X-Authority-Analysis: v=2.4 cv=Yrya1IYX c=1 sm=1 tr=0 ts=6af5671d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=MxPvbxFPEjud-wvEnLgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: NDYKdbnVME7XsY4TE6C7CP2UE8visvhG
X-Proofpoint-ORIG-GUID: NDYKdbnVME7XsY4TE6C7CP2UE8visvhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfX0BNkcln5dfFQ
 /Wnpb1Ra+LNjHnzkLrZN8oPLQNTpph9PCraWLuauYMNm7BCgsWqYBcZQ3k9bAPK396drQI4HEA6
 lHGF5yXDS7XOk35B53fHIH3Z1bPON0+/7PWNugEmC536gJKpcfhJ4tMfF9yDPpVIR/FlNyx/cqh
 odEXJKEQroNKoP41MV2VwTi4kWDG89z1z65MslpL+9VQWVNbVkEt/Rt0Jkps/h28LFZ+lqtL9W4
 3x5TnILKc5vOpGR2qn7vgT4ES+yp0EIeQwcHiXsI91Hp98gpjwUlUjtKzt36NG8yX1H2WZlvuZy
 z82V95HXHvjOcS070X7rZeL9/Daxeis6GQW1WdknUIDc1mN4K1cEodeOrKY/Crr6Zc9xzARJXOU
 pRbugHerfPCUYaQC92N7fMZgpYH87QN2qW9MJQeylIfzASW22Bno5i3KjMlqICi8ZEKlBp2yRkL
 H85akJtg/ptKBBciJHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120028
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 8:25 PM, Krzysztof Kozlowski wrote:
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,kaanapali-dpu
>> +      required:
>> +        - compatible
> Droo required
> 
Got it. Will drop it.
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          minItems: 2
>> +
>> +        power-domain-names:
>> +          minItems: 2
> How did you resolve my previous comment?
> 
Will drop in next version.
 >> +        power-domain-names:
 >> +          minItems: 2
I moved the items: list to the top level in v5. Only the minItems: was 
left, which is pointless anyway since items: already fixes the length, 
so it's gone in v6.

>> +
>> +      required:
>> +        - power-domain-names
> Why adding this?
items: only checks the value if the property is present, it doesn't make 
it mandatory. The driver looks the domains up by name, so a Kaanapali DT
without the names would pass the schema but fail to probe.
