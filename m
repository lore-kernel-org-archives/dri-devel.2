Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71C606D803
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Om9HljUk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EF2112DD0;
	Fri,  6 Nov 2026 13:59:17 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C447112DBD
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:59:10 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106135909euoutp02c2363eba50b4c20aa2d4f96959d0e9ec~leXAew5gH3135331353euoutp02C;
 Fri,  6 Nov 2026 13:59:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261106135909euoutp02c2363eba50b4c20aa2d4f96959d0e9ec~leXAew5gH3135331353euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793973549;
 bh=7bA78Hn1Qn+0eCZkcT2mFs3p5W5h9bsXK0FIB5YmPq8=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=Om9HljUkOCDUCBfjvGA3JEp+Eqn32b9pTHyFvfGSyXLTf6kEzYzcq5bZ/LL/YATZo
 t3NLvBh2TAV7R/oj9JnimEHt6rPcFXXRa0AfUSJbQb96uIkOe+MEN3kepTv8PH7BCy
 ndDYHC+vvZxzYscJili+w/Z77VgkHFygq3eAytw4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261106135908eucas1p1327e42a8b4f0367d55353dae77307708~leXAF1luu1548915489eucas1p1n;
 Fri,  6 Nov 2026 13:59:08 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106135906eusmtip1f997c964cc6122cd6ab314223c55ce07~leW_OiQ_U0952409524eusmtip1d;
 Fri,  6 Nov 2026 13:59:06 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 14:58:44 +0100
Subject: [PATCH v7 10/19] drm/bridge: inno-hdmi: Add .disable platform
 operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-jh7110-clean-send-v7-10-68f7ea9913db@samsung.com>
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
 <cristian.ciocaltea@collabora.com>,  Byron Stanoszek <gandalf@winds.org>,
 OOHehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=RKqbMoh/65yP3/ICU5N8bEt8c80xGz268dOiQxM+X+8=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9vSueF/SjQkJhWuPNB2ennNZh5wwMrPFSXRX98p+W+
 JXqKxmZHaUsDGIcDLJiiixnN0YbSf5jeFp+/PEvmDmsTCBDGLg4BWAiBaKMDLe1M36XT42ae57Z
 Skpkdrxg1pz378zX9M1m9nDz9Lt7chMjw2cHTRkvK+mzP5qWuoemfwyQa2ya0dhhuqC7a0e8Vo8
 JIwA=
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106135908eucas1p1327e42a8b4f0367d55353dae77307708
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106135908eucas1p1327e42a8b4f0367d55353dae77307708
X-EPHeader: CA
X-CMS-RootMailID: 20261106135908eucas1p1327e42a8b4f0367d55353dae77307708
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
 <CGME20261106135908eucas1p1327e42a8b4f0367d55353dae77307708@eucas1p1.samsung.com>
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

The Innosilicon HDMI driver supports platform-specific behavior through
the `inno_hdmi_plat_ops`. While it provides an `.enable` hook for
platform-specific power up sequences (like enabling PHYs), it lacks a
corresponding hook for power down.

This patch adds a new `.disable` op to the `inno_hdmi_plat_ops` struct
and calls it at the beginning of `inno_hdmi_bridge_atomic_disable()`.

This allows platform specific drivers, such as the StarFive JH7110,
to implement their own power down sequence (e.g., calling
phy_power_off() and clk_disable_unprepare()).

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: OOHehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++++
 include/drm/bridge/inno_hdmi.h     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 05007ed1d7af0b0f72721a0fd4def08fa621b525..6d2756c36ea22e704b3350e716bcd2f55b79b912 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -882,6 +882,10 @@ static void inno_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 					    struct drm_atomic_commit *state)
 {
 	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
+	const struct inno_hdmi_plat_ops *plat_ops = hdmi->plat_data->ops;
+
+	if (plat_ops && plat_ops->disable)
+		plat_ops->disable(hdmi->dev);
 
 	inno_hdmi_standby(hdmi);
 }
diff --git a/include/drm/bridge/inno_hdmi.h b/include/drm/bridge/inno_hdmi.h
index 507d5e999183ca02e7dcbe4ce7568acc21426a89..0864f0d8862a4325821a84db6d04f14011d9aa78 100644
--- a/include/drm/bridge/inno_hdmi.h
+++ b/include/drm/bridge/inno_hdmi.h
@@ -16,6 +16,7 @@ struct platform_device;
 
 struct inno_hdmi_plat_ops {
 	void (*enable)(struct device *pdev, struct drm_display_mode *mode);
+	void (*disable)(struct device *pdev);
 };
 
 struct inno_hdmi_phy_config {

-- 
2.34.1

