Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAD1CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B9B1122EF;
	Thu, 15 Oct 2026 11:16:42 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0B11122D9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:29 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B0234F1;
 Thu, 15 Oct 2026 13:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062866;
 bh=vMRxXhglv4vVPhAZNH0VGgacBEqPuhZmuWkk5p8x4sU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XBoizUm4I+K7kxEzdivVVLhZBJxpAFbbOzkdKLGYBf92rG+1iDxJxsqK1V4VKYicP
 VfqOpsPeDZSbt0204J41Kf43iRolgBbUpxXk+b5kom/w/xEicw6vMLYZUnT3OlhK7v
 OY/6U2oq4yMy2LEgwh/NsvGdLbWNioX0ldjQOe38=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:15:53 +0300
Subject: [PATCH v5 02/13] drm/bridge: tc358762: Improve SYSCTRL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-2-7cd721a6451b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=vMRxXhglv4vVPhAZNH0VGgacBEqPuhZmuWkk5p8x4sU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYFzpQSSsxHaEjdJaXmbgJMmCHvenXxRrzqB
 dpFtpcgJTuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2BQAKCRD6PaqMvJYe
 9U/oD/0XQiGRVD4fVPYguEfUq1wrCzXPctFbdW96Y8qr9yk1FIVE92Y1ibALeZeh3Gll2u8SacO
 +Txlf/s25eIiymbVgC+hq73NKx9WGM+2paqeOM490XnGoS7DxceW2naD5xFklz6bqljY7xSm+Xb
 ZGBFdFsRwHY8OJz07U+vPB233i6g/l4iBkUCz+RYY/Pw2i0kwrTsugsuZruzyarENp7aEgY3ON4
 3nUUYuUNleg9ptLyEF42vXnPZxmO1xV9MSRHb7e4ZyPwena8S6MKSdJmt7eD7YJY2dsw9THRCYF
 nNppyhSeDF/lTGxQJfnokaZh7RZP13RQWi4jgxerpwbDDIVJRdHNuNjqhSDFUi5U1LGp+mO5ARq
 FwHTfLCLxBOMb2ApCXHfNOsFL6FGCf+/lQ2lrDuuWcJqte7a0v+7jjORTaJ088Z/JRkjoA8j/vX
 O4MquN+yrsSSvEFqJ2gLQTORF8/BHb9UKwNKEUav8i+v8g+HjT7SEOAxTSKNGq/XsmU7sbZRTsk
 x020h87pdSXff4h2PB7+cwVWfaIWKE0SzuBVZw5lA6M/odL5Gf85za2HjFeFHe7Ku9QVnB/pQh3
 mpFgQm/8RFtshHoA2t7I4Q7PdLfQu2TVFlvwfbC4AKn7B5Ill4Qi2XzE+q/uBogGGSxbmZd9Eoi
 MWlo3jKGc3HpogA==
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
index 097d2f331a16..59c68432f8e1 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -10,6 +10,7 @@
  *  Eric Anholt <eric@anholt.net>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -63,6 +64,19 @@
 
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
 
@@ -136,7 +150,11 @@ static int tc358762_init(struct tc358762 *ctx)
 
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

