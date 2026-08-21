Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42E8C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB0710F2DE;
	Fri, 21 Aug 2026 14:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WsQ3gLEZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D8D10F13E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AED76187A;
 Fri, 21 Aug 2026 14:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4F01F000E9;
 Fri, 21 Aug 2026 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323242;
 bh=s6gprrgeHxv5WYf7Q409m/tC4l9erXZiKKMa9aFS4MY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WsQ3gLEZzFEadLSkFPsXkwdeQpF9SP7kOdxbYtP3H7hNDgNlgkFfKxj3d3i+Oikl+
 AXGbadcrw1JXn56+xtj9754UEFtB2g1L9fss5kufQGhvL8SsZ3qcRM4b3li61z2fHr
 5c/6tWzLeqnGMqTOKHywIgj+LCURl7J4qGG2m2N227d4Yh9cwLfwYC7fa8I9r8JlDB
 Y7CksP04UkH2a+U2vwJYzPWSoTPU2/XG2BJ0wvTXC7CUjjA9u2zXbIOkgCluuYzea0
 wyH1zOM6YuJmd2eqfXM3P0t0aSFLGZhtA+yGpIS4gwzdtlWXzqhZm4lTYczvj0YelN
 tQLerN5Ao25Jw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:09 +0200
Subject: [PATCH 33/70] drm/tiny: cirrus: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-33-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Lq3nj6xay6Mqg6NTUKSgPhoi9gnhcfzvOTjDBRIWURI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyey6Ofkbv/P07V7ss+CXy22nhpKGO/vmBt67zaM72
 erQBcspHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiuq2M9fkbpcsm3Xgqe49J
 e9ncZWpaR1Zy6F9Re/Xaa+97UZlf92pVbkR1LX9659KHWVHTxIxTihjrU4x3pU5a+W9j8qobLx5
 U7N7NHX+u8tykKbOjn0Tddmwx8vv1XWV7czODm6V9cpNQ0up+AA==
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

The cirrus crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 075221b431d3..73516f631e0b 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -417,11 +417,11 @@ static const struct drm_crtc_helper_funcs cirrus_crtc_helper_funcs = {
 	.atomic_enable = cirrus_crtc_helper_atomic_enable,
 	.atomic_disable = drm_crtc_vblank_atomic_disable,
 };
 
 static const struct drm_crtc_funcs cirrus_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

