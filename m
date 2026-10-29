Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3E606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BkBo6QZM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE75112001;
	Thu, 29 Oct 2026 07:54:06 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD8310E7A6
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:53:57 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029075355euoutp01eea036e51cd72bd7c0c58807a106fed2~i8N1xnTKA1094110941euoutp019;
 Thu, 29 Oct 2026 07:53:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029075355euoutp01eea036e51cd72bd7c0c58807a106fed2~i8N1xnTKA1094110941euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793260435;
 bh=JZNkLI1D8LxYOknNbfCg5Lu+geHLR3VrUCkF7jR5Kb8=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=BkBo6QZMtUsXRxnoO/Yb74uVdSrHTZy+ic5vZxWuTlq62siFuE/Pjo7u7e9nG/r+7
 xOumhri1o/Mcd9jmFkRIZR2SyUwA03d/7Lb73ftnnwgdkFrF9R5+ODoFWUPyznIT2J
 KKNq2E2XJaPxlTP7ZtNfpqIMkVp0EcVLoD76JG9Q=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075355eucas1p190ad652b6408201a2e04bc53c2717783~i8N1izObQ0317303173eucas1p1X;
 Thu, 29 Oct 2026 07:53:55 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075353eusmtip154e0ecc8421a1ca239ed21e147cf907e~i8Nz9nfKd1314413144eusmtip1C;
 Thu, 29 Oct 2026 07:53:53 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 29 Oct 2026 08:53:36 +0100
Subject: [PATCH v6 02/18] drm/bridge: inno-hdmi: Don't dereference a NULL
 drm_device on hotplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jh7110-clean-send-v6-2-759594e43acf@samsung.com>
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
 <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=Fwb2xAUCtZt/sH55MZahcxWST9JBKrVqy6JVIEgxJmM=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9+t3z48XUsDkdu1ffcpKcFHHywKXboXNXf7TIqas1Z
 Pyt0DfjeUcpC4MYB4OsmCLL2Y3RRpL/GJ6WH3/8C2YOKxPIEAYuTgGYyCQWRobrL76daZ9w4JQo
 1+vw1crvXKr07TbP/6x9bZaO9BGZyc1NDP/945caXfj0dyNDkPapWwWvG9Yfd3v8/O6eo+ekJvq
 UK15jAgA=
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029075355eucas1p190ad652b6408201a2e04bc53c2717783
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075355eucas1p190ad652b6408201a2e04bc53c2717783
X-EPHeader: CA
X-CMS-RootMailID: 20261029075355eucas1p190ad652b6408201a2e04bc53c2717783
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075355eucas1p190ad652b6408201a2e04bc53c2717783@eucas1p1.samsung.com>
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
arriving in it enters drm_helper_hpd_irq_event(NULL).

Before the conversion to a bridge the ordering was safe:
inno_hdmi_register() called drmm_connector_hdmi_init(), which set
connector.dev, before the interrupt was requested.

Drop hotplug events that arrive before the bridge is attached.

Fixes: 969325a2597e ("drm/rockchip: inno-hdmi: Convert to drm bridge")
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index d7c33b92e2ddf4ced84d17304463f44be52270b8..d29832249b942dec84fb9d07a0b21ee751fc0486 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -929,7 +929,13 @@ static irqreturn_t inno_hdmi_irq(int irq, void *dev_id)
 {
 	struct inno_hdmi *hdmi = dev_id;
 
-	drm_helper_hpd_irq_event(hdmi->bridge.dev);
+	/*
+	 * The interrupt is requested before the bridge is attached, and
+	 * bridge.dev is only set by drm_bridge_attach(). Drop hotplug events
+	 * that arrive before then rather than dereference a NULL drm_device.
+	 */
+	if (hdmi->bridge.dev)
+		drm_helper_hpd_irq_event(hdmi->bridge.dev);
 
 	return IRQ_HANDLED;
 }

-- 
2.34.1

