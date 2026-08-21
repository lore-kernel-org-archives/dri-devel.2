Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8E3C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A1310E1FA;
	Fri, 21 Aug 2026 14:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hUBl9fTj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86D210F2E3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CE96406D1;
 Fri, 21 Aug 2026 14:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFB81F000E9;
 Fri, 21 Aug 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323256;
 bh=rcQR/P7J9ROu3FgfslSQMzpe0RyerJnArHhtAL9GON0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hUBl9fTj+CAg6NzatBR6CFP4YyQ30XFcy9ifAyprAXZAgr5LrwkJ7bkQ99OcAzCnC
 LVEJ+a2ryqzfYC1WosxR9E/HzhNMHSUyqk6P6hKtC1vAoG3DtUDciiLKMdFjsYdWdd
 1Fu1PxtGuGoaOvDtUcdpei86YwK67JdxtlTwoYjZFEz7CT/d6DrLGUfKl18s2+hSXL
 l0P2TqHZ2X11kAStGh3CqL+m1F3CsNspx4zZ2n/1y+20Fw5ldOuTlh/Rdsl+kFIKjj
 5H5Zr+21ineqj+2vWi1hCMvYD2ykONHzGhwPiVGwLKKPeH1TtAV3tH1DRWHWOfJWO7
 Ga2kohh9iLLHg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:15 +0200
Subject: [PATCH 39/70] drm/virtio: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-39-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=mripard@kernel.org;
 h=from:subject:message-id; bh=f9XtDyuCF8q3dFTH/dUWkN+PU6BsrizgHtChfYfOCJI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyZzJzLYVxwS2MZkdPTTjKu+VuuOLCrPsftn/mPpkV
 5cIl8W8jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRY9aMtaISz9huyxY99vuX
 fbKw+nRq142dqZLyB81dBESTXecXvuaUW3BT1DGn+f29HXFqT4R5GOu0DvqrvvkuFnB627v30nP
 Ytf5UJLD3hgQ+YttiY7mfR+dj9aX3YbqyB3N773WsspkQ6Q0A
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

The virtio crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..c0b71fdae330 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -53,11 +53,11 @@
 static const struct drm_crtc_funcs virtio_gpu_crtc_funcs = {
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

