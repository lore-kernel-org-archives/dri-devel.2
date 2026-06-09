Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C02CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C459310E573;
	Tue,  9 Jun 2026 17:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="egV9CtKl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0F610E54F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6r1PsypaDnjuIh+rcjMoVvqWZhLfuwSHm3gYmtbd1v4=; b=egV9CtKl2zmtZ8k4U/BNHCyBgV
 cdI4oI9trmBCcbUbQ/4YC8n9ULe7Y7SlHwPvzBkb+uLNV8VoOmcugAzXCrYX+C1pjTh4Mh/nB80j0
 aY8F+fbjrph9Vqr76bwsKEfE217hCcpiABS0XmuiYVPPxmy/RpU7uHQ5xAMLIdkUc0N6+YR6GPGiA
 iBwZPMZfuNsA1GB6mDeMCam1Zvke2qXVjU0h4wnWYL2EkRZt5oR6BgPq30TCI6oyvsFAlIpEodNWe
 YYywt/pIJzI60KkYR5qCTHYgU+hxXXVGqeXT8JQuSrF4Thb2FJTjWV8ZvB4VWT1fArmVp5U46fBbp
 WimmsnBA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX086-00F5FG-CY
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 19:20:46 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 6/8] drm/colorop: Remove old add-next API as no longer used
Date: Tue,  9 Jun 2026 10:19:39 -0700
Message-ID: <20260609171941.169104-7-John.Harrison@Igalia.com>
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

All users have been updated to the new method for building colorop
pipelines. So remove the old version.

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 drivers/gpu/drm/drm_colorop.c | 16 ----------------
 include/drm/drm_colorop.h     |  1 -
 2 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index b568ae942706..5a6d05557bc4 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -640,22 +640,6 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
 	return colorop_lu3d_interpolation_name[type];
 }
 
-/**
- * drm_colorop_set_next_property - sets the next pointer
- * @colorop: drm colorop
- * @next: next colorop
- *
- * Should be used when constructing the color pipeline
- */
-void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next)
-{
-	drm_object_property_set_value(&colorop->base,
-				      colorop->next_property,
-				      next ? next->base.id : 0);
-	colorop->next = next;
-}
-EXPORT_SYMBOL(drm_colorop_set_next_property);
-
 /**
  * drm_colorop_add_to_pipeline - adds the given colorop to a color pipeline
  * @pipeline: drm colorop pipeline
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 5c34bc3f115f..6888d27e5592 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -463,7 +463,6 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
 const char *
 drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
 
-void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
 void drm_colorop_add_to_pipeline(struct drm_colorop *pipeline, struct drm_colorop *colorop);
 
 #endif /* __DRM_COLOROP_H__ */
-- 
2.43.0

