Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD404C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238FB10E603;
	Wed, 16 Sep 2026 08:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CaXtj5SX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BE510E8F0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E75243996;
 Wed, 16 Sep 2026 08:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C33D1F00893;
 Wed, 16 Sep 2026 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548967;
 bh=coCUJokKo7gpmQMYlPl9FYskB2sIiCVwAGIux3w45uY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CaXtj5SXqBLIg7Do0fyJoEmht79ZiMJwT/writsAAJ5sHF3J0zg/BSNdIL6SlsVGO
 Cgdt6ZIO2DuQINvy9+aY47reFF5u4U/fYza1jL0czP9bPdy5qoY45HK995yzOk9PoB
 2tvV277KpgWPQNnymOfT1433+v+jjISMfUheTbNcZEJ7xERi6JcWg/8zAdHTsbFgT2
 uUY43Qcz78t4Mi6iz6nKtLGZiuBWxJLbce7jrlzZyDZGVs26vSJ6uO/Vq8GEMJaPxP
 LhGhKUGHigsXogN1fKAAcQJYxbFAwfU57wWXCWQE1gbXWCyeRMK79vYYsb3dH/n5iq
 yjtKHY2gTcP8A==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:46 +0200
Subject: [PATCH v5 3/9] drm/mcde: Switch to
 drm_atomic_helper_plane_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-3-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=mripard@kernel.org;
 h=from:subject:message-id; bh=eyFLvBoZnCxW+Lh14bE//J8+JcQSSguAx2tqbxw9GF0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqdwaV8KSVx/KOC1xn2vpMZ+6T0/Luv9LF0vfUP1g
 Ns+uVdFHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiQW6MdRabs1mSit6uP2Kc
 o6W7bYnRUTmmA0HyleGGLw6+5ixhU5cuvZQ3aWb2hN4mzsJbed/nMzZ8lL83sS68fdEmPo/yyhm
 Xr9/STEncZ33CY0tNfIERL3efV3rg4k8suibx/cpLP7WEbAAA
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

The mcde plane implementation uses the deprecated
drm_atomic_helper_plane_reset() as its reset hook.

Switch to drm_atomic_helper_plane_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index d1d01f3d8ab4..af1b8c466a02 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -1526,11 +1526,11 @@ static const struct drm_crtc_helper_funcs mcde_crtc_helper_funcs = {
 };
 
 static const struct drm_plane_funcs mcde_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
 	.destroy		= drm_plane_cleanup,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 

-- 
2.55.0

