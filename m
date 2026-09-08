Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A99C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB4A10EC2A;
	Tue,  8 Sep 2026 14:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YXuIcb0o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3593610EC56
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:35:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F01A41748;
 Tue,  8 Sep 2026 14:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DAC1F00A3F;
 Tue,  8 Sep 2026 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878123;
 bh=ohLVhV+vK2hN/lzyGqNK6/ZnRj8cPzMGLS+edC/u0TE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YXuIcb0oHtVxmTaaTOmZaVKppO3iR0VLad2tU6WIJKab+W12QMtu0r5wjceeBkJap
 1fHoWaJ1CL5dotJC28xJLRpj0Ryzobf5sdHPwLbvsLXwmy9vbEwSBxFJlp9k43SbdH
 7LPncrfmrQtDFmtd1glP48+I7ULFBYFdlDCi4rdBSsg9YlW8jpmch/8bk/xkxv5xV9
 CIb4OFTzaeecZ02u8FwyV/XwFor0wyaxRCQkc9f5y60NjqFVf8VKmT+5vhGn2Hz8U6
 ta7wjpdOhLbd2C/aAjR/7WmlvnjExOWe+JC30p/kQW9mnTMJi1FoX4a4lms5vN17dN
 BCBRiJDODEm7Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:35:03 +0200
Subject: [PATCH v3 02/11] drm/atomic: Create function to insert CRTC state
 into a commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-reset-state-flag-v3-2-905570f387a4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=mripard@kernel.org;
 h=from:subject:message-id; bh=i0ebjrzllE9a+RJMjGlK4kAZEGdsP5r+YMP40Y27aFM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkLZKWljCJ9Odhma/RYf+YLudotPzmx1SDaoCqaRXNuy
 2K7NKGOqSwMwpwMsmKKLE9kwk4vb19c5WC/8gfMHFYmkCEMXJwCMJH97xnrvXP7My8E5l96uWYR
 Q/TE5+0Ohf/5zmmft3As5E1aGGS36pbcopLWY3bL3/7cmTbtrWEKY52dZP25bw2vbyzue38xQzZ
 wxZ+pz45JOfC/6VnS3nzmwP6/+RxblfofRW06ESwS47FftQUA
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

drm_atomic_get_crtc_state() allocates a new CRTC state by duplicating
the current one and inserts it into the atomic commit as a single
operation.

However, a later change will need to insert a CRTC state into a
commit without going through the full allocation and duplication path
in drm_atomic_get_crtc_state().

Extract the state insertion logic into a new static
drm_atomic_commit_set_crtc_state() helper, and convert
drm_atomic_get_crtc_state() to use it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 5c0f7b7024d1..153d959bd4ff 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -421,10 +421,27 @@ void __drm_atomic_commit_free(struct kref *ref)
 
 	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(__drm_atomic_commit_free);
 
+static int drm_atomic_commit_set_crtc_state(struct drm_atomic_commit *commit,
+					    struct drm_crtc *crtc,
+					    struct drm_crtc_state *crtc_state)
+{
+	int index = drm_crtc_index(crtc);
+
+	drm_modeset_lock_assert_held(&crtc->mutex);
+
+	commit->crtcs[index].state_to_destroy = crtc_state;
+	commit->crtcs[index].old_state = crtc->state;
+	commit->crtcs[index].new_state = crtc_state;
+	commit->crtcs[index].ptr = crtc;
+	crtc_state->state = commit;
+
+	return 0;
+}
+
 /**
  * drm_atomic_get_crtc_state - get CRTC state
  * @state: global atomic state object
  * @crtc: CRTC to get state object for
  *
@@ -443,11 +460,11 @@ EXPORT_SYMBOL(__drm_atomic_commit_free);
  */
 struct drm_crtc_state *
 drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
 			  struct drm_crtc *crtc)
 {
-	int ret, index = drm_crtc_index(crtc);
+	int ret;
 	struct drm_crtc_state *crtc_state;
 
 	WARN_ON(!state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
 
@@ -461,15 +478,15 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
 
 	crtc_state = crtc->funcs->atomic_duplicate_state(crtc);
 	if (!crtc_state)
 		return ERR_PTR(-ENOMEM);
 
-	state->crtcs[index].state_to_destroy = crtc_state;
-	state->crtcs[index].old_state = crtc->state;
-	state->crtcs[index].new_state = crtc_state;
-	state->crtcs[index].ptr = crtc;
-	crtc_state->state = state;
+	ret = drm_atomic_commit_set_crtc_state(state, crtc, crtc_state);
+	if (ret) {
+		crtc->funcs->atomic_destroy_state(crtc, crtc_state);
+		return ERR_PTR(ret);
+	}
 
 	drm_dbg_atomic(state->dev, "Added [CRTC:%d:%s] %p state to %p\n",
 		       crtc->base.id, crtc->name, crtc_state, state);
 
 	return crtc_state;

-- 
2.55.0

