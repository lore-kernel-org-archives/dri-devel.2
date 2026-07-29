Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EE6C54F52
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9801C10EC07;
	Wed, 29 Jul 2026 12:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TorweTH/";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5140A10EBCB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:29 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1036084f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329728; x=1785934528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nws/vK/FIfDSac0GAtMHBRQdRs8Fl0UkisvSO1h3SQs=;
 b=TorweTH/HuSAnI7lrCT6P5dhcixz5UpkXraHy5MgMwajpWWIpOJGBxWCKLjSLS0VuG
 0D+vYu/kZa7jzrg6Uo0UOmen/Y66U2AnTjjST0EqdaMqQJQe0w0FXBxpWo7QtlaYmhyG
 R9R2fvpo0fTz1Lv44mLRiuJcurgI9soUsOfYV53bpWKm/rteTT763fMrwELkLhtugNYc
 I3oqC9ynN5yCosRglyXgjeMonCfaTs5btJP5PPA271qrIc3xUKaqXYd4ceVhVS51a5Ob
 rbG0Nw1pU6KmnMXWpBIGKomE1mh9m2We7zr9k9hrtveT8RzBcmxQFqIH7hrqraPFq682
 kRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329728; x=1785934528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nws/vK/FIfDSac0GAtMHBRQdRs8Fl0UkisvSO1h3SQs=;
 b=eyZ9aKfYIf/CKtbyA9Zz97SCwlEi1SG3RPpx45AmwWHdukpwsFokSUmGnsUIky98Jb
 PSQ8Rt0W9IIZrIrV4P9D4YfJ5Dm2STB3r9ye++YSFtQx0lUc9FqEcWmeTZPeFR6gvV4n
 tQjYL2yCemDO9dAm+wXR/pF1guUHzZMEVRiBBMXbMqCdvkJndgNV32BxH3UYYpGelMgt
 pyQGRHBFIG+yFgqcQVpXtcZo9FrgVpWiRBjopkKyjocb3+WGrLxFZywfNUVwFNUxb7kY
 6IScCm/KdKJ6riehpslVIhlRgtGYNwCd8THdYXfMNpew1o9gBP5VPlGCs4PhalRLj58a
 lNkw==
X-Gm-Message-State: AOJu0Yyg2QRNSUicE9swjp2O2lPx5scontzdUPjVawsARgKmDkNC6hTv
 /mV9QA3fiH3e1K1pX0+hh22TRs6zd8UDn0uN51iZLX21WYHVVobOiMdB
X-Gm-Gg: AR+sD13BUu2w3eRodwWQfwQWI0kk7Kf8eEZbtoNW1fHYNAIud+thvaMjjs3JLAGBjHe
 DnckrbyRGBJGndVPNSR8ce0UhTHA6Nr/rE67Cm6ZKo82zSYaO6dL+BSEPnpBzoxRSHmD16F97ga
 eWNRvhiUf+XUalbjIXvcZdvxhO9N4n43c1i28osA27G2lzDPMbCYA9jK1JZCDRmRR+dph8t/jSe
 o218toD8cy7Q/GhEaO6zfAdpR0NF5TEBqTE/A6NcwUeAj0PhYnC/VvXvXuRXAxvVjrt2JcXIuhU
 A2xtXoAipoVCwA8t8gQHWfc3baEmyrbG28AqtWfMJSNnvAcz0MtNd0/r1btDD3QxXUv465iWVvL
 ez3hTfgnFRgsXAS9tylXdc/dZoiWqAaLhDwBm/AV2nIKpBjLS7vNhoL6GUKU+pmiXBW+BGRq6gG
 pL8pv7uwBRMIYdgOie1VSXv3GmREJvsZDZ9l2NmvcxRaG3oLio5aBHeKsgYgBedBxSpVZYj9UEg
 TnM2s3q28GuqQ==
X-Received: by 2002:a05:6000:2f81:b0:47f:8f54:125f with SMTP id
 ffacd0b85a97d-47fb1e82754mr8565001f8f.7.1785329727610; 
 Wed, 29 Jul 2026 05:55:27 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 03/16] drm: renesas: rzg2l_mipi_dsi: Add activation_dly to
 hw_info
Date: Wed, 29 Jul 2026 13:54:55 +0100
Message-ID: <20260729125516.230757-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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

Move the post-reset activation delay into the hw_info structure as
activation_dly, allowing SoC-specific values to be defined per
compatible. This prepares the driver for supporting SoCs that require a
different delay after reset deassertion.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 2128fd16ebc9..1538eeece2b5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -59,6 +59,7 @@ struct rzg2l_mipi_dsi_hw_info {
 	u32 dphyctrl0_init_val;
 	unsigned long min_dclk;
 	unsigned long max_dclk;
+	u16 activation_dly;
 	u8 features;
 };
 
@@ -806,7 +807,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 		if (ret < 0)
 			goto err_phy;
 
-		fsleep(1000);
+		fsleep(dsi->info->activation_dly);
 	}
 
 	return 0;
@@ -1534,6 +1535,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
 	.min_dclk = 5803,
 	.max_dclk = 148500,
+	.activation_dly = 1000,
 };
 
 static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
-- 
2.43.0

