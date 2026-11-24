Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07933606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLOV68zx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396E310F4AD;
	Tue, 24 Nov 2026 11:00:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF6810F48F;
 Tue, 24 Nov 2026 11:00:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B84E94163E;
 Tue, 24 Nov 2026 11:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DE91F000C0;
 Tue, 24 Nov 2026 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795518014;
 bh=9v3M2+kIb8n5isYUqt3mFrCm21SodWkRxV/rD8HgSa8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JLOV68zxt4P92CNsM/QplZt64pmkFJWU0chdIfgpZR/hqT/x/6v5mm5fUd0cn28D+
 aiOEBrXxdNL4D8FInrmE7ih9uWC8sXy5zk00pWlVT4Qh+qBZg2rmqh3zYk+vJCE5/E
 rqsfGcqTZiIFzaeZtbcFT+N5nHNUhBNiEmvmR+1lG5V/xa6Gwi71d0v2/iapdz2y9B
 qoU0svh58K1ZQ3y/39TGx67EuX/Dox97G7VLZbmrraUQvfgPs+ONw6k6TuBbi5pT0o
 YGUABiY/Z6C9K6b5FNS7+15YaMENjRRXRsD0Xn/cthpXy7MpdOZSvkNY06QEmKo8dc
 8AkHhhZJaWv+w==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 24 Nov 2026 11:59:53 +0100
Subject: [PATCH 3/6] drm/i915: Implement CRTC atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-drm-i915-conversion-state-readout-v1-3-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ELpcjgwoHq2tA1t5kCpFaFaR2ts4BqTosRjTFBECnKE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmsebpL+5ctbhZ+8/vqh6rXrxexT3JZM71m9aoVGg1u5
 62ORms3dUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ3C1lrC9I+f6A/1OE2vqZ
 folPQnl9IrdEMqiw1XbzNfVK5d03OfDb4LF7pLlR8XPlsEmVT8wOMDZc1Arkf/D/UItS362MPS+
 c6nfxLiszmVyW+jj1qmeM9jO9VQL7vCL+7c833vQiKM+E8x4A
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

The atomic_create_state callback allocates a pristine, initialized,
state for the object it is called on, without any side effect.

The upcoming DRM_MODE_ATOMIC_RESET flag of the atomic ioctl relies on
it to bring the whole device back to its default state, by filling a
commit with such states through
drm_atomic_commit_fill_with_defaults(). Both the reset itself and the
DRM_CAP_ATOMIC_RESET capability reporting are gated on
drm_atomic_implements_create_state(), which requires every plane, CRTC
and connector of the device to implement the hook: without it, the
reset is rejected with -EOPNOTSUPP.

The other atomic_create_state() users don't apply to i915: it reads
the state the firmware left behind out of the hardware at probe time,
so it never goes through drm_mode_config_create_initial_state() nor
the hardware state readout helpers. The atomic reset is thus the only
user the hook enables here.

The i915 CRTC functions don't implement it, relying on
intel_crtc_state_alloc() being called directly instead. Since
intel_crtc_state_alloc() already allocates and resets a state, wrap it
in an atomic_create_state implementation and assign it to the CRTC
functions.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_crtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 10ed9bdfee76..7bb3caf91310 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -175,10 +175,21 @@ struct intel_crtc_state *intel_crtc_state_alloc(struct intel_crtc *crtc)
 		intel_crtc_state_reset(crtc_state, crtc);
 
 	return crtc_state;
 }
 
+static struct drm_crtc_state *intel_crtc_create_state(struct drm_crtc *crtc)
+{
+	struct intel_crtc_state *crtc_state;
+
+	crtc_state = intel_crtc_state_alloc(to_intel_crtc(crtc));
+	if (!crtc_state)
+		return ERR_PTR(-ENOMEM);
+
+	return &crtc_state->uapi;
+}
+
 void intel_crtc_state_reset(struct intel_crtc_state *crtc_state,
 			    struct intel_crtc *crtc)
 {
 	memset(crtc_state, 0, sizeof(*crtc_state));
 
@@ -241,10 +252,11 @@ static int intel_crtc_late_register(struct drm_crtc *crtc)
 
 #define INTEL_CRTC_FUNCS \
 	.set_config = drm_atomic_helper_set_config, \
 	.destroy = intel_crtc_destroy, \
 	.page_flip = drm_atomic_helper_page_flip, \
+	.atomic_create_state = intel_crtc_create_state, \
 	.atomic_duplicate_state = intel_crtc_duplicate_state, \
 	.atomic_destroy_state = intel_crtc_destroy_state, \
 	.set_crc_source = intel_crtc_set_crc_source, \
 	.verify_crc_source = intel_crtc_verify_crc_source, \
 	.get_crc_sources = intel_crtc_get_crc_sources, \

-- 
2.56.1

