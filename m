Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DA606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lxPWJUZa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9323112DD2;
	Fri,  6 Nov 2026 13:59:42 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D19112DDA
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:59:28 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106135927euoutp026f6745a09d9fbb393dbdbdee6743eb75~leXRq07Jh2695226952euoutp02A;
 Fri,  6 Nov 2026 13:59:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261106135927euoutp026f6745a09d9fbb393dbdbdee6743eb75~leXRq07Jh2695226952euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793973567;
 bh=FOINdvs6XWC1FSRub4vzOIG+tC83yBPDa+HTuiT3hm0=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=lxPWJUZaHqj5WcgomSfsSk9sX2hrLkmKX2PsVOietCm791+etLTUm7L6MpAA9+Ue+
 Uov+EgWc174w53280xbmLZsU/DAZGwS03cWKlLtgtbNp6m7y0VjxuHrIZQE+5KK5Nh
 ELew7b0L4RAa/L/tvE6SEotqzLPUHZezvP+W/HXk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261106135926eucas1p2de40819f5e8307219ae80a96341c90f5~leXQ6MDPi2505325053eucas1p2B;
 Fri,  6 Nov 2026 13:59:26 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106135924eusmtip1dfd8157573257655aad13b94a72d97f3~leXPNo2080076100761eusmtip1T;
 Fri,  6 Nov 2026 13:59:24 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 14:58:53 +0100
Subject: [PATCH v7 19/19] MAINTAINERS: Add StarFive JH7110 display subsystem
 entry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-jh7110-clean-send-v7-19-68f7ea9913db@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=jqCtlnNej838pW00ylqvCA2gn89yffRdOQ9M8LboPrU=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9vSteu/nuipZpmqUz9A+EFmy9Nue3onZxoLnVtLlMm
 cwP2sy2dJSyMIhxMMiKKbKc3RhtJPmP4Wn58ce/YOawMoEMYeDiFICJBDkwMmz78U7YpbFjud3y
 Zj73Oy9Ffn/zfZS26rLnB8M3lldn7zRiZFhae0z6uUJQ6OqQmk+7+h6XhB77v1/NV2hN2a4cv8a
 v7kwA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106135926eucas1p2de40819f5e8307219ae80a96341c90f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106135926eucas1p2de40819f5e8307219ae80a96341c90f5
X-EPHeader: CA
X-CMS-RootMailID: 20261106135926eucas1p2de40819f5e8307219ae80a96341c90f5
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
 <CGME20261106135926eucas1p2de40819f5e8307219ae80a96341c90f5@eucas1p2.samsung.com>
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

The JH7110 display subsystem spans a PHY driver, a DRM bridge driver,
a parent device and their bindings, and has no existing maintainer entry.

Add an entry covering them so patches reach someone who can review them.

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: OOHehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065de00c29cc02de16c38eac58ac5a1..f56046284fc986f18704635425b7f61709e787ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26718,6 +26718,17 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
 
+STARFIVE JH7110 DISPLAY SUBSYSTEM
+M:	Michal Wilczynski <m.wilczynski@samsung.com>
+R:	Icenowy Zheng <zhengxingda@iscas.ac.cn>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
+F:	Documentation/devicetree/bindings/display/starfive/starfive,jh7110-hdmi-subsystem.yaml
+F:	Documentation/devicetree/bindings/display/starfive/starfive,jh7110-vout-subsystem.yaml
+F:	drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
+F:	drivers/soc/starfive/jh7110-hdmi-subsystem.c
+F:	drivers/soc/starfive/jh7110-vout-subsystem.c
+
 STARFIVE JH7110 DPHY RX DRIVER
 M:	Jack Zhu <jack.zhu@starfivetech.com>
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>

-- 
2.34.1

