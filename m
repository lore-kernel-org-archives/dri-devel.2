Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E1606A97C
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DlfoBBMQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iXtYDW65
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1058710EE4D;
	Mon, 26 Oct 2026 11:12:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9D310EE4A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt87O2733524
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2EQ/MiWnWG0HlXQbsW/EZMMH51V/jq2046f8+siL5Mk=; b=DlfoBBMQdu+gGpBp
 HLTsmsjMT+cbwrSvkEyj/YVEWR34HlP8VGa6IPytShHDFswEtICWVO/mOuGvCLB7
 SSqcmkfg5Pyv3vCFQqr3jeubg0fA5H8OXxXyUEg3fR7s4zxN4424clUcrIbbYheu
 xppxXBdrQaeJT4wkJd5nBYu9lJAH4el8agc39XXo80NAwDova8QMSxp571ZvUzzO
 dB+kECVSUh35GpildXscuG7N+qwXX6COEHqPUhWQZEc0wtXGQT0m4cT802a5a/Xy
 oLPaQxNH43SixV82JSNLTDQBJgJQArY4ctWuAHebEbQgAPfoDsXiBQIhRgkgNkA/
 YkgcpQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp8bkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:27 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91bc57d4d11so72515716d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013087; x=1793617887;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2EQ/MiWnWG0HlXQbsW/EZMMH51V/jq2046f8+siL5Mk=;
 b=iXtYDW65J+NPqURqFdI3KlmbS1v4GKFM9q34Nh5e+Lq7LinAIT22gOYeRtk8obIV6j
 1pYycVaMrkptlJkpAZgi5SmUi+yRj99vTzaW6RAElEHPe9vnwGnQDJdBkCX+KW+ye0Fq
 gOdcg9hfucbXcMCylvTU2mCgZ5HxZZo7W1GXETQ+k4ARIJ44IrTGdR6p6CkMMEHW4QEg
 ldGjW7iZbXUuq8jv2/ii4ZFrsRFlIX7fS9NhHVoROvKU3O6LONE57gDsISakBnv3tmnK
 M1u//IlcW4R/fkGZThq1siqeiWnrv4nDw3XuCvzsVfN+5EtmUWYMbQ+HkulA3LwbmuIQ
 EycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013087; x=1793617887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2EQ/MiWnWG0HlXQbsW/EZMMH51V/jq2046f8+siL5Mk=;
 b=ODCbQSUSDKqIsIyNPrfsAMNLiquEZvoXZhhzkIFST57ZxbzOc/2NoiqofbsCQmwRay
 aJCZuFxDKW1mLSMqwoniFKM5tCV0rXCSFcYaNxTWKWv+E9gaZP6Qv+6z7F/TZrW7z9i2
 jUnIJtD7QuusZYeRwyw73F3gb8BXqDisZMVm83NuSo0ncoTMYGk4LsO+Co7dBB0W7ksL
 trSJBIqptvdp2JAkUGmhTa/72zkhgAhTCV1CP1dJ1zEfc6aioGG8DQzFMQ7DjLKci1jA
 lgHEGxpscKEWCszrc/2UmMDxZHPVgAB3NWBDujAzKtk6m2KB+hqv0eu8hCnLMRgpFZ1O
 EiGQ==
X-Gm-Message-State: AFq9FYKFUu4p4SZOlQlX//jvRpNm2lRlyQDg+PV7BCbX8ab3BQUbrK5u
 BapIAdCxgOOlmJ9DFtWtseZH37oNivhvrEwpUEzwbz/ntL/UhVbpt1BoIILPddchZtpPxnSoAi+
 LjpEBIfZDLQYLO0jPNRTUVIHMFSfnK6MCO5sGnN2B8SGXaUsSfnysoREzVQP7ATgJO3hnMY8=
X-Gm-Gg: AYBFou2JvfaBbLWdG9FN8iLy6uSt7Hffid8huA1Yyp9ZJsMJd6tjdh/1VVvtBU5Pt6Z
 Nk3VxkiE2B5nr+5YPrjgRmCUnshwGmJkYri48nzgb0/29BwwCzEzfcw0jkg1DqJxmZrN+Z8o8l5
 wrXXd219ohoZtt412CVir/PphNrBsGG2bqlECpXG2V9DcuXYHETVMgYkpUOR5RLys22+NVXrlYx
 HP35hKRs29KKiz38H7UE5ZLM2jPggKoPPu+s+L0+tVu5LGY1FhXW7pSFI6leZ8OGyXadVy/4htP
 RFb66HAcQYHgRuT5KFjSZ4z7X8jqbLGXl2b4sAgiBziWGklsJ+ZA+gKTfD5OKYJeV3v5xxkGrCm
 3EtDfoRP3tlRtWAkLyN2cxAqT4L4D64odJ/60O35cl1QENq/+dgK88CbgsH7QSWisSF+NLstd0w
 +TM1cKIPepa9zs
X-Received: by 2002:a05:620a:470d:b0:93f:1af1:7952 with SMTP id
 af79cd13be357-940ef7b1ab3mr947044285a.4.1793013086629; 
 Mon, 26 Oct 2026 04:11:26 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:93f:1af1:7952 with SMTP id
 af79cd13be357-940ef7b1ab3mr947033785a.4.1793013085856; 
 Mon, 26 Oct 2026 04:11:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:11:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:14 +0200
Subject: [PATCH 25/35] drm/panel: remove the get_orientation() callback
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-25-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=memBQqdrrl5gcxOviNjOVq9PVZkJuaYQ1rBpSIUkLCI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUSN7gXcQBFypwp2wbYmPQOc6iEpCWG/CNlo
 kn/D0pCyeiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81EgAKCRCLPIo+Aiko
 1fcCB/9gZLyPxzsZldrayRHV7F5rm0+1qyUFB8jDX8vfiOt67qT3HspHI8OlWm/FeJztv+a6pWR
 NZi/SaDcdAdzcoFoecPe5f955PMcqmIc7W8YrxSTjTJXgXUVCUD3aB7foCr3F22dVWOUMPPpBDN
 0INFvfjJf5b1Vf6BI4QOsesiEXm8dje/GftQMPt3WftrY9aXIEk5wVzR50QrVNFpww+7oXq8qLX
 EM8lKIqcgs1qg1F06ctP91i1DL/XvHJ6WDWR8c1FkDFMV/6vh2KROf5hzdd7QzDbPCJxWIrDJ6r
 63RbPGf/yxG80b0e7eaBfscwIPmhMZPu4tQcIyPztXV8vcNK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXxAURDjnJoTEC
 /iIbvEXHe/N8Ou1GTIpWIUTrEmvd0GyqQBO6NElZHE5voiE5b8GTxtmEGsRDY6MO/e8B4YfhweC
 jEIqbP2Qh6oDmU9SVRW01Q6VglzE+SA8MzaA9uXbS0r5DmtxMErgOReIT7V9Ud2gpAhdC1pnYfv
 FB8f53zzrdoA6pyH+ggyRRvhBO42kIyYT1ij0C57ucWVU6VkjtByfCbTX//BgXOB+Pzs+6aYMbW
 hk1WET+GZ2bTAb9HN5d50K4GYULHPxAcYUs2IjsTzDEhJQ/JGBX4fkCBWOaC1azJvvS+duY5y7X
 YoUrH8OqBrHp97iW1w9LS5V8fxTsHofnWxU3ekb5ZUD7pUrAedseYS08iOGjaAuToPtHjMEv4or
 sfyY2aJhLsBPfdfYQZgPn80B5+vBbFJy8526odGKTZleLg9Qp0M0S2AS65xmO6xGGGMAV0Ypv+z
 Ea6H1LY7OiRp42Y9RPg==
X-Proofpoint-GUID: GhcfO_RWBjQCls5hkmBVVz4h-RxS0wEp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX9NUoaOqV1zqq
 0+WmzQoXTf75++TEl4h2vsjgItGHbr63fXIA+JZrONd9+vIkMPpp1o1UicVSbi/wFXXd1dF2Q9h
 CRt8mjYl6z6dTDcFkRtZUsDyoYqVHwU=
X-Proofpoint-ORIG-GUID: GhcfO_RWBjQCls5hkmBVVz4h-RxS0wEp
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf355f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=NYfc6Exo7QqhNbPHc2kA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
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

All implementations were copies of the code that lives in the panel core
now, and none is left.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_connector.c | 9 +++------
 include/drm/drm_panel.h         | 9 ---------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index efcf1ce979a9..f630c9cd7a8e 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3392,13 +3392,12 @@ EXPORT_SYMBOL(drm_connector_set_panel_orientation_with_quirk);
 
 /**
  * drm_connector_set_orientation_from_panel -
- *	set the connector's panel_orientation from panel's callback.
+ *	set the connector's panel_orientation from the panel.
  * @connector: connector for which to init the panel-orientation property.
  * @panel: panel that can provide orientation information.
  *
  * Drm drivers should call this function before drm_dev_register().
- * Orientation is obtained from panel's .get_orientation() callback, falling
- * back to &drm_panel.orientation if the panel doesn't implement it.
+ * Orientation is obtained from &drm_panel.orientation.
  *
  * Returns:
  * Zero on success, negative errno on failure.
@@ -3409,9 +3408,7 @@ int drm_connector_set_orientation_from_panel(
 {
 	enum drm_panel_orientation orientation;
 
-	if (panel && panel->funcs && panel->funcs->get_orientation)
-		orientation = panel->funcs->get_orientation(panel);
-	else if (panel)
+	if (panel)
 		orientation = panel->orientation;
 	else
 		orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index dc4fbeac796b..d643434037d9 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -121,15 +121,6 @@ struct drm_panel_funcs {
 	int (*get_modes)(struct drm_panel *panel,
 			 struct drm_connector *connector);
 
-	/**
-	 * @get_orientation:
-	 *
-	 * Return the panel orientation set by device tree or EDID.
-	 *
-	 * This function is optional.
-	 */
-	enum drm_panel_orientation (*get_orientation)(struct drm_panel *panel);
-
 	/**
 	 * @debugfs_init:
 	 *

-- 
2.47.3

