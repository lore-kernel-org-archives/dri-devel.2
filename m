Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7CAC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C44110F2E0;
	Fri, 21 Aug 2026 14:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iF4e33hK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B2C10F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BA9340D91;
 Fri, 21 Aug 2026 14:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0717B1F00A3A;
 Fri, 21 Aug 2026 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323275;
 bh=acxmok5THKeDlc4VcEzLEdDbzEYBBROL2zvQZG1+s1Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iF4e33hK/C7oV2CHwIf3bd9DUvxvaAnyI8puOvYg//t4K8h9+mM6iJkPrFnCKJvbi
 YRfmF8e16aFbFVYnit1bnHwrM2yxUqzv1hzMz3+G6fECd6aiE3jA4aMa+yelMupu5j
 fTUY/x0qxytxizYrQx+9BUY107mWmRy76f/GEYmGRnr0KSOAPaRzHiYvnn+t7lgh1z
 Qghv9CAZu7ghk8Viciqa7I9nEgIwqx5GvkGo9dAvd37pWhOMtpAjXhR1ITLS3CARr1
 MOSlhYsudbOUSUZLiVLbmJOipUmGTYfyTE32opTolcQb6EAsxSwf/vlLuZJa+hgOJa
 iCpCaXwZWJijQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:23 +0200
Subject: [PATCH 47/70] drm/ast: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-47-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Mn/aCG+fqQyETfjHAsj5zNtzYkAYojwsnIno2Y/Lm5Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdybzMs+Xazz4PPMh9Y5OBBdvuXz/W66f4vt3lJTYnZ
 5dMcfq3jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRbnHGWunrvL3y8w3KNXIv
 3K1zOO/68Pr20luZXIV8lyYUrO2r0SgWzb3LUXn97iHHPwzf1le6M9ZXbdNVU/jW3/rPMv5+ZoP
 E3bPrNAJagosnKS9taNJfKWwYcW/WlLwD69zuzd4/b8oFlYUA
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

The ast crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index d5ed8c5c7925..ea0ef8096aa9 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -886,21 +886,21 @@ static const struct drm_crtc_helper_funcs ast_crtc_helper_funcs = {
 	.atomic_flush = ast_crtc_helper_atomic_flush,
 	.atomic_enable = ast_crtc_helper_atomic_enable,
 	.atomic_disable = ast_crtc_helper_atomic_disable,
 };
 
-static void ast_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *ast_crtc_create_state(struct drm_crtc *crtc)
 {
-	struct ast_crtc_state *ast_state = kzalloc_obj(*ast_state);
+	struct ast_crtc_state *ast_state;
 
-	if (crtc->state)
-		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
+	ast_state = kzalloc_obj(*ast_state);
+	if (!ast_state)
+		return ERR_PTR(-ENOMEM);
 
-	if (ast_state)
-		__drm_atomic_helper_crtc_reset(crtc, &ast_state->base);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
+	__drm_atomic_helper_crtc_state_init(&ast_state->base, crtc);
+
+	return &ast_state->base;
 }
 
 static struct drm_crtc_state *
 ast_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 {
@@ -932,11 +932,11 @@ static void ast_crtc_atomic_destroy_state(struct drm_crtc *crtc,
 	__drm_atomic_helper_crtc_destroy_state(&ast_state->base);
 	kfree(ast_state);
 }
 
 static const struct drm_crtc_funcs ast_crtc_funcs = {
-	.reset = ast_crtc_reset,
+	.atomic_create_state = ast_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = ast_crtc_atomic_duplicate_state,
 	.atomic_destroy_state = ast_crtc_atomic_destroy_state,

-- 
2.55.0

