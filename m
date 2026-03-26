Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5310E10A62CA
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C74E10E2B3;
	Thu, 26 Mar 2026 13:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rIOtZ7nc";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F8010E2B3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:36 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 449B7F90;
 Thu, 26 Mar 2026 14:11:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774530677;
 bh=tUPCwk9RutYoAa7a2LRuYv47/hgSBZUcX/gp3JO4ClU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rIOtZ7ncy2jaGHRCmRsojaTeemahdkei8hJJY19hXSh4vZTUCkPV5wcbB1q/aL/r2
 gWp+TN/PLrqA5nZNQINqpYQ03078ST1+buMeF42BVprIfngtog+szNdH8RTeWU79yf
 GE54ApjbK1dRWY6c+n5lGzEQRva5kk7Jvnw28R6w=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 26 Mar 2026 15:12:12 +0200
Subject: [PATCH 2/8] drm/bridge: tc358762: Improce SYSCTRL register defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tc358762-fixes-v1-2-65f479227af5@ideasonboard.com>
References: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
In-Reply-To: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=tUPCwk9RutYoAa7a2LRuYv47/hgSBZUcX/gp3JO4ClU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxTC+5mjMXG7TQmsu2XeOQrs66sS3wTGs9EMX5
 bf492wODN+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacUwvgAKCRD6PaqMvJYe
 9VR6D/4tcafSrYbh2vvwRbtUnxUgkqGWDL8TzzOLdur/DXn3p/btWzHobbrKQ7NVxpBHu1Kqhov
 iXAfsiWhR9I9yk9U/OMVcIyz0MsT3FdVOu606lx+LbjwQycS7V5YnkhJz8f+bt43wKJmWRJLsv6
 EtRlfgQ1RoXAKOLkbt844Mg3CaUvOeeTobc7s58Ur9iQfx5e/8iAh/Odg/V5WGYiyK55jkDufJG
 idb8g0f5Rm5GXUIHr5VKMHz5SHxv3QJquUIVuIhoDL6ntEnPojve83tXL5H96lYKt9PvZwLJi9q
 6G1So2dQrTCh9bDoRW9BA6P+5jBXiTrhG1LlWOREXHtosU4psfBKeyxxSS+IpySU5+r1dgD5XNR
 59x11K1Rtnvhx7bKG9q3QufHoLDRNNSGHvA4+KiikJMJLiXiBedS+aDaQtWZk8irINmpfTC0Uxw
 VaXvpQPeudqz6hU0TF/judCzkhtxSqyjTd6XPUYcGvvizzQf/dRH6aSlkykE1u3ZUlanVWQGdzY
 gLpAx8WsyAgTweuIEHDv+WU7pTKuyZP/+BUdS2URJBpkhTb+PODZcvcCF+2qvCBHAfOtwsY/bxs
 5jSxl7wbfcWaTcdj86G5MixdYJXjaka9bHCWuFirSuAowmLAhATestyAgfeZ2+rke4lrSpJZn5a
 CrZr8Zqw5jHRGQA==
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
 drivers/gpu/drm/bridge/tc358762.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 833fd9913c75..9a0b1f0c18f0 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -64,6 +64,19 @@
 
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
 
@@ -137,7 +150,11 @@ static int tc358762_init(struct tc358762 *ctx)
 
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

