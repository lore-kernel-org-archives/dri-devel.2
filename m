Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C96DCCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 22:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A891E10E732;
	Sun, 18 Oct 2026 22:04:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F43610E732
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 22:03:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FD3A60D9F;
 Sun, 18 Oct 2026 22:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC40CC2BCFC;
 Sun, 18 Oct 2026 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792361028;
 bh=09VHhiwJd7bTVssvm/nN2IhGWzCo6OX16LPn+5tjF3o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=lhw8M8ok6wSEaaaIKXRO8hJJAmcN9mMg3WEdGkyPRYHNsZV0YrH9rY8P0RGd37nP7
 MvzIU/oBNB6FcYSdQVvSpxZSSeQuHxqK/pS/XrBCTBYxIWXisDyu+xannaTGWhfknk
 UCBV5h3WXZ8ilx00aoJ2Dwd9qXAz36l0BKgeGyomYQRobWtw4YfxLS+WViZ3COGT/p
 8feuk+L6BbpIV6Ps9pRyW92Av9TcUJo8nfQNHru7XnTbsfcZhYuP0TFNtli35kRd5V
 YE2SvyZZSmPRpL11yEfrzYu/z+cDmBCrCfWKFObB4vzktv1zjtIHo/eHUJLJ542sbD
 S+YTXj7qEUtCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9C75FCCA490;
 Sun, 18 Oct 2026 22:03:48 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 18 Oct 2026 17:03:46 -0500
Subject: [PATCH v2 1/2] drm/tegra: Support swapping chroma planes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-tegra-drm-yvu420-v2-1-512889103ab4@gmail.com>
References: <20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com>
In-Reply-To: <20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792361027; l=4832;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=8f9/kgf/w+kZjuzlQw+QdyCPQS3aC0rzLtNVhOjyJ/w=;
 b=zXJ3DOw+bT6jInahrAwSnUEHLyWh1V3+w2pB1UE/WEWe5DkTmvKyGxaxboMPergZZy/2NiUsN
 RWQiKFTitlNDrsOSRXuRm+AalDAxZxCqMl3Uf6KGlY2zUvtEHgni77E
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

The Tegra display controller supports some yuv types, but not their
chroma swapped variants. For example, yuv420 is supported but yvu420 is
not. This can be efficiently worked around by just passing the hardware
said chroma planes backwards. Add a flag to the plane state struct and
handling to both tegradc and nvdisplay paths.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    |  6 +++++-
 drivers/gpu/drm/tegra/hub.c   | 14 +++++++++-----
 drivers/gpu/drm/tegra/plane.c |  5 ++++-
 drivers/gpu/drm/tegra/plane.h |  3 ++-
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index b0bfa946e6979..39c2e920d76a6 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -740,7 +740,8 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 
 	err = tegra_plane_format(new_plane_state->fb->format->format,
 				 &plane_state->format,
-				 &plane_state->swap);
+				 &plane_state->swap,
+				 &plane_state->swap_uv);
 	if (err < 0)
 		return err;
 
@@ -872,6 +873,9 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 			window.stride[i] = fb->pitches[i];
 	}
 
+	if (tegra_plane_state->swap_uv)
+		swap(window.base[1], window.base[2]);
+
 	tegra_dc_setup_window(p, &window);
 }
 
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 448f49f3a7d7e..6427155ac4fdf 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -440,7 +440,8 @@ static int tegra_shared_plane_atomic_check(struct drm_plane *plane,
 
 	err = tegra_plane_format(new_plane_state->fb->format->format,
 				 &plane_state->format,
-				 &plane_state->swap);
+				 &plane_state->swap,
+				 &plane_state->swap_uv);
 	if (err < 0)
 		return err;
 
@@ -664,24 +665,27 @@ static void tegra_shared_plane_atomic_update(struct drm_plane *plane,
 	tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE);
 
 	if (yuv && planes > 1) {
-		base = tegra_plane_state->iova[1] + fb->offsets[1];
+		uint8_t u = tegra_plane_state->swap_uv ? 2 : 1;
+		uint8_t v = tegra_plane_state->swap_uv ? 1 : 2;
+
+		base = tegra_plane_state->iova[u] + fb->offsets[u];
 		base |= addr_flag;
 
 		tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_U);
 		tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_U);
 
 		if (planes > 2) {
-			base = tegra_plane_state->iova[2] + fb->offsets[2];
+			base = tegra_plane_state->iova[v] + fb->offsets[v];
 			base |= addr_flag;
 
 			tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_V);
 			tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_V);
 		}
 
-		value = PITCH_U(fb->pitches[1]);
+		value = PITCH_U(fb->pitches[u]);
 
 		if (planes > 2)
-			value |= PITCH_V(fb->pitches[2]);
+			value |= PITCH_V(fb->pitches[v]);
 
 		tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE_UV);
 	} else {
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 2148b0c59815c..757bc552809fe 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -59,6 +59,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->tiling = state->tiling;
 	copy->format = state->format;
 	copy->swap = state->swap;
+	copy->swap_uv = state->swap_uv;
 	copy->reflect_x = state->reflect_x;
 	copy->reflect_y = state->reflect_y;
 	copy->opaque = state->opaque;
@@ -319,11 +320,13 @@ int tegra_plane_state_add(struct tegra_plane *plane,
 	return 0;
 }
 
-int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap)
+int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv)
 {
 	/* assume no swapping of fetched data */
 	if (swap)
 		*swap = BYTE_SWAP_NOSWAP;
+	if (swap_uv)
+		*swap_uv = false;
 
 	switch (fourcc) {
 	case DRM_FORMAT_ARGB4444:
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index e33a581e6490e..dba5f1b254e98 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -49,6 +49,7 @@ struct tegra_plane_state {
 	struct tegra_bo_tiling tiling;
 	u32 format;
 	u32 swap;
+	bool swap_uv;
 
 	bool reflect_x;
 	bool reflect_y;
@@ -88,7 +89,7 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane,
 int tegra_plane_state_add(struct tegra_plane *plane,
 			  struct drm_plane_state *state);
 
-int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
+int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv);
 bool tegra_plane_format_is_indexed(unsigned int format);
 bool tegra_plane_format_is_yuv(unsigned int format, unsigned int *planes, unsigned int *bpc);
 int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,

-- 
2.54.0


