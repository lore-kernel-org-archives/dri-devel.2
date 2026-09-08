Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D41C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B757C10E1D1;
	Tue,  8 Sep 2026 14:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GEoB3Kdu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CAD10EC26
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:35:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EF8842A75;
 Tue,  8 Sep 2026 14:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815EE1F00AC4;
 Tue,  8 Sep 2026 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878131;
 bh=XMX13DtPDDnyfrT120bG1968XXiMmSlCAD2GolHcyVY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GEoB3KduVPc01tcYEIO5KOnyQn8BuXVS+a4NBE7w49HkSSc0rYPbkiqEq/ssz2IO4
 +ZQnc1rlTsoI8tZeMGB9tZpupdB+Rssb2ATAQKjUfwJfJy0XGpVGWiCoSOFyD7YYfD
 4ZbzuRS37eTW3k4vZwK7v31rCdcLzbmit1Ynj8W2MsQsLeXyOMnETuIrHetrLwAezG
 pyeq3xLCnKCHZTRnq2IO+GZcvPNu0Y8Vw4CV3mGTHqQvDYd8rE4qdoSjEx7fKT31yb
 W/0GwK2FkTUD/nfNX4/K7AEWOiRkT+jDTyMtEW7Sv0/IftZ9BK9RFgg8xUSJnuK1bc
 n32ddQ0NavmVA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:35:05 +0200
Subject: [PATCH v3 04/11] drm/atomic: Create function to insert colorop
 state into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-reset-state-flag-v3-4-905570f387a4@kernel.org>
References: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
In-Reply-To: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=mripard@kernel.org;
 h=from:subject:message-id; bh=norOsKJSzhagJvOfVR7DhL/TvimASvnyTfHuJ3JakF4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkLZGX627PvOfkniETfr0q78jYrODRLPD22dNtsd79q2
 1P2ToYdU1kYhDkZZMUUWZ7IhJ1e3r64ysF+5Q+YOaxMIEMYuDgFYCJBdxlrBY9N2cI/O6HI8Abr
 Elk/tndxlXdt7lkdXnFl1+zQS7wFm+zLNL+907l0wkIg/Kb79qtpjPU+s9TM0y4psM7+2P3P+/6
 jbysOLHNasnduqMKauHZP7pCNOhoXmRbtsQxi/PuhRc+C7TQA
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
index f62323679f44..f6a31c9d477d 100644
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
 
-	state->colorops[index].state_to_destroy = colorop_state;
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
2.55.0

