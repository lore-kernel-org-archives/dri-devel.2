Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FF0CC6B2F
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326C710FEC5;
	Wed, 14 Oct 2026 17:29:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5D210FECC
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15FE94398C;
 Wed, 14 Oct 2026 17:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7504A1F000C5;
 Wed, 14 Oct 2026 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998934;
 bh=tCV19d4zAY6lsUjiQNpICn9XcY+9ywiaZ95chPpA/yw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ocbtjVyPNgBKEMfD11Ft097Dyi0lTagrlqs92yGEEEur+TowJ2N1+KhK/2lpbgo3N
 UdnQ3q8LvRmbhYHEsU/8lH7EXvcxxuwHGXDxcRZUevfyPQOssVU8GaZELAi5HGmadh
 pA57bsvXxK2MQ+LD07NPV/u6r/k8Ds+Rju0j2LmeXhis7+k649z6pDjlY0mayDMXCR
 660PD5cYE5M6+d40z2TKyE+kGa2wfTB+TZFQ0yO9YRGURa9ZfMtTCK5LA2f0ngt+Hn
 SSbQcIBOTYj6Y7AMGTDS6di01WoLvgbYcsZ3JEQyGK2Bd5WMTWoD7SmddD7kOP5pnM
 COYDWgPE8lh8w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:51 +0200
Subject: [PATCH 28/75] drm/mgag200: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-28-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7i7stdL/3DvtYfQ+04qWLbT9xd7MHyX2KzBYGKRs6u4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4cJiO6ccfbRj2xLyW0lJ+t0X74u5pP+GGWWH7gk7
 fOhKM8zHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiqpmMDXtuvhRxsP/1zeaK
 yJ7cvzsClgo3dO5VkWkUuc6cl1L2IuSD97bpKq8mcR5NybAWipnfwFgr9ZHvnd3O2S/889Nq7v3
 p06zmvfOyfXlSiPaH6RWPjvHLhE7W2bRBRnrZI8azCjG2wXsB
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

The mgag200 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_vga.c     | 2 +-
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_vga.c b/drivers/gpu/drm/mgag200/mgag200_vga.c
index b07c1362ddd4..a949c6543c2e 100644
--- a/drivers/gpu/drm/mgag200/mgag200_vga.c
+++ b/drivers/gpu/drm/mgag200/mgag200_vga.c
@@ -16,11 +16,11 @@ static const struct drm_connector_helper_funcs mgag200_vga_connector_helper_func
 	.get_modes = drm_connector_helper_get_modes,
 	.detect_ctx = drm_connector_helper_detect_from_ddc
 };
 
 static const struct drm_connector_funcs mgag200_vga_connector_funcs = {
-	.reset                  = drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.fill_modes             = drm_helper_probe_single_connector_modes,
 	.destroy                = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c b/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
index 805636990b55..1c118dad6d81 100644
--- a/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
+++ b/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
@@ -98,11 +98,11 @@ static const struct drm_connector_helper_funcs mgag200_vga_connector_helper_func
 	.get_modes = mgag200_vga_bmc_connector_helper_get_modes,
 	.detect_ctx = mgag200_vga_bmc_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs mgag200_vga_connector_funcs = {
-	.reset                  = drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.fill_modes             = drm_helper_probe_single_connector_modes,
 	.destroy                = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state
 };

-- 
2.55.0

