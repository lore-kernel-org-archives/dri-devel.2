Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA4110ED651
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB82C10E35D;
	Fri, 27 Mar 2026 10:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="byjUjqyD";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C6C10E2A4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:25 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62FFC7CA;
 Fri, 27 Mar 2026 11:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606865;
 bh=rXG4UaTkhdBDUrBbY+IrNeY5w5J0q/UWD4rfx+BbDqY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=byjUjqyDmQk06TPFiO+Ne8t/xHwXPsqY4oTGJ3NEi0nOOz9i09eIWYEIbx3WCl531
 sPr+TbJ0yh1bnGWmHuTYn+N9GauoQWIuLYTx8pSd0fCPkR3XEnBrZ/8K1weVnWNsmz
 G3rDi/OMrjQKkyY9dOtImrVPrSRUP5Zau7pVElfM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:49 +0200
Subject: [PATCH v2 01/12] drm/bridge: tc358762: Clean up register defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-1-3589d3c45f4a@ideasonboard.com>
References: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
In-Reply-To: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2518;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=rXG4UaTkhdBDUrBbY+IrNeY5w5J0q/UWD4rfx+BbDqY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpZMIdwKIT+IkYMqMbe4NEWcmJ9lqe9WuT+M
 KkPgL0sbwOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaWQAKCRD6PaqMvJYe
 9S7eD/0QwG2iwm1LgUwTxwSwO2QXB8fUyp8NEwPoecktxgRpuU7sx3Ak/Du61ub9BLeo2fVu/bD
 Nwtx3T6zyCLqPXtAuyQrEGiAvOOjTerVAm58Q/yp5bdoGFjB2JM+5uZrRDr4NZKLNSqVSlkfiIl
 Z5XzcNApVSNy3NZ/B85s03hINCoSVa6lHyqgp5r1YpTGsSZT1lDM9GyuSqHac+pxTwSQA0fdbyB
 caHArFaBXXYXFSOdNF2ITbwkaQsLwt+GR2LVa+wlPiF4lTvvEOXKJpGMKQvJYKy9lDe1TCzZXwg
 4ebvlmJ+kyyxgM/axb3H3FxBHF0X7YseWeS/HqfuVRfyMA6xh37E0CIdUmcPu4/6Wk+hXovFrTN
 mYiFaLYfpVOjvjTb71JNr+YlqAeNpBxqh1EFjEEDwVLlSwTFfIklZpfGmVJGArOokBi2VpTWEeT
 nI+gWdO21vkPgIeNG0hGIaSHZcvpAhDNicWyRPNrWhDb0VOI5CB3mKHYPfxJtWh+bHyIiGd1ZnS
 3nYPWA670UDTyV4XAva28KsAnwVn6WTkM39sWvh7CO+2EMaDtJfoZ7k1lq7B1CWUpVTBwkJytfq
 1O08NYqOGEc1K0pwtS4rXUvzI3LoZYEFq3pCZ5flWED7qr2ZE1qJaqWL09gA9wotOFXZXjYS9lh
 yzVBwnrtp6QH8gA==
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
index 98df3e667d4a..833fd9913c75 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -29,17 +29,22 @@
 
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
@@ -60,14 +65,8 @@
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
@@ -118,7 +117,7 @@ static int tc358762_init(struct tc358762 *ctx)
 	u32 lcdctrl;
 
 	tc358762_write(ctx, DSI_LANEENABLE,
-		       LANEENABLE_L0EN | LANEENABLE_CLEN);
+		       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
 	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D0S_ATMR, 0);
@@ -141,8 +140,8 @@ static int tc358762_init(struct tc358762 *ctx)
 	tc358762_write(ctx, SYSCTRL, 0x040f);
 	msleep(100);
 
-	tc358762_write(ctx, PPI_STARTPPI, PPI_START_FUNCTION);
-	tc358762_write(ctx, DSI_STARTDSI, DSI_RX_START);
+	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
+	tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);
 
 	msleep(100);
 

-- 
2.43.0

