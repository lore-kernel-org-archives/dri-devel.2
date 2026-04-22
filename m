Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3608FA1FE8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DAF10E043;
	Wed, 22 Apr 2026 19:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A40eLM4t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kCmWNYRe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D298610E043
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:22:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG4k9Y1587762
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gd8Jn+YnGMOFa7MuN99QaZkw
 rSfwywBTf0cnvOdaVqE=; b=A40eLM4tSJzOgUsqpN20mc6f7SS9kzDRFvqemXUc
 RCnz0ii0ZZLvHzTWFDqyxPR3rQRdW+SkiJFlFeYWDBw9amuvYV5i9u4qkkP2x4lJ
 O5O5QRd3X8u3Ye+jwJH1M1jb99OSS+Lwhc2hj5PH6zJRlFZRc4/X6WDEZbYK8xc/
 16RyB8/NvxduzDA7FmGvC1990/r6nDyzciJ2ZmoMqI2uaPkZje5MsUhToIG1qGah
 3/f7J9aVVYb+UVB63vwIl9DIKNWFXLRmn1ax9H1yX1GMt1RLBA+PbkHBXvJOtmtr
 GlE9OOlTJS9Q5FmSyk4pZcPwm32+mma3bVT9M11SsP92YA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq0p64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:22:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e2592ea3bso64168001cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776885735; x=1777490535;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gd8Jn+YnGMOFa7MuN99QaZkwrSfwywBTf0cnvOdaVqE=;
 b=kCmWNYReXfavaLb2Evhbg8/pW+f49KuqoxhhTK27yvIf95Y29nYn0yNH/zK1ABs/Md
 dXEw2pCtP5yUy9Zqz3noQKYbi2KjSzKsOY2zDqOtaGBpBe9ktq1tkuEryvCsm0M23vxq
 cMArHCHCu/cpsoiRtbpYWBw2Ku+99/rvRtrCL3h2fvcSEhnYtyFtc9hRG56PKMOxUo7F
 CTHgkxk/hF3rI24C5sjcYzscVFCYcRquIUbVXcXog4Wp8dGDPvTmIrjHloSkePepsnI2
 N+ovJDuV+reFvKm/Sy+dy68S9cWHwEw4lC+8CxOQvxLf0ZUZFsQC84NzlVwKwXU0oYvo
 PoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776885735; x=1777490535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gd8Jn+YnGMOFa7MuN99QaZkwrSfwywBTf0cnvOdaVqE=;
 b=OQsBTVeGTtCogZRTevUYPKXIZ77nnm51PKmTK4dPpjOh7/8xOdcFbwLGWOmm9USPXa
 J2cmix4eXUTRC58/DIcospC+n5Te+w2bnkaCrdWlPuSaUxxYmoTvhyKhakrHxeqvh9WK
 UtPMLhcHskvA2nVKXTcl3wSPmYHMk1eQE/C+8gYqRlq/sxZqsVKHyoPPpZg+kGKnTVK7
 mW0AKSG8u5QH1Zj4n6Fb7IEBaELVvv2sv8kNcEu1Mk0yTk3t5qWObFVtYQ1Rlt+krR7Y
 5tN4HH6Qew4d/JzOrD1es+BFkLfuHWrbvy/gaRFmu7DsJUKoT/SL22zEVIEzMG0lWz5J
 UfkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ++HBYzz/rfDOt6/u4WxbnhaGlmsPw7cKwW7KEJV1vRcr0wAcA6s3FvdB1POVItL7Tz0asB43yCxkM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVE0YnFyvxcWSmtlpQfzfnnglHcLxLw12nMNAj1JHc5q6mqM+9
 WlmvC1aY8JhID6X/HS61ae39c64ePw4+VTjEURuDbhFxeWBSS7Mf6tTNzzunGHOid1XD/+KW2mY
 4eZijynWKx56Aqs6ib2w8L7gqef6SlpT/7PuJVsNq2RhadMsb7OIwn23qwPwXhMm0/mh5yEY=
X-Gm-Gg: AeBDieuxR/TNzGM4fgapFX+haz85V17bY6iGZZ0sx+MLYie15sFlnAhiQ7vKAV6ksZk
 UTJWeqZ1qJEEtP/pWkdbjYcdzeZQ46UuD1yx5LAaqylkSpglKi+4lHZhF7VyE0aYhvu1UoCoZ0y
 ka/krjQ9S2/YlYjfbqhZOCtkCdzlUB/dG8nI4b2S6N0FdSSYA9pmwh4XEk2qF5yzfEe1R5hzrGW
 N65AKWt7t/uFzEpH3INmiy9us3qBRjzeXvZHXVI9ZLY9uOE9nwTDUhKET/C/kb2XM9ZoBneHax2
 K7hA8CkE66sRTXynYYYO+GMK4Ns74otg0s8JloiXCCrtq9PJymcAJPJx81zkJd4R5vv73Cu3hwg
 N/eUpuRAE7G8qts17IWFph1179LwH3Fe+FMrPx3yB0nw0WYUTzQwqss2vmB+xfrEQ75zgsglHdc
 sRs5uaW3ticSO17WnyuQm18z42zQYaEv14vK2iHe5iErekvw==
X-Received: by 2002:ac8:5cce:0:b0:50e:63b4:9b9f with SMTP id
 d75a77b69052e-50e63b49f5amr193354521cf.55.1776885735237; 
 Wed, 22 Apr 2026 12:22:15 -0700 (PDT)
X-Received: by 2002:ac8:5cce:0:b0:50e:63b4:9b9f with SMTP id
 d75a77b69052e-50e63b49f5amr193353761cf.55.1776885734643; 
 Wed, 22 Apr 2026 12:22:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e12c8sm4633175e87.49.2026.04.22.12.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:22:13 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:22:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
Message-ID: <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4OCBTYWx0ZWRfXwnEdobmeUlOH
 bEMNr4Pui/FCKY9gdnLGBmvEEer2OFAXpZUZtDNbdI8Dg7EqnWOrY5YKyOshW7VmYNYa89V5R1z
 Cs9URln7vjifThDSgYoYhU4R0CiMAobJKdJFVW1Knf5X6UYzcpvqyXAYkhQZjZ0Ke3JIDtwvPe7
 QLYI+nIdg62H6P2rjjfeJjEtlcqN6SIiN4LuuW8WH8x1ChZp6H6Xx9PLXi8TCF1fDdzctYLkY5w
 yOcd6Mo5YH9ga+uq5Et1y4XL3rIt5nYYzWiqrqv4tMY/KtEI0GHcr/fV9EpSca5t2kN8dQTjGPk
 XhzcAEK+aDa9c4zTzStuiWydTBb4Tyu5km7+EdYKH5FlLZPBC3mmNlSCkoh5IwAgBHOZz32Jf5P
 xNMT3v/d6zXyI0/RKsZGCEJaitBWZtb/7Pz6wQJ9/0wNO+dguXK6ZULfz/VmlB2bfMY1U4QQpMp
 ggxI3mt0Xc71mkOCOZQ==
X-Proofpoint-ORIG-GUID: V6t3u7WpXEbjMxWAt_Po1ZWuKV_mPWbL
X-Proofpoint-GUID: V6t3u7WpXEbjMxWAt_Po1ZWuKV_mPWbL
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e91fe7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=RF00TdSWAAAA:8
 a=P1BnusSwAAAA:8 a=b2m3sqVslbpkhv3KnfgA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=_nx8FpPT0le-2JWwMI5O:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220188
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

On Mon, Apr 20, 2026 at 04:13:36PM +0300, Tomi Valkeinen wrote:
> Add timings for the panel used in Raspberry Pi 7" DSI Display module:
> https://www.raspberrypi.com/products/raspberry-pi-touch-display/
> 
> This has been tested with version v1.1 of the display module.
> 
> The panel is very strict about the back-porch values, they must be
> exactly 46 for hbp and 23 for vbp. Other timings can be defined quite
> freely.
> 
> The panel is exclusive to Raspberry Pi, and different versions of the
> display module can have panels from different vendors which are fully
> compatible. Also, as the panel vendors are not public, the compatible
> string used is "raspberrypi,7inch-dsi".
> 
> Note that while the display module has a DSI connector, and the
> compatible has "dsi" in it, we use DRM_MODE_CONNECTOR_DPI as the panel
> itself is a parallel video panel. The display module (as of v1.1) uses
> TC358762 DSI-to-DPI bridge to do the conversion.
> 
> We could use DRM_MODE_CONNECTOR_DSI here, which would have the benefit
> of showing a "DSI-1" connector to the userspace. However, the panel IS a
> DPI panel, and gets its input from a DSI-to-DPI bridge, and the
> panel-simple.c behaves differently depending on the connector type used,
> so, DRM_MODE_CONNECTOR_DPI it is.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 91ab280869ba..e75eb20301f2 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4208,6 +4208,35 @@ static const struct panel_desc rocktech_rk043fn48h = {
>  	.connector_type = DRM_MODE_CONNECTOR_DPI,
>  };
>  
> +static const struct display_timing raspberrypi_7inch_timing = {
> +	.pixelclock = { 10000000, 30000000, 50000000 },
> +	.hactive = { 800, 800, 800 },
> +	.hfront_porch = { 16, 72, 354 },
> +	.hsync_len = { 1, 32, 40 },
> +	.hback_porch = { 46, 46, 46 },
> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 7, 21, 147 },
> +	.vsync_len = { 1, 2, 20 },
> +	.vback_porch = { 23, 23, 23 },
> +	.flags = DISPLAY_FLAGS_VSYNC_HIGH | DISPLAY_FLAGS_HSYNC_HIGH,
> +	/* Note: the rest of the flags are defined below in bus_flags */
> +};

This looks pretty close to powertip panels that have been used before
hand in those modules. Are you sure that powertip,ph800480t013-idf02
or powertip,ph800480t032-zhc19 don't work for you?

-- 
With best wishes
Dmitry
