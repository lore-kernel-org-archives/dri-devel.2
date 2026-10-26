Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D00606C9F1
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I1IVgT0j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cTRxoeEY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82EFC10EE2E;
	Mon, 26 Oct 2026 11:10:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE6D10EE15
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtNHA2542001
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SpKV/JNuWWy0JhJSp7qItiPmfiD7gnGBifLSgJFmDEc=; b=I1IVgT0jmhAC2asb
 J2XIZ6qxrePL3+97AuF+S4wz3Lt1dXjnZnF0T8sPuCfcUhoomUFYogeVOEyDrRjq
 +DJ31F/WW9Bj+SGuYuX/2kwO11o+3AK0FPpsD2WcFjdHo9/oElGoan0t6iKjoiIz
 nn3W8Zy4qp2I4p5sCEnh9f1dVeL/50uzJwn/LiQc1i8g6YO861aLZXFv4gWBXtNK
 acuYl5CXhJjRLGL+pAn/xd/9MbV+xu5JL4VrmXhd/ltSPAEYR+dVj95wmuXULgbN
 eA2r14pxbl+bggXOXXMG74BnntY+l+9tKi6SSQxT4o8HI5QHK8bFLjTLnBzGbGrJ
 Hd55bA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjda5eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5339739b343so75959421cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013025; x=1793617825;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SpKV/JNuWWy0JhJSp7qItiPmfiD7gnGBifLSgJFmDEc=;
 b=cTRxoeEYRZv+ToGcNrInQOkuCQwxlgtls4w1S9dsrbYLdsfONoDdBsASLVH7dKjhQK
 OWW0NwtU+9yGA4KgW5HjOFOWYccWKvxP5BBKRH1wfwMPjtCwl2pWvcfx+RUMcrvot2oR
 t3JbqDQnz9/Ceu03U7s230gF8TqlVCtIQfonNfCMw1cStP7tChhT2YbFq9BiODb52zO7
 EmR9PdzzszgRG65r5odeVb3ybgzwONMjzloGlPP4hXu+v6qCngqYvYm5p53ye+HSN06k
 EEIvOEiUrQTt+NJtbGBqWnRk7uMA0KrNIGUxm5Hrht1rypgBz61u8W4yeFBHpEzmamRZ
 0BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013025; x=1793617825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SpKV/JNuWWy0JhJSp7qItiPmfiD7gnGBifLSgJFmDEc=;
 b=HLaZzdxvEqQpzBdy/VkdLHxkXaKO8S3s67Fa6DcJqE46cZGX1ZdFOYW/pe6V+xgOaw
 LwX9MgF0dadE57IZt0uojdU9kYVPcFeEMYVqDzQCVQMHbmtq8O6ho0xFfwdGDqbxtk6H
 lcCqVHjqi88vpXiQHsBklnJWCGccYklR6fJduFkgAkw3UrNv5qiiLw1775KleHURnnuT
 ECu3zH4fcup5ii3reHoTJyd+59mdhQC++r854CPsS4Lf8NcgxDrJgKMQp2UaT8DE2MIz
 ZNeDkq3JA25Vs+r0Xo3ms3q5PGS2YFm8KHLoYMaZxbfbqmSom4CAGIQSOVbvLEBQIPc9
 QCAw==
X-Gm-Message-State: AFq9FYLeVG8lLQxn2GJ7znC0rOv/2WSKAUZ4fh3YKFr70oew4IW3Y9GE
 E2CVq4rklklgHkz5KyRZAbory1JYLQru+PA3wkst6HQ7L4iwWxxLE8Z1ybrlU9lbawEDenOardP
 9bNnLzesnlcTN9zPuSSgcJOj+llzvg4xBe2zql+81vLOdb8UpQLVe8eKVsSah21GPj7NHfy4=
X-Gm-Gg: AYBFou34C7sjuo2JOb4FYoiif7O2AqVcgrbZMuV2ns1VygaSIBrfWzLAZzKlCIsAFgb
 qFlbML6on4qWzquEVDDSHPIThfvKpWNrUjufscpypdto1yHYrwXb1UGPzhqqrmR51OWn726wTsE
 PCooFFCLc4EIYDdipKzBASOyDAF7u/JLbSsAZUWYpstx3R0uQPTdmQAk16iTDSsFzrUvJpWhIdC
 U17ybZl5g9hrGo26TrwTCLMhwNEo+gE0Bo6o42W8o4wcfIkIrlzubLhYRSthImX6SEu23RzCY0e
 yeIiCgH7/KhdRfSAzbytNmz9iPDZoZHSC/TbZPmM/R7AKDXvQgAFgNOnkGYCPqtzi97FybuOq/5
 L5CchI2lkGtZoKhZ72lb9QOurH5tIRoB/9Y1FcK/T8ohYd6eyKq/xw/eLV5RIWqmG6TuOe95ozf
 clZqRBgj/d4qBg
X-Received: by 2002:a05:620a:448a:b0:93a:3d67:391f with SMTP id
 af79cd13be357-940ef7d5658mr870031985a.7.1793013025226; 
 Mon, 26 Oct 2026 04:10:25 -0700 (PDT)
X-Received: by 2002:a05:620a:448a:b0:93a:3d67:391f with SMTP id
 af79cd13be357-940ef7d5658mr870018485a.7.1793013024566; 
 Mon, 26 Oct 2026 04:10:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:10:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:09:52 +0200
Subject: [PATCH 03/35] drm/tidss: get the panel type from the embedded bridge
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-3-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ahWXP0kp+S5t7qf5z3TmyzjNxmZan19MSz4+hCT4HOY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUGItgb6kKK4AjO3W9Om73g2vCXma6yznbKl
 LFUKHSAbf+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81BgAKCRCLPIo+Aiko
 1c1kB/9LbGiOdDtx2eRR0gizf/fYpmreaM6z8w6EdAOFy1t/Abha1FUFd3caC3ERdnTesJb3RMt
 MQXRJn836BfxLcfr9grvPR645KCe339m9p6BgSfw+vPkemOuMfeMue4u5SDVupVid25yf4z7/0O
 /TXoov8P6bhXWyVeULl+m3JETg3qSoN99E9vQSJYSVTlWET+ZjFIjiHJfBHNNzKnVHYftfAHQsr
 VRe9z3PgswquJGQe/caiFzqlKOR6D3WWeU8ZHiOdVVf46Rm8u/Cm4seRvZ88SAHSwh4bHqD3nZD
 uzSrdXcMs4kpU2bLoFGLD29eYswEr61gzU/IKo39B93AULEn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 1Jm8zYbQFr-EjL9ph7jfqy9R0XGgybU8
X-Proofpoint-GUID: 1Jm8zYbQFr-EjL9ph7jfqy9R0XGgybU8
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf3522 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=PT7dRZsv_P8SEcnFsy0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX/IZBzbBnO1R/
 1Al/mot7c8JVm9z7BETDqVJlzZBrgPnGnaUiVEtJjs5N7tExRUeMve8+xGGaEgpg9lyMCXIqhuS
 W5pWPha6hjcXubtw7P2tIL+NVD9cV2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXxBSXOGxjgMd6
 lEVecg6PkpqOxvuKuhILiwm3emX437Zw6FBmRH1VgVK+47inpBAa/Le/2Bax41gtSKTmD9LnbWG
 PHTO5Z0tlsbOi6KXqoxvtX54/J6uq1cAszD5rocPREGlFGibOkyJ3lY2dSsdU8fBuxDQx4C6OEG
 hQmL4oBZjuaTUDNnzya0TR9smNxn1uc7U3J4O+A7B7bjLfEPRL2pTUe+0ckq+18chPsGXw3HMv/
 BiEROudZZKNbTQ0BGh8ufC2+Bwlw4N2uGkEa+yCRo83qRw7DJ9XQbNTi/jbXJsQCcFOp3NB5HHi
 0ghimGOBeh+bxhh9p1qQ78zVVbldpTFjzaKnTY7vHCu0zG6Oip/7eSlHM019tZj26LdsmOioNBC
 3ip+GXx3GrmswjuWcaRYrC87xNEw4ZvSKwImO/tXLLyc/6fcWJ/aLbtcgZxdOi943fWipHNJ6eO
 dAjHzt/KpGqkJEZxX+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
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

The connector type of a panel is also available as the type of the bridge
embedded into it. Use that one, so that drm_panel.connector_type can go
away.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/tidss/tidss_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index 70c14c3be10d..b98a48085db1 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -181,11 +181,11 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 				goto put_panel;
 			}
 
-			if (panel->connector_type != conn_type) {
+			if (panel->bridge.type != conn_type) {
 				dev_err(dev,
 					"%s: Panel %s has incompatible connector type for vp%d (%d != %d)\n",
 					 __func__, dev_name(panel->dev), i,
-					 panel->connector_type, conn_type);
+					 panel->bridge.type, conn_type);
 				ret = -EINVAL;
 				goto put_panel;
 			}

-- 
2.47.3

