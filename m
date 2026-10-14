Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53EDCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBF510FECC;
	Wed, 14 Oct 2026 17:30:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3761110FF02
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19DB840B08;
 Wed, 14 Oct 2026 17:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7731F000C4;
 Wed, 14 Oct 2026 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999007;
 bh=Lr/XXJQqNzEaDmrzSymo5WCdyffBBI6acLI4Obl0TtM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WU6nO/QkE2ljjawlqTh45zT46cNdbfMNSjAt4UEdbuvj3+zuQ2XKh926gk1ZAha+4
 TpXgdgXJ2xRInBlZzKBP2FBIYflRItDSPqWFDTVa4/YeVv6INLNHwF0AVhnF/E4I0v
 JcXVDqf1T1vcNm+NDYFSqb8jcB4fx2DZWburTXy38MAoEgveijQlEpl1hMq+xvJb2a
 6l4gYCulnEekE4bygEWhVIRSn+4jsVDQFENWXrim9K1Lm6yAH1vE2FHOueTyb3NVdx
 1Ov6KQe52SkHIqBmI6Ae/C0Q5Tn8dLwW4PJySP7B9Vh25ShhZ6i16Gts34y2LShpP3
 i1vR+GquKQvhA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:11 +0200
Subject: [PATCH 48/75] drm/tiny: sharp: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-48-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Xtjl2k8Q3udev8Hb5rZNCWrJ/SB1gU4IZb3Vqu0uSWk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8fPChc9WL9XW/tYmPicQ5XMbFdnC7ybJvxrzW8x/
 ehP17vvdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ8Dkz1orHuHv7c6z8+vT3
 7v/t2m+4ki3YZV9P4Y687WS8/VSqUsbyTU+jrUP2v0rL//It7LL3RcaGHkPN+U/PRh7tMJ6z1Di
 ORULk4/aQK9fWfPo60cq35lF0sEPV2+joJPMLPN2PuzQEnNQB
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

The tiny: sharp connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 434e73bd25a5..29c63eb9f945 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -367,11 +367,11 @@ static int sharp_memory_connector_get_modes(struct drm_connector *connector)
 static const struct drm_connector_helper_funcs sharp_memory_connector_hfuncs = {
 	.get_modes = sharp_memory_connector_get_modes,
 };
 
 static const struct drm_connector_funcs sharp_memory_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 

-- 
2.55.0

