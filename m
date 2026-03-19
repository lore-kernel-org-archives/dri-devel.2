Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9E71075289
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F7110E892;
	Thu, 19 Mar 2026 09:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HP4eVMtV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="faBZQszj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CDD10E892
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:39:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J745SF2666596
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bZQ1JZfZf0V3b2o9DsRkzjevaQcj+BM7BVANfXVI76Q=; b=HP4eVMtVTbOXWsW+
 nppDM8gMWfMyYCFG790YVY/aoyqToC0nn/4cqmpT1zlrOskNWyVYJMxfWBT97P2+
 6Q8X2GxNGWdzfHmaTdYZruseS9jlv0AkzcbUkxgAAokTrfxhL2gZpMuJqD31lnxl
 dbashY0pDeWFkJIEa7fWm3XKbuY0qdc++xecn1XEwI3LGdcJe3fuv/CazC/H4vPc
 m+cBp2JGk4lVNt93adVBt1tNl+nhXmopwyHo/lmSI36dYppfQ4xhI0+zSC65H+Me
 HdCmPc+LP6qBcS9zj8JUGyqODRZ1uZaFtZU/1Uz94lNpVK90jdbTNjtg3AkHFmAq
 nULnfg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytj546kw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:39:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c49436edeso7727026d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773913170; x=1774517970;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZQ1JZfZf0V3b2o9DsRkzjevaQcj+BM7BVANfXVI76Q=;
 b=faBZQszjjVlIHQFtBy63eN9yW09u8N9rgf/nbirCzh/Hlr9ecx48cDA6JgR6EQLi0O
 bJwzh8l9rbJ2ROFl5aTE9sjYA6MYJcbG2yg4XrwVW6UdM8/JPWsRSmpiqO6kBzJTvg5M
 1dOIdQbeisWBZow2eDITR069CNwDgYeq2Dhmyu60qqGLDKdGoKlhgbK1xPUSkeEMIar6
 kmlUUZUBof+I0ZqqygGQMM/VNhQrJckdaZ8szE9aMpeTTYLoHN+5iewTtqTwAbJW6wrA
 igUwuUua8FS1/tw0AH+HQRyIT/45KXUn212JKS9SNp3pfvQ5msn1dopO9t29zpktcDZE
 dg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913170; x=1774517970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZQ1JZfZf0V3b2o9DsRkzjevaQcj+BM7BVANfXVI76Q=;
 b=s0JsFYyKhymBBqsYaBstn/1W+7GEr7WELng+1dnjaxWHq6x4BFQLoP1lYpydoBfw66
 MPD51LfJQ2zLjjbw4JjhZ+ptXn56T0yvqS/uEIRbECg0IKVCQbeE+JkNyUr/1kdoS484
 ff3HzujaXDRPQ8ojhrR1YN1Fux+YcSawOq6tZAei6Y2tBpzVh6tRO/LS8XGvyse1Cr/J
 tGyKW0mRBd0vlZXwkAewiedof3f0IDy+sq9zUR8SXrtWU0Q+OfV2459nQ/OIqFRiOjv3
 kGZWbKvjHKAv4dlQJBflOj6EOyDm7yD+iOfFfGsXqkAdz1CNkqvg74Rka0LvnaHoOTlJ
 C0Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMmvWlY/rL6K8OhmbHEmI370UsK7AOOcJIAxtjfKYRPTJhrY4ZosiNCuLtW5qC5yNYcMf7aip6z6s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaMSGDnBLvg5dCFyK4aauRecXJSkjL9VRc3x+6lnL1pi8FN951
 RIFiO/sxDuCAvtx/2NwGzBwrPcZ3M9gTf0sL4JDSM9iNXtKsSVYLbwns4VrKDTPZoKK5FKW319Y
 Mdmpa54AOxMyYl/KtrVOU9u/l5DwhLZe+wJBxHMiht4de2o6jhBCjQz1I0p58cPQpPhGpkro=
X-Gm-Gg: ATEYQzwtmFFi87P6/U/Gltx1PQ2p4lZt9qnMD2rIFjaBNkSgmtdtxpMeLY+bTK0poV5
 Csj8/trQWb+lfvljCX2iQFl+qnKfdcf59pVsy6ZqDK1rzWISKsA9XJBFzX5pYMkp17UumJJ6N2D
 fPCG0Yh0jZ1zHLYTfpohy+eBfHhwcE1hE18BpIh+EI34YTbBpPIeW8uJST9S6+ulCMSS7H0cjna
 StFdGv2OyY6/bevNak9eU8/FTPFoet4wqQlpFKS7f82HqGYg9md3/MOQCtKkdNpGUTaVlMG2pGg
 bG26ku1E3pkwbtwOSidIBryWyaxTMgms+QCr6yOtBIfqoHm+Mbqbrsih+MRJF/GzLCCUXWvs6QJ
 2ZInwMZWGZlbdZCHtxWkezUKd1eQ0LSNvEuHHr3KkzqJDOsRPi0p81VAV6nl25A2/6SbiIx0uLl
 LPS8M=
X-Received: by 2002:a05:6214:411a:b0:89c:51d0:20df with SMTP id
 6a1803df08f44-89c6b5bfd2cmr73428386d6.3.1773913169753; 
 Thu, 19 Mar 2026 02:39:29 -0700 (PDT)
X-Received: by 2002:a05:6214:411a:b0:89c:51d0:20df with SMTP id
 6a1803df08f44-89c6b5bfd2cmr73428036d6.3.1773913169232; 
 Thu, 19 Mar 2026 02:39:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f13e989bsm429275366b.11.2026.03.19.02.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 02:39:28 -0700 (PDT)
Message-ID: <7d31ca0e-063c-4cae-be82-41f5f80238a6@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 10:39:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/msm/dsi: Add support for RGB101010 pixel format
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-2-698b7612eaeb@pm.me>
 <5b79ccbd-5c75-454b-8b3f-812a6c59157b@oss.qualcomm.com>
 <pGJabrbuMx_tCkcjrvUESbgwgvwGXDQYJ3czHFEWSDDVv8ugukIWOchF7uV8D1Ns1WI4O9OKDBeKdOW4I83uD7ZfwX58k0EpxHwVVgcnSIU=@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <pGJabrbuMx_tCkcjrvUESbgwgvwGXDQYJ3czHFEWSDDVv8ugukIWOchF7uV8D1Ns1WI4O9OKDBeKdOW4I83uD7ZfwX58k0EpxHwVVgcnSIU=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX9+R4+pUqiWET
 4g81iEN0Ch3pLkzwDmQM8NQ160nNU9bnkbvUi0+Ggt/0L17dE1p+YZF+pYKoPY8ELbEf0oFYceu
 pEUYcqUnlalgkfHvwlMZV3V/x039nFsJRGo9l2a9zp6pA6f2WV6Y/oejD3KmTWJdVqAGCswqqs3
 HgdSAwFUTsAJEO1Ga9EZue780uHIYq32eiwq076k9GSnyRIlLEXNyT7AugvcJcLSTZqi3AsdTFE
 obNUndtAD/126pWBRuN77t4JmBH9lHH9iqh9Bf5yBVUBd4UcqhNvgnYtQRO9EN1ub8mHP+uI9iv
 bmWmAmxbbIeDTukUrtyXJ/asiCdlA76SGq5p+Nhfdt4djOLzUi6c6HdHCsW4xutTkQMBVtUXnEE
 cXvIwDyu+yg270P6LHIPaLBU38A6hngQOTaeAdG7Ejn/t/yX/LnF2wAZmsxvoQjXQfSgo4LKbj3
 9rEzFohRmUDDkgF7yhw==
X-Proofpoint-ORIG-GUID: 9PeKfIHk4ys2jcKRxSqM7q50BIwjSf68
X-Proofpoint-GUID: 9PeKfIHk4ys2jcKRxSqM7q50BIwjSf68
X-Authority-Analysis: v=2.4 cv=dM+rWeZb c=1 sm=1 tr=0 ts=69bbc452 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tXHaASYRl17ePNmWAmoA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190076
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

On 3/19/26 10:25 AM, Alexander Koskovich wrote:
> On Thursday, March 19th, 2026 at 5:10 AM, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
>> On 3/19/26 5:00 AM, Alexander Koskovich wrote:
>>> Add video and command mode destination format mappings for RGB101010,
>>> and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
>>> the new format value.
>>>
>>> Make sure this is guarded behind MSM_DSI_6G_VER >= V2.1.0 as anything
>>> older does not support this.
>>>
>>> Required for 10 bit panels such as the BOE BF068MWM-TD0.
>>>
>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>> ---
>>>  drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 8 ++++++++
>>>  drivers/gpu/drm/msm/dsi/dsi_cfg.h             | 1 +
>>>  drivers/gpu/drm/msm/dsi/dsi_host.c            | 9 +++++++++
>>>  drivers/gpu/drm/msm/registers/display/dsi.xml | 5 ++++-
>>>  4 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>>> index bd3c51c350e7..6a7ea2183a3b 100644
>>> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>>> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>>> @@ -133,6 +133,7 @@ static const struct msm_dsi_config msm8998_dsi_cfg = {
>>>  	.io_start = {
>>>  		{ 0xc994000, 0xc996000 },
>>>  	},
>>> +	.has_rgb30 = true,
>>
>> I wrote a patch to determine this at runtime, and only after I was done, I
>> noticed that we can already achieve this:
>>
>> bool msm_dsi_host_is_wide_bus_enabled(struct mipi_dsi_host *host)
>> {
>> 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>>
>> 	return msm_host->dsc &&
>> 		(msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
>> 		 msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_5_0);
>> }
>>
>> let's perhaps extract this to a msm_dsi_host_version_is_gt(u32 major, u32 minor)
>> or similar
> 
> That's what I was looking into initially, but V2_2_0 (0x20000000) is numerically less than V2_1_0 (0x20010000) so didn't think I could do that.

It should be v2.0.0 (0x2(zeroes))

v2.2.0 -> sdm845v1 (unreleased)
v2.2.1 -> sdm670 and sdm845v2

Konrad
