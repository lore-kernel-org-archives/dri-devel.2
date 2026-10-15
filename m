Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE91CCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456FF1122F5;
	Thu, 15 Oct 2026 11:16:37 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDAD1122D6
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:29 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 297C92F8;
 Thu, 15 Oct 2026 13:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062865;
 bh=hcEs1EESDACSG5FDi0QNjOuOs0/cXvky+phx60RikVg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XsVovh7fQHvjw45Ls2tbeRsulV4sYjocwfUZcPjLFbV47udYL4Fe3+IyyNsKAZiPt
 E24YPIr28ONbb641NaJZqna0wM42wRVbEYnePI48+lwUj/tAZCdexWYXzSZwLJE3rp
 qf5ihr4l7r5dBGj7Xai8EAkVIpsZ7//vpB5fpqFA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:15:52 +0300
Subject: [PATCH v5 01/13] drm/bridge: tc358762: Clean up register defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-1-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
In-Reply-To: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2518;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=hcEs1EESDACSG5FDi0QNjOuOs0/cXvky+phx60RikVg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYEzsJro3jK1pHnpUI7oQrZtK0pXvQS//8e8
 M2itL9bkE+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2BAAKCRD6PaqMvJYe
 9dgiEACx1EvHIDxdoaPYpELqLC3J0fExWHWzdwCHcb0iw4Y5OHM8kInbnNXJzqkktJ3V1GSr4jW
 cEy/dl3Sx7bfu2Uu7h9VC0gN4FYFuZDOt4Jws71cUQqaCB+sXMO9Y9CjLZ6aF4Qqgm9hhFU/sw9
 UjOP/3dlT5NpP7kB/k3okYDoONWOppF6tdUp8ZBT3dY3kZtcZGXk+ygbDGLeT7PMXz9WoxmionN
 4cnjm9lwq1mOOpBg0gxs6bX3GDFG178lx8cNaHs7Ybfu1LPjRp/SSqlq3o8BxpV2XAO0ezffkXF
 T9BVb6IBdtsKdf4YCeaHFAW+3is49WWbqSLjGkIM4MnNJxy1JBegIXTmBIvzaE2eL97pgkjT5nm
 w5D8Zy5QngPOhXKXnuiRlstCcXPwhcY8OZX5pfgPSO9n2mp/gvgCKZx+wp9M0dsXjCNiaJeS9ZQ
 +lO/ftbEVOPT8OssiGs/ZdQT6oTCZTPTyKVgtOU8N1vpPzgq6fu96ZAOEgQwC1aRtMYjUAuDSlH
 26t0/fqV3p2RZBIdwpKQ192xgCoxIxyJIZtSdsCWdo99sPhD+DHJn226l1Z9FNTbuDZ8ExWt4GI
 oueOAVPp6/ak6c8eCUYgve7Hq5KOKw9d+wWXD7KTrg+jWr1bF65YuvAHa8ReTHtva2KvMn5kcUE
 BTxM2BSPjNtqeiw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Move the defines around and rename for clarity and consistency. No
functional change.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 76564d5e4f69..097d2f331a16 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -28,17 +28,22 @@
 
 /* PPI layer registers */
 #define PPI_STARTPPI		0x0104 /* START control bit */
+#define PPI_STARTPPI_STARTPPI	BIT(0)
+
 #define PPI_LPTXTIMECNT		0x0114 /* LPTX timing signal */
 #define PPI_D0S_ATMR		0x0144
 #define PPI_D1S_ATMR		0x0148
 #define PPI_D0S_CLRSIPOCOUNT	0x0164 /* Assertion timer for Lane 0 */
 #define PPI_D1S_CLRSIPOCOUNT	0x0168 /* Assertion timer for Lane 1 */
-#define PPI_START_FUNCTION	1
 
 /* DSI layer registers */
 #define DSI_STARTDSI		0x0204 /* START control bit of DSI-TX */
+#define DSI_STARTDSI_STARTDSI	BIT(0)
+
 #define DSI_LANEENABLE		0x0210 /* Enables each lane */
-#define DSI_RX_START		1
+#define DSI_LANEENABLE_CLEN	BIT(0)
+#define DSI_LANEENABLE_L0EN	BIT(1)
+#define DSI_LANEENABLE_L1EN	BIT(2)
 
 /* LCDC/DPI Host Registers, based on guesswork that this matches TC358764 */
 #define LCDCTRL			0x0420 /* Video Path Control */
@@ -59,14 +64,8 @@
 /* System Controller Registers */
 #define SYSCTRL			0x0464
 
-/* System registers */
 #define LPX_PERIOD		3
 
-/* Lane enable PPI and DSI register bits */
-#define LANEENABLE_CLEN		BIT(0)
-#define LANEENABLE_L0EN		BIT(1)
-#define LANEENABLE_L1EN		BIT(2)
-
 struct tc358762 {
 	struct device *dev;
 	struct drm_bridge bridge;
@@ -117,7 +116,7 @@ static int tc358762_init(struct tc358762 *ctx)
 	u32 lcdctrl;
 
 	tc358762_write(ctx, DSI_LANEENABLE,
-		       LANEENABLE_L0EN | LANEENABLE_CLEN);
+		       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
 	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D0S_ATMR, 0);
@@ -140,8 +139,8 @@ static int tc358762_init(struct tc358762 *ctx)
 	tc358762_write(ctx, SYSCTRL, 0x040f);
 	msleep(100);
 
-	tc358762_write(ctx, PPI_STARTPPI, PPI_START_FUNCTION);
-	tc358762_write(ctx, DSI_STARTDSI, DSI_RX_START);
+	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
+	tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);
 
 	msleep(100);
 

-- 
2.43.0

