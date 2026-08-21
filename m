Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A083C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F79510F2BF;
	Fri, 21 Aug 2026 14:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SGNKZMOO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B85110F166
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6278561838;
 Fri, 21 Aug 2026 14:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DD31F00A3A;
 Fri, 21 Aug 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323230;
 bh=HOtH/5YaZJl///PPGAgjRsfit6MflPWAx3PKiD46W8g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SGNKZMOO5HTdy/a/KXanfQsTNklg4LEvURwbUURZJggqFAP+gyMoqpEg4SK7NluRR
 1xMkucvHqON9J9qOHAXhb4JEhmqircL9i2Ve2EZCzKaFMSw45LrCyps25VBExJITLH
 A1wMXmcA0pBAwxr75gypt65qgu8pJOHk5w2i/8EfSLUnaaefBlXKqrCq3Jt8rhHkV/
 oKeb0CyqiRTJmrbIzW9CFjYEMKqyXmNh+gj4K6sHqEq22rxgl9bAuWwCoLfqnjxb11
 fCLDpH/dVARqfXUyoiDnLykNRQtBpHtZL0o/ihEfEdLv2PXHGHD3/p2Np4lb4WNlkF
 QMo4C0h1M2xdw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:04 +0200
Subject: [PATCH 28/70] drm/tests: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-28-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UEnaEnFF+t3ovAuC+UMICzjvGMYFLoaxYXJSHwGsUAg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdySxM6oUT2U9c1+QJ+djJ717Pz9B4fvv2TKWgnZMWr
 l69P/JYx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIdxbG+gguxgt9B3w0Jwff
 UZn+y17C5Gfw7G239Hkuf7S/fCHViOePyFrDjMx8HpuZQTNnVi86zVhfk+et8O9Z4GuPmmtzFEI
 +xOqHlG0N+/m+SMPt8Nb0ULvTSbpB4W/elO06nF+zpkx6gyIA
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

The KUnit test helpers use the deprecated
drm_atomic_helper_crtc_reset() as their reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 727766444d63..1afa9b162355 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -215,11 +215,11 @@ static const struct drm_crtc_helper_funcs default_crtc_helper_funcs = {
 };
 
 static const struct drm_crtc_funcs default_crtc_funcs = {
 	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.reset                  = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 };
 
 /**
  * drm_kunit_helper_create_crtc - Creates a mock CRTC for a KUnit test
  * @test: The test context object

-- 
2.55.0

