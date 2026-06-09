Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24781CD98CA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6779910E55B;
	Tue,  9 Jun 2026 17:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Bx/Oxiem";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D3310E54F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yGDedy/Y9emBTBxfFPOWapvLC/7v25AYteWJgXWHobA=; b=Bx/Oxiem4cQQP9m6gO2fK8FeJo
 bcMi8aACaMlmDpfDVPVyvk/yMrrXSXno3gyMcKcl812lw04r1wA7btYnogCz8vh0xpRtDFsAYdN/s
 U0YU95xpWmxqyqJ+eVIIurVGX0nb2gdM9hSEsXpMX/X6d8Ny4dolwbSXzOHyKo7GzhZ8NQNbz43xN
 tP+3Oa+7krh0Iv0KpaD+gBwb4h5vYFaiIW2/qRzE5K4cBfuBKBrg22JVqIBjDCWNBTTCHqCYgCWNn
 Bi4uN1fDiyA3f36fNVM1eYy+CMSdtEaDQ+MCiNJyGeBVFLePRmEFKiPWiej+Y1LpcAvhQMZbNifVq
 KrlxzCwQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX084-00F5FG-99; Tue, 09 Jun 2026 19:20:44 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 4/8] drm/amd/colorop: Update to new pipeline API
Date: Tue,  9 Jun 2026 10:19:37 -0700
Message-ID: <20260609171941.169104-5-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609171941.169104-1-John.Harrison@Igalia.com>
References: <20260609171941.169104-1-John.Harrison@Igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Switch to using the new method for building colorop pipelines.

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
CC: Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c    | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 48f5c431eaf9..6b5741d9d98b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -86,6 +86,8 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	if (ret)
 		goto cleanup;
 
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
+
 	list->type = ops[i]->base.id;
 
 	i++;
@@ -102,7 +104,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	if (ret)
 		goto cleanup;
 
-	drm_colorop_set_next_property(ops[i-1], ops[i]);
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 	i++;
 
@@ -119,7 +121,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	if (ret)
 		goto cleanup;
 
-	drm_colorop_set_next_property(ops[i-1], ops[i]);
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 	i++;
 
@@ -137,7 +139,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 		if (ret)
 			goto cleanup;
 
-		drm_colorop_set_next_property(ops[i-1], ops[i]);
+		drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 		i++;
 
@@ -156,7 +158,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 		if (ret)
 			goto cleanup;
 
-		drm_colorop_set_next_property(ops[i-1], ops[i]);
+		drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 		i++;
 
@@ -174,7 +176,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 		if (ret)
 			goto cleanup;
 
-		drm_colorop_set_next_property(ops[i-1], ops[i]);
+		drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 		i++;
 	}
@@ -192,7 +194,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	if (ret)
 		goto cleanup;
 
-	drm_colorop_set_next_property(ops[i - 1], ops[i]);
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 	i++;
 
@@ -210,7 +212,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 	if (ret)
 		goto cleanup;
 
-	drm_colorop_set_next_property(ops[i-1], ops[i]);
+	drm_colorop_add_to_pipeline(ops[0], ops[i]);
 
 	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
 
-- 
2.43.0

