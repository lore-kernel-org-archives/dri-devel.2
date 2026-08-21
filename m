Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7431EC5DF96
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D40E10F2FD;
	Fri, 21 Aug 2026 14:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NQeuqysY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BA210F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BA3043FE0;
 Fri, 21 Aug 2026 14:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8711F000E9;
 Fri, 21 Aug 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323314;
 bh=xNeHeQm3xxsT74SWkKRGF9Y4Y5K7mSnOid8cWSfyPNE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NQeuqysYfpIKIP7CCrSEHXFsURtIpO9buWBWtmfIiES6ipHCofWnDyBMdhQV1qg96
 0QrICxy/Ozyuiy3eeVE7HtdReWyPJtz2eAbsDf5zaxi/o4NrBaX6EZdx3tt8WtmJKv
 8QhBIvnkfrYwW2c07TP+hL2MvJt3qSLstEicaiYeBpIIOCKBd7zBSYn3Vym8bjrG2w
 B9Vg+Btub3A6NK3xRjXLnCKPOOIDqqU/Gvyt/SnLpe17IwM5HqW2XgexB9/6FDnEwp
 kR3g3oeoT+qKUlPpKCjEQ4+rqyzw3I5yKhns75dgJ4GqtnmvO0Izu3a5W59zfOhI2J
 3J6SurDDdgDVA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:39 +0200
Subject: [PATCH 63/70] drm/sitronix: st7920: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-63-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=mripard@kernel.org;
 h=from:subject:message-id; bh=B70RPBCnUzUC7LqMzofI+//AvzG1KNUWI8JoCk+aebI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdySIC5RXsxX0TH5yfw+1r+dVvqvvyj+uW7k36KSBza
 sLzdT9rOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE+EoY61Nv+P071HL2xqzT
 TbwrT0S29jyW9DTufbXle7pUqofbi50tZ9lMihvqc+ce818sL2Crwtgw2bwkJfNRVbbN8Un6UQX
 eF+Pq/K72HLSavOcCJ1O114Eupemz1s+vjpiXkd9ZG/mstQoA
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

The st7920 crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index d320391801f3..debbdb55fdc1 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -573,21 +573,23 @@ static void st7920_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	drm_dev_exit(idx);
 }
 
 /* Called during init to allocate the CRTC's atomic state. */
-static void st7920_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *st7920_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct st7920_crtc_state *st7920_state;
 
 	drm_WARN_ON_ONCE(crtc->dev, crtc->state);
 
 	st7920_state = kzalloc_obj(*st7920_state);
 	if (!st7920_state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_crtc_reset(crtc, &st7920_state->base);
+	__drm_atomic_helper_crtc_state_init(&st7920_state->base, crtc);
+
+	return &st7920_state->base;
 }
 
 static struct drm_crtc_state *st7920_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct st7920_crtc_state *st7920_state;
@@ -627,11 +629,11 @@ static const struct drm_crtc_helper_funcs st7920_crtc_helper_funcs = {
 	.atomic_enable = st7920_crtc_atomic_enable,
 	.atomic_disable = st7920_crtc_atomic_disable,
 };
 
 static const struct drm_crtc_funcs st7920_crtc_funcs = {
-	.reset = st7920_crtc_reset,
+	.atomic_create_state = st7920_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = st7920_crtc_duplicate_state,
 	.atomic_destroy_state = st7920_crtc_destroy_state,

-- 
2.55.0

