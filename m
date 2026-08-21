Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D1EC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D31610F178;
	Fri, 21 Aug 2026 14:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MccviKBe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6699D10F15D
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CEA8B4402E;
 Fri, 21 Aug 2026 14:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B24D1F00A3A;
 Fri, 21 Aug 2026 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323215;
 bh=Rva9RyYSsEZX1ExcOXToTUCqxMjM7NlCUGBvOq2/E5s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MccviKBeFrvOFzxT8Zs/TkMTsrcC/4L3Kt5f7OnUzAgzKvHh/9iLViXYE5i+LqYkF
 TJvC6dG8Am1/iN/mXa6K5lca2m7O33WOOfdL54eIyNpH9fZ3+O/XWeoQbkjX4xFrvy
 Sj+NKlACke+K2Rx8hAR105MQxs23EVo6nx31ENEQHuS/UcAvvlVijoJkKG59VYa4J7
 DWx9t8yH3g4gybF4z9MMUM6kyYfXQAYVEk48iGZC+dc4w9RgUDTuXWj8D36CYXMfJx
 mpZYBZrPFoVa+A5sHdPV/t5ODDEbesgENlXpO5LCUAha3PHYSPk1MEAAV4ixETdXr3
 1ZCxBeMs452dg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:58 +0200
Subject: [PATCH 22/70] drm/simple-kms: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-22-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=mripard@kernel.org;
 h=from:subject:message-id; bh=++8DGtMqKqgZOPGV63Xcy+nd9sD40eICfk8MgZY/CBI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyUzneleG+4nabpjQsuTah4ebnhpKvEw+efBI4UrmP
 B/ZObNTO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEYhYy1unLXObzMw57He44
 wS5jG8ttxhzTW4GXk6WTjqyTsuzmnLJzecHEhbw2zC+Ff+3ee26NHmPD9/ZV2s55dmIl/zZpZ1a
 r53BYsk0z7Gf6vKh6+baac9u0eMIm8XKdYXq+3CdUX/VASjwA
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

The simple KMS crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 6c77154dc54e..cc19039ec641 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -145,11 +145,11 @@ static void drm_simple_kms_crtc_disable_vblank(struct drm_crtc *crtc)
 
 	pipe->funcs->disable_vblank(pipe);
 }
 
 static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_simple_kms_crtc_duplicate_state,
 	.atomic_destroy_state = drm_simple_kms_crtc_destroy_state,

-- 
2.55.0

