Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564960A2617
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1IKzDhM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F301129E5;
	Fri, 20 Nov 2026 12:56:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F3A1129D4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2E14623FE;
 Fri, 20 Nov 2026 12:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BFD1F000D2;
 Fri, 20 Nov 2026 12:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179354;
 bh=tJQfQC0KQHwZV8PfBsIz1xeE0undi8p8x3p6IFO6IPk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Y1IKzDhMMyBIYtC759bpXsTHFOG9ouGm6/sfdTtzkGIbtMl5wF4cCCfCh6fkr24O5
 YkF3FxjnTOlqmWupW3Wtd0dw3uzK8kBsAXgJ5dl6leln/6QJ9fTMTY6QDkrmshvnpL
 jyOiMgZxR7t51P4MyJBlxMMI9YkYgmGf5NxCKbWhlk+tOcH7TqBJXx0ZNV4QBx6yvQ
 EW5sh0rR2PeZPEhQk2DHsB6CDddNO49YP5QvAAPWQ0/v5X2kMglMZXw0ALFFBJbbPR
 ke2i/cpt8PYYEmAGCd6nJc9aRvJGBHo63c+Tuhs6Biw2MqkHQ7QZto1LSTzKpiC7Vr
 Av3qh8LNGaARQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:02 +0100
Subject: [PATCH v9 10/42] drm/fb-dma-helper: Handle framebuffers without a
 GEM object
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-10-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0w3DyeZyOJODOyJrdzQDSWxJ8+D3huOZMzCGgXcRnG4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzur7A5+ovov8Wte8IuX3nwdalrNLb5U0JinsvtM7U
 UD/nKxNx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIRyRjfb26W6db8ZUW3ole
 k9g9997z+fG+8X2FZe6KtTEau03uGx1W6ry1cHedroL56h8fLjbtZGz4v1Ora/JVxq9Cm2cknJy
 kFSm7dQ3TvEm8rzadSJh14/eDozm7d/SkCTz+IVK1lWFX6IOHAA==
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

The state readout documentation now states that a driver should
return an error when the hardware was programmed with a
configuration it cannot represent, so that the state initialization
falls back to the regular path.

However, a readout can also succeed with objects that cannot be
fully reconstructed. The framebuffer the firmware left in the
hardware was allocated outside of the kernel memory allocator, so
drivers won't have any GEM object to attach to its planes.

drm_fb_dma_get_scanout_buffer() dereferences the GEM object of the
first plane to fill the scanout buffer description used by
drm_panic, and would thus crash during a panic happening before
userspace had a chance to replace the framebuffer read out from the
hardware state.

Return -ENODEV for such framebuffers, like we already do for
imported buffers that are not accessible from the CPU.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index fd71969d2fb1..e24036e1f3ba 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -175,10 +175,20 @@ int drm_fb_dma_get_scanout_buffer(struct drm_plane *plane,
 	fb = plane->state->fb;
 	/* Only support linear modifier */
 	if (fb->modifier != DRM_FORMAT_MOD_LINEAR)
 		return -ENODEV;
 
+	/*
+	 * The framebuffer has no GEM object backing its first plane,
+	 * like a framebuffer reconstructed from a hardware state
+	 * readout: we cannot access its contents. Check the framebuffer
+	 * directly, since drm_fb_dma_get_gem_obj() warns about a
+	 * missing GEM object.
+	 */
+	if (!fb->obj[0])
+		return -ENODEV;
+
 	dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
 
 	/* Buffer should be accessible from the CPU */
 	if (drm_gem_is_imported(&dma_obj->base))
 		return -ENODEV;

-- 
2.56.1

