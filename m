Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB67F589B2
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5879910F0F3;
	Thu, 23 Apr 2026 12:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eC09PN2i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SiZ0H9Iq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808C610F0F3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:42:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8trZT028818
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nPbpkNj9ABhjGDGvKynwI0Mf
 HPrmaa9hsgMYHe0+7+Y=; b=eC09PN2i24nCZriljMh8JR/1ApJQAbNzTeI0q3AJ
 ecYJiOJZrZDmKs0KMclx5mM5sSs8rMozaTP5vcHDvT6EfMr8LxW+x5nNByuVX5p7
 0uUBmLUzk6EA4s/nXj7aqxxQ1tinWuC2x1wOaVAMZq1Sa2VVoYq1weIuCjZxa3tu
 rhcKGUnyeKVxQZozsBCCOeMugfw36mfVVMH3UPQW1yW5HYB/X+81gylFHiXPKmkd
 tsh9Aj5mT3OOS8YrlxbAJ+oZ/Hnm54MGwRs0gB/1MQOxg9xz6RvZyFyFinuqNOR9
 QAshNI31RpsjkNwnbsfUoVnHp16VxLx0svestX6bUeFzVg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqdjm1j8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:42:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50faf575af4so89822951cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776948123; x=1777552923;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nPbpkNj9ABhjGDGvKynwI0MfHPrmaa9hsgMYHe0+7+Y=;
 b=SiZ0H9IqJ1bNNUXk3bIrMWuuicabvmryWKUynmLspXDZmodG6oLes63wQzZK5hbqlB
 HdQukdCsGPfqacJCgtSENxsn4pMbd8hMKERvYz85lBzQdCLqWspAiaLUddb6Yz0oG6x4
 E0SLjq89bNc80oL4GR1LJfKCd/0SuWqyMCVOH0LFvIInCRS+Y2CXKildkRHBuDn3WE0b
 woFJOV/6H5PoqVEoIHqz0BKT5+Nl0V74ACsTqGSU07+vuNr8rkquFVPMk+j9vMnIJJrX
 LXqgCwNINUc51tOUz2STJY9HY+O9CsqoAZeBRmWlcq29w28dgt4pKgML6ofDNoB1txLJ
 Ki6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776948123; x=1777552923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPbpkNj9ABhjGDGvKynwI0MfHPrmaa9hsgMYHe0+7+Y=;
 b=pZ+h4xlOPBhox6PWQjOL1E/TQFBeS7Pd27BRzy2etkZ1aSOfn4MEYPJPYQ0qRg1m6X
 +VcDolrNVU0xvxsBOGEsxH61YJM6awstaDDB3YhqKO4r3zyhafw+Z7rk+v6WzepCl1dV
 ge5r6oQ1KgyErfIDQVKTccSXG23ZL/9QEE+cCWTKFLIJzvuHujYa93zKuFifwfAGvy2r
 4AouYD/N52hKoEDUpm00CT+XxB1wPvSAs1pBUI19Lc4aZJ64f3pEfVY7J70eJirM1ekr
 4y7kuCIaf4xjpqBzfXJ5vSh1O773/8qiwBo5P3PxzXQpGBV9fZymXnnz4vqGEopKmtb9
 JAVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9h5u6VaeMnDtGgHpPBVarskiw3LbVsJNDRPCNNTs0N6O7KbIAngdtFFPgXjF/H9swB3rBgTvyJ4mw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzznYMYvsPjOplmEW/pnyc3E25YWfevVW7Y1V7E7UO0zYqXusD
 ylIlGYmQu/7H0prMYnmK/1YYn7ImYvSbL11yO5W7qXd+TnbSGcp3y5abU+Cyuy1MxR7i4K6BE3i
 D1eH6OXt3DLrXNxNdGz0dfpbi34R1gt6GVLkyjgxwku//D++tTnmVY/ma5aUqvEhHyHOwPjI=
X-Gm-Gg: AeBDieslNSBKpYnMV2JPJae3Q/dXino4s5WGn59piDCE/Gnd90dzb9hF1sGOUT2It7h
 Ly6evonzWa+GUKwlYWhTyzW754njXO4+sAVC6BQtJkKbqSgQwBed+rUBy/fBvEnZtQwZzGs7smE
 L2/bebY0556e37EIrbR8DHSPguTj3HB67DOyaFHTqnY3x+rQG0BHX6xCtyzbHxFY7xh1AWUA3tV
 vQq/G52/gmqkD23H+I4or7xbAiS5F8NSOKG4GR9pb9unNNkONoaerfmmh4iNxU7Czhh90aTFrUJ
 tELW5pGONu0TWTae9dQMEobj2Ext8YF6/Z0kfzAxXD0ZHO79gI8Mxev+FZrP6K2YvR/k7IJ6v3b
 SBYcKXXPD8QbeboJbDOFQwc7fTdVJe7JhlMB2yv7rD3/M9/YHa2qpCant6lDc+Ogqt6p+7zOtXi
 AZZJcymc5EDzZl65P6nMfqIOl44LhYkqFGnURusYx5gTgbGg==
X-Received: by 2002:a05:622a:17c7:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-50e89e92b67mr230996351cf.17.1776948122948; 
 Thu, 23 Apr 2026 05:42:02 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-50e89e92b67mr230995701cf.17.1776948122428; 
 Thu, 23 Apr 2026 05:42:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc240sm5134146e87.23.2026.04.23.05.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 05:42:01 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:41:59 +0300
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
Subject: Re: [PATCH v2 19/41] rm/rockchip: cdn-dp: remove now-redundant call
 to drm_connector_attach_encoder()
Message-ID: <lxwchrttkseoqo4e2njsyvpgingwymabvgoqh7xmwd5ysie2dv@v7t5q4qelqen>
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
 <20260423-drm-bridge-connector-attach_encoder-v2-19-2ae6ca69b390@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-drm-bridge-connector-attach_encoder-v2-19-2ae6ca69b390@bootlin.com>
X-Authority-Analysis: v=2.4 cv=EZn4hvmC c=1 sm=1 tr=0 ts=69ea139c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=P-IC7800AAAA:8
 a=Gxjqsh2QC4DOxsvvGYoA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: APW2vs84aEcVP7Bg90VNkIBJF6TySpgv
X-Proofpoint-ORIG-GUID: APW2vs84aEcVP7Bg90VNkIBJF6TySpgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyNiBTYWx0ZWRfX4358J07wFAS9
 7u+qqJnp0monRf/X6NUKnD7hGI1VFOidrzreJGn7wvctVYoSO/kOPfG/2HFnsbsrvDLZvfUzuyy
 mU7QMhYlKgWit0qgHAQdy1RETyl23q+E3AfcFtmrpRQ7L84hADLcSmBcSDPBLR88wsSsWB+kpCj
 DRaa+IROa6EzL0kAd4Ha23lqmXfJBX7iOZW1GOClQkkz7Vc93sfLrDItqm4PuEgIkMSDdwh5X79
 wNPMHvptyWXMjB8poTaAegkwVQ0RVDcAzoXF8VBlUtTSyQSbJO4LYRbktBR5L4yAtt1iZAs5Qy9
 WKjyjhv2j5XCgZUSxHb5cqorBPl9q3JAC9cNsAaCZe9tgTBE4oOe1t49vXBEreyvHORvEaLuVYf
 CyWFsMX/ruFsR/M3MD4BAle71wU8g0YiNrjbpoXELoXaAHPu7zX93ax6FDFVDmQgC3G7PI/gfz0
 /PoqQspBW/rqy7/krsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
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

On Thu, Apr 23, 2026 at 11:17:13AM +0200, Luca Ceresoli wrote:
> drm_connector_attach_encoder() is now called by
> drm_bridge_connector_init().

Nit: there is a tiny typo in the subject, but it can be fixed when
applying.

> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 --
>  1 file changed, 2 deletions(-)

-- 
With best wishes
Dmitry
