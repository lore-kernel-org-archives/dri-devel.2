Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1B610ED659
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEBF10ED24;
	Fri, 27 Mar 2026 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bd6pv+oE";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A9F10E35D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:26 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 566561F37;
 Fri, 27 Mar 2026 11:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606866;
 bh=tUPCwk9RutYoAa7a2LRuYv47/hgSBZUcX/gp3JO4ClU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bd6pv+oEk80txaXgXBctysFXqD9rmHWpoO1UscarloF3keAFbW9Nmf2afVLldEn7b
 HEFp+87P1bWvp6bjt7+hmIgB0+2wiF5ePiNJR5dC9NtO2iU2jnSMb12mkgmKZrnwuo
 YsmsnFdQyLeubCpwDleILbYQWtj2EsTwJ5m+rF0M=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:50 +0200
Subject: [PATCH v2 02/12] drm/bridge: tc358762: Improce SYSCTRL register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-2-3589d3c45f4a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=tUPCwk9RutYoAa7a2LRuYv47/hgSBZUcX/gp3JO4ClU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpa8d0qXiEMIaOUfieO9a8ktDmPJ1oZf5gaj
 lrGE16daRmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaWgAKCRD6PaqMvJYe
 9f/WEACqis5CedE5sDAN0Uo6YeY3qgtXQm3yiQvL20NyXib/gIcQ/owsqjZZhAyVUu2uhsd5R+W
 t8BHCEALib3/14/JmvVLoNIM002LdxxlUetbgAZNiphfj9aIq472vLHJBZT2dkjtEDjm8GHnYbP
 wDW4JpeV9k88IQQno3CgXpttrpwgwoWHCkrpgPklnbuInd4GGDA8thNLOeFJ+m41zcs9a/RE6NL
 QNkuTyT8Hjza8qikBCVnbq6LSIuyZHZGFMQqT8tEO7TXOJHH79UqYiOPqiX9MMqyvGjr9hd5XSW
 em8RiXQpuXY2zNJZ7UaMQo97V1sWZkRCQTnIaoQPWFDW6oCzmdQ9Pqn2GruYX5AMdq2rd74UiCz
 s3nVOrOBEBPLkomFYx3Yp0MRxZ4T6aBuLvoaH2KvDi5GWOq98Kise0Vaq/9sYsxK3+aPg8VABj1
 4HJFC2Wp26hKTY+MRgpCjyHLE29iqgdkHnAZTmdCyvAlo4P3YAaFjrVK6IIfXuxRHYCumjSPndo
 flYotxw4fJGzk3a6nwMZ0eWEfpLK/deVg8SAG/RnD3fQzsQcWV8UZhV/ZyqrJR5N4G8brujSkAU
 VIO7L9rQEgfuKBtzIjfR6oP/XVfx4BPss+LMJDopXAZVM/OzXo1XTAx+J0K36GGDFwaSdvQRHYd
 8hpi3pYHrUW+MYw==
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

