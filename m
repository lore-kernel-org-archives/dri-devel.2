Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60964F589B2
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB73010F0FD;
	Thu, 23 Apr 2026 12:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fFCmdbSf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/3zDXgd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549B510F0FC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:42:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NBwdKa009834
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7qCN6fA46LhWWbVU/958hHw2
 V513lfnGpAmb4yh0Leg=; b=fFCmdbSfyR4XRLkYWI7N0Tk+PjH+OUN5AhQQ62C1
 NejbCSHDJFuHdR9JsGONxsS2qNPi8uecZxrL5IALiMQxx+wQiNuphOJcfp5E8q9S
 fF/a4MG4M0jRNGEiAR8yWqA+IK3BZ9XAnUM2O7nHmiHv67WIFxlWGCcNYdaR9JyG
 nzaSHAyLLVuyd7ErqfQPNLn5fcEU2pkJybXPxN1K1ekb8qm9/LfmyLhltoKVJKyb
 +4bnEIEu2cSE4RDXfCzHHo8BnEhXG7ue92bfANCDf7pki1CvO7/Q8Pqy8y7BYNfA
 8hk/fetWEbNmajZGVeNgXM/fIq48KlUrsYscWVnczkm09Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqk178501-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:42:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fae95c82cso49414891cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776948156; x=1777552956;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7qCN6fA46LhWWbVU/958hHw2V513lfnGpAmb4yh0Leg=;
 b=K/3zDXgdi0aqwQ6D/QVP+2ZJdcJugqLZBfhTDAj8eU//kYb0V1l34zDmAfDT5rHwjd
 g/g76dCNtUC5tUAPmnp7tkmHnyn/cX2owlSzGiUzF1CQLF7z2m2uqieO9IoEMlP8FSI7
 CEVLHMqDLvoVcGqftWd0YWxujI4h/6zA3k63mLsZuYTmzOlSxC5e1IwgWgD2tlFY7e0M
 WqVjHHfJlPn83UdsccuqlNd1O41mT83NGPKx4Oro9yOfHuR+dDXhWMvGnMkPGSJkG6NL
 x/Bl1vkLn6k+XUmO3JKUquGGjnIYoMVF6WjPsWc82KXmvqQucl0UBpKCJaM0hCwiaB3Z
 59WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776948156; x=1777552956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qCN6fA46LhWWbVU/958hHw2V513lfnGpAmb4yh0Leg=;
 b=TaeaEcW/6b01RmQlHrnKcZHtRBBHenCeFR+Ttt6XApTzrzixO8MTDPf+livvZE5EN/
 cIQ+KmSAGlpphGt11MNQXMKLfjJF6h7y7GhF9NCWhnTcKx+mg3EABFkFJBEL2OtiLmRn
 3umird4X+Czk5apaYBlAi0QGuLzakhok0zlfRjhVJL5XHnMGsd01p8UKpZCKh2mXjLbH
 ZYCEMcF+1Onauw5nydhs+3+/X9+A9e+38IiMQfNMUDJJLNwi6BDcqMrwKsb5NHvYEk1J
 gXYN2cX0ByaKElpvBaZ+Wpj2gFmPtvCbO/JzQezaLv3rOwMJ6RjR+wa0llnDFIkKNIzK
 di6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mWxjqcZkWRa3ACvSQ77UgkpYnWsEVdZztvCfyD1xg/4lL6RE+AeKRPB8TFZrs7nG9I2gfObSTlUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9vQSv7QE1Uw6ggsJ8E6uHuCc7RIQjj311SwfnRgYJUG4v6L73
 6UeSBeY272HYkn1iDUa/KV4UnmwP3ZKSivZ8PvQpX/b/8r+zG8y1iJIXLmLgli1ZF693OFkh/0W
 ai0jnQcS4KGu7aoBNLcCF8nO8XV9t0bFIrhCLtRJpuF6zMWK2h7ptZpz5T7VZvGxiEiLoGSs=
X-Gm-Gg: AeBDievDWPWFc9BFe8UyVijqtQLBfzPOoVbJm3AShAiaXLoiSVTeJljIL0MEr3uCaHb
 oSMu5CzCLz8Ru4N52j+tchAZD/FFzZg9huTXk6DBcXbwNeb4/JSioRA+j9JiLchDQwBWgK2Rxl+
 yEZ/9HVc8AKuU+9pamnNZfu/LpZQYll+vQVCO/MgRiXpFnXd5yMiepJctWapYffWdmxbXrfrJqj
 kvNW/FAqKSrZYB4Ozqk0vNdkbuieZ2DIBBRIof8yrNtKA+NvEi3WS9TNBJj1IxCpQxfdaFtxHzi
 h9BZTbuDFbLG+VfKrpDCZ50Ns2f8N3yXB3b/GRMg3Lu4x/mIDLHeNytytuM5ZE/ID7NMmcPMMur
 usots27EoJ/MZ66Uqe6veOGUxslLrDXGOgmJC9ya+T9bCF95y3b0pibM/KbCKDA+6yG+/7sGd0/
 uZRVESMAyCZb7VD0y5uhSxpBvroqBbHJoUcPNzRzQsaa5DRQ==
X-Received: by 2002:a05:622a:1496:b0:50f:c2f8:406e with SMTP id
 d75a77b69052e-50fc2f8479dmr91073441cf.48.1776948156447; 
 Thu, 23 Apr 2026 05:42:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1496:b0:50f:c2f8:406e with SMTP id
 d75a77b69052e-50fc2f8479dmr91072081cf.48.1776948155831; 
 Thu, 23 Apr 2026 05:42:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e147bsm5123482e87.52.2026.04.23.05.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 05:42:34 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:42:32 +0300
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
Subject: Re: [PATCH 35/41] drm/rockchip: lvds: remove now-redundant call to
 drm_connector_attach_encoder()
Message-ID: <wapbiwxou64emxlt6oz5slst3nvcgvs35hvhpz7v3wmwp33bzc@mvdog4t7un6m>
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
 <20260423115334.444750-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423115334.444750-1-luca.ceresoli@bootlin.com>
X-Proofpoint-GUID: PgNW9o8XaA5-ZRuAk3I6jLZPh5neK9W4
X-Authority-Analysis: v=2.4 cv=R98z39RX c=1 sm=1 tr=0 ts=69ea13bd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=P-IC7800AAAA:8
 a=Gxjqsh2QC4DOxsvvGYoA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyNiBTYWx0ZWRfXzYfKiHWUbU9F
 7jFiTSK6Uyy+amfeIOK5Uk+5IssmjozxtWYYzUZuOQ9LwOeufdfHvDQOlIJ6FDsCwt38vKtlRw3
 s93LLJt/W84iDAz4f4GG0imGUM7QxJg5k28vy9SxFwmsMscP/GLScUcJpimk5QYCslclsKBft1R
 AKdm0P1OEBcnrwKbWA/YH37pW+HXiqjcGrwHu3wdaJhzMedKaie+wfW041Kfpy42WhpbUUrp9kS
 XBhQ67p6aK1qP66/Dc+ElAP8LQNQ4QE+FHN656lM4TRbjvZbzPOZC7toUnhB1y0lCy+jxZuQ6T3
 xPgHy6LhDI6ztF6N/QfypPcjzh/mlODDykfZ2vFEHYtnFFNt8LFEmLAb/xoW28Zk+OsyC57yAXU
 YYU9yT0DPioNVn+DekoiC8xC2kh9hObKLnV43W5iSJJI+eb9TUM+UfXRjGtMfkyp223VeZBpYmI
 4v1hYZ/CpKEMEjDZlzQ==
X-Proofpoint-ORIG-GUID: PgNW9o8XaA5-ZRuAk3I6jLZPh5neK9W4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
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

On Thu, Apr 23, 2026 at 01:53:28PM +0200, Luca Ceresoli wrote:
> drm_connector_attach_encoder() is now called by
> drm_bridge_connector_init().
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

stray duplicate

-- 
With best wishes
Dmitry
