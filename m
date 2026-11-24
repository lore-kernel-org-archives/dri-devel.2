Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFB606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=B/LnkZrM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8B410F42D;
	Tue, 24 Nov 2026 10:09:31 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F143210F41A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:33 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A7921AED;
 Tue, 24 Nov 2026 11:05:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514760;
 bh=95B6XxOlyHoEyrwSZvIyIl6muJUPXqc9RynHldBHXsM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=B/LnkZrM/ZQ3UE4AC0Jb/ZrchVUpCQwxQmnSvd5kqk6fdkxTqhw/8GH1IBOnsR7z0
 DrgILXUAvCgVPawBj/X0ynnhb58uhD2qc/aDhkM3DmuqOz1T1lhhj8AFN18SplepkN
 7p9CzbaW6rGlCv1rBq67sV78yjNmTVYB/lEMXcug=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:07:55 +0200
Subject: [PATCH v6 04/13] drm/bridge: tc358762: Configure SYSCTRL first
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-4-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
In-Reply-To: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=95B6XxOlyHoEyrwSZvIyIl6muJUPXqc9RynHldBHXsM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIXDsBDEjEho+ub2BQu725HZPF7TDuTbaV+M
 tJh5kyM7YuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViFwAKCRD6PaqMvJYe
 9UQjD/9a+cR8tS/kzQEA+MaHo4TVAcYp5bVy9kFM7Zm6ho7DcjHFdbgrWRZ8kuooFr5rzLDCWIz
 FKwEhdLuHEEoWzLBOjrg676M75srJRQ/v5XbP//jm3EM1gqprd/M8V8kNBAgEO36aGxgWkBOSzp
 PNGRq9NeoES0/ftXTH8Psxeh2VCvr4mmLI+lDke2xgtgY3Z4ML7G2MzVU7xUNGma+jaGECtFCM8
 KKnW7wzpGBEKRWinOFgjQ/EFuJOB9ePv0jVwX9JA75GxQukhPfPvBDBbnkY+IrU4UMiSZRFRVB7
 +n/KKUJLdm+ktFIgik0kPIXUikv7gYe33PPHWyGtXm7/qW9TyBAdopLbWqGM/iM0u+VZfk2UDkA
 co6Aq8ztHJDc6tT/6Y3RS5Y3BohZBoZyIO7VNwmtoLV0X4QyQIf8/xu//5D6i2vAXVo9tkPqhLg
 2MkOJLPXU9aMSAG30NU0lMU55YzTYfeFp4Q7i8bO3lKShO8jq2x0iUFtVvmwrPXjNhzq/rcuz5W
 PghV0rUUl0Gghz8n1MgduOYV8w8kRUsiOmRVIi/awEZdcT6nfD6yDfarqiU9gVBeDS5DyyUjsyT
 9jZWn73kbFvRNYM6WtTZe8PHiRp8JR50zGq7BPQGNR/G+G950Zepjurt5goX//DDDncwR+j6tWQ
 /+Th6ZKKG0BS+6Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SYSCTRL affects the DPI output and the clock tree, but we configure it
late, when the DPI output is already enabled and clocks are running.

Move the SYSCTRL configuration to the beginning, before anything is
enabled.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
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

