Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407D606F839
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XgxWJLiP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E1J2aXqa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0347710EE44;
	Mon, 26 Oct 2026 11:11:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F5010EE3B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAspAr4131378
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CcjOekiXLWxe/7/1hEWEOJKSkOmsFR1V+/VqYLTRRqM=; b=XgxWJLiP9e2y8eBq
 +EMObEajhPjWxClKTTAqY0xfGvXsCvqBiLNsbkaPmujcpiI08Hr80htWgQ255ueL
 O0B+mwpc9QGF3hF1I67Zrs58Kacq/5VekmaebhrKkpKpYih/g3Udlj+vHPLK182Z
 dVsSkUL8nGbmwciqKYfCvd0ZWuWaHohDH7NGw0Dqk/E5Gbz0Nj505viuims5wSeV
 VrS1BqyE/MwJ3oDceomdfHmkGZq1wcfaSK7JpjsNuv04ya53FZas9Lmn0ltQPSVU
 lHiClo60O9P4qlJijeTv2sq1DmujfzPOAtolKYr+kwR3MbY6QIIUGMnuhwjmFM68
 KLLz3A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q059q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5ab5c136so487585185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013052; x=1793617852;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CcjOekiXLWxe/7/1hEWEOJKSkOmsFR1V+/VqYLTRRqM=;
 b=E1J2aXqapOLky2GHo8i4NjtrDFTzrS/TP3sfSzCx7BzW1gVmQF4JLoEP91WSU6ESdD
 bvBeHdyG5WDpOo3VbTsxc2Nv6QeqUDwXIPp7xCEAawq7RILbKM3KUtFYXZeJ481hFQJW
 gprNa1ZrpEy8ES2RqJ6cA/oJVz+TMlwyBt07o94kvfcW+Wc799RtWSLe/RJADFVV1PDL
 esalbCSaBPLKNbOt6y9NUKBM9uCxunq33SOmBCOR/UHdpe7q6tpRCG2yvNE3U4kwGK8z
 +YZazhTLDn9h98MqGK042IZKgHmPoKBJtAByUkkobpI3tcHxF6t68Fs5HIWH9pWy0npQ
 68yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013052; x=1793617852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CcjOekiXLWxe/7/1hEWEOJKSkOmsFR1V+/VqYLTRRqM=;
 b=ZQMMAdwM7PKc9zpBpJAkZk0buLE/Cqvcz4W6Q2Gnjga7WtV56z9L6eeEB3oT3BukFq
 6j6SCluojjWxDjDxdgYHNlUpQzGN7m4nzm1AhGssy1AUHD5vsDd/AJCi2qnr4pANF70N
 0VEXQSb2dOdNQ9ShWY3ifKKZAmSP7nGD8+iYJVXL5MZcOLaJIOX092dQnsxvnoTGNcf2
 zCgqq1XVSi/s9VrMyaJXAKBopEr0SdU9j5Bxb/r69GHI4U6DoyJsBNEStiCgYAK/6M7/
 9+o55wbsUHVJEW2uC1OsECDC4oQPUuWW2XGwQZedB7ONWkAewoRUWGdpdsi8GIOBKTyX
 MTWg==
X-Gm-Message-State: AFq9FYLE94gUJsRhtmf2HxGjcPzCXjiwO+zdWMrEZd/1BWgl2BNX9onw
 TwkDF03nSGew4Xi6bobbmSbeMsIK/56CMv6Ewyv8zgB3phnuBaKNvIRm7FyA6FVjzeccmp4rZJZ
 18/ZG76UFUBjc4lIprxeUMzTdyweM4GchmZYds2nJlOy5npKh2XFVZdpNTFxoacPzKYWGmGk=
X-Gm-Gg: AYBFou34opZrP6SvR4qnzk68ItafdNmVlG778+SLZhECCIJrQ0Ts2wDXw9bZoKk5Ap8
 jBReB2DQHjDPLqJ/KMh7ozbY7AJH97mMGb7GH0fSYwObM3S3zK+v27xiKNZdDPHw4Eo9zxoBm/k
 PqTeeT1wWmsnlse+uN7VirXIOSlyOZIHPKNriVi2RLN2ubggJfyG+XT72YFJmUPt0jhwAoHiAXR
 aF7gFFvP2pXq80LSatzPzvJZ+7s7D1unpKj3X+PeGBoT9ve8wNk0E1WuvOX/2y0iLqqLiKrp+++
 Y7Gu+w9HzqyXRKGjb1cQ3/5pdYoa7jiSNUKwlSfRPE1OQXfhRk03QLYHorAfXQ3lxLQUPETN4Pg
 /QMwFWfHIJUzYzgiblQ03ZLT5ZP7HtUIQyvrEIMVOzUPRkpR/QgKcb5u3vvJnxGJ3XT/dwCKXaX
 n9NwxhIb5dZ8/z
X-Received: by 2002:a05:620a:2985:b0:93e:f499:43b0 with SMTP id
 af79cd13be357-940ef8fcd8fmr993258485a.22.1793013051440; 
 Mon, 26 Oct 2026 04:10:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:93e:f499:43b0 with SMTP id
 af79cd13be357-940ef8fcd8fmr993247785a.22.1793013050795; 
 Mon, 26 Oct 2026 04:10:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:10:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:02 +0200
Subject: [PATCH 13/35] drm/panel: remove the _typed() panel bridge
 functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-13-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5701;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PsyqjoGaSgNE7nK0s4wZMtJ1rwL2WBpxNDlkW4hwgwI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUMPeK3u+Ehpvg+nMYckz20XnOB2X6DrWiGp
 ivt9hZIDiaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81DAAKCRCLPIo+Aiko
 1WCTB/49xjv8bT+E14FUhCWg1zJPgoKza1B4TkNDaSoxvqp2OzTbFSqDJVoOzZPRr2MZ5GSnxer
 PafN5kN4s9ZxGzoCeVnc0VHsyHqFCcxnF7/hpJTvvFhU03b8zIAqv7yYymvLZECWUjw7pQFz8pj
 VPdwH4SZwjWC3IlxeHsEPyxrDkKW/cxusJcsm4QO/WPwH8Gh9qKc3q49M9tq3B0Tk1WHuyIOz4+
 +ATu84VfzohwMW4fT8dc7CCYV3NoPjk5ZGu0SKiX3XtNkbVmUn1mbQyjoaEZykmJM1426/jx6s8
 eVvXGxGPRQs+/82naDh7UwjuDT5PG7dnoGZoD79A48SIHg/O
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX9mTfxpKJde56
 HKM66u5iAe2JgERRopaFReDf/L9oO3TW7x1qRC7E3nFHv23Nizjepf8yII00hCopImPrmXYKO5R
 o4sjqwn3sVzeoLYIBtqb2WQB/34Utes=
X-Proofpoint-ORIG-GUID: sK_TszgJ9hPnyF-ogS0cYOt5tNPaU7HN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX78OaU/5D+JhQ
 gMKD7yewWyBwBqhAlKzjIiygtpTOMfpxiSzDQrQ57XzTQb6DrCo2b7dy+OyCCW0rIbXizm0TbUJ
 zSyUeyKcNgk9mA5zdsSIQBeHQoJEEBQeMH3bNwH9y4ikSxU8yO9IUF5jM4jpSoErqChsHBL0bmk
 Y7rNFhpzKf0/mWrRkY5QzpGDyArjhvDZ5L+z2nZNMXTnyXdsKUy20Ln1Kdb03BEsWnuprg0IZdz
 lDXJ7MpVRjen501KVjxvHJs4acs2PVUTPvuDQPi7+wN3PYgRBzurOrKPV1ybOGZEFfj+zYDvgRo
 fDv9gKWVZYQcH02zeVpBpEoSQatKA+l1fpDue9ztO7bs+egYK4pjWleP5nuCr+TFPVggwpMyZbg
 aNr/Qvs/aH7HPFG3xb0MvUMLbvrvw4vIrVaL0e7gcJTk4zOToQn6VKeqT9A7m8Xok8IUd9NuThj
 MfBwDIhlaLk29FKX40A==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf353c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=5Yw8aHIVc0SrouX_YTsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: sK_TszgJ9hPnyF-ogS0cYOt5tNPaU7HN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
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

The connector type argument of drm_panel_bridge_add_typed() and
devm_drm_panel_bridge_add_typed() has been ignored since commit
b7797081ccfe ("drm/panel: embed a drm_bridge into every drm_panel"),
and they have no users left.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/gpu/todo.rst  |  1 -
 drivers/gpu/drm/drm_panel.c | 55 ++++-----------------------------------------
 include/drm/drm_panel.h     |  5 -----
 3 files changed, 4 insertions(+), 57 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index e6d36f8da086..f78455e4c97b 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -475,7 +475,6 @@ not needed anymore. Its APIs are just accessing the embedded drm_bridge
 transparently, and the are deprecated.
 
 The funcions to remove are:
- - drm_panel_bridge_add_typed()
  - devm_drm_of_get_bridge()
  - drmm_of_get_bridge()
  - drm_panel_bridge_remove()
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 268e655140ac..ab701a526ef9 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -270,31 +270,9 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
 	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
 		return ERR_PTR(-EINVAL);
 
-	return drm_panel_bridge_add_typed(panel, panel->connector_type);
-}
-EXPORT_SYMBOL(drm_panel_bridge_add);
-
-/**
- * drm_panel_bridge_add_typed - Pretend to create a &drm_bridge and &drm_connector with
- * an explicit connector type.
- * @panel: The drm_panel being wrapped.  Must be non-NULL.
- * @connector_type: The connector type (DRM_MODE_CONNECTOR_*)
- *
- * This is just like drm_panel_bridge_add(), but forces the connector type to
- * @connector_type instead of infering it from the panel.
- *
- * This function is deprecated. A drm_bridge is embedded into every panel.
- * Don't use it in new drivers and update your driver to stop using it.
- */
-struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
-					      u32 connector_type)
-{
-	if (!panel)
-		return ERR_PTR(-EINVAL);
-
 	return drm_bridge_get(&panel->bridge);
 }
-EXPORT_SYMBOL(drm_panel_bridge_add_typed);
+EXPORT_SYMBOL(drm_panel_bridge_add);
 
 /**
  * drm_panel_bridge_remove - Unregisters and frees a drm_bridge
@@ -362,31 +340,6 @@ static void devm_drm_panel_bridge_release(struct device *dev, void *res)
  */
 struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 					     struct drm_panel *panel)
-{
-	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
-		return ERR_PTR(-EINVAL);
-
-	return devm_drm_panel_bridge_add_typed(dev, panel,
-					       panel->connector_type);
-}
-EXPORT_SYMBOL(devm_drm_panel_bridge_add);
-
-/**
- * devm_drm_panel_bridge_add_typed - Creates a managed &drm_bridge and
- * &drm_connector with an explicit connector type.
- * @dev: device to tie the bridge lifetime to
- * @panel: The drm_panel being wrapped.  Must be non-NULL.
- * @connector_type: The connector type (DRM_MODE_CONNECTOR_*)
- *
- * This is just like devm_drm_panel_bridge_add(), but forces the connector type
- * to @connector_type instead of infering it from the panel.
- *
- * This function is deprecated. A drm_bridge is embedded into every panel.
- * Don't use it in new drivers and update your driver to stop using it.
- */
-struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
-						   struct drm_panel *panel,
-						   u32 connector_type)
 {
 	struct drm_bridge **ptr, *bridge;
 
@@ -395,7 +348,7 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	bridge = drm_panel_bridge_add_typed(panel, connector_type);
+	bridge = drm_panel_bridge_add(panel);
 	if (IS_ERR(bridge)) {
 		devres_free(ptr);
 		return bridge;
@@ -406,7 +359,7 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 
 	return &panel->bridge;
 }
-EXPORT_SYMBOL(devm_drm_panel_bridge_add_typed);
+EXPORT_SYMBOL(devm_drm_panel_bridge_add);
 
 static void drmm_drm_panel_bridge_release(struct drm_device *drm, void *ptr)
 {
@@ -436,7 +389,7 @@ struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
 	struct drm_bridge *bridge;
 	int ret;
 
-	bridge = drm_panel_bridge_add_typed(panel, panel->connector_type);
+	bridge = drm_panel_bridge_add(panel);
 	if (IS_ERR(bridge))
 		return bridge;
 
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index deae4753a594..07612e9791cd 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -393,16 +393,11 @@ static inline int drm_panel_of_backlight(struct drm_panel *panel)
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 bool drm_bridge_is_panel(const struct drm_bridge *bridge);
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
-struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
-					      u32 connector_type);
 void drm_panel_bridge_remove(struct drm_bridge *bridge);
 int drm_panel_bridge_set_orientation(struct drm_connector *connector,
 				     struct drm_bridge *bridge);
 struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 					     struct drm_panel *panel);
-struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
-						   struct drm_panel *panel,
-						   u32 connector_type);
 struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
 					 struct drm_panel *panel);
 struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);

-- 
2.47.3

