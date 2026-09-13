Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B47C88E66
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2F810E8F2;
	Sun, 13 Sep 2026 13:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lTfVxqfK";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4724F10E8F2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:19:01 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1cebad4adso1074524a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789305541; x=1789910341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BzrAlMcZ8zBRfbQWU5o3RvRaRsPXz8ZJNVxN53VL4HY=;
 b=lTfVxqfKy0q8AXeN/2wiTvT1NsTX+VvuDkJAl4gS6wmRRyBpXi38kh6b+2x8j/6Z8R
 0s5suHYFzLqhBh/q4PMWyLluWD3Pd6vglFmSo4PzUMQp1xdPZwm2bTsIGHCGRo9BcMSS
 XP8CiS9taboqE2bEajy7HFEus/bKzmNaREL6Th5iOwPTEJB5fC/91urugkkAg7mMgPa1
 K5PgJLZp2pxjebINV/tuPF0CA5MX3phK0cTJFiIgtQg5fPlyv7n29970tg/pF0QXC447
 T8/DPfa3QYGaVlUCrWNSdoPzHmc/DCJ9TUQHhHuxDghPFf8k9HuUewJNjNzjM+Kf8pS4
 DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789305541; x=1789910341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BzrAlMcZ8zBRfbQWU5o3RvRaRsPXz8ZJNVxN53VL4HY=;
 b=kgdDvYLIaXeUjz5t1mSOZpnBVkGIGNhhDMABuEeOy4muWJCHOWjOLqfcFDESzbDhNh
 2ZYWQhcW2R4UFH3NBY5hxXQqrHiifd7UjUeiHXRcG0/koM1B5Yh1Pz92yUIU3WQcRH8k
 ar62iiDHRHYdLPbyPUo5Y5TWgV2KW3ltYuI4MotbVDXn72aBOKSd/dgc8D6Q9P6HYXYW
 Y3oFY8BSPBaukOMfzYfoDXDOPM9bM1D1sfbOS4Wke+AAyRZbZYHa1bzKFs3WLpKRfwX9
 MzHzIr9HwjsXG35w+TZNdq2+3wQrQb/mtSoQUSdmwsAvt4n2fIqWhFH4MbG7tg5NvTFg
 Zk2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXF28aqiBXA9w+US1c2cPJGGuInuX3N5KPbN63CS9V97+VDw3ydG9NWgl/G1VGw06bQV0ASgqgvQ4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqtZid/GdDaj2JqUVfkVTp5yq9fzk1GCpEZTKds2qrz+MKPbF9
 2Sj976IoKa7VbknuVlVHG0IAt/Kvsv7wOj7BpPI+tiIGYHN7fXvlVQFe
X-Gm-Gg: AYBFou1WiU1/4yfXEyNMTEhGgIFL9telOowauCJGRXqhrVJwYe7B3bpZQ+n89GdmEQG
 rUoh1qgvD3QJBEhwvgoJbPce6PbxJwSS+yyMaO7gWg1QQELF5KGMa0iHUOoAoVwJ3RWEUapzeK6
 MjYYpjeKUzKBPWE1EtX7GmU1GcH+2jjaiZ1o6fWPTHDMWA4/wj/nlR0GgJ9L5MWAnISnoLnbbi2
 31MnUk9+GcJyBBvxgLvWJr26dQMNH+gHi25DpUg2Am+1Pf8TLY3HcSQt8nybUefeQk1GlGzNOvN
 LNmvE8ygZvq+9MnqbOQEeHi2lweyfF6sBxlohf+vYdKHIq88TcicRNmTz6p7KB+9CUGP3CYSRkn
 msOA5IEig4+KtaYtvAANk2QJBzLGe9MuI9Lg6kcopCCDV7+T+jlzwdwyvcM6ReNq+8XacyU+r1R
 9NK81WnwyVsdItOzsmnHuVP8gtom6MDq4SlJqkmSQCueRdzJazy1I7ewcgZaYJ5RrUeQ==
X-Received: by 2002:a17:90a:d64e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-39d9c1db130mr26350180a91.13.1789305540739; 
 Sun, 13 Sep 2026 06:19:00 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95095946sm15749780a91.5.2026.09.13.06.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 06:19:00 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: novatek-nt35950: fix potential use-after-free on
 attach failure
Date: Sun, 13 Sep 2026 21:18:49 +0800
Message-ID: <20260913131849.1561742-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

nt35950_probe() registers the panel before attaching it to the DSI
hosts. If mipi_dsi_attach() fails, the probe error path returns without
removing the panel from the DRM panel registry.

The panel is allocated with devm_drm_panel_alloc(), so its storage is
released after probe returns an error. Leaving the panel registered
therefore leaves the global panel list pointing at freed memory, which
can result in a potential use-after-free when the stale entry is later
accessed.

There is an additional cleanup issue for dual-DSI panels. If attaching
DSI0 succeeds but attaching DSI1 fails, the error path unregisters the
secondary DSI device without detaching the already attached DSI0.

The failure sequence is:

  drm_panel_add()
        |
        v
  attach DSI0
        |
        | success
        v
  attach DSI1
        |
        | failure
        v
  probe cleanup
        |
        +-- DSI0 remains attached
        |
        +-- panel remains registered
        |
        v
  probe returns error
        |
        v
  devm panel storage is released
        |
        v
  panel registry contains a dangling pointer

Detach any DSI hosts that were successfully attached before the
failure and remove the panel from the DRM panel registry before
returning the probe error.

This issue was found by manual code inspection.

Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 94aa6489d99f..8edd0aa363ce 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -514,12 +514,19 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 
 		ret = mipi_dsi_attach(nt->dsi[i]);
 		if (ret < 0) {
-			/* If we fail to attach to either host, we're done */
+			dev_err_probe(dev, ret,
+				      "Cannot attach to DSI%d host.\n", i);
+
+			/* Detach from all previously attached DSI hosts */
+			while (i--)
+				mipi_dsi_detach(nt->dsi[i]);
+
 			if (num_dsis == 2)
 				mipi_dsi_device_unregister(nt->dsi[1]);
 
-			return dev_err_probe(dev, ret,
-					     "Cannot attach to DSI%d host.\n", i);
+			drm_panel_remove(&nt->panel);
+
+			return ret;
 		}
 	}
 
-- 
2.43.0

