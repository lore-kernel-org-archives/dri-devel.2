Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A338BC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC3F10F99B;
	Fri,  4 Sep 2026 09:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DVj4jDXr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDB910F9A4
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:07:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBC7543B96;
 Fri,  4 Sep 2026 09:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0B31F00A3E;
 Fri,  4 Sep 2026 09:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512863;
 bh=wwkpWvZ5g1Ce8HhDDAG493tVxULrcqtw7MLNe2t684g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DVj4jDXrQrZ6FWceNowcoK8ziMEQBXsDuE4wuU5KSneXFyiD/FLuaEf8MGRjy7js7
 tOb0yOYEfVyylQ8IHsAmyE0uqNAkVPjl8u3j62s/0oUICPanzOg/z1pFL1SNMXtMiZ
 /QGrksoWWMc2TMWqiPcmWpMemYrfmLfoGM6A7H5cc+CDkZ0BB+/sdsAsV61maqJobg
 pE6ZeRCeL84fKWGgz9pNWJZlSTr7YFIxGHtmg6SON24NsFXbzL0FFJr5IX0vAaGIlw
 +IRuYiNoFG8rNNDNMVy6T3PUA4osj8DgHxXxbfmk8wEq/rhYfFXSO0Km3KHVvjzSJF
 2Jy+tt3ZtbSYw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:21 +0200
Subject: [PATCH v3 03/13] drm/logicvc: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-3-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Paul Kocialkowski <paulk@sys-base.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vMk01+zslvO3Gcv8WfZ07UXA+kf3dYsPr4ikdvU8c+I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzunzaGWrrtSvunfmz22vBiztr/aYwTJRljreMveaWF
 VffHHurYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExE2Zux4XjuqSLDc4vDv06c
 3/FefAH37+k1wvNC56x1TDnjrsn/69OOjvuzzt87GnFQ+uznsFk3XzI2rHAVLlPe9GfV3nrTp3P
 rTq4ps5NyZt3gKCM8Ndb90ZYuVTv+s/1cG5IUQnq9F/xQcl8OAA==
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

The logicvc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/gpu/drm/logicvc/logicvc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/logicvc/logicvc_crtc.c
index 81e5b80736fa..af92a573c3f2 100644
--- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
+++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
@@ -211,14 +211,14 @@ static void logicvc_crtc_disable_vblank(struct drm_crtc *drm_crtc)
 	regmap_write_bits(logicvc->regmap, LOGICVC_INT_MASK_REG,
 			  LOGICVC_INT_MASK_V_SYNC, LOGICVC_INT_MASK_V_SYNC);
 }
 
 static const struct drm_crtc_funcs logicvc_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank		= logicvc_crtc_enable_vblank,
 	.disable_vblank		= logicvc_crtc_disable_vblank,
 };

-- 
2.55.0

