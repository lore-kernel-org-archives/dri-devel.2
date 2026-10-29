Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F0606A325
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=D5DAtzxY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0264F112006;
	Thu, 29 Oct 2026 07:54:07 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA1810E79D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:53:56 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029075354euoutp016e88e6a354312a857e1b3b9e62c3025d~i8N0hfURp1137711377euoutp015;
 Thu, 29 Oct 2026 07:53:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029075354euoutp016e88e6a354312a857e1b3b9e62c3025d~i8N0hfURp1137711377euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793260434;
 bh=ku0CbcFjP5oyTURtH1nZbWPb4FmfVfzCX5zYsGSO7VY=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=D5DAtzxYxshwljwB8jzcVS9dCZNE5aCyjD9uerKQPZmIfLcrOupEuFtZeUgZNL6/B
 fv7aLTGRJJD/b92aGKGwUbejskqgRfLEuBa2I8frMC4ZFE3iqv2cnXlujfY8vPWrx4
 mdjM2Z4P93oOFwW1sRWXwwhgBPP9xvpcX05WhdAE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029075353eucas1p2e700f30e833a17c676488f1427d3e565~i8Nz5neOe2714827148eucas1p2N;
 Thu, 29 Oct 2026 07:53:53 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075351eusmtip154c1ec5b48b6d622ac334ac60625ac7f~i8NyQgCUB1410414104eusmtip1w;
 Thu, 29 Oct 2026 07:53:51 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 29 Oct 2026 08:53:35 +0100
Subject: [PATCH v6 01/18] drm/bridge: inno-hdmi: fix swapped HSYNC and VSYNC
 polarity
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jh7110-clean-send-v6-1-759594e43acf@samsung.com>
In-Reply-To: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
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
 <u.kleine-koenig@baylibre.com>,  Byron Stanoszek <gandalf@winds.org>,
 OOHehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=UFRTX1n/etdtn7ZAtCmHP2TLNTN1AdVfJA+jCMkZCoY=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9+t1zJPckg+Kr2U5dk2TO/jLbvGBuwsf7TY5vt2o/l
 BU9KqFk1VHKwiDGwSArpshydmO0keQ/hqflxx//gpnDygQyhIGLUwAmEveIkWESD6fohHP8/pMX
 /p/DYjLvMoOWXd3ZM2Z3aidPUVimUTiXkeHm86bX8/RmdjL3VmZxfr71tDu6ZIeEn8yu56VPTbf
 n1bMDAA==
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029075353eucas1p2e700f30e833a17c676488f1427d3e565
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075353eucas1p2e700f30e833a17c676488f1427d3e565
X-EPHeader: CA
X-CMS-RootMailID: 20261029075353eucas1p2e700f30e833a17c676488f1427d3e565
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075353eucas1p2e700f30e833a17c676488f1427d3e565@eucas1p2.samsung.com>
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

v_HSYNC_POLARITY() and v_VSYNC_POLARITY() write the wrong bits: the
hardware puts HSYNC in bit 2 and VSYNC in bit 3, the macros do the
opposite. Most CEA modes drive both syncs with the same polarity so it
goes unnoticed; it only shows up on modes where the two differ.

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Reported-by: Maud Spierings <maud_spierings@murena.io>
Closes: https://lore.kernel.org/all/e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io/
Reported-by: Byron Stanoszek <gandalf@winds.org>
Closes: https://lore.kernel.org/all/b8b046ee-c574-3e16-6079-2fc415633dae@winds.org/
Suggested-by: Dominique Belhachemi <db@domibel.de>
Tested-by: Maud Spierings <maud_spierings@murena.io>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: OOHehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index dd35f5a875d3d842fee6d2ead0de88503f9914e1..d7c33b92e2ddf4ced84d17304463f44be52270b8 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -122,8 +122,8 @@ enum {
 #define v_VIDEO_MUTE(n)			((n) << 0)
 
 #define HDMI_VIDEO_TIMING_CTL		0x08
-#define v_HSYNC_POLARITY(n)		((n) << 3)
-#define v_VSYNC_POLARITY(n)		((n) << 2)
+#define v_VSYNC_POLARITY(n)		((n) << 3)
+#define v_HSYNC_POLARITY(n)		((n) << 2)
 #define v_INETLACE(n)			((n) << 1)
 #define v_EXTERANL_VIDEO(n)		((n) << 0)
 

-- 
2.34.1

