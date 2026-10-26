Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C760A2612
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3SeSQGl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EowssZNE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E42110EE3A;
	Mon, 26 Oct 2026 11:10:52 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4426510EE36
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:38 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtK7V2541814
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rfPhrhw7QqfVInWRHaGAOXWVQmPErff7bcKudkQLqU4=; b=o3SeSQGlxlD1ZlZu
 j6N6iic85w2ONYT3wC+38Oi7/6GVPFFUa2+aL4sncrS1hprd3DTTHJvg0o/lOrUN
 23PQliQylUfxjXA+2TxQx2QUzEtkRfXJx0yJJixRVeeqaF9l4l2sV8cQ5OUGzNM2
 bB/7Rx4DfJAoOA0KCBTLzr+nmrQ9bRTnbN9ysYrRExwgSp6VIssuPkjH8d7tXj+r
 c0bUzyKYtzgmm2WbJGRobeAtN1PXuE6AqPibFFQZpnBYYl8tD/ETvypPB2dz0OKM
 ys1ABQ9mswzCSZIe2mn0enVHrO39EpJqwP2UGBOsnqaouJ/BRpt9dToAR58j01BZ
 6egJBg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjda5gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so640455785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013037; x=1793617837;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rfPhrhw7QqfVInWRHaGAOXWVQmPErff7bcKudkQLqU4=;
 b=EowssZNE/gve9BD/REqfMcnbZCnf3HLEA+LzU12234BARjZ/XAlMYPYAw8aJmR+Poz
 mfs1zLFzeDd4Dml1SyZdRVJWhwX2T/erdIyqM5+ObmpJ98XQLxYCQtHzaCkaGog4FdQ6
 8S0kQSosfUxxnFFRTULPBsTePbRcZDiHYUxDfVE+1jdMuU46nVR3tUqtd0dj/wD1t+dT
 5x8/ebKX9TQjI8IyS2OKDYXfnVDyuuDvr8EeSKNUmBehd4rHeuWpbe3Hh5h3UziQ6Kvr
 AN++zjtzklh9E6Fj35e0SOs5GIOl4tqodYJDvB5XlQSWmmKK5gqHfQmEJFKzd0nFLLwu
 Bhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013037; x=1793617837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rfPhrhw7QqfVInWRHaGAOXWVQmPErff7bcKudkQLqU4=;
 b=fRcQxqearjQ8gWh63C84eC2YXtohQmzikcQvPsZuDKLqn0McLUgQaSl/OMacubR9bS
 uWppVlmZEbQdiplluHRguN/QIf7kohcCOfLJaAOXeEVECydDqiUPxQw+DQrFvlxHowA+
 O0YuJPwzZTpJiwwWZWVxS1H7JwaenTzTzfDYgP7h8edXAZcpWazsyBy67GL9fTk68O82
 jb/o6iGyROXDLnoBXWAQj21zEqbyGbVJcIJLERMYf0tMZ1c4gxxloCRw9CxAoEQTtSUK
 ioAQ3s0lPdEMpVlS1qiur3vbmhhFNJzddRD9i1Ico2QH+BEu2WFs8iv6a2Riu6y11YI7
 +gcA==
X-Gm-Message-State: AFq9FYKKj+6ZK14am2pJm8Ewww0jGHZibKmU5hh8UaDcYii9hQ9YeKiF
 9bSA5c6d4+IWlXe6SSFyyiC7OsPI9SQmbhJ6K0lawLrwnWM7Qc7lcDg4PFoZpPZgvQv9pefTFD1
 r0RI56vGpXX92U3TLoceIi021PD92IkYyOOYraGTCR2MhX1HyT4tnIjc8SYK0fgIchEkUE54=
X-Gm-Gg: AYBFou1LzskOHetX7y4wOZXrJ2gMgod69aVZV8MQAdEcMS1dfdTL/86Aj4GI4oxomOK
 EfMMZQszOz0v/tKJiPd+o4EXT87T4c+EgCj+66up99fnj7f24BKQx71j2z1tC2H1m1l+n4KEDLq
 gVm2t04QxwfePF+J3R/d1FJ9NsxYwilS12VZLxhWlasAX8xEvFnNzjWfFW9jPCuWg5CZ0PB5Yzi
 bPydDqCpwGxqnSEYyP0oELKLIwpk6xInjAYNDJyP9Rf8Dj/rzVPqcELwC/D6umzj1Y437SNPNAP
 fvW5j0Cmd/OCBvtA5SwVDhNqnoFaSdg5CAlvjifaZF5Q3NvdsgCvGhcubO62pJbrf0mRllwPhmx
 qEVkKFjCQgSAT+uokrFT0p/Pvo/7IHfTGO6NIhiHP0wdM2diETWHPtDQd0erxgtuEk9W9A57ab2
 9V1bueRDKcl62A
X-Received: by 2002:a05:620a:4043:b0:93e:c12c:fbbe with SMTP id
 af79cd13be357-940ef9559b3mr968991485a.75.1793013036538; 
 Mon, 26 Oct 2026 04:10:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4043:b0:93e:c12c:fbbe with SMTP id
 af79cd13be357-940ef9559b3mr968986285a.75.1793013036065; 
 Mon, 26 Oct 2026 04:10:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:10:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:09:57 +0200
Subject: [PATCH 08/35] drm: rz-du: use devm_drm_panel_bridge_add()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-8-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=L9QBqBm7svfVSs2q4h7czZX0v21Ts82vCTLjVtq1nVg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUJhK2bkP8mANHdq/N3ftOzv7WccIKtt5ZXO
 6tCU0MGEKCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81CQAKCRCLPIo+Aiko
 1fz8CACOTwp8mMz9LdCKLCqOOuK8Qd2qaZB1SvSzCPhwgD9Ian8Zauhug0X+fdkmI4VjKEebyNl
 6eIlHeO20Qt5hfXfqdwz/ezKE4k93aAYep2wG1S2hfEEQ+crBeN/yowHzi8TR+/iO4f//86+EnD
 e0M8eAye5tkII9M0Iwm0aO0L+FqC2IIBirkJUdokHuBjpGeGSEjleYPkCsElUY+37QjY+2bDkGK
 HbDOBsf0Ey9N/Pv62g7KU2qjneW637Tc1H/TcF8lQ2elO1nM3Pcf8J6NxmyOSPxow7TzT8yi0s0
 MAHYZLVEY9W2W9Fg9FwCn6im24F5casNbP6xXhX5rdBCStUL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 9tKi7yU5OWiN2xSKv_MYNSESoKUaQT_X
X-Proofpoint-GUID: 9tKi7yU5OWiN2xSKv_MYNSESoKUaQT_X
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf352d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=BQQ5wuhf5moQr-eOkAQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX23CsBijZgtVy
 1XIeiBQdKBAwaK5HPGirgMN8ikpTuAem44Vl3hq3ZAybcxWX5hbn2nTyN+qJjvvMx4Qj9MXB1VW
 MduEbKtwh6yZ2pSuHmXZt4kIiWYHWvQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX5VhebilNBsGL
 Eej2HAZxXH+SaT335eZtGnim3Rrwi7/8gCglr3ZtCCCr/4ZTyBWtzOC9V0ilSVqINRNf9RenfIa
 HOckMVFZG182dfuada3shqVwnt5qZx/ligADLiaEeID24CxxcTfwpYCgCAderuo4DkSncDnuSz1
 WA9FR/9c8649++11HBZelhBJRXpdU6yWHa29IktLV6qP99QPaH+iqYt+2mwVhZwOIp8kg1kikFN
 br1FbkWl4BYe+seTxfYNyaWyNtPTuzeRzoFmCBOiW+DiTTv9ljzMs+Jpg5ujuyMe0DpjF9Cd4je
 brN6dr7CldvSlxCvF6K4xr6knN3fxWjEHIacsgd0GDSD0oe1sYJ292Rs3SNL9Z7JIa3cg/J4d/p
 PujBObikz7YU8Nfr83WgD0X5I4OPNUxRJJO+NbAE29dbRNUx3Z7xRgvNz2YQsckBYnh+V8WYTqO
 TSnqHN/gV8292LdVMfg==
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

The connector type passed to devm_drm_panel_bridge_add_typed() has been
ignored since commit b7797081ccfe ("drm/panel: embed a drm_bridge into
every drm_panel"), the bridge always has the type of the panel.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index a1b48973aa8e..3ba28496e948 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -112,14 +112,13 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 		if (IS_ERR(panel))
 			return PTR_ERR(panel);
 
-		bridge = devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
-							 DRM_MODE_CONNECTOR_DPI);
+		bridge = devm_drm_panel_bridge_add(rcdu->dev, panel);
 		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return PTR_ERR(no_free_ptr(bridge));
 
 		/*
-		 * The reference taken by devm_drm_panel_bridge_add_typed() is
+		 * The reference taken by devm_drm_panel_bridge_add() is
 		 * released automatically. Take a second one for the __free()
 		 * when this function will return.
 		 */

-- 
2.47.3

