Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97747606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r86VxOHK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93551112799;
	Fri, 27 Nov 2026 02:08:39 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D371124B8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:08:21 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so4975542f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795745300; x=1796350100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zyy33FAdfBAAQH0MmIGIDDo6N5QoH0VVbaF8njRBWYU=;
 b=r86VxOHKefVdIqMLn1OL/cNT4VcDNL9ZNdYbyBy/TKnv/IhI2ykoOJM8mspx0R632y
 rS8AtdwIZIMBjYNRkDYbPmp4+sIR669CI9rE2MxBj6rnr+BaLoJ2gRAhzoVZSjxzj4iN
 Io5ThySK8lZ5k0EydyPhPrmQy3X+BFgXFBZH5EOqF5X1xeJcLiIwHzVg/yHRDPGpcq8C
 tOxt6I+BjO5QQnZlBUdN3m/rsS0KJdjfA5l09DHlQcLw9nZSrA/EtSSF21RD543NKD2v
 TzIAT9+awtCDe77/Uca5mnCwi+9wW6gepkQN+zZ7MA+Jh+lt24XEM9Is2ekLnwXGkmHm
 OQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745300; x=1796350100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zyy33FAdfBAAQH0MmIGIDDo6N5QoH0VVbaF8njRBWYU=;
 b=DSr3O4/13V6531yJt7+CRJHxtKayBfK/DdyRNvGwqCvw3Ar9zlcroh5OXqkny6v1+X
 nKHTRNShEUHpnY1ZmegUELpOTzNlf1R/hejeiYHXitfI9QEFLafh8/MQUVyw8wkLB3pV
 fWgEheugOiZaMhV1zsY2gYx7bUsI9/f8FL4O5qrZABQvJf/w0cakz/27PTrxWnac8n8W
 crLuLga7i4ktX40ZskyedFInsX9sqlAKPmiSAFHCx1mXSYLYpb0D1UReZw3oB6SGSOpx
 LlglpTOPpD9184RiOzH9nf7sk8mnRNBA0JYNXFiCb2+ZHpYcC8biyezNLZjW/932Gsai
 kaFA==
X-Forwarded-Encrypted: i=1;
 AL+hErG1x/sZUEcJGV7favyGvEM4qeWkIozzbdAYHT8smK0XPWq+8j1LF0LgWG2itjWcRBJjvP8vicgRHkI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8JGRioWw9SELpGjvAAZKIshqRRxkHJr16FwB1gShhTOyr+aLpY
 rF2SVqq6uybEY3Igyo1AGBw2tB+BlCmGk7LWVruqK4vNus2OFTJfD9ezRRI9mps49Yo=
X-Gm-Gg: AZFdTZeNCbxZwHxtCPuzEov/BHznxOsnRuiNJeqSoJKY6zDvhbFVJHD7YT8b/T3C3Jq
 axXktj/cz8AzvEtOuvvF3989J7fAsMb5dYvZguKV7YJ+20IQoAbAWUnumSQ6PAM/AB6EzpgMDyl
 SnqHAEK5SZdFZVTtAYzafBga2xKNMvMyfKCnLu2VunQQErZD2FHK4UoUM9UYrnMyofNUuSAqAdu
 qBZg5dTgvniAtsUsVeCYfrFa1+xjxhDrdDWkJqgZKFsZm2WLXVRcjjYHW8cN6x83a8fB5KnlYVB
 rPagbJcNuljTwX6uxtnbJjPWNoyXIN199KUOHpJvGK/BX4Qggqu4e/pNFPfJyOpGTSKPDz4xom/
 wN0d1lpJybHvT7CCsmtOEWNi8tmTZVit69ohgqo/LMKinDVd+0KQvoj2wkiep3WIaRIRsuO3O7/
 llHEahwc/p0ggYESNKyU8aLoLhgCitEfmJEJTsfuS47lfm5bbAsao+uIL95OvGvhHgP4QXPZfRz
 BppuviY5IHF1kMLPbHmKqk5m+HgV4D6oRpuQjHYTEjicVUXUVQKlafhvw0VOFPLpdbWbg93MDon
 7WVbLd9bcocC1cxNJJW4YBj5bdkz8dX/No5In2etN0T3kSuc8RgugppO/BN496fv0h12Jm9T/1o
 O/xecuX/xODqVro7CiqMFL/wGgiLPvlmAztkoDbSo2qK1BA==
X-Received: by 2002:a05:6000:40ca:b0:4a3:976e:27a2 with SMTP id
 ffacd0b85a97d-4abb5146238mr44410235f8f.34.1795745300251; 
 Thu, 26 Nov 2026 18:08:20 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm43390844f8f.49.2026.11.26.18.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:08:20 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH 3/4] drm/panel: st7701: let a panel provide its own init
 sequence and DSI flags
Date: Fri, 27 Nov 2026 03:08:14 +0100
Message-ID: <20261127020815.1621790-4-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127020815.1621790-1-romain.tisserand@gmail.com>
References: <20261127020815.1621790-1-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every DSI panel handled by the driver gets its init sequence from
st7701_init_sequence(), which encodes the Command2 BK0/BK1 settings from
the panel timings and descriptor fields, followed by a panel specific
GIP sequence. All of them also run in burst video mode.

Some vendor init tables don't fit that encoding, and some panels don't
work in burst mode. Add two optional descriptor fields:

- init_sequence: sent instead of the generic sequence and the GIP
  sequence;
- mode_flags: DSI mode flags to use instead of the default ones.

No change for the existing panels, which set neither.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 31c56eadda12..f288c8c8aab8 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -128,6 +128,16 @@ struct st7701_panel_desc {
 
 	/* GIP sequence, fully custom and undocumented. */
 	void		(*gip_sequence)(struct st7701 *st7701);
+
+	/*
+	 * Complete vendor init sequence, sent instead of the generic one and
+	 * the GIP sequence, for panels whose vendor table does not fit the
+	 * generic encoding.
+	 */
+	void		(*init_sequence)(struct st7701 *st7701);
+
+	/* DSI mode flags, when the default burst mode does not suit the panel */
+	unsigned long	mode_flags;
 };
 
 struct st7701 {
@@ -559,10 +569,14 @@ static int st7701_prepare(struct drm_panel *panel)
 	gpiod_set_value(st7701->reset, 1);
 	msleep(150);
 
-	st7701_init_sequence(st7701);
+	if (st7701->desc->init_sequence) {
+		st7701->desc->init_sequence(st7701);
+	} else {
+		st7701_init_sequence(st7701);
 
-	if (st7701->desc->gip_sequence)
-		st7701->desc->gip_sequence(st7701);
+		if (st7701->desc->gip_sequence)
+			st7701->desc->gip_sequence(st7701);
+	}
 
 	/* Disable Command2 */
 	st7701_switch_cmd_bkx(st7701, false, 0);
@@ -1343,8 +1357,11 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 	if (!st7701->desc->lanes)
 		return dev_err_probe(&dsi->dev, -EINVAL, "This panel is not for MIPI DSI\n");
 
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	if (st7701->desc->mode_flags)
+		dsi->mode_flags = st7701->desc->mode_flags;
+	else
+		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+				  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
 	dsi->format = st7701->desc->format;
 	dsi->lanes = st7701->desc->lanes;
 
-- 
2.43.0

