Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E81AC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931B010F2E3;
	Fri, 21 Aug 2026 14:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NBB5wB0q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C6510E1FA
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 514E741536;
 Fri, 21 Aug 2026 14:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF72C1F00A3A;
 Fri, 21 Aug 2026 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323261;
 bh=YStdIeBA8bI7tPeJDx8zvmyWEtPTzGWKMEQj/a3Y+fk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NBB5wB0qhNpM/Pdmx6AIF8WMCm+HpRHFRSASa+7/FxJEUOxRfWtnB048939f+GfPS
 cGueNCGqVKIQhpOlQaXyjwZceLj63LmE24Cd8NqMV+mctT6Vvv8H21mgW4l4dltP6B
 UctTFwsgbsLl0Rjk7mVCn98U8C84nrRNoq28BpjpanBbaL5ENFcPCUiTz0R5E0x3J0
 TP+KcsQngOBkxl+WH9pxkVUSz2D3Xugi/VpeP4bSZhxsXRVo1pLh0urTiN1KYzKM9Z
 DbFXKpUVCmvgnjtDFwbIXwI4vhDV57339pGKO1SYa+adAtmVnoKu5wCbXnZ556ZoSz
 qpkYkzmKbRqrg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:17 +0200
Subject: [PATCH 41/70] drm/mipi-dbi: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-41-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dvHgjqYzt6Ga4mXtuVAGlvBJKEfcwTjAHyvSRoZK0UU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyVyzrgsx1Bw0XqTktNlQ4MWN/vtrXY/askiu0ZaT3
 7FYTUKsYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEwJ6xPib84q0nF3bkPBAK
 jTo1J932wtn5l5du5KqN2G6zzdFXYIrrOt1pJz1u3Kow+lmhsnNqH2PDlDud+fPMBcwZ+W9+vFO
 2vcEqRHWNwfq5nWL/ZM74HH7B5Zi3besCtmVG9iuOeQVeXzEBAA==
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

The mipi-dbi crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_mipi_dbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index 78ab23d844ce..d93e25fdc2e1 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -232,11 +232,11 @@ void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
 /*
  * CRTC
  */
 
 #define DRM_MIPI_DBI_CRTC_FUNCS \
-	.reset = drm_atomic_helper_crtc_reset, \
+	.atomic_create_state = drm_atomic_helper_crtc_create_state, \
 	.set_config = drm_atomic_helper_set_config, \
 	.page_flip = drm_atomic_helper_page_flip, \
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state, \
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state
 

-- 
2.55.0

