Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861CEC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E1610F99F;
	Fri,  4 Sep 2026 09:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kprLSflV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C9810F99F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:07:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6216343C8C;
 Fri,  4 Sep 2026 09:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45501F00A3E;
 Fri,  4 Sep 2026 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512871;
 bh=neZm+NWtZCOfwuw5eRWfPnd4ZkDtMvem/wAv00azdQY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kprLSflVkAh11DuqO02m5LjffLSucXIwDEBqLfFHxc74cdlUTqvSwR+Fb17r8YEwN
 6D4TGODe3t764CszJjR8eVrz/OkJjTYc6+2M+x28zqRSv0UwVtUYRmQlQr9Av1hc+E
 Bf6N0RRTBspKwwdGKSxpoll4Vcx7T+0YhkutSqvQku2XaRu8Cr5qQ4nMTh4labDwRe
 fzcmnvLGbassCSAfd/NZWwr1q/ATAsDy0GbIpU0+HZFrpkI26YRMTjpWQOlobVUUgG
 qw1jBWC7bbFE9STLI9aXHHmKUIt68ubBuwKeMm7e/D3ZUaXBMs08xliREQ7bdNCGHP
 A5JOBNTxdWk8A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:23 +0200
Subject: [PATCH v3 05/13] drm/tilcdc: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-5-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dagBGMFWByWpy+3AXs/qc6yB0OlkOY1S0mQ5SNOQ8lA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzunyVBQSZ/Vyfxi97L6Y9fXr9r6YV05pVvpovE+10n
 Zbec4OnYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkmQRjw6o+x7qzz+OzZkov
 r5yhdvj92lOq9SavQmqWelxbmpGd/LhgyvWkm38iGzqWq65uTrfPZmzofpey6NqiV/unueyeOeF
 dtTz32uaWl8pfvmTGO8RKP+/JPXJm3fqYilfzTdboPFyianAOAA==
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

The tilcdc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index b299d73ce385..f619b7a6e70d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -712,11 +712,11 @@ static void tilcdc_crtc_hw_reset(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_funcs tilcdc_crtc_funcs = {
 	.set_config     = drm_atomic_helper_set_config,
 	.page_flip      = drm_atomic_helper_page_flip,
-	.reset		= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank	= tilcdc_crtc_enable_vblank,
 	.disable_vblank	= tilcdc_crtc_disable_vblank,
 };

-- 
2.55.0

