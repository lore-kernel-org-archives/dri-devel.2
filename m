Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D5FCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17A510EF6C;
	Mon, 12 Oct 2026 08:41:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F24210EF5F
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:41:14 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8Ksu8312831
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f8GO7ExOgblqj7+GdipBZ3YhlJBmXYlbc4wk298drcU=; b=ai5FHyznuqWJvwh7
 nFw9jGAjXyjV9H5Z+mcIUA2ESi5ifOMKW32t0UcjzUd7n5QRWA9bEhEtG9DRk2BO
 4fK2ZuYuau57oxsHDZHWS5j2SEBkIpQkMpd8EjH2nMc1paqdjEwoYo9wIr8kzxn1
 ATahCT2LL6Tzrr3NxfV70XnwgeMQ/88UlPMT6oY21dMeY/8R/6vFxjLSwlqODBb8
 M2+KfnNTbp5E0IXuYCEVOko3N3JxTtGKlQt3rhmgEOLDAM+R/Rq8r8iyBB5c8Kls
 Hh/3TSCEGeCBt7iiqCJJpJuvdNhdZxYlIjKHfsMJVQHd/SFtOOoxmzF1Z/2wMJ/z
 Hj+MUQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjnp36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:41:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e605efae40so21250815ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791794473; x=1792399273;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f8GO7ExOgblqj7+GdipBZ3YhlJBmXYlbc4wk298drcU=;
 b=XIOvyKgaBTkS0gxCqdamy7aQQLpkY9UqgvtYGcvtX9oVPdi0Af2Y16Y2dZYAwof4KN
 KtuaeSPPWJ9DonKqBektNRTJzxlMuPtN/Q6jHMylSgfwxNvGHgrNT/g94teiYknwFz93
 XZLmnfr/aF+bIW0CRsRXJJLgIUXi1bS6be/5NDtn6rtbKrrRTRPS+MxOiuzaiB/WmGRu
 fgtUBtzIkhBNL1oqRoWiAep2cf6uV0Wif8YHTg8J6fwCF+7/YHL6YqoyqGZ4+NCkDLKq
 A6drUkojT3LKV0vqOdUM1r8eeaYzSeRcdSVGBHH1oP8SqjibiTrJ/dVp+RF4tU0Szu92
 PvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791794473; x=1792399273;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f8GO7ExOgblqj7+GdipBZ3YhlJBmXYlbc4wk298drcU=;
 b=XoDhW7GilGxhrD2vUKhlaAwiKzDVE0MaXmVkbqS5TnK12gvh5ehfU504C7hu7svAmT
 KvzSLF6X97sL0Tk1vMuLkrnLqHcPrh66IBhXAZNHFjOQvk+3aihSatqokzeKT+L4mWTm
 cYEG7RwCHwjrLt25b8A1DnxDtm2LwxS8vO89Aa1MSD9Z4x6gQpmuIDhLa+I1n2ggxQ8M
 jH9GZbJ2sr8jZKCZFl5u0DSNTTpkE+RLySQqYz1wTLuKXumNX5vwkNdG4TN1cETYrl7N
 LC6ppZ3bIbwEtSPox1DIVbrzMKnHo7b4srB8rziSkNU4gZOuzTw2gIRceuHCPuFktw1S
 IFhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi6d0rVbsq4fFpxh0OcdcAQsyl4pHfkMuHfkcSHdQYcfYpFp2MPk1QhAXYqrMEMHfOHQR/9xqujME=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPg62bqGijeg66Mx1M9QHY3Ix3UzwIhoqm3L3KYGCOl+A7bjlC
 h4klbGQFk9tvHiA/ZNdpIVXWbdlcB7aE/iClTxLstyTRQZoOrs3bepoAyCmEBNnI2R956A7EyTD
 Uu+iT4FGAnZ75AHdqQ0w6HYRIHbjtsPyqmgvG//Ed2eqkuTJI/+VXXL430HL9EhYUaVqfJxo=
X-Gm-Gg: AYBFou1hBIQ7EoonVY541fe+1hcA4DV8RzHnBkfet08CpZhwwEdDLPfkSg0TEfhG59O
 Z+vAk046rxYV+d9BFEdm8W0EAu1OxmlQZtW9ekpanNbgpAhd2hRRuJbAJrmTqO4Xs2PTM6GyGGn
 BJLfhWyqYts94am9nSHp5AkMr1/akLMDqJX/QtOVohAp/TsLd1dB0NitO4PGOV2LRXGIQfMawnE
 gHqnFf0CCwUBjrs9mjP+slOw++JwoSFUHFjIVZ0nKNYaKBxXEcN9K7kjCnoJNjJvdWuzibjL0Ul
 3wbzOxeaUj7gcAfGk8kZcyVVrbKREAX/AiCCZRlqLLN5LUX6gPKdi0KWJWLCPMjfptJcHOvdNe5
 8HoDIknc16ZaEEZ9oReWC8p2ZjOnzvgbf7WC4xuk13bmo/rPRwJiVSLt9KjKHSwE7q2RZZKo=
X-Received: by 2002:a17:903:15c8:b0:2e8:f7a:c69d with SMTP id
 d9443c01a7336-2e8429a8013mr71143005ad.15.1791794473029; 
 Mon, 12 Oct 2026 01:41:13 -0700 (PDT)
X-Received: by 2002:a17:903:15c8:b0:2e8:f7a:c69d with SMTP id
 d9443c01a7336-2e8429a8013mr71142745ad.15.1791794472496; 
 Mon, 12 Oct 2026 01:41:12 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e14f6sm40626185ad.69.2026.10.12.01.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 01:41:12 -0700 (PDT)
Message-ID: <a09f71a4-31e7-439d-b053-66b279ea27c7@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 16:41:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
 <f3qs4wcascfodjufisl4qtpycfb3lunff2fv4u3olybjius5kp@vahhjfjfh6wv>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <f3qs4wcascfodjufisl4qtpycfb3lunff2fv4u3olybjius5kp@vahhjfjfh6wv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX+G+nUXM5/NGh
 ckT6F6poSPZ590aH4HZjFG9OBQJl7dpVpEkxpJ25VG8nNY5rvjRiaM4HlpFHwJ4c9umHT037eil
 OHG17aLtF0FMGeCXlxxR8IKC5kAH6ke/WtKJTIOlc4a+Pxy8FY6FtgyweF5+gvQ6BJx664yAIWu
 6UIE8ZCjv5Ffdut0vMKuaQ1j2eqm/msgVALnr5QukkgPcGKqWo+SKbrJQepU2NCLsNlpI9P3TKe
 oublQrN/HQhTuhzSdvJOzb5eBvlnxsgiDCvWPjrvYX7PNTkKhc+3g+jj54Lg66owa3dVYGNIZNK
 ToZ0xSoUxeFtJ8XC/ou4tt/gBOnz5rJ9ri38nTqGYb6rm+3k8D9pnhVXHJPCVfFD5pV97oeILR/
 5J6NUD5CbIAbqZoKMDulz3dlsjZuf5/mgwlsNssWGy+ctuNGIY3/M6L1fVRQwvlT5wwjPsQev6s
 pMk1EzbNo0cpGFJs9fw==
X-Proofpoint-ORIG-GUID: Fa2nWb8jQfzeubYy9THwJDWayz-67AJn
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acc9d29 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rG2K5GnlOK9i5R8LVMAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Fa2nWb8jQfzeubYy9THwJDWayz-67AJn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfXz3b154R5Eq3L
 Gvv/b1BG0Uhe6Gp7LFxMYpNE8JqUVRJRQ0s55//BSc8F1XoPVZoM34ut/f+t9a4O2P/LpoUDdw6
 AEhSMno8ugSqvcW3QApu00bwv6neoU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120034
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



On 10/5/2026 9:02 AM, Dmitry Baryshkov wrote:
> On Tue, Sep 15, 2026 at 05:27:48PM +0800, Yongxing Mou wrote:
>> Kaanapali (SM8850) has an additional INT2 GDSC that powers a subset
>> of the DPU source pipes (VIG2/VIG3/DMA5), on top of the CORE_GDSC
>> that powers the rest of the MDSS hardware.
>>
>> Describe INT2 GDSC as an additional power domain of the DPU device
>> rather than of the whole MDSS, since it only supplies DPU-local
>> source pipes. Restrict the schema change to the Kaanapali DPU
>> compatible via an if/then, so other platforms sharing
>> qcom,sm8650-dpu.yaml (which don't have an INT2 GDSC) keep the
>> existing single power-domain constraint.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../bindings/display/msm/dpu-common.yaml           | 19 ++++++++++++++++--
>>   .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++++++++
>>   2 files changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
>> index 3f953aa5e694..19b791a857b5 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
>> @@ -25,8 +25,7 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>   
>> -  power-domains:
>> -    maxItems: 1
>> +  power-domains: true
>>   
>>     operating-points-v2: true
>>     opp-table:
>> @@ -53,4 +52,20 @@ required:
>>     - operating-points-v2
>>     - ports
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,kaanapali-dpu
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          minItems: 2
>> +          maxItems: 2
>> +    else:
>> +      properties:
>> +        power-domains:
>> +          maxItems: 1
>> +
>>   additionalProperties: true
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> index aa0cf0ec5b93..88aa71d2b912 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> @@ -61,6 +61,29 @@ required:
>>     - clocks
>>     - clock-names
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,kaanapali-dpu
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          items:
>> +            - description: MMCX power domain
>> +            - description: INT2 GDSC power domain
>> +
>> +        power-domain-names:
>> +          minItems: 2
>> +          maxItems: 2
>> +          items:
>> +            - const: mmcx
>> +            - const: int2
> 
> Nit: I'd suggest more generic names here. If the next platform switches
> from "mmcx" to some other domain, while keeping the split architecture,
> the name becomes unapplicable (in the past we have seen platforms using
> CX instead of MMCX). What about using names like "core", "int2"?
> 
Agreed, using "mmcx" would be too provider-specific, as the DPU 
performance domain can be CX on other platforms.

However, "core" might be confusing here because DISP_CC_MDSS_CORE_GDSC 
is already attached to the parent MDSS device. The first domain on the 
DPU is used for OPP performance-state voting, so would "perf" and "int2" 
be clearer generic names?
>> +
>> +      required:
>> +        - power-domain-names
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>>
>> -- 
>> 2.43.0
>>
> 

