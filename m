Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAEBC5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEC310E306;
	Fri, 21 Aug 2026 14:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TuCrz32w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009E510E306
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7677161126;
 Fri, 21 Aug 2026 14:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32B21F00A3A;
 Fri, 21 Aug 2026 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323177;
 bh=Appbx40xVgM2xIoRawmq2rnatISkS3RhPlkctJoxsW8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TuCrz32wANstlWfESRxXJMolhJmyzWvWofnErXEbUbcY8CaRac4H7BD7p10JbQmW+
 pNb5t07JyhQ8R8hEw3saugnS029k4F2oHKNElYj7mXKKiFVhZgdnljTO09MnuCk++A
 clPi+oajMG2ZCaoqRhor9Q7MVZkYDyFwywM2Xtbvx2YmXqHEM+zf0hmFyNs9iio3cw
 d4zS3AyLPzwOW/HcF/L3wjZVJeLSHEAzpbFqyrljcsHtw6+0hrqVrQmnLHc15IiRKa
 aK46Hob11wc8SZ6O9kFv15Gy2U08IHBaXaMnSCClPKJGYTkQri0jDZlwKrW7bLqOeM
 AwcRQF63w3F+w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:42 +0200
Subject: [PATCH 06/70] drm/fsl-dcu: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-6-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=mripard@kernel.org;
 h=from:subject:message-id; bh=c0kDWIEJrq2AQ7ptJ36wmZAgYjISeXGl/eOq1WdFQzw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSb/S+E/5fTDb9nyPePleLYm/31YxxXybcnix3KVZ3
 0vcXpnN7ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATqb3FWGdW+qfIui8ypk6P
 96e1mn7xjQeiL3xr+JfdnGrQuO/D+4+qk5I0XuuKThB5zrT4qfhLHsaG+4+WHTOemC836VXZ1Kx
 SXye7ByER8rN86ucpX3b6NGPObv6zNw32ffdRuG7Bpa/ALcAJAA==
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

The fsl-dcu crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alison Wang <alison.wang@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 9ef16f5eb613..73c0675e6c54 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -159,11 +159,11 @@ static void fsl_dcu_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs fsl_dcu_drm_crtc_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.destroy = drm_crtc_cleanup,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.set_config = drm_atomic_helper_set_config,
 	.enable_vblank = fsl_dcu_drm_crtc_enable_vblank,
 	.disable_vblank = fsl_dcu_drm_crtc_disable_vblank,
 };
 

-- 
2.55.0

