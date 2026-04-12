Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8455F3ED5A
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 05:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457DD10E174;
	Sun, 12 Apr 2026 05:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iSc1B7RF";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF3710E174
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 05:38:34 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so2219540a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 22:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775972314; x=1776577114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDCm//iQqF35Bw+js2MFQOc5fraBJ7IJxDw9OnKDBpA=;
 b=iSc1B7RFTBQ3/1p4d487Qq/2yu0Mb1Kr5QkFVV690QlrJoLegc03WGIlNmeSy3RoS5
 BDywnAVJke5D0wt46qX5+Off3uH63ZjqNPG/f6JeXm6MYhyVR4AGHjaZf4uaAk3HyoBF
 okjT1Tjp8SLmoWriXoAUDsboKmQCCEbiOAnP+dtB+EikhStQB7PRU1qUeVRTOVnXYIEd
 w7H0sJ1A0TnKH+p06jGO4kkBhZN/MQ1LYWR5iLCJUbt+TTucy4YS/Il0zO2rdIATHzTn
 8ZOYFEqnV9gpPsWqPHo4nMJr3TnNJS64QWPEt1KzziUy2+4YU8GBArSePME/1efv+aXz
 myyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775972314; x=1776577114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDCm//iQqF35Bw+js2MFQOc5fraBJ7IJxDw9OnKDBpA=;
 b=EJXNbBbiI6rZG36HiLEQQYpmcthNKKRkoHJb4zYP+ZpikAo1yT8+OtNTNak7k5fruT
 PtQm/ZcxVSLlah/5ZMpP6zPhtTaeGACq13bGzGo1Bk4d2jVJ6Ek+B+sEraE3+kgHI6hD
 tWEWCOE1O0QI8Yn9aVjhOCe6sFAnvvqD3lcKG4f2mix/J1V9jDwq4lINv+FHTElC4h6b
 C2m1hvR3BLFMPWyFeWxJ1rGmpfgWzHVMfPJWqjwb4t0cku/ag7ujz/1YQ2Im6BAa+7re
 uqAau+b2Oo2NwH/4H+YEE9cn0NBt/lOsvBEiBdyo7+6PVD/xr203Q1kvDwsLG3Vp/boO
 ixPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J2oJodEKRLl6xfFsjYlctvGlhjceSO/DUeiWih27IawT7f5FJW65Bj6B/Rn3UPi4sffbcO437gQs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx45RTU7eBkv9RF5J12OTEl4JiX3ADbOy82m69jzblHcx5yXp2G
 zwr9QW8VhtmOR1umhz4tXMjedVUvMg0M6LggID/xc6CeYe+ZnBVSoh4R
X-Gm-Gg: AeBDietueA21+RK6U97kJaj08DImpBqdqZt4EQoCTtSq1RyfPQdLLVSIpAOQAw1q+6W
 U9uU+oLZB9IJtS/QdkqOxZ93KNrD9OGfiME8b2Bbg50PG6Qf3gdMHEO8dReba95lxe+2OWgrymt
 I9WRNl436M2881p8S1eNRbR1HbmzKGiDtWL8P5LlYvRjjtoc1gPPpQS0gWcmN9tD78UR5lHSTAF
 3gX7ScPGmzUN4NPc++Y7/ak0LrkxoU4yZvbAJzKf2uBqu1T44IaJiAyq9UNvarN5jgwAR2x7OFP
 BvRF2xeeg/QrMTPpKhRyBXfXPNkohzFmGKhifqL6/ixCY2Mp7oUXm0s131FMUsmrdIfuJE2HByo
 tVqs1up8QGij0bLsuKAF998wOSVhKOi8gVhJ8XnxrvxG/TJjUB9QuR+ld5fwBmNazix8V+dqoAI
 UE71DVzeZpQ9iZMdCmsFWUhCWHqd1KHWUw/PehjuK6dudEhJGB
X-Received: by 2002:a17:90b:164c:b0:35f:b288:8e4c with SMTP id
 98e67ed59e1d1-35fb288b4e8mr536731a91.15.1775972314034; 
 Sat, 11 Apr 2026 22:38:34 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e41e1196asm2740502a91.1.2026.04.11.22.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 22:38:33 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, marex@denx.de, valentin@compulab.co.il,
 luca.ceresoli@bootlin.com, philippe.schenker@toradex.com,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Date: Sun, 12 Apr 2026 11:08:11 +0530
Message-Id: <20260412053811.662461-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412053811.662461-1-tessolveupstream@gmail.com>
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
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

The current DSI mode configuration enables VIDEO_BURST and disables
horizontal front porch (HFP) and back porch (HBP) transmission using
MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.

However, the SN65DSI83/84 bridge relies on receiving full horizontal
timing information over DSI in order to correctly reconstruct the LVDS
output timings. When HFP and HBP are not transmitted, the bridge cannot
recreate the required timing parameters, resulting in unstable or
missing display output on some panels.

Additionally, while burst mode is supported by the hardware, its use
depends on continuous clock behavior from the DSI host. In practice,
burst mode may introduce instability depending on the host controller
implementation, as the DSI link may transition to low-power state
between bursts.

In testing, removing burst mode and ensuring full horizontal timing
transmission results in stable LVDS output across affected panels.

Update the DSI mode flags to:
  - Drop MIPI_DSI_MODE_VIDEO_BURST
  - Drop MIPI_DSI_MODE_VIDEO_NO_HFP
  - Drop MIPI_DSI_MODE_VIDEO_NO_HBP

This aligns with common system configurations where non-burst mode is
preferred and full timing information is transmitted over DSI.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index fef6bca3273f..9d51dc2b75bc 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -976,9 +976,8 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
 
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
-			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
+			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
-- 
2.34.1

