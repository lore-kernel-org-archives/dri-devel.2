Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8F6C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193B910E032;
	Mon,  3 Aug 2026 11:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TgydK5HS";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DB210E032
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 11:13:32 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d0407aedd6so34857775ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785755611; x=1786360411;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I6Kz68yYAXo6+FxgCcZ8xt2d27kzI8ELfLUFCtIDH5c=;
 b=TgydK5HS1b74Qp6YxwEy0tnUD4T7hzCOBZ8f/fUu/phSlWu+uXXrgFi/dkRmHEfdUI
 aE6JcwEd6rUbg6svkH0P4soecaxTqZ9oeIDVs45/BBTFtzUyzpol/k2Fvrj+6lC1Z8Uz
 zwdB66pfXxI0gi3fMJBRD4vfc6B2p3nEo5Yc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785755611; x=1786360411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I6Kz68yYAXo6+FxgCcZ8xt2d27kzI8ELfLUFCtIDH5c=;
 b=CB5QZSdYnd+t9AJvA7Py+EUcH9lc3bKtu9+07/W+R1gi4bU2/gCy5z8Cm+SJW1c6h/
 EZxzlmZZN/W+EUhS7nk/U4ZTXqdqbPpgEe6jnlUlBC1fs3gL/e/SpvfD9clVKGzuwAQN
 6DWtY5ZYds0zjDBOSsYlTr5zwRKG7LINmKtFIoI4uIachT36NaSRdnbrSn9L/PCo0vRn
 D5tR0Glu/ircSozfVRJRz+7YGu5C8C+8AdAqKBVfGUe9AjADBU39K9OVwDnmkSiCaAQb
 BYYIEk1iqNKHSYCkL7nQAHkC5YKPcUuOP5DeSp1qjzgCXdGA7Vj2MfUgUVVieP14JqZs
 BtIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbB9I+Rcmc1cnWREmQfb5+csnH/oC/pcHLFESfk6yTWVOWtgp6NW9kEezABJWmq3hktrPsDygUcTs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxFpltbEGFRv7NkzDxbhE2nYEN3VTVS4WQzZqfSzxrjGcsCf0v
 BW9UW2KS4v5fqConCD98slZPgswgYMq2XA9mbUM8gsDEhOmvjrZOiMbpV5d3xKewkA==
X-Gm-Gg: AR+sD10tjKmvcSUXRYRm7qrQkWmaz122pDLLLC6vy/gIo/a+uEPxv6+T5WH5AvxcHAM
 zo8b77orDt6eutu6QaYUCMRt0TFRQmz/JoralzcIanWiphjQO/hxnGjm0Jshq8AEEloax1QuoTl
 09jul6oTY1fvaA1wN3Ha11PKT68fqj7riNMX2XYBNIWbI3RTyogSYI6lvd3qq30BCOlwtzo+v0H
 VxnwIsswdgEoZJWMBLlRQ3wJDo9wovCx23k1Yp5ulJGkxKtN9SYnAkM/gKATSymRVoCX6lu7xUI
 v4ONe6mNw9LlZGf1aOChuuzDmGGwcdIKfWcnCZynn1xSL2aVEWNFV5XpT8R/vDTD2xlvlMvziOv
 EPaIesSV0C66GKDONC3ZSNfn8xphXEIPAOYRsUeBqccmgd9YMWzoiIhzCBGYmf6TqZTFwyu91t4
 ITgs7Pk23epSYn0mHtdzIt8/7QF4fgImtySTAivq7Hj2glHimE/9hXc79uFbzTM/RJjkt8/QhJ/
 PiSiiqYHvjS5fuQiUTwtP8dLSX9AoAgqNt8+vWErcZfug==
X-Received: by 2002:a17:903:1b50:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2d052297a68mr94429995ad.21.1785755611549; 
 Mon, 03 Aug 2026 04:13:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:1c0b:57ba:92e2:e178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b11e69asm36171805ad.56.2026.08.03.04.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 04:13:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-sunxi@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: framebuffer: Set mode_config.normalize_zpos
Date: Mon,  3 Aug 2026 19:13:18 +0800
Message-ID: <20260803111319.2836240-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
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

Back when support for zpos was added in commit 47a05f4a68f9 ("drm/sun4i:
backend: Add support for zpos"), a custom atomic_check callback was also
added in commit b8f1230dd3bf ("drm/sun4i: framebuffer: Add a custom
atomic_check") to have a place to call drm_atomic_normalize_zpos().

Commit 49efffc7fbd4 ("drm: Add drm_mode_config->normalize_zpos boolean")
added drm_atomic_normalize_zpos() to the standard atomic_check function.

Set mode_config.normalize_zpos and drop the custom atomic_check
implementation, which at this point is just a simplified copy of the
standard one. The standard one also checks whether async updates are
valid and updates the self refresh state, but neither feature is
supported by this driver.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index 9c8ef927d929..fc822bc2c62b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -14,24 +14,8 @@
 #include "sun4i_drv.h"
 #include "sun4i_framebuffer.h"
 
-static int sun4i_de_atomic_check(struct drm_device *dev,
-				 struct drm_atomic_commit *state)
-{
-	int ret;
-
-	ret = drm_atomic_helper_check_modeset(dev, state);
-	if (ret)
-		return ret;
-
-	ret = drm_atomic_normalize_zpos(dev, state);
-	if (ret)
-		return ret;
-
-	return drm_atomic_helper_check_planes(dev, state);
-}
-
 static const struct drm_mode_config_funcs sun4i_de_mode_config_funcs = {
-	.atomic_check		= sun4i_de_atomic_check,
+	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 	.fb_create		= drm_gem_fb_create,
 };
@@ -46,6 +30,7 @@ void sun4i_framebuffer_init(struct drm_device *drm)
 
 	drm->mode_config.max_width = 8192;
 	drm->mode_config.max_height = 8192;
+	drm->mode_config.normalize_zpos = true;
 
 	drm->mode_config.funcs = &sun4i_de_mode_config_funcs;
 	drm->mode_config.helper_private = &sun4i_de_mode_config_helpers;
-- 
2.55.0.571.g244d577d93-goog

