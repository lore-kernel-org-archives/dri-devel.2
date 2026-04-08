Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701261073CB0
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE2410E666;
	Wed,  8 Apr 2026 13:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBehY+M0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B/NYmv/h";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEA410E658
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 13:32:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638AeaJ43362677
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 13:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D6RvOwvFYEYCyXFzHd+gy+nHIBkNAGshdd9r2tXEymo=; b=kBehY+M0qav69Qet
 5ajjor4PS9U5phswhDEmanQbecRTIxjQkdHqhF4NtLP5+xxkqfqUh2xO9BG81xgV
 k6obVktxjCuWzBW98LLSnYKMlO1UesW5hFhzIpTCHT1G+eE7cNbofMkRQyckYdu4
 dY+twkQcsdBJxw3Wo33I4F4aFPSuGM+lJJey994WLjG3K5+dkaY3dQt9NVWlP5uj
 uuTrFZfyzP6kuLu1Zn5H7N/1OZc8Ol0d4llDTZEOQOCdFybB13kFJSnoXfCCUsV6
 kzfYcWFGZLe+k97XifhYyN25y3gbJQ2SK5bsJKLO0Ph0IeOy0NIFYmo2ClX4qEtz
 pwEmkQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tkkjkh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 13:32:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89cd541c0edso33647316d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775655155; x=1776259955;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6RvOwvFYEYCyXFzHd+gy+nHIBkNAGshdd9r2tXEymo=;
 b=B/NYmv/hkpYH2bALWuXaXQrI6px7Ox8pYIeLOEhYgssiY22lYBO5l3loV95oHal99D
 b0WKebuoQEQja6zwTfb7jRmk/7t7RxFx0bQ4mnOS/8FWlbf4qucFLeZdW3q3ni1gOWlF
 AIdGtuZW7Ok6biDgbLH+My7u7mjWRoIgG20ILauLe+zm+ZR0W5Q/ZLJNcaJsYwGm/EuN
 rTL3+/Gt1BozNR2EuSvCPvUFh8nhr5ofBX2O96dTdTr8ZBOoSQQmXhO4ATMzKS9udypS
 JH6oH3FVRpPimGva65v9JmGFczSZ/AjyUMqZhSC8haR02mhjZ3b0IxEWEZE4334PBj1z
 vrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775655155; x=1776259955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6RvOwvFYEYCyXFzHd+gy+nHIBkNAGshdd9r2tXEymo=;
 b=Gg39+ufhEo10mWZ5Nn8yIPRlUHW/WL1EqXfsOY/nMkgVKy6Y4iY3uUJr0730d96R4T
 VJxgbtUvPbu3y/xSqyyEpgsNxFzMwxAAUb6F6O0y0qg8A4Fjx/6RFZoQTXNT/9KoK9rS
 HCnqOaim2GDWadBCbf+W3DRVRZpWrVA+V8xa0OmXGL4hp/umKyiOcouyMOlYyPRCl3t1
 +sGcT/H/j/nfjaPVD4ccrBLpb52FZZcF0XFJltFNbDu/jpuqgFSH6t0T3rVvaKOOqSrZ
 ol5hynNXnSYIilAt16zgk4NsEnXFMskhnONy2XkJ6Q8GmL8fYGNfdvaz858cqohzQyAm
 uGIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAXxxgyEBFnrMQ8KZZtB4zod85rX1SqU+Jb13XdwOzxUl7wTeELyQ7CMh+YAqHObeVHix+oPAz1L8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRLNiVXE6xKRwZdldtCRb7XkYuNB+6j9uXuAN9AprdqAiZBL1W
 Dt6g1C+VZeuZ6UjXogwmWdN5/z50bOJM4kAtOa49tJq0wl7+TDSbjAzxMK+y8aU7AhIiyA8D1IJ
 cO08HA4+Oe3I0SPB5oG3XUQ3eeaPPzhzxatXEF53EwVPIWvTBoMS4a1jxE2vvZ25VgtR8WxE=
X-Gm-Gg: AeBDievSiuRtsPG6Zgor0MEIm0X4Hq91ZjWaglrCPpx9JTD80fHqD5duxAqizX2pL+I
 n04+7uHE/ZAQQUWR56u+/+28ww2zHtqwKIqnkoLeiqlgMGGqNcGKdKED2RTd4GFOSt10Cqx8kCF
 xUuhpPWSTSfMgChT/LS4V/OHtwdE87pl7p1ptXiWDsI2Yjqlv4pBpapA6NwloPI+SOH5AknQiOu
 zCyWZmYSsF2O4M8WAq2CFIIllYRUq+7eeBxPPfDkxrsiNIrDbQSq5L0yz2xH5zKgvMeMApNZJuv
 J3npnqGrmFajOqDrq3w/jZHdxYkR493S7zIysYC3IKmunhyTkZ3nOspcOzEod9rAaIH2HPEA484
 72MP0aLdXN4NILs6RHM5M1syVLQ7vvKEYDSy9YFcQjYlKW+ldOAG45cXAgu+lsZKK/gaZqf2Y0U
 f50yc=
X-Received: by 2002:a05:6214:29e4:b0:89a:564f:bbab with SMTP id
 6a1803df08f44-8ac63fcca40mr36122536d6.3.1775655155375; 
 Wed, 08 Apr 2026 06:32:35 -0700 (PDT)
X-Received: by 2002:a05:6214:29e4:b0:89a:564f:bbab with SMTP id
 6a1803df08f44-8ac63fcca40mr36122206d6.3.1775655154784; 
 Wed, 08 Apr 2026 06:32:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c97218esm647078566b.9.2026.04.08.06.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 06:32:33 -0700 (PDT)
Message-ID: <437414cc-e2a0-48c7-858f-65cc982d0861@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 15:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/msm/adreno: add Adreno 810 GPU support
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-5-725801dbb12b@pm.me>
 <6da36e75-effb-4e3e-a2f9-c0f3ebdbcc21@oss.qualcomm.com>
 <hvcBm15eFRX0ZonD34zzneuD50ceOzKGo1pE8LkQrQL1qEb4t0pEA4ankxEViVr7lwghJeGOoYp2ub8Ti2idrIzMfBXHBqnXejwukigxz9s=@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <hvcBm15eFRX0ZonD34zzneuD50ceOzKGo1pE8LkQrQL1qEb4t0pEA4ankxEViVr7lwghJeGOoYp2ub8Ti2idrIzMfBXHBqnXejwukigxz9s=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=drPrzVg4 c=1 sm=1 tr=0 ts=69d658f4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wpl9K_kFG4-g1iQaUfsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: Zs2c7LglPQz0QesHUAs1QmmrMDy3LMqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDEyNSBTYWx0ZWRfX3WjKhtqt9F6C
 lA1dP+PlxyrQkKyJvL+oA3NyrTLwI9Hxz4j0U4KGOXPFvM6qnP1ivZukt0C7v0ZSWn6O8yUn7Z+
 nTGNqhNSKzfO3TIGzXaNeOfmWf3PwaqtKHokXrPDjfOeApllHxj+aEzXaZ1oO6SQqoNHVCKzPxb
 sOgfVPR4nUiobPL3Sqbuf75CgdGEv2i5zfkiEZwkaboCtNls1gL0v3DprLzI0u8u06MWqsCVzSe
 Szhnkmf+ghglzIdhrCb//ToxkdHz7Xrf606W7mNKCzvUgpvL1cIHQ4jstRNc/RuBhYZda4Uno36
 5clgCHU8kd1MvKy2LjQXRUgeL+p0LBFuLE4oQ9gYCnq+fhK0NDz/Skrbu9QuXozAv4TW9hwDj6l
 HoP2s08E5U6nu9LnE87wSd9S5IA0MDDHJ95dHmmwJ45uwzKu/bnGgp5KVtDbF7HeYePJYBp1dC+
 aYfOKnJRTYtewRlhBkw==
X-Proofpoint-GUID: Zs2c7LglPQz0QesHUAs1QmmrMDy3LMqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080125
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

On 4/3/26 12:14 AM, Alexander Koskovich wrote:
> On Wednesday, April 1st, 2026 at 6:15 AM, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
>>
>> I may be on an older tag or something, but:
>>
>> $ diff /tmp/downstream.txt /tmp/upstream.txt
>> 24a25
>>> { GEN7_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
>> 27,28c28,29
>> < { GEN8_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
>> < { GEN8_UCHE_MODE_CNTL, 0x00020000, BIT(PIPE_NONE) },
>> ---
>>> { GEN8_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
>>> { GEN8_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
>> 31,32c32
>> < /* Disable write slow pointer in data phase queue */
>> < { GEN8_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
>> ---
>>> { GEN8_UCHE_CACHE_WAYS, 0x00080000, BIT(PIPE_NONE) },
>>
>>
>>> +};
>>> +
>>> +static const u32 a810_protect_regs[] = {
>>
>> $ diff /tmp/downstream.txt /tmp/upstream.txt
>>
>> < A6XX_PROTECT_NORDWR(0x0ae00, 0x0),
>> < A6XX_PROTECT_NORDWR(0x0ae02, 0x4),
>> ---
>>> A6XX_PROTECT_NORDWR(0x0ae00, 0x6),
>>
>> -> the difference is that
>>
>> SP_DBG_ECO_CNTL and SP_ADDR_MODE_CNTL are not protected
>>
>> that might have been a part of the ^ difference
> 
> Going back for v2 and making sure this is 1:1 to GRAPHICS.LA.14.0.r5-03100-lanai.0, I
> think I was going back and forth between my own downstream from the OEM,
> GRAPHICS.LA.14.0.r5 and GRAPHICS.LA.15.0.r1.
> 
> GRAPHICS.LA.15.0.r1 has gen8_3_0 support, but I'm not sure if there are any
> devices that actually ship with it on that branch. Seemed to be fairly out
> of sync from LA.14.
> 
>>
>> Also it may be that the better name for this table is a830_protect_regs[]
> 
> Can you elaborate on this? The only names I know this GPU by are "a810" and
> "gen8_3_0".

gen8_0_x is A830 (8750), which seems to have some sort of a common lineage

Konrad
