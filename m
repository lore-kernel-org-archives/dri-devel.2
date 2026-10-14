Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EE0CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1D210FECA;
	Wed, 14 Oct 2026 17:29:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669FC10FECD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE6D16053E;
 Wed, 14 Oct 2026 17:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161391F000C5;
 Wed, 14 Oct 2026 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998937;
 bh=yl9yim04vVyiTXo+L7VQZ7u+fFPNoEcY8EPbGdbWhns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BeFUkcSYmUJz3OjLFgyf3Mr5wAVfp8HPqeISp2CspyUHqJVK9KMoaV5w3Guey+HtP
 aBJHlv5ijx11H4fta4tGDYkEoYBO6IhqrzvC24eh63hSaf+2jEu9KE1/mrxwPjM3uv
 BdHTDG2uNAaC3hBBg195gFIi4xrcuwlPLQybPlzc0OqFCAqYq5wQHnsL026rM9nCif
 EK5O1ufH5rO1jZ++HdA5GZxpkg+El725rnOaoN+1I05euwwsQmfomk1J4GJEdZstul
 ZtzUsJiee+frg4SFiybcmOtHS+j2AzNHGACnKq1EDv+RBJtwXUFa7S8B3HFI6yOTRp
 zI3SkUIXDMdPw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:52 +0200
Subject: [PATCH 29/75] drm/mipi-dbi: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-29-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QnAVx8ROc8Us+DNwtFFqjmDP1Ihu/LH0ALhH/phiGI0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4c/yTUV+vi/+23SFK7XMYvZAmRDGQ4+3HbV+/aEW
 tMDztW8HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAic0IY6yOe80uHLd6o0vGr
 6sqzu9f2y4S9rQvgURU3ec51sOzy77lNB9kuiE93ZsziN8zUidiUzFhfcq5qVbP3wUVWcxI1E8+
 efbBE7dqFmY/PHu2VLvndYh/5pEt0fe+yq4GyJ5yzzk2cxtoLAA==
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

The mipi-dbi connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_mipi_dbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index d93e25fdc2e1..d130d0600c73 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -255,11 +255,11 @@ void drm_mipi_dbi_crtc_helper_atomic_disable(struct drm_crtc *crtc,
 /*
  * Connector
  */
 
 #define DRM_MIPI_DBI_CONNECTOR_FUNCS \
-	.reset = drm_atomic_helper_connector_reset, \
+	.atomic_create_state = drm_atomic_helper_connector_create_state, \
 	.fill_modes = drm_helper_probe_single_connector_modes, \
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state, \
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
 
 int drm_mipi_dbi_connector_helper_get_modes(struct drm_connector *connector);

-- 
2.55.0

