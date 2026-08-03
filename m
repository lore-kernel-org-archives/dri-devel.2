Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1E4C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986E010E6FA;
	Mon,  3 Aug 2026 16:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EHizRmS8";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5490110E71E
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:26 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso11097075e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773485; x=1786378285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JovHwWPJVIJjedVl1fvW+GGr92iYs5PPothHhlNSmKk=;
 b=EHizRmS8F8JybyQKwg89S8lX01wrXTvlG+JwmevEhrgCKnVkQhh26kQpsV0TDuzcyh
 R9kT3joyP9zt2e9ds8qqMINGVzjjMirQGxshYfGJ7z0HcMI6BGgs+CqbtDRkky7FS1nb
 6lO2QGyMk07JfPITJA9b3kjNnEXWtfN/zS7nsZhxpUw03WQ3RJX9VVHHYL380fudi8dV
 psttsj7qYtf8ACjzAYsc/LxrFCBsOLI/FgMbaRrLCoC8uJA0ozMgvmZJsA6u6BHLqdQV
 e3kEiiNej6rm8OXe5/aL9K3nYNkgtmziAlpmwV3me2C33o4ijHeZ/qEbSMmx4pz2LBhi
 Zv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773485; x=1786378285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JovHwWPJVIJjedVl1fvW+GGr92iYs5PPothHhlNSmKk=;
 b=bDqTEb66b/yr0pcP7WbBpomE0xTggOe7wAMoDe6YV/BJrSfJRT7yWDwVlrCPaapGVb
 tyunbncAksfHYQYUL+ArunxTL5dYb8huQxrznPCTysKUFqO9ifrBn6t26BiIUewyKLGc
 6uh98NsX1kwztkAeio/q651DPXJBAVF0XX72c9Jgy64Y/eM6eq2fsF5G16JytIBGXOhM
 Kl/BqGS/TsdJYt6mCGGuovjqGMxtUWuRSkDKM0+n35rYMSXTdTpXzTQ0eGiPiEWU36kv
 ljSfdjUTifxPKQLsqONCF9U47t7oqEcTbVoNFVIu1b79DwpXE5Sg0J0A5lIDTjxvr1tw
 6xcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUxtduo7qYdinchDKKMHwr+rXQRlDO9/ijQRG3wl+23U5NjEZOkv1iR/W+WsKgWd/eJuROjKwYvxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXMD8U7KbsbvgiypMs0nLepDKsg+nisVtDf3M4maUS9IK3sjze
 hp9GYGXFU+dq9J9TYO/8kiSQ6G5+gtZ+JQDEzvimOE2eYjVX5OQJIk+g
X-Gm-Gg: AR+sD13NJsWNP7R6I6Cq0tT7ooggKKXinesqj5ODA9xVEITSo812Nb09VGAdDyXXO1t
 ee23kdUsU8KnoVuCIAk4of/HXw3UgFkILiZ6WJHCTsDs0OglmZYIIzQ0oZ6YNxm/1GJ/8sf10Z1
 lusP75uMXautO4ImSL/YLbxe0azQL1VvXa6FFBrORXyjDjlrkGMimL/jtixdsH35ykGEt9JrBYy
 XJR0Wp0uPZpzSkcQWQHYp3hvf05xQ4hZzabL6qz1XshjmgcGoYfut5lUZ9RPlWcrkN4Dy30+g0Q
 mKy2MWm+eYBPjvgcbOwqLTizyvqncealL0my1J/KlBelonOeb64eHOZwuIXqMidRn38obINJC5d
 cXt6TGaNckCXbPeDDqhL44p57lV052IPfhwxuF8y1e4EJUxPNEo0IfbyegIWjvJtxTWjOfa4RL/
 6PVzVUzFwD1Fk0uJGb6uvUDjxGHclzTZySspUotKw0L0M/4MoqpY8oL31NBI12bDjmNcbfXDY8V
 v/Kvc0jl1q5t6VxeI/XMhS32xbqwBE9JvUsrSkSWs5yNH61RPoY9V0GmtVXrKNkz81sRo99Si6I
 FeYdP7q3ghiT1Q6UY5zfTITr7gyHe7fG2imCytlK/3vjl+QMZfmv2VcsXzNMFZT5tn1CZLhtLmU
 LuO0GGr1xvTBhC6oDyvN/HgwqHZuhrSWym+xpyJGrZiGT3tepNgxK1A/BJJSdwPShPrQDetrt0v
 ASn1vFBm1P4s1N
X-Received: by 2002:a05:600c:4504:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-4980c66c9a8mr228536025e9.3.1785773484651; 
 Mon, 03 Aug 2026 09:11:24 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:24 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 05/13] drm/sun4i: tcon: Set output mux for DSI and LVDS
Date: Mon,  3 Aug 2026 18:10:43 +0200
Message-ID: <7e9dad9eed2e91a79c4e1202caa8fed7c2427531.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

DSI and LVDS skip output mux setup, so TCON TOP cannot route the selected
mixer. Configure them like other channel 0 outputs.

In practice this matters for D1, where channel 0 TCONs are fed through
TCON TOP. The remaining set_mux implementations only handle TMDS and
return an error for other encoder types, as before.

Fixes: b9b52d2f4aaf ("drm/sun4i: Add support for D1 TCONs")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 960e83c8291d..ea7c90fef316 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -717,9 +717,11 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 	case DRM_MODE_ENCODER_DSI:
 		/* DSI is tied to special case of CPU interface */
 		sun4i_tcon0_mode_set_cpu(tcon, encoder, mode);
+		sun4i_tcon_set_mux(tcon, 0, encoder);
 		break;
 	case DRM_MODE_ENCODER_LVDS:
 		sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
+		sun4i_tcon_set_mux(tcon, 0, encoder);
 		break;
 	case DRM_MODE_ENCODER_NONE:
 		sun4i_tcon0_mode_set_rgb(tcon, encoder, mode);
-- 
2.43.0

