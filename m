Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03205C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE2710F569;
	Thu,  9 Jul 2026 11:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h9U+TWXu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A03010F55A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:53:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8398A402DE;
 Thu,  9 Jul 2026 11:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36E41F00A3A;
 Thu,  9 Jul 2026 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598004;
 bh=c4pplHTTxKkVaXeXR6WCSCm+3aDL6BSlUt8/Z98zILo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=h9U+TWXumpUF+E6f6j0xGQWfJzdgl9U4KJq28+0RzHxPhwsQwrZ9pbSSgVacGklZP
 O2yQ5yFxHg11Qo206refqIWjwNEmnt/61qmBsXYiGVPC5jdWVBVS5sS/Ita5QIBr+P
 N2oJsttXVmh8aShpZBYIwUrdlc2efqn6jpY0i+tSjw2WNEQmK2s8r8z5J5j/0AcT80
 a+wA5Amc7KuXcm9BeEb5XSaXgk2XE64aEa4zjtIazSI7WTeZqn0rOcTCGF+tWc2/m6
 DU4CnIks98BGPXZz5ZagZpXWZ4Cn2jSfwRDI8y0UfdPh9LuGz6xmB6HVYGBGlubqpd
 1kNuKyWfv4DvA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:25 +0200
Subject: [PATCH 59/60] drm/tegra: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-59-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, mperttunen@nvidia.com, 
 thierry.reding@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dkl/iYd/vFdrO/oCnCnOdrgX+JZCc4FOke/Hae9XIJk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3co/G98sPKJbxKHKf+rt1LWJ7Iw3Ao50BPA99dhoG
 BS0eIdDx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI0lTGepdlhvavhVd8v3ZS
 lHf9mU+XxKTee+/M7lzZfOqoYdMOjQuHcg5650p+3ct0reB/1BeGSYzVLBqtdYZXNDSTnnhzPJs
 51WjF33Mij90KKu5LVFrb6P/VC5Bq2pe3etmEhLPrAmuzHm8GAA==
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

The plane reset implementation creates a custom state subclass, but
only initializes a pristine state without resetting any hardware. This
is equivalent to what atomic_create_state expects. Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: jonathanh@nvidia.com
Cc: linux-tegra@vger.kernel.org
Cc: mperttunen@nvidia.com
Cc: thierry.reding@kernel.org
---
 drivers/gpu/drm/tegra/plane.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 0cb30910773f..2148b0c59815 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -22,32 +22,28 @@ static void tegra_plane_destroy(struct drm_plane *plane)
 
 	drm_plane_cleanup(plane);
 	kfree(p);
 }
 
-static void tegra_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *tegra_plane_atomic_create_state(struct drm_plane *plane)
 {
 	struct tegra_plane *p = to_tegra_plane(plane);
 	struct tegra_plane_state *state;
 	unsigned int i;
 
-	if (plane->state)
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-
-	kfree(plane->state);
-	plane->state = NULL;
-
 	state = kzalloc_obj(*state);
-	if (state) {
-		plane->state = &state->base;
-		plane->state->plane = plane;
-		plane->state->zpos = p->index;
-		plane->state->normalized_zpos = p->index;
+	if (!state)
+		return ERR_PTR(-ENOMEM);
 
-		for (i = 0; i < 3; i++)
-			state->iova[i] = DMA_MAPPING_ERROR;
-	}
+	state->base.plane = plane;
+	state->base.zpos = p->index;
+	state->base.normalized_zpos = p->index;
+
+	for (i = 0; i < 3; i++)
+		state->iova[i] = DMA_MAPPING_ERROR;
+
+	return &state->base;
 }
 
 static struct drm_plane_state *
 tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
@@ -129,11 +125,11 @@ static bool tegra_plane_format_mod_supported(struct drm_plane *plane,
 
 const struct drm_plane_funcs tegra_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = tegra_plane_destroy,
-	.reset = tegra_plane_reset,
+	.atomic_create_state = tegra_plane_atomic_create_state,
 	.atomic_duplicate_state = tegra_plane_atomic_duplicate_state,
 	.atomic_destroy_state = tegra_plane_atomic_destroy_state,
 	.format_mod_supported = tegra_plane_format_mod_supported,
 };
 

-- 
2.54.0

