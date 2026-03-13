Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1283105F787
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E7D10E0E9;
	Fri, 13 Mar 2026 09:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a/UtCAsU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAC610EB88
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 09:57:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B28BE429C1;
 Fri, 13 Mar 2026 09:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F0C2BC86;
 Fri, 13 Mar 2026 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773395827;
 bh=oRkOP7dzdb8gYLs9PmrI7X6Kwn8xFQTWyx/CBJ+1Mts=;
 h=From:To:Cc:Subject:Date:From;
 b=a/UtCAsUe9b430je15Jr+au3UEJ72Cop5WiAiZio+MqqfAqVeq3R4RVCsY7I9H+B8
 eG8lTi5vtAwOFG8JbYKoyl1YvJEaxg2nQrHwIA+EjVU/UnRLqxs7tSnL84WbNnETv3
 dj/oFxzaUOJP0/BiK/W+IgT8Z8+7DpnOvnYfIEOXz7687FfIIRHrgcjNB6LL4rWXYL
 Ksl7hHCAmIjUg3wDhoyy1oPTpwbs+x0WLxvULKZUISYxEvs8f+7arJgQUp328wAKS9
 WTOapWD8tnWT2Nb25UrVTsvYk79AaAVKovApkOR68bgSc0xJr249t7nLXefm1DX2cB
 JYM53cK3CLoQg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [linux-next mismerge] drm/fbdev-emulation: restore
 drm_fb_helper_gem_is_fb() dummy
Date: Fri, 13 Mar 2026 10:56:33 +0100
Message-Id: <20260313095657.4115599-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

linux-next contains an incorrect merge of the drm tree and the amdgpu tree,
which have conflicting patches from Thomas Zimmermann:

drivers/gpu/drm/amd/amdgpu/amdgpu_display.c: In function 'amdgpu_display_suspend_helper':
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:1777:22: error: implicit declaration of function 'drm_fb_helper_gem_is_fb'; did you mean 'drm_fb_helper_from_client'? [-Wimplicit-function-declaration]
 1777 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {

drivers/gpu/drm/radeon/radeon_device.c: In function 'radeon_suspend_kms':
drivers/gpu/drm/radeon/radeon_device.c:1592:22: error: implicit declaration of function 'drm_fb_helper_gem_is_fb'; did you mean 'drm_fb_helper_from_client'? [-Wimplicit-function-declaration]
 1592 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
      |                      drm_fb_helper_from_client

The newly added drm_fb_helper_from_client() stub is in fact needed, while all
the other stubs are correctly removed.

Fixes: 6d438685340d ("drm/fbdev-emulation: Remove empty placeholders")
Fixes: 1837c76b780a ("drm/amdgpu: Move test for fbdev GEM object into generic helper")
Fixes: 9c63d743d5cc ("Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux.git")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/drm/drm_fb_helper.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index bf391903443d..80c81fdb04a2 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -273,6 +273,14 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
 bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
 			     const struct drm_gem_object *obj);
+#else
+static inline bool
+drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+			const struct drm_gem_object *obj)
+{
+	return false;
+}
+
 #endif
 
 #endif
-- 
2.39.5

