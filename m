Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A713AC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E7710EFA2;
	Tue, 15 Sep 2026 14:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nsE9wMk5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC43E10EFA2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EA436022A;
 Tue, 15 Sep 2026 14:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526341F000FF;
 Tue, 15 Sep 2026 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482308;
 bh=dxhOXyU03PHBoIPpDZZPyZnL9E7XDepnYiIp8qFdUCI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nsE9wMk5DztUJtqPcrL3ma0IkTnBCtBPqpPw/jLJR5K2Pogt0FIKlfCk4rbuGVZDI
 Ik0E7mBoZMWJq74GEBo2KNfOMtAvVeOZkZJxny2bkeg3kEB1FysgirLi9LCRBa08z8
 ccmnAVPbT7/mzynx+dM04cKyF2xRZhTyXmTX44LiN70AVKbvIiPTIUXxRQXcQUlU+n
 9VWNBOhScYT6cZwhJBvlp5DTjW8o/oorc1ZrIGO9BFqpqRNDI7I2CE48MXUlmzy+1f
 lORfzlMBNfnAY7V91icXPVzdzuElJZLxw+lWCKK7ZNd5acXsWqGWAVrh0N31RIUJvd
 PJSSHOS8kn4Hw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:45 +0200
Subject: [PATCH v5 04/11] drm/mcde: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-4-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gFFJqXJT6jIh2rRQH3X++YvTUd8Cx2LTG7ixK4mzF30=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ/Wsi/9c8pfQb1LoCEo6rHfs0/E5ST4TvDYKJzu+Y
 qzxun65YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExk413GOktzmcIbm17q+/hf
 yTowIfSHy8N1/dsC+PtsosLPu+/Mf3V/l+61VZtfn/LpCt/7XHgXL2PDooNlE6aURL9UML7gwrt
 ij83OQz5CN2eW9Wydvf7/e5miZ5OqNTSlSn00g1WDBTqip6wCAA==
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

The mcde crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 50c90cf84a9a..d1d01f3d8ab4 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -1506,11 +1506,11 @@ static int mcde_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomi
 
 	return drm_atomic_add_affected_planes(commit, crtc);
 }
 
 static const struct drm_crtc_funcs mcde_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

