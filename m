Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0752EC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D68510F1DF;
	Thu, 13 Aug 2026 07:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYSCitxZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bf4NG2x9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643B010F1DB
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5fwgM1525993
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9VIi5gbm+o/Cvix7njYFCpqbSntmg4C9aERKb/x1kFw=; b=fYSCitxZzc+oMkbH
 ERQ5vjKScGv7z7L6Utt4PT/Kx6hb+9HI9jnp+KzDpTiXx+IpG6UXuBE2yZzxRNWY
 D6w4TqVaKgOUOr3gI2wao14eKq259IKjU+ObokRiqy08aiWh73ljORNCiJkxdAn9
 GPDN3fP2MVUijXW+bcEnJoM5Q38GhQdQe6tjBo76HuikZYjYEudO5j6JIoi8ZiaJ
 wF1mpQpTVBZiQm+7QPENCYfMk2Lo8aJvbp8yrVB+zNdFkNMvC5tD3A3izFSXrUq3
 79YsFiPD8H1Ipflr9oSHszdAg6GFw82Z2mw6wbDGJNFIMfu8d0BTNRFyawcqX+2y
 N0e9kw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g158g92jf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ef8249f871so4746326d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786607130; x=1787211930;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9VIi5gbm+o/Cvix7njYFCpqbSntmg4C9aERKb/x1kFw=;
 b=bf4NG2x9dgjjgH1wvXI8pRsfFVZZtrO01YDE/Blvt4ceKlFVHne5WnKfVrNtb1PoyA
 WtfBnPApgWfMFzTRC4+Iarv0ZOSPpUSzASAC7W1Sl3qjMgbFVn6KCIqEDkkRB/8WNrdU
 FsE3OrBJWk0sk1offtnzd6Sllvj0awdsEaYFUS4sWIezhBpr92/orCuU2EevZJOzr7Tk
 Z4rK9wX9bzx5gPohoZPK9MMEx8ZmSYA5vYWsI5HAcoQ4HcW8x/o/jBvYQCriTD04A6jE
 bcsGMCwcPhGk+5peER3SIoEPRcsSWbIu8tD67MOanTf4JWM4npimNqCE23F6vra0U9V8
 t1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607130; x=1787211930;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9VIi5gbm+o/Cvix7njYFCpqbSntmg4C9aERKb/x1kFw=;
 b=PvZL0C5a4qumI72iSF9Wz1MiL27djmKZNEniPWubJE0klcKaVVei93KI+jnNM45JVC
 1GaargYZa6B1R95xtcD7wt9XbqSJibw2nVZ1PPfbrng1v8ppiquCAQgyGA1khVicjagI
 heIrz6RzUwai4L6p7WnSCOMFg+YwVGu8pxkOjUvRKIhGnKpjSKDLkrR1rV7YcOQ25mID
 s5MpWX2aabJJ2g1zWhFRdISVIzEHYsIKMGpVNV3juBfrOe5SvGIX2ZFOlfyjHDjxpXND
 p8rGCMJT4TrpMGTHSJw/p0bvp0yTQn2tvkckVDA71SJ9j2W9+2H+sid7yrmcxzXrSbxR
 r9kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoD7E+FD4boccLGoz3sUT9YHRhqsJtegYhR3qfbTk0T3gRkA0AM515umwn5IGnDXkV30wGJ+BxFTgY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtTR2JRKTZ6mswK3rmKPHBf4rIRjnUDhubdt9CahujdvlaZ0OP
 ueRBZ5wsaV5iqWOJTFEBjv4nq3vyCEEIyS0xxYeRwlDfEoRefhbZjRQq5+8OhZ1SCjtwfV+IhZW
 aN1h1GClbApADHNm6bx+io1SwBWNzWesvu2wY6E4OU4ibbYtbxOHVNN1syGTTne2VHnWlLG8=
X-Gm-Gg: AR+sD13CkOwvG8ExQkjm7oWZIRcdVi+KLj7mv3ybvBG6j1RAn98iiXugRPs3/vCj5qi
 g5WbFsPpVHtmQ2mlPsPzUyN1QexasOFb5APE1gGuaPgkRYjL5T5mq35uGIlcgBgy4howg3ZWl2+
 NVdjNaRlt5BptjEMRGrKqyr9J1+aueHS4ks3E/fw+gUvozKJjwajBIei/E4SNjODYJ8000ijjs8
 LYezpIauE6w7aPnEQ2K+NxGtcRS7rBxO7EgtfqmxPIHEwu3CDxInWSpAIHZDdg7ij4TuCcfACyP
 XGup9kp9wpE+/hud6D+GAMal2hn+WWA89a+3xYsejH7CTgXXIQzMarr7GAOHUS4FDzoD4SOkbg1
 vmUmKSFBq93VoEXOFbD8JyHQbpE12J8Zt0ipB9vbVgnUe/+NLx8fJ1QYc6ZPwDspl
X-Received: by 2002:a05:6214:401b:b0:8ef:e0d0:9fae with SMTP id
 6a1803df08f44-90a80b2f028mr32615116d6.14.1786607129684; 
 Thu, 13 Aug 2026 00:45:29 -0700 (PDT)
X-Received: by 2002:a05:6214:401b:b0:8ef:e0d0:9fae with SMTP id
 6a1803df08f44-90a80b2f028mr32614586d6.14.1786607129167; 
 Thu, 13 Aug 2026 00:45:29 -0700 (PDT)
Received: from [10.111.164.29] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a8179e4fasm9733956d6.2.2026.08.13.00.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 00:45:28 -0700 (PDT)
Message-ID: <bad2e899-106a-4d7e-b082-345ec757ee9f@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 15:45:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
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
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <20260724-cocky-uppish-pelican-3796ee@quoll>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260724-cocky-uppish-pelican-3796ee@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EzDABVbe-QsVnvCVgOOT1sHsD4umGfSw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX6VRxOWfl3QWM
 e3uaEGN7ImamvI8If9RO8sY9L3tafbDAwDCogd8Xaqd5eZFTftjfL9gkcIQBqqPlBMbcVjWQVGw
 JX+p3sT5L6pl7PmWyZkGWkP52AMb3Z4=
X-Authority-Analysis: v=2.4 cv=G5ks1dk5 c=1 sm=1 tr=0 ts=6a7d761a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0b-XH3JjkyDtS5VtSh0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: EzDABVbe-QsVnvCVgOOT1sHsD4umGfSw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX6eBgZ/3vHcVG
 72PVx15FYYk9Afafh8LUMwzfSnjKPd4xUOdixERrK99s0f1yfUqRnG7y7/hdx8Tli8FBFJSDkPG
 biCmidOifqyXYHgGwvDGN5eOUb/mXZysiDiStgHfM+JEGWlc6goDc2marNueOl3LqsH4yPzjH2r
 9KZ559pZ29mja5qbTWVZsm5R+W1QAc9onchV7Z5r14g3PEadOqs1lz7zyIQAKPz3ZEWRQNcSRsQ
 enJ4V6msbE8L/pLQmlPtM8qFGZxf1iuXEEJ44CtWiDywqFwkDjFj1t332VY9qF3fOWVE99yJA0x
 ULSTk5nB/rlJrrGeqncq20lsegM8DTHal5fAyTfEUYT9t5i9+5ea8CqMLU4A02XlsNw7mxUgX1p
 QO0zk4IcxWIT6hX03jaAAVPuggiutSbs3mfc92lYn8szQXt/powzD+c3GgMaruXKaT4T7vIfAja
 PVbU21RWxY09l1lgUVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130052
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



On 7/24/2026 5:36 PM, Krzysztof Kozlowski wrote:
> On Mon, Jul 20, 2026 at 04:43:53PM +0800, Yongxing Mou wrote:
>> Kaanapali (SM8750) and Glymur use two display power domains.
>> CORE_GDSC powers the main display hardware while INT2_GDSC
>> powers a subset of SSPP blocks.
>>
>> Allow the MDSS bindings to describe both power domains and
>> their corresponding power-domain-names values.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
>>   .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
>>   .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
>>   3 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
>> index c6305a6e0334..c0b650ffd9ef 100644
>> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
>> @@ -31,7 +31,8 @@ properties:
>>       const: mdss
>>   
>>     power-domains:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
> 
> So all deviecs now get 2 domains and this is completely ignored in the
> commit msg.
> 
> Best regards,
> Krzysztof
> 
Thanks, will modify a proper commit message next version.
