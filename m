Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A1606A339
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=d4iPC2Qk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB4C112DDB;
	Fri,  6 Nov 2026 13:59:28 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53F2112DC5
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:59:19 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106135918euoutp0212ad2b581631d7552963c3752f45ae15~leXJZoHn62692626926euoutp02E;
 Fri,  6 Nov 2026 13:59:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261106135918euoutp0212ad2b581631d7552963c3752f45ae15~leXJZoHn62692626926euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793973558;
 bh=JAAf6ejIjSHAZUYPs2a+1oyrfP9h95zkrdlwUi8RBDk=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=d4iPC2QkRe7VbKJGfIQ/JfhHftILr4+lsYa+4n0OAUDc9iKf4A4xgLSrAxFdrZrgQ
 8TPLrsFSNhqpuTsZfl32DcpM8138D1irf5hjPThoFKv8/CHdeUTz/hgvOJT+txeBzJ
 AS+h+vmJG1rXSXELLFpMW0NVeTyH0Iq8KRDhow/E=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261106135917eucas1p260b4a7f05f2787a46d7282ede885401f~leXIZ5dB_1707617076eucas1p2M;
 Fri,  6 Nov 2026 13:59:17 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106135915eusmtip1d9ea61d0fa14a43daae27ce64d083c52~leXGLujRY0678706787eusmtip1W;
 Fri,  6 Nov 2026 13:59:15 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 14:58:48 +0100
Subject: [PATCH v7 14/19] drm/bridge: inno-hdmi: Make the supported HDMI
 version selectable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-jh7110-clean-send-v7-14-68f7ea9913db@samsung.com>
In-Reply-To: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=+wO5gwdnHhvooMrBTcNjEt7hkWgh1Oq7kFJjB8SzSJo=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9vStu9O/oH8WZshcS2Z6KnM8UmRN1d1f9zA4tpsL5b
 BEfHdt9OkpZGMQ4GGTFFFnObow2kvzH8LT8+ONfMHNYmUCGMHBxCsBEtoswMixVlrnN4vKb1yLr
 TeVt92sbz0V4fWMW0Ji+ziI8Ytet8/sYGb7fWpN1wV80vr3u4ZxF0wrmu0g8rDkgknWppSLu//w
 UQXYA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106135917eucas1p260b4a7f05f2787a46d7282ede885401f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106135917eucas1p260b4a7f05f2787a46d7282ede885401f
X-EPHeader: CA
X-CMS-RootMailID: 20261106135917eucas1p260b4a7f05f2787a46d7282ede885401f
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
 <CGME20261106135917eucas1p260b4a7f05f2787a46d7282ede885401f@eucas1p2.samsung.com>
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

inno_hdmi_probe() advertises HDMI 1.2 for every integration, which caps
the TMDS character rate at 165 MHz. That matches the Rockchip variants,
whose PHY configuration tables stop at 165 MHz, but not every SoC that
uses this controller: the StarFive JH7110 supports HDMI 1.4b and drives
pixel clocks up to 297 MHz for 3840x2160 and 4096x2160 at 30 Hz.

Add a plat_data field for the supported version and keep HDMI 1.2 when
it is left unset, so the Rockchip integrations are unchanged.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 3 ++-
 include/drm/bridge/inno_hdmi.h     | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 9aa005ff65a23bf55672f97aa1ea6688cf1b7ba3..ce036965a483e47d349df85db1ed7dad31f4e8f0 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -1177,7 +1177,8 @@ struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "Inno";
 	hdmi->bridge.product = "Inno HDMI";
-	hdmi->bridge.supported_hdmi_ver = HDMI_VERSION_1_2;
+	hdmi->bridge.supported_hdmi_ver = plat_data->supported_hdmi_ver ?:
+					  HDMI_VERSION_1_2;
 
 	hdmi->bridge.ddc = inno_hdmi_i2c_adapter(hdmi);
 	if (IS_ERR(hdmi->bridge.ddc))
diff --git a/include/drm/bridge/inno_hdmi.h b/include/drm/bridge/inno_hdmi.h
index cc5099d05f641eef5de91ed5becde7337c04b013..89a38f26091eda1ef7818fea9d1d9c99e4ae019e 100644
--- a/include/drm/bridge/inno_hdmi.h
+++ b/include/drm/bridge/inno_hdmi.h
@@ -6,6 +6,7 @@
 #ifndef __INNO_HDMI__
 #define __INNO_HDMI__
 
+#include <linux/hdmi.h>
 #include <linux/types.h>
 
 #include <drm/drm_modes.h>
@@ -34,6 +35,8 @@ struct inno_hdmi_plat_data {
 	struct inno_hdmi_phy_config *default_phy_config;
 	/* Clock the register interface from the TMDS clock, not the system clock. */
 	bool reg_clk_source_tmds;
+	/* HDMI version the integration supports; HDMI 1.2 if left unset. */
+	enum hdmi_version supported_hdmi_ver;
 };
 
 struct inno_hdmi *inno_hdmi_bind(struct platform_device *pdev,

-- 
2.34.1

