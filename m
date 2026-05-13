Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5478CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E142E10F07D;
	Wed, 13 May 2026 20:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CgivsKR9";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 427FA10EDE2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:09:08 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so2900935b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778666948; x=1779271748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zfvlu5mb61YW6djjjZABEhL76NEylTpLflYnznw7iL4=;
 b=CgivsKR9/AhUl4wdKqK4QKoWPz1NtQ29YSdTm8Vhp+TvFUeqrHxKDT//TX9AOcNSTE
 BaUbkpV51c4QXmqynanv6BEgxYmEkWME0vL6s5L7sCRfI7NCNWJzKuE00XwoW8fROB7l
 XkrkGsWQgZIKZyPNfd7Hsexwi59KXYpKfa4jQONMwVZvbdCoHB7ZnJy+GS8mgw35T17K
 qgaV87F4a4KY/sUid8QA1Z6pBTm4sNN2yK93sdJ3Sx3b1G+zkIz0XbtAD39N9IM8ubab
 1HPExGMKgGRtnhgOZDtpS31ltvbk57MVI5NR4dd4v+u3z/x5Dfe+2Q5YL/TESct5kBiD
 y92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778666948; x=1779271748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zfvlu5mb61YW6djjjZABEhL76NEylTpLflYnznw7iL4=;
 b=j3xu4kTPjlH1rG3XUECgjK/S5a3Ie6/JGuOKmLDz2R6XiZprqU4reeCxkZpJrwmCaX
 Wp3/gNrmQeBOA8t7Qravt3om6BarCwRzlqaA+sLH22KdymQuUGqMzcDGTD+Dh3bNBJsA
 yKkSYRLeoxLqLyifiqvyL4Ko+yoLHS7FV4gfbZ1n2gmnFt5Ap3qPKDNjcTj03dQT9yOI
 GwhOpMDGcSpLjwITtP6LmOaUALJpWNHRcgf1w+zA4YMHCzICu8AVoULnLxTVu3HATvYE
 XQcDeyqCajCbFgJUvh0wLX8LFG63IQCOgeiYZVU8cEE4KLFQf1tM4yoxtPEiIavlmUnc
 peAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rYbKdZN3sQwNW6h3kktxj9+boJLwoxWAKMxEyUw2pOhtj9FIr2oh6313MFnaaH4fqMZXKChFBffI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyEiR2pSjbv1eMhGWPrfL4Kgam6SZb0jO4ITe3UApQB6NNd4Ld
 iKQ+0eIbD2/5BNXfmnlyR9m8B0U097OQlfoQ0mI4iVsJXh3Zh4SJ7aiU
X-Gm-Gg: Acq92OEOet5NPp5qIo3rD9GgPW2KHdpoAAGC5x6DNJ1Ea1/DQlcPt5Q4qlIBc6trBLf
 9gNXiAPcCF6Py0ZVKrVcH4XTTtj4a7zrjYXPBaO9NdsrZs3Co8xmMcRFe7lEJLBmwhDVRaMNxne
 29arccnA4bhDA1ViBTFXE24ddqp5bPV7u41gnkX9f77IEo5DQ+Z4+k2nZG9MkI16jYHBvCXkoeH
 XMrlnVV46PCVO1y2I+SfR6T5ews9YWOoyP90vIPdjQcbULrFMzrlQ4STD524j3r66nPD3+qgc8D
 Yvzu2wpx+3pQaWe+jppCL2/H0sP98HJ0BL2fW2N0wRlzWdaX/+vzCRnv8+Eg2ynGuAh+ugmV59V
 9AhYNGDlRhAbpJwwm3k8SaZabSflKlZOGX2mGuu01YVt0U0QIUCIA9TBlPjGqy/iYLMHOCtEyuA
 fU72+dZLtKTqOXjW/6u8ubDSGYPgBaPNbMfK9v/QXbl1WXFJyTGiaDWA==
X-Received: by 2002:a05:6a00:4509:b0:83e:eeab:aff8 with SMTP id
 d2e1a72fcca58-83f04290259mr2661772b3a.25.1778666947745; 
 Wed, 13 May 2026 03:09:07 -0700 (PDT)
Received: from souradipto-das-Latitude-3460..
 ([2405:201:8011:1c:5511:5483:bbf3:4c46])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965c30ddasm33968239b3a.21.2026.05.13.03.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:09:07 -0700 (PDT)
From: Souradipto Das <souradiptodas6@gmail.com>
To: thierry.reding@kernel.org,
	mperttunen@nvidia.com
Cc: tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Souradipto Das <souradiptodas6@gmail.com>
Subject: [PATCH v2] drm/tegra: hdmi: Open-code drm_simple_encoder_init()
Date: Wed, 13 May 2026 15:35:01 +0530
Message-ID: <20260513100501.6468-1-souradiptodas6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260502143420.7850-1-souradiptodas6@gmail.com>
References: <20260502143420.7850-1-souradiptodas6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 20:57:01 +0000
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

The helper drm_simple_encoder_init() is a trivial wrapper around
drm_encoder_init() that only provides a static drm_encoder_funcs with
.destroy set to drm_encoder_cleanup(). Open-code the initialization
with a driver-specific instance of drm_encoder_funcs and remove the
dependency on drm_simple_kms_helper.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Souradipto Das <souradiptodas6@gmail.com>
---
v2:
  - Remove stray blank line
  - Patch is compile-tested only 
  - No functional changes.

 drivers/gpu/drm/tegra/hdmi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0adcd4244a42..068a32be0c13 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -25,12 +25,12 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_eld.h>
 #include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "hda.h"
 #include "hdmi.h"
@@ -371,6 +371,9 @@ static const struct tmds_config tegra124_tmds_config[] = {
 			PEAK_CURRENT_LANE3(PEAK_CURRENT_0_800_mA),
 	},
 };
+static const struct drm_encoder_funcs tegra_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
 
 static void tegra_hdmi_audio_lock(struct tegra_hdmi *hdmi)
 {
@@ -1555,8 +1558,8 @@ static int tegra_hdmi_init(struct host1x_client *client)
 
 	hdmi->output.dev = client->dev;
 
-	drm_simple_encoder_init(drm, &hdmi->output.encoder,
-				DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm, &hdmi->output.encoder, &tegra_hdmi_encoder_funcs,
+				DRM_MODE_ENCODER_TMDS, NULL);
 	drm_encoder_helper_add(&hdmi->output.encoder,
 			       &tegra_hdmi_encoder_helper_funcs);
 
-- 
2.43.0

