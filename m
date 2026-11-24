Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A5606A323
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QTAegHl3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A6910F766;
	Tue, 24 Nov 2026 15:55:11 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1284310F722
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:54:25 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261124155423euoutp02eec8ad6e3011de31a32a1c9604515160~rBixZJ2hW0431604316euoutp02U;
 Tue, 24 Nov 2026 15:54:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261124155423euoutp02eec8ad6e3011de31a32a1c9604515160~rBixZJ2hW0431604316euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795535664;
 bh=KiI8d4cKVeyNsxfRDWA6gviPifCD35OJXPxKhstld7E=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=QTAegHl3FbYGn9eL/Lg1jImVCWu9mFd1UxcXNY0kUEUeBNQlUzd7EatI58loj1Udu
 I3mVDXnn0yQ1pHQEGnbpak/2ekbH5lIhY6+mE2iJi8PupOf39Mes7AXC+w8oZ6eorA
 O5vhLCMnYb7SJLXZZaMg9CqVwYDyAyTxaBL+yuSE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261124155423eucas1p2dc9d18f8a847d77c60615bc7f37ed657~rBixArJQT0856008560eucas1p2G;
 Tue, 24 Nov 2026 15:54:23 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261124155421eusmtip1da8a2deb01b07769b105bf7000d86256~rBivWoOMY2656326563eusmtip1R;
 Tue, 24 Nov 2026 15:54:21 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 24 Nov 2026 16:52:49 +0100
Subject: [PATCH v8 13/18] drm/bridge: inno-hdmi: Make the supported HDMI
 version selectable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-jh7110-clean-send-v8-13-de92635dd857@samsung.com>
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
 <cristian.ciocaltea@collabora.com>,  Owen O'Hehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=E63qKCoHeBTDbROc0mY6FZDQcS54lq6G9OYzSsmEdo8=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWSzbhb1r9sSXftMnUMz7l37B+t/fyt3Jk8vVxMPlQpbe
 53p9RfujlIWBjEOBlkxRZazG6ONJP8xPC0//vgXzBxWJpAhDFycAjCRJXcZ/nCba9k2n58fsbBB
 WtjBhu2h6N7/R5o+7Pl6eaqb9l4/YyVGhiPSPtn/i2xe3eA4Ki903ObuCmXHpB8bN5Ts+Rft9KL
 blRcA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261124155423eucas1p2dc9d18f8a847d77c60615bc7f37ed657
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124155423eucas1p2dc9d18f8a847d77c60615bc7f37ed657
X-EPHeader: CA
X-CMS-RootMailID: 20261124155423eucas1p2dc9d18f8a847d77c60615bc7f37ed657
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155423eucas1p2dc9d18f8a847d77c60615bc7f37ed657@eucas1p2.samsung.com>
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

Tested-by: Owen O'Hehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 3 ++-
 include/drm/bridge/inno_hdmi.h     | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 19add900bf728ca7dcdd1b3605d3fbcb2e879db4..8b9850637dcc677bbba61b4a93a3db6c0dcd020c 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -1169,7 +1169,8 @@ struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
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

