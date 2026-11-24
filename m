Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADE606A691
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=d5rg+lXs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452FB10F731;
	Tue, 24 Nov 2026 15:54:25 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3592F10F717
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:54:05 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261124155403euoutp02bf3e7449e6b5b16ad43cda284d650627~rBiejgEM00854408544euoutp02M;
 Tue, 24 Nov 2026 15:54:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261124155403euoutp02bf3e7449e6b5b16ad43cda284d650627~rBiejgEM00854408544euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795535643;
 bh=4f+zvrzv0cMyD2yztqFamMRRVgagGMlkySBMVZX9z/E=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=d5rg+lXsnKaTCW5R1yhWvobj31lgoXYts/EwIes7YZJQpJUNk8z4ffxAStgTuscXL
 QC5SHdAGbf3D8CmsHOzzFxTpBV+XbV/fcE317LaPd4kmCd5P/ub6NxqB9BAKhOaAff
 1wSBfdYqHugs5ftl4AqsI88suuAwx2owRHm+NoGA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261124155403eucas1p26cc9bf09dc326b2e48c3d2e7100b4ecf~rBieMDwEC2171821718eucas1p21;
 Tue, 24 Nov 2026 15:54:03 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261124155401eusmtip1427157fa602b18d1d6e3d8439be22060~rBico6VEm0174001740eusmtip1O;
 Tue, 24 Nov 2026 15:54:01 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 24 Nov 2026 16:52:38 +0100
Subject: [PATCH v8 02/18] drm/bridge: inno-hdmi: Report hotplug through
 drm_bridge_hpd_notify()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-jh7110-clean-send-v8-2-de92635dd857@samsung.com>
In-Reply-To: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Robert Foss
 <rfoss@kernel.org>,  Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>,  Conor Dooley <conor@kernel.org>, William Qiu
 <william.qiu@starfivetech.com>,  Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>,  Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3380;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=G48i70LdEO6nG/8tfCf1URPabbh9BzFXSIDuSZEq4sk=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWSzbhbdUqY+favzy60lggU1uX/6jVpSxM533Px/0Fj/5
 8v1BfL1HaUsDGIcDLJiiixnN0YbSf5jeFp+/PEvmDmsTCBDGLg4BWAic8QY/gdui1xzf0JFTPVr
 k7OJ71ov39bJPKYxVfRBn1TtRN3DE5czMnwvmpC/br2H4euDzx9UzOHJ+X71d+K/q501xf4yQiX
 ro5kA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261124155403eucas1p26cc9bf09dc326b2e48c3d2e7100b4ecf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124155403eucas1p26cc9bf09dc326b2e48c3d2e7100b4ecf
X-EPHeader: CA
X-CMS-RootMailID: 20261124155403eucas1p26cc9bf09dc326b2e48c3d2e7100b4ecf
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155403eucas1p26cc9bf09dc326b2e48c3d2e7100b4ecf@eucas1p2.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

inno_hdmi_irq() passes hdmi->bridge.dev to drm_helper_hpd_irq_event(),
which dereferences it in its first statement:

	if (!dev->mode_config.poll_enabled)

bridge.dev is assigned only by drm_bridge_attach(), but inno_hdmi_bind()
unmutes the hotplug interrupt in inno_hdmi_init_hw() and installs the
handler well before it attaches the bridge:

	inno_hdmi_init_hw(hdmi);		/* unmutes hotplug */
	devm_request_threaded_irq(...);		/* handler goes live */
	...
	hdmi->bridge.ddc = inno_hdmi_i2c_adapter(hdmi);
	devm_drm_bridge_add(dev, &hdmi->bridge);
	drm_bridge_attach(...);			/* bridge.dev set here */

The bridge is allocated by devm_drm_bridge_alloc(), which kzalloc()s it,
so bridge.dev is NULL for all of that window, and a hotplug event
arriving in it enters drm_helper_hpd_irq_event(NULL). Checking
bridge.dev first would not be enough either: nothing orders that read
against drm_bridge_detach() clearing it while the drm_device is torn
down.

Before the conversion to a bridge the ordering was safe:
inno_hdmi_register() called drmm_connector_hdmi_init(), which set
connector.dev, before the interrupt was requested.

The bridge already sets DRM_BRIDGE_OP_HPD, so report hotplug with
drm_bridge_hpd_notify() instead. It only calls into the connector while
the bridge connector has HPD enabled, under bridge->hpd_mutex, which
covers both the window before attach and the teardown. That mutex is
initialised by drm_bridge_add(), so request the interrupt after
devm_drm_bridge_add(); devres then also frees the interrupt before it
removes the bridge.

Fixes: 969325a2597e ("drm/rockchip: inno-hdmi: Convert to drm bridge")
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 6534ad7b16a7c6dfb9718269821b4dd1cd7c5d54..48bb19d59314067343db2c1f3fa6be4d3f8dd1da 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -928,7 +928,8 @@ static irqreturn_t inno_hdmi_irq(int irq, void *dev_id)
 {
 	struct inno_hdmi *hdmi = dev_id;
 
-	drm_helper_hpd_irq_event(hdmi->bridge.dev);
+	drm_bridge_hpd_notify(&hdmi->bridge,
+			      inno_hdmi_bridge_detect(&hdmi->bridge, NULL));
 
 	return IRQ_HANDLED;
 }
@@ -1103,12 +1104,6 @@ struct inno_hdmi *inno_hdmi_bind(struct device *dev,
 	if (irq < 0)
 		return ERR_PTR(irq);
 
-	ret = devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
-					inno_hdmi_irq, IRQF_SHARED,
-					dev_name(dev), hdmi);
-	if (ret)
-		return ERR_PTR(ret);
-
 	hdmi->bridge.driver_private = hdmi;
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
 			   DRM_BRIDGE_OP_EDID |
@@ -1128,6 +1123,16 @@ struct inno_hdmi *inno_hdmi_bind(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	/*
+	 * The hotplug handler takes the bridge's HPD mutex, which
+	 * drm_bridge_add() initialises, so request the interrupt only now.
+	 */
+	ret = devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
+					inno_hdmi_irq, IRQF_SHARED,
+					dev_name(dev), hdmi);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret)
 		return ERR_PTR(ret);

-- 
2.34.1

