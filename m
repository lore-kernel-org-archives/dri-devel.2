Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3008F589B0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A45310F103;
	Thu, 23 Apr 2026 12:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kz7jLeBz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UG2gDf9o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC8610F103
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:45:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8uNub1565807
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BWsj0dSc6URl6GzhKqtvvsA5
 lvMVdCA8oRPUY5tXRI4=; b=kz7jLeBzJhutORDVFx2iCKLx6BbKBMv6ZD/OAzXy
 A0y9fL8VJ5azBC4WAyY4ur8i751/Cb6BI3cUXuKQsmwXwY34+fQJImLA7H/88D4v
 1BG5/aKfbFE/R3yiLswxqHx22LbWVldKcz8Z7n+9vvLF6H0umWX04940IYnC18qK
 tqpEoazA4Gx/aTQtT+TClBki1rUGdP2FhQ9RJS7+TJ/lTUY5IZeO+dCzFtwCvg78
 NWGFar9sZDj1b7ftpz2facMTIbdcJTW1sSKycWLMr7MmGIEbOm3qQC3OGbd5TyaF
 4WBlrARrtwmAMfi0rdEMVIqZqVfGqYskKA29CbPTq0GlIQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16wv2p3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:45:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50e592e833aso59304041cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776948200; x=1777553000;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BWsj0dSc6URl6GzhKqtvvsA5lvMVdCA8oRPUY5tXRI4=;
 b=UG2gDf9olD/PY+ygy9VvhWbp6Jtz/e2i5sWLki+30osjNeR3XP35rvpN0lgTCtmciP
 0PnXHkBw5jNhozXV305pbveNrdHFuRlNhuOcSIdrFJ028DbAGcLV90VHFLtt1UaFcgeX
 7tNjJ42J0s7Xf0PiveemgWdbuMccyDX9kvYjgmzNDpdX+MUX5ffj2iSPMak7oS8RpDAB
 fGztMmYlKqJgI+bZpL9o3PU+T1uWv2JtNA2FxoR2YVf1QyOavb1FZ1DbtIBK4ICpEmnn
 x0kTWDTMrLvO/D325MI8cb1mzLN3/kV2Tg+wDsIw5iujmP2xYRpEdRC7Pazc34xNikg5
 +BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776948200; x=1777553000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWsj0dSc6URl6GzhKqtvvsA5lvMVdCA8oRPUY5tXRI4=;
 b=Y2NiHV0W4lDXMcM7w0OVwnPmsKfqIXCQ4/4Wh6x3LECTIANz8YAveWYADh68Er1tZw
 1EVatVBQQRvLZPHRincCSG6gj/1qAkVdU78JXqFDIbMf4trL2/Gc7ANxURLZ6U21WuFZ
 9AzfOrF4ahPS/lRKal1LUve8aXvKTYkynAd3nPgi1pnUxYSA4nQGrn1UmiNRGy+Tbdgm
 r/tNsk4x4qcY2emv5wK2shb+eKSgDA837SAjdrmE7Kx6fwFaXtKY08jRLZHmlRkldkc0
 OTUsyKiXlc5OxL7OZ9i6wtC4Q26eYDQaORfuXLYWGf+tUaBumgkJLik3OC/aBbROaQRo
 tW8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QZ8C3t6WdIOErNsL15mMrGJ6gVcc6xpHf+6pt482F6n8HnrJq9xgV6tuE7I5Srm2vOhJ5vLOcyQQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEm/7qW+VUDJKGrWvg+yAjUsFHizyl9rRwqY+0om/e0esLOAEJ
 ymrVaA8KVsCPGSraA51CqHN9EthnVJ2StKZimcklKq86uoNeWG9e2fYJe8i/v8QViOvyNWAaWF+
 xSwg3/e3zwoHUGMR1UieQ5+eARGGTq9nzruCVfW4XyWai+Yd2CQtBzZ6GrWUR075UHZu+J+Q=
X-Gm-Gg: AeBDietFiadcul72C7gXcF3NhcjrxQXEf3O07UU99KA0iPrgJRdjZ2QFErWhlaRyY14
 E1u8+WxJM9SQ5ltmoXVRUenkLcE+OtKB+KfHQgcFk80si6BAku7NM5c4P09I4pMgKrK4XqngK47
 uJOs+1jSTmo7aZfxSsxXlLOfyPFG+XoFmgwaI2Rz9FlzPZMg9YEgyMbJa8dxNmrcu8SCDK/mF3a
 31Uy7+ktDZ/CvdvEAMVxMZjP8p9vhoRArKK2obZLDTPTnRLF6MwyE+omwc2apbtqnOooJ7R9zEP
 0yZIA2nQFONdM7IwU4S/I5TCqc4j+AAEeQ5i0DboBmuOMzEyS5nBBg47wzfx/VsnuEmQiz3RJaQ
 x2zeyjBJOeVTxXZLOMNJV1RuSsuyglircOaFbL7UqPE5HFC1cDXHb8dqmXf59kynHa3TamJsZ+K
 3Byd+LVgFrHcQokMbsrGSR9I7kc8vxP8un0cGVxNoyws6+hQ==
X-Received: by 2002:ac8:57c1:0:b0:50f:b6ef:e10b with SMTP id
 d75a77b69052e-50fb6f016cemr157722221cf.27.1776948199560; 
 Thu, 23 Apr 2026 05:43:19 -0700 (PDT)
X-Received: by 2002:ac8:57c1:0:b0:50f:b6ef:e10b with SMTP id
 d75a77b69052e-50fb6f016cemr157720991cf.27.1776948198942; 
 Thu, 23 Apr 2026 05:43:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e12d5sm5133222e87.41.2026.04.23.05.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 05:43:17 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:43:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>,
 Liu Ying <victor.liu@nxp.com>, Douglas Anderson <dianders@chromium.org>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, Jyri Sarha <jyri.sarha@iki.fi>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 41/41] drm: renesas: shmobile: remove now-redundant
 call to drm_connector_attach_encoder()
Message-ID: <kxltg2wx2zwuliguszipn3hldalok36finlqwxe4qh3e2mr3hv@ymc7gwkozlzo>
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
 <20260423115550.444930-7-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423115550.444930-7-luca.ceresoli@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyNiBTYWx0ZWRfX+FTFzqkDRwPB
 fvFIULEJgjQ/pr+QjMoVJrqJCYrz2Lh3fckG7wPzXkTFaqme2G9rE2vz5dCOgwXewZS/sUxs2Jz
 RcorcLIneKejb1krumgOOdeqJhB2XyhmK0c1sWFVds4zv9W6PzQuGrMd5CW2sCLLIlwHXEBmqBg
 cfg3xSIOMiLgSGBr7dLUTvrHbtiyT0Tn33xHvwhbr6RkBk5cmCIhtnzplJq0lhYm7onWOHXBlrk
 leK+1ikfxyLPEhcOLo6lWzRWKsQoKllrho6gBjA9zY/TW+tZwdUtxSH/p4qhPyhsPSYiUQhMTXl
 2e6aSgRpDMSrOMvZN53w9cis2S7NhQXnpNpCWaUIRJlyxY0vpYKzv6Q8Oz/pOwStTnzNtz7ZG3Q
 xzZh/Jmy1c+rFvUXjsNiJQFMSLUXrU83sr4Y5ug0nkgtfFYti73bXJKpFHnHTeIljJo7vdotoyF
 FKwTcpBA77OCfL+oaxA==
X-Authority-Analysis: v=2.4 cv=dL+WXuZb c=1 sm=1 tr=0 ts=69ea1464 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=P-IC7800AAAA:8
 a=W9-MdjkIhrGOmg5mk6gA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: jhyuHYY3zGti3ApGBzV3RbliNTcYacrW
X-Proofpoint-ORIG-GUID: jhyuHYY3zGti3ApGBzV3RbliNTcYacrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230126
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

On Thu, Apr 23, 2026 at 01:55:50PM +0200, Luca Ceresoli wrote:
> shmob_drm_connector_create() can init the connector in two ways, based on
> the 'if (sdev->pdata)':
> 
>  1. manually in shmob_drm_connector_create(), or
>  2. delegating to drm_bridge_connector_init()
> 
> Whichever branch is taken, drm_connector_attach_encoder() is called
> immediately after to attach the connector to the encoder.
> 
> Now drm_bridge_connector_init() calls drm_connector_attach_encoder() on the
> connector so it is not needed anymore in case 2 and should be removed, but
> it is still needed in case 1. Move drm_connector_attach_encoder() from the
> common path to inside shmob_drm_connector_create() in order to get back to
> a single drm_connector_attach_encoder() in both cases.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2:
> - rewrote completely, fixing potential ERR_PTR deref and ending up with
>   a cleaner patch
> - also wrote more extensive commit message
> ---
>  .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c    | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

LGTM now.

-- 
With best wishes
Dmitry
