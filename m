Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E7606B96B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I+rhtZ0u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=brbDLORs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00CE10EE15;
	Mon, 26 Oct 2026 11:10:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C947C10EE10
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt2sJ3632933
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M2Z0RCPtboYFZ+IjaCc+zjd7qHKNjhm/LRlubdPohDY=; b=I+rhtZ0uENob/eM6
 rPFxa/Lxq/hRo634DX6rAq2ZBsVROCaRhUBCwfOpvUSidtqm1pMdnTIICnBeAQJ6
 9lCqPVosXfFpkxSUDqnfjw/1DbtEOM+eMbulvKMRIU2/KwtfqROsWmSPi9d/h8NW
 gFjnc5H22kumYOcEUALN5IlhQScuSpHqbEqkXTeQbRHcPwZrVhAFISMnVvHi2ZBz
 XyI07fF0J3xyiSqoyWSz9EeaN+D6vYmludcMOjXHOYJ488n6Y9RinkEAOf8/WdTf
 v4EmQKlNrvvXX5CmHQRK5V6ByNyIpkC3n8Ki4C++uqyCOH5Rdix9JEzciaYHIaSu
 EbLNSg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf07ey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f568dee56so412006485a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013022; x=1793617822;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M2Z0RCPtboYFZ+IjaCc+zjd7qHKNjhm/LRlubdPohDY=;
 b=brbDLORsrfNufxC/1D7c7w4BtT6bMnOwiVKix+DyoqnUtlq/YmLL5bnWGPBM0DftD9
 XAdM7qyscnf14XL2Z9WwCn4WXmeREifoXn1j7XtOYd/bKGcaj4/EgBH/ZCasSD3LzIhp
 K6MwhOsNJEAxN9mGkc9l50NnMfIJmk8chzc/HHsl5HhOlPZ8s9vayCrVRvY7PkM5c/f7
 RNi2vHhHHSSPSleqicUqGv1PB5ya3x4XBHqCQ3oXxiia0ceKeNdszsTMA1LkgEYdQaeH
 8qT4pLMSo9o3hZqWunQNmcj0rc/CsyncICJjrTZBp1cEiXKNtRemyj5K+VISwnotBoRh
 H3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013022; x=1793617822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M2Z0RCPtboYFZ+IjaCc+zjd7qHKNjhm/LRlubdPohDY=;
 b=vYFWL9tWX1uwAt6VwD3RXHy5CfuGkMao9iI3qov7anago7BsGC7IUesa1itwQGM9k0
 YdkkOQY6SmcPMACepfSH8CZMx4CZLgBdERfn9Wv5SgFkVpA2CHE4OjR/fy3FGEvXCKiO
 wm6k+Tqqjwnhv/L1GOa9oPlE6TDxUWo6KXVS9MXZrHXuGJsNsrehrFpSwumUr8Hhl0XS
 SurxUGxul6uwQSLJ+dx+mFWfIVaxSY/grtQTrYw7NXImdatBb7227iwmw0bQ04CKn1kG
 a5ONRPpfWtQx8NYIdclkDAhFBOo62ojb6V2ww9IxwkbRugThqE6AleAAJtWSkJZtA3To
 Wcjg==
X-Gm-Message-State: AFq9FYJ8gaUg0d+wYtbNqzT77dEKySSdLaGt0ZzofOWvFoZy0gUOQvB+
 TmkOozAznWGm/6UsiTkfr3fz5n31lcUNrdgoSGlKMBAr8NEvAsCW17XPCGuSB73HLX89xJFHXX2
 fsG7nU92v4eTfPYSCWXjvldg5NsJLL5oFxRhd8UlFpU4L5uris05DElzTyICpjIc2Y2V2+qU=
X-Gm-Gg: AYBFou03KDMNpsYlxHvOY/uuHX7LNez+oKZ1qzCSOwRw9V2mqqmC41Er8KfWWD6FSv5
 Vpxd+fu7SplyR5bG8MNqgnM6czBTspFQRRoxy+Y9cGcPd/vmzxFyjf7WNhjkZcLdF0KSpTL7dA9
 y2oDehXupKEmGXp9ufEQDx9sYHjkFxlXAT/TOxMKnYcKkpkPc138x4ULrdpnon6xDUnDQVuF6h7
 2VVDgThT09Yuke8dSLgdh6686PR/zVDAr6pOzIGryEcSFPH5KoEjNigKJp+cBQgOGqI+xUzz1QG
 KcKJdaojHYDdAtiZNGHpT7D9dirkXuQ5P0lASuWJOtexDB0RPjC4gTQqBYtjy1bkLW0w/m2R1YA
 xU7/inQw7ar7ZmJFeiewHpQUPlu3AxVY50pp2dRlMAE687nTk5MqqqJm6KZhwBD8A6jYFyF80SK
 6FsuJKF57TUxbC
X-Received: by 2002:a05:620a:4515:b0:93f:22c4:e92f with SMTP id
 af79cd13be357-940ef90f7dfmr883919585a.54.1793013021170; 
 Mon, 26 Oct 2026 04:10:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93f:22c4:e92f with SMTP id
 af79cd13be357-940ef90f7dfmr883910785a.54.1793013020579; 
 Mon, 26 Oct 2026 04:10:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:10:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:09:50 +0200
Subject: [PATCH 01/35] drm/panel: remove the get_timings() callback
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-1-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4897;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QyWrgkY6ZnjVq5h1vZAiS6oNrgNf9gieSUM/aLO7szw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUFn2LL/a3hpHcwUKprTutBJKRl30JANmhZI
 0sNo9qgoQGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81BQAKCRCLPIo+Aiko
 1QZ7CACHPPW5AOWGSWzAkI4CS6eiI6km5J70phewHDz5Me8KZKsKWKw1PhMGtKDYABWXJwZXprM
 w1Mwd9MLWmGKuMjvgeaX4BeaBWHIE9lqWcZAtAP4hPjvlewyNVCHzjfVPcHKj2bonTPYAZjLyY/
 Kdm+x/ZpB27J3/76XA9ckLf29X3++gUnrIeLIWML9atz39KUXpQjHWpkY7+9hWVMrSjbh9ThgFM
 cL5NwHUlDYhgA7cwESIzgVIe+Nd3mxrmtqtqcgMUM/W3YqRnhngxGcvEyfeJXucilRevgZN2w9p
 9t/l3xlE2Eo7+p7jGCAPfnMTN331Xx7JQWECasKBfom/i3JO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX1MGs2ewhiG2k
 6ABzL6CHKR+i2JqUG++Hr+OKzMp135lkcPLnarEHbc6TkQhA6VEjA6KymWWSd8MZm9Qgt9j7Cw8
 4iP8IFJ+cei0P1wHkon7Jpj+3Nd2J3Y=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf351e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=6bBJhzG1MskExv8IbyMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 2MlnaSbYXbMzYIDtlS7nc8GKcxS2wtaj
X-Proofpoint-ORIG-GUID: 2MlnaSbYXbMzYIDtlS7nc8GKcxS2wtaj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX9U5Jd6P2iUk3
 TAxq1MS2Xk6/JtodSccS2hVpclp+69GDt8HkDoVZhhzpBVBehdW9Xiv4tCLlO4hJ+miZuUZiDSw
 9FbaYCyzsYHNyQ9yBzfmBsEHZa/47N8QIJ966zLzeajo+S+qw44pIoZK1+yMGAZc9aHRtg8L0rC
 6/wEaMaBKEFSj2iYoIGyr+G2ow02WKzhoCSzm12NziJDWfVTN8XLCUQmTKj48sK5cv+nDfiZzGY
 0C8T+lRE8MM5IDgl6rvNE+7PxRCVUEC3pybWuQi/aA3F29Mlc2w+XXpFBkNS5jA0WvIVQbUj7/w
 +E84NqOOXRBJ5LgrgmVok2Wx/h4KpYbwX2aeyii9ahvHZ2xU2GhcHCqPuX2EwHiNdsnnZo/o1UF
 mr7Rg7UwZlCxGtgoi817wIhfNFwV7+WHL96ZL0BLi/oc5j/DPdLvf6wb0m+gqyORPrswHUJVZ6G
 g/9l60SDjEhAY4iDbNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
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

Nothing has ever called get_timings() since it was introduced in commit
2938931f3732 ("drm/panel: Add display timing support"). Remove it
together with its three implementations.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-edp.c           | 18 ------------------
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c | 18 ------------------
 drivers/gpu/drm/panel/panel-simple.c        | 18 ------------------
 include/drm/drm_panel.h                     | 12 ------------
 4 files changed, 66 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 94bc54c3833a..d3a4cf9b1760 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -646,23 +646,6 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	return num;
 }
 
-static int panel_edp_get_timings(struct drm_panel *panel,
-				 unsigned int num_timings,
-				 struct display_timing *timings)
-{
-	struct panel_edp *p = to_panel_edp(panel);
-	unsigned int i;
-
-	if (p->desc->num_timings < num_timings)
-		num_timings = p->desc->num_timings;
-
-	if (timings)
-		for (i = 0; i < num_timings; i++)
-			timings[i] = p->desc->timings[i];
-
-	return p->desc->num_timings;
-}
-
 static enum drm_panel_orientation panel_edp_get_orientation(struct drm_panel *panel)
 {
 	struct panel_edp *p = to_panel_edp(panel);
@@ -699,7 +682,6 @@ static const struct drm_panel_funcs panel_edp_funcs = {
 	.enable = panel_edp_enable,
 	.get_modes = panel_edp_get_modes,
 	.get_orientation = panel_edp_get_orientation,
-	.get_timings = panel_edp_get_timings,
 	.debugfs_init = panel_edp_debugfs_init,
 };
 
diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 0935d83ee2db..99b3895a1b28 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -174,28 +174,10 @@ static int seiko_panel_get_modes(struct drm_panel *panel,
 	return seiko_panel_get_fixed_modes(p, connector);
 }
 
-static int seiko_panel_get_timings(struct drm_panel *panel,
-				    unsigned int num_timings,
-				    struct display_timing *timings)
-{
-	struct seiko_panel *p = to_seiko_panel(panel);
-	unsigned int i;
-
-	if (p->desc->num_timings < num_timings)
-		num_timings = p->desc->num_timings;
-
-	if (timings)
-		for (i = 0; i < num_timings; i++)
-			timings[i] = p->desc->timings[i];
-
-	return p->desc->num_timings;
-}
-
 static const struct drm_panel_funcs seiko_panel_funcs = {
 	.unprepare = seiko_panel_unprepare,
 	.prepare = seiko_panel_prepare,
 	.get_modes = seiko_panel_get_modes,
-	.get_timings = seiko_panel_get_timings,
 };
 
 static int seiko_panel_probe(struct device *dev,
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a944c34642dc..e4629428b1b2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -405,23 +405,6 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	return num;
 }
 
-static int panel_simple_get_timings(struct drm_panel *panel,
-				    unsigned int num_timings,
-				    struct display_timing *timings)
-{
-	struct panel_simple *p = to_panel_simple(panel);
-	unsigned int i;
-
-	if (p->desc->num_timings < num_timings)
-		num_timings = p->desc->num_timings;
-
-	if (timings)
-		for (i = 0; i < num_timings; i++)
-			timings[i] = p->desc->timings[i];
-
-	return p->desc->num_timings;
-}
-
 static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
@@ -436,7 +419,6 @@ static const struct drm_panel_funcs panel_simple_funcs = {
 	.enable = panel_simple_enable,
 	.get_modes = panel_simple_get_modes,
 	.get_orientation = panel_simple_get_orientation,
-	.get_timings = panel_simple_get_timings,
 };
 
 static struct panel_desc *panel_dpi_probe(struct device *dev)
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 58113ea7d63a..deae4753a594 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -40,7 +40,6 @@ struct drm_connector;
 struct drm_device;
 struct drm_panel_follower;
 struct drm_panel;
-struct display_timing;
 
 enum drm_panel_orientation;
 
@@ -131,17 +130,6 @@ struct drm_panel_funcs {
 	 */
 	enum drm_panel_orientation (*get_orientation)(struct drm_panel *panel);
 
-	/**
-	 * @get_timings:
-	 *
-	 * Copy display timings into the provided array and return
-	 * the number of display timings available.
-	 *
-	 * This function is optional.
-	 */
-	int (*get_timings)(struct drm_panel *panel, unsigned int num_timings,
-			   struct display_timing *timings);
-
 	/**
 	 * @debugfs_init:
 	 *

-- 
2.47.3

