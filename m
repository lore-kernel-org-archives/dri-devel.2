Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FD606A940
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j6Wl2ZKT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F42NtQs4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377D610EE49;
	Mon, 26 Oct 2026 11:11:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B54DA10EE34
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt7eZ4126433
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k2CxYTJXMNJu8w6PVYOlO+zhm/teDp2OHpxctIuY7Sg=; b=j6Wl2ZKT98xHbKEx
 /nU1pTxuHGauwXtw97DwI2vSbvSkNprXjQhSmRWrIFQp1V4LjR4fvRC56w2wjh8V
 GRlHhqRThB+X4gBAvEQ5tqBnh4OR09YzmcJ9I23KNbAQz/wfYptN534uiKGOvnTN
 BfFyH27eQEUbzKXUnPEpzKqtodNGDgqCKXSqsVxd2nK9C1MufKc4MCnzYCfJc3h/
 QaoFUr1TY/sZ8idYP2giGyfsHLqTVD9mgkMfxnVZ/T4DE2tIfvs72stR4rioyGCj
 3Rj+Mc5PfS7zgfKojRpyH6YViZxjvPqeYx9R0/1AAXvXygbbSyv9BnE4ZfByhzxz
 LQ2URQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpt3pe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c61cdfb0aso14548266d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013042; x=1793617842;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k2CxYTJXMNJu8w6PVYOlO+zhm/teDp2OHpxctIuY7Sg=;
 b=F42NtQs4lxMDeOUWLfvM4Nu/4R9KABcSaA7GKRt4+scGDG2dgnFdUFKHh5H5YGiWYu
 DCxcPNvdnX1rrd+FY1MlxbueYytKwkX4I7615N0piMFHoUvUVmI4AzODkUGVCkByezm6
 EcvETxXGnLEk5S9ug8OqfJAzwW0fJErhfmgdbyiPtPRwBOEk15lSJj2lhNdwQwLoYW42
 V49l07//M2R6yjBtVNEUCQ6PsfWTIKSoNTdZopJBSEZcJN2PRzPem337J2peknqh+dAQ
 Z+JzoWnPzTsd4dZ6tLXJndpeVgXOEnUZQv9O2SztDuzxDhKpr0/IRL5ubTbAgOGmxZ8H
 Z/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013042; x=1793617842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k2CxYTJXMNJu8w6PVYOlO+zhm/teDp2OHpxctIuY7Sg=;
 b=25XACs0sbRirCYD06Wdeg1PHzOZaU1x34FdPlEPyUeKp9/4JBKWIL1CynNUsLGaU+e
 PwwmW9Uh1JpNaIDfxsQMeKT3fkgVUeBboNbe6iK1ke+vJeQ8YMPeILJ0Tl0818SoOF83
 4HYhdIqVGQT+Qqt42+1D23pKxHIFGxlm0Rp7HYaF+FmDmvKAyY6PMUbM+7DIYU8ROU5C
 QXuldCNemhdFdcf8jfCqir/jaHB6vq4wwcv2iezMfpZLMV5VYFxK/f3M278AY4BK369A
 LO8A1vjbERz5yDoMpJ9IFRxEWu8nvL6j0gocLzaUPepDn+UiBrsYbkgmXyCLZD/Ev7oA
 u/gw==
X-Gm-Message-State: AFq9FYIO0KAOLlEKRe2DIFNQ66gtarA00CauMzDOSMI+UwWmMcynJMHB
 MpjR5khcXQY2pND1k95GOATNdJU7XbmLG55wdWrg0aSBfvcuw0KDzfZgy/O8EwggxKBnc6Qf1yZ
 4sAZfpPu2/KA+qT05D5IcYM3OUaLFzaXlb+jWfb/n32Oa3YMbysHb1tJmKdp/jho9pXolQns=
X-Gm-Gg: AYBFou3ii4r8+vKDyaJKzuSx6qbRm28SRiJpqH0g7Ff4D7So0gWGuJO0ZQsFqIdBSg3
 8GlGba99rQFPX+3br8LNttuiNHd8o+9B4+4498+YR5Ub+TvV8jn1f6Uyvxa6GcLqrkxAb9M9xCV
 bMQRfa+vA9+hA/Imt5qcjymuv1jv7yKK+Df4/SmbOU7GU7QdpyqXnuPKGTk/R+pinLVM4j7oRbm
 RyI1vcG5x3z+11cRLXy2Uw35A7txI5MFcBpSLGzEe0GU/eVVRbQeXMkUJ1n2TnR8Pt0BfzQNg9H
 nNJlZ56ks3KdWIBxhVub+sKhi/vzHgKwtBYjgnErJevPZUhIlfI33UCudZQZNGVQiZFlzfd+hZE
 q+3vR2lraOWCYHXNSkz9HCw/8Nf2Y/Ao5LJHrdID5ir20UShGBKWLjQ59udFcZAHcUpSbZROlz0
 cbRtDMfORqRhUr
X-Received: by 2002:a05:620a:25c7:b0:93e:e531:b78d with SMTP id
 af79cd13be357-940ef7ca684mr861752885a.7.1793013041780; 
 Mon, 26 Oct 2026 04:10:41 -0700 (PDT)
X-Received: by 2002:a05:620a:25c7:b0:93e:e531:b78d with SMTP id
 af79cd13be357-940ef7ca684mr861744385a.7.1793013041149; 
 Mon, 26 Oct 2026 04:10:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:10:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:09:59 +0200
Subject: [PATCH 10/35] drm/pl111: use drm_panel_bridge_add()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-10-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CmM8Wphvynv0lIRI1+4+EqPH050ei17LGuNpAlAxYlU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUKQ7TIU2XRP7HZmWCiTiNqZj11gfIKhJErO
 DHDY9rbRdyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81CgAKCRCLPIo+Aiko
 1YPGB/9rhW1ooU6FBzQ1pckqwHPnHHWFmRJFIB1Fpi/hiCtnjoh9PtNUR4MQKjC/rH3//hU3uFC
 nozE52P+NNx700phAyOXXZC7YRZJaCErlJn5BFFr1JiexNs20CTS6K7tejSh8TK2Y76rZUxhrrV
 Y2loDvttO806mSD/DRpUdu9ahHaiE+NhyJI0EW7G4jjWOQyvpEpueI9gklyFlhdEPlnarBK/s3f
 K5h9NwlLkyegQ9nvNlccObPXL5xrzNK+KqqmPhcUyPmVR3mJ1zA9ApXMADNC6Vdjq2EOaPrBcBs
 8rGmFy+GqfVfwsz798jK6AMPQ1yrjM6732SGR4Ykn3ZWK5IA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXz+IY1FkQHw0T
 Z2lZlVG0RBoLPgn8HIZFB1uolfdwN1uNupFPJW1LdLZfCY3pDiiCeeljZT8bgSzxH8b/TGBahSq
 2VOWKbJU4uqexnFLLOq2p65dVG3PDLc=
X-Proofpoint-GUID: obCLlsNpH865N5pg7xiWZRVKsK2cpKCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX7PGgdytgQ+Xj
 BlDgithkfthJUfEFh/lQabDzQ7vYxeXvDq16Wf+i3jRUE7JczU0Tp8AAZPn4mybzAlLTjg5h+31
 JLGMF8qlMITe1K7I7LnliaHm9vIsbLFJ5gh6Sd6vOPyAeZO8dHh63IagU6DFbEPesXPxZD2j5ci
 inGB9KuKJaCscxNP2TXKE+XnuzJgtiHq/6aaKSr4wpn+1h1/wB/4+8hVpAIbiGOV5iIuDjWm/4n
 vwaRxsucJonl9uirfPIlBK7TouSjC9Khu7MOa2Q7sSbgywzsCsRgMKkvYIZlkCGojRU6KR/7+z8
 k/pszKwGkXh2RjvlXonnkfj6A3rFp8mJmLsULA5Dft7+zAtpGaLXXl4adY0Nzc7NxQ00gnQ3T9F
 Gy3+RNQLcBjOyNeJv9Fe5vraZGmru7PHuSXJFUutBd/kgEdUqvpBrGvXiXpsqbxKRNhJcaWCx9J
 ludyau7yNuDSUh0u/FQ==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf3533 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=6PQUdDDLQLJ_jpbVOC0A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: obCLlsNpH865N5pg7xiWZRVKsK2cpKCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
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

The connector type passed to drm_panel_bridge_add_typed() has been
ignored since commit b7797081ccfe ("drm/panel: embed a drm_bridge into
every drm_panel"), the bridge always has the type of the panel.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 89d44e970510..d172cbb95d02 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -143,8 +143,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 		return -EPROBE_DEFER;
 
 	if (panel) {
-		bridge = drm_panel_bridge_add_typed(panel,
-						    DRM_MODE_CONNECTOR_Unknown);
+		bridge = drm_panel_bridge_add(panel);
 		drm_panel_put(panel);
 		if (IS_ERR(bridge)) {
 			ret = PTR_ERR(bridge);

-- 
2.47.3

