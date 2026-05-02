Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D9ACD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228A810E999;
	Tue,  5 May 2026 07:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ErRn6Cuo";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A81910E036
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 14:34:37 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c80227c9572so15499a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777732477; x=1778337277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tgjXwJez3aZR9MFJ8OuPUlwHGqmX5qrc95kELET/7Ac=;
 b=ErRn6Cuo3Z4VeTgUU8qaOrdO2RmI2jQv7Z+ZAdR2h4xPvFam8S9O4TirUid0dS+fA2
 rb1Xv1eiESso8OvmuFP0yXIwJE41Ylpb93kenYZIxN1jjZ+6+qAySmK0YFIdcmCggTlV
 ZdUMw01yYtqp7lsWm6kiy2OB670EJNWh7ks6DTF+sS8zu+QAzCFsCYAEpHBs0QSDoiGR
 8nZB9O7rhFUB6XIoyw/AqIWgWt6+jh9L26JX2+mfE+PZ5d6NfKMRmIHG+M2VMpohGKOP
 fXw0uXY/hp/RQOeJkV+Mn31jztqYlCX5jqAYytx5iq0qVh8h83fmSTlm8k1Lo4xtnVJm
 xOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777732477; x=1778337277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgjXwJez3aZR9MFJ8OuPUlwHGqmX5qrc95kELET/7Ac=;
 b=ZLHUQ/jU/C+LkaujaPZPpl5VS0tcFUylQxWebj+WQn1mWHe+8Z8Z3nVsHdFzFxTutB
 vR81TeG+SXfkfpJb18NKHqR2OZYfiUgDk3Qf9mX8P/QkPsvtUf6R4/l6KbxgxgSrIIH6
 L0TmCkQ54zaxdjStR2PUv3MRetuFb/2aWGDObmf64a/11++tR2p1CNjHXJgdDGGCLE9W
 tjT5ASd/zGWKxCUlU9xOfVoCOs4h4l+fPHMQCq1Yz4pi9qFenD2DROePcASg1IdeetBG
 O5dgZ+WwU5ScFMgYigjzsA7XSx6QHZbfgAWOHUDgQzWGLJRXT73CdBGKbRs24Wr5eVWa
 rKxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+V4cFmuTBENjF6JMeiKr1k56iD5ScRpg9fEKbdq19TZyOC7oFHFn4UkW6VHhztT8OA8X1FWI/x/I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzgf7hkzwnPg+EAmF1k9XwyYZeNwZ+FSssy6splPqJ1dJr8UK0f
 J0cQLqXGZ2vbUTb88d+eAxr9gHNxBSOsYzdNWVrfT4jnRSjtvxRwBGuo
X-Gm-Gg: AeBDievfQygzF2pWTXQlvH/rfxppp7fOZcSDkjri/qQMPbPqGV9SqUg1ZAt1Q1rPUjA
 e3opEnHVFB9TDfUkme4PR4udeT6yqlN435vNTm48LxSdi6S7rrmxZVoeAvQGIvqVDudHgtLlqa+
 wARqcrJnvR8z0gKsBy6PAvZgIIQ1hd2IYI5Q6ZAbZzPa3L7KQtjMbA/X9ksqX9FvnvGqHY6rHNk
 ApR6rAZ66t3tROoddoCpmJDXHdW9I7WuU0xZlET095ZqmyxRtPFRV/ZRtbPBoyEYQAEJDX2N79L
 jOe0a0H/Olf5MQn1Cll0Tt6uudm6gZHx3M+T/qHxvWmmVT8SbFqsjr7Q7WoMSw6ZCquMTsX1JXa
 URr66inLenqL1YTAc8RZVpuLApWDEU9GwQvKH8fDLMd8/7ad+wL4KN6uPKa/7YCii7zqwRj7TAL
 d1YOtfya8QZ2oYYxheD1KVzFNkjK62KKYrT9pZR4ecVQaSmDjiY5Q9JsxnQf/waIeq
X-Received: by 2002:a05:6a20:e291:b0:3a2:dabf:fefe with SMTP id
 adf61e73a8af0-3a7f1bc2302mr3579543637.19.1777732476507; 
 Sat, 02 May 2026 07:34:36 -0700 (PDT)
Received: from souradipto-das-Latitude-3460..
 ([2405:201:8011:1c:b259:847f:f774:53b4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515ad0176sm5714230b3a.39.2026.05.02.07.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 07:34:36 -0700 (PDT)
From: Souradipto Das <souradiptodas6@gmail.com>
To: thierry.reding@kernel.org,
	mperttunen@nvidia.com
Cc: jonathanh@nvidia.com, airlied@gmail.com, simona@ffwll.ch,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Souradipto Das <souradiptodas6@gmail.com>
Subject: [PATCH] drm/tegra: hdmi: Open-code drm_simple_encoder_init()
Date: Sat,  2 May 2026 20:04:20 +0530
Message-ID: <20260502143420.7850-1-souradiptodas6@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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
 drivers/gpu/drm/tegra/hdmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0adcd4244a42..a45c19d1631b 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -25,12 +25,13 @@
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
+
 
 #include "hda.h"
 #include "hdmi.h"
@@ -371,6 +372,9 @@ static const struct tmds_config tegra124_tmds_config[] = {
 			PEAK_CURRENT_LANE3(PEAK_CURRENT_0_800_mA),
 	},
 };
+static const struct drm_encoder_funcs tegra_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
 
 static void tegra_hdmi_audio_lock(struct tegra_hdmi *hdmi)
 {
@@ -1555,8 +1559,8 @@ static int tegra_hdmi_init(struct host1x_client *client)
 
 	hdmi->output.dev = client->dev;
 
-	drm_simple_encoder_init(drm, &hdmi->output.encoder,
-				DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm, &hdmi->output.encoder, &tegra_hdmi_encoder_funcs,
+				DRM_MODE_ENCODER_TMDS, NULL);
 	drm_encoder_helper_add(&hdmi->output.encoder,
 			       &tegra_hdmi_encoder_helper_funcs);
 
-- 
2.43.0

