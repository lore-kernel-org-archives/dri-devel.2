Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A1EC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF6010E309;
	Fri, 21 Aug 2026 14:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H2T/v8Tc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF09B10EEA5;
 Fri, 21 Aug 2026 14:39:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CEA4561879;
 Fri, 21 Aug 2026 14:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC121F000E9;
 Fri, 21 Aug 2026 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323167;
 bh=uw+0IVjuQynISkfWjN7hE6V3/uqhz7cHyZjaTSueydg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=H2T/v8TclcsxKbK13hVDT7KwaDpJkvjCKE+9Wm3QCsScLvJ+VJaw6V2bmBh1RGQp2
 auAy3oSy52DfQ1L85doXT2IW2BNX59PKYR8tD1UPRpdlYGvmbb6RpV10a3jxHWrJ8b
 k+Q7JDiPafABDK8XOb8UZ3rmrco3Kpah/9gHblO9VJGmFNltaIruiwjb1MIBVKDnuY
 qVp+/Fg+PGsCIjfQBNqKARAluicn+EJ0eh1i0PZ6g1eZn1KvRLx01BqTtLiWBtokjq
 TO9OvDQQGL/mX2PpKAeLtiHsJyNw0IWHRR3dfu1rdd5FT4Bzo6cR62hUte1wTEl0ES
 iDczxFjQkkV6A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:38 +0200
Subject: [PATCH 02/70] drm/amdgpu: vkms: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-2-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=mripard@kernel.org;
 h=from:subject:message-id; bh=//k8pWgnPqNYUXXjNMHxr4MP+4xmQeTdGGNv6ayWTic=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdST9EJadPl3z/KmKz+NS/xV/yslqiGCps6+fXGLO5X
 Jrb0HC5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkgjBjw5q3zU8/2fvf7L+9
 scHZ92DuhucROh3xR5QcjcNcvfKm/d984vo+yS0dy+buvsvHzv5+L2PD3wL/NYs1bune8jgqsnL
 ap4sbZu3uZi5Y1KXUuz+zMPPHJM6SnRu++R15Jnv0Qkh4udoRAA==
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

The amdgpu vkms crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 170adaf7e76a..6c37ba7e5259 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -45,11 +45,11 @@ static const u32 amdgpu_vkms_formats[] = {
 
 static const struct drm_crtc_funcs amdgpu_vkms_crtc_funcs = {
 	.set_config             = drm_atomic_helper_set_config,
 	.destroy                = drm_crtc_cleanup,
 	.page_flip              = drm_atomic_helper_page_flip,
-	.reset                  = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
 	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 

-- 
2.55.0

