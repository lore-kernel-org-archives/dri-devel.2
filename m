Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A33CA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B666710E505;
	Mon, 12 Oct 2026 08:01:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C904510EC71
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:01:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55rwJ2436696
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JsBn+x/B4FRTAQ9qeP4Xp/X8QK95CkhbCMiwhXCn/08=; b=R/iGb5yh5gV+VzRZ
 yCFEkH4d4rDnR+vKoe15fRaCJi4R42/mdiB6NmcJrF5frK9CRi3rD8YYWU2pyb8v
 OUVigOu78zNtDxDGKQJmQjTq4oHP5b413jrhdmFsg0VBon054OMYK/KYZCZUia+q
 Nw1aiu3pupkVf7mrgTgolwvyR1DMps1/4jTDyCRPZMgbB4BjFAKcdfC0NYj/O9S5
 GZoMfYcCBDmj4obyPe7oZqTlMAl0VhU6mL/9baAWZyug+xKCnMO9Mny2Xel4px/W
 kWHFX2jSt5qEiCBmM6FQsUNLHaYw5hVsiW8VcRGvOzD6Xh1acjR/zrWWfkpAFXt3
 Zgfvvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7b2fdu05-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:01:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93edac5877bso3781285a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791792066; x=1792396866;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JsBn+x/B4FRTAQ9qeP4Xp/X8QK95CkhbCMiwhXCn/08=;
 b=TRO3P77rAxLVeupTXZ5VksglrleVf97A/xAUfqwgVPWgotV5iDtW08Trh4Od2GytH0
 USdUG/r5nJNPlwMEr+MWuBADigi9uY5byZom6sz8JEdbZm7nRWf2mKv5Q5uHuk7GqxsD
 WsaEZ9pvRZk5SlOQ6d6rjzvYPJZeAgNP/A3UY3NVF0qe3sN8opUIn1qu6Hk9N2Qq5Wjg
 d1VUaJMsoDES98R2pbMQeUOZTkta6ASLKYzVPXecO+R+nCVY6kJO7/O/i2Fb2sNRPteT
 LOKiqTIYAK3x6X1kWiIw6u2ra49FUkH4XIkR5mJh+XnmoFXK1L8FkJCp9B2WQf09++/5
 1KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791792066; x=1792396866;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JsBn+x/B4FRTAQ9qeP4Xp/X8QK95CkhbCMiwhXCn/08=;
 b=GE+0WHUZiOwKk+vEAFzqwaAyVINKwoI17i6Wg+1qB5BxV5ip+uSnVuxB6z0zLyP4KL
 QtvNAn9Gf20m8cNwPJEX0IX0Y7fCqDedlsjKAdkOqAtlF/do91Wi8+qHB3/qR6VCLMvE
 7lADN9AvELTJUxT89y0EiRrTgxle4An5cVUV0VCpwdiFY4oqiBwSIUdCfMfrQ/lAcgl4
 0DclW2Xun3dQmA0uOfOq6Oec4qDjvQOr0loXSOZFQDlf/Mrx259VHLRLcqtU/ByPQCi/
 m48JYdvo/yAYZFLNExVGT7xhstJDQnyr9Oict0ptJ54L8KztYjr0yITg86+H4rEjmvSl
 HYeA==
X-Gm-Message-State: AFq9FYKkd5aUfmUzlLquzrXWYGgVfhmLrpMhXsUIKob7sKOx4R+rOI9u
 PI/90ejNZNqXwcDyrr2tJ0grmz4jub61HnSZF4O0qwc+E5W3qkvYeNpEDlSSIyqSLhlkTmqUveo
 ffmOi73BZCAYnodP9MF/PDWjhR5YIGnvB3HwzZYxsueHx3nmljPZpIcTJ2rAH0LdGqp/IPC0=
X-Gm-Gg: AYBFou3rDoUih6SeVmX/nocHmgHDHr9O1hOsx5ml2sU1cqnKS4MTLb+eg1nJJDKo6nb
 5Xbbh81X8EAI3qoD2C/jvTQaisHqh5caE0HSdFghwy23u3AJwwFBHd4yflnpbCYwsIa1A0L1k/m
 DOLZWjhiyB/jj4t98/T0NnYzfhg9pEiIN1xgApwF2B3S0iOScL658q4hPh7s6eCU5Z5vIlnNsDR
 M/6cexgbGbuSWGyMh8giglNBZkh1FZM6hHWriDGjsb5yevdcO0MOYqqFPDY9hkNJp4eR1Mg+Euh
 rMlKDHaMueObW1kfW/8M0b9Jbb1Ltmeyy4OzTK3nzijZFhEraxfxZL88BG3MzYMVKMejuxRcvIj
 SWvL5+cg+H7DxruVGe5gn4A==
X-Received: by 2002:a05:620a:1a10:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-93ebd23a4f6mr1661419085a.4.1791792066237; 
 Mon, 12 Oct 2026 01:01:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1a10:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-93ebd23a4f6mr1661411885a.4.1791792065667; 
 Mon, 12 Oct 2026 01:01:05 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3c9af97sm27169731fa.14.2026.10.12.01.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 01:00:42 -0700 (PDT)
Message-ID: <d33eaab8-2933-45a9-a716-b3eebf3dd9d4@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 10:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/20] drm/msm/dp: Clear stale MSA colorimetry bits
To: Xilin Wu <sophon@radxa.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dragon@radxa.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-14-1835d4966da3@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-14-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMSBTYWx0ZWRfX3QVxAoQHvUxA
 RAjen5xRsTuoNfBx6BuMuJkCAkprb/xCveP2u9eNKNbNhedf5bxCiQrTB5pF14BObtCdzcGYrvf
 iP/R0qLGTWaCS9SHCiXSvT0vSrFpALI=
X-Proofpoint-GUID: xS-hvbG_yiq6HPldqT2ZjSw8-xFY5Czz
X-Authority-Analysis: v=2.4 cv=NddzRGD4 c=1 sm=1 tr=0 ts=6acc93c3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ksxQWNrZAAAA:8 a=KLRTrxjsjmTHsxePAeEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMSBTYWx0ZWRfX6N2NmYcd4A3y
 SGAMx/Ea03tVAGt8OUNBZPYl4q7fIfkpnNjx+QaEqjiZS/x5324dfrYqb2c6yjUW+wEjhwxUdRi
 Q74MMqJpZwv6/kzcxKAWKg76NInO2Uii5y9bxQi7xocP3W/cyj6MXt9NgMzC4viAE7hnCe4Ke35
 rsgsG+tvvuO6mBk4CZfYj3qW08JEWXqtR30LJqjWSvGuroppQ4CYxWreA31/1dH65C9+lUn6aC5
 WGJJS1/c5+g6/FmYzcUDB83wYWp64DbbeDpmL4b35yOJ7xJc0Xwhp1ywebdOmEDzkWz2fEFZKXo
 zJW1y1ScXVCTRNvjmrW3LXNxsgLhTk19jfEE6kgksnviz12i1QmSTlfTaGE0/vvQEH2CdR42ZWS
 NgO22hvx83IiCxghrei2ES+chHrF+VPLpY0XS05kOVuI0VvLihOg5vXo2i7Mk1IEjhqN4t/KTE5
 UdzlfWya8hlCebdMbBA==
X-Proofpoint-ORIG-GUID: xS-hvbG_yiq6HPldqT2ZjSw8-xFY5Czz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120031
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

On 10/9/26 5:16 AM, Xilin Wu wrote:
> The MISC0 update clears the bit-depth field but only ORs in the new
> colorimetry value. Bits from the previous stream can therefore survive
> when the new value clears them.
> 
> Clear the colorimetry field together with the bit-depth field before
> programming the new stream.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 791bb3af2cad..783cafb22374 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -476,7 +476,8 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
>  	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
>  
>  	/* clear bpp bits */
> -	misc_val &= ~(0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT);
> +	misc_val &= ~((0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT) |
> +		      GENMASK(4, 1));

The colorimetry field spans bits 7:1 AFAICU and bit 15 means
Y-only video

Furthermore, I believe this register holds the standard fields/
values defined in drm_dp.h near

"/* MSA (Main Stream Attribute) MISC bits (as MISC1<<8|MISC0) */"

so we can drop the local defines

Konrad
