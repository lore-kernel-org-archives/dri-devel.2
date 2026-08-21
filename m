Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4694C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FF310F2D1;
	Fri, 21 Aug 2026 14:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M8OhJnYq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E3910E1FA
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20F446136F;
 Fri, 21 Aug 2026 14:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528FF1F00A3A;
 Fri, 21 Aug 2026 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323258;
 bh=q7ds/yJSd0z8bmluw43RvI3NWKVxWNN7hkuvJRoB8Nc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=M8OhJnYqDy03aiN1A+XOACSoLspJc6HZ2qt98jpRLP2WwFdi/p+UGOI4LQ4KLY8lh
 qP/6QoQUKAYe7G5tmPVR3/cyUbls5fwFImgLqzi0kC4uJK6lE8q0CyzohOwju4CT3a
 Q8n8R+74TE442xBqUu/xOP5IrY4vSrEGh87FJyRWDawVtjLAqqY6LkW24p+jCLF3V8
 WKKwViPy9pZSFqWgprhrsTG3bE7YGh83tRSFWijIrELWDY61o/Zq7RQCmUFpjjDk/9
 JsnhoewtB4oQAdecbdxmFI0ml6yXm8Uqc6k47I6JCnIc6o2yx5Vji6pDQE2mr8nJDT
 X5hUqTml5IqLw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:16 +0200
Subject: [PATCH 40/70] drm/xlnx: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-40-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UdaQjY8k8kMzzha+H+QRpw5yGvWZYc1gWbv3hlooQWg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyVz1jCfeLHnpN937xvyT6zT+r+FXW/TNZJ6TyYMFb
 E6C0szpHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAih6cyNiye7JdVKxGuW1th
 tYk9YmP8599fr7S+LOt9ckg3OetA5s5DT8VqNhyamhO9xMCB+/rmKMZ6l1dHlrMoJEeoVKl6rOx
 uWJIzj+Hx95CgirWvNj9krvY3mniGzys1b/3Z4Nay6aW9B8MB
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

The xlnx crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index d5f922450565..966a9243f1c7 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -306,11 +306,11 @@ static void zynqmp_dpsub_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs zynqmp_dpsub_crtc_funcs = {
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank		= zynqmp_dpsub_crtc_enable_vblank,
 	.disable_vblank		= zynqmp_dpsub_crtc_disable_vblank,
 };

-- 
2.55.0

