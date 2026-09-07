Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50827C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5EC10E771;
	Mon,  7 Sep 2026 11:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uQPL3XjT";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE6E10E4AB
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:28 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D3741104A;
 Mon,  7 Sep 2026 13:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788780412;
 bh=R3FaNQrlNb86xfalGaX8Aw8wDMwPPadvb26T0rMm/AI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=uQPL3XjTQpqPIV6uKyJwv6pHSTDhbscPdhh+MCu7owy/NKVeHdkg7tWT6GrJyenV3
 C/rico9EU1+gJQw3mRbMdZ6rmRk56XYfEMdeyoix9BZAmkYmSxr43U3NZVYnZgd3B2
 LIsWn0g1QYFabYNtn9NM5GdjFho9jYvTdzoFCi1A=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:27:59 +0300
Subject: [PATCH v4 04/13] drm/bridge: tc358762: Configure SYSCTRL first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tc358762-fixes-v4-4-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
In-Reply-To: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
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
 bh=R3FaNQrlNb86xfalGaX8Aw8wDMwPPadvb26T0rMm/AI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnp/SS1/qBvMsSFVmdKQChMYxG3RdU3MK9glCP
 r9nSmbMOheJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6f0gAKCRD6PaqMvJYe
 9c4VD/4s0qpc/X1zfHeiNyvXpNa6mynQnLMjs2OneAJVzZ2WTZiLJYppykYUHq4CQKmG17Ycuk5
 Qay7REzz1BX3/nkwUiUfsMOG+llzDYasNlTQAsGiK7RkyfFo4NoivXzhf2R0nB8IHULNemeys5z
 hR9f65XgXsd0UjuEDA5LhH43hVIHJjfSeEyfJb7ZDzZzZwM73MErAKZNuCMYg2LOYxvr2bMjGYL
 i9Iq4cevHBCZ2V5ph1bQBpIuvgvnXy01pvKAH3xtYivRr5Rt6NUOIU02REqG6aIg9wIl9ZU6qRP
 wsZNKvPiyspo7xKftZTFzvKGvSfvtRaAOSi9H1VjBZelpfjSC+Zqr/rhmeW+mn5Sl3mR1l4J02Z
 bvU+MBMHVtPv3z70dEctkpI7cQvNJ27aLzTMdWgAIYP3+5skFlNGrnSC4kf7S8w7/9Odvuz06Xi
 62DtMqNG2gr0byaFNuE8UqqiapSpI3FBZeJ/VTNrs0K7seUR+Z9pKJxURy5zBEaCPp1Vw5lHPx6
 +f+gLpwR4RcdTPOOi0Sc6SJKhp6Qg8WSBc/48ifZEDNTUFkDYd8EFoAYin/o6QOf4BmZ/KGiQDW
 j9OgWqqTTlV6GxK47I4HG7XIOgctqr1papBbDkeCmR/LL5/4fRw+1winpg1kEtpWjAkrXMWYRFh
 RVHI3YhbyylHYRg==
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
index fcd741f5765d..eb6e6ad5b6a1 100644
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

