Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E436072BD7
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Te8CKCwt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XeMfVk0a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B6610EE10;
	Mon, 26 Oct 2026 11:11:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBB510EE34
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:55 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt8782733524
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Yae7u4iPTCkVtrsNrlio3XtykQ1rkcSFoZWaTvI0TM=; b=Te8CKCwtC2Bm7wAV
 075aGMUOaqQaJUofzvgg4bXSfsGt7kbwDZ+zX1wNVMjvYGBGBxhGTMNvboDKhaeK
 0Q71MC+PkRCjKS0/nSVt78bvOr06d9VforfYXaLdet/RXEHiArN2sciG0qCBEQA0
 UkpXlF3c/LwDNtDmfGlhXurTMcgy5fEg8cjso1DDkqMI0OAbT5BC/a3o7A12QHuP
 fnZJOmHlJ6V5ygi2Apxn+O2mUyZ77hO0HNCsFaczuxFquCKqR/VfNy2HsqqSvMZq
 JLj6kTn8Igk/rAHhMvjPcGv0pNUdxLS+RfeomuBBUfkw0Wr0hS8s52MkmPb/5Ka0
 Y2wIbg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp8bdk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso104928616d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013053; x=1793617853;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Yae7u4iPTCkVtrsNrlio3XtykQ1rkcSFoZWaTvI0TM=;
 b=XeMfVk0abJlUri3RVwQbMVFbWWJdW8+cfN7nIQPR5g6ZVKOJYTahlRi13csaLI3F2s
 JKuXg4B3ZDmq4Yc3aVZb6HUFGfNkuj7fEa+KTB1fTp+onMKKkugsSRSD2OsYCS+d/RHX
 7tPSnaGJAnFyZdoVMe8gBHdnazcsQiaHKtcwBPdNyLTY8eeneixUkUjcN4LYbKmcB/7F
 aNca1zJ/kDBAY/AP6yfH8OHhUZbr/KbqwxVh62QUIQfE/vu0iLbSPnBegkS7N3u8hmCU
 JbobTjc3GVxHYsc1LybVT0JWqj+70heLYJWZFcBqb0xyZvagAu+7wsNpEaQf5f7wadYE
 21OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013053; x=1793617853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Yae7u4iPTCkVtrsNrlio3XtykQ1rkcSFoZWaTvI0TM=;
 b=0Nus4VB6JaxlIoRADzt0glzw0/2f42kf2ZZFFdzGbS4HXgkxIOh4GnQgG+JHC7WAb/
 SRA5YKQau26e4A2WlYvtULLEDMlo+F9kz61yqTjemA4ryTcQd5WnWuAchTM9b5UlPyBe
 kREdQ8EBw2qhK/BzxVeFEgdaPG0xfx+A5rFJ02mzRGgh8r+kxZhW0LxscCB0+Gk2E3Wb
 D8gAbLqa+qw0OZmibmwS/3jOszKVkEf1jogBsF08909mNA2rI9MXVTn+QzYgXL7Sj+Hx
 d+i/Ar8j5aok9yJOCNYOC8OiZla/I5Re8BfEMYsbzTDUxFTamg9cMM4M2ARsJcY93Lzr
 ouxQ==
X-Gm-Message-State: AFq9FYKKZZN9IXzBMb79NjuXpM/oM2L6tv+RFz9hANH2G19+MZ3G5puT
 c1yR0oq1b1OcLhdcgiN+/utuKc/N6NrDPCELt2rcTT57NSOFIpNyzgE7+H2bHOeXlQRe0LZu/hE
 br25NHZhuICXK1XzhbUDd/nAhcq6uVSOL8tp01GzcpUzc5paikFSF0w7Ag4xYzu1c+OYGg2Y=
X-Gm-Gg: AYBFou1P9g7Pvj53AwT4g2HJcqA09ANyxcqYI+5ZEGRzJIPASjYLNllwN2C9+ghq9V3
 dQHgiUfO3I9snZSvSN45IQbDJFPY7TR69+tm1t0oNNXbsI9pILh28tZrb5VIQqRwE5Csapr6D73
 S0vY0VaKXpZZWIBx/S1A/Xys7HDNG4wTGO9d9aLylQ0x+jS14dA0Ak6k8sg0Yr56ORDa8ZUmNPa
 VXWz4iHVMQWUows57CYqyh5F+ekv+/6KlSfS0t1TKAiRMz+BMMXszsYdIem6MSC29jnkLDNg7RD
 u0zpsFjkqFO3vdT6BkuDQ1+VLPWF2KHM5DdROV5Avx2gb1a3sGJn2Uqq4tYxnpWCia+Ez2YxDLJ
 YP4G867vn0Ffzg13cCYxc9Oni3atyfAhYguDMhJ6QA6n3QEm4DuGiyH53fBcmJFZJ6r3rCfbO4M
 JBNvG6ZWFPzk6M
X-Received: by 2002:a05:620a:31a1:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-940ef956c10mr863557085a.46.1793013053244; 
 Mon, 26 Oct 2026 04:10:53 -0700 (PDT)
X-Received: by 2002:a05:620a:31a1:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-940ef956c10mr863550085a.46.1793013052703; 
 Mon, 26 Oct 2026 04:10:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:10:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:03 +0200
Subject: [PATCH 14/35] drm/panel: remove drm_panel.connector_type
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-14-5e3070a3478f@oss.qualcomm.com>
References: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
In-Reply-To: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Paul Cercueil <paul@crapouillou.net>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Linus Walleij <linusw@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Alison Wang <alison.wang@nxp.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Igor Reznichenko <igor@reznichenko.net>, Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@edgeble.ai>, Jianhua Lu <lujianhua000@gmail.com>,
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 Joel Selvaraj <jo@jsfamily.in>, Icenowy Zheng <icenowy@aosc.io>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Junjie Cao <junjie.cao@linux.dev>, Ryan Brue <ryanbrue.dev@gmail.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Stefan Mavrodiev <stefan@olimex.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Robert Chiras <robert.chiras@nxp.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Markuss Broks <markuss.broks@gmail.com>,
 Artur Weber <aweber.kernel@gmail.com>, David Heidelberg <david@ixit.cz>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Yedaya Katsman <yedaya.ka@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2843;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=H8brYvr026sFwdBTY9RxWvYdlcCYPOlDmMVuJvSD6JE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUMaqizdITs0fda3O8tKBo3xGuCEiu/0xJEI
 ascQoHtgWKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81DAAKCRCLPIo+Aiko
 1Wo+B/0WDUqJzv2IDDyhx8xOzsIKbrawnNRv7+uNpMh8u5003kuuc17PuW0A21ddRPPc90JQBQu
 30YOoTNAl71shHXaRzstcHpab5AMmb1Vfl7kVdCyRzYmP/o5/OSuCwVRYyoWfmBZE7kR+bEVeNJ
 IvrNKFA+Hrrv0BIaMDEBIi0K7Rf+tioSmDTSX1oHCQ31fXHzctnmK+U/WK+nUmXK0GX82KykNnj
 gmqIrXn8z7M4wyfK/THNuJgQCeB6SlwdIyWTOPo0+m5T/E6DkqSJ69EBR7pFqvw4RXhAmkYBTs9
 iTwXcvZ/5NUsHwK1FDqsXQFKICNjNGOp7zHGJQxdaLXiWkIb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX4sApZZb6/Cxz
 wGYE7O37b8IN1sCdh+blRZojinLLagVle7YRqeZ8sWuWD+brwn6+29GeLJ+rkZ/ecjUw0i/yQUU
 jSYEqunf6nA1R6sZXjOylileH9s68zCxkakaB+DMDC/2kbzVS+JS4BWCIhrd8bgmv6s2/f2ehaY
 nkGHBAwpKacxxuITXZv97/rqbDD+5Jbiqqdy65eRmmCXu2KVO0Teqj3m77MI1bbiEx8WAA2t1iq
 kM5+Fea3GAR4KEU1qHbmPVzwrSnyXsUCr7imzDKXk/KrYH9lUNCRfMUZLALjbF2HOLUsmotbn7y
 /00OEUX00IwCU+YHwzSarwWFX6Y8UyuB2ck1L/s0kGSaTEV1RIHPrbtVAxX8LsgUE9J9ezipHXt
 Um4WSSRyXGAY2GKKpCq1w9TrIDRWkbye/sWoCmlC8qeLlQ/kkfy61sSYZE+ks678IWT9aMCz+tf
 SW28fDcKxfuupRzwOAA==
X-Proofpoint-GUID: L1NQeN0V_rPQnS6BajFss3Vy_OzNR21p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX/GeMlT/AaskN
 jjLJsBjHAlMv2/hu9Ix8Xv87v40xwJNU0K9yBAqk4upvlpqH3xWQoO8hzthuNcMnbCXLvVGITR5
 bHpZEd8s4fg6S+NPNNvlzYwfUikZRHQ=
X-Proofpoint-ORIG-GUID: L1NQeN0V_rPQnS6BajFss3Vy_OzNR21p
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf353e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=T6n4-d-I4O9jgBeP1XcA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260044
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The connector type is stored twice, in the panel and in the bridge
embedded into it. Keep only the bridge one, which is what the rest of
the DRM core looks at.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel.c | 9 ++++-----
 include/drm/drm_panel.h     | 9 ---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index ab701a526ef9..5bc97166bcb8 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -86,7 +86,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 	ret = drm_connector_init(bridge->dev, connector,
 				 &panel_bridge_connector_funcs,
-				 panel->connector_type);
+				 panel->bridge.type);
 	if (ret) {
 		DRM_ERROR("Failed to initialize connector\n");
 		return ret;
@@ -258,7 +258,7 @@ EXPORT_SYMBOL(drm_bridge_is_panel);
  * drm_mode_config_cleanup() if the bridge has already been attached), then
  * drm_panel_bridge_remove() to free it.
  *
- * The connector type is set to @panel->connector_type, which must be set to a
+ * The connector type is set to @panel->bridge.type, which must be set to a
  * known type. Calling this function with a panel whose connector type is
  * DRM_MODE_CONNECTOR_Unknown will return ERR_PTR(-EINVAL).
  *
@@ -267,7 +267,7 @@ EXPORT_SYMBOL(drm_bridge_is_panel);
  */
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
 {
-	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
+	if (WARN_ON(panel->bridge.type == DRM_MODE_CONNECTOR_Unknown))
 		return ERR_PTR(-EINVAL);
 
 	return drm_bridge_get(&panel->bridge);
@@ -527,7 +527,7 @@ static void drm_panel_init(struct drm_panel *panel, struct device *dev,
 	mutex_init(&panel->follower_lock);
 	panel->dev = dev;
 	panel->funcs = funcs;
-	panel->connector_type = connector_type;
+	panel->bridge.type = connector_type;
 }
 
 /**
@@ -547,7 +547,6 @@ void drm_panel_add(struct drm_panel *panel)
 
 	panel->bridge.of_node = panel->dev->of_node;
 	panel->bridge.ops = DRM_BRIDGE_OP_MODES;
-	panel->bridge.type = panel->connector_type;
 	panel->bridge.pre_enable_prev_first = panel->prepare_prev_first;
 
 	drm_bridge_add(&panel->bridge);
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 07612e9791cd..579b6be855c7 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -236,15 +236,6 @@ struct drm_panel {
 	 */
 	struct drm_connector connector;
 
-	/**
-	 * @connector_type:
-	 *
-	 * Type of the panel as a DRM_MODE_CONNECTOR_* value. This is used to
-	 * initialise the drm_connector corresponding to the panel with the
-	 * correct connector type.
-	 */
-	int connector_type;
-
 	/**
 	 * @list:
 	 *

-- 
2.47.3

