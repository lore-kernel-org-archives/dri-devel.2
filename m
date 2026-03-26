Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F3810A62CA
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D8310E92E;
	Thu, 26 Mar 2026 13:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FP/yjNnI";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D1A10E213
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:38 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 104C311EB;
 Thu, 26 Mar 2026 14:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774530678;
 bh=kXEBX6aktrNXxxPjgSs66smVTLORZLIDKgjSxczFR7U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FP/yjNnIId7im5sRcaVRX8Dl9SSVRKdgh7HE44/vivKb0VaNpSasQVBTxlfUR76DE
 T7PXF48MzutPA76CDTMiwem3agXRspn5sSVsLliEu0x6HKqmsf9XI0qwjboqiT9y9n
 uZZiAXLrIaTMJCy3yXsDwljXanEqZYiKDkIwfmaQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 26 Mar 2026 15:12:14 +0200
Subject: [PATCH 4/8] drm/bridge: tc358762: Configure SYSCTRL first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tc358762-fixes-v1-4-65f479227af5@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=kXEBX6aktrNXxxPjgSs66smVTLORZLIDKgjSxczFR7U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxTC+J1M7nueUSN4j2rkrjp7d4olSoCPFzpwWW
 tBGuOfDN5mJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacUwvgAKCRD6PaqMvJYe
 9ZaPD/4tG6GPM8QNhA8dzVZwTvfGn8qB5VTALEaSmyKjVw1lvYt+9p0Og4tlAMk2OeM8XNPe/e+
 nIOWl+VxG/IlkTBFgGdaE+w3+S/YxO7HHpANPcnMBUd2KmqGVsS+Pr9GU5qpQT6InVFb8eP9OTh
 K2+0jqdbxVGP280KRI1tlUom+SMIfqt33yxe1qWWeHh0VIr39CZw8MH1KsPbFmJYwGbvI3+ELq5
 32/bXy/vju+j3fgh1LXtOr7OPMous9OMFSqNZMa4FhDgrHFuGzDVh51gvZiAZ/YarxEJIzT+xv7
 2A87irhcFnZB6OjcOtLKeP3lNDNya0o+eUygSFSezBIVHHW2iF/VMKNh08WFo/VGaJCX0AGhxkQ
 EjZZMfP6NVGzvFeGTEU3gJHcECLamkg+1gEHXo1u8eUXrZDQHwxeeRLPtp/g7c7IPiMIrbRvUlt
 53brmlDV0tT3YtWJwg52KXmPf6mXzGgQ+9ZuLjPma4p9b+jXgV+z+g9Vdombk54BZBHc7VVbbGo
 bkNgZToNjAuMUtHC+alT7Oaxw6dygyGsi0uaQ55vzz5OOfk3jX0TPdG9ULf7MXTor99x5IMjVIf
 te8kZwTwl6rEhYTixEPrTCVLEejxRsMGB4egyIT62DM9lhy2jj2ZJmTEtJIjxH/1Ze7wFNcjAjk
 w8bBtFylUEslm0A==
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
index cbedffb7a705..053579591dba 100644
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

