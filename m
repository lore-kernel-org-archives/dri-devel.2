Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A200C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724B410E144;
	Wed, 19 Aug 2026 14:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S7ymNLZY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVoel4by";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0DC10E142
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:40:33 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbd003816395
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YkxApuLR3nH6kHIS/ueeOQIr419fLolFuozcNnUKvXQ=; b=S7ymNLZYY1/ADDbu
 DH1VqoRhEtAuiPXPnGap1L8y7UZ4hNSCxy0yrjSdt0lfRH6bp1r0J1iNK3jti8ta
 uybb6fahSH40TJPtEdI8es8KsaQ5LDJxvckfbdKJPgQ5uYpO2mzLCP3Wjd1FW/9X
 PjulT2/FLQNAmu04Qw5HG6GWZY2h4+z4QqFFwXXY1T3nMtOKrpQBAUEFToMQcCFr
 uaFItHQPYCL2LWwRAORDp0zVhtNvoige3dFKwpfYN4SqGHQDI93vg0TmLHkc/dtc
 PTdS2SHBqkGzhTbxuUJBwa3mI3K35BiuLyUt1D0w/9dNa/aU97TleiLidS6sDuGT
 PNkNeQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm3r63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:40:32 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ef4a54f86fso1733786d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787150432; x=1787755232;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YkxApuLR3nH6kHIS/ueeOQIr419fLolFuozcNnUKvXQ=;
 b=gVoel4byPvwooNODhPlUTOlI9etNdT0RMqXLtO6tLHmiFV6nBEFB2kgLJiE8x2pS06
 UB/AthuT/+rpjMZViX8r9p+uLK1yCxg7QYOTCuPmKe65z1JrfEXiGknS0fSMW54PxHh2
 YwNt0tW4sSoQc5OuV8BGLy818hwUTNnpFsfZlw4vTZWh10YqSXk0g0LaVPGm2oWKnrZ5
 7saBj/aER+Jxe3S7MnzkBr3EzYnlnNMGlzmlX2rhrvQGgrozeXkc0MW03UySMb0lzYzP
 qzTzVmfEaH1SWKbPyh6HGxxSFlHrdlJuQPnWIDS7RMCz6Qj3GNiB9ouPMBTHSP2rnw5M
 vZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150432; x=1787755232;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YkxApuLR3nH6kHIS/ueeOQIr419fLolFuozcNnUKvXQ=;
 b=ZQFrgh/e+wBgPaevbwdbbWmzOMy6NJ08r3/01p8XhpzJ5M5139hOQAN9fWGAbgPMIT
 aQa+5TLPT5rBMIHP/uh8nhDDXpgdPqN9Dv2TNEmLvj3ia3aVDn3uzZBP6RzCmXqB7TQJ
 D/dZtZmqGTGSYHBtx3bRV99Zj+jURVptESAWbEwDzDwtcg3tlYAKGkKCSOBHQQ7GXcnB
 JQ4avb1E5S8duLjZz0a27ah6J++BuJjKk4hVw6pqZXYexY/e2QZJPTPac0qRQY8Bc33f
 1cNjXloxSKvjFGMcSxEMscr7W8fM4ZuDxdBBZjQKfZpJJ+dKcFo1bRrOxM5y0yIJhXQP
 Dypw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2FOUNVRC08JpJktvMPc1G2uF9ZIgoml2aJbe23MpQDf2GihJs/9XDHmQwkECqurFpVWrFGQrobR4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYxFFtVejSDOjQeEjj+GnXHpS22zRKdsJhXHH7e9Ipyewp4MgK
 uiUeQE+DcWcU1kknpyYQ8EgHstlB5tSyMYP8wN+ApI9ReBcrCtNNjQlYQjtffIH4R6DJLXkuCuz
 QhPzkmtsFKvrTGwBuoyHKUHPqtyySq5bFnRrRpt2UuI52NL2qHo0a9zoND44HixxE6lOnjik=
X-Gm-Gg: AR+sD11RDcmcOMDKHg5FDXVZBNd8zRvEaMmclvmeKj1jUfMnDAMqqvdVJCJnxo0jDRl
 GKnp8QELyFuFnRsbbSfkxa1QAT/y1/co0nCoO3JYpie3+4hLARkSe8MysGnRGoKV6MPVw9M6/DX
 kt+W8lQl1UeboTHef36lSDvdS5rNMXgPkjhxfw0b4looKlJITXDtzTHm1btz3ZgvZE7Fbtp75rk
 TezorIJpreDpUgEDa+44XGalc4ZPknViIYLPY1DH27ByCKpcoPIvtgHGwvd6GHylZy4fAAyBf0f
 MguT9P0gVoN6oiVLwIXlUfDf5pD+F1tfBfkArwV4N+YKK6tuUQxCiRG3yc4oIxDMMnuEaAx7ztx
 BibfJgglClf7yvEaQMJlAX/9p
X-Received: by 2002:a05:622a:2cd:b0:52d:9a83:4187 with SMTP id
 d75a77b69052e-52dd4dcf390mr38628271cf.0.1787150431711; 
 Wed, 19 Aug 2026 07:40:31 -0700 (PDT)
X-Received: by 2002:a05:622a:2cd:b0:52d:9a83:4187 with SMTP id
 d75a77b69052e-52dd4dcf390mr38627581cf.0.1787150431215; 
 Wed, 19 Aug 2026 07:40:31 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c243c38b029sm86575866b.47.2026.08.19.07.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 07:40:30 -0700 (PDT)
Message-ID: <bfb68688-aad7-4eb2-8981-4a4d1f116ce1@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 16:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
 <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4GqlbT-X7YAolQJV4ogLPd1IrQcNZEhh
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a85c060 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DxY1U69r6NhVaGGOtf0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 4GqlbT-X7YAolQJV4ogLPd1IrQcNZEhh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfX9h+/Iv/Tt3UR
 8J7dac5qXdxHl/xnnGV1RCS5NB8Q6V/IU5O3OFLSidXf5IwsNqBmBePfxFs6F6jl/FivD+uHoYU
 AFB1EvsMyKxhtJZZMUQwzVtC01fHt3VTZXcfTvfQjzgHG0M0oekkikyfpfABnwZFjMkq4cpAnWL
 h+OLYzMzcnsq+irMb0/5xr2FjMTB8KMtap6uZhB6CFjL+7Zr9wzhvAwgOFeL7hyvdA7Pzz/Q6fV
 BfI8dTu8mPv8k8bKKlsJFt/1JXEOKqqilr2aGO4LyxqnXLJystqPpI206clyIZo+4tqu9XyQW5e
 cJ0GEdPfKZ7PYuFsSALGJogR7z7btzCgAM+I2WY8PLUq4IfFVvPaBYwhlRrPAXP1rV5BcWBwizu
 Jw1C5YIeJfVVKmLPPOcUH4FeNfkaH3VoUtOgsfvB6OPKjW4TYAdsZTiDYm0hn8ztnHUNVKxjqKI
 JyYLp0qpGU45PlQBT5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNCBTYWx0ZWRfX5HTatQNy1eQO
 Rr8YFYzOC1h2OWu9VJKCtSLFjhHu6V7Ap6stNObArg4Py0yG8dWX6xOmjYWGN8cBT+J9qBiOHVW
 ohJK4swpkLAoLEgpfL+y0gjWIUjfYsc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190114
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

On 8/19/26 4:38 PM, Rob Clark wrote:
> On Wed, Aug 19, 2026 at 7:21 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 19/08/2026 15:26, Ekansh Gupta wrote:
>>> On 19-08-2026 00:43, Krzysztof Kozlowski wrote:
>>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
>>>>> This patch series introduces the Qualcomm DSP Accelerator (QDA) driver,
>>>>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provides a
>>>>> standardized interface for offloading computational tasks to DSPs found
>>>>> on Qualcomm SoCs, supporting all DSP domains.
>>>>>
>>>>> The QDA driver implements the FastRPC protocol over the DRM accel
>>>>> subsystem. It uses the same device-tree node structure as the existing
>>>>> fastrpc driver in drivers/misc/. The approach for binding the QDA driver
>>>>> to device-tree nodes while coexisting with the fastrpc driver is an open
>>>>> item described below.
>>>>
>>>> No. Grow/replace/improve existing driver instead of coming with a duplicate.
>>>>
>>>> That's a standard upstream requirement, basically given on every
>>>> upstreaming guide.
>>>>
>>>> Please watch old talk from Greg - "I Don’t Want Your Code!".
>>> Posted discussion threads here[1]. Would seek comments from Dmitry,
>>> Srini as well.
>>>
>>> [1]
>>> https://lore.kernel.org/all/3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com/
>>
>> The rest of the comments is still valid even if you did not acknowledge
>> them.
>>
>> Anyway, regarding above - again, watch the talk from Greg.
>>
>> You have ONE driver. Not two.
> 
> Long term, moving to the common driver framework (which did not exist
> when fastrpc was first created) seems like a good thing.  But does
> that not allow for some transition period?  How can we get from here
> to there without otherwise breaking userspace?  Is there some other
> precedent elsewhere in other driver subsystems?
> 
> I suppose drm exposing legacy fbdev on top of drm drivers is _sort of_
> a precedent if you squint a bit?  I'm not really familiar enough to
> say if that would be reasonable/possible in this case.

Also, venus/iris, mdp5/dpu1

Konrad
