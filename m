Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B51CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5D810E950;
	Wed, 10 Jun 2026 12:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9ZQfilt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hoLLmHSs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7C310E91D
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:12:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ACBx4Y1073141
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xGkUpLUxzhuoLP0OdwLiPqPmRiRkn9HrYAcmu30w4u8=; b=k9ZQfilt+a71nvjj
 91Pc8x2Qlq0RR6NQrRuKrjPzV1jVBeV6mg1HL0nnQ8/WIrnlrEsIn5RCFBVYpnkB
 xzpJiklROibXTgk5x2oGjRhBw/AuYyvx9NXObdWNcEdwto2h8VMU6SaZr2WsQC01
 smdtJGens3ry8VwxsbQHQB3vVjD9s11iq/ancHDAlsmgOXdsYcoww/EOivOzIQVC
 nQzQ3FMMO2GCC7XOoc1K1qZPQ60ceqF1M+iSkmC6pkJ72AQ1/KiK6tA/F+0Zg8YT
 qacFNvA9Utd5uGqMoMP6zTX7oWm3GzJL9rgExip3r4uIloCls+0adbZEKvVGlz21
 zYcZ1A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epxuvj2qq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:12:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ccf128a93eso14259236d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781093555; x=1781698355;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xGkUpLUxzhuoLP0OdwLiPqPmRiRkn9HrYAcmu30w4u8=;
 b=hoLLmHSsh1oLDb8udZBKLyTaHUz9lQ1ex1hBRBi71VgF/O8mzNpgW9+mObCILrLQ/8
 836Ustox8oNk1AM5KY37aGc1TmR8nzY325MCHzSVurwxaUiSHvzVzZx9hS5InXnf8VNI
 Fw3VHRJftY9cCv4iSZH3S8ViA4yoH/6IiCRwCgFRLQljKvhPWYT4zmEbiSvJnU1TVpTt
 sHQG9y2MZaORtT0vVuDmc90XWnr/sX75D0PpUmLMMyFDVy0aUxMHBoFMPnvnQuycIW9e
 MWAWPC6RrM2SwRHfD5LSgT81ZiEinS62uL+296HK/3HVqWvenZXVmGnHmHPag4vmiz12
 kuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781093555; x=1781698355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xGkUpLUxzhuoLP0OdwLiPqPmRiRkn9HrYAcmu30w4u8=;
 b=NZSmkKylKg5sQPO3JfG15fs3nnZWMhXyw5Scm6xvedfSWk/zCav/KSY0sKslhi0Jnt
 hW4Ll6vVlkv5Tk6cifwtK3RwwtRXzNNsq5XyMM+KGj4sBZKzrXhmtJoMRVrJ9+32dQKk
 mk75fvBE85CZCM/OSG5FR5JNtuZWD1xDeOR6dac676R55Ff94oI/a/ePPMclcWvfFl1W
 DAsDVOqWFwMcTtIudURqXzZmTcU61jAvyaIoIQRiOT1NmAXkVNPebw+SZt5tegSjqiZL
 Pt0OujiOpFrA9rJmy1EpM2Sjp7xXktrO7eM4XUPbymbj53+tIz5NsACMbEHJdwopo6ep
 ICzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8npcpCpIEEUROSxS1Wc4QOw3B+JJCZAqhcZrxYbKbQ9+nJPMlSJKun+rAwjo8xomRHH5cbgaIEAvA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwF3JWcWtjzqNDrp8USt6CpgqWksQovcjCt3p3GSCWUZBq5Ry9b
 9jjH4VhLUKj+SEc1w5BAiU+fjTPBb6HigMdlzBz/E4jjHHN5M1gMXPvwBuDLocGQNmnA3At3bIt
 JNiWA58jEmnas/FgtiLv2G957DhfJewCsZFwNGcq+FLTNK3t9zpo1FUE8gitqzjaCPhOtegA=
X-Gm-Gg: Acq92OGsNvakhoOFxHq5rohfByEakvyN3DyFSeUnik7REB+bbE98dNxDBWR3mZlMW73
 pgkjO2QMtkAKmjVliEAwgofLZnlWJ5JkqhFATfHGjPP/37O0cze4/ejAWvkWzeA2tYARJuEi3ii
 YPMGkwRjN8C9/IWAtXwiGv4hdFcbs5H1QfvKyZmJHuJsQxUEiYE1SEYKY33SgGdzw9f5vJDjLFq
 z7vpG/2pFkakmmTROIZy9if0ASvT3VjZStGmvvg+011UXOdTNjqwbBSXRMgwBsbg0YVOA9erd+r
 JLOUHD92rz2F0bmtPis2HbJSM3JLJR9osNcCGs7y6Jgc7vThy5LVcoM3mgKA/mlIp4CCdVO52Qu
 21kO1Rbh4xDBRKtndgKXPYsUhvrBSLFahUguklh5CYUCKoc55lNA7/d8u
X-Received: by 2002:a05:622a:93:b0:50e:5e6a:c7d5 with SMTP id
 d75a77b69052e-51795aa8074mr209898771cf.1.1781093554606; 
 Wed, 10 Jun 2026 05:12:34 -0700 (PDT)
X-Received: by 2002:a05:622a:93:b0:50e:5e6a:c7d5 with SMTP id
 d75a77b69052e-51795aa8074mr209898381cf.1.1781093554071; 
 Wed, 10 Jun 2026 05:12:34 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517721e5sm1193637566b.9.2026.06.10.05.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 05:12:33 -0700 (PDT)
Message-ID: <841a54ff-6287-48d2-a513-a7442d624ab6@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 14:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x Gen11
To: Krzysztof Kozlowski <krzk@kernel.org>, rob.clark@oss.qualcomm.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-2-57c70c23d0d6@oss.qualcomm.com>
 <7a330941-8715-4523-9f39-10b57586c69d@kernel.org>
 <CACSVV03J7Y4-ADRNE+4qArqsWvQZ3qmTc04r7vmY64s0qDYFkw@mail.gmail.com>
 <799fea04-e7d0-4184-b9ae-4cebfdac38d5@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <799fea04-e7d0-4184-b9ae-4cebfdac38d5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VW6TbZSOhV86dRhnE9mcRUi6qsnH_78V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExNiBTYWx0ZWRfX8SBGd9PjqXpe
 EDL3RQN5OucM2kZkBPZsm9SD7gBReZfFoX4Ebg+ctZvxTCJKv3G3nahDHnzrmmZwcGx0lLoNblo
 UjQBN3TewX8O8bCTd8CFbyymhDaAP4w5E2v4sScSNn1oG/Vea4X5ORdV7/toSLwjHlZrZxbtbXg
 OdbpWXcG6yEomYu88K1dfIyDxae38WfzCYz+H/zg/MRXvBd1cEINSRwO/juaP02eKqaazIrCZ33
 6N7LJEreIv9ha4vUJG9gzPcfcvCFYii40S+0vSidpfU9p6zvgt+iWgXu5jsyy0bm9ynOWwMIGcv
 Nxz3A4/OxPp8WFxu34xbEKFiAZ1EC1ykC7+IteQivzN6y5yHVAEBjQeC2lbO9YwygzFY/2YM6bn
 ugOrsLq3JHbbPZFFr+sh5oV3vL2qo6uQMUvrLSIdZi5WbftHTB5nuw1qYYGv2CUx9LHMbfdtKZZ
 DrfcEiJFDeEOABKXDrQ==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a2954b3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=8k6WQxmsAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=8WJLHc3ceWcLwtWtDxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: VW6TbZSOhV86dRhnE9mcRUi6qsnH_78V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100116
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

On 6/4/26 5:18 PM, Krzysztof Kozlowski wrote:
> On 04/06/2026 17:13, Rob Clark wrote:
>> On Thu, Jun 4, 2026 at 8:09 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> On 04/06/2026 10:06, Konrad Dybcio wrote:
>>>> The Yoga Slim 7x Gen11 is a Snapdragon X2 Elite-based 14" laptop from
>>>> Lenovo, featuring an OLED touch panel. Add a compatible for it.
>>>>
>>>> According to the spec page [1], there  also exist other variations
>>>> (based on the Mahua SoC and/or with a different type of display panel),
>>>> but those are to be described separately
>>>>
>>>> [1] https://psref.lenovo.com/Product/Yoga_Slim_7_14Q8Y11?tab=spec
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index 50cc18a6ec5eddaf48542b85387c2d430cd4721a..fca3d180489d4cd3eb2726a722f15febe44f03ad 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -68,6 +68,7 @@ properties:
>>>>
>>>>        - items:
>>>>            - enum:
>>>> +              - lenovo,yoga-slim7x-gen11
>>>
>>> I imagine you might want different panel variants, just like T14s has
>>> LCD and OLED?
>>
>> I expect this will be the case.
> 
> Then better to prepare for this now, otherwise later you need to change
> bindings. If unsure what other variants are, then at least make this
> compatible panel-specific, e.g. lenovo,yoga-slim7x-gen11-oled-foo-bar.

I took another look at psref [1] and there's only OLED SKUs (today?).
There are however, two different resolutions available and both can be
touch/notouch.

I don't know what this will entail - if the panels are both samsung, I
would guesstimate the same driver works for them (and Doug was against
adding new compatibles [2]).

There's also different SoCs (which will need another #include in DT to
override, sorta like hamoa and purwa models; they seem not to be
available in the store rn, but I'd assume it's fine to just rely on the
SoC strings in the compatible chain to differentiate them.

Konrad

[1] https://psref.lenovo.com/l/Product/Yoga/Yoga_Slim_7_14Q8Y11?tab=spec
[2] https://lore.kernel.org/linux-arm-msm/CAD=FV=XBn78eOC_zG0S2U-W3whrVYEpghKF_WgX+3zpUJ82-5g@mail.gmail.com/
