Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E92CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1485210E541;
	Tue,  9 Jun 2026 17:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="r+3fV1tT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A1C10E541
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8Ew4rttDecOZtUwYH4uUZYSR4J6EkENQSphIIYbcwls=; b=r+3fV1tTi//7HXKuPmonUj84b3
 9Te2ER/T1AeLtF/vlh4XQ5TTgaTyef844YDzZ8w4109U+3ZKLjISPMJa7NCCYch3Q4bw+Mlkh08IJ
 q8hwuydmF4Isxwa5t+9/J6zgznFjP8/9EkX8mJ94m+g9ahlKv5XRDQxqwojNja6CQoRyILA6AOip8
 AsAilEbLaue32YXWYphkeS0lliUzWhgZ18EA96n432tHqes9Jhx5v2GbZXXe8nOFpagL+GY8OV9tt
 39mewGH1RR9vc8YobhH+muIdZ6sGp6wJVCKmoQaOKApXFfvnNWVu7+/7NI3FQwTpHqaGbUyJX0sQs
 2qfV/FmA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX082-00F5FG-Ue; Tue, 09 Jun 2026 19:20:43 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [RFC PATCH 3/8] drm/i915/colorop: Update to new pipeline API
Date: Tue,  9 Jun 2026 10:19:36 -0700
Message-ID: <20260609171941.169104-4-John.Harrison@Igalia.com>
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
CC: Suraj Kandpal <suraj.kandpal@intel.com>
CC: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 .../gpu/drm/i915/display/intel_color_pipeline.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 6cf8080ee800..49dac9627553 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -53,7 +53,7 @@ static bool plane_has_3dlut(struct intel_display *display, enum pipe pipe,
 
 static
 struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *plane,
-							     struct intel_colorop *prev,
+							     struct drm_colorop **pipeline,
 							     enum intel_color_block id)
 {
 	struct drm_device *dev = plane->dev;
@@ -100,8 +100,10 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
 	if (ret)
 		goto cleanup;
 
-	if (prev)
-		drm_colorop_set_next_property(&prev->base, &colorop->base);
+	if (!*pipeline)
+		*pipeline = &colorop->base;
+
+	drm_colorop_add_to_pipeline(*pipeline, &colorop->base);
 
 	return colorop;
 
@@ -117,7 +119,7 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 	struct drm_device *dev = plane->dev;
 	struct intel_display *display = to_intel_display(dev);
 	struct intel_colorop *colorop[MAX_COLOROP];
-	struct intel_colorop *prev = NULL;
+	struct drm_colorop *pipeline_root = NULL;
 	const enum intel_color_block *pipeline;
 	int pipeline_len;
 	int ret = 0;
@@ -132,14 +134,12 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 	}
 
 	for (i = 0; i < pipeline_len; i++) {
-		colorop[i] = intel_color_pipeline_plane_add_colorop(plane, prev,
+		colorop[i] = intel_color_pipeline_plane_add_colorop(plane, &pipeline_root,
 								    pipeline[i]);
 		if (IS_ERR(colorop[i])) {
 			ret = PTR_ERR(colorop[i]);
 			goto cleanup;
 		}
-
-		prev = colorop[i];
 	}
 
 	list->type = colorop[0]->base.base.id;
-- 
2.43.0

