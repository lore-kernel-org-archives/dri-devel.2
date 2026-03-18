Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32706103E199
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959E210E859;
	Wed, 18 Mar 2026 15:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdNDQzyX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CJzHCT3/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2E310E85B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:23:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IBluRW2878682
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mNyh1HiW46Rs6Ltcp49U0a5W
 xhwi8i0oKhGbe83Lvh0=; b=KdNDQzyXDHAAGIHwEy6D//NK//nVTQk0wmD2AFFO
 Xk+EH/ONgDerwM34G/X/r2onD63AiAxprWQ+vu8NuIQXvLtLzg8LuOsm4TnsDqK8
 WhxOrO5kRbi/tZSh6GEFVn6hj1K+30d1v6O/4CEawscRTNrrb7Uvs/AjtC5rzg6q
 Egyu5BDOIo64RikheSQgVqryII4MToPRpbUn3t4VwY+4mpKsedS7qW7xl/5chF8v
 ajn8X2Fp0KuUZ7kWaEfiQFkAhvwcJx+z0UKgdlHmknstNEzzegFadmJwUdlXiypo
 0ljFxTpAi3i6loY88/1umyk4GTYLN3kbyQBspJOLbUDIAg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cypwr23nw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:23:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5ffbf6d209aso54322663137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773847415; x=1774452215;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mNyh1HiW46Rs6Ltcp49U0a5Wxhwi8i0oKhGbe83Lvh0=;
 b=CJzHCT3/+hIuMdUFIny3xPiRpOXXtI7pgDXnP6UaqYoUO9mU7/VdTNuDA+E18Lvwkx
 Vm9LMruUguMJ9USBuMg2DWxhsDmjUYAC3QeVhiFNQwX1MfDQDU2yhXm6n/ooHtxKaKyB
 rxrrRmr6rybWF5fjK2u/hH7yYB7625Ox2+Na8oSB7zBXIFO0OBBoyuVsnrDEfTng+QAP
 uRXuVqCwEai2SeBG9Gms9fjEz8vIwzHJ8aJOLPNLHFajczbyiQhIoPhHuB4tEpDEdqEj
 q+L8rJEX26XaEBAlPd3uJkVZHEExCPQOEPGQxYkFmumYXJaK+zV4ThSsd8vatl1QIzIz
 IXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847415; x=1774452215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNyh1HiW46Rs6Ltcp49U0a5Wxhwi8i0oKhGbe83Lvh0=;
 b=HswokJXVzh41gyZIg5rVctRPi7jlu92fVwFBeomkZEXRmTkSEKr+qm58HSNC9Vslcd
 yz82MTUZk1mZ70kzpU9RlRxIsCyIyj8LOZ/ua3iz1CD3GzZMgQ2YCC+c0Be1PpjRJUkV
 e+VluH9PQvXU07W/t/zykDOqGNd7E4hPL5eeHnp9nKydaHEe0oH77zlzeQHlme8YYAC+
 LK5WcoN2AkzB/h+BGAhH+eDuBKSCFqyDI9X69aUYFsoVQhtpzmySR64L3xoLa5Gg2sSB
 gMqOltsY/qDEa2XqXgRXrvPsEOjI+7RbyThcQy9kSQ5TgkAEemftxWVMQxlFRo6tsMEs
 2fBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ39KKXUplzGyZre5bs5uyMTgqcMcNcZhnuaBpV9E6n0VTWKd+hJsNFAcRkS9U0SkfgchnRkx/YpQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcYX6nlwhz1umk0MK8mLzNP8xrBJHdlyYpHokjvIAHbKlbFW4w
 GZ6hCbX9rqyZrKGgnbghlUXcUSoZ5QHO7fDc0NIM5oQvu8Tj0eDTDEQ+r2FZiBonOsah+m6eIA9
 mHdh9sZ/XVz9iO0D6UzLCJ2PVJhzF3zVFT8Q99cJw0i13rmxhYQOC/46Xdk+7TVoykuKxhU4=
X-Gm-Gg: ATEYQzwISiRR1axkwBrgUsjGyu7Gg+Cn1VqKJryot7eUjf6S5PFCjAI7p3t2cQ7+L8c
 XL/cB4c2jTXuSHq5ZI1B/V5sW0F929G3xa1P0fsgy3FQMDML/yA/94biZ54B9KKCV1xqekwvnGS
 ZBwz16vdRkforASQbNwMoMzj4WpJtcQI6ic1n3Xvu6NQp8HbaRAAphraIV9isNTYant4VtGF2RK
 GE0QDDb+aI9jf/+Vi6jwIl2IxJHomxw6C+McZueuvccqxTUwagrBrnAxZtBBmTdj4gHZqsQArQt
 AnnrGHmejGTY2YnEFyDCoSJahF+EcexyEO4aZ+7o9yUV5ACM+UclSh8+XyuTrnJ7fS4AHsvahZb
 8N7QmOf6LBwSaMtXfJGlo+Z38osvTKHk4Bbb5ts93u6RIZNR2VO5Re32sA57yvEhcLOcKV7EQct
 fLzMpQrlbhwJLaRAsZ1LRkUP2xiDPPfDDvCrc=
X-Received: by 2002:a05:6102:ccf:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-6027d39aee1mr1818881137.31.1773847414627; 
 Wed, 18 Mar 2026 08:23:34 -0700 (PDT)
X-Received: by 2002:a05:6102:ccf:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-6027d39aee1mr1818864137.31.1773847414167; 
 Wed, 18 Mar 2026 08:23:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd54bc645sm6008871fa.30.2026.03.18.08.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:23:33 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:23:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/msm/dpu: fix video mode DSC INTF timing width
 for non 8 bit panels
Message-ID: <ioc5si2r46kio3l46dcfgvnaytago4hdlqlzagerwc2vc2oqv5@sovdeki4ws7g>
References: <20260318-dsi-rgb101010-support-v1-0-6021eb79e796@pm.me>
 <20260318-dsi-rgb101010-support-v1-3-6021eb79e796@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-rgb101010-support-v1-3-6021eb79e796@pm.me>
X-Authority-Analysis: v=2.4 cv=bIcb4f+Z c=1 sm=1 tr=0 ts=69bac377 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=2B9XaqMHzECM89MvOLQA:9
 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: 3UXv8xvrsx-inHxHWUI2wJhS0i6oIG20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzMSBTYWx0ZWRfX65H4zPbYWHOi
 QBv3uoPjXr0FyiXfOWS6K7YZ6quEtRelnM1WqJwcJEkeJ5I+p5HvV/vWjjh/BRfT6Y7Nqvypf19
 Jp4AbULqb3tJfFYJgr+jTJU/y9tpxqcSEFqsZ5vFKQiT8Wqmab1i5oneFJoCAMsL+k4y7vJVPi9
 EDqGhX33PG62XX64awJCO4KsaLg64MZD/ofjOPE4A/1WZfhM6nAnsUOk8KTqVqpE0q9fs6weTKf
 H9JvyxRzGpSWEjfgA3353bdIo+1WqIrMWwtVm5Pw7fu6nN67XBuhHU9xD/XVgwRkxc5FZQpfXU4
 EhHR+Pnv3DUyVlQo3eYLFt9NkOJfHrjy39FXcmyPdpvnfQAO5cgamufC1aoc+ybP6VBX23SdM9k
 3a9bSwE2lpHdBpm7+vYTIDWZZFL0vWWlL1xwlN5JQTECcpQmUOvP69KMp1cj5+Wpwf1vueTZtfQ
 /WPLFhazfviaWgUSc2g==
X-Proofpoint-GUID: 3UXv8xvrsx-inHxHWUI2wJhS0i6oIG20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180131
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

On Wed, Mar 18, 2026 at 09:41:09AM +0000, Alexander Koskovich wrote:
> Using bits_per_component * 3 as the divisor for the compressed INTF
> timing width produces constant FIFO errors for panels such as the BOE
> BF068MWM-TD0 which is a 10 bit panel.
> 
> The downstream driver calculates the compressed timing width by
> dividing the total compressed bytes per line by 3 which does not depend
> on bits_per_component. Switch the divisor to 24 to match downstream.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index 0ba777bda253..9b046a0e77aa 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -122,19 +122,21 @@ static void drm_mode_to_intf_timing_params(
>  	}
>  
>  	/*
> -	 * for DSI, if compression is enabled, then divide the horizonal active
> -	 * timing parameters by compression ratio. bits of 3 components(R/G/B)
> -	 * is compressed into bits of 1 pixel.
> +	 * For DSI, if DSC is enabled, use a fixed divisor of 24 rather than
> +	 * bits_per_component * 3 when calculating the compressed timing width.
> +	 *
> +	 * This matches the downstream driver and is required for panels with
> +	 * bits_per_component != 8.
>  	 */
>  	if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
>  		struct drm_dsc_config *dsc =
>  		       dpu_encoder_get_dsc_config(phys_enc->parent);
> +
>  		/*
>  		 * TODO: replace drm_dsc_get_bpp_int with logic to handle
>  		 * fractional part if there is fraction
>  		 */
> -		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
> -				(dsc->bits_per_component * 3);
> +		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;
>  		timing->xres = timing->width;
>  	}
>  }

It's already a third patch touching this part of code. I hope Marijn can
comment here.

-- 
With best wishes
Dmitry
