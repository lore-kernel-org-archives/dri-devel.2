Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB3606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GV3clkXD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2028A10FFCD;
	Thu, 29 Oct 2026 07:34:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EFA10FFD3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85BED40D82;
 Thu, 29 Oct 2026 07:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94931F01825;
 Thu, 29 Oct 2026 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259278;
 bh=f1WkC3AfDhND3JpZOPFFjzESvRxHLLmL/xRwaQ0a7kk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GV3clkXDGwBoM6pduYpnfjPn3GzpL/N1ius/H2HiJN5dqYBAFPf5M0E0F7aH6bI38
 VRbTC5wB6Y4/q0+ZOfb9Dp2dEFek+f83mszKMp7qS94xPBcrsBTctadqOiXwLFK9y/
 jflnql6PBtICJ31gTeaF6m/aXqDE88ZxWKu3txwdnJgHN7V5ClsGxH55M0vzB1+tfA
 BJpIzK3U14p+VUP0ZDWMYUD5ILjBDTOEC044zq772bxrbQ+4QdAdX/DNAS2271N0cu
 Yuxvq63g1LrS2b3llsw6UzfwA4+e8UoH3rpQaBUbhUtWOVYay7AWCg2WBxiFOskjbm
 BMSirgvSe8TpQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:33:54 +0100
Subject: [PATCH v7 04/34] drm/atomic: Fix private obj error handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-4-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Kd17jaZJ95O3EgD0fvrRdABEGQDu0lBipqkURcQshM0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvr3zuTT7Vq9VUtq+v+86Jj4pmeFV9qQ4dp3CsvPMx
 yzTnr2w7ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+fyQsT4gKIvbmkPRp+yS
 ZmNFKKPyv6ZLR1+FmnH3LZ46Q/2mge27EmYfzcUM5x+ZbtvpGCvWyFgrfZHbaOl+btkfdh7bz03
 esrX5yQOerlPTjyzY2KbetoWt56HEfccFtrypa0O5wvdKbJoNAA==
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

drm_atomic_private_obj_init() initializes the modeset lock and adds the
object to the privobj_list before calling atomic_create_state().

However, if atomic_create_state() fails, the function returns the error
directly without removing the object from the list or cleaning up the
lock. This leaves a dangling entry in privobj_list and a leaked lock.

Fix this by unwinding both operations in an error path.

Fixes: b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9bb761eda59f..8f9b17395b90 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1030,6 +1030,15 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 {
 	struct drm_private_state *state;
+	int ret;
+
 	memset(obj, 0, sizeof(*obj));
 
+	/*
+	 * Keep the list node in a state drm_atomic_private_obj_fini()
+	 * can safely handle if we fail before adding it to the private
+	 * objects list.
+	 */
+	INIT_LIST_HEAD(&obj->head);
+
 	drm_modeset_lock_init(&obj->lock);
 
@@ -1039,10 +1048,17 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 
 	state = obj->funcs->atomic_create_state(obj);
-	if (IS_ERR(state))
-		return PTR_ERR(state);
+	if (IS_ERR(state)) {
+		ret = PTR_ERR(state);
+		goto err_list_del;
+	}
 
 	obj->state = state;
 
 	return 0;
+
+err_list_del:
+	list_del_init(&obj->head);
+	drm_modeset_lock_fini(&obj->lock);
+	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_init);
@@ -1057,4 +1073,13 @@ void
 drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 {
+	/*
+	 * Some callers ignore drm_atomic_private_obj_init() failures
+	 * and unconditionally register a teardown action that calls
+	 * this function. Make it idempotent so a failed init followed
+	 * by fini does not cause a double list_del.
+	 */
+	if (list_empty(&obj->head))
+		return;
+
 	list_del(&obj->head);
 	obj->funcs->atomic_destroy_state(obj, obj->state);

-- 
2.55.0

