Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924536072BD7
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SoOl5FT4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cgkuEpDi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E1510EE42;
	Mon, 26 Oct 2026 11:11:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870EA10EE34
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:06 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAspYK2168629
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z+AIXvczawfI8EmCH7mB903AvReMzPtUT6kwOSKhzOs=; b=SoOl5FT4oUwWlrup
 w602dzJ/8d0kluDERn7rgovsGk3r3RrwLNwQY1CGhhoo1cP0kQrBjgHAValXUwzg
 /nXzV3W953+C71g7MRN0LcfE4CEo9jT1GuCfnk06b89a/woNyI++7gScIFEAXtXe
 iBU40U15wQItKd263vXug6XGe1F/e01tDeKIxRGvjOqR35y9cpdgYQXUUb8fqkuu
 xg0spNtF1KCFop80bJfrQH13wlV56QhqN8bw39wHLMVAyJMVJ5Jb1zvjAjpmDZL3
 A+U9NqRS2GAIdMQak8y8608vMdKzlSj/UtHQP2JtpbLO9fpjLmkf+VaC3vtMr2xG
 JLbPEA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u60fvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so364861285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013065; x=1793617865;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z+AIXvczawfI8EmCH7mB903AvReMzPtUT6kwOSKhzOs=;
 b=cgkuEpDiD9zQE43dds0WiG6iUaEBp4XQOuDvR396I9SrY3X8ZqPHFQyNUg023VS9nP
 +lawhPuCP5MsahZ5sFgckqzqRloQMTX74wjI6X6GXQgpbyj8GBFuNjNaOGRe/XcWgFUa
 i7XtC33fx6Bm13KId6TBeV5x9NI1LU+a/KkOusNICP/gdVIFPMYMy7zD0qQx0AMO+ZF2
 8BzpS/dyaRyJmDYHPtLPWNvN09OqglYrlfLwfcExzC2vvCWoNsgU66eoeKrCa8rLYUUm
 m90Aw5kF7KH8nda+mnYdFSWITsShFzcoRMXljfwAF1bmD6F1W/Mc0VmnAJCT/8ZX6yRE
 f62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013065; x=1793617865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+AIXvczawfI8EmCH7mB903AvReMzPtUT6kwOSKhzOs=;
 b=f1d/TGGcA513kzduVIYmSbT0gtOA80O7D1440iDMIqdZALVYbaaadEYMlyVssWHVig
 r+RpLodXgVZtTqCaUxLWKD6FOEpFmb0mxdFbglueL8xtePfZ726MKtlbL+uu6UQDd2+h
 SCT6JQL4QHo9ZI2ar5wDV/nbsJP/YZa1JiQR512au5YxRvFYLOUqBiPBYgRgPOCAq5u5
 uIcVYu4XJUAuQ3DF+5fjRlYqt+lZ6dBX/pG2uJSPEOIy+auphQ8MvY0qMSEXs9z/ouZK
 8V4KMNmiHeWEGujTALTPtRBgusFT9QlRK0oOb81zCCXC15/+1E9YhPfikuczlyJzYKi1
 eqAA==
X-Gm-Message-State: AFq9FYK5JCv34IJPFYGbL5kgrXYEJB2iaip9DcMhEe62QTtuLB8szuoO
 eCOVGYTtS+dp2mEKhkzpkFhpKTZRW0AzLddnGcsnHmwFhmm8RIoB/TWbWEzOlTGBRoxfwdugT3k
 e77RoLJGh5ZBeCuCYARchtrMhA9FueAm8saxZJ/NGZLSOieRD6LFcknSgofC8PPkgl0uJG66qtk
 4tNIE=
X-Gm-Gg: AYBFou3kjB/2y/FjSuQnJ+uqRXA2e78AvbxHYBNM9a/TF3gFeooEyU/5yC3uStOxRrK
 9qcapBXJDsrrcilrTndXrUkBJQgEyQwPPa7SXFg/V8vgTPf1GRdlbtPu5wYkzuuoudpfOd6kCq3
 t2nfgIbSoxLNoW4hnT2F2eZkkCO/Vbra9v49pv2QKEBiD7dIj5zb1PnVLX8y+xS8q1lnPQxsEGS
 7bmUocs2+lp/Tu4Hfmlub2BkDIkNr6RO23SMP7mKgQJiaKqmAq8q87WVvFIlgZgpSp0fumKwitd
 C9IdQFvLxCGCVfNqvIR1WfkTiL6PRRVFQJY61bd0OoBbPL2K5Zem2mSsA5JnZd9u/z+FpJTyr2o
 w6jBpLK8s/RfryxtcMcWBOtqbfrZVoSDTrKrVvYlkPgMEFw1SArQR4LkG7WiEox5LGtXSQiK+cD
 8TjcJpUOTKUkwu
X-Received: by 2002:a05:620a:4016:b0:93c:8e3f:3036 with SMTP id
 af79cd13be357-940ef795b3fmr912286085a.4.1793013064581; 
 Mon, 26 Oct 2026 04:11:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4016:b0:93c:8e3f:3036 with SMTP id
 af79cd13be357-940ef795b3fmr912276285a.4.1793013064036; 
 Mon, 26 Oct 2026 04:11:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:11:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:07 +0200
Subject: [PATCH 18/35] drm/logicvc: set the panel orientation on the connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-18-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Qdajy+ZxizCGYRHwcySOH98TyzKssLnXiyy5l4MYQ6w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUOSPb5SkROiJ1qgWHeJ/0zI3xpF33LRg7Kl
 3E+JMtrfDKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81DgAKCRCLPIo+Aiko
 1fCrB/sG4pFH+B9sQNL86lviJf0md4fWW8kPrNEAXeSTrNauPGWoN+5qU86gqZnym81fcvJGHWt
 eidB4GCk2J5yvG2doNP8Mgu5fQwLl91HF7cy1j/D0y3dqSMl3DZ4Bx6bni/p1jmv25RYm5RDwWV
 9pUznhEgK6pJdKm5YVNoOIlduKYbWWVGMEvzwSvXdNTYFH8RiG70sb4ThrUeLCmKUSF38QGdbdg
 SqZrAkA4nt1QYH9Y9EVqohUn/NIGzsKGvBK8yURwP9QQvtHIFXvTtWwnoT+jm71gG/gkc8aAvk3
 5dwraj1xDfN8EgWs5GT3ujM5ENWatL+090SyEKJp6JNnP1PC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: sprJsVzBd48Fjx1CYzKCj5eQlzUd-Sdx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX/hky2nJO9N0K
 o4o2Vl8NqeiHxqvgYTUpFAQdehVoOTKTTiGcQrpZNism5oWuIB+h8lXWQhmXrhes0asA2uQRXiR
 UnCArPwl5dC8vlmookBrdf8le2TAVcMKEYsuZ2ys78lcx0zEH28reB+PIV4BE2X2c2LId3RyrG7
 sLKFBG2cLBnjMVLG8yfN2YWPgiLlR1ocPxoJ7xKfS9QJXQJlwlkKZYcvM2ZSVSca5htJFm0aLW/
 ojlOQqsC1GWTUW74qnwenfvWzKYVQoXlMyxaFbV+4jTYYvRBm/ClqmRxe1eIkIUw/KmtInRhtQz
 HXket0SBf6lb2tZKbXCUzsEeWeCT/txvOYs9piccps+h0z2p+iFEWNMm2pnDU1mw4N2c9+jkMir
 9Wj+UaPyCGsQRAqUU4i6ek8yvBjheNTIj/qk5XE/SO8TnC0rYA+IaIPLHO8R7jw8BoadcSyZ1/o
 xIUhzMDCLTN+bb92pmg==
X-Proofpoint-ORIG-GUID: sprJsVzBd48Fjx1CYzKCj5eQlzUd-Sdx
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf354a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1mv1z9nBhO4L486rGt0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX4BAf4yHDrwWU
 j0FBKPmhXlwleaQftgeohvD61AKTib+SmtwRDOoNdUJrBgbTWQqDrfcuLkVB+uFRLMWFb8+qT8N
 s3Cub50iJ5G9XLh6NfXViYIkSV/nk1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
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
 drivers/gpu/drm/logicvc/logicvc_interface.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/drm/logicvc/logicvc_interface.c
index 81f760dc07f8..bcbb837c9675 100644
--- a/drivers/gpu/drm/logicvc/logicvc_interface.c
+++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
@@ -194,6 +194,13 @@ int logicvc_interface_init(struct logicvc_drm *logicvc)
 		drm_connector_helper_add(&interface->drm_connector,
 					 &logicvc_connector_helper_funcs);
 
+		ret = drm_connector_set_orientation_from_panel(&interface->drm_connector,
+							       interface->drm_panel);
+		if (ret) {
+			drm_err(drm_dev, "Failed to set panel orientation\n");
+			goto error_encoder;
+		}
+
 		ret = drm_connector_attach_encoder(&interface->drm_connector,
 						   &interface->drm_encoder);
 		if (ret) {

-- 
2.47.3

