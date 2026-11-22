Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D51606A33B
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LOIAvVtE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D34410E4AD;
	Sun, 22 Nov 2026 08:19:09 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D78610E480
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:18:55 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6b88bc47e23so2744831a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335533; x=1795940333; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AHE53nOdyArdfub2fhYvMnd7jTxi+4oRR0nTE2xoxZQ=;
 b=LOIAvVtEEP95UBJk+YnA/65CLNCE9jyofNzec/F6Kq7TatIKX+o9JVSjIZkm9zPG+E
 Cy3VizO8H8BYOTX71S9OdEoAGMmSWOPJ9bYxcag/t4t4PSNz013GXafPZPapcUm1X/qs
 eleHGFKLlm35tnKYN1hAWRL2pr3QSk72uYypvvcPBcmdAFV/p6N0ouI0kqmZnh+EaL5g
 ghijjBnpTxxlUKA3m6sdWvExrkNruaqRVXgNYdORiNmPg1ziLkpVgQ10YwiRua9vGqa0
 o2Hvjy9ihz1L7/HgnGnUFVVKxj2L7k4QZCrdnnU+xyYGEwHzxlDjk55tEF/eC3CrNsei
 vUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335533; x=1795940333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AHE53nOdyArdfub2fhYvMnd7jTxi+4oRR0nTE2xoxZQ=;
 b=oSbeSjkCMQ+CsQqd4VnzMKhHNPtKxraJngbb2dhsCNr1mLpFtyLDFnVdBtABY3inQ+
 HkdYQ4e4pTtWj4LiTsZ7xjlyFMs9pFemF5A8lk98dGOzNGZx3uaqurW/W4Xt04kWjYm4
 diGFcoUwdHZTAe1Nr7nKfqcs+jhKmFTBPgPYjvEHwqI/C0GY9v99SP9zEfiBbPOFiKsw
 DOQVFHfQjSj7tYKN9kiXiJOaU5MCnqZd2ui8QoRBPUDReiz21HXJmHs6vksDTav7tvip
 yghxU9fHOaZkrhodxbLP4PXAIdZtdnVKSMKk7dmokPJZX8ezZ/Usbd55W2aVt73VleBL
 v7EQ==
X-Gm-Message-State: APuU4Z8uiACpe6nd+AuwMm3uYlJ85TDrRSzHiuz4/pDjxZLv3jsKvg5f
 pm4ijEljTvmcenYCWe2WP4E6NSaiUX9URC2KzMwikp97mRFXXh+1cciG
X-Gm-Gg: AZFdTZdmpHzS0EgKpFzw94D8EOe65cM/kpV1uytl8C4lz0RWon/wjoHQgeY+r10KGzU
 CgplgZMKiVLM8wqvb2Szi/3O0DfvHvcM3O+3wjHK5X0CerILhZPBFjPbM4s5MlrXhLVi2MTuy2e
 ULCWrqK0SSVO8+bIWKDyXY//ha6/cgCQZS8p72Lndd06IZfabmx6tQ6pCTCa1h0bAFyvD+PcMpT
 4+DWSR53apTbIsVeco50SvorWPJ6UoYHV2Ya3Tvlr9O4GU+ik7PxYobR/ajftyvmCfVtzb/cl9d
 4o10KFArOUlZ/iHj7PNXDhs+//Gft3RYcn4EJScvSRZU2orCGuNXjT4xDTWMTNOLr2WLvkd/DoW
 QbgvZKUbpqqTJ6l4+gYdF9dXLPztqj965qSsMsfz+2KheK70qRWsVycgV4tTGBE/YL9F4K8+oEy
 LmENy9ygA6aIEOWt+9wAF4PJ0L0WwcVp0RfG4YVa7pq3wjkorQi8LTd3BPBJT2Vw0WxD17cG1gX
 tPVehn3YZcv/584FV7CPe2t3HUvIz+ZH/Wsdt2JJbsUTwYE4zRlReVyUs4UpGdAyOiJQa4IyEtH
 W1TspueWsfzRzKAFDV5xRMidfFTaMXHj4e+8u9wtcIjiZXis3KArsVjw5j5Fa911Hir4AKPYvTg
 addqnp2Qe7A==
X-Received: by 2002:a05:6402:13d6:b0:6ba:a614:2fa9 with SMTP id
 4fb4d7f45d1cf-6baa6145b92mr373973a12.24.1795335533285; 
 Sun, 22 Nov 2026 00:18:53 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:18:51 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/12] drm/panel: panel-lg-lh400wv3: Convert to
 mipi_dbi_write_seq_multi()
Date: Sun, 22 Nov 2026 10:18:13 +0200
Message-ID: <20261122081820.53199-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122081820.53199-1-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
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

Switch from the internal panel command-sending macro to a generic one to
improve code reuse.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 91 ++++++++++-------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
index 63efeb434be13..02150330f1735 100644
--- a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
+++ b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
@@ -37,19 +37,6 @@ static inline struct lg_lh400wv3 *to_lg_lh400wv3(struct drm_panel *panel)
 	return container_of(panel, struct lg_lh400wv3, panel);
 }
 
-#define panel_dbi_command(priv, cmd, seq...) \
-({ \
-	const u8 d[] = { seq }; \
-	struct drm_panel *panel = &(priv)->panel; \
-	struct mipi_dbi_device *dbidev = (priv)->dbidev; \
-	struct device *dev = panel->dev; \
-	int ret; \
-	ret = mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d)); \
-	if (ret) \
-		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
-	ret; \
-})
-
 static int lg_lh400wv3_prepare(struct drm_panel *panel)
 {
 	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
@@ -76,57 +63,59 @@ static int lg_lh400wv3_prepare(struct drm_panel *panel)
 static int lg_lh400wv3_enable(struct drm_panel *panel)
 {
 	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
-
-	panel_dbi_command(priv, MIPI_DCS_EXIT_INVERT_MODE);
-	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_ON);
-
-	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT |
-			  MIPI_DCS_PIXEL_FMT_24BIT << 4);
-
-	panel_dbi_command(priv, 0xb2, 0x00, 0xc8);
-	panel_dbi_command(priv, 0xb3, 0x00);
-	panel_dbi_command(priv, 0xb4, 0x04);
-	panel_dbi_command(priv, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
-	panel_dbi_command(priv, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
-	panel_dbi_command(priv, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
-
-	panel_dbi_command(priv, 0xc0, 0x01, 0x11);
-	panel_dbi_command(priv, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
-	panel_dbi_command(priv, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
-	panel_dbi_command(priv, 0xc5, 0x65);
-	panel_dbi_command(priv, 0xc6, 0x41, 0x63);
-
-	panel_dbi_command(priv, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
-
-	panel_dbi_command(priv, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
-	panel_dbi_command(priv, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
-
-	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
+	struct mipi_dbi_multi_context ctx = { .dbidev = priv->dbidev };
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_EXIT_INVERT_MODE);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_TEAR_ON);
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT |
+				 MIPI_DCS_PIXEL_FMT_24BIT << 4);
+
+	mipi_dbi_write_seq_multi(&ctx, 0xb2, 0x00, 0xc8);
+	mipi_dbi_write_seq_multi(&ctx, 0xb3, 0x00);
+	mipi_dbi_write_seq_multi(&ctx, 0xb4, 0x04);
+	mipi_dbi_write_seq_multi(&ctx, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
+	mipi_dbi_write_seq_multi(&ctx, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
+	mipi_dbi_write_seq_multi(&ctx, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
+
+	mipi_dbi_write_seq_multi(&ctx, 0xc0, 0x01, 0x11);
+	mipi_dbi_write_seq_multi(&ctx, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
+	mipi_dbi_write_seq_multi(&ctx, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
+	mipi_dbi_write_seq_multi(&ctx, 0xc5, 0x65);
+	mipi_dbi_write_seq_multi(&ctx, 0xc6, 0x41, 0x63);
+
+	mipi_dbi_write_seq_multi(&ctx, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	mipi_dbi_write_seq_multi(&ctx, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	mipi_dbi_write_seq_multi(&ctx, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	mipi_dbi_write_seq_multi(&ctx, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	mipi_dbi_write_seq_multi(&ctx, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+	mipi_dbi_write_seq_multi(&ctx, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
+
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_EXIT_SLEEP_MODE);
 	msleep(120);
 
-	panel_dbi_command(priv, MIPI_DCS_WRITE_MEMORY_START);
-	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_WRITE_MEMORY_START);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int lg_lh400wv3_disable(struct drm_panel *panel)
 {
 	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
+	struct mipi_dbi_multi_context ctx = { .dbidev = priv->dbidev };
 
-	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
-	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_OFF);
+	mipi_dbi_write_seq_multi(&ctx, MIPI_DCS_ENTER_SLEEP_MODE);
 	msleep(150);
 
-	panel_dbi_command(priv, 0xc1, 0x01);
+	mipi_dbi_write_seq_multi(&ctx, 0xc1, 0x01);
 	usleep_range(10000, 11000);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int lg_lh400wv3_unprepare(struct drm_panel *panel)
-- 
2.53.0

