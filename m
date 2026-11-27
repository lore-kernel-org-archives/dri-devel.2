Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=T6srVvW/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65ADD112C09;
	Fri, 27 Nov 2026 16:19:22 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E9B112BFE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:19:07 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261127161906euoutp0205e004fd03be7849af68b51e48be0088~r80M87TiQ0991909919euoutp02G
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:19:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261127161906euoutp0205e004fd03be7849af68b51e48be0088~r80M87TiQ0991909919euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795796346;
 bh=2OkpDkbCyoJLFOdO1lzyvVFusub3trHvPVp03It2fqI=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=T6srVvW/342bRiJ+FwBSXVFm+sfF5Qa6TqQ1+eTiT9DO7Mgc9OHNQZ1P9kbauzQ7B
 Kiuj5/bHVYOlDuna3tiPvpLpD1MJWJcacVzuVs4xRB0+DArXp50mAe/fNe4M8JUPvK
 CdbD2ga4i2g6abDHROG98JaV+oPa1CCoRA/rHH98=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261127161906eucas1p10d26e6dbbfd4a93fe8976cedfc8c1267~r80MgJ9mv2630926309eucas1p1l;
 Fri, 27 Nov 2026 16:19:06 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261127161905eusmtip2a3cc83f060c560cb84668452b3da5cf4~r80LjIpgr2967129671eusmtip2z;
 Fri, 27 Nov 2026 16:19:05 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 27 Nov 2026 17:18:59 +0100
Subject: [PATCH 1/3] drm/bridge: inno-hdmi: fix swapped HSYNC and VSYNC
 polarity
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-inno-hdmi-ddc-of-node-v1-1-465622e1b7ad@samsung.com>
In-Reply-To: <20261127-inno-hdmi-ddc-of-node-v1-0-465622e1b7ad@samsung.com>
To: Andy Yan <andyshrk@163.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,  Heiko Stuebner
 <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Byron Stanoszek <gandalf@winds.org>, Dominique
 Belhachemi <db@domibel.de>,  Owen O'Hehir <oo.hehir@gmail.com>,  Michal
 Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=xVFAkBd12BJey0Nt5oHwW5AmpKXWLEYRNqtQ/ReT9fM=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWRzri2XMyptPHtq3rnnmgwnXS/8OnM5tiv7jWrG7KMbg
 zh6/DZEdZSyMIhxMMiKKbKc3RhtJPmP4Wn58ce/YOawMoEMYeDiFICJsKQyMtyftNxsxjR9V+O5
 i2039X74Ya7yy5BPU6L4wtSpfz7x3YpnZHhz54C8reRJ3vBDH37xm16dG+Jn92LLnJ43h++uZ7w
 wr5wPAA==
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261127161906eucas1p10d26e6dbbfd4a93fe8976cedfc8c1267
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127161906eucas1p10d26e6dbbfd4a93fe8976cedfc8c1267
X-EPHeader: CA
X-CMS-RootMailID: 20261127161906eucas1p10d26e6dbbfd4a93fe8976cedfc8c1267
References: <20261127-inno-hdmi-ddc-of-node-v1-0-465622e1b7ad@samsung.com>
 <CGME20261127161906eucas1p10d26e6dbbfd4a93fe8976cedfc8c1267@eucas1p1.samsung.com>
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
Tested-by: Owen O'Hehir <oo.hehir@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 4d9d06d0419646f00142f984b797e810df37779a..3bdcacf3cbc8427c8420eac9a37e3ecb79682414 100644
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

