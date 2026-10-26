Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60F606A970
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NT/pTjjt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E351pZo0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DC510EE11;
	Mon, 26 Oct 2026 11:11:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2FE10EE34
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtNVl2009947
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dg5zkY2HMaN3S1LQ7C2wxwVeSCWjIGLxXjphKAEg1Bc=; b=NT/pTjjtrT8dYnjF
 WH6qLjW6kx2wD0tAa1EQLt5mJoBFBC278Sstl3FzSsSLBoPXgMOCnzIX09ifooBv
 7pkRxd4fS7XPQ7JUM4NjjZcmJx19Y7WHU7i6jtMBXYyLPC9T6rwbv93In7PMXpzi
 QPJAkI+be2BxxA5zI5XamOE6r6O3Kr5HDZwTNTv73jT5VrWnsFJ77Yi5yzqT9yFn
 o45rm4LsQsYn7vmIWTjo6iqt6X9ZYuPY0W1pF4CdJNLN/FLKlxEq6LFKnF2+K0UB
 5kXQZ/lskryTSgbtibVEeNId1StpbWSfS21DPbH0l2PIcYPWxAp1dLnqntim7WL0
 OGOMwQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27x2w5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2c0e6653so274722185a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013077; x=1793617877;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dg5zkY2HMaN3S1LQ7C2wxwVeSCWjIGLxXjphKAEg1Bc=;
 b=E351pZo0btga3xl2PDOG0IQdrPjjGcNKx9srvERge0ucy6JKsjwTm6MHIXwYp4vOT/
 jPQ97it9HJrsL+G97S7O+XshqyJpUalku4MJ/Ji7phC8+kbizoObE0FXfYnwF6tk5T2b
 oBXrmkFBPAU3bV01PizkiBZLhRWcm/hDXz+6k7bCfJBNnnBgKvbx5v1WmJM8Gl9V7Y//
 LdO3eBu+ai/IyptSCAujXlHFS9gJ+hDz2/2nX7K4ruKMP69u3Ozn057pJ9o3+2YuOB4o
 4LrRxFQfExiZwKP2KCOisulduj/wedD3iTwJ3LFE80jOSc5ErSSiB6HkWUq/vG30aJ7L
 m3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013077; x=1793617877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dg5zkY2HMaN3S1LQ7C2wxwVeSCWjIGLxXjphKAEg1Bc=;
 b=COX/Eoxpu+9+RDahA2YOYp/2poxAWVyQF9ZGsT4huY3kQ1TBEJlrJT9Rg1QYO4gezz
 KeTWcqed3M7+MJfsCnOda6rZMPqOsqtbJwn4OBNhhBnHaPaWt3rOjTFn0EC3sKPObzos
 CXPbJiE3V+nI6mKj9VmlDWZG0JMw0BhArz16EGwpXeKx+/Se3TwKbbUEOFYmzsIaValQ
 Al3G3111/h4pZZpC04G+2e+DRuFBGDgTjI+k5oHoHAvosrmN3kYiZiIRj1dTnQzWn2mj
 lQgL56Cpg0qQRBsThtf1kigjg4neR+i7V4BBCH/9919w3JTJjDMJpK3k2URCyjRGIGM2
 nh0A==
X-Gm-Message-State: AFq9FYIvbgBRTBMrZQpjkw7IyaE3bWqcWk3UVAeOcRopz707wayaAPN8
 CR9S+3BKoMk6rfYff9KgAAKOsQZWSa/ERNJegbB/zCPHOAu59nGcPCSSA/XbLT2h2+7zOsd6OZo
 k5PO5rKfaxxzodLgnb//agAkF4F+gyjO+4/urr7wS1794l2JWVquWWjYg1RM5Gyx2wGuQoiY=
X-Gm-Gg: AYBFou1buWP6H4O5WE794rP3JzEU9oOGeZJb9RvFkys+WuQaibQ3vHd7qRW1il0ZqnV
 0OOPBA2Vxa7Y/z9QHUikFKljsI2mTK3qCGRkDjDuEcnLItwIWyL8/so+glSHbIlrZIH+Kejugc9
 FcCh1BlsUEqNaahIBvH9gug0xS1D40p4NK7AxZUbM9xgjO7gu6fpOZKjRAhORSozF2d0j56D+5w
 fKVJNkwOsN1OAb4R/MR+zuVfMmcSnNbii5QErDTjPBkcuovz7pCPjd42bpFhICvMjCQEYjG92vf
 parU3/zeRSZLTYps3N/qlMa0w/3nIC/e0SHJBNbnZtdcOzRORvSMFhRC1/4s0WVdsNFA3kaJan6
 ZC+6gqJle7pdB+GWfw9g7eDVhkENqLokCZmtVGcSdVDX4mpX0nxBCSuZXr8iKk0fKVEOQyHON0k
 BTyh0x7mRJ6VSr
X-Received: by 2002:a05:620a:261c:b0:93f:707f:28d2 with SMTP id
 af79cd13be357-940ef8aed1bmr994267385a.26.1793013077000; 
 Mon, 26 Oct 2026 04:11:17 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:93f:707f:28d2 with SMTP id
 af79cd13be357-940ef8aed1bmr994262285a.26.1793013076523; 
 Mon, 26 Oct 2026 04:11:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:11:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:11 +0200
Subject: [PATCH 22/35] drm/panel: drop the orientation workaround from
 get_modes()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-22-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6347;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pIOB3uhyuBnIv/4e7qIm3qYvTrQqV7MkFySAJKsupco=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zURNMUbn+OFPYO6Rs5wHYoMvPXWbHnPEQw+S
 eR2by97mJWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81EQAKCRCLPIo+Aiko
 1ZJmB/4pC0z3MOz+MYOvygaw89qOLA80ziZqdzL2JsocIt6Gdpqn+jXgLiKeKzfpkRqe93yynNS
 6w72Miunger/6rdcY7rRGrRlFem8FTSpCJtamc5WacQP7woDC6T0A67d60V0sA53pFs6mnPcf1c
 wmG+kc/TZizvHfgHcIsV3ojeaH0YdfS0Uw0jd5DpNQMPz4+FJ4SEOdO0N9UsSqaN8p99GLZ4wnN
 Eg7CEyx8XI/MEu4LI5iPg3mHptZfQ+7T8GOdDgkhLvNvhyz24Lm16Y6wMSjdIQKPau5mwzUKf2R
 8CvwIbzO6VH8PVQTzIyeLMh901DD8wek/BCPDasQMN/5pNtU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adf3555 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=PL5jcg54admUc1aTEAgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 4hvgp3lEldFqJILrGJrxmFAB41OpjXvp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXxEEIVb7ivOHW
 B6DZVewQzFj+TxLVLRMGTNSyUPS2ygT5s1kv/PXOue53kmWBcc6yXtS5MDk6gxRtSTi5wc+q3+z
 ekUog7Pdr37pBtU7LRRifVXKD94vObc=
X-Proofpoint-GUID: 4hvgp3lEldFqJILrGJrxmFAB41OpjXvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX7SDSgmmryvpX
 GwdAsgrMgkWZn2FZP6FL9mytbpJdbpqpF39W7pc1wMOzbveHrc0b8co6lMsUrLI9T2jvwz7grOL
 O0GUbZO4w0LU2BwPCRjHqPAYQQRod1ETGoAKcvv/BGU50CvLQrpSXjkW8ldDCEmSdAKt8uaydxl
 /rXWiRG4BmgMJzKDOa6rA6BS180wMhF15AqUCKaCSxE/QljNKu/M/DrOYiLYgU8OEhqb15OTTmL
 tCx6MgYxEcBZNDqzTJoLUrdBvwVQNNNY5XFwbj0erRp3pkBA+SQi0ojlpCkuUiPZggRJkH22+e/
 hfGCFfpu6gVDXSMoR6e5SLv4HhLprrtf4hAdplRk04idYS8+eJdGK/9mmbwkiUoC1XbfchhmKAe
 8F6iODm9MalIwRRWbuBbpkxsWRplujWSmXtJsQW8o/OPPaXzQNQgBGKg316Vv3nqG+regygoQUQ
 QWrmDCX0FOo7oargcmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Setting the orientation from get_modes() was a stopgap for the display
drivers not calling drm_connector_set_orientation_from_panel(). It is
also too late: by then the connector is registered and the property can
no longer be attached properly.

drm_bridge_connector and the panel bridge set the orientation on their
own, and the drivers using a panel directly do it when creating the
connector now. The exceptions are sun6i_mipi_dsi, sti_dvo and the Tegra
DSI, which get the panel only after the DRM device has been registered.
None of the in-tree boards using them has a rotated panel.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 6 ------
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 6 ------
 drivers/gpu/drm/panel/panel-edp.c                    | 6 ------
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c        | 6 ------
 drivers/gpu/drm/panel/panel-lvds.c                   | 6 ------
 drivers/gpu/drm/panel/panel-simple.c                 | 6 ------
 drivers/gpu/drm/panel/panel-sitronix-st7701.c        | 6 ------
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c       | 6 ------
 8 files changed, 48 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index a70a2e58f88c..a67e0e57d8c3 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -318,12 +318,6 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 	const struct drm_display_mode *desc_mode = ctx->desc->modes;
 
 	connector->display_info.bpc = 8;
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, ctx->orientation);
-
 	return drm_connector_helper_get_modes_fixed(connector, desc_mode);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 150dff3ab6c3..681a2418f154 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1666,12 +1666,6 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, boe->orientation);
-
 	return 1;
 }
 
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d3a4cf9b1760..493a76f7416c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -637,12 +637,6 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	else if (!num)
 		dev_warn(p->base.dev, "No display modes\n");
 
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, p->orientation);
-
 	return num;
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 7bf38e96678a..9e64bdb403ed 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2520,12 +2520,6 @@ static int ili9881c_get_modes(struct drm_panel *panel,
 	else
 		connector->display_info.subpixel_order = SubPixelHorizontalRGB;
 
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, ctx->orientation);
-
 	return 1;
 }
 
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 37f7498449ec..92d397b131ba 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -98,12 +98,6 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 					 &lvds->bus_format, 1);
 	connector->display_info.bus_flags = lvds->bus_flags;
 
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, lvds->orientation);
-
 	return 1;
 }
 
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e4629428b1b2..0bd0afbd562e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -396,12 +396,6 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	/* add hard-coded panel modes */
 	num += panel_simple_get_non_edid_modes(p, connector);
 
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, p->orientation);
-
 	return num;
 }
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index f16e0de1ea60..b6e62a4c67fa 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -635,12 +635,6 @@ static int st7701_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = desc_mode->width_mm;
 	connector->display_info.height_mm = desc_mode->height_mm;
 
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, st7701->orientation);
-
 	return 1;
 }
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index da6ed31d151e..4d28efeafd64 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -361,12 +361,6 @@ static int st7789v_get_modes(struct drm_panel *panel,
 	drm_display_info_set_bus_formats(&connector->display_info,
 					 &ctx->info->bus_format, 1);
 
-	/*
-	 * TODO: Remove once all drm drivers call
-	 * drm_connector_set_orientation_from_panel()
-	 */
-	drm_connector_set_panel_orientation(connector, ctx->orientation);
-
 	return 1;
 }
 

-- 
2.47.3

