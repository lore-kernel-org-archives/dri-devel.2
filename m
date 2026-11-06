Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C635606A331
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEgasTjq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C6110EA81;
	Fri,  6 Nov 2026 15:11:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E9C10EA81;
 Fri,  6 Nov 2026 15:11:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C772840673;
 Fri,  6 Nov 2026 15:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA4C1F008A4;
 Fri,  6 Nov 2026 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793977913;
 bh=Cv8s/0EAszCylBUn/l89HelJSiucOWcHTNPbi/BT1f4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GEgasTjq4ZPejm9sZ6app4Zav04q8SnDv5Sz56BoI4EjUc0+UNxHgnhxGfXgCUGKI
 bB/o9zqedy3xsYWqQCVeeas6wqJ2FYuEzTyrjPEtILtbZba1c993EoX25FW2KN8DTB
 kRh3gtka5lyJy5Omf0ExDF9VYIPWtyxpGj5L8B9DlM9/K/kKKXkZeZ6noJ1hpRQmPP
 GMPPo3Af0Get2HZzjbnS9GGswq6ZTLHgh4e+zjK3vpkjeVmuej+qE0IBeUYJVvPWTf
 YfySTNr0KbgY7B4sDKyr3NUnfbBpu4dbeEcxXUn6zz8bye260u5qMt0l+mfhSie/e2
 2dX7T6ZtCH0VQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 16:11:39 +0100
Subject: [PATCH v8 1/7] drm/amd/display: Fix planes atomic_create_state
 implementation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-drm-reset-state-flag-v8-1-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
In-Reply-To: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UXJpmo5ROHPzhMg+de0zko6SddYMdKZssZ+0PtShoSM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlv3+nLT/Gddj9hytw5so6XPcTSr3rpvQ08u0hR8GDRm
 f3Vir23O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEVjxirDP5ZDxLNnTi8cMq
 B7ZJ7T+l8kVw9hYrz+NXou1tbGKmR1x97/DPpu5Ghpj4pJcad7b8nsZYp7w5kpEnPE2T42OUYej
 Ek7YNSndm75ZZdGx1p2ldsff1Ddf+/clKyJmxp8emgj9t8dUKAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
converted the amdgpu planes to use atomic_create_state instead of reset.

Unlike reset, atomic_create_state is meant to allocate a new default
state without any side effect on the hardware or software state.

However, during the conversion we forgot to remove the call to destroy
the existing plane state if any. While this was expected from a reset
implementation, it's not for an atomic_create_state one. Remove it.

Fixes: 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

To: Harry Wentland <harry.wentland@amd.com>
To: Leo Li <sunpeng.li@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 91398230d408..31101c810bac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1804,7 +1804,4 @@ STATIC_IFN_KUNIT struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(
 	}
 
-	if (plane->state)
-		plane->funcs->atomic_destroy_state(plane, plane->state);
-
 	__drm_atomic_helper_plane_state_init(&amdgpu_state->base, plane);
 	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;

-- 
2.55.0

