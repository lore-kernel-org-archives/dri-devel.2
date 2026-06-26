Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F197C44508
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1847210F622;
	Fri, 26 Jun 2026 13:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="i23xqBh1";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B14010F5F5;
 Fri, 26 Jun 2026 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782481335;
 bh=8atRt4B/PXAXgr5z4WvxSpmOYT8k6lDmprmy2FqFD64=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i23xqBh1BGzGVdxefVLl9XYf7hxCiy/KkIg0mELDBMo7jlkwnzNZyadsuAPx1j9I6
 DxfQcnntMpD1bIJrWbsP3H5NuLdMBw2xy5R0NG4gilflgNbBAETlBFVoS0Whgq9CMe
 YKmNME/gMAsDOLwXnz2ZPSfAc9OY5hjG/ZTYEx9cnAZk1OwhJbsCJNZT27Bji60l6s
 zDKzCPdwzUj4Y5pLlzd8aoqybsAxGQ0tbVufFoPshlV7dwGvGxmmv/Mr+9w1N52roW
 Orj+a36FyKFEqx6GG187UV1StS/fnwHDJccrjmi8rIZf2n/a2jwRaKboGGXlwa3noL
 fxbcUB8l7BTRQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v10.5 26/29] drm/xe: Avoid using stolen memory for DPT.
Date: Fri, 26 Jun 2026 15:42:17 +0200
Message-ID: <20260626134222.1198252-27-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626134222.1198252-1-dev@lankhorst.se>
References: <20260626134222.1198252-1-dev@lankhorst.se>
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

On systems with media GT, extra latency is added when accessing stolen
memory when the GT is in MC6. Since we additionally aren't counting how
much memory is used for stolen and we could in theory fill up the
entire stolen area with DPT's, avoid using stolen and only use the
default memory region.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 33 +++++++-------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index f93c98bec5b5f..86013ef532fd7 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -164,31 +164,14 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
 		dpt_size = ALIGN(intel_rotation_info_size(&view->rotated) * 8,
 				 XE_PAGE_SIZE);
 
-	if (IS_DGFX(xe))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size, ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_VRAM0 |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   pin_params->alignment, false);
-	else
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_STOLEN |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   pin_params->alignment, false);
-	if (IS_ERR(dpt))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_SYSTEM |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE |
-						   XE_BO_FLAG_FORCE_WC,
-						   pin_params->alignment, false);
+	dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
+					   dpt_size,  ~0ull,
+					   ttm_bo_type_kernel,
+					   XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
+					   XE_BO_FLAG_GGTT |
+					   XE_BO_FLAG_PAGETABLE |
+					   XE_BO_FLAG_FORCE_WC,
+					   pin_params->alignment, false);
 	if (IS_ERR(dpt))
 		return PTR_ERR(dpt);
 
-- 
2.53.0

