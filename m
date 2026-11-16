Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9C606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HORGSpSX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B3910EF10;
	Mon, 16 Nov 2026 10:33:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D987C10EF04
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C81F628C1;
 Mon, 16 Nov 2026 10:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A3C1F000CB;
 Mon, 16 Nov 2026 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825179;
 bh=YslYCg44gqhBR6m0tRwHdg7c/YtFwS9wqvThXDiIe2c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HORGSpSX+RsdCAJwjPUZpbMxoH4/QnyCrVzMcKY2kUTW4QffEhtaR9+dCQmlvWw+3
 JAk2lYGXCZVY7ZiBq+BOaeRjTQE047uaTWtOUZFobafPpTleHWhQ8JQhpkOv//Wzbk
 ve2ZBk4E4LL0Hr9nswkvZ7ez2RdvXJPpaZzPSseG57RZhfqn2raZm3ygV+w29SQQL1
 ND83Tc6SqTXXg0D293OWDcFPcjGDvw9bUOYY3mnTitZped+B5GjAdWAPc1Wbls/G5l
 6eknjj/FfYWf2OCVL/kPBExoo5fEFS8ReuRS01JT/GGykeICD12lEva7dKyQlYgijU
 nJTOIzZ6oiP0w==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:54 +0100
Subject: [PATCH v2 38/64] drm/tests: drm_atomic_state_test: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-38-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=mripard@kernel.org;
 h=from:subject:message-id; bh=g8ZyZ6u2qOvNuiwgYYgu/goVsrhybr+EIecVR9wl33Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgcEBibuf1PaN/FJcIttouI1gf5TNQ03f2cdveCyh
 uV8RmJFx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZgIHx9jw4wFHuxFEjf6BExn
 9V+dHCiZ4/z7EfdBrp/+uhX9f6L5mqp7ri/KDq0/65znzrO/6OZlxoYZ/Z+uTah1uuIcv6xm5kE
 px6VFuw+7hey8u67s1a+Jwgc0Tvdyh07MSGp9I3zrx7sZt/MB
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

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_atomic_commit_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index 6ccb001f6264..97f60ce68b3e 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -132,11 +132,13 @@ drm_atomic_test_init_drm_components(struct kunit *test, bool has_connectors)
 
 		drm_connector_attach_encoder(conn, &priv->encoders[i]);
 	}
 
 done:
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;
 }
 
 static int set_up_atomic_state(struct kunit *test,

-- 
2.56.1

