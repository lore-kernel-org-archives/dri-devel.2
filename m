Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6721CD4F3F
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39CF10EE62;
	Wed, 13 May 2026 13:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KZFfprXM";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C545E10EE51
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:43 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7AE24C79;
 Wed, 13 May 2026 15:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677834;
 bh=8jIOgsyHgmNQ7xpDzmhtB2qIKIklUENHUNlx1wpR2Ck=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KZFfprXMakfj4JXU7bHORyGL97Q9LtXptACAbwK67dVpmcJbhC56XsFVAk8Wh5wlP
 uqVKcp/UZ/HTHTiq4b2fK3l+r0yJdoTgh6BHFNMz1xlpesENhpBQVixfsqX4BN0AQN
 rkjDxC4iMjP85ixVd+R01t7s5/3uuAivQl8kDxPs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:11 +0300
Subject: [PATCH v3 02/13] drm/bridge: tc358762: Improve SYSCTRL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-2-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
In-Reply-To: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=8jIOgsyHgmNQ7xpDzmhtB2qIKIklUENHUNlx1wpR2Ck=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhLP3dFzkXSQgeTGQc680G3SO7pAfbmot3Hv
 oU8ysNdjH6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4SwAKCRD6PaqMvJYe
 9cMQD/9U+7rZkgDTwtPmebKEQoy0Lc+r15Vd75s4h98efV2ZYZ0askhsglFJr0AapE4c3BqHF2R
 EFTiWgW54/50iI7HFQJKoBUaSP5DIOMv3P9FpYuO0ShsZqEGcjVs5rO467wXKYLp8M6rEELzWwg
 Sw5r26GCe33JOot66KuT7C2l4khJbH3VhnTJMsmpn3yc1mEwYAhR86MThIaZJ8obbVjgs24iTG/
 iYCmjq29uNrIth2CNxutMDzkq7h3fWersSZqh44uLrnQxQ96SOMpITg8T3E9El0XMcIhJSZKkER
 OiX+Xi3hTk9lAJeZAGstJgikMRrhI7FArK0wW2dmXlQpFw0opdF1IXH9cauEnLV9IdAVTatHimk
 QsEnNR9AZ2DFH7K5O4IjXkVOQEmfh/TVCujMq5w0MCNaHL9GPtwTsCptfKNpyQtsiuhAiTczd9b
 j7E99bN42HaBBuhANXzgd81XhrqZQcNy8XhZjCLT0I4omdwj971ooHloZ8J2NAJVNhz1gfv1nm6
 OkWyd+QofdDK5e8kOsmnT8qNtyCzYwg7bYcpAUjp0Hcb0pZu4quao04E3phGDJqPVSmlOtd7dhy
 2rRTkir6/sgJuQiRPeW7exRJkwl2B9Fe6Er3oumPJLJYPmjLzNuBdtXOPd3/SNiSuLhy4BBIYkL
 g5xIaZ6IXoGd+cQ==
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

Define SYSCTRL fields. No functional changes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 833fd9913c75..c8b9984ff301 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -10,6 +10,7 @@
  *  Eric Anholt <eric@anholt.net>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
@@ -64,6 +65,19 @@
 
 /* System Controller Registers */
 #define SYSCTRL			0x0464
+#define SYSCTRL_DPIDATA_IO_MASK GENMASK_U32(1, 0)
+#define SYSCTRL_DPIDATA_IO_1MA	0
+#define SYSCTRL_DPIDATA_IO_2MA	1
+#define SYSCTRL_DPIDATA_IO_3MA	2
+#define SYSCTRL_DPIDATA_IO_4MA	3
+#define SYSCTRL_DPISTB_IO_MASK	GENMASK_U32(3, 2)
+#define SYSCTRL_DPISTB_IO_1MA	0
+#define SYSCTRL_DPISTB_IO_2MA	1
+#define SYSCTRL_DPISTB_IO_3MA	2
+#define SYSCTRL_DPISTB_IO_4MA	3
+#define SYSCTRL_PCLKDIV_MASK	GENMASK_U32(11, 8)
+#define SYSCTRL_PCLKDIV_DIV_2	2
+#define SYSCTRL_PCLKDIV_DIV_3	4
 
 #define LPX_PERIOD		3
 
@@ -137,7 +151,11 @@ static int tc358762_init(struct tc358762 *ctx)
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 
-	tc358762_write(ctx, SYSCTRL, 0x040f);
+	tc358762_write(ctx, SYSCTRL,
+		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
+		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
+		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
+
 	msleep(100);
 
 	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);

-- 
2.43.0

