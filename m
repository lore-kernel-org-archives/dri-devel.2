Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F4BC5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A3710E159;
	Thu, 20 Aug 2026 08:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y7ZUdcHp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKRLZAPg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE0810E159
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:10:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K66jqB1354362
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0WWp2wT5qOSsyYpU/bw4CDXmY45ymLIZfTRAZ0vxfec=; b=Y7ZUdcHpf5vnWV3z
 qEjTgFdhF8uw2yuMbZ/5a7TZok8vkv91kc0e5RnrsisQWYVpROtDNHm0xBPirtln
 rVy7lPsL4fWurnCouPfAxuUjy3ZDHVXU2O3fzkJkK8o/AEdHmJuOfWAl7wroK7Ql
 a3poY4x3ksH0L14kEgzJQKYXr+4p44rjplTE3+z1ZH7p8duXWwTgA5+KwmK0+L1a
 a3FJqQDdFFbi/rlV2pMxcsJw5pXKlZL5bRcxaN2eHtZ8X0nLu3bdo81Ev3OgOIqC
 KX3uOaehov/vvss0vVX/Ln7mvIk8cgioQBwrIH9F2Q0gQjtPU0u3I5ngm6vTTaKd
 FR28Bg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es5bvqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:10:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so254069185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787213444; x=1787818244;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0WWp2wT5qOSsyYpU/bw4CDXmY45ymLIZfTRAZ0vxfec=;
 b=PKRLZAPgM355UJqp3LX/gzFXEZuPvAcYYM7eG0fisuo4fCrAWputS9z8lUO4WJAAt4
 +i4MdSXbImWc1GC6ASrI4CYObWR1iW1E0/k4y1xMS2R9hT5m3Nl6F+z0w4pyNubTjeDa
 jfgXXgHDpnemO7TXJXcg/VB5LXjDF/1+8rDFP07/1OgHBUI35k3vbM9vCs/Kocsr9OOl
 DNS14oJSFHYVpSgG/lNEnymW5ka2G/XxiOiRdIlKflo1agmN4EkbAhlJe9QIRW/hxuWN
 BwNeg6l6PTxt6aaw6H7fGCcE9Rxe52705GfX4BuOuFJA79m21TnyIUfrJCcbIijqlfiE
 ++UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787213444; x=1787818244;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0WWp2wT5qOSsyYpU/bw4CDXmY45ymLIZfTRAZ0vxfec=;
 b=tJfEplbf1Fx71G0V/ney+hgx/1MhGFHRhqe8tup4g6wSg/XGcrd+c8g4wvCAuyuaNz
 I+tlrRB8ijZ7nLZTa3vwUFudX7+JVyIwlJfyznRIORgP6/7vGYT37sXt9WId4IgZtgPK
 ZQVWnOVufWuq2DYQXpUjkgyrJuqiWV/jcEhfIpvuP3W0+yEp56olINfv2AMAjA2ZloYg
 qXwPGyOi+CCWitJ5pFKx1lV3PEkZSQx9GxNu5pYJA/lWGtNL/v+tuiacdFRVl1KWk4Kx
 12oblRgwcdaOlaWWhvSq4wme/+fMkeNG5C9o/wbm18H884SoUAjRTdf+r/Y1gGmHlNlF
 mHtg==
X-Gm-Message-State: AOJu0YxnSi3yPhyfivQtRwk8EAeiMOi5BR63ZGddxGrXik4jnb+au2N2
 rFU2pAc9DPIiVlEFMrfMP2kHgHCucfrTtkJCUr0vowxlAW09cEaWCjgvTDsAKbBVII17BNJ6A15
 bNXdC3j6oPDv85L9yVGrj4loTybeLt17MioZ+4pGOg00ZbsWR8PGXVi56nTudWS/DjWFIWsQ=
X-Gm-Gg: AR+sD11XXguoBVU5kkL1O/w2arFAFZwReZoJJ55yVFIDE1mRbB7Mr16C7/nTrVV52uE
 fiR2ZcJw0A6SHzsrhRB7ryUkfErbj6qMmT66jdDLGd5sLTFh+FquBYUnRug3vrTbFQnQFPHkaYb
 k11JffVpSjFjsdwOtpo70qqGnI0l+/ggbQrDmXAY7h9R4wNYmmTPLFu64gjdmQEUWTDb0xiFLQH
 HYnmziAenF5pbaqjzA69MjCwFLHQm32eoOV7DbMZOwYA1MoO0al24vSf3PjG/tej61g5DhKsQtk
 sJaphJK7Q4fOyNHfUbTDhXh+DEYRwpfkv8UrC9Ke89IIQpaYT/tc9pvt7TRO9h+zqcRCFKnsFO6
 OT87oMFsNXp+pSwnm3MXlvrfHj8JylI/Ruvi49v9StjzAWzWViBAgqjC96hgZUCeRoG8g4eGdpA
 GfmnRNi70nFziC0Wsen2+k0RVkMStJWuUFpsMHlFqAGWJqGqkX9ipK6EyDyByp5gGNoXs=
X-Received: by 2002:a05:620a:bd4:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-9371e6ee8cdmr959799585a.36.1787213444345; 
 Thu, 20 Aug 2026 01:10:44 -0700 (PDT)
X-Received: by 2002:a05:620a:bd4:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-9371e6ee8cdmr959796185a.36.1787213443877; 
 Thu, 20 Aug 2026 01:10:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591989ecsm38276166b.38.2026.08.20.01.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 01:10:42 -0700 (PDT)
Message-ID: <e19bd55d-74fb-4c81-9beb-c37271f677fb@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add FHD version of Acer
 One S1003
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
References: <20260713203828.383404-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260713203828.383404-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z_JPsamnH6mXQ5D8T2xUmWqaxVUZ0qjI
X-Proofpoint-GUID: Z_JPsamnH6mXQ5D8T2xUmWqaxVUZ0qjI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1OCBTYWx0ZWRfX2RU+ZsM9JZ6V
 dWWJ8kYdS0QNfdZRmnj7mvc3Nz6RihX0oJaKA63VHuFuCvD38HnhOa/ZxY7sh3/HpIC3HtIo+GB
 DjMflpFiObnjLh/SBdZL3uK/7qd55Ek=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1OCBTYWx0ZWRfX2KXVxgd4bGlJ
 TuQVD+R6miyHm1botMAe4JUPQ59Z8cckALvHL7Ri9gB0E3gG09EAuAA3UDfegBweIAo0iEECXHY
 92x1uxWGwZSdfw+EtMdllDkM/hwA7/RE6YPaH1FzrpTW13ZhWj7Mjqp0GiqSJ4ao1iA3bh/zT16
 8v/kbf04c0jS5jOHuVieV5BvvjGh1wDLI5D4SQiN88GtsTOHXHXyAEabkdkxH2966/krom9a3o3
 0hdpCVoCmwWMB8iT2osul0jflfMucJQXRbEFa158XojH0HdhammcSsq4F3Io3+ryBhCFAWZCmBt
 V1i7LM31UWEBtVj7+ik3+L1ngPOeFg3WFOtFPmRfDJTXy6k9vsZ2c1q4AyD7XqL9aKEaPztqNQc
 hebADNmr90CbnB7Q7LEDIkb0ZkLlvsP239L2ImN7IeIHlPORWx+zQikga7ykv0qC/jYgbdDcOBC
 SvNPCnPGAFalLycMZEA==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a86b684 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=IMqy8r4nALh_Rpp6BzYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200058
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

Hi All,

On 13-Jul-26 22:38, Hans de Goede wrote:
> The Acer One S1003 2-in-1 also comes in a variant with a 1200x1920 FHD
> screen instead of the 800x1280 screen.
> 
> The FHD screen also is a portrait screen used in a landscape clamshell
> 2-in-1, add a second Acer One S1003 quirk matching the FHD screen.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

ping, can I get a Reviewed-by / Acked-by for this one so that
I can push it please ?

Regards,

Hans


> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3a218fb592ce..68b4eb7ab9f9 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -161,12 +161,18 @@ static const struct drm_dmi_panel_orientation_data lcd1600x2560_rightside_up = {
>  };
>  
>  static const struct dmi_system_id orientation_data[] = {
> -	{	/* Acer One 10 (S1003) */
> +	{	/* Acer One 10 (S1003) (HD) */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
>  		},
>  		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* Acer One 10 (S1003) (FHD) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
> +		},
> +		.driver_data = (void *)&lcd1200x1920_rightside_up,
>  	}, {	/* Acer Switch V 10 (SW5-017) */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),

