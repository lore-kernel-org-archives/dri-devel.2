Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2C4CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE1E10EE67;
	Wed, 13 May 2026 13:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bD/O7PsD";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD83810EE51
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:45 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97B56E0D;
 Wed, 13 May 2026 15:10:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677836;
 bh=pCzMVMS3iSPdf41tahdSFi2W5/nHuHdB6E9VIqlktpA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bD/O7PsDF2a2Wcs9miQ01wTuL2Xa5jpGACAhXaLpIGVj6sBki1MdwdJcL6+hQFEN3
 Q5UEb4qEJSYPT8RLq+KOYYBsDWyXSHrICmBVYZKhxP0OZjbcyPRE968Or6H4y55AiV
 roesU9Z2kZdC0+lWF97oNRBCDSfGESvFKLqwMoKk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:13 +0300
Subject: [PATCH v3 04/13] drm/bridge: tc358762: Configure SYSCTRL first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-4-6698b55008b9@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=pCzMVMS3iSPdf41tahdSFi2W5/nHuHdB6E9VIqlktpA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhL6EJO/ZRZ3Gj1w61fRsk92zfgequFiYYrD
 SD8lG/AQFyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4SwAKCRD6PaqMvJYe
 9SSHD/0bBjla3gJTQnVIlnQfVsvZ5F9BCno2p84Du3wW/xurvQptk4Ga8Gm/60nOXOKvm7y+MUa
 bpWHb2UsqnUxi4SjGxIHcXuby51b1zhiC8o73zs1uw/5zviYfByTGDFSm2hKN5hQWSAxlW8iaro
 gTQ+KyVOLHg2R+jROjsQb/N1IdjfmEAbAw+ByDGI0+jG7iwDh0bjVRRCow/SiwH4kMdGn9aANVY
 Pp4+FD38BjlyRT2uLHm/Dfnuxx3qq2GSxN7ekhhFbnCfz6btlFY8uJZ/RwBCQrMt6yY364xTfbM
 RnuMpzeI8WfMEgbmgloebvoMugSd8dtD3Wb0FAZKyR6lSkzScsA56VU7N7IRw3irAiFQw+bo6eI
 7myCcxkdwKLSt3gx0ViUivTky07CwCHFSPjF5vVqdY5VBhIxgwiqvx0PJGcPUoQzWW6Xhap3diW
 oxdAQbWJHOyQwjwA3FJPKXQklhZLqCYyNQ3905qhPToaR9SLlcUihTgKF5MKT1ctwvPQfJbhIZB
 CaRnivFC+i8fWuDEkwhNljEoEx2f6aRbfM2EnAdb241Sjokc3nXo6XWVUtpAp07JiOjMXtzlLZ/
 gv9R281N2jGPs1MyaQbBeiFRRK3xl/h7MbstUjeAFBHu9ZiDzQAth2JzQK9HNUEWBHpfUxkxvXu
 ZvUFZxtfVArRGtw==
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
index 669052074974..d119e399f7a2 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -135,6 +135,13 @@ static int tc358762_init(struct tc358762 *ctx)
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
@@ -158,13 +165,6 @@ static int tc358762_init(struct tc358762 *ctx)
 
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

