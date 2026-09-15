Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BFFC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2575E10E85E;
	Tue, 15 Sep 2026 10:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n7FGizkm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2119C10E814;
 Tue, 15 Sep 2026 10:12:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CEE6D434D4;
 Tue, 15 Sep 2026 10:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D19C1F000FF;
 Tue, 15 Sep 2026 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789467175;
 bh=NfoUQduSWmFink/5S/bNRnGZCA/pdLAU6Bd1CaQ3OmA=;
 h=From:To:Cc:Subject:Date;
 b=n7FGizkmfQbWAi/P/l7kyg2dNBaSsE4HHCIF8HWXp3ubbjNJgTo0yXYdP8rPtQGZN
 cmRNHObtJMQ66e3cPhcaMdzW5H1TMJwvNvKAEzRYv0w+5SWjmyqpq2O55VgAvmn3x+
 M/m/Z8g9O5Mttp3DFNg40318CJz3KwfHQUi0roIyG3kw22DG8QKblL//yIoSMbawmG
 IlaYp+tIxP7Ntn3Q8OlGrn9zgU4aZnBLU9r9pPind3RdsqEFh+pLZP5Ai5eMhuys11
 OAKmQKirBNTYKd7nlZ70SSCwSObZPlWvCrmEvZYqxiQAKmSMptycyOKdq06qitfbeb
 Sh8nGbs3JrXuA==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu_dm: tests: Fix wrong variable declaration after
 merge conflict
Date: Tue, 15 Sep 2026 12:12:51 +0200
Message-ID: <20260915101251.1711103-1-mripard@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Commit 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
converted dm_test_plane_create_state_initializes_state() to call
amdgpu_dm_plane_drm_plane_create_state(), which returns a struct
drm_plane_state pointer stored in a new plane_state variable.

However, the merge conflict resolution kept the old declaration
(struct dm_plane_state *old_state) instead of replacing it with
struct drm_plane_state *plane_state, leaving an unused variable with
the wrong type.

Fix the declaration to match what the conversion intended.

Fixes: 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index c75a2ef87479..4a2ea3ea2ce5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -2931,11 +2931,11 @@ static const struct drm_plane_funcs dm_test_plane_reset_funcs = {
  * dm_plane_state, and initializes the AMD-specific transfer function and HDR
  * multiplier defaults.
  */
 static void dm_test_plane_create_state_initializes_state(struct kunit *test)
 {
-	struct dm_plane_state *old_state;
+	struct drm_plane_state *plane_state;
 	struct dm_plane_state *new_state;
 	struct drm_plane *plane;
 
 	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, plane);
-- 
2.55.0

