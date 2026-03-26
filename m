Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9609106F30F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2550A10EA80;
	Thu, 26 Mar 2026 09:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kOW7R0dJ";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C92B10EA90
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:43:33 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso420773a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774518208; x=1775123008;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCaasFgG3bKwmDmNR0xzReU3+wYjKSaL6CIO2mNwHyw=;
 b=kOW7R0dJzifJV+3FkmvgUOo+Wd/UE+e39MzBACoEWNkA53KNKIMPLOxdOQxsffKtaP
 xPZgJ5H8jJlLixfvYByH1S0pMbHNvskuPFx+0NBE3GaykNUX12jS2Ee/p/awPOaMIRZq
 l3Kx09M7GJXQBf/6hRqSvpJSuUbsLKK/vChcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774518208; x=1775123008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nCaasFgG3bKwmDmNR0xzReU3+wYjKSaL6CIO2mNwHyw=;
 b=e/oA4WZ4L2tA2pFEDtEpOYAfNJ4P/g8/2YzhOF4k8NwtE8T5uf0x6S5oNEpScXxXEC
 iQeLNScZs8tjAyBBoH/W2fS2UVL4hBEsZsT/evnimkhKXzOeYGeiD3KBQx2mKIrKursy
 438gUdP6RX82TUmM3vcyUk9gws0qBw7hSRA1Pa5yhjz7K3TDFZ8p4UxsSbeV8PUETABL
 RIfJpNLfW5Sud+hfBn6Ujz3SB3kOZ/wh1sRepUbK4z9Xo8LsFsy3oR/EtIho/evuXkmn
 QSZH+FwDm1AqspswELlN+qr/cvW9ALwjM8oFNfsOMhYaHAtGdB/uAyH/VpcS+IcdNXsn
 lFeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLQ6a9GlB7QkVPhtL+q3arlC6Ef/kPzU1tck3d3dPg3g0M+ClRUtaEQ4xUFFH/CFawco26uLGDxZI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi2xFIdIY6LmYQcXcxany+cHi4s4R45HjPxtE5l+w1l8hWplfg
 d7N+w3u06u8hOzdlOj3E7iBFTUsd37e4eppGNjgvmVwC7E4jccIQLIRhHgMWFt820fBK7xPziR1
 nsU0=
X-Gm-Gg: ATEYQzxwG4pPSs9nojt3e/FuVYuv58+tT68VlQ/3n9Pb1rY0YCsKfZyO8xV0MMPOHrI
 /yq5/0gSJ26Zwv7gTVtj56WbXNTnvTxl2CxCndaLw8JKHWB9bdchtq+5x/z0mIH7eaunp5Fbybq
 vzAaNuKv+KpM6GxmLTE+QWbCGAvwE9Ikm8BGMpvf9LPG5LXlfPtSHFIX9Wki2V7max7No70VyEu
 M3QMmGtvHNi6CTFTSqebo3DDAfU+DT9cKmNMmZ1zyH688VJp/R39WwOd1DDHTusjOQec9qJ9zyO
 vsLqeV6vLESw4cHAJol7/ZnEe8ulqyYXEnLAh4IzOSu7wn5Iq5xoJt1g9SR91xndfMYSzrCTpic
 eY5s/MXTgy6ToiuOcB3+n3Itolg/DBvNZThEZs/mSfF6QigeA3P+rd/A24O/Hlw24fVB1d7lrji
 jBVZBxrG+K7zg44CK0G4ryF+r8s9gn2D6UTuAIYpMZQNZOYt5x3Y9fmMYY1RokfeYZrq4RHd6hl
 tTPNP8I
X-Received: by 2002:a17:90b:4fc4:b0:355:35b0:8b78 with SMTP id
 98e67ed59e1d1-35c0ddd9d68mr5978607a91.27.1774518208424; 
 Thu, 26 Mar 2026 02:43:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76737f28fasm1673312a12.7.2026.03.26.02.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:43:28 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/exynos: Drop MAX_FB_BUFFER in favor of
 DRM_FORMAT_MAX_PLANES
Date: Thu, 26 Mar 2026 17:43:06 +0800
Message-ID: <20260326094308.1161335-5-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326094308.1161335-1-wenst@chromium.org>
References: <20260326094308.1161335-1-wenst@chromium.org>
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

MAX_FB_BUFFER refers to the maximum number of buffer planes for a
framebuffer. This is the same as DRM_FORMAT_MAX_PLANES, which denotes
the maximum number of planes.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h | 1 -
 drivers/gpu/drm/exynos/exynos_drm_fb.c  | 4 ++--
 drivers/gpu/drm/exynos/exynos_drm_ipp.h | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 1ab7195d09ae..b126cd129944 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -19,7 +19,6 @@
 
 #define MAX_CRTC	3
 #define MAX_PLANE	5
-#define MAX_FB_BUFFER	4
 
 #define DEFAULT_WIN	0
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index 125b87adfdc4..93f387b12126 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -99,7 +99,7 @@ exynos_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		      const struct drm_format_info *info,
 		      const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	struct exynos_drm_gem *exynos_gem[MAX_FB_BUFFER];
+	struct exynos_drm_gem *exynos_gem[DRM_FORMAT_MAX_PLANES];
 	struct drm_framebuffer *fb;
 	int i;
 	int ret;
@@ -145,7 +145,7 @@ dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)
 {
 	struct exynos_drm_gem *exynos_gem;
 
-	if (WARN_ON_ONCE(index >= MAX_FB_BUFFER))
+	if (WARN_ON_ONCE(index >= DRM_FORMAT_MAX_PLANES))
 		return 0;
 
 	exynos_gem = to_exynos_gem(fb->obj[index]);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.h b/drivers/gpu/drm/exynos/exynos_drm_ipp.h
index 67a0805ee009..2842c8af0b7c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.h
@@ -70,9 +70,9 @@ struct exynos_drm_ipp_buffer {
 	struct drm_exynos_ipp_task_buffer buf;
 	struct drm_exynos_ipp_task_rect rect;
 
-	struct exynos_drm_gem *exynos_gem[MAX_FB_BUFFER];
+	struct exynos_drm_gem *exynos_gem[DRM_FORMAT_MAX_PLANES];
 	const struct drm_format_info *format;
-	dma_addr_t dma_addr[MAX_FB_BUFFER];
+	dma_addr_t dma_addr[DRM_FORMAT_MAX_PLANES];
 };
 
 /**
-- 
2.53.0.1018.g2bb0e51243-goog

