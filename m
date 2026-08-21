Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F1C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FB510E310;
	Fri, 21 Aug 2026 14:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PI5H9gCu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D4610EBF8
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35CFB61834;
 Fri, 21 Aug 2026 14:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672FA1F00A3D;
 Fri, 21 Aug 2026 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323169;
 bh=yEPrCq2RESGwk7TTMVfLtqCOi3LStUWMaAzU1HJ61VM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PI5H9gCu+9QyC1wPxRmSC7KihP79vyE1nDsLVrqFesJDTU9aMVAOVkt1y0LrWgoQH
 xAEC6eiOA4JDhlYKbPW3MY3nwTzc6Ie9JNe1VpO9+kVylJr1CcJ5P4wfvlteGpLpDD
 z9kRMbv5nU6u5sz4OLJVHcBM5bBrk26ywlHRt1acBAHt0DhL1HtzG2tKKEppjpeYdg
 Ryfdt1fUyfWDOlfzlsEB7ld9RuBHzuu/91mxGQ6nY9CSsanCtMEmIdtgNJE0cUMo8r
 dfgjUTVsHY5LBldKuoF+a6hHkkn/xM40ea6QP9jbOlUw/VbNTQ48Bzt05VvBeI38Qn
 QMIUVzu31wAyA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:39 +0200
Subject: [PATCH 03/70] drm/arm: hdlcd: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-3-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1Iay1CGVdX/VedYWtRgdUo66cgOZLYnJFeFCeA9q6fw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdST8Vpj+YYue1e13d/A65lUei1jdd3pT8gCH7eH4e0
 7n47mkzO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEYtQYG27umndl1YFDnm9/
 R38W1YkVdVryQ3vNDIO4KQ1Z3DFF1y4eZu1K32a/gnfi78K1VnVHJRgb7rCGMzIejX/fIyCYdv7
 ERA4mpU1zF11PlHFdcj7pmwQvf/1jPe79P6rzn3x4H5YSc+cWAA==
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

The hdlcd crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 8565749a3e48..e394464efbb4 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -65,11 +65,11 @@ static void hdlcd_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs hdlcd_crtc_funcs = {
 	.destroy = hdlcd_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank = hdlcd_crtc_enable_vblank,
 	.disable_vblank = hdlcd_crtc_disable_vblank,
 };

-- 
2.55.0

