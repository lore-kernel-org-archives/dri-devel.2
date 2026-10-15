Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B74CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DD111229F;
	Thu, 15 Oct 2026 10:30:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4AD10EBC4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:30:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kHaW2999206
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KplVd/YKYqENYMOmHIFo9y+PVYEEVdQEm3m9itaMaCE=; b=UYQksjDkUbOQufaB
 +7pgiELkyXGXOFV7uBU91E3rHdJtvmf7pIrrr7p+h7AJ7b0gtLEjZlvOz7XX2BnU
 oVdjPQUh8uNtY6kr0pwt4rBUbAJtixSCISI90BGxewMN5XKnYRdDlwvOg7FvCHss
 QZ6y5c4xh3sDeeZZUUOr5pKxda0u76aatzFwvN3n6F3NV27604z/d8l6pL1RyHT+
 vLrhcZ2gMJJA2nBY5qgUWKjkVRvTqTEdksSxd+3LFJuE0ToRvDLN4XuLa6TUrtvU
 cnemjFTi3ZvD9qjCXUmeho00a2sWD+XLpkbeukgb8NmeIqNUgL8YGEqgzIb3hzDe
 846OpQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm0edt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:30:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc73895c7d5so2438432a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792060200; x=1792665000;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KplVd/YKYqENYMOmHIFo9y+PVYEEVdQEm3m9itaMaCE=;
 b=ZtZsBtpNlvqCMBmtjsCEuOgd9YsPlHpPMfbXYwrrxKJhqAmtRdyXNOc3lgOxTYBzRj
 9lVwEI8fUXOpReJ1l+o/xoDH2EJit9f06yikN4fYZmf4ca+7fnZ12MQpjh6qFrdhC5mk
 YZSVbdz7ZuGOLyS7XVQ2ohOpvhHmiZJdoEC9B284EFsIQy0c/nw9VPdeftfQqvKcwHeS
 l6dA0AHOEjVkxgfiK1YMa+zueYcFPCUICokas0iM0wMp4Aav7Q0sPzecjhkjiROXSvxj
 sxl4fOX+zF4gqi5a5/hotM0ICVq1+hLRErCMEDCQgYz71o1l8g6scTqdpubDdxVLq4bc
 2rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060200; x=1792665000;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KplVd/YKYqENYMOmHIFo9y+PVYEEVdQEm3m9itaMaCE=;
 b=FERfaH10WdNuq8TbttXbxL182raz2gGZ1DPtQURORRJ6BJVvvDTgU3wQtnSkkepfso
 ru15enpsA+OqWQrFdK2QqJTravozQ+CY2LxQdWQ6FZwHDM1upRoptChOHW+rIbgSJ93s
 Y2YAUWgaONqq8iIhKls58IP8FWC5ibGpWoYQYIRudE5rOPHUyAZGFuDevPu+TkHHSR+i
 XNKIxWnjxCVXTpns4KT+t72M47TftL9mpysvUvnhVwUysOCYJvHyrjw1qn8XE3by0k3S
 PGI9OtU6SkFZ/SsZCjywS3cR2prETenP5HwuvliIlkvhrQeIDwDDde8EGhZOGMLQdgT1
 yQ0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBylHSvtd/lpcK0kltpoBwbyrS71SS1mhy6DZM7fq03x9rsVSeL7cyhsgqdOO1N72YMlXX7CykWSxdY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYInxlxpEY8yEBbZ/r/YdP7fF/A0Mf8YoHq/VKENZTymBLJilATS
 Iq5Wdi74IK187DHnqGfs05qlbRCvjUR6w0yR2rKXCD1cMOovwml5zA+wR7DJ5ScIkKydFlkMLS4
 ikEm3CX/79NmTEB0Dl0LplsdaUHxgPytQPClcFmg9afZBOXIBwBvxeRIRUEt/Rkn+uA7vqIU=
X-Gm-Gg: AYBFou3UkMtwl2M9JdprsBWRrC0VFEKY2Lahi5+WJIJqv++Y+Q7uOvTlwwi+H2KhQ83
 hwLWsph9WygmKSRSuBQd5Sm987v8B4zg0C1mz8WuZmDCufEIhk1oet2Ft3beKCE2ud+nNSGRmDT
 tReW3EN9moYSmJH122ofx143PQt8/dcjOqignH2IcJdSw559ufUn+Y6DbfSmeyXXRzWxREc0Cmg
 vJe/17xihV4mOfiHwjQNAVQN8EKHay2WcP0xkb1IegHkMD176+TG4GBmYIQOv2nOFYwH3rIEorT
 mTkOBrJRb4MnwRzYUncUjyiMmNZhPMZkRCyZRNcQ0emZ/bqE0u75zcf+Yck7ql1w6Oo31Pc+M4k
 VV0AeIVA7WV5915EVGzp8f/SVtTo=
X-Received: by 2002:a17:90b:224c:b0:3a8:6a6b:596d with SMTP id
 98e67ed59e1d1-3ab3a9a8d66mr19929531a91.26.1792060199885; 
 Thu, 15 Oct 2026 03:29:59 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:3a8:6a6b:596d with SMTP id
 98e67ed59e1d1-3ab3a9a8d66mr19929491a91.26.1792060199340; 
 Thu, 15 Oct 2026 03:29:59 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac944511c7sm4093439a91.10.2026.10.15.03.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:29:58 -0700 (PDT)
Message-ID: <6ac22076-073b-407e-b6e5-1f4d0a229121@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:29:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: display: msm: Add INT2 GDSC to
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
References: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
 <20261014-msm_gdsc2-v3-1-f1ed69014416@oss.qualcomm.com>
 <20261014-elated-hasty-coot-ae3485@quoll>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261014-elated-hasty-coot-ae3485@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OJ_HRvKemgewGwmRfDsN0FGKcNVQJ1RR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MSBTYWx0ZWRfX0ENjamn7BCl8
 1lUN8yS4tYx2K3ExQ8lS+XyPBS+cpERmOABgZxOzuejnhAbbtH6MCF7uWXKwPIhFFYV9N4B0uor
 65qt9HnTjAOvLCdCbzfXjoo0nIlszrBNPJ/P+hIU7adJsJ16CrjPtIa8dFd7gG3ClRmTojxYo/w
 m5P0lZaIdL2VyFJsLwH71OCpqThVw5Z9MjsRVtirTRC/LCfK6UFtBE73B4JhVql9jE2F+3CEnOz
 wyWHdsRu64rFvfqyvKTW+2PmXT8Lx7ddfZtqKGJJanBJrHdCXIpCP4LXpckJfklwE5mHEzfQGYV
 sVjebahqt41p47wAvfwVocd+rEM2ysT/5jsFqjo5U1723wea+RratEWxnwzblsn2A2/9qQTWIX4
 YrOkwQD6DNoJt+3PLEnMk04ISEeab93XJ77abCOtIGuftSbjl5xHYmQz66Uji7TMhdtkHps858j
 nGtcZVetd5r1x5vDcNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MSBTYWx0ZWRfX9X13ixseTsiq
 KL2nbNyB/dBWefiC+dtrvYVJ8pfwJ92Lj4Eq30hUogK2xX/xbndBpZaD3Rpo09/o+ZdDAZEFICF
 sSb4p3wOFOIGiyBeoOeBiHkN/bEb0pw=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad0ab28 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4m8bAy1w6SXghX4ugIsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: OJ_HRvKemgewGwmRfDsN0FGKcNVQJ1RR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150041
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



On 10/14/2026 7:31 PM, Krzysztof Kozlowski wrote:
> On Wed, Oct 14, 2026 at 12:38:16PM +0800, Yongxing Mou wrote:
>> Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
>> MDSS hardware and most of the DPU, while INT2 GDSC supplies the
>> VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
>> remain inaccessible.
>>
>> Describe CORE and INT2 as power domains of the DPU device, matching
>> the hardware partitioning. INT2 only supplies DPU-local source pipes,
>> while CORE also remains attached to the parent MDSS device because it
>> supplies shared MDSS hardware. DPU performance-state votes on CORE are
>> propagated through the genpd hierarchy to its parent MMCX domain.
>>
>> Restrict the two-domain schema to the Kaanapali DPU compatible, so other
>> platforms sharing qcom,sm8650-dpu.yaml retain the existing single
>> power-domain constraint.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/display/msm/dpu-common.yaml | 19 +++++++++++++++++--
>>   .../bindings/display/msm/qcom,kaanapali-mdss.yaml   |  4 +++-
>>   .../bindings/display/msm/qcom,sm8650-dpu.yaml       | 21 +++++++++++++++++++++
>>   3 files changed, 41 insertions(+), 3 deletions(-)
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
> 
> No, widest constraints always stay here. Look at other bindings.
> 
Got it. Thanks. So here mean allowing up to two power domains in 
dpu-common.yaml, requiring two for Kaanapali in qcom,sm8650-dpu.yaml, 
and adding maxItems: 1 to the other DPU bindings to preserve their 
existing constraints?>>
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
> 
> There is no such compatible. Open this file and point me to it. Why are
> you adding this compatible to common schema? Is there any prior art
> doing something like this?
> 
  Thanks for pointing this out. I will move the Kaanapali-specific 
constraint to qcom,sm8650-dpu.yaml, where qcom,kaanapali-dpu is defined.
> Best regards,
> Krzysztof
> 

