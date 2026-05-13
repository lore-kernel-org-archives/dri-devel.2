Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB9FCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DBA10EF58;
	Wed, 13 May 2026 16:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pToALUVB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EgZiBplW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DB410E34B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:14:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGAwcM2524398
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RPWFEMF9L9ig+cq3Ah630zwHNnboGXlXmuygk2CCVVc=; b=pToALUVBz+0hc9T1
 B87a27PKliXyoeuOoHRmSLfHjBLET2HL2UI7f9XCVv+FJlIC4pe74n0LdNvsPjRc
 cP0icMfLLMTwijRlBDAqFD2Win0A/GRljrln9ca9lPH4n/XZ+fN5bbODJ0+3fbcq
 ymuWeApdiDDIYSDdUp2rXb2hEbFuyXgZiW00nl2zNP6HrxainKPVLDR6YJ0NQo5s
 D7nhmX8iUSZl1ostkdtT5S3TkfW2Wh++Rk/gRHGFas0dOmPMCmZWw/TJ73WLT4mr
 6OKKRvwo1ulVhzUMYNTPgQHG+DoOXySvpEjPNC95BpAeBlicIyzsX6fVTloi6Unm
 eLel6w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjg0kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:14:48 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95f8863e500so2160674241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778688888; x=1779293688;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPWFEMF9L9ig+cq3Ah630zwHNnboGXlXmuygk2CCVVc=;
 b=EgZiBplWIP2IAI+iXJ6YZZQ3FIOy5vDIS9R6oQOIUJGMRaCsTk7GvHfxR8FyPkOTkQ
 o1RETwqfVFiWl5DyMMVIV7yiUshjX9puVKknUlPuvpzocNH0Uel7Gptudd5M3dG1HyxG
 X7EBn15hK7FqX6joHgXPEYYI8T8Zn+gJWy2ee/Sw0HqJXT/TLo2DU9yI1NTahoH3N8Ku
 PvuHIU+UM8UCJU691e0Jbz1WlW4F2SVuvduRJ0D56PtejsplyigZLZ8vyi43LcYtyHdS
 QxtqQtV7uQiU9MqDCdme+p7SYn8aRiOCs0SEYPfXFo+chfKeeZ4UDLRlzuQUl9uqPrch
 xQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778688888; x=1779293688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPWFEMF9L9ig+cq3Ah630zwHNnboGXlXmuygk2CCVVc=;
 b=ofcGWLhzsD7La8wBiG61pTw2UFc78JAVQ6ytSaMCWGheWepD0wGXbcAHj5jtc3vlJ/
 6TqiABya6qrpKdGnVSMHVgQedDaVatc8o6J2NV/C20dlHe8YQbp8tUF6l8KoE9M8kXH4
 SUlvvEJcG4r66D1HiK6QSChlAFXCB4XtHFbNvOQc2NTIYvii1ILGE9OsonnmoS45soPS
 xZ9ewDu4X2p7ojMnBY8o3FEvuWnpOsXokmTlHji5BRSxeQPB4DJPNyEeKxsLvc/IAElF
 gloRwy6zSobuZjjy2IM/2oDxjh6NOpBcmjLmIii6sSTw670U+RQvoVYDhpWk2b6S/8RZ
 cJDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FA6KKpSdi1GGq7IM2dsurplDl9c0/S904Tocf/0+TmIqC8eqaTc2R/hiVkEsi33cmJi1ZV8my1hU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyacuB+hQc3oQ5n/Ektm2n3SZyPaK7+ysgZVWv3Y5LR0pz+1R/D
 GkPgvKPlrS/r2xWk/WpmTvqB95pEdfiUfoRyZpn5d6RpSAKw6GJHUzFWEU/vgdqT/5EHdNgAI8D
 JmTvfdKZhv/LE66ExLD7t+6RsWUKPu8qwLmBQFKi+l8k1ixQKPNnglAgseSQIZIKFOgx/ab0=
X-Gm-Gg: Acq92OGVDGDgUHmZj0UIep3EbmOLmDOjcR9IWZhg8De/VzIlPrEF7OMPJfAUMJpW6+B
 TOU8/YMESj3UEOzc+xHydU46GJgSShEn0KpIasjtZTLxfCard92RAeoZnNtATnUH8OsawEISQkS
 4W3W8uOMEgze0HwVPXOWDB8Gto5qi0fa94aD/zR5db3+rGDbtV1K8edOopq44WOXRtePfCCguyN
 BiEz90FLUEo+V4feOHVRNcoZRt4kSiPtxs9E7F4a36ofEOIpHyQDe8xRzRU0+MExLYRbRv4SMfA
 MPYHE9tdRQxqChI3qcBGK1tCX7vIwJl+VX3+nSvfbLWn1rFNLJDE3Mu8c6mZb2tK52hyxXy3Zq7
 +e9ht45WEdVop/rGItLB9TrNuuYXMWVeC2aHS5caVvysYYIdLNmRe0prdGW1IlCVtYpeVBMY5Ak
 FZYcANwSKy7itbMpSOB9ie92lT4Yd0YqLf2Rh77b0smVDW6aI39rs6aYDEyyE1nQ==
X-Received: by 2002:a05:6102:5e89:b0:631:26f6:7022 with SMTP id
 ada2fe7eead31-637a96e4aabmr2271252137.23.1778688887553; 
 Wed, 13 May 2026 09:14:47 -0700 (PDT)
X-Received: by 2002:a05:6102:5e89:b0:631:26f6:7022 with SMTP id
 ada2fe7eead31-637a96e4aabmr2271183137.23.1778688887084; 
 Wed, 13 May 2026 09:14:47 -0700 (PDT)
Received: from ?IPV6:2001:99a:252:3300:d706:9b57:5996:15b4?
 (n2i9bzmlzk2z87merp0-1.v6.elisa-laajakaista.fi.
 [2001:99a:252:3300:d706:9b57:5996:15b4])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f625bd3bsm42816281fa.34.2026.05.13.09.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 09:14:46 -0700 (PDT)
Message-ID: <553c16d9-26f9-4702-9214-02e44502af58@oss.qualcomm.com>
Date: Wed, 13 May 2026 19:14:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Marek Vasut <marex@nabladev.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
 <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
 <af71183d-70b8-4a41-8466-67123e7aab02@ideasonboard.com>
 <20260423-kickass-fat-boa-209f68@houat>
 <72c2cd94-0a8b-46c8-981b-4ad4a3222e59@ideasonboard.com>
 <CAO9ioeVX6OChRTgUrUdgrPF+3s2_7vme7m0yb85pjYtH1MFskw@mail.gmail.com>
 <ced05a92-06b4-4f6f-95b6-c3dc104c35f3@ideasonboard.com>
 <b24c428f-5752-4544-a8b4-77e91d7bc158@ideasonboard.com>
 <da6bdb78-7fe8-4f51-b9e6-444748ebc319@nabladev.com>
 <103f94d0-2599-497d-ae37-d88922b9f669@ideasonboard.com>
 <faa20bc8-02d8-4715-a65d-2d8aa4102296@ideasonboard.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <faa20bc8-02d8-4715-a65d-2d8aa4102296@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l2PPqlcRd0a732_Dj1DFwjaJRNkfS-Ut
X-Proofpoint-ORIG-GUID: l2PPqlcRd0a732_Dj1DFwjaJRNkfS-Ut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2NSBTYWx0ZWRfX6ZhbD6N1V44T
 cSZvbzdXtE43b6vVJ7OxeHCGzZUOreIoXYM/kv2oMr9fA5xPyt3M+v+RDZSxNAWJ9rGCFjAAYIh
 z935rEVs+14mo5Fq040ABgf1mUBbM5Rk6vPGGF4wkETzfhkhIXiROmloTs+8wkyt3B1dz9eA/E3
 k2sAk8nl55jCFavUH1Bh1Ui1KO67NdLX7GbrQH8lDYKAabWYnyMVdkiZGE1VC1BulibH+p6FTlG
 E+YtTEZqoH22gWGgnB101QXtw3+MyW7cZs6e81g2v8cYMq7wpGw9vWBGJ7460g81O7pVtTAzGGl
 kE1jhmgtd22e4wDncVA/CjEVdfCYXQRwM7LgB3Orl3nzOxyOy/uZIrZk75jpGWZxK3b8ksooWXa
 ptH2EjVZ5y+UFg6QGWu7u5pc3wmYI/Gy2MJ8VBkFjC6UmbINVBQ37KSde5a3EzNhAd+qFpCqadv
 tFTJjHsEBq12+EXRStA==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04a378 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=RF00TdSWAAAA:8
 a=lLZmtIKjAAAA:8 a=P1BnusSwAAAA:8 a=YvoeO6lhbD8J2Jc-U_EA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=_nx8FpPT0le-2JWwMI5O:22 a=q5Nj8NTjyn2D8kUwajRn:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130165
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

On 13/05/2026 14:52, Tomi Valkeinen wrote:
> Hi,
> 
> On 23/04/2026 18:01, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 23/04/2026 16:54, Marek Vasut wrote:
>>> On 4/23/26 3:16 PM, Tomi Valkeinen wrote:
>>>
>>> Hello Tomi,
>>>
>>>>>> In the past I used this panel compat instead of the
>>>>>> panel-raspberrypi-touchscreen.c and it worked.
>>>>>> IIRC Marek splitted the multi-function module into a regulator and 
>>>>>> the
>>>>>> panel description.
>>>>> Ok... Indeed https://pip.raspberrypi.com/categories/651-pcn lists 
>>>>> PH800480T013 as one of the panels used. Although two variants are 
>>>>> listed, and also a third panel model, possibly from another vendor.
>>>>>
>>>>> My module is v1.1, and I think it has the PH800480T013-IAC21 
>>>>> D/5624/ KIT- LC variant.
>>>> A question to Marek: Where did you get the timings for PH800480T013? 
>>>> Did you find a datasheet?
>>> Search engine first link:
>>>
>>> https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5337/ 
>>> PH800480T013-IHC09.pdf
>>
>> I tested the "powertip,ph800480t013-idf02". I'm using BeagleY-AI here, 
>> and it didn't work at all. After some testing, I figured out these:
>>
>> HSW of 2 is much too small. But this could be an issue on the display 
>> controller or the DSI encoder side. HWS of around 8 starts to work ok. 
>> Below that, I don't get anything on the screen.
>>
>> The syncs are interesting. I set them to DISPLAY_FLAGS_VSYNC_HIGH | 
>> DISPLAY_FLAGS_HSYNC_HIGH, Marek to DRM_MODE_FLAG_NVSYNC | 
>> DRM_MODE_FLAG_NHSYNC. But I have sent the TC358762 series, which fixes 
>> the syncs that the bridge sends (20260327-tc358762-fixes- 
>> v2-0-3589d3c45f4a@ideasonboard.com).
>>
>> Flipping the syncs might explain why I used 46 and 23 as the 
>> backporches, Marked used 46-hsw and 23-vsw for backporches (well, 
>> Marek's vbp was off by one as I mentioned).
>>
>> But now I'm getting unsure if my TC358762 fixed the syncs correctly... 
>> I'm pretty sure I measured those with my scope, though.
> I did some digging.
> 
> The upstream TC358762 syncs are wrong, and inverse what they're supposed 
> to be. The upstream powertip,ph800480t013-idf02 timings are such that 
> the image still gets centered correctly, even with the wrong syncs, but 
> this makes the timings not match the datasheet.
> 
> With my TC358762 series, the syncs on the parallel bus are correct, and 
> thus powertip,ph800480t013-idf02 no longer works right. My 
> raspberrypi,7inch-dsi panel timings work right with the TC358762 series, 
> but those panel timings have the sync polarities wrong, and thus the 
> timings are also not according to the datasheet.
> 
> So: we can drop this series. I'll fix the timings for 
> powertip,ph800480t013-idf02, and then it'll work with the RaspberryPi 7" 
> DSI display module...

Ack, thanks for your updates.

-- 
With best wishes
Dmitry
