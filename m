Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75ACF589AD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128D610F100;
	Thu, 23 Apr 2026 12:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f4KeQ6v7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D2dCjGy6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9548210F100
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:45:19 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8uJLv3413371
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dRf9flM23evHV+dCjZ11/3wA
 eY0NjlVmUaCb2MHl7Rc=; b=f4KeQ6v7smM+6vkjRyPOX9wXEYAtm4U3Svh9O4LA
 F+Ut9ODMjODxPNbgXzx8vYsDdabudfLWLc0zHnFv+oEKiz89nUOO2sQPOHS/+ZM3
 zQT6oMIVkCq5Wp4R3VTgnkYwX6xePFRT1MC0rIMz32csoNRax4q/mT6Yr/+zL+9C
 7OuvYNvRF7g+TmXzCH7lNo60EkNeNnDFHwVPY44uYX+2fEK1axSGxBuE/TKbVwb/
 fm24A7Rzdi8ERqvvgbrmTj90vCgNjVgjSS7A0elPrw1hQn9gGEzfn8Ty8iz4A8An
 nqvE0T5Xjg8h9sNYtk4IJbU+TIpW+LIBNd98FbPRTRXSOQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h6c0cs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:45:19 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-610503b689eso8222154137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776948318; x=1777553118;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dRf9flM23evHV+dCjZ11/3wAeY0NjlVmUaCb2MHl7Rc=;
 b=D2dCjGy63C7lPV192K5CU9mEPQrfUz0RefvSJIfEhnQrcOs279+Gc5piXMXhXoXA1/
 6CbaOeA+2OwtesmxfJrbW8iiC//HYWtjF256EHLqe2A8S7juCBfhNJrO8i1wm7+/1HhB
 2kw99Zmf4QEBnUnPY0wpZ+6Xt5INd/hbKNu+TMsxRNkCzZ3PQh7Re+qKJQ+/o9O/9tE0
 F8kIGK1E2ph1MLlOANfaS6U40HdQ1Er539fWfZtX8Co7SNsjVKrRJ8pnH9u8ihxdFwoE
 xtO0M1IbsZSTQCNzn5sjxQ1M1FmtswR++zknsTzrfbPrSB77YOZvmnZvlOE7HMBxXu0I
 hlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776948318; x=1777553118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRf9flM23evHV+dCjZ11/3wAeY0NjlVmUaCb2MHl7Rc=;
 b=Vvw1F0v0iljUh3s0H3z2sphE3UpPZymggSQgsWH83JOIRTpOALIvtLoTbe+lv9jq3f
 G0W6CEoNX43CpKPFZ3SO5Hzhb2utngTHDI9vWr8lwxRdpnqCSyr8l371+lfjhjhTtyJP
 QSSNF/3US1Bn7HAVFLx5YkXaNHcXzE7PlBxSYyZsvheLKN7oemOi4Hcdtep+VVSShFwq
 afqBMZKi4wiPg4XbfH98i1lHt3okx05YnJ9aAG0sCOYHlPUR0LdRruZ1AfrX2EiRuymF
 ADAZclzazEpj7nAA5uwyaw47o4u4zxjwN8JIDAL3HCu4/n9NCSKvT/duWqmydcbpf0zM
 uzEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/u0uDnq+mVWakiH8un8IfiJIF68KAY5oHw9MPm6XWk0tsGeulhEEuBRV9p/y7ZdePdDsHXWUASVZk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw63t/IvcQg9vzSETdd6QhD1ypxk43wlWsKtBgdTKLyoVawQDhS
 Nrd0mMGX2vfzHSmcz1bnnbqPONgn9+7w+DZeOQ/+yOHBHg7S4H/ooQjEOad/2L0LwbHttm/c6M3
 0/1RLvcp8o+zgF4Y6Tffbx/hOixvLBF+QMDiDyhdbsRSEiCAUhYVdvhy4gufVFP/sZx/Mt3c=
X-Gm-Gg: AeBDietzHXiFk+XD5mRVBPLvd2Q1SZ1ovoDl7jt3Pfh18XWabxdNNNp2jKkTZi7cVxL
 2TxihKilajP8c309xkvnbvh1JOTjfeUGJX0BdJesjB9Xf32zXqw2uwqQwfx1FzPfr852fvALRg4
 q1wwYqZ0qn+XOf1Wu0js5bYHYhDQ7Hp8sB2XgzUsEFQUbw/bajVOvBOfgC2p3OeD/4vW9VVQi99
 RxARTceEMnU4v1xTLldYeZFX+b1C08T3ntxww8DnCPAK0BcIAai+Ue6mRbaTGkp4ZxAUzWcnC4Z
 sVzS8LXlkTy6fXxQCkd0fsbem+RskxoahOH3GlW77cXA7RyW2yFVc+2xkHsWpcrSvykJCpquqsj
 S8YGNeNl+QlZfqFgMYc/8PFEAvhHoL3ftK/w4gQRzBzq62CN+so+N9xnHDeyV2ogccijsKg20h+
 17PDfcyDkiFsb/sQkQXFI7/YtVWHcEFp3n4PTIWCQW4MKCJw==
X-Received: by 2002:a05:6102:3e0f:b0:605:19ce:9ccf with SMTP id
 ada2fe7eead31-616f58af7d9mr13838634137.13.1776948318015; 
 Thu, 23 Apr 2026 05:45:18 -0700 (PDT)
X-Received: by 2002:a05:6102:3e0f:b0:605:19ce:9ccf with SMTP id
 ada2fe7eead31-616f58af7d9mr13838537137.13.1776948316554; 
 Thu, 23 Apr 2026 05:45:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb75b033sm41855241fa.39.2026.04.23.05.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 05:45:15 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:45:12 +0300
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
Subject: Re: [PATCH v2 00/41] drm/display: bridge-connector: attach encoder
 to the connector
Message-ID: <wanzalswb3lez6kyklprqojcnidab5fkxgu57lfka45w2rt4ic@xdatq5o7yiub>
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69ea145f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=SkVVgs_SJVxU13IceqMA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyNyBTYWx0ZWRfX0jCLdDXB70IF
 pO4P11Vd5uuAvspzs7xQgFkjLh0mUZLXIsIMgxPxLH/3b11Zox96yNCTSHHjorfYEZaYL/nDfqL
 YFDBL8xufqrr1vHEU6VV3m9cG00y6IzKvcuVcMDWkhi0MfCl3+axoee/QJpq5E2chYBDN7oLOjz
 w4cLrF+tfge8sFakbVvLuinZZTo1tEw4Eo79t05AMHRESyIUu6OHiaR+cePyetJJP1wEjR9MbFB
 cpNz8is4uCD4Z58SH65AnAAkWUzGa13yerreDxlHOHphRN86duVGJGX7wXsAD8P63/YQkOYtEdE
 nkOYRbWHC5aShx3nJVFJfHdygEWymkmqIp13fPyLCiWxBaIoTC5p3Iuan3l8ARl6PgU76aeLgBF
 /POF0OdpBKqZDHjrnC2TKv2kEKB5OYiK27GyemKCR4l1Ui6gBCJ/JZZWlHM+Npy+aJnTJjMqPZJ
 fT78v843cqDIpKbWJXg==
X-Proofpoint-GUID: dOf_OfFxdpUHz64gaDsWfCLONkBJtzGc
X-Proofpoint-ORIG-GUID: dOf_OfFxdpUHz64gaDsWfCLONkBJtzGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230127
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

On Thu, Apr 23, 2026 at 11:16:54AM +0200, Luca Ceresoli wrote:
> This series simplifies using the bridge-connector by removing the need to
> attach the newly created connector to the encoder.
> 
> == Series description
> 
> Currently all users of the bridge-connector must call
> drm_connector_attach_encoder() immediately after a successful
> drm_bridge_connector_init().
> 
> This is an unnecessary burden for users. Move the call to the end of
> drm_bridge_connector_init() so all callers can be simplified.
> 

I don't know which one is more correct in this situation, but let it be
R-B for the series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Feel free to take the msm patches through drm-misc-next (A-b).

-- 
With best wishes
Dmitry
