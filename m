Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC647C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CFF10F1BA;
	Wed,  8 Jul 2026 16:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ypuuk+gP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05FB10F1B5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:09:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B891841E8E;
 Wed,  8 Jul 2026 16:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B11F000E9;
 Wed,  8 Jul 2026 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783526940;
 bh=JkCB/yLDgCMXGjeHTwMFtk2LLys1f8LzwWd7x1TS8IE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ypuuk+gPb5o8Sv70XfHcdhwffvMYRZMDCKVDLKTizFl0H5Czb6KaM9pqg8seJitys
 iJervuAtVAMQ7rshCWjMVvuhAv/VNsTfrK2TUgexa7d7NI7OUjG6OQRaMp/mcWSHNH
 c2oi1gMLQho/TJIK4/t8jZIv5z0Ut6El4934uE0DKWt83Hc1Pg9xzuOJptPEr7ZV+0
 UsIl0QOXEkwRXhxMnbPn4Ha9Ga6InTS5Q9Tk5T4cLMZd8JVwlV/xHpgHm/pTSwQNzL
 +Ni74rwd01+omNfh0TBlJfwvaJ6nPi8Nk5jLlkywKMbGxnYilRjxH93eoBgGhRNL7z
 d07YPrYWaoW5A==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 08 Jul 2026 18:08:41 +0200
Subject: [PATCH RFC 4/8] drm/atomic: Create function to insert colorop
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-drm-reset-state-flag-v1-4-c37dc985485d@kernel.org>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
In-Reply-To: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fttxGMVBGL07n7oY5tNcqwsyIoOf7c4O1B/Bmytm3Sg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl+ZXwxSxpniaRMvMHVXzVrmqVu2ENV8cQj+2zkw1iKR
 KJ/BE3tmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABN59pmx4ay8RJbTgv1865Ln
 3c9x62FcNUM4bFVlxpWAuXvC6gKOR/bvy1VaUPph9hvdmF2LvUsSGOuzyt40dFoUaf3nvN9W9PJ
 TxZbXLgEL2U5OZ0pd+1qnqM9YWc/NWopxnjNHmNHy9dsZ4gE=
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

drm_atomic_get_colorop_state() allocates a new colorop state by
duplicating the current one and inserts it into the atomic commit as
a single operation.

However, a later change will need to insert a colorop state into a
commit without going through the full allocation and duplication path
in drm_atomic_get_colorop_state().

Extract the state insertion logic into a new static
drm_atomic_commit_set_colorop_state() helper, and convert
drm_atomic_get_colorop_state() to use it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 56542494ab56..f006de9b7263 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -704,10 +704,27 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 
 	return plane_state;
 }
 EXPORT_SYMBOL(drm_atomic_get_plane_state);
 
+static int drm_atomic_commit_set_colorop_state(struct drm_atomic_commit *commit,
+					       struct drm_colorop *colorop,
+					       struct drm_colorop_state *colorop_state)
+{
+	int index = drm_colorop_index(colorop);
+
+	drm_modeset_lock_assert_held(&colorop->plane->mutex);
+
+	commit->colorops[index].state_to_destroy = colorop_state;
+	commit->colorops[index].old_state = colorop->state;
+	commit->colorops[index].new_state = colorop_state;
+	commit->colorops[index].ptr = colorop;
+	colorop_state->state = commit;
+
+	return 0;
+}
+
 /**
  * drm_atomic_get_colorop_state - get colorop state
  * @state: global atomic state object
  * @colorop: colorop to get state object for
  *
@@ -723,11 +740,11 @@ EXPORT_SYMBOL(drm_atomic_get_plane_state);
  */
 struct drm_colorop_state *
 drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 			     struct drm_colorop *colorop)
 {
-	int ret, index = drm_colorop_index(colorop);
+	int ret;
 	struct drm_colorop_state *colorop_state;
 
 	WARN_ON(!state->acquire_ctx);
 
 	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
@@ -740,15 +757,15 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 
 	colorop_state = drm_atomic_helper_colorop_duplicate_state(colorop);
 	if (!colorop_state)
 		return ERR_PTR(-ENOMEM);
 
-	state->colorops[index].state = colorop_state;
-	state->colorops[index].ptr = colorop;
-	state->colorops[index].old_state = colorop->state;
-	state->colorops[index].new_state = colorop_state;
-	colorop_state->state = state;
+	ret = drm_atomic_commit_set_colorop_state(state, colorop, colorop_state);
+	if (ret) {
+		drm_colorop_atomic_destroy_state(colorop, colorop_state);
+		return ERR_PTR(ret);
+	}
 
 	drm_dbg_atomic(colorop->dev, "Added [COLOROP:%d:%d] %p state to %p\n",
 		       colorop->base.id, colorop->type, colorop_state, state);
 
 	return colorop_state;

-- 
2.54.0

