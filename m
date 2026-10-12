Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4B4CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7BB410F1B3;
	Mon, 12 Oct 2026 14:49:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EC910F19F
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:48:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0XTA2252795
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bpOndlgPfv1kdWQOBM72wFH+
 Lnf26uksnJykK9/Hdy0=; b=leQ3bD+g5c4VwVA6byRTH+0bNQu9f658P3LBrm0T
 OeuBlhUzGR7Ak7FXaNvBsYmbvOCx4iV/fyfr7g2TBld1Ih9q5tdgxeH4Zrof98pY
 yer49v/uHQp/PuurFmz/HVauIFCeyCmNVC/UZQ3jRqT09sGtEI58x+P2uRzRufva
 CR0Npj6JR4C31oqsUyLrqhqGA6FhBT4LJondzTSWoOOwl8JrTrYTSQW0CIP7++hE
 XC13s1ELe1gMVTM48x+eMKyN+20CrBsX1zL+ninXNBmkvBRSoQtSIfugCPaVBVI4
 ukHpmfzp7qGfeT6y8elgPZ7KAmFFIntQNJSm4G+aJvO6/Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j713h9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:48:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91961374299so74211336d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791816521; x=1792421321;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bpOndlgPfv1kdWQOBM72wFH+Lnf26uksnJykK9/Hdy0=;
 b=U1uSTC4/lYTF+ovFBQlgV4V37GfG8jwBJYl4sazI4pA+uVk6YW6rjn9WMLb9C5poyg
 frLyWqHAMnwKD7x27zJBuwCa/roqmDvRZdYIafwfTToYJXeIhwHYIommlvtA/Dp22IJ2
 uqAYuEyJW6njja+4qP9xCjs5ljgsNG2j7KWy4uka317xGMXWPcN8ngsndsVf9vx1g59P
 8lAl20yTOt6XstcFv4jqbDpHWOLP/zM3RyxbCD5qypSJKHhll6sBrD72pxW81nCRheW4
 Fux7gB74dtssTGXGphgQXdrkH1SxJlsgIHBesaZFpaXv75FgNbhWR5/vncgkVAyMHBRh
 KNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816521; x=1792421321;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bpOndlgPfv1kdWQOBM72wFH+Lnf26uksnJykK9/Hdy0=;
 b=uJVsZu/IbIVW9SSq4lLDraNIow1TtbOOPwVHoHoByPAUWBmwm+DbWHDL/4ztfC0b4x
 TwhaD0jsEkCHD/T77QM6/JZxV1Pghp8UK1sBzctMmpqKD0ezmLQiOthwot4Huave3FiN
 BUPFLK/efAR0L11Ew98dlwZpVV0kgNTK8SDCB5E4KTGBskwd/eD0UO3UiNyHYXIWeHIj
 /kBLF+JXQFxWjrS8q4PEy2xfWtylJwrRxknsA4WerDs7hRE66CAx6DUOab3/dxmc0QZA
 XTnSAoeBd8CCCAzINywY9ASWVAFyn8Mk5IIZGw5pmjCnEAijUIKas+Rqq4UHf8uRofLI
 YhJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVZSsH0QknTPPozgcckbmO/ENNQzaskSnP+ZaZjMG9fnJYad0tzRuBfQROqGlsHH9uzG9WeTmgVGE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJednRTqseulzRmyAuYgOlh5wcOsthSDkopfz6G9YigvF6rwdCs
 WY1oPa4dOlxrppQQKQ+FQhFDx03mtoXGQv+G78KGwh1AJWIzz7q6IrUvpmDlvxKcJdatDeja5Wh
 OMkthOYEj4/VyinPxyRlPBoacgSiTuQME6wvWRjgUlaJeIO/KGPX2gocz+7R18FIkSpmnuUQ=
X-Gm-Gg: AYBFou3FV9fD4Rl1BpC0h9zMowhg2YmZXTNbWmZfj90nYvSQOXyN5y1Pik8xVtdDGH0
 bgBbBf6FF+EJStRjNn8I1keLIIj3NceMY4XYn3yNUD5oG3x+Xnf3IZ+kruYcjR3ntoqZ32nLIsg
 cJBkA13X8euELbFZCRr63XKKhI2ffA/AB40+htm/1ORFbkqSwUPwlh+ZWYNgiqxPapPxkyw+RcL
 4eLpGHv4r4Uz7cWPsBzg+ReAr3PPZx0AM30tbi34lAS/P9/mJB2/WOsWnwY1prb2WPnTI4iVo59
 VqnB1wCuTnD0N9+Dx/yjsXwKa6joqjrEbieQz7xxTjxwYWqT9N2+Wpbwk08cTiguonBECarPRJ+
 vKr3Yb7ZxDk5vy0c/zrVdyfGuA4n7msfIB5yU57uOIf+hJo2qMD5P7Wqt+hRAeQnt4V7lMD8RA4
 IZO7Zh5uYfTOiV
X-Received: by 2002:a05:620a:4694:b0:93e:d1d0:67f with SMTP id
 af79cd13be357-93ed1d01a42mr1036813085a.51.1791816520885; 
 Mon, 12 Oct 2026 07:48:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4694:b0:93e:d1d0:67f with SMTP id
 af79cd13be357-93ed1d01a42mr1036807885a.51.1791816520206; 
 Mon, 12 Oct 2026 07:48:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cc7689sm32134791fa.24.2026.10.12.07.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:48:38 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:48:36 +0300
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
Subject: Re: [PATCH v2 18/20] drm/msm/dp: Signal BT.2020 RGB on DP and eDP
Message-ID: <kjt7k6nrlctvykvqrlvl7ftjeul6woarmjcotlvdasd4u5jb6k@oc246xwutq4h>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-18-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-msm-dp-hdr10-v2-18-1835d4966da3@radxa.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX3h80nn05QPuI
 aO2vbpg6jpVbPMOfmqMdQCqj7pzXaAeDvkiGWtFBMT0HeadImxTECbXefqsH4YElfPsjP0XJ+zE
 E/5LqNCtOSszz2fB1k2lLXQLFFlZix8=
X-Proofpoint-GUID: u3fD0mOS8BWOMCDYAQFR-CrL0XNOAg9d
X-Proofpoint-ORIG-GUID: u3fD0mOS8BWOMCDYAQFR-CrL0XNOAg9d
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6accf349 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=ksxQWNrZAAAA:8
 a=EidWXHX74OIilm-ZvMoA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfXzIU2K+3hTOZ/
 vBgxiDy6PxAZ66Y2syNDmFhmOPZQWu40fc6v2yhKWokL1DxG+UjjGQmA6b1ioSryjxPfimDLDTu
 zd47w2KVIyFXnA1BqiFet1L+ee4LnV7QofvGu8zlrJ3RE1iZuuJhJePlKLfnWU9WrHaJvZU6fvZ
 vUduQ5/v/C/9ikiXzPjxk0Nl1ZjUY0Q+/JewfQ4Gi5srDMt+U1JTcLoA/vp0nHDz0YBEcUSvtvR
 zO4eslsSw8H+ocRdvN1Yd3VOvwLA2zB7C3RG6zKYnqwESK/yEa6L+U/sZfYE24OXtbJuOnzgBld
 s+aZOk0ndQ0H6xrbJlGdG1Hjo2lyZNIQsz0zDwStJlb9aJCafhlKGpet8E+uil6uPWR1W3vRMbc
 sFerrD78jy8sihpeSx4pBNJSTwV4sjaOXdRRALm7LODF82Llsn314/be9MBIeA2Wq34IjsNA+AJ
 IgkcDYL1/T09lzyjN3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120058
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

On Fri, Oct 09, 2026 at 11:16:10AM +0800, Xilin Wu wrote:
> Expose the standard DP Colorspace property with BT2020_RGB support and
> carry the selected colorspace in bridge atomic state. Force a modeset
> when it changes so the stream receives the corresponding VSC packet.
> 
> Signal full-range RGB to match the existing pixel path and retain CTA
> range for YUV420. Reject BT2020_RGB with a YUV420-only mode. Reuse the
> preceding VSC state, update and PSR handling for the new colorimetry.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  6 ++++--
>  drivers/gpu/drm/msm/dp/dp_drm.c     |  9 ++++++++-
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  1 +
>  drivers/gpu/drm/msm/dp/dp_utils.c   | 12 ++++++++++++
>  drivers/gpu/drm/msm/dp/dp_utils.h   |  3 +++
>  6 files changed, 29 insertions(+), 4 deletions(-)
> 
> @@ -456,11 +456,18 @@ struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
>  					    struct drm_encoder *encoder)
>  {
>  	struct drm_connector *connector = NULL;
> +	int ret;
>  
>  	connector = drm_bridge_connector_init(msm_dp_display->drm_dev, encoder);
>  	if (IS_ERR(connector))
>  		return connector;
>  
> +	ret = drm_mode_create_dp_colorspace_property(connector,
> +						     BIT(DRM_MODE_COLORIMETRY_BT2020_RGB));

Don't we also need BIT(DP_COLORIMETRY_DEFAULT) here?

> +	if (ret)
> +		return ERR_PTR(ret);
> +	drm_connector_attach_colorspace_property(connector);
> +
>  	if (!msm_dp_display->is_edp)
>  		drm_connector_attach_dp_subconnector_property(connector);
>  

-- 
With best wishes
Dmitry
