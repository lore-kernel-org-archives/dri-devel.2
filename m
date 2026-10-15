Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89518CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF73112320;
	Thu, 15 Oct 2026 11:17:08 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13FF1122F5
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:31 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C0BA874;
 Thu, 15 Oct 2026 13:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062868;
 bh=+nFQtxFFynf+jDfolcK2GFFb3OyIB5wHYX5vygEBrnU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P3OxeOWI6PpdrM0Ti7b3lu9i2yI34IxOz5bJ2S1Qyy2qOvZD7PZORVTftAO4GOYpN
 SY+HSJL8NfqmIahkC09+h+gKM2AKSlaaF51RGOPuJ8mAg6welm/ex/UZNEuhjcKY01
 aR4U3aKgwB+P2VTD/3L5RKPWkxsXq4lSyEAh6Thc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:15:55 +0300
Subject: [PATCH v5 04/13] drm/bridge: tc358762: Configure SYSCTRL first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-4-7cd721a6451b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=+nFQtxFFynf+jDfolcK2GFFb3OyIB5wHYX5vygEBrnU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYFZvN/CyX6eh2vNoe9geYlXz2aqC75pJy5H
 v2fzMx/XeaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2BQAKCRD6PaqMvJYe
 9SMpD/kBAOXa+utuKo61UXQatORkBy8SPmkIVZFLnu1Trw77fgpphyKVRcapRxpTlLJj1enR8a9
 UbKFIh+VwmbCW/+G9RuRZcXtctppDvNw5/6k5uASL96x2Lh3jWYLxE1BTj1PU9B4+hnoCVJC0Yl
 oOr5xhpJR1g8MhaSMk87vBD2m+Nc6Aia/ueripuTz6j5obRNt3bPLcoRcbqQnN1DDry66ps1un3
 PxDyNvDfASSA7SldiF2meA5SL5n2NqOi7y3mTQ4RL7SKYr97FfBW01D36++v05qFIjDUxWMJg1E
 MRNAMdRnzrm/8ddPqZzxzlpVydpOq4dncL4a0F/O80Bd04xgK757XX9wIOy5TVxYl/mBzdj0MaB
 uih0tisYcv8jEYtTDAPqObNTKujWnEimkqtPb0jbtRRsUxs5LcKCovOsnvaWSncHyDMhKoJImHD
 2PsA3SD2RxbvKAdl1RIFNRSrfQuiwWHXNK/RY1zQNAnDvZNi+TKO5jN2+yLTlbfapIJluth59n/
 eVpB7+DnQgKTLdqc0+GS2Fp/iypXEs3lF1qqHXGgyYCP3vQYCZLSp40kRWnCj158db064ZtunV5
 qbKk8Av3pkz5yFZ78zppEeXeyIBfrJSByBjSm2q9pIWTDUkDvVVerKICztsINwwdkXlgrFb0mhq
 lZYext2/FgZ5iug==
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

SYSCTRL affects the DPI output and the clock tree, but we configure it
late, when the DPI output is already enabled and clocks are running.

Move the SYSCTRL configuration to the beginning, before anything is
enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 26671dc66874..f5ee781275fc 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -134,6 +134,13 @@ static int tc358762_init(struct tc358762 *ctx)
 {
 	u32 lcdctrl;
 
+	tc358762_write(ctx, SYSCTRL,
+		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
+		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
+		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
+
+	msleep(100);
+
 	tc358762_write(ctx, DSI_LANEENABLE,
 		       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
 	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
@@ -157,13 +164,6 @@ static int tc358762_init(struct tc358762 *ctx)
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 
-	tc358762_write(ctx, SYSCTRL,
-		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
-		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
-		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
-
-	msleep(100);
-
 	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
 	tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);
 

-- 
2.43.0

