Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBF3F45A08
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9CC10E127;
	Fri, 10 Apr 2026 19:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eR7gUJaq";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2742A10E066
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 19:55:49 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so1617898f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775850947; x=1776455747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cn1n3g80CRUTEYDPxzpqhTonRkq3m5+Hx8e7kozYg5U=;
 b=eR7gUJaqhQ9HoO/nuL0heIV8LQ8vOwESXkjWzro0MA9m8np2553/lGqvm6a1aalwC6
 rLHAbu4DjwVbVU1qUAPR21DebQEAuFTt4spD76/G7Lk5ZnDtVEv+EZfIqISjhLmzvIIj
 5A/LgOQ6SqZzRK/naj265qK/jY0ubnDsyUMISumzqeuE2yRTZtufrTfRMZ5w/hOENkaF
 pQPZBRK0bIxsPvOV50dP1QJrGcK/P4iOIlZZdQ/S2jqJSFv601jYx6QevZz3FDuc4gyc
 lOEpoSFrVZVRHgxoLhjm2tr74FkuQwFtSsGRP6aP/Rde4BQt3IffeWpz8H5OEjmQokgW
 GIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850947; x=1776455747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cn1n3g80CRUTEYDPxzpqhTonRkq3m5+Hx8e7kozYg5U=;
 b=aUchCV8XnPBo6M2V0Oa+gZcyJNmdpze4uH5aqF+HAR9bnkFmLBZzk/7f5qWyLe6gXC
 IxNAL/ewL1Q5V9kq7sojV5XYvcF4zyuP2zwUcOVgbCpPzjuB/TXKJeGXW1HocZAAPKcY
 P2ZQZ6B4rKUZH+LffzSTFXg6dQMzZCff0ieHZZKfTkYeC3wuNGrarileJ0e2L9TR4ySV
 ZAs4BaoB3VzFmXkmMwBsXRrcP9CC7zGfGteN470hMMUhE3BAC7hoCJSJHRlIxw0A9L4p
 XrJCBAg7mlmiIUxc+6z8daZ6LoKCEtngn8ij8wuA0E0/N3PqLcvaXmLkCV2Rm/S0GTo1
 rgPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMdxwWpdvFFZgvPPIjrHBepGcclRsP8oIYandlu/yxA1wBFsPHD5DlvAKm68lI1N2tURyjEG1EynY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxH/BkEA4HmwszWG+hosq4o1y4Dzm5mnt5p66TwuHKLAkwAeg1A
 sgWr7FZDWW2ZjNYWshoEJY0A6uKCQpGKVqzVCGWOAotmT6LyXf8okzYg
X-Gm-Gg: AeBDieuKcc9Bm5ugfzWfjSk8k1l7XbIeW0K3McNYZzITy6f3pgWgwt/zgAA+AxD/XrN
 wJxmPpe5h9RM46JjR+IJZB90pkOuAEfB4kCPadmSTbZgx09si83qaHTOAMhIut2GoBao1sNQG78
 m09gGTaalnSp35+jHqgdBpT2HSqgL6YoZ36W3hldObP5kQLhoxaJ7w5UVl9igWLJ8dlorcX7I2W
 J12YWc2VHoZGdANV+NRdgbnJ6OBgWdI40T3MUKcNffF5lyIe8XJgIxbO8eEaD/N2ZMqApXaPlcu
 I+HpjhQg0T25uEVDtrdr8N1YmBYKoVnA8ZHXh2I6s73bPDHAPN37Xyp6aEY0POVw4RUUQMj0iw5
 VqRM7BP1WK7bTWKbcdv9o2eQhDakLzEekzW8u/WUjf1ZwbmXcDgCMQotb1xfo0hzTDvHoGLQRKH
 +m5K4VElXrcf+KAee06JJjDJzPb/uO0cBNeCIjCqAxmuBTHmKtS/GrojvPS5Q=
X-Received: by 2002:a5d:5846:0:b0:43b:3d4f:e18d with SMTP id
 ffacd0b85a97d-43d642c3db2mr6968024f8f.39.1775850947468; 
 Fri, 10 Apr 2026 12:55:47 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:d356:742:cb75:6153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5d85fsm8611476f8f.36.2026.04.10.12.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 12:55:47 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] drm/bridge: chipone-icn6211: remove bridge when
 chipone_dsi_host_attach fails
Date: Fri, 10 Apr 2026 21:55:37 +0200
Message-ID: <20260410195537.295119-1-osama.abdelkader@gmail.com>
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

when chipone_dsi_host_attach fails in chipone_i2c_probe remove drm
bridge before return

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 814713c5bea9..5bee10c64265 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -760,7 +760,10 @@ static int chipone_i2c_probe(struct i2c_client *client)
 
 	drm_bridge_add(&icn->bridge);
 
-	return chipone_dsi_host_attach(icn);
+	ret = chipone_dsi_host_attach(icn);
+	if (ret)
+		drm_bridge_remove(&icn->bridge);
+	return ret;
 }
 
 static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.43.0

