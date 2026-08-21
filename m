Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C73C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009E010F15D;
	Fri, 21 Aug 2026 14:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bgG1zhx0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A413610F13E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 24F7B61834;
 Fri, 21 Aug 2026 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB21F00A3A;
 Fri, 21 Aug 2026 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323222;
 bh=PPallGEl5qAVgE89jFGpICrjlCtbggTckpYUozhDJ9g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bgG1zhx0L6nIRq4dM8PnRrOnpWSnataDomDlzvip1MfPcDrIcJ9uMDTgNB5Z20LI1
 XjcklH6ouojXMSdAVya/T9l/w5gLnSvkiERQJtXcG2ZegQaQywCJbtQTbEpAAxNYHj
 Y6MsJ/R12icd3mN9lSfqA0RXVazSBJMt39oogZcrHh2nv3LmPM/kktRk88BsqDLmHT
 EipbrG/77hBeQl3EK+dqKdG8uxAM96T7lsyMm2XcNIBB+Ak/ZOSx/XlNBpo4YILSbV
 CUovWneBbKJryIuSjD2wITgTbNexj7rr/hiP9BKbY3/J1VIgASZXYT0FXHDFcJbelH
 PNOfCuloUPCKw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:01 +0200
Subject: [PATCH 25/70] drm/sti: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-25-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=mripard@kernel.org;
 h=from:subject:message-id; bh=woxaRtsHLlT0RNtUUPqD6Z6/+jQC4lARjr3ZzGRvjYI=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGqIYwOj04S5JXLBNFdLRDkT+2YqQ5FAUnnHv1LLaCu/g1Y8m
 4iVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmqIYwMACgkQJ1/OGaI9vnZ+eQGA2RV6
 37cT/y2cXsETPVKV0VtZ4IJ9sIkY71eO1WYT6ZyV3HNcx8Z0GPTwVbYH5ajrAX9zDtWuQMeIPRa
 fBDm1rD7DMO/i867H+om3wjkptgNYUV/XZOFrQ8BUOaCYgfu6TsI=
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

The sti crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/gpu/drm/sti/sti_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
index f0e98653d35a..c69612728f2b 100644
--- a/drivers/gpu/drm/sti/sti_crtc.c
+++ b/drivers/gpu/drm/sti/sti_crtc.c
@@ -326,11 +326,11 @@ static int sti_crtc_late_register(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs sti_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.destroy = sti_crtc_destroy,
 	.set_property = sti_crtc_set_property,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.late_register = sti_crtc_late_register,
 	.enable_vblank = sti_crtc_enable_vblank,
 	.disable_vblank = sti_crtc_disable_vblank,

-- 
2.55.0

