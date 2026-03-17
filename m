Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00758FD8763
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B55910E626;
	Tue, 17 Mar 2026 12:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EVeXcGjt";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0915310E5C3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:36:16 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so529580f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773750975; x=1774355775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxJ5pMJ4op4YCbXsnXfCwBV/YmtiAWSGD2H1bAEJVn4=;
 b=EVeXcGjt251rseSJdc/L2cIKrlEhC4jDcJprvPndkfdLlw7C3JndEMFsrmT/Y+ggr2
 fpIxwVBmARnWDPFMYOHlzFu3Ai+MgE6qh6y4COqTiCeCdUnqMs4M3pVTwSZ6FLaZTPci
 4BAbcn3l3MRl3NeXPMS7Lv2wtVNJrXxq6PDKpl04j2g1o9G0j5+/3V72A7eHOzI0hQcC
 bBpPebUL1sRuPJzCePPBmHBOGgEtyGgMEaa+HO9ul9luOxXwwKzNUCkNHwZ12BstoYsf
 m8Fo7iwOKuIwbvG213mtvSCTUChiBksBxXDJ5mcu3wojWSdDH0WBhiSS6jr4uKPN0okP
 4kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773750975; x=1774355775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NxJ5pMJ4op4YCbXsnXfCwBV/YmtiAWSGD2H1bAEJVn4=;
 b=L/FH6whZIBI8zactcpBuKgKuYVG/LXrE8Lmh9AgZdZOM4t3sNlak+G2qTJjrV5Wu4C
 BwqD9gS6hyoeZPmrVeeSedCnEU5l1eDotGg6dKpddA2XI4I/1P+CzZBg3OoJTm53B/d0
 yXr67r/7NWssDf4EBNOsbl3BwznHx2r8yB3Jbei+9cJgSlNLZEug9kLwLcLMV70g13Ua
 i8xBDY2l0ooUCYGGz6F6Vv0wxJQr7eRfo5ESGH9PiJoO+jeLCBnIua+ukf5lOCqtv/qf
 PlPSbtgxFhfhK0AX0FDAs9SGSd/gyROATMa3WSFyRAk/1fAOkaKisHVto/cvxtBgd7Tw
 3NOQ==
X-Gm-Message-State: AOJu0YwnJ5pa+Rs/QI+65ELdjqWJSxDy9cpe1YDNnKnesdiOEVkZnD+s
 RYTSY9odyUDdn7SwS6OqDvlpcuTG2IoKFZQkXMUGvMsgqIN6w8VlDfF9
X-Gm-Gg: ATEYQzyZvR375OYmS8bA0KEWBRRBbBUfqzj4dV+OrxCkMsfB4xJvhej2V8jlxolumMo
 TCHQiRw6BPtIip6YtWSu7SI6x9AOBWOlikb2y23nYCkgLmFCkZ8lHdIGY8TS2QL65U5BI4xHsAv
 qq0BBGoqEYoCfImm4Nn8NMJwR5L1Lfkl7SWWQKNZqhnvbDALIOfvc0H7M5uuxBdwoqF++WkUXgj
 g01UrUt9JiYkn1Gh4eMo6sSh/7J8mq65XGKVcfBfomS3T6Qr8U1x84nNHxlr7nFw0vWluWNVjZ6
 hBcwVeyd+jg5pUgCxUUBcDwsWwWYTL1KUXh6HeDddzBBBRDJGx7tNySM0y8nzADhkkIWcpYRanT
 7Oi9Kx1GavIGZTyPgS81l0K+SeRkcDKRyquZBQHV7wnxno23iuvRVAPYBp6oHLu06a+rcZBEJWt
 WqxbBiNDT4zrk6BTXO3VpxOOOlhYISnSD4EqRlyCuVwvRx2YETjgHdhy4OsBw=
X-Received: by 2002:a05:6000:24c5:b0:439:c078:9a57 with SMTP id
 ffacd0b85a97d-43b498330d9mr6248986f8f.25.1773750975272; 
 Tue, 17 Mar 2026 05:36:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b4f845841sm3247444f8f.11.2026.03.17.05.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 05:36:14 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 1/2] drm: renesas: rzg2l_mipi_dsi: Use fsleep() for 1ms delay
 in D-PHY init
Date: Tue, 17 Mar 2026 12:36:00 +0000
Message-ID: <20260317123610.329630-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
References: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace udelay(1) with fsleep(1000) in rzg2l_mipi_dsi_dphy_init() to
follow the power-on sequence described in Figure 34.5 of section
"34.4.2.1 Reset" of the RZ/G2L hardware manual Rev.1.50 May 2025.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index a87a301326c7..e53b48e4de56 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -528,7 +528,7 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	if (ret < 0)
 		return ret;
 
-	udelay(1);
+	fsleep(1000);
 
 	return 0;
 }
-- 
2.43.0

