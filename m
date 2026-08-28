Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4969C624C8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B46010E68E;
	Mon, 31 Aug 2026 07:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YYuvht7X";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9647510E0B6
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 11:04:55 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cc1c3c90074so703854a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787915095; x=1788519895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jKxWNMOiyJDVCKUpUfvxRgy7YCO58oIDyM2gb3Klkzk=;
 b=YYuvht7XUXdgeNGoh84sXsNcDHnLRke+WAIdQ/W1bWC90PpW9dm9UGzlLb7CgLd5xS
 VBl45rimv0iGYSZTXJI2GoObZMdEjU2nLkcYvmbFDFG9nLQUSb+MAo7AG6G8+sswFnQ5
 20ef1QM4YK/GtuLGAaq80shAbTc20pl5U4/lSQaaeZT6HlIKYrOrOL00j/XV61gDzU+Q
 9fWwsSJ/9iE1e07YLAyKUrBJ2jbUeaaWC8+KjpsEDyIk6th5PKUsYzJssFmXA/dCJhqt
 vOwsJEzsOlf3FLfSM9gW+fM60DYoSaPJ5nrqnclIZJ1WiSwdK+pS951Oizi3jwBKWok8
 RDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787915095; x=1788519895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jKxWNMOiyJDVCKUpUfvxRgy7YCO58oIDyM2gb3Klkzk=;
 b=IsNr03Xgbd680rmptr+GfCPR6eEzB4aDBoqb3oKlRa2jGU7fuZPD4oW1lZQy0NLTUS
 0bsXntDfUYtLd/bD+o1mGQa8my0hYIJKjuyOEFP2rZ4jLOVN+coUulhgLW03XUSE9xPQ
 LreDBWGeZIlNPFo4NMy7O8ovR0u30Jmtw6OMcU6YS4HfgT2D7n034P+oUxD2QAb3xBgo
 aTBZ4zCRSG0oiCHVDCiZySLmW3bZgXk9VxUiHqJO/zFBboB+WDPAw4zchcdNJ+MU9zV2
 qZ/CSBoz2XOGENDiwXMskNXiifrMIG6wSJLJNspu5DussZSOvANe/EBUmMi5vHSbQbIl
 Vxng==
X-Gm-Message-State: AFuF++lgHBrhKrw5V8pF6j3L7zcVXOwVPh+R7Yj3lklJF7ytuI+xzUsY
 1fA9qtH43XRHdGe19Wl1x05D0XNItba95qhrapvngLpaQlHFCxfVlYPU0vk9JRaN20E=
X-Gm-Gg: AR+sD12fXk+Vt5kJBeW61V1aOkbv/XxgTCtwAMFFBAySSkHgxXkVMbMaI16Sbau3Fzj
 MJwqsxClf4Sr2MKRxf9ODT7iJ73JRbSBQIgAxvW8Jv9JXfaG/Hn1yBHwxIGQty2/K+pWuLP6VCX
 r/IhKF7FnfId7kxd++NNTv7e3FmAXIwie+R9lnQip+1DpQDuCOQe7r8ijM+N8dMgCbnIjOAHY8I
 YOaySdIEHor0Ly+lcJNFqYAEPejnAG0BJ27tIw/1sK6qEfblgz6VW3gf3D0nO8UO+/BG5UcTSdK
 BsW2ZsmoiAfkigAsODL1YytvmbIkm5EnvQ4qX73AQOii820z1dKs4CjGgOnMswmPcBv5K7SLxJ+
 KxJUf9s2YFEuH4tucxTZH6fUssY2Tfs5DOAFt3sF9Y+gFefdRNMAKSeK/RLDdLVHjkM3+7iiRSy
 dQaBL6ZWpUUTrtB02RJMJRTQKX+ed3M1OAjZ7pr5JRfZV3qLWsleYkln8kVNsIrQbUw8qsWWc=
X-Received: by 2002:a05:6a20:9184:b0:3c4:3112:45 with SMTP id
 adf61e73a8af0-3d26562eac5mr10258025637.1.1787915094977; 
 Fri, 28 Aug 2026 04:04:54 -0700 (PDT)
Received: from ebizmis.com.com ([61.136.101.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-856a3d689ccsm433268b3a.58.2026.08.28.04.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:04:54 -0700 (PDT)
From: fausten <yunfeng.li.nb@gmail.com>
To: dri-devel@lists.freedesktop.org,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Yunfeng Li <yunfeng.li.nb@gmail.com>
Subject: [PATCH v3] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION as
 unset
Date: Fri, 28 Aug 2026 19:04:37 +0800
Message-Id: <20260828110437.1592832-1-yunfeng.li.nb@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
References: <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

From: Yunfeng Li <yunfeng.li.nb@gmail.com>

The cursor plane code validates cursor dimensions against
SVGA_REG_CURSOR_MAX_DIMENSION before every cursor update, and
rejects the update with -EINVAL if the cursor is larger than the
reported maximum.

However, this register is only available on hardware versions 18
and above, which introduced cursor MOBs. Older hardware (e.g. a
VMware Fusion guest with SVGA version 2) returns 0 for it.
In that case every cursor update is rejected,
and the log is spammed with:

  [drm] Cursor dimensions (64, 64) exceed device max 0

The visible symptom is that the hardware cursor never appears at
all on VMware Fusion guests (SVGA version 2), making the mouse
pointer invisible even though the input devices work fine.

Treat a reported maximum of 0 as "not implemented" and skip the
dimension check in that case, restoring the pre-existing behaviour
of accepting the cursor.

Tested on VMware Fusion with an SVGA version 2 device where the
cursor previously did not show up.

Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB cursors")
Signed-off-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
---
Changes in v3:
- Use an explicit cursor_max_dim > 0 comparison (Zack Rusin).
- Fix the comments: the register requires cursor MOBs which exist
  only on hw version 18 and above; it is not Fusion-specific
  (Zack Rusin).

 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500..3d4660684 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -237,8 +237,10 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plane *vcp,
 	mob_max_size = vmw_read(dev_priv, SVGA_REG_MOB_MAX_SIZE);
 	cursor_max_dim = vmw_read(dev_priv, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-	if (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
-	    vps->base.crtc_h > cursor_max_dim)
+	/* Cursor MOBs, and thus this register, exist only on hw version 18+. */
+	if (cursor_max_dim > 0 &&
+	    (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
+	     vps->base.crtc_h > cursor_max_dim))
 		return -EINVAL;
 
 	if (vps->cursor.mob) {
@@ -748,8 +750,10 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 		u32 cursor_max_dim =
 			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-		if (new_state->crtc_w > cursor_max_dim ||
-		    new_state->crtc_h > cursor_max_dim) {
+		/* Cursor MOBs, and thus this register, exist only on hw version 18+. */
+		if (cursor_max_dim > 0 &&
+		    (new_state->crtc_w > cursor_max_dim ||
+		     new_state->crtc_h > cursor_max_dim)) {
 			drm_warn(&vmw->drm,
 				 "Cursor dimensions (%d, %d) exceed device max %u\n",
 				 new_state->crtc_w, new_state->crtc_h,
-- 
2.33.0

