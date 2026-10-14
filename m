Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4743CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E1210FF08;
	Wed, 14 Oct 2026 17:31:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5D710FF0D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 627714398C;
 Wed, 14 Oct 2026 17:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A5D1F000C6;
 Wed, 14 Oct 2026 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999076;
 bh=ylIvmJ1fWT+/RvL3mp/BYepBkoLinQI+HeoHPbwUvEY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OgEQ9SKToqaft4PCMVbkOqXlfrTgdUoQQXI2cNVaETzQNgUxhLrunXeUWBp9NcFXj
 CJmOAOzR+bkpv4kKKMCt2584+ZNk4i6fWz+QZIgY/386EGy8A7mRKcYT9kJ7q5n3Vv
 saXo9E878Af6lmzY9rTNxn67obcKqKGh7IHO6p7KAi0nRWKAQMokuZDT4uAgsOqIvF
 wpCifL/Sk7Kb0PJIbHRjevRHj1KMN3dHz1N2EqLA8LJqXEY/o27zbnn3KgTegeXUGS
 ZuftVI64tkTuKqPlPlFIxouyHtfxVf6oPuCfXVjjBXpdO/c8ksm64Iei3KyWUOQJ9t
 DgEE1/RdIaKmQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:30 +0200
Subject: [PATCH 67/75] drm/malidp: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-67-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xWlkU5Ox3RrBinU9oqiBhf+uDT38OomMGDksRvvpvN8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6fzhRy5dGlZpP0ftnMc33qzX7p+SRP/cKBb5m9u6
 +2q+R6LO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE+jsZ6xTzbyhstp748WWo
 4qOSzYwN6Yq+LnzmaW5Bq4591/VfHhkivzHiabpRoihr2mH/SIOnjA1bOi7cWeMdH/fme9ySezE
 zZzseuORkG/akc9XRd38eq/+U4Vu2tqFUcv6Dj+8rb11a8SUMAA==
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

The malidp writeback connector reset implementation creates a custom
state subclass, but only initializes a pristine state without resetting
any hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f8be65119e3b..edd924ba722d 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -62,22 +62,22 @@ malidp_mw_connector_mode_valid(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs malidp_mw_connector_helper_funcs = {
 	.get_modes = malidp_mw_connector_get_modes,
 	.mode_valid = malidp_mw_connector_mode_valid,
 };
 
-static void malidp_mw_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+malidp_mw_connector_create_state(struct drm_connector *connector)
 {
-	struct malidp_mw_connector_state *mw_state = kzalloc_obj(*mw_state);
+	struct malidp_mw_connector_state *mw_state;
 
-	if (connector->state)
-		__drm_atomic_helper_connector_destroy_state(connector->state);
+	mw_state = kzalloc_obj(*mw_state);
+	if (!mw_state)
+		return ERR_PTR(-ENOMEM);
 
-	kfree(connector->state);
-	connector->state = NULL;
+	__drm_atomic_helper_connector_state_init(&mw_state->base, connector);
 
-	if (mw_state)
-		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	return &mw_state->base;
 }
 
 static enum drm_connector_status
 malidp_mw_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -109,11 +109,11 @@ malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 
 	return &mw_state->base;
 }
 
 static const struct drm_connector_funcs malidp_mw_connector_funcs = {
-	.reset = malidp_mw_connector_reset,
+	.atomic_create_state = malidp_mw_connector_create_state,
 	.detect = malidp_mw_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = malidp_mw_connector_destroy,
 	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

