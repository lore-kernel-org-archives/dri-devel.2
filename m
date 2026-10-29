Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDA606A326
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUQh6vQm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6651110FFE2;
	Thu, 29 Oct 2026 07:35:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4EB10FFD3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2ED14600D1;
 Thu, 29 Oct 2026 07:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD141F01825;
 Thu, 29 Oct 2026 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259292;
 bh=36LbEfjymQdlvpApF+dR5BGReUwtF/eBUGdBaaM+mJ8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lUQh6vQmDErBWN5fPne0aXFGeTL6Kl68NjTB0pz6+HLHTpJZcgC5zJNGZZ3Exf321
 q1cPPmaV/seYDfx2oa4aFd+T+cqBHPgNpcsk5Xh+KYPAU3fE5YW5Zo/GvNa9pcCO6l
 mxHJ5IRolHvurwfh9T0+/AN0P+KkZSdRBgBeEDwIkTlTAocf4wWmSA2rQkRvTFAvCv
 h63KqpIgxWIRyxSxeoYkk57CUOjS8Y7kQqKAudIVVn37PQHJHwX/773j/AcQmEJbcq
 HAzAyJUcAawHrGmSTXMb8OYnCerVJ4fk1Kv9hlfY6DEm1ChNCrV+oPGtBEcMvzBT8Z
 0R+4UpHswcXRA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:33:58 +0100
Subject: [PATCH v7 08/34] drm/fb-dma-helper: Handle framebuffers without a
 GEM object
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-8-25e5163d75c3@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fb4W1U93Je4A6XGffFp5RAQ5r71xg/Q1Zxy3ov8fdaI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn1wqPnVfq4vaeOvrXtYTzy1Mr4159vVJMNTF3L6W
 da95Lue0TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmoq/H2HA5aat+xZP/U666
 Rf27aSXdzfIsSWeSylaeP13WISuY7vH+XxQt7+98KXjjtYgVToJG5xgbpkzxmL1j9l5BI1dD9++
 +tQcjj14Sr/MQnr3+yt092svWqnMJdEmGrute03hnkuKOzcXNAA==
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
 drivers/gpu/drm/drm_fb_dma_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index fd71969d2fb1..3a37253ab9f8 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -180,4 +180,12 @@ int drm_fb_dma_get_scanout_buffer(struct drm_plane *plane,
 	dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
 
+	/*
+	 * The framebuffer has no GEM object backing its first plane,
+	 * like a framebuffer reconstructed from a hardware state
+	 * readout: we cannot access its contents.
+	 */
+	if (!dma_obj)
+		return -ENODEV;
+
 	/* Buffer should be accessible from the CPU */
 	if (drm_gem_is_imported(&dma_obj->base))

-- 
2.55.0

