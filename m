Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA6606A325
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DykbsvWL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E7b3k1WO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EBC10EE65;
	Mon, 26 Oct 2026 11:11:35 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383CD10EE10
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtIrJ3563651
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mvK2BhmWsNwqcy/G+J7S3TLd2RKrJI5wiEQ1uROoR7s=; b=DykbsvWLY7taka22
 WFhCOCc+jiWbv7/S+XWueMgqhVAkqS7Phn9UFvxPT6TvmPzu3+nrWrK/NaTYUPk4
 1poFdFxFRRYKhwkQaRCLfhZ+lGWZukgtoFL/TP9nwOoxWRZLMMyAvhGWcuDDNrM4
 UUqTfwwr7Bk5CsVw0HSyroMdoSrP89/JYfqNdUkyZn8M6xZJfrxRzgah95V6rmRZ
 0nFn95+pEZHHHkoXVfVPzwtS/nYeT6tggGLrK9ZW5WQ6N3FZHJAUNOc8tx1Wzj9y
 GMi2zLhYtg+6nYRTTAW7sy6nV2gWM/wfxF52DrOi3GqThoDV0pgEh2kTo3Z9RWr5
 UjKWKw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s9092p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f568dee56so412154985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013071; x=1793617871;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mvK2BhmWsNwqcy/G+J7S3TLd2RKrJI5wiEQ1uROoR7s=;
 b=E7b3k1WOOeGTNMTdtgqMngP1urC/ap4c+hHQA5bZRKt+uY2T51/Bp3yFcZx8+LcH7z
 YlWYJzjiiuEZ2hODeVM0S35AhLp28tA6GQwcvYM8Csg46rbYpcK+HJuvIxGV+BE6x1FJ
 u8PVRN17YTjACtTtVWOjUO7BTEM8fVuSco/c3z1Rs7XzsTL3LtO/hrNIHdzuEusxqYB1
 ywHXG4Prc9D9Mnqx/B50QNgBIUULxXrVq1Mb54U/QJUSWAlNOrC/SSvgbfAr6VthldLU
 VoexqsNmwiFnZH3IKf0J1HCg/0jrWXzN/yxrfa36Nf41554oCyUTurgqEjF8d1J7Glgs
 8OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013071; x=1793617871;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mvK2BhmWsNwqcy/G+J7S3TLd2RKrJI5wiEQ1uROoR7s=;
 b=t35TWrqmMf6khupb7K2Za3yzlwh5f20ZDvgRa4jQU+9MXO/aiOwhmsmjzcFo5IMI00
 Reo1xXw1fp70KWKTMg6VzyQvVZDj2JfH3qpkdjfPBSdISNuVcu4UI9RAZhTc8Nxroew7
 7prQBtyxfiJEbam7OWHlF5KGpBmJjiix5i+xPxfX2X07hLmzMkZDxBR4FueByne8/odx
 tV0EF0YjOA3mZNo1Pij2LybS1+t8jWH+jwHaXxMlsp7S6c0NPCrll83Z+zZGvbI20ixF
 KDk1fTWuHXaoPdL6KQCivMst0hcq80NmG1ni0We7r+BdA7Difag4mYAJb3l5f/ZnfbEq
 PnzQ==
X-Gm-Message-State: AFq9FYL8OIjj/LblhjE8AGS0Ywj+AxRJr9TYdq6kp967yYV8WKZwW1I1
 7IFxRQUKaeZL6ez2a8iOmCibvR6h42jqagUcJ461mnCZS83FHgAKPzp40DOjVaes8FOvpmR8j7R
 0+83WNWGbqjwFftyJJseJ7XQZYBWyx03YWtbAtPxzGLVUfYqODNWcx4OC/D+Ek6aCdBPSqLM=
X-Gm-Gg: AYBFou2LbI6reRmjLCIG3h5wkRAgVczndsrsTfqwC2oRW9pEdXMfcqat73n6NiixUF2
 BHWa0Kv6Mbh3hl6COiGpeDV0oVwrPlQDj5e3EwONbA/T2oc/C7HDIOWkQx4EIirTWc4Waa19q5A
 5dKaDxCtVe5ngq9BmkAUMm21A9XWgzq9PmY7ZK5s7OMEa1ey6Gx188KNf6YZ2GtofqD7e18S1Gb
 JK1bTQUMM+6Dzn6FgwTQZT/EIvD3vXYtb1Gg6U32bpKnvj7LfneLZcVrPb5kO+aqR+PnUwSlNtP
 M5ogsxLfq2Qj6XV3RKaQSAM2581zuKIpGouIHUCjEmrKeN/ilJECNBS5jiyhYuSnQwPxn+XgFgM
 lOd8PiaMZQNwaO56sp8uHgl+6ARSpNb5syQbc0l85AX5W4lxcdBJkTh41Eb29mzUFDY+2L2JFiJ
 DXk8ZMcac7RJ//
X-Received: by 2002:a05:620a:2984:b0:93f:4cfb:2a8a with SMTP id
 af79cd13be357-940ef8bea4amr938993185a.26.1793013071216; 
 Mon, 26 Oct 2026 04:11:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2984:b0:93f:4cfb:2a8a with SMTP id
 af79cd13be357-940ef8bea4amr938985985a.26.1793013070598; 
 Mon, 26 Oct 2026 04:11:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:11:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:09 +0200
Subject: [PATCH 20/35] drm/sun4i: set the panel orientation on the
 connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-20-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ew/aRxbQkoMcy5WEM3fmByje6NiumMVLXKmZITcWKQY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9Z9U4HNlYFOfzVOyJXwhnLG6uhqrdTOk9YMXLtOb0662
 FvpgL2djMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZiITCz7f99/Xmt+n7hQn7Q5
 oiVJ6pv+XP79lYExnj13dBk+zvlx6fLRCyn/vuRw+Fx35u97yD/j/XlfRYmQxlLJixKe91p0tqe
 c5VbMDC199d60Q0rhh71ExOTZ3z4aJep/k1I5+GeykeTH6E/X4xUOSAtN/HeUQ/y3pjfrhH5m+9
 3phrlJzvXT2pPCu9tCJ+lwfq+TO+11L07N79CeHVMsfs2vV13Mu0/luc28bxfrE5NyTf9IxMeuU
 1juEVsnvKDT/tOXtiVpSnOay7KtWAPdgxZvffGkvOPp2hmVu4S+8gsyH4ve/0DI2f7gRqck+4sZ
 d3jWv5w0hW3Ft3VHw6RmZ+VWc+hbNwVutjnEcjxEfGMDAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX/0drl6uJqqlG
 DMgN/WxsMrh/YVrVt4hSklGT9Dcu0KRnA/d1pyZxdQnRnEIE2lCuwDvGcvseR+848Ey4OnwSdeD
 GPowiYyPi9Ccz5afF58O4x5+pCbpTooJVP9WhkQjGkMDPP55oEJ8VZxS48EkPVduFjlAVvaiqIi
 jAc/qcZ0L/2PURT9nrEdVnkbJ5BFtMjA5E+MeylTcQmkeYY5TANgDnLTF5Zcci7igdu2a726rLa
 3/LXvWUsLEm6LvEbAW8UtlPvlWosziPyO0PlhKG6sF2jhtYtpIa2oLG6pGImki32YD0gPmsiQnm
 Y/rPZ74hIr0aMyttLiCXNmFHqLwQ40XHkElHjb2jKqKHWW6pb61wn/ad/jxbrH16Ps0KVPDcc7P
 b3saV9xafMNvVI0f5xHH+g07xmdsm/wwzY1p3ZwA9lkEOn3v4FHXF7rIX8DXnHhWLm1lFoRDC2o
 Hs7vtnoXDanFAtQIQ9w==
X-Proofpoint-ORIG-GUID: zYqej_VFQZFKJi76b4Xua3r6Gn0uhWv9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX29YJvSIt5p5x
 47VaFUJHDZskdA1w0TUsjQyebmbgDIEb5ZKFAw/dpqsWoLVeb9vHunWa0i2wluxt6bpsBE8RUVG
 AuH9fnz+ubXSLlEWKwvSIMI3namTSPs=
X-Proofpoint-GUID: zYqej_VFQZFKJi76b4Xua3r6Gn0uhWv9
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf3550 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=uNaPwJEBfYLeFD5OJSkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260044
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

The panel is used directly, without the panel bridge, so nothing sets
its orientation on the connector apart from the workaround in the
get_modes() of some panel drivers, which runs too late.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 2 ++
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index 6b98d20a8890..448e8a70b1aa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -153,6 +153,8 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 			goto err_cleanup_connector;
 		}
 
+		drm_connector_set_orientation_from_panel(&lvds->connector,
+							 lvds->panel);
 		drm_connector_attach_encoder(&lvds->connector,
 						  &lvds->encoder);
 	}
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 3da9a9283c6e..5414afcb10b5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -245,6 +245,8 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 			goto err_cleanup_connector;
 		}
 
+		drm_connector_set_orientation_from_panel(&rgb->connector,
+							 rgb->panel);
 		drm_connector_attach_encoder(&rgb->connector,
 						  &rgb->encoder);
 	}

-- 
2.47.3

