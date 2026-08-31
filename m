Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC081C624CF
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCF410E95D;
	Mon, 31 Aug 2026 15:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GUOGY/gW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D2810E958
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:35:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B2D8418B1;
 Mon, 31 Aug 2026 15:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9533A1F000E9;
 Mon, 31 Aug 2026 15:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190512;
 bh=Uz3NJDfMUuHNjcHmCDlKB1ocAKq3cnzHRnlP5aAUguA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GUOGY/gWaOnYxmTje449DMwn6nRfHvTs/B4U9kH5Uw6+h1EIIy8rw4sWQlQ2LyV0B
 +ShUzfcmTgZLjmD5rK3AYMdYN2lyQUepvl/Bqi7qsIiC+b2YxKE9OEGzTFMoaxlMrl
 /DzlEUMuKPKKD1w7UvZ3Bw22D15/Q0LzvLsuiSWwRzd7dZOww1Tuj5m7ViBaivKprG
 AT/nR7k2tz9eqX16zuf5EExL5VZfG3Q5ybn6qAK7/B7bCl33nQwNg9MMD2fQ6TO9g2
 kE9z+dYmqzziLUwebTSvTMY6GvPLQpUZmxnyH7XSA58skv6cbXpmiGg6FMTKBo2TYW
 4N1FqXAiQaMPQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:24 +0200
Subject: [PATCH v2 11/13] drm/sitronix: st7920: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-11-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=mripard@kernel.org;
 h=from:subject:message-id; bh=GBy4VwIR8/zfsyNzWSFjYO/pI2kGkpdzXNk3+aPg73o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5zNkJpZ0VO3sSnpUzWX1v3Flhk7dVfW9QaxJyy9//
 v9NdvW9jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARiwTGWqlsrTebt4m68/95
 W9b6YIfWy5Np/f+U55Tv/JWYKqMvP3fZKtOkIxOm5wR0XGbbFed+g7HOdorpNc7bryvVb3c23fO
 1EHh64++SGTMntbTkPEs3b/8R8GWy4ckw99OnfcM1fz7Xsl8OAA==
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
__drm_atomic_helper_crtc_reset(), and warns if there's a previous state.
It does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 0a75e9319080..9887ed746ceb 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -573,21 +573,21 @@ static void st7920_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	drm_dev_exit(idx);
 }
 
 /* Called during init to allocate the CRTC's atomic state. */
-static void st7920_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *st7920_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct st7920_crtc_state *st7920_state;
 
-	drm_WARN_ON_ONCE(crtc->dev, crtc->state);
-
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
@@ -627,11 +627,11 @@ static const struct drm_crtc_helper_funcs st7920_crtc_helper_funcs = {
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

