Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C91C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765D610E30A;
	Fri, 21 Aug 2026 14:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ViBUXxsn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC35D10E30A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AFAE413CD;
 Fri, 21 Aug 2026 14:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BEC1F00A3A;
 Fri, 21 Aug 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323165;
 bh=AScN3I19v07JnahpXQ7o5Qi2mGTdd7ShdSVptgTH1ko=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ViBUXxsnlw4JO5codulSf8pWTNvmEqoXxp7yvVOIqc42ArQ9KCXSWgBULZRy0JrZr
 xXLfdHiFnt6xYc1rb2SQOEqv26Z2aEooIre0DBCPTXP3XT4DipiwMm+GK7pl4fvjME
 VUymUZ4tO+YaiPGaUN2hR/o5eXnpaDrGZ70xzo1DpsPqfCTjpUSfUQqXoK6rhElUNu
 SMC3SoSn/utuPyIWZv2x5I4YxcwhOdGBacS2KcvCdV37tU+QNtlkoQaTO0yH+T1+DS
 z72/XBKOnlRKw9LW8nQ1easCNjDsq7eD1gz4lmYhJ11KxZsUf/gVuOBGHhO2PHsSaZ
 5/S9pDNESI/LQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:37 +0200
Subject: [PATCH 01/70] drm/adp: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-1-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <k@chaosmail.tech>, 
 asahi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=mripard@kernel.org;
 h=from:subject:message-id; bh=W0QXkOd1G6710ZQOVTXlkk+LZj0vT0LYhmxlGGxIKjE=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGqIYvijClxRq9XLRHIY4IUPlGQYlYmxrftqyCN2IMX2ttTte
 oiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmqIYvgACgkQJ1/OGaI9vnbCuQF/dQUE
 k6pfT7B78UTTujiWpnOJWJUEtwpYjrF1QeEBY0sigCMz8t7J/y3PbG2q9E/1AYDERhk/Lv6N4pY
 Hr7nB9xR+5dwpZ5kbOq7dY/DqsQ9DAPy+WFjtt9MeFUNb08OXD34=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The adp crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Janne Grunau <j@jannau.net>
Cc: Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev
---
 drivers/gpu/drm/adp/adp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index ce9dd6222634..fdf0e6316175 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -349,11 +349,11 @@ static void adp_crtc_atomic_flush(struct drm_crtc *crtc,
 
 static const struct drm_crtc_funcs adp_crtc_funcs = {
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank = adp_crtc_enable_vblank,
 	.disable_vblank = adp_crtc_disable_vblank,
 };

-- 
2.55.0

