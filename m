Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22A606A325
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjKTsqfu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED6B112664;
	Thu, 22 Oct 2026 13:53:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75FB112664
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:53:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA8BD4139A;
 Thu, 22 Oct 2026 13:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD1F1F000C1;
 Thu, 22 Oct 2026 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792677218;
 bh=mTDmY50binhv4KAhOwDjYuuuzxrs3fracWCulNAzN7A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jjKTsqfuU60TMwiTZt8Z4AaEEIgXoh1AYVIfhKzAHT3foYHIPstJiAXoiajRzOdni
 NTXDGcuNHPHD6/TQ96bFG/8O2K5Ef4x07D+uMAvRAOV30Ukz9ha2CrJE6+D9QDD9ns
 0BB+pro278zIMZ+7YzD+ibfXrRoM+ZtKwlU9uJ8/yNo5KTV7wKrCjVwiC6C92JU2ln
 +fD0Tw1/Nbt+zHHdTs5YX7OeQQRq+Iq+LgEPUnM5Z7qCnRWMXP0SyjQASHKFdKQ00Y
 3oeZGCxtoT3eo3TVLENXb0eKVVGo6TfSDq0L9jXt9kEjHLpMN5D7eiCsgXvt2ZXtGP
 te608JMZSsydQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 15:53:07 +0200
Subject: [PATCH v6 06/15] drm/atomic: Create function to insert plane state
 into a commit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-reset-state-flag-v6-6-f36d640b7e76@kernel.org>
References: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
In-Reply-To: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
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
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=mripard@kernel.org;
 h=from:subject:message-id; bh=41LUGhYJAROn0oZPZrkQUy7D8c62RSMKcGFPg+lAdDc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3RF3LqgujlXqcVY3dRXYw2d9VfJRZYmB6Mf/FJq/Hr
 ry6GZ87prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwERucDI27En7FRPL5u40Nyq4
 XVSv6flG+e+vN194O+X4BcnHBdEnE5ol3zryXbIqmnyo+OSr7f2HGRuOfdvGluWhrVGaVXmkkuf
 9qi8n580XW3x5naIK79TGEw+m5U8pfadbeEXsTmfF4+fV758AAA==
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

drm_atomic_get_plane_state() allocates a new plane state by
duplicating the current one and inserts it into the atomic commit as
a single operation.

However, a later change will need to insert a plane state into a
commit without going through the full allocation and duplication path
in drm_atomic_get_plane_state().

Extract the state insertion logic into a new static
drm_atomic_commit_set_plane_state() helper, and convert
drm_atomic_get_plane_state() to use it.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 178eca95d0e3..b26458ee98d8 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -631,4 +631,19 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
 }
 
+static void drm_atomic_commit_set_plane_state(struct drm_atomic_commit *commit,
+					      struct drm_plane *plane,
+					      struct drm_plane_state *plane_state)
+{
+	int index = drm_plane_index(plane);
+
+	drm_modeset_lock_assert_held(&plane->mutex);
+
+	commit->planes[index].state_to_destroy = plane_state;
+	commit->planes[index].old_state = plane->state;
+	commit->planes[index].new_state = plane_state;
+	commit->planes[index].ptr = plane;
+	plane_state->state = commit;
+}
+
 /**
  * drm_atomic_get_plane_state - get plane state
@@ -649,5 +664,5 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 			  struct drm_plane *plane)
 {
-	int ret, index = drm_plane_index(plane);
+	int ret;
 	struct drm_plane_state *plane_state;
 
@@ -672,9 +687,5 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 		return ERR_PTR(-ENOMEM);
 
-	state->planes[index].state_to_destroy = plane_state;
-	state->planes[index].ptr = plane;
-	state->planes[index].old_state = plane->state;
-	state->planes[index].new_state = plane_state;
-	plane_state->state = state;
+	drm_atomic_commit_set_plane_state(state, plane, plane_state);
 
 	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",

-- 
2.55.0

