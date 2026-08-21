Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD019C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F73610F2E6;
	Fri, 21 Aug 2026 14:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Muc4PNsQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05D610F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3148061834;
 Fri, 21 Aug 2026 14:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623C91F00A3A;
 Fri, 21 Aug 2026 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323246;
 bh=ZRGw/b7Y5C3If8EoCt23XhKsqPM3+dkq4s4CH+CbAJo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Muc4PNsQijpHtZZ86NuyPQgipx8vSjPki3ZtMVBOPO+H1EtV1+Vig55En9CCbWujb
 vT1FKx9M8ZTqghZpDbeCZqYWaocbiUMOoToqrDJiWiNg4Akc90it3y/CpSoPXF4ltG
 bZ43keLdlMTld0Ib6w5NYcsuq4mpwP+JH64Zb27AhnjYS6/Cet/qlROJK/vTK1kzyw
 380qr4bdjEwzQNufmsY7ul2eXEsTTQZyEnw1WCbPJ37xEffi+eQyX6G2UDKH3dVzs7
 k5Z9lYm+IcqHoQnB0JltoAZNwKEbbH0hKwbajOh3FkROIxDoTp3XHdGnCdOVmL+pF3
 FFNJwAvMJFFfA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:11 +0200
Subject: [PATCH 35/70] drm/tiny: sharp: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-35-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FK1c/WP1PCzjT9qUdvXepjmBpKLneheHpCzu5BqG+gY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyexzXD7XTl7oK/D4XsW2dUoJC1Zt/Pf9ZgBvhcE9v
 +SERa+tO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBESi4yNtzUWsZs9E3q1Lrc
 wIOfZOYFFKl7XTrTPPW1dUDJNcUn2cv35yionWPdk9/WwbXzRnP2Ccb6fC/zPcvUf51PKT628tb
 MlODdkgY3G6tms/0Il9vTu/xvxBO9Iz63dTj/B3pUX7pxzmoqAA==
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

The sharp crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 7efd7b567f3b..434e73bd25a5 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -343,11 +343,11 @@ static const struct drm_crtc_helper_funcs sharp_memory_crtc_helper_funcs = {
 	.atomic_enable = sharp_memory_crtc_enable,
 	.atomic_disable = sharp_memory_crtc_disable,
 };
 
 static const struct drm_crtc_funcs sharp_memory_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

