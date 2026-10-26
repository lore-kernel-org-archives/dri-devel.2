Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF96072BDD
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d/YLm8iy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pmn8xmN0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9234810EE3D;
	Mon, 26 Oct 2026 11:11:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D71A10EE10
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:57 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAsxmp2168785
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FM3kXGDco5NtVmAs596vka6zixIm4dAJF2g35IRPNFY=; b=d/YLm8iy70QciDI1
 xsw5vntiBKVjy58tjQk1wWQ/sDVM8phUMfUO0fwngs5ZyPdG9qnRlebNMOtv0272
 94Uo/PKJhTMs1CmcIJSqzTB5hZxMnjMROVCnNqJGSFhUy7fD0MdpmuRm+V9pcUzN
 eQxdvvFRwwfN7zKMxK9ZsskkVOHVZZSGedoPBeuVtKbdQ48x+lB21aivDHe6GAEN
 IFruFR7LxogZWdq9fj1dYUlFSuUXrEfVp9gb4RpRXxNMAa5VCsjhTvEdnsbXx/nj
 wDOulrki7VLjV4F6KhSj4kpYi46KQeo0Sp8FkMtZi58Vv4lPBw18pvESrxwoKM9d
 ffC7Pg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u60ftm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:10:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso104929736d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013056; x=1793617856;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FM3kXGDco5NtVmAs596vka6zixIm4dAJF2g35IRPNFY=;
 b=Pmn8xmN0etfd5dS1y9iTKuEdJhsOyqeBJiB8ffdztyP8KBwEwTKWB3aqx3ItdU+rji
 m7dN5I+DhPYSFDUpuHh5SSYwu1tEDmRUCqEnkv8CVjspppjIyWVPQFw4LEHD211mj16w
 ZEllY9M3zNqwzs1ORUnX6wBmv27+5Rf9MmFvtnio2wMsQbjnw5OAAhrIHC4qe2yZgKBb
 kqVsl1uKXZxFu3b88O1Twj+drZu6nDN0c1cr/Ev+vE3un8TSK2W2ecv0OYcbg0m0rA5g
 HB2Fr3D/oKQhf+r+4rrf+ub0cgAruwL/Ydz318vJI4+eDEZDEKu+bkXqDFfv7a1geAmG
 EWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013056; x=1793617856;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FM3kXGDco5NtVmAs596vka6zixIm4dAJF2g35IRPNFY=;
 b=bngri8xgmrC7GJKQI6Qi+QpDYa7fg6OZ8sDPqMkdNqJ3eSU7tmx/MDXZP0h1pUn5Wa
 PJf2+Uy9zWUNqvmYgeTMI2OHR2Ep6IfkSh0FOi/VEtUd2el/2FMWwiBISXjVCiNq/hkK
 c0ZcnWEz9NSJcH/GpKerYquXW7W8UghN+7e2Mrbmblsq8l2k3LHeJQKd0RtIi+VUR+XG
 TJ5SxhdO4aMAYHfrxypde1flk1T4Zx3Oz5L7XA5Sw4kWdmeeDey2vtz+YHKTCEygv5tj
 6EeH8jYfvAl43LjHD4fCYRgawLyHEwx+eNBHGrmass5J7uAl21S1WQggIy5r0mnvBXDh
 rm4A==
X-Gm-Message-State: AFq9FYJT/bWSQR/mCRs2YuJK5/RCnfBaSfuFm+WV+16PjLt7IR1Wlsff
 hR4Vyn7uZmroBlKlfpw7MCB4KmlcBg5JfBA5lveZh+ayVDxGBiUnONJVUWsgO5HPkglBQ/16tFO
 C7ESRWIphy7eh6up8CeeRmOclQGhyhQPYyc/DTqqpqXocfs+94dgg7cgju+ifMV2JUVLafek=
X-Gm-Gg: AYBFou1hVZAUzmUjeIU+ikJyBIprUmcUltuXIgpRRXy5/PE4yOB7dGqqwVPs9U7OYPk
 6Owh3/9v6wKdEtPLJvj6WB0jOeFRFgkw8FJIh7ZtWhj0YjkaZbzWUDY4AQa5vXrEAZwHTNPxFlp
 lIa1BpRimIrNf8hgBLFQPdp/koisrf3pmf81HbPpQalixVcn6amRcX568/+XXv3fD/Pf5HPhiKf
 mzkI+uubbgJrZmp4mNocuBBXg+JVjRdaZf1pZO6CmKFMBJcuD7gtauX+KeeZx8Eo77Tj1QFTgLm
 KORArFqP6UdeanheVrJBhVU9d2KmH5eeFqzRYKIT1f5/MVLFru7pVzrKi0sr6RrnhSA/bDRieTY
 v52KhBA4tOn41it+9F1t269Oc686WMcNiH0uFu9Kr0G2NazNWX6cYo0v7aTN9MM7me7tJp8bna2
 Pcv/LwrAVYqNAA
X-Received: by 2002:a05:620a:17a2:b0:93f:34b0:4880 with SMTP id
 af79cd13be357-940ef9143a5mr985779785a.22.1793013055834; 
 Mon, 26 Oct 2026 04:10:55 -0700 (PDT)
X-Received: by 2002:a05:620a:17a2:b0:93f:34b0:4880 with SMTP id
 af79cd13be357-940ef9143a5mr985772685a.22.1793013055334; 
 Mon, 26 Oct 2026 04:10:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:10:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:04 +0200
Subject: [PATCH 15/35] drm/bridge: anx6345: set the panel orientation on
 the connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-15-5e3070a3478f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kJJulWe9/CRUqjDC8d07GB/dA7Y7k7bAfXwncPVPNF0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq3zUNFrhKRJ1vs1GyUehHNBtb9FlnqJoPMquu8
 8BkmoB71QGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCat81DQAKCRCLPIo+Aiko
 1cqpB/90Rev4Ra9vC2dyeOIrhnPoNQBSYBLQ+4cBwkJptbtGfyOsJEdf36WL78sBupyXy7mvm70
 mOZiZb5Q3wQEUFvvldaq1SinnSkM4ZvLYA54YtJe1e4afUhZf1zdxxxN6uzG/nzN2MtX4gSeIko
 27jwwr4T7EZOInS4vGyl7UvrpyOVrBrxx4Of47Ux+urG8HX9CQPn65jITmKLsR4Q+mOYk2/cr0v
 I5mHBhdl6b9iwkCJ5w9zK11X/Jvpm5Go095HO/8NURfhBKLsEmjAFaijW38uz9L/Js1zRLqM/vp
 BmmaJ4tz4ggA0u+jYpCBNPnIMBEjR1IObkJrqpE7vpMy82Xe
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: FHdoeYegNzeJZ89jlPcVZVNeTfg1cJL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXxzWRi3/lZ21/
 bpyyh3pHTBEV6/82CFXB0ZSyl5DIc96sUxE5fTjXPgo8nmogEB7yer+CmDa6tbcuGHm7jHHPdkX
 Thr+JUI3AqbZGkXaBKKl+R/iMKdm21FCEY21PS6RUm9EO3mSyZz9BC1QGCIjGeMyD0qeZ8A4Cbr
 PLML3nTkpu86Jpmx+SH6NHYPtEG0Tb8q4Qb92IvgZASPPCMY5v0/67pLn+7aB252aiL8zdX4M6r
 fOfgbV1EHiusqY3NqzTDKY8ikT9sk8ndTkCufh9xZEMY4wAHO0FzBKGMAFsWxYbsTUlJGKafC+9
 YcB2CIKwm4I80fbXNa9Z2GVtrSfEPf9/3S6qlIPV9K4hdWPfkJ/Gk1gi1nWIvfQWRzXedzqaC4X
 su8BzXFGN8/bq8IwLN+X3nPuIhsvYMCo61rWgubHT98ttZkb18sYIawPxDJZzGtWGzEAtfXAL6u
 iqq5el4E9+gB+Fm3dcQ==
X-Proofpoint-ORIG-GUID: FHdoeYegNzeJZ89jlPcVZVNeTfg1cJL9
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf3541 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=oT6YcSNdPRKyStaNtX8A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXz0EQZqQAv530
 jNEkXbcm8aDHMEWRa2Sk5TYBO+YuChbhRRG7NAwZy6GFQYyXxpjPWm2TjE/QtmqcMJjO6osEOWX
 uxweL38lyI21XchvqdPoHkCpgvsCSnQ=
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
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 407834a03b63..91ce1a877bf8 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -525,6 +525,11 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
 
 	anx6345->connector.polled = DRM_CONNECTOR_POLL_HPD;
 
+	err = drm_connector_set_orientation_from_panel(&anx6345->connector,
+						       anx6345->panel);
+	if (err)
+		goto connector_cleanup;
+
 	err = drm_connector_attach_encoder(&anx6345->connector,
 					   encoder);
 	if (err) {

-- 
2.47.3

