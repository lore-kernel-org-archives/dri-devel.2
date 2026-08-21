Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3D9C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DE410F2B4;
	Fri, 21 Aug 2026 14:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RIghd8+R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC61610F13E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BA104406B;
 Fri, 21 Aug 2026 14:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2C41F00A3A;
 Fri, 21 Aug 2026 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323220;
 bh=51dGxRHGNOYg2qnOqeaC8ufQBiZZVv/99oW8W8XUDMM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RIghd8+RIhBVC5w1CCnraR17z6lxRtBKY1uTrfYbaAw1HPHsb3GJ5jumIWjzrwhAq
 1+okelAe2JOthaSYuvuGGoqOVIfNSStUAUR2YLdo+jlty4IprPpXlm9HtVlHtjAoOE
 deVqER7adX8CNtUfqV9j3NNL+kyYuAha7DEcG8rTlTB1TCbmMA32DxIzKGNlz3x7EE
 EarfUk64TmosgW7+AgaomPVOdzVuAg5S3ZuD/AtyhVQkJzKmcueRUkJmZFJ8p+12sX
 BvHxOZtimH4eEVHv6JCfjMkDfnDPK35UpoUQK2eV0MvAFZ+SCzlbuhTw3D4tZUqNPa
 UbNXSeFzMD08A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:00 +0200
Subject: [PATCH 24/70] drm/sprd: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-24-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Obax5Pq4PUSmZ5jc8aqoOAytgbqXpFslB9J6QQwoeng=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdycwbG2c4WYbY9TyZYJPLVMX7U8qgf4lswe7SJhXrr
 6VCibc6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwET0rjI29F1ZufBVnLTWpXhb
 8VUSij6p7ME/0k0TTvA9Fju2fYPEnur1nj8ept/wW/o+WE38n9g6xnqfnvg9wqf+F1bXX5nrd3F
 t6v4d2tV969cdUqvI/5z5sXKPv9YR7htsX/aHdGs1VfGbpwMA
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

The sprd crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 66990398b903..7f0bc1e31076 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -705,11 +705,11 @@ static const struct drm_crtc_helper_funcs sprd_crtc_helper_funcs = {
 
 static const struct drm_crtc_funcs sprd_crtc_funcs = {
 	.destroy	= drm_crtc_cleanup,
 	.set_config	= drm_atomic_helper_set_config,
 	.page_flip	= drm_atomic_helper_page_flip,
-	.reset		= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank	= sprd_crtc_enable_vblank,
 	.disable_vblank	= sprd_crtc_disable_vblank,
 };

-- 
2.55.0

