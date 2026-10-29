Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/viTYv4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A13810FFE1;
	Thu, 29 Oct 2026 07:35:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B88710FFD0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C348360232;
 Thu, 29 Oct 2026 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33AB1F01825;
 Thu, 29 Oct 2026 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259296;
 bh=OHTieHW2qhmJqkKAoM9GjqHbm6KoGrhXfOxczKiB1qc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j/viTYv4oKLEXlOD61oWYB+Uqm+mdaJ6I4IGr3z0oz3Q2x0Yj0UNmD9OLPohlp5e/
 HwEylZT/VK/LvE/gO7qN0ojjIZj456uu6ZnPmXZWL5Gu75wAhviiPAflQur3tcY4Vj
 IsGlfRMrmkaJpGyJ5xFIpY9oUjVQuSY+XwNg8o3USQ8UX5pDuLDUnn1DShik9SiFpN
 WxUxmvp6xCBtcVeH94Fa7dTLcA4UG/1HSXNrwDjdJAuOL2jN9IZK71YDQtNxLu56VV
 xlT2/4NAuFBzy5jFF0Jx6vaSR9FjFB0wdFebLQld57QoMvQyEumXe2JDVxSpojBM1o
 Z/5UyjJb/5T3A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:33:59 +0100
Subject: [PATCH v7 09/34] drm/atomic: Export drm_atomic_*_print_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-9-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3545; i=mripard@kernel.org;
 h=from:subject:message-id; bh=n8Z9B/nELFbnUNzbNrUE3jRJDONbahVmbf1UlU1Ip6M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn2ovZMfIZXmKlbj9rLMJH6D9YVybw3zGRvbV5c7c
 wd2TZrXMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZy+RdjreQBaf7p93/WcX9W
 M9tt+TKY4eGx6vQQhc+uKQXSjz7v7K+3bzt2jsm2fp3fpH2d6ve6GetduraqNf/b8iVdITDk5CL
 DtbWcb1fq5zWuO2XT6su5PHS7+KUrC1oZmwV8Q2KYdX4tPg8A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm_atomic_plane_print_state(), drm_atomic_crtc_print_state(),
drm_atomic_connector_print_state(), and
drm_atomic_private_obj_print_state() functions are currently static.

The SRO infrastructure needs to call them from
drm_atomic_state_readout.c to print the readout state for debugging
purposes. Make them available by dropping the static qualifier and
declaring them in drm_internal.h.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c   | 16 ++++++++--------
 drivers/gpu/drm/drm_internal.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 039be737fd07..895b958c2901 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -548,6 +548,6 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
 }
 
-static void drm_atomic_crtc_print_state(struct drm_printer *p,
-		const struct drm_crtc_state *state)
+void drm_atomic_crtc_print_state(struct drm_printer *p,
+				 const struct drm_crtc_state *state)
 {
 	struct drm_crtc *crtc = state->crtc;
@@ -947,6 +947,6 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 }
 
-static void drm_atomic_plane_print_state(struct drm_printer *p,
-		const struct drm_plane_state *state)
+void drm_atomic_plane_print_state(struct drm_printer *p,
+				  const struct drm_plane_state *state)
 {
 	struct drm_plane *plane = state->plane;
@@ -1473,6 +1473,6 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 EXPORT_SYMBOL(drm_atomic_get_connector_state);
 
-static void drm_atomic_connector_print_state(struct drm_printer *p,
-		const struct drm_connector_state *state)
+void drm_atomic_connector_print_state(struct drm_printer *p,
+				      const struct drm_connector_state *state)
 {
 	struct drm_connector *connector = state->connector;
@@ -2119,6 +2119,6 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 EXPORT_SYMBOL(__drm_atomic_helper_set_config);
 
-static void drm_atomic_private_obj_print_state(struct drm_printer *p,
-					       const struct drm_private_state *state)
+void drm_atomic_private_obj_print_state(struct drm_printer *p,
+					const struct drm_private_state *state)
 {
 	struct drm_private_obj *obj = state->obj;
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index f893b1e3a596..815486557f51 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -40,13 +40,26 @@ struct dma_buf;
 struct iosys_map;
 struct drm_connector;
+struct drm_connector_state;
 struct drm_crtc;
+struct drm_crtc_state;
 struct drm_framebuffer;
 struct drm_gem_object;
 struct drm_master;
 struct drm_minor;
+struct drm_plane_state;
 struct drm_prime_file_private;
 struct drm_printer;
+struct drm_private_state;
 struct drm_vblank_crtc;
 
+/* drm_atomic.c */
+void drm_atomic_plane_print_state(struct drm_printer *p,
+				  const struct drm_plane_state *state);
+void drm_atomic_crtc_print_state(struct drm_printer *p,
+				 const struct drm_crtc_state *state);
+void drm_atomic_connector_print_state(struct drm_printer *p,
+				      const struct drm_connector_state *state);
+void drm_atomic_private_obj_print_state(struct drm_printer *p,
+					const struct drm_private_state *state);
 /* drm_client_event.c */
 #if defined(CONFIG_DRM_CLIENT)

-- 
2.55.0

