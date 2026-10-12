Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADB4CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8572910E5AB;
	Mon, 12 Oct 2026 14:09:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6347B10E5AB
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:09:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxxoU800868
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mdrAE6CtWkM5g2ZOGMq0Ywa6
 INxDz9OrKN4VJ11fBwY=; b=Ckn2jM7Eo0qepYoAQcndFNeW2qyhGOPwe2Mt80W9
 ElX2mrrRhZErw4oASsxb1JsWQZsCTq95LZUB6q00UegX7Ant666BW9yPZzlaSw4f
 PhEhmRCzi62WwFouLsel3RuvzRIkJMB3boSSmZKUtaG/l2Ec4/KOFVVjuX4KzFiL
 eoDv26PvZMSc2N+4pgI9FO3Hxr2f/FKCN23q0JraCNZMvVYNFvWo9Z3C0RsbnPhC
 tXXYzdAiXPZKjONgWzxKUZFcwyjAt9Buz3p0JiABcZrn0eLRvm0OtSedFsP1nFFt
 uLQ4T+fWcVst5Lpu1qCDKK1jIvc5tY5ch+5PAPHjj+VygQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcs2bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:09:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a082c014aso416602785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791814146; x=1792418946;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mdrAE6CtWkM5g2ZOGMq0Ywa6INxDz9OrKN4VJ11fBwY=;
 b=Pehl4WrierU47yNwvj9e2PH5oGtfR907Ozbd9fGR7Lexg0K9ZHSQGLc2wa7oqCpGsr
 Oa1Ltx/tHP8h2qkGbHASHkdm3ThG6vi7i3XPPTgQ+V3Ag6A6hfq46AAW87p58nPxjsC8
 MyeZbidVbO4vl5wJEgZoWqeGx1aUqXzAopnwMJDF6LRZu3faFHSyiFbdO6Lh4dxmyh8p
 +i8iHdAoZB9pIbjjlW7xPihxkGmYpK2ALWYkjaJdHjd0NOZ5Z2tmh270wufrubiYBo+0
 xAWEwyy/0F0y86S6v+fqNTOmLn7mseDx69GIkEyTiUuhmZm/68q5GN8VHERtNLhAZ8JB
 rZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814146; x=1792418946;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mdrAE6CtWkM5g2ZOGMq0Ywa6INxDz9OrKN4VJ11fBwY=;
 b=TYZeRNPa5OvTWmh8MQyFeWY7jAf+8UdhPnNU1V38Ox5YDCBCi60r1d33aAPqnW+qzc
 +hmx9nV/+Q2hc7YzAVD+PkiqszeIggBTowby//OHPWo8b/kxPKGTu3uN+zkLZCQmUTLZ
 NKzUY8u7MCMeY2H1CyWlCfr64nRcw5nN+mY59Ux3NFPuIq7D+FjHbGX0FZVCkSNAIq+q
 ct3vreV8JbHcZ3I6aqgHWXHTqb3WoxcOfec549aF6/qQs9OqkjbDl8TNReSVxu6B5kSH
 UH3DPruzdlbZtPi6g1F2J38Vez1ecS+3Dmeam0CKh7fr+lrSVHglp4OOt4NZiFFXdjlh
 3T5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEuTN+Z869TOi4j9yBmRedp0qDvrJVmjB8iFhQDuz502ShNUZ6n0kF0SSH9rMypLkTw9rbXoCTzzM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL1y1lm6+slEAtwfEL1D4XhYaaaapIz3fljDhPdd6gZXqE8dnh5
 D9VSzU0BQ/4gtRmgRlThrW3pAMssvf9nNAKdQtu4OB/wuE3b0PTlzGNvBhfaRg0iTOnvpj9arAj
 8ONmsWwHKg41zcTkWKFLhGWcoEFPm2TQncGwlLK+OOo5Gjw1w32n1Cyu0xPj8K/KV0jw8tjI=
X-Gm-Gg: AYBFou3l17sLdcMXN95oDkTr702pnus5pevSaBR9OUmBIhTEVuJT5e3s68x8sAddL/X
 jqchBFHqXnCHVs5Ou19fpmCczgNbq5Y4yQHUzOTK/t3tOcawKHm9wWmYm0RetvExrFzLgRKowwk
 Nqu8YEEj+UvOi4AWedKStOKYDBuItLgivmRZM+NrpiM/VE+psWY9gy7uOZL2wLdz4eqwSuFwMRf
 gLqvUhXXgOV9G5nzEN8e3VtnHghrkiE61yXAZUByhz3uuBvYpgmzGCzHuBAwx74nSw8HpXVyHju
 ein5TYcNN+QHB4XjTkeZkunAogEHIUW/Y1cX6tZdRBTdNNmsEZWuY3i0vXlDY8YOtbfb+lJyYl1
 G7XjBW6vzEW6f8XOehyBGmaiSh3BPtJQCARSYG66K/MHn/KFoSTBvaPqml2EslIwIaUMFWV1Nil
 DgSaOasG9K+zTg
X-Received: by 2002:a05:620a:3182:b0:93b:cb64:25a5 with SMTP id
 af79cd13be357-93eb95e34cbmr1568177385a.12.1791814145782; 
 Mon, 12 Oct 2026 07:09:05 -0700 (PDT)
X-Received: by 2002:a05:620a:3182:b0:93b:cb64:25a5 with SMTP id
 af79cd13be357-93eb95e34cbmr1568168385a.12.1791814145243; 
 Mon, 12 Oct 2026 07:09:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddcd3fcbsm2883054e87.0.2026.10.12.07.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:09:04 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:09:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dragon@radxa.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 15/20] drm/msm/dp: Flush VSC updates when leaving YUV420
Message-ID: <3itnyk5vvlj2piguntvera2ch5qn4mmzmqch3aevfmpdjvis44@7zujyc5sauea>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-15-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-msm-dp-hdr10-v2-15-1835d4966da3@radxa.com>
X-Proofpoint-GUID: 9I1yRgFqKC_SB0T-zDyUT3-5thqV5R9S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX7PWVy8SbrK3E
 pqe9Ecbo8A7X7zCp2O0lr90yOC0CwuSalZ6QIiUwy69tWWINgEjBr8x5opLdsisf7J/+RoFKizP
 lJj/wjAw81BnB43VU38MbGXv8oAfIUM=
X-Proofpoint-ORIG-GUID: 9I1yRgFqKC_SB0T-zDyUT3-5thqV5R9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX19P0W2bMDPp/
 Diz+sQQZlmgo2W1S6ApJukhQiXfFiy9zmZdZUvYYN12Pfq/D6BkNfrVehAClXOhOL7nogakA49C
 /aBfiE/aaLL2AAzfeK174kLjjb/M3znfWfsPSURbG9CmCyArrruF+GP+Q/4+nsgeQnIfcCgMXaD
 /UrsaABYArTz3zHs2CArwSJF+jU9Nub9XQxyrNtDNusgzkUFyCTTHdXyBtJrg3koTiMMJ0p2duo
 IBzf+p8mXyu+c9KUy8xjZa+khJ1syruHJgjKyAS7ffViy+12K20XpDgYaPlyHodJE3ZZj/jf4Vk
 oihjF1VFDqAvUkN3jn4/fYnTQNZblcAlOQrI2+T8/I+/5Cryw2cT4c1M/TU5fML20igzjAnhHd7
 nfTjDKVdf3zlkP4cVAtDCyrFwOAj8YP/AWz7ZE9lLc3CLwexciPW7issVHF6h8jCy7H3NPgymwR
 4QHvcJWzgV+jI9YDzAQ==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6accea02 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=ksxQWNrZAAAA:8
 a=Sq4eR0YASbV39jB7rD4A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056
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

On Fri, Oct 09, 2026 at 11:16:07AM +0800, Xilin Wu wrote:
> Peripheral flush is currently requested only for the new YUV420 mode.
> Returning to RGB also changes SDP state and must remove the old VSC
> packet rather than leaving its enable bits set.
> 
> Track whether either stream needs VSC and request peripheral flush for
> both enabling and removing it. Explicitly disable VSC for RGB, and write
> the packet payload before enabling transmission. Retain the existing
> hardware-specific SDP update mechanism.

Missing Fixes tag.

> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++++-
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 6 ++++--
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 1f9595ff5fd9..486348113b8a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -691,6 +691,8 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>  	else
>  		bpp = state->bpp;
>  
> +	msm_dp_panel->sdp_needs_flush = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ||
> +		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode);

Does it need locking? Can we instead store if SDP is goign to be used in
the atomic state and then pass both old and new state here, letting the
bridge to determine if the SDP status is being changed on this modeset.

>  	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
>  
>  	/* populate wide_bus_support to different layers */

-- 
With best wishes
Dmitry
