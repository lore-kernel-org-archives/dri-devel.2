Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586BFB44C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2878F10F388;
	Fri, 24 Apr 2026 07:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caUZyxrp";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DD010E289
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:59:37 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so40954795ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776949177; x=1777553977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEBu1ljzt3vE7YWnmdy9zgFophEUplDcH9zsPRouB9c=;
 b=caUZyxrpScdiW2H6g43D3ZrpAf8ezzZlHg+LUzmEGLP8tJSm86qTqqQdEfpvNu6R7a
 BODY5Ai0S4jjz7bx+LNxIqTtDLAjfNIj0cvyNnK4nyMfkC+y+KNdti8aZhG22BbsKofn
 ASSO7GLI7KrL63PeqDD0+Q5toNYldCWqC4iUpAZI0Ol0jD32uy2G8iAh3aDQxpFyoGqI
 4dOjIYLfzkCiM/qEq+++aEtdn/stsiYh3cVx1PWy8sZkdVCJKCxAZ2d/ncbEzOgOuZG1
 wD1PeepQxURknxl+yLcvw2fdGYeH3owZhDmqEJlnrY3JGlLRcy7NmOOrZvrnAPMdPkKj
 0/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776949177; x=1777553977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEBu1ljzt3vE7YWnmdy9zgFophEUplDcH9zsPRouB9c=;
 b=B1ehxztQrN0GiBDIVt7yXOzVBsMbSc7TZBucrH9FGE+wjOh4uqcIgFGB1gmAkJ9OaC
 /Mzz2gnwjb2SNNOWgJxV8kck9ju6z07rlQr/qux1flDTuy9rKxYASrwA4n9HtDPXP1sO
 zdVhnFzPFNho2elCpMAxneunOGqB8N25kCZVHwtddz65XbFHToCE0w/QxErplD9T98CT
 cOOdclZxs3crlSir+I4jx7GOr4IEs465ZfvOO10ZOUAwsDZnS6rxEln0WI12PnPf+Pok
 RxL+vUeiGKblxFemp5G7vxzJiGyGp8pGmNf1CTBhz3wfIsB/wHY8BEGpOwdDVSBmdfvB
 Glsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d9BrdWDsLwYbrxAkUGDnv8TNDYHgm7uFwGn5P0qL4sQTMLuHB/ksLw8lCB56NFVvPJl2yDvg4G08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPJ/UymkyDup/2+/MAItTEI/lZy88Oy6a16DCPXS1fe5Cq0Iu+
 IC4LDyUUUzTDmGdxTumPBWJ/frY54Ks0kqP50MFo7lb4UMUbcLpCahM=
X-Gm-Gg: AeBDiet17gNdmcW7ccwUm77i3UUCKhidufWoyL1/dTzkMJbqmOLDKDqJK4maFHvPc4p
 PvYWPYK1UCodZozja2Q8FFOzHknf6t+nCtbwu7VzTLf5C6KJglQtPIkCKypHv6LiEpO5D1ubvQG
 3MkzXOZSYKioiiAUvhRVL/8WigniLXK+G16bBUd1gSVn77wiiCBiK74J4hXnQac+mU34b+o9/qJ
 xrhmghAHBBrurlu48i7demodfaeLPuNKDEPK+KSbmxYYpHXAMGdaCYMPoAryow0mghAVKpFTe2p
 kThsRTHS2eU3rPg8nsW9NJtoIE4hvbGXfNRdwxe6aJogjTAPVb59JSPGnU0+sZRQRV5YlNtCWYX
 B70xfKEzHYcI0QDmN/UZV9BmVdPBhHXnoLC3VDeY8rCr4vvoTjO0KjKkxWge8a94U0PMb6cBMVZ
 Z0kEPWF32CBS6ScqL7CPV9og/C4IZcBpAfx7hi/yUidJct7OB/3EWLljBHT/S0bmjlu4z1uOcEa
 zNDTOX5G/ErmU5aMs2v
X-Received: by 2002:a17:903:28cb:b0:2b4:59d4:9a with SMTP id
 d9443c01a7336-2b5f9e77d80mr204836995ad.2.1776949177223; 
 Thu, 23 Apr 2026 05:59:37 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab28e35sm193499065ad.64.2026.04.23.05.59.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 05:59:36 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH v2 1/3] drm/panel: ilitek-ili9881c: use devm_drm_panel_add()
Date: Thu, 23 Apr 2026 21:59:20 +0900
Message-ID: <20260423125922.57428-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260423125922.57428-1-mhun512@gmail.com>
References: <20260423125922.57428-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

Replace drm_panel_add()/drm_panel_remove() with devm_drm_panel_add()
now that drm-misc-next provides it. This keeps panel deregistration tied
to the device lifetime and removes the manual cleanup from the remove
callback.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 0652cdb57d..bc3cd9a182 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2590,7 +2590,9 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n");
 
 	dsi->mode_flags = ctx->desc->mode_flags;
 	dsi->format = MIPI_DSI_FMT_RGB888;
@@ -2601,10 +2603,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 
 static void ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	struct ili9881c *ctx = mipi_dsi_get_drvdata(dsi);
-
 	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
 }
 
 static const struct ili9881c_desc lhr050h41_desc = {
-- 
2.47.1

