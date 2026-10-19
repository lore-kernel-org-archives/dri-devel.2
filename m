Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F725CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C5088EBA;
	Mon, 19 Oct 2026 10:31:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3E810E9C8
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:31:22 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P5Bl1896530
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RYK1463Om0BeLkjtSbKer/jvmkMwEuX1kL+uNM6n95M=; b=Rmw8KTi0pUVSCpBY
 wiF8RiATQWk60bVp/6dCGSJIy1eEb7SEmXjJhM/T7Ku82wna+2M16RzB7oHjuq9I
 6EBZlQXb+bAbnaQMACOajPSc8TtRZobmWmiNNB6yQWiVu6RA/+QTUKUAwJKbRKSo
 vB+0NY8vnFX0nqkI676eJNB7IdeamuyHa3VJJU1FCBJlK+CoBWZF7I33jluOk2ni
 naStfiVbo6lArR7JOy9y9iJhB0p6t6h6qc5U02bdBMZmxIrPt9B9UofwuranTAEh
 xvTDVLBoxxPGcGDNG624IEM2QfeM/qsWE/eI4/pPRErWn0Kei0r45YawOfQn6RG6
 zwIyBg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr9e88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:31:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e629c7b16so34028485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405881; x=1793010681;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RYK1463Om0BeLkjtSbKer/jvmkMwEuX1kL+uNM6n95M=;
 b=EHzh6Mz1d4b3eAV9YhMqekAKZWu+nLPO8OgOeDIb4dkpaDT5UrRLyLbUPZjCmxLM1H
 IWy5XuVUJTdDXvi5HmlqITucK/4KVnKnKjk1k4m+zecJ00z6KWuHXqNInzwZC0+6c59l
 jDCqDmdQCdS8+Cb9D1IM+XqzjFY0wD/ZE1ekP5p8Aa33iqUHzy/OL7b4nQ7qtHJk/7pO
 B0HGMexJ0NPEeYDGzf9nCqwd+zvY8oheKp4ey3JfQkrSc7o0D91LLcXBAyGTL/gPgr2I
 UmbFwvH+Ktcl1bqNvJ29fP57b+k4LphUFFYcp28bo4TZi9QlJ6W/W6hmCOK5F9a4ZCIv
 K/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405881; x=1793010681;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RYK1463Om0BeLkjtSbKer/jvmkMwEuX1kL+uNM6n95M=;
 b=Vv/jcabw7TE80KUNV0GGVeqAPRA7cbwlEONCmdhtOkEkhXm5mKUL1qZrzMfGAOdItB
 a9BVozZ93WU6lVf5uWj/ZlSk1ZRGmPC2ohR/xsd435jfi4WzLHNcbXkLA1bKKGiAkFAV
 uVh7GTGT7bZYuI0NXQV3YvmIfW4tighRwVr5Tdtag3lfUb9jwW9uaS8lu5G+qpNokBgQ
 0ThilKLCZOnQdr3w+OfSLcf+WoKqBLDn0HMFf3med1i8RSPI1lt0CfkKWYUJJUCj2fsl
 ACajTMyDj5ogEosN1sRYJik7JGWY+SsMVpB+WXr7TmRPHduVi6p5RLSkOVbUNcY4xZYW
 sM/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU3O4usdf1oQ6JzQhPmFJu/w5DDUSHyEgHugRIDF4Qzu/pRcoR5jphZ72MNSsAv5XUGMTxEZdczFk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJvmZD6NfWrVRiqcAnQ5q2NKJaAz4QTxYB4hvYyDDFOioXJpJjr
 uXEMd6oIVpOye+C8hT3/7muuipo8zqeD+D85iqyL53jWHDwzIFUWKl57UhgdhbCe7YX2R2WxlvC
 KWQOynafRqJtOXZsqSLxGPQJR6RqRz4AQC8tNPwr7443uq81bpHGjRd+baig3M84jLsVqasY=
X-Gm-Gg: AYBFou0HO5m60MdvVN2fzWTQDNhDH1CZsQGHSdEJLz7RfcSqw1y+mLxd2Cn0h8u1QeU
 /gfWrfs8rNwtbvq5pH4IZIpehdKaduiOvt1FKEaUT6dSnJkbHYn9O66+F8eY7OR5JVzSSutUz+I
 tMadWAlW7hooI930SCjAeD2/C5rIMBNEZr4btSAvlFv+MGa820n6TMHCI2vKZ2cmai1Obx8Fn3O
 Vy06jOkUaYHEb2EuQcmaUtlceVVr2t2mVK/vpqImuP4aaUeS5WwPRz0jP5Es0GUMYyk2kErp56U
 lQBAyYVcGHDIkCyEuGizoyyp+qwhD5hRDVs8pbWHidcwYtfSUr9lcICtxAdqo0fCyuk/JY284lu
 wA/pUH7xEo4wGkMICt3hbEQ==
X-Received: by 2002:a05:620a:2a0a:b0:93c:61e0:81ff with SMTP id
 af79cd13be357-93f29b88632mr1364684985a.1.1792405875783; 
 Mon, 19 Oct 2026 03:31:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0a:b0:93c:61e0:81ff with SMTP id
 af79cd13be357-93f29b88632mr1364644685a.1.1792405870444; 
 Mon, 19 Oct 2026 03:31:10 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091fade41sm343284966b.82.2026.10.19.03.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 03:31:09 -0700 (PDT)
Message-ID: <5cfc6414-735d-4df3-868d-c8c3c4a98e30@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
 <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
 <52adff3a-370c-4445-9797-e0b0dde36fab@oss.qualcomm.com>
 <5568fd0f-e412-4f2a-9f1e-729a469da572@oss.qualcomm.com>
 <65f6883d-8ead-4c6e-80f5-81f6857df0b8@oss.qualcomm.com>
 <f624b075-df3b-4862-8231-8fcae7f18d50@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f624b075-df3b-4862-8231-8fcae7f18d50@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX4Oe/LVkilLLL
 DsYrkDlMIIDnM3l/ohLeGXfoggwxuniIJVxxQOg3dZ046ADxma3CyfXSNGSOXUUL/gIKcZGnoIK
 7HymduNsO0pEv4yZZnpBVigg3De68eKNL37sdfMn2OMTSEaeULqBiMzS6KHV5PVqUypRHPnV/tc
 w9JHKyyYnN9SmbTrGsVwBvI/DRBbP5CyA8ETxSjRBm4yFL3c+apiKsyYT3gsTH5z5U4zQRxyWuJ
 uWVZT5xxszRLk/lzyU2/kyoqe2aH40JU1bNmugIkcQfr5YBKoD5f7dPzgbVnUkKXPivcW0AjU6t
 dinrEhx5bvYxlxOitnd8xdMaXY9QPaEGnFOLvHT7EIwCLcqRYA7mTokXWbiOyrKlQ8D/FtRRKNn
 NniWVFlLCUsDuXFV9FCgcioo6/uVeYD18jUTmV5E6kFO30yolqDMAFMGFvVkkGQZM4wKq6gWLep
 5qaeN2OIPlHEqr+qqRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX4blmTVV1KPCU
 MTzFo5LbtHwupcQ2BMDFEiBTfK5lfFcMq5obX3xEAo8ZHkAiLoMlau8Fz1a0cuWujmqt5mUZpBW
 XDAEqxbRqzRT1wWi9w7yqakK65jllTQ=
X-Proofpoint-GUID: TWFBQ81CxHZDfYRABNODgyl7FTFKXk5O
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5f179 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=8k6WQxmsAAAA:8 a=-HwF9I-Zzcp5qfXbVEgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TWFBQ81CxHZDfYRABNODgyl7FTFKXk5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041
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

On 10/16/26 11:26 AM, Sibi Sankar wrote:
> 
> 
> On 15/10/2026 19:02, Konrad Dybcio wrote:
>> On 10/15/26 2:47 PM, Gopikrishna Garmidi wrote:
>>> Hi Konrad,
>>>
>>> On 10/13/2026 2:09 PM, Konrad Dybcio wrote:
>>>> On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
>>>>>
>>>>>
>>>>> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>>>>>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>>>>>
>>>>>> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
>>>>>> ---
>>
>> [...]
>>
>>
>>> Thanks for checking. The only matches I see are in the MPTF thermal
>>> package, which ships"883ROT13Inch.bin" and "883ROT15Inch.bin". Nothing
>>> else mentions ROT.
>>>
>>> I also checked all the ACPI tables but didn't find a codename there.
>>> The tables are here:
>>>
>>>    https://github.com/aarch64-laptops/build/pull/176
>>>
>>> Following the Lenovo gen8 naming, would something like
>>> "microsoft,surface-laptop-gen8-13p8in"
>>> (mahua-microsoft-surface-laptop-gen8-13p8in.dts) work? I'm open to
>>> whatever you and Krzysztof prefer.
>>
>> FWIW the "gen" naming comes directly from Lenovo's product name,
>> i.e. if you go on lenovo.com it says "ThinkPad T14s Gen 7".
> 
> Official Documentation say "Surface Laptop, 13.8 inch (8th Edition)"
> 
> We have to create a dedicated board file for the fifteen inch variant
> since it is expected to have a sd-card port and another one for 13inch
> specifically to enable ufs. All of them will have only lcd panels. So
> how about if we go with the following?
> 
> microsoft,surface-laptop-8-lcd13
> microsoft,surface-laptop-8-lcd13p8
> microsoft,surface-laptop-8-lcd15

sgtm

> With this is mind it might make sense to create a common
> file mahua-microsoft-surface-laptop-8.dtsi that all these
> boards can import from as well.

If they're sufficiently similar, sure thing

Konrad
