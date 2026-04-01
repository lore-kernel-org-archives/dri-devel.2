Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D8D3515F
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964F410EAF3;
	Wed,  1 Apr 2026 08:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AfWyphj5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dloq4KPR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A2410EAF3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:40:48 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6314Ga5o1579367
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 08:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BDagwufMCUS3ui7Czr00qwvBpE5LW4lU/kv1dVv43gY=; b=AfWyphj5jGRKJdU2
 mIUbel0nlnEeEn9iIhQxbQ8Ti4Ondjh2ic3+AY4Uxt83fAeYuoGriKN+LYiiWSrK
 mXtnfyddpHqjsWBv/sMpRMfXIG6zjc9qYSt2pi7nU2If+qF1Qy4YuPzswFSSuJTf
 7Onu2mNftjqFrzpPss9pQehWhyPTncW6EQx/pkFm1B6AbTZxtHyrxhUlwidb6YJF
 tbPLAwl2Uau+ajY9fDfJdv2BEWFiFnq7ns/AhgWjCOE9st983BdZZL1ozdzLqRQe
 CRLLnzRodzZWPyxrOqPwo+VlTdSVouWy0yHjrywM7StnXfdBj6x8400O+6CxkMK1
 ygp1hg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2tmf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 08:40:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89f48d009c8so13620636d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775032847; x=1775637647;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BDagwufMCUS3ui7Czr00qwvBpE5LW4lU/kv1dVv43gY=;
 b=Dloq4KPReJoJCo1V8DyuDPRnkcvldVy3qwZHNit8KFzub1AGEBOFmPrgXimOCgikXL
 Kz2djYAOenHFIXho5Ldl3vIKv8nM/T4E45Z/XKNtBdXULe7u0nLS0KVk/nwS2HRFJ2Jg
 QKBWGG8//7ynhflPCQop1JBU0ge80hWsRanfE40EvEqWhvuJ7U6pV/XZOO3c/fRXa1nk
 geC+m8BteHlQ92E6RcJXQG3jblVEYFLBAVLnTIczdY6e9PtVw0mLfnAiOzH21Y9cEpjL
 +Tp9lUmBcP5WTHLpffvL5cavGoZosOJivi5HIsHxx8Rjyrs+85FcAvqbAV1ihSHn8n6I
 zA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775032847; x=1775637647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BDagwufMCUS3ui7Czr00qwvBpE5LW4lU/kv1dVv43gY=;
 b=BsUJr31BT63d6WeQqMtQzSkmnQNEJqVlN86CJ8tCg3S/n8d3/R+AO47ZXeiLMbK2zR
 4IoeeHx93HqLHfLBCyhqEv4KjbOxgSeKvChkAmBeA9ynGHZm/dNrY4EIfy4U4JijxOIP
 BpXuHm34MtbX0MK70yYexAVWF91NUQAC4KcDx4BIiequI/1twlbimMagyASdRZIOWNBP
 f/ATM/Tt9DCyo2C1QJ0mLs3PX2Qho+fpWmNH7FnWxxVBJMgc5/RCVhSdkI6vd2fPgk1U
 Zl+JdKIqpCh2NlTuhdAcjbvM1cxOsznzN1dnkPl/ufi/x9TblvBRyzSpFuntaWN8gR6E
 r9Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw9/zr/Qjz5Isn674dEegjbOKfLoz1865bnfnRS1fOhr0O210cgk07PePolSoVtGiT9gWk0pl7StY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySsikfEnkL9yA3ABpWu71P8F6f6oOv6uJwtmioFllKDEi/lNHF
 AnzDCZzCvY/K7ZJil8ToZcAYWekhYzTr7+9QUWgoIiYS0tw/D9lABERRjw8InMOPJqBFNBcViLW
 kgBcsdcXkgtLYJMSG5VVOWy7jwde9fv19trOzpqq8hNPhC7tg09/7TsDSmWkt134UgIY31xY=
X-Gm-Gg: ATEYQzzcQoWXFAi/PckTn7N17h7P1OmOIx8jd4U+KntUkueBepy0I4kdlNHY9idxYkd
 VvvZ9EnQY1wynQsb/mCDG8lesMYHS3BcSTXulE3F9AqzwHrSfPqkxL9r89/xFDwJExuJS7J3cIl
 QkS3R1xHnlotH2xUfCD+p7f+RDosMUCS9Qn/AxfijQP51aYX4x3uFwULYOcVa1E6vR2Ciz3/vZ4
 KWRj4HUTDAGHWrnYDCjMvs9QO6ZdyFmZBCGw4Kp006I7wHH7ynchR8TVwcp+uSnG1Bfn6W1URsJ
 6Fduu7AIKEMjjJ4jPeUuzH7O9R/z6alewkxVZEKm9G8zTaXl8NkhzAmqFM0hA7Fw3rnZ+EGLKHO
 x65/OngsmHXHKkOw5RKdCArmrD0DAeFOk06rEheuxeo7/N3SPrXPC3nM1DKHBBUyTfG7GI+vIjQ
 Lw+TQ=
X-Received: by 2002:a05:6214:4012:b0:89c:cc08:c56 with SMTP id
 6a1803df08f44-8a438dd0481mr28226196d6.3.1775032847054; 
 Wed, 01 Apr 2026 01:40:47 -0700 (PDT)
X-Received: by 2002:a05:6214:4012:b0:89c:cc08:c56 with SMTP id
 6a1803df08f44-8a438dd0481mr28225896d6.3.1775032846552; 
 Wed, 01 Apr 2026 01:40:46 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5dddsm506284866b.35.2026.04.01.01.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 01:40:45 -0700 (PDT)
Message-ID: <e1d05708-a812-4fa6-8985-ff6995350da9@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 10:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/msm/adreno: rename llc_mmio to cx_mmio
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-2-725801dbb12b@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331-adreno-810-v1-2-725801dbb12b@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccda0f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EWmrOR-qnjryNtOcuEoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: OPQ7XzIcWMONHbK195uYJ8yVhuopxv6-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA3NyBTYWx0ZWRfX7gHOOisfE8HQ
 yQGtCqaiKHIbRQE0ZQ+mOBhDE//MelwaDd+UD1NMqSRlQoclZAmnj2zspInge3upP5Z5dB4Lo90
 j2HSAQgjjzmvMFWT2/PP+aC23pUWDUJTAe+JVCekgEeaQhS3WhKJNLCMAEKo983ygrPncMg63+z
 DIkAPw3+Ml5TM1tl1oCdOElGuiwgUpCmMB58ALQtPowe44jW+FlYdM8mHKqzAoBztkwGwcVPSwJ
 7+tbcwTkEz4ZoWBqryywOhOwDP7VTOtlBmc3S+oIX8zM44KFmQ2tKEsSs7Mfxm6DndYCpHrlOKO
 dU2FGLf7J1cT3x11qYF9cw5O0/sigcmZFHFHoYX9brP+JA6wkln2D3Cl63KCssqKeNjW8flQ24p
 +q0YnFDwdELwX81JQ6F5JlYgkQ6Jh1O1NdQ38fg8OpJdHbqSVDAeD/FOkJ2ShkOGVOmWO8c+CCC
 pwTbH/lqDQUIZQA2NJw==
X-Proofpoint-GUID: OPQ7XzIcWMONHbK195uYJ8yVhuopxv6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010077
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

On 4/1/26 4:17 AM, Alexander Koskovich wrote:
> This region is used for more than just LLCC, it also provides access to
> software fuse values (raytracing, etc).
> 
> Rename relevant symbols from _llc to _cx for use in a follow up change
> that decouples this from LLCC.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

I think this would be better named 'cx_misc', but maybe Akhil or Rob have
a preference.

(VDD_)CX is name of the power rail that powers most non-multimedia parts
of the SoC and in the Adreno team's lingo that roughly refers to
GPU-adjacent HW that does not need the VDD_GX ("Graphics") rail to be on

CX_MISC is a specific region within the GPUSS

Konrad
