Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D8ECD98C7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC09010E4EE;
	Tue,  9 Jun 2026 17:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lTO98uF3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60F910E4EE
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iWfqXz4u8FcidrqplEq4BgfB6XPJyYIY+QArJRt2EPM=; b=lTO98uF3doyL/xJhdRxAW1yNBw
 cnd+rYmgxqcWramXP7ZsSsbOq1ENHqeLymxu5suNtva0+rSC1UoFpa3UDD08/T5PRS0LN2SNHasIB
 Wwnsue+Bv+v9/Brbk2HpQyhq+MBXpF2Zn71LWnMm25HGGwCXy2HJEiYXJPbPXmrAi+gV1Qvc96zgw
 8cUQqyt7tgDk0y6C4B0b6OgwmQCQCJ3VLVeEN0V5x6rBbMW2BExse3ECFcCBszh2JxGpr7neY3RVm
 G5/91ValiTce2/mJTY+R+tjUuh7PQyk1PrxaVJe24LsEdFFWFNpelvMMuFzFhEAlCZt9NdAMwaAXp
 EEdPyK4w==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX081-00F5FG-JX; Tue, 09 Jun 2026 19:20:41 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: John Harrison <johnarr@igalia.com>
Subject: [RFC PATCH 2/8] drm/colorop: Create pipelines via 'add to pipeline'
 instead of 'set next'
Date: Tue,  9 Jun 2026 10:19:35 -0700
Message-ID: <20260609171941.169104-3-John.Harrison@Igalia.com>
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

Add support for building colorop pipelines using an 'add new entry to
start of pipeline' helper instead of 'add new entry to end of
pipeline'. This is a pre-req of converting the pipeline to a proper
list rather than explicit 'next' pointers.

Signed-off-by: John Harrison <johnarr@igalia.com>
---
 drivers/gpu/drm/drm_colorop.c | 25 +++++++++++++++++++++++++
 include/drm/drm_colorop.h     |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index c0eecde8c176..b568ae942706 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -655,3 +655,28 @@ void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_color
 	colorop->next = next;
 }
 EXPORT_SYMBOL(drm_colorop_set_next_property);
+
+/**
+ * drm_colorop_add_to_pipeline - adds the given colorop to a color pipeline
+ * @pipeline: drm colorop pipeline
+ * @colorop: drm colorop to add
+ *
+ * Should be used when constructing the color pipeline. Adds the new colorop
+ * to the end of the pipeline and sets the 'next' property of the previously
+ * last colorop (if there is one) to point to the new colorop.
+ */
+void drm_colorop_add_to_pipeline(struct drm_colorop *pipeline, struct drm_colorop *colorop)
+{
+	struct drm_colorop *last = pipeline;
+
+	/* Head entry does not need processing */
+	if (colorop == pipeline)
+		return;
+
+	while (last->next)
+		last = last->next;
+
+	drm_object_property_set_value(&last->base, last->next_property, colorop->base.id);
+	last->next = colorop;
+}
+EXPORT_SYMBOL(drm_colorop_add_to_pipeline);
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 7f0bd58fb625..5c34bc3f115f 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -464,5 +464,6 @@ const char *
 drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
 
 void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
+void drm_colorop_add_to_pipeline(struct drm_colorop *pipeline, struct drm_colorop *colorop);
 
 #endif /* __DRM_COLOROP_H__ */
-- 
2.43.0

