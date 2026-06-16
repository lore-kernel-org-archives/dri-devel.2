Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5388FCD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A298610EA4E;
	Tue, 16 Jun 2026 11:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHqSze1r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dte7y2d2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E7310EA4E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:28:09 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GACTXY3474740
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hoJLZQD2EEa0tSnrFDi3f0vHL8Y+Bwo3kq935KpPr90=; b=oHqSze1rIzdt21dn
 YARjGJ7Ge6GN7U6HVfjZy2vHVJeAxyKgq3FYXWZBAZg/2vNZIniBBBljt8IoXEBE
 ZIUYgwH5fMXt2gqHrdAlAtV8afEj7XF8Ekmio31bTf9M9zAmF41SdpLkoD9lRBm6
 REvG/EFqZNWB3J72tMFwA0x093gJwCkvU5klHskta7YYFkGLgHVhLMBblx5OIKWt
 1V/lismEgC9AhJSWka+SFoj7mRgfyHmez/LGYVT2d06wvNTHogwRDch+WRtXNlQI
 8jG/EHEqwtYVSpKk057nY9ArVkjeP+LcpvY7y9mD62knoPDdejRg4YbNDxlnqDqm
 ZBOM/w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52srvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:28:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517741bcc53so10807461cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781609288; x=1782214088;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hoJLZQD2EEa0tSnrFDi3f0vHL8Y+Bwo3kq935KpPr90=;
 b=Dte7y2d2nzQURHCsPmWNfWg5w9nX3VPXThwi1Bzsspu8JPBDgNcoxXBXlokENCrA2g
 Pdp3tWjzYF6JaKsoi0LL8NJzI0pTuP+HR5EkVsklcnBei9wioT0/jFHePXHo480Z/Ad5
 nafWVjDMyh3qFB9N+pSHapd3g4aToKGKj3EfJC+MJTA8IQiavqsBB14lq5XpGkY22ErA
 zYNAS8yaty/RWwq1x9gUU4ehRVUkfhv6ORGh2T1JfJ/fnaO4oSvD3s3fUoZe4KBMl9JY
 Yl8EFQm9Pu5ETFhlhSLfjaPi6BvrcLmAAGl6NCft4eD1C85iQ+SVwoquG2kgTjRUhxxD
 xXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781609288; x=1782214088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoJLZQD2EEa0tSnrFDi3f0vHL8Y+Bwo3kq935KpPr90=;
 b=Z9R3gX/m5mC63fb2N21FrweAaGZyybbH3kNnO4WiILa2MjvrroeUEiG6LGz4/HFlN5
 HSVExlam/jGoOMLI9az0rgn1ivu2eLVtLhSNj4Swaq9puhFVxFRJSjlCbMo+MM3G0AaH
 GvmrmhPOlnuAHTtW0G4Y0jvvkqhIQifuZkuaie5nBL5q5WCYTTPP7WKynYE149pQkM6S
 fPH2jGhRnppPCJYrNPCwTzthrlyS7pRmXNI0kqk0ZZaJMPq+HwpYpc9r5cV3cdmaVFAZ
 qNYb3SSnREBOV8YK0BhDknwqZnvAqmcBmnQ4L/rovP9DR4k58O/y+lphrFmSUtUj82eE
 dFPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ARXJgef4WoUNczV4QF0JueHza7VcAkK126enTCTILvDQJWQoZa7liEb2VlP6CJeN1EpaNR+6MLy8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBYttw0WFZrqFOSdR1t4FAOCyst4XPP8W83KOtS4HFZKdSwRdX
 h1hlyEEloVbg2rgsRQaQufytBXba72UPLVK+kM5aKioltAik2ai/I9R1SMb1HFFPYa3eg52iiYt
 TLc+Qidqfkl3nCA1blKMqAmww9S5Qea4dkQ2Sqz8NYgSoQOKU4XsQQ+WXwQwAdP7xSrq8f8Y=
X-Gm-Gg: Acq92OFR0xCU5DrwEirXEtiKWlyfeber9C0c+8kNkIJafh3z6Jv9aqocwtw3oaerh6O
 6LXpGJ1MfJKnwh/Ostoesk3r4y1Zbc96d7Xyx22C5mtx75pLYy+uwE8CX+EvPHJPfDDDD6dYq5Q
 Mfnv+dKkjQWKWx5YSqTPWqx3AF330DX/xk9yfBhthv2RxFlQw+4cnAc5pBuUjV7uvIjffTm7Rey
 /lEVZIqXGy2CngYf/zi3d1J47KOtik5Tv1ouUJrL1+GdtAw6ymJ6OafBTpfJpf87uAX9xbsFj8C
 jCapIjvJW3Lr8CH8MDI011gFa+UOXsXBVHABXU0CSr7R7TjkYGTIgrmgeydTIk6Huyj0QFdzswj
 ty6XyDj4UWPmeQ8vgodnc6bjGMbibZUhDSSNRo8I+nDW0Ng==
X-Received: by 2002:a05:620a:40d1:b0:8cf:d289:d0f3 with SMTP id
 af79cd13be357-9161bca6345mr1744419685a.4.1781609288142; 
 Tue, 16 Jun 2026 04:28:08 -0700 (PDT)
X-Received: by 2002:a05:620a:40d1:b0:8cf:d289:d0f3 with SMTP id
 af79cd13be357-9161bca6345mr1744416685a.4.1781609287724; 
 Tue, 16 Jun 2026 04:28:07 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb522167dsm628573766b.25.2026.06.16.04.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 04:28:06 -0700 (PDT)
Message-ID: <d6da3d13-a8a7-4dbf-b89d-06a1fbe41260@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 13:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x Gen11
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>, rob.clark@oss.qualcomm.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-2-57c70c23d0d6@oss.qualcomm.com>
 <7a330941-8715-4523-9f39-10b57586c69d@kernel.org>
 <CACSVV03J7Y4-ADRNE+4qArqsWvQZ3qmTc04r7vmY64s0qDYFkw@mail.gmail.com>
 <799fea04-e7d0-4184-b9ae-4cebfdac38d5@kernel.org>
 <841a54ff-6287-48d2-a513-a7442d624ab6@oss.qualcomm.com>
 <uieb6ukjokwnppc5zfr6bjychqsnpikwmiy7j7dmt2kgk7k4zi@2stv37ijv36o>
 <ac191a18-bcb4-4fa5-a179-b72a6ac928cb@kernel.org>
 <20260612160519.GA1118842-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260612160519.GA1118842-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNyBTYWx0ZWRfX5r5zqhpA2bOv
 WuXl/aNSRrSgg0er+q4Hqw+MmDZlrqOOyHFYDe2oCL9PqyyezXbUL+sel/H6GsG97kJi0LB3H1k
 iWdMU/O39QNbWWZCcqleyiKWFD+x5eQ=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a313348 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Kc-3O7wfv0iHM2_tCFYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNyBTYWx0ZWRfX6bOcvGrQnSCq
 s6Kxa3rIXNIjLIqXpmv2ZNTgLGbd2sg09SmwCiIDSFHsgWa3CHNOENvKSldS9Nkig7cdiwMEg/b
 YNeAq7OnIg+TtzCAW+V5Yfq/yNdt72g6pg7f//MFurBo9ryxgjPXSr7ct5xBO2L6xAdsG0ROdet
 sZrxEzSEpw6ne7xTpFlcxjhdNsX+lbC99wL6R+WqvOevK48rm3afUlZLNo0MdrEq6gXXG6TpuRR
 WAgc/0jXBP5ozZzX6iydRfnexfV4K/P6+VdyySQ2FJR7iurROkDSf0e9Z+gxqRH7W82dqNVmzP9
 YA5ShkDfRKUqJrnMfWsM/W5PrzNk/lFjiJiLCiqd8R1K3I/maw7wot5Z2qGU9oKwZWqORSgDRfp
 yhXGLlEi6GLa8zbqOPM1pH7gd0Aw5gRFlhYvKoHPPiiho1USY6Q/nHzomdgTmRFfaP9PnWXJGsy
 tSsRZoNyVPK81O2dDxQ==
X-Proofpoint-ORIG-GUID: PLoywbIzIyYDTS7tEIT7MBhoLl4hVAup
X-Proofpoint-GUID: PLoywbIzIyYDTS7tEIT7MBhoLl4hVAup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160117
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

On 6/12/26 6:05 PM, Rob Herring wrote:
> On Thu, Jun 11, 2026 at 03:48:15PM +0200, Krzysztof Kozlowski wrote:
>> On 10/06/2026 15:31, Abel Vesa wrote:
>>>>>>>> @@ -68,6 +68,7 @@ properties:
>>>>>>>>
>>>>>>>>        - items:
>>>>>>>>            - enum:
>>>>>>>> +              - lenovo,yoga-slim7x-gen11
>>>>>>>
>>>>>>> I imagine you might want different panel variants, just like T14s has
>>>>>>> LCD and OLED?
>>>>>>
>>>>>> I expect this will be the case.
>>>>>
>>>>> Then better to prepare for this now, otherwise later you need to change
>>>>> bindings. If unsure what other variants are, then at least make this
>>>>> compatible panel-specific, e.g. lenovo,yoga-slim7x-gen11-oled-foo-bar.
>>>>
>>>> I took another look at psref [1] and there's only OLED SKUs (today?).
>>>> There are however, two different resolutions available and both can be
>>>> touch/notouch.
>>>
>>> If the other SKU doesn't have touch, then you might as well mark now this
>>> one with touch suffix or something like that.
>>
>>
>> If you decide not to have any changes (new compatibles), then at least
>> please document the above reasoning in commit msg.
> 
> If the difference is just the panel or touch, then isn't that captured 
> by the panel and/or touch nodes?

We already have a couple of DTs for laptops where the touchscreen may
be there or not, with the additional hid-over-i2c node defined
unconditionally and it works out fine

For the panel, it depends.. If it's another "Samsung ATNA"-class panel
(which I would guess is the case, but can't know for sure), and there's
no other changes, then it would work too.

I opened the build configurator on the Lenovo website and I can order
both kinds of panels with both kinds of SoCs (X2 Plus / Elite)

> OTOH, if it's different firmware builds and generally treated as 2 
> different devices, then different top-level compatible is probably fine.

I unfortunately don't know the answer to that question.. 

They all carry the same model number on the website, it seems

Should we go forward with an optimistic, single compatible for the known
variant ("lenovo,yoga-slim7x-gen11", "qcom,glymur") then?

Konrad
