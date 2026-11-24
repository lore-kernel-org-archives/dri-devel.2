Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10817606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=eOFuwJSc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD0210F835;
	Tue, 24 Nov 2026 18:18:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00D010F039;
 Tue, 24 Nov 2026 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=Y9n7UOhXe/wOeOulFkE7hxZ1zdEblzpuy83y2wLMkL4=;
 t=1795544289; x=2110904289; b=eOFuwJSca+NI5RByCj3J2urmLU5anhmoeJ7LhnJsdWi0con
 HzjGpUOft4DTtQOZ6mnnxRb8Kji3/HJ+xe571c7ub/CFozvyGMa+7gK1q6YOarMcG0iWotc84rpcx
 wrlA4xHbtuCpylZJjatU1V0Va/oO9AVOME3CbGxwZHEfiemY2IPZY48d1w5xKuoyFz4SRCKK/WhpU
 DRRNsE7n/TDcpaXKtO41lUp9oZK7QpOYvGP45LMOPDtwTqzoOdKCvZ9+pedoLGTVyEYVei8/V1Etk
 K7nXZPlUJWuXy65YYKdbWfjZvlBoyaJIbDkYUBeLzkz/lGCfmdq9tJrh+f5Vs0hA==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5d-00000003axM-1qLw; Tue, 24 Nov 2026 19:18:01 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 nfraprado@collabora.com, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Daniel Stone <daniels@collabora.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 03/19] drm/atomic: handle CRTC colorops in
 drm_atomic_commit_set_colorop_state()
Date: Tue, 24 Nov 2026 19:03:20 +0100
Message-ID: <20261124181652.1333986-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 259907fef771 ("drm/atomic: Create function to insert colorop
state into a commit") asserts if the lock of the plane colorop is held.
Now that a colorop can be also parented by a CRTC, colorop->plane is
NULL for a CRTC colorop and drm_atomic_commit_set_colorop_state() has to
check the CRTC mutex instead of plane mutex. Update the helper to assert
the lock of the object that owns the colorop.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- new patch: adapt the lock assert added by commit 259907fef771 to
  colorops parented to a CRTC
---
 drivers/gpu/drm/drm_atomic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index e72e5e7ee76b..6d608795f28b 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -710,7 +710,10 @@ static void drm_atomic_commit_set_colorop_state(struct drm_atomic_commit *commit
 {
 	int index = drm_colorop_index(colorop);
 
-	drm_modeset_lock_assert_held(&colorop->plane->mutex);
+	if (colorop->plane)
+		drm_modeset_lock_assert_held(&colorop->plane->mutex);
+	else if (colorop->crtc)
+		drm_modeset_lock_assert_held(&colorop->crtc->mutex);
 
 	commit->colorops[index].state_to_destroy = colorop_state;
 	commit->colorops[index].old_state = colorop->state;
@@ -725,8 +728,8 @@ static void drm_atomic_commit_set_colorop_state(struct drm_atomic_commit *commit
  * @colorop: colorop to get state object for
  *
  * This function returns the colorop state for the given colorop, allocating it
- * if needed. It will also grab the relevant plane lock to make sure that the
- * state is consistent.
+ * if needed. It will also grab the relevant plane or CRTC lock to make sure
+ * that the state is consistent.
  *
  * Returns:
  *
-- 
2.53.0

