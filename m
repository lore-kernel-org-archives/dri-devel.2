Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE18010ED651
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087E110ECD7;
	Fri, 27 Mar 2026 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SiN1tJT0";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4529B10E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:28 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4687720B1;
 Fri, 27 Mar 2026 11:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606868;
 bh=kXEBX6aktrNXxxPjgSs66smVTLORZLIDKgjSxczFR7U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SiN1tJT0hFvNS3ysjzsXqbYqc/EEBbHz3ZtiAtVIaztL7HHD/e551eSP0YJySNaJs
 eDFW3o3aDd7sdSUQgpliaDKJoDWYSE2WsozxDZ1OInJQw2gxeb3+m008QeRhteL3D9
 TELffqDpRfIow9qLS3N0OFB5NUP6TE7VGOUoFvK4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:52 +0200
Subject: [PATCH v2 04/12] drm/bridge: tc358762: Configure SYSCTRL first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-4-3589d3c45f4a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=kXEBX6aktrNXxxPjgSs66smVTLORZLIDKgjSxczFR7U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpbnS/v6u6HoN7+ye5GmbfvoMUY/5yECTcmj
 E0EwEamAJuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaWwAKCRD6PaqMvJYe
 9XnqD/0WFsh2fl9+hlduIhlAVLv/pWYjHgzuqadKDfi8t4JOYTfVb9b4VIhU8SyPJCjztiS5OpF
 5wCXxROkYsQ+Oe04gnmxYqWdEclYe38Ef0AJvvxr8x4chyP0q7CscEwxPH+db41m0/O2Q1vWZYx
 +imhtDtZj41qavHHQPrXtWdmcQl1DL70qvkhR6YXf0QOyd6C/T0Lx1PT9y/yEG6fFbX7ZurNpN5
 jg7g30bZM7CfjJ0lA55NgT/NYR2f+k2SVGBlL7NhDEsaXZp6D6Xq9tazh1BvcsiDpnprWhGSKtr
 X+Cx0CxB3zCoYoYMd+Tk2N7+SoUbaoKd7PKfvub85A9SNIkoFV8o17Hfhim9C6lnf6eFzp96Pqo
 Ds1gEvfnMQGHXOdRuEkMyDFD063GlYMKKUz8Cb++KPWz2sj5csDjLUnwp5y3Csu6EGhBGN+GmKx
 aZGolaRtp7q7qm9J6AEz+j0N30bkUpmcudxeUsWn1l4SUtRljCVaJ/+sH3aWa1dOFWGeyq8rdoX
 Ke0u6AbI0x4nD+7Yj4R1Yir8Oe7vsw8SsjnmelDEC4v13pHlcafgCx7gQG4j6cBzN35/DF8VaXA
 9blOZkiZ3D7989AARk2aq/M7PsyVePqh+LnX9G7Ic1SUXEilRZ5qHlZnKHGxuroIqOtU75hutVZ
 eLFZdbLthEeq4dg==
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

