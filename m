Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1E8CA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF1710E004;
	Wed,  7 Oct 2026 22:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="AeAj9Llj";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E0810E004
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 22:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791411775; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jvQFPzEiH3dqW0DGDSMLpVLaXoyJ4dv05KspH+dqEbEWsEsdXpWtZofhsUPZnwrBHzbBFWxK2R7Ji/vgtZw2RkUtHGY3vkhS2PW2J9QAZV0ja1f2YCy9Lno9hilLtmHdxQ85Tn+QTu89dU5sJq+fabcB6q28gt92yQr3squJvlA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791411775;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Z2nIKukZw95dcKC5lhzGGPxFQ69nGF5VaLvHA5MuW3Y=; 
 b=ir1zmXvhuaHtgU5IYRJBC4A5vKIT0BkoatnRQtbC4hmiBepa1SllR7Y9lwDk0Li9YJuPhcpoFz2fqFJloNLjd4jVBcc2wg0vYujKma4MAr8QlhREznQVnV6/m2aYmh5VbTh48DIKw623X0vguZf7QohkSAIeEgGQcfqPxxfds80=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791411775; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Z2nIKukZw95dcKC5lhzGGPxFQ69nGF5VaLvHA5MuW3Y=;
 b=AeAj9Llj1w0I1954263tBAGt8nXp/9qvJr99VrxkoFK/oTDhT+dEjDCTtBDvsvd0
 eYvOU3kn80IXxlyOHbCrqsm8UeuEzhGv2amIfVwi3oPAXSYJQiSxacJgGD48VlVGa93
 15TpyUGo0ophcNJh6vUUhxM609aEaPNjS2HTLa+k=
Received: by smtp.zohomail.com with SMTPS id 1791411773989975.026492163321;
 Wed, 7 Oct 2026 15:22:53 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1] Revert "drm/virtio: Add pixel blend mode property to
 cursor plane"
Date: Thu,  8 Oct 2026 01:22:44 +0300
Message-ID: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

The cursor blending mode was added twice because the same change was
applied by accident from different patches. Revert the second patch.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com/
Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor plane")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index b422eba42a5f..640815af4098 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -589,7 +589,6 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 	struct drm_plane *plane;
 	const uint32_t *formats;
 	int nformats;
-	int ret;
 
 	if (type == DRM_PLANE_TYPE_CURSOR) {
 		formats = virtio_gpu_cursor_formats;
@@ -615,17 +614,5 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 		drm_plane_create_blend_mode_property(plane,
 						     BIT(DRM_MODE_BLEND_PREMULTI));
 
-	if (type == DRM_PLANE_TYPE_CURSOR) {
-		/*
-		 * The cursor plane exposes a format with an alpha channel,
-		 * which requires a blend mode property. The host blends
-		 * premultiplied alpha, matching the property's default.
-		 */
-		ret = drm_plane_create_blend_mode_property(plane,
-							   BIT(DRM_MODE_BLEND_PREMULTI));
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
 	return plane;
 }
-- 
2.55.0

