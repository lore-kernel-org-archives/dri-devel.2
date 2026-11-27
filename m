Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB69606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEhCbj6d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC64911292C;
	Fri, 27 Nov 2026 09:55:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2720810E56B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F97661DD7;
 Fri, 27 Nov 2026 09:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DF1F00899;
 Fri, 27 Nov 2026 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773261;
 bh=neKriUD3qBIOmjAzyyooHRmh3hRlYJ6dSF3StSzf0ak=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HEhCbj6dBdKUvRJq2i0JqJqpL92j3tYDTEvJUdxM3bxJ+ZzHa5NVfDmA3G52VaNvr
 AfCAw5+0rqFPXy/8owX6UJWaVDDvCtHnAkj+l7bpfRBYGkCGOFw1J5ye6qa6cDP9yw
 Pl+0MvnFN1CtfwOjgWubLFZAgkqVYD2NnOje8wRrKKYoL0mI5hXY5wJdi+omTpaZwp
 ywPQuo08OirSi2TymZ6cwvDSvWTqRmrhzre1fT3G+adjUrovhDbZ2ajLTX5FUDl1qF
 5MdR0Bw1ER+qkZA+GoKsHzdKcR/w1+kNTkWb7TUvEgfD/6KC5MG/raiMakpoTjziJ1
 7HRSzTaXr3RZw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:00 +0100
Subject: [PATCH v10 18/36] drm/atomic-helper: Document State Read-Out as a
 state initialization approach
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-18-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sBvOfWw+zOrwmSX/+Uj6dWOQFgeZwg5EoiBwGvMzbcY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwSyr9pz48Gnps82v1kR9O9pwOWLyeiX16iBlo3NiN
 7lWe3S2d0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJZPIx1qmldnyoOBD9vU2k
 bd6lrzzb/Rc8/7n6+jY1Zok7rInbDtqVzY7iSmUO0ZcxlP23slw+jbFOM6XwhMjvk8Hbp/cFJvG
 tvn/Hd73Nic0bc+V/L7ffdcx03cYbi78ejua1KXmXOuV6XK8XAA==
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

The "atomic state reset and initialization" DOC section describes the
problem of needing correct atomic state at driver load and after
suspend, but only mentions the reset approach and a vague reference to
i915's read-out as an alternative.

Now that the State Read-Out (SRO) infrastructure provides a generic
solution, update the documentation to describe both approaches and
cross-reference the SRO section. Also mention
drm_mode_config_create_initial_state() which combines both.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 267f44330629..c5bf70e6ad53 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -45,17 +45,25 @@
  * DOC: atomic state reset and initialization
  *
  * Both the drm core and the atomic helpers assume that there is always the full
  * and correct atomic software state for all connectors, CRTCs and planes
  * available. Which is a bit a problem on driver load and also after system
- * suspend. One way to solve this is to have a hardware state read-out
- * infrastructure which reconstructs the full software state (e.g. the i915
- * driver).
+ * suspend. There are two ways to solve this:
  *
- * The simpler solution is to just reset the software state to everything off,
- * which is easiest to do by calling drm_mode_config_reset(). To facilitate this
- * the atomic helpers provide default reset implementations for all hooks.
+ * The first is to use the :ref:`State Read-Out (SRO) <drm_atomic_sro>`
+ * infrastructure to reconstruct the full software state from hardware
+ * registers. This enables flicker-free boot when the firmware already
+ * configured the display.
+ *
+ * The simpler alternative is to just reset the software state to everything
+ * off, which is easiest to do by calling drm_mode_config_reset(). To
+ * facilitate this the atomic helpers provide default reset implementations for
+ * all hooks.
+ *
+ * drm_mode_config_create_initial_state() combines both approaches: it tries
+ * SRO first, and falls back to a hardware reset followed by
+ * drm_mode_config_create_state().
  *
  * On the upside the precise state tracking of atomic simplifies system suspend
  * and resume a lot. For drivers using drm_mode_config_reset() a complete recipe
  * is implemented in drm_atomic_helper_suspend() and drm_atomic_helper_resume().
  * For other drivers the building blocks are split out, see the documentation

-- 
2.56.1

