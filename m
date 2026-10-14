Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D45C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8470910FECD;
	Wed, 14 Oct 2026 17:29:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57C410FED1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE090416C4;
 Wed, 14 Oct 2026 17:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834D1F000C4;
 Wed, 14 Oct 2026 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998955;
 bh=Vo8aKdyvupS+mWAne9rqZT88TCOlZKm5zaj/TlP04i0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lPhD2Xkc3uhBQCwCN9KFj38jdkR49eIf1BBYpVrwiJ34nfWnvEGFF4CH65sR9MZOl
 nFz9WbG1AatGkG+YlbA8E4JcoiUnbvf/M87nkeM7WZwJW0niYTFZQDzL9E628Ba3QS
 46/2DffIMSOrYUAAhleDHLwVj7+l0TwwuyYnln172+XRnFVSLfS4hQ1fePF6aB/uBi
 nT+Spl27AmTIibL2HMphOHXHj4oThM04ltgcVa9KZ8pzKOOFnrgGAVwt5/gV722iYs
 xbJBHcc/XrQoLPvryyZSyho+zXTNUVIuhPqQ8x3HwwN9sJT8J+9k1IzEtKNSxx6+Oj
 j6eubHL2qulWg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:57 +0200
Subject: [PATCH 34/75] drm/sitronix: st7920: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-34-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Xh9t+hJHYO9t30X4j9Ae47xG0R/9vMl2cPEGNowwZaA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0fy9y6+HKO1tN26+MalvRUxkhzFLUpi25ZLVRvme
 rzaNqW+YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkdDtjfe0WIZuzqck2t2cp
 1Vy6mTRN7Uv4ec4jPTXc0i36nWXv/u//7zh7arJ/71fxeA7Ga1cOMNbnRR6ya3oXNt/igu3qpvx
 7nw2N/nryPF3m3+v6he0QV7rti/hl9m9DV/a21BvkyGs8KAMA
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

The sitronix: st7920 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 9887ed746ceb..0b838ddd13fe 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -651,11 +651,11 @@ static int st7920_connector_get_modes(struct drm_connector *connector)
 static const struct drm_connector_helper_funcs st7920_connector_helper_funcs = {
 	.get_modes = st7920_connector_get_modes,
 };
 
 static const struct drm_connector_funcs st7920_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

