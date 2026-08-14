Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC89C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F124E10F61D;
	Fri, 14 Aug 2026 14:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jl+A//Ol";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5A410F61C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:57:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACBEB60204;
 Fri, 14 Aug 2026 14:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC9A1F000E9;
 Fri, 14 Aug 2026 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719468;
 bh=7Kc3Xvc0zPz9yTx3/wfmr+X6PpbmfHMGF+XxfWaLbMA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Jl+A//OlAvY64+DByp+R/iufGAR/GyQYM0aZq2WYsJFnESvxDzsc2IkRCvSVL7mP6
 DsbEIc3Ny/HIo5eJsjutP5W1Nla57yrOXds26JjkMSCDFPi1Qm/UA9QElKLBydcITT
 v7zxHvDzOgTZ/cJ2HZPfbc1l7ZkDaOXnslFzRFuwQeO5s+zb/wF3Dh/RAvddwH9Smb
 dsgmNpUCMB+WOYH0rxjDNxm6abHonhoguyQtQOkZ69ivWDkT06kil+1fWNJRgaZzaY
 nPTj0PEKfCGohHmiZbqGXu4sAg6TaOsDqIUZYcIoPVU/5gDzcFYv17K2YqO11VvnSv
 waNJO0Vfcod9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:56:53 +0200
Subject: [PATCH v2 04/61] drm/gem-atomic-helper: Switch
 DRM_GEM_SHADOW_PLANE_FUNCS to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-4-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Zug22YZtcOPzo2LQAAhzmsBPZfod5ldRkekPJ9UDhX0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OsemPl6y1U8wYenD6APScyuYLcsePvJ+F8L7Zlalr
 FTNE3fnjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR4zMYG17Y6hx83/ZryyWe
 guKzVrbMdem+Oxg2nljVm9W9NnBX4mbHj/eFlv9XmJVS4Om3xuQWK2N9hW7AZevSxLVJ8juNlkU
 XWr5I235gIs/F6AfBC97r3xZOVNm0eQfv3Oac/ZuXWi3fMl0EAA==
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

DRM_GEM_SHADOW_PLANE_FUNCS currently sets .reset to
drm_gem_reset_shadow_plane. Since
drm_gem_create_shadow_plane_state() now exists and only handles
pristine state allocation without conflating it with hardware or
suspend/resume reset, switch the macro to use .atomic_create_state
instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_gem_atomic_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 8a3bb27233db..da8a4fb442b4 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -108,11 +108,11 @@ void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
  *
  * Drivers may use GEM BOs as shadow buffers over the framebuffer memory. This
  * macro initializes struct drm_plane_funcs to use the rsp helper functions.
  */
 #define DRM_GEM_SHADOW_PLANE_FUNCS \
-	.reset = drm_gem_reset_shadow_plane, \
+	.atomic_create_state = drm_gem_create_shadow_plane_state, \
 	.atomic_duplicate_state = drm_gem_duplicate_shadow_plane_state, \
 	.atomic_destroy_state = drm_gem_destroy_shadow_plane_state
 
 int drm_gem_begin_shadow_fb_access(struct drm_plane *plane, struct drm_plane_state *plane_state);
 void drm_gem_end_shadow_fb_access(struct drm_plane *plane, struct drm_plane_state *plane_state);

-- 
2.55.0

