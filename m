Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93E606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpSrSTW9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C9411204E;
	Fri,  6 Nov 2026 13:17:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADE810EA0E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 537414188C;
 Fri,  6 Nov 2026 13:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56751F0089F;
 Fri,  6 Nov 2026 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970922;
 bh=myAjFqZu7a5de0oww4kgYmP111C92VmIrkUhhg2hJ7M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QpSrSTW9C/nZdEwvbf/77wgsxFNWV+psC/rWbT3pOrggUVzvmbo5R1grtBWbKBLNZ
 NPGoUTdVXlVKsxfk0DMRWgwBPlIZcSgZewYVuEOKyMKWkPSG9NibD9RKaPEZP3htzK
 l2H2RdwY2vrb1TQTRjD5v5Z5Z/EkBFZRDEZyOiXplMVhC6QyYQW7azmvCbYi6l0E8a
 6a74gRk5oSS+/oQcMRqwj8IIbVR8hCbvpgW4cHxignxYVEbz0WEBPtoUm78NrVuga4
 TUaGBH2smgQDZFgFmoIGT8itdXfNS+2At/gtrp1zRQkK1rygYlvz3A/qN8Z6aO6a+e
 3tk8werHVnKyA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:24 +0100
Subject: [PATCH v8 11/39] drm/gem-atomic-helper: Handle framebuffers
 without a GEM object
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-11-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=mripard@kernel.org;
 h=from:subject:message-id; bh=d4LnqSojmsuNGIwnBQCAjx7dqIFwcU5h6vsWpvRz+5A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL23Men628c1TldZV37/xF8QvnGNdxzn/7rYX3mcSV
 07eGffuSMdUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYSP9WxjprJeNYBh4zG6EP
 2n/ftve/0OpfEDHnapPubWlz96+JbvZbZjCwrFuYVHH/wVXj/3/CzzA27O+Z8p/FTNaFXc74yYK
 QmtSW61Pe70p69CS71ur31YBfU+fWeqcLXGGYb5Jin+S6ZMMnAA==
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

A framebuffer reconstructed from a hardware state readout describes a
buffer that the firmware allocated, outside of the kernel memory
allocator, so its planes have no GEM object attached.

drm_gem_plane_helper_prepare_fb() retrieves the GEM object of every
plane through drm_gem_fb_get_obj() to extract the implicit fences from
its reservation. For a readout framebuffer, this triggers
drm_WARN_ON_ONCE(!fb->obj[plane]), returns NULL, and fails the whole
commit with -EINVAL.

This can be hit as soon as the state readout installs such a
framebuffer on a plane: any commit that includes the plane without
userspace providing a new framebuffer will duplicate its current
state, readout framebuffer included, and run prepare_fb() on it.
Blanking the display through DPMS right after boot is such a case,
since it pulls the plane in through drm_atomic_add_affected_planes().

Access the framebuffer obj[] array directly and skip the planes
without a GEM object: there is no reservation to extract implicit
fences from anyway. This mirrors what drm_fb_dma_get_scanout_buffer()
does for such framebuffers.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index c952cfed84c1..bab354d12fe7 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -138,11 +138,15 @@ int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 
 	for (i = 0; i < state->fb->format->num_planes; ++i) {
-		struct drm_gem_object *obj = drm_gem_fb_get_obj(state->fb, i);
+		struct drm_gem_object *obj = state->fb->obj[i];
 		struct dma_fence *new;
 
-		if (!obj) {
-			ret = -EINVAL;
-			goto error;
-		}
+		/*
+		 * A framebuffer reconstructed from a hardware state
+		 * readout has no GEM object backing its planes, as it
+		 * describes a buffer allocated outside of the kernel:
+		 * there is no implicit fencing to wait on.
+		 */
+		if (!obj)
+			continue;
 
 		ret = dma_resv_get_singleton(obj->resv, usage, &new);

-- 
2.55.0

