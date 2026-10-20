Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFE606A328
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crzNBzZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A81610F37A;
	Tue, 20 Oct 2026 08:10:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4303110F379
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:10:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B11D4067A;
 Tue, 20 Oct 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792483814;
 b=yDeOZaaUaj/7VyaQZ+OaCvQZnFM2FvKdT3HCfr7i60aFwbMNCRMx7ED4vm0MNRlYw2dK
 2/zm18PwOwfLb6S3BPG9doqMQpFeHB/s9s8oCWICXvccEaA+zK7ZHFABfNCIf9rRq32yT
 CoU8YpWZIzYFJo2WQ0ONGvAsWmQyBhjtHpOXNV614bZza30xLFKgPACnr3KjhKLf2NclT
 7mloQLVH822kr1/UqXDSbimRVqSum4+ySZ0ZRoDtVgjlqnAGzlpCNQ8Cg6+IGzxw+NA4D
 G4WWsNjcYIRqL96U50cXme7Q2ljEqiHUBXmWe4FOgRVGAT3kmP6h2jtO0SFuA5PtnfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483814;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=8wInV1bks4Iw6mcSksXlHLW/myLfLZCb6aK36BGNRtY=;
 b=G7jmenU0QmUU7hxTuMc7M7Fg6k/Bg4ER5HLXw2AkMH6lqxAg6jA+eZZpP0fevnfiT9K6
 uVBR0i63eZZYfHSkqkYbs3Pw20vKZoWZSisC+jEavmmNfyeYqGBrgtgyIAV6RU5kKGMDU
 unk757iiQydAyxE93Ff+ghb/xv3jOngas1DHLxe8D01AaOnutItaf/Ii8q3Vp077FhLl0
 V98HkylYEZOfD9jHQE2hKcu34E6b3APFu/lg4o9hd+P5VatmUeRL1oEXMk9wTQk6eMXst
 LE0u9EhHMzPQ/dHpkxT9zyRCGQSZAB2wJ9jxHfcMl23tEB/oWp6pAAaF402DLyl0sog==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9B5A61F000D0;
 Tue, 20 Oct 2026 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792483814;
 bh=8wInV1bks4Iw6mcSksXlHLW/myLfLZCb6aK36BGNRtY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=crzNBzZXwCgxhRhW4VpOA69tQow/inJzohm33majkpvlX/Wk+manyC9oDGy0tE5dJ
 UH3N63464j1Ad5D3E5L2x+ZFXVZdCICgz+4jHRzTa0cMBtevqBLtsnC9vFaGlt6wQl
 fTfqirvV803vhJWuxzYCbMjVFudiryK0ncYpZ6gW4mlsNBB6F8pu5iZ3skGSgpI9ya
 OkCXVByLa/i2NxLXg0aiunEp3mN6gt6Pi3dMD51wOMZbgbibtfQw8WTKpHt+7gzKlB
 JslL6tBHZMcj6qbcfWJVzgLZr+QYERf7j45qms0eOOOhnkV6moAoDgUml4/L3QEcx5
 6bVK01PqqGy0g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DB0F3430BF;
 Tue, 20 Oct 2026 08:10:11 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 20 Oct 2026 03:10:07 -0500
Subject: [PATCH v3 1/2] drm/tegra: Support swapping chroma planes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-tegra-drm-yvu420-v3-1-7f19a834ba98@gmail.com>
References: <20261020-tegra-drm-yvu420-v3-0-7f19a834ba98@gmail.com>
In-Reply-To: <20261020-tegra-drm-yvu420-v3-0-7f19a834ba98@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483811; l=4205;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=aseBG4+nsmwlogE8nfji0wIaNX+2LJ0Usy3RCoj2p3w=;
 b=+kv2t7CxKtklxPPslCL2P6ENlUlcpoNJU1sOtYT9/pKSItwbcFMIr4PQZZKw89mJyLBEtvNQY
 b9sZzXIBXywBqRuurN9xoOTttST3H9Z1wHYnMoRaf3WIw5b+dtGWB5r
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: webgeek1234@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aaron Kling <webgeek1234@gmail.com>

The Tegra display controller supports some yuv types, but not their
chroma swapped variants. For example, yuv420 is supported but yvu420 is
not. For tegradc, this can be efficiently worked around by just passing
the hardware said chroma planes backwards. For nvdisplay, there is a
window group flag to do the swap in hardware. Add a flag to the plane
state struct and handling to both tegradc and nvdisplay paths.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 6 +++++-
 drivers/gpu/drm/tegra/hub.c   | 7 +++++--
 drivers/gpu/drm/tegra/plane.c | 5 ++++-
 drivers/gpu/drm/tegra/plane.h | 3 ++-
 4 files changed, 16 insertions(+), 5 deletions(-)

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
index 448f49f3a7d7e..5a86f8260f136 100644
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
 
@@ -642,7 +643,9 @@ static void tegra_shared_plane_atomic_update(struct drm_plane *plane,
 	base |= addr_flag;
 
 	tegra_plane_writel(p, tegra_plane_state->format, DC_WIN_COLOR_DEPTH);
-	tegra_plane_writel(p, 0, DC_WIN_PRECOMP_WGRP_PARAMS);
+
+	value = tegra_plane_state->swap_uv ? SWAP_UV : 0;
+	tegra_plane_writel(p, value, DC_WIN_PRECOMP_WGRP_PARAMS);
 
 	value = V_POSITION(new_state->crtc_y) |
 		H_POSITION(new_state->crtc_x);
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


