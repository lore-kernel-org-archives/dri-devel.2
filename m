Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A060A2634
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGvFjSsV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B62112724;
	Fri, 30 Oct 2026 10:28:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBA911272B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:28:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E8A9602CC;
 Fri, 30 Oct 2026 10:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335771F00A15;
 Fri, 30 Oct 2026 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356088;
 bh=CzmNkiMv5ZgXclvYn2qzX3vsC5a+5Aneg6GuHpphg5U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SGvFjSsVTxcOnggFYhXY9Ota4vCPX++EVnsmvquD2grgoNJgyQu3xAJva4SsVALEM
 8VuGNfAVE2vq36TeDrjOsHxsY96nhVEVoOZeqhEh13Uk8uUqkHuh+wQHhmCnJWlvIG
 2cxu0VYcZPmFl3DdJ178RTgOJYnk8VxaqqWMGHeGp2okFPYSd9GxP3ge2+gFU2ZJQ9
 RVsOwndt61E031rBPoBbk2nuZmP5Z5BgvVRFtfE5RVv/1bNpQ/39XOQoaQNZeYZiQv
 v3Ac+JHR8JYLm2pQRAfTN59hvZ6ET/+LQr/1hZH0ziNioot4QAGdI8QnBqaA3XEDj7
 hEOaBLx3BkJag==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 11:27:38 +0100
Subject: [PATCH v7 06/16] drm/atomic: Create function to insert CRTC state
 into a commit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-reset-state-flag-v7-6-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
In-Reply-To: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xfMzixrk5y7ZgO75udLR6cvkHU3Ewzag0kKdSZQHgRU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPCiWnt6Xmfe//0SsgsPvp8vX9PMHsCZMXLWA7IVZVe
 VE4U2Rlx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiInRpjw0xW8fxm85r1u/80
 We2JsHJaIVZiLmi302H2zfKX6g/CjEyl9ctlHmY7CnpElJ3b83giY8Opji/HNrVFC0X/b5EIdd4
 VYxffIKv9Y4KYMJv/x/vf5i/+VrJrb0Zv/faMA9u7xKdsegIA
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

drm_atomic_get_crtc_state() allocates a new CRTC state by duplicating
the current one and inserts it into the atomic commit as a single
operation.

However, a later change will need to insert a CRTC state into a
commit without going through the full allocation and duplication path
in drm_atomic_get_crtc_state().

Extract the state insertion logic into a new static
drm_atomic_commit_set_crtc_state() helper, and convert
drm_atomic_get_crtc_state() to use it.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 80436adcfb7f..178eca95d0e3 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -434,4 +434,19 @@ void __drm_atomic_commit_free(struct kref *ref)
 EXPORT_SYMBOL(__drm_atomic_commit_free);
 
+static void drm_atomic_commit_set_crtc_state(struct drm_atomic_commit *commit,
+					     struct drm_crtc *crtc,
+					     struct drm_crtc_state *crtc_state)
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
+}
+
 /**
  * drm_atomic_get_crtc_state - get CRTC state
@@ -456,5 +471,5 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
 			  struct drm_crtc *crtc)
 {
-	int ret, index = drm_crtc_index(crtc);
+	int ret;
 	struct drm_crtc_state *crtc_state;
 
@@ -474,9 +489,5 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
 		return ERR_PTR(-ENOMEM);
 
-	state->crtcs[index].state_to_destroy = crtc_state;
-	state->crtcs[index].old_state = crtc->state;
-	state->crtcs[index].new_state = crtc_state;
-	state->crtcs[index].ptr = crtc;
-	crtc_state->state = state;
+	drm_atomic_commit_set_crtc_state(state, crtc, crtc_state);
 
 	drm_dbg_atomic(state->dev, "Added [CRTC:%d:%s] %p state to %p\n",

-- 
2.55.0

