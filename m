Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939D0C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F2C10E0A7;
	Wed, 26 Aug 2026 10:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KOuIqSs6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7F010E040;
 Wed, 26 Aug 2026 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=ELS7Xk/G7rbUZJ/ezYATvF3a7mjrn7Xq9dhkxPrHZgg=; b=
 KOuIqSs6UMZ3t5r/C18W1hWJWttbOA8rC8s4h9CjQsjcix+SYvDsbgXvQUaj1XNQq6e5pOMRk/UYq
 M0GgJC5cGHT8KeSQpzmk3DftbpEapNAfWSZiGoFCLw3CCInBLvUp2YEb3CYPRO5SQAPbuQBmDxcWx
 ivmlnZgxt6yQqsPDuoodKfPZEXppgD68tgCkAxs8WJ9hX1et0x9EgkE/pdn1yCPjUX2QlDPoJ54Hn
 vkQA/uxldq2teKeASf2TFLHlkr6W/FUQhi+wHsK9MH6+q1cqOp495o8yRb946BPBdCrioVh6kuHji
 5M58UH5ld3MXq+ZS8N+Esukge6PQ39tPTw==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wzB4l-009Uut-I8; Wed, 26 Aug 2026 12:41:47 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 =?UTF-8?q?Viktor=20J=C3=A4gersk=C3=BCpper?= <viktor_jaegerskuepper@freenet.de>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 1/3] drm/atomic-state-helper: set pixel_blend_mode to prop
 default on reset
Date: Wed, 26 Aug 2026 12:37:05 +0200
Message-ID: <20260826104143.39077-2-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826104143.39077-1-mwen@igalia.com>
References: <20260826104143.39077-1-mwen@igalia.com>
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

In __drm_atomic_helper_plane_state_init(), pixel_blend_mode is always
reset to DRM_MODE_BLEND_PREMULTI. That was consistent while
drm_plane_create_blend_mode_property() required PREMULTI in the
supported modes, but it now falls back to COVERAGE or PIXEL_NONE when
the driver doesn't support PREMULTI. The hardcoded default may therefore
not be a blend mode the hardware can do, nor one the property
advertises.

Initialize pixel_blend_mode from the blend mode property default
instead, keeping DRM_MODE_BLEND_PREMULTI for planes without the
property.

Fixes: 9813e158d13d ("drm/drm_blend: allow blend mode property without PREMULTI")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index d90d1d7c9cf9..a2ef272e9f27 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -278,7 +278,14 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *plane_state,
 	plane_state->rotation = DRM_MODE_ROTATE_0;
 
 	plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE;
+
 	plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
+	if (plane->blend_mode_property) {
+		if (!drm_object_property_get_default_value(&plane->base,
+							   plane->blend_mode_property,
+							   &val))
+			plane_state->pixel_blend_mode = val;
+	}
 
 	if (plane->color_encoding_property) {
 		if (!drm_object_property_get_default_value(&plane->base,
-- 
2.53.0

