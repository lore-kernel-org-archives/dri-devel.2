Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E3BFF8860
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 16:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9088C10E264;
	Sat, 25 Apr 2026 16:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jRm0M6hu";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NkRCIPv+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9149610E264
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 16:24:20 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PGNuVs1054354
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 16:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bZzgVikKVem+yKBm9PKQ2pL0LAqojwaDKUW5/SZUQuA=; b=jRm0M6huFizUvkHb
 tZYUdtnmtE2LQE1macTNCd8MjeOQ/jmrtd8i6rVmUi2ynura1X+uSDuMpGOGtMhc
 qK+4Epc530EwLltrtpZ0OZegKQJwLQ8ucfGJAMIAXH/w8N9lElP/thldjCiAKKdp
 nguBbfbmJVWsR/x7LoIYwmAVybriET0q/I2TX6msC3i9vUg0DdJaVAUfFT2VCZLr
 PFHDJlvZEzn7VaskC5AjzbXpDtwuSMAZtXetypupMBydu2h2lZDHID1O51lAde+2
 qUcKbkRcOgG8RBVF+2m+kSHOf392hF0uzxm0p2k+bApZAkdA8cnPpye3Jjmmggra
 BAsXHQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw995v7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 16:24:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fbaada0caso7846331a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777134259; x=1777739059;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZzgVikKVem+yKBm9PKQ2pL0LAqojwaDKUW5/SZUQuA=;
 b=NkRCIPv+S+hUsnWCxtoRROeEisQWBCdtrUVHoELAbYfQBXSXaf5Idqasx6ACauIq7Q
 jBgmI9boRTyyADvvfpb7tamNP5I0ySdjauxalVsm5GL46Xv2//vleSysfuPV2rcSylFT
 lDpdawJT8uheASYcg4wYDZ2M8cohl7lc0/w9Ye47vCnmpOK18yrRZGUCgo3+5KrW4xm5
 FAyaFM11te4EyQHM7hvLpBXIADlTPJvcnFA/Xw1bArd4SPnp3dM+z4LzHtqteIMuqy1W
 6vqmoB1yPbtgxlbxOYIn7buvTxVxFXZeUSOHRKKq2JZMM1a7yUUbyvepnrm5uVDZdhsN
 h81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777134259; x=1777739059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZzgVikKVem+yKBm9PKQ2pL0LAqojwaDKUW5/SZUQuA=;
 b=gGN/M6RYeO6iZZfhgomjtS5OSDukMpwbzNQsY6OzPo/6qj7V6FWbjbZ3ZdVPSrJjqY
 nbjWh6SstDnJeBTlkd2jBF8ujYrJV+2Wu4+rO5h9OdWEFlJ9AwUXHcnOKKpwzXMUNNwk
 pidIBsvMmvNWRESqqT4FalzjUB1yiqprEzCOzzhjuiAotGCaQrPitDoFYyxpcmgToqVP
 W6/bXyuwGyvLppO8Xt82guicDseXZqizHTGcmT6EPhmuC9NH3hmSdOkZ/5WcE8zA/NcG
 otOpi4xczwZPkaJJmA2J/c8pRHR2v9XkHnE4uCpOiOFkAzCkFLR5+P6fJAnsNoBbjKRt
 4U3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ990TolNoEsDMu/O9oSQ8kXFRXHfzw1LevAZG/MSGZRj+1ZxpBl8GGocioKOqZLkbaz+kFlmaZd32I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBKJMiyZipdQLzDpVxbbXzBUDg0X6tn8pa5L6iGpKBlptGwpr+
 M/KvXnJV0fVHWlE4G+JMm5htXm35aAt4yeGREFI3qpx26hyM5Ztbw5pd9PL9mD+CjpT0B3xjXhg
 QNz6jfVSbbxakxn9dRxSJ+gkI4SgLKJNMUhbMbKmsi3QDNg7B3r/29bCtDfg3+CGfxj2EYOPkbl
 dH+/M=
X-Gm-Gg: AeBDiet5tDOr3rU2HdU7xuvtDKz5P1A57KhLm68b901CYVYjZZkpKZFhu7WuuEkJynr
 V9MGQdBOf0LS9IDfCDco0dGKVDmk+uCKMZbjQvc0uSg0zEWeehY0SKyODBXuY2COy+cDP0gHXjZ
 bcTk71azVmkFIM/2NZn/zjdEdKCNj5GqZpISI7B2SN0ZuumO0DhojbghvRC2QfosjttabNRnemY
 srtV/shRdgI04DdanSOqRQdKGPNAJFdVbFzZLPR/skG6J8sBkxS5FcZsnuFzsSQ83E0v3gem37y
 plZgteyGEt/h0aBssnGrQW4pCiyfaWVasYNyljcRc6TOVOfWqxji66NGKB7FwZvCOBUgxb6HllP
 x6WXXDV5GVQlfLgsIS7+HcQuflaW0ZA3GdMOojdDOpGue8tyXCQMq7IylBrxQxbgv8Q==
X-Received: by 2002:a17:90b:5543:b0:35f:bddd:3860 with SMTP id
 98e67ed59e1d1-361403b18f5mr36788723a91.6.1777134259135; 
 Sat, 25 Apr 2026 09:24:19 -0700 (PDT)
X-Received: by 2002:a17:90b:5543:b0:35f:bddd:3860 with SMTP id
 98e67ed59e1d1-361403b18f5mr36788694a91.6.1777134258606; 
 Sat, 25 Apr 2026 09:24:18 -0700 (PDT)
Received: from [192.168.29.100] ([49.43.194.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141990bb6sm27919380a91.17.2026.04.25.09.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2026 09:24:17 -0700 (PDT)
Message-ID: <6d5516ab-f693-e605-77ad-e3f7d0bf579e@oss.qualcomm.com>
Date: Sat, 25 Apr 2026 21:53:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 04/13] dt-bindings: media: qcom, glymur-iris: Add glymur
 video codec
To: Krzysztof Kozlowski <krzk@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-4-0296bccb9f4e@oss.qualcomm.com>
 <a9cacc9d-c7da-4803-8950-97511f8d927a@kernel.org>
 <b89eabd9-3d0d-0128-eb56-99ab2ead2257@oss.qualcomm.com>
 <0d68b3a6-576c-4073-9df0-802f909e439f@kernel.org>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <0d68b3a6-576c-4073-9df0-802f909e439f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GgSDM0VIBgY8U4Y6tPTRCVPzoHnxnt0P
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69eceab3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=gkiTcqCCC2T/77GpOVv7Jg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Hbe3yhC3yqVD2gJYGagA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDE2OSBTYWx0ZWRfX8tMgqH6jZbxd
 d28qFOh299sKixzK/Vfqvp2R5WEbhCkSuGrlVCl4iUR7Z6c8iAvM6kA1rmBfxBHcl5/pt5QUFTQ
 hGRVve8mpqNr13IRSwnG+HJmVOWGpRJaPN03Io/Ql7VOXJgr77qPLMAxs8M2LJQeSg8Km5XYvfz
 dZH9fc1v2QIHvIUK5yny5DEiYbQtcsBq3rwRZo7CoEbQAcUQM0SY69ArBGXVCcItuXTyuBzrA3g
 AhagHt3sWp/44+PzRvud3Savh0zoWSqgnR4LrVj/Ljd5SlWBZD94EhRSiOSrnriDYQCOhAvvSmv
 AykwozldpTKY0vOtciRa/LJBNrtHdobFnbnkAR1z9eJuqTWrYcsZKPtoRhrvaYuC7kZDDll9t/4
 DMg6+VqtfPs56iGuzFXF/auKJVN36yXdIW5zaS7myZoxp9FK5FeVl+E1d9C+nMzk5a6RNzhkaH6
 PsB6ez6HCvTVt0r7fzA==
X-Proofpoint-ORIG-GUID: GgSDM0VIBgY8U4Y6tPTRCVPzoHnxnt0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250169
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


On 4/25/2026 4:10 PM, Krzysztof Kozlowski wrote:
> On 25/04/2026 11:56, Vishnu Reddy wrote:
>> On 4/24/2026 10:39 PM, Krzysztof Kozlowski wrote:
>>> On 23/04/2026 15:29, Vishnu Reddy wrote:
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - dma-coherent
>>>> +  - interconnects
>>>> +  - interconnect-names
>>>> +  - interrupts
>>>> +  - iommus
>>>> +  - memory-region
>>>> +  - power-domains
>>>> +  - power-domain-names
>>>> +  - resets
>>>> +  - reset-names
>>>> +
>>>> +unevaluatedProperties: false
>>>> +
>>> I think I commented around here but probably not specific enough. You
>>> miss here either reference to venus or usage of additionalProperties
>>> instead of unevaluatedProperties.
>>>
>>> If you intend not to use qcom,venus-common.yaml, then explain WHY in
>>> commit msg and switch to additionalProperties: false.
>>>
>>> Otherwise, you miss $ref.
>>>
>>> Rest looked good.
>> Iris glymur platform have more clocks and power domains, which exceed
>> the maxItems limits defined in qcom,venus-common.yaml. Inheriting from
>> it would cause dt-schema validation failures, so I have chosen not to
>> reference it.
> Instead, you should extend the common schema. It's already flexible, so
> what is the problem here?
>
> You then need to duplicate all of the common properties...

Ack, I'm fine to update qcom,venus-common.yaml to relax the maxItems
constraints for clocks and power domains, so that the Glymur Iris binding
can properly inherit from it.

>
> Best regards,
> Krzysztof
