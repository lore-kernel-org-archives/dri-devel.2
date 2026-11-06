Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC52606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4s8PBd2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A6D10EA1C;
	Fri,  6 Nov 2026 13:15:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA2710EA28
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F8BC6020F;
 Fri,  6 Nov 2026 13:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430D01F008A1;
 Fri,  6 Nov 2026 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970943;
 bh=WnlQgXv6wsILtew7P1+DbGLBlMBDIykxpn9KD/zk9s8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=F4s8PBd2E1ouzPWRYLcUKYIpnkv0AXnJ+4PN/WJaGdC4NfvmDr0lco5H8476Bcqtz
 5L83MBfPT5vyOjycSW/eNSxuQoOBq/3YPmoqsx2iZmM1j+R4Hfqj0wSIRjr40g4bay
 bVWpe6A/X9L/ifiqG73PMYnkahnIS7c4b78QEr/Smmvao2/bwjwSR1bn/NZjkm3AwS
 6HkgtbdG+0xRI4QtDMWJTBb2YPOsJNg4C3e5OXLZCbo7AvBqGNydTiveebUZZZNjrF
 t0RUSoh/M5krWgIKvcnLiEHq45j19N+pFBoXvTdH0YLpX+iG/MMOyNBRgSyWaMrgzI
 Au9jeRRzBrIAg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:30 +0100
Subject: [PATCH v8 17/39] drm/atomic_sro: Create documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-17-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3552; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zdVueWHQub7aVZv5znC7EbAZZleq66pYkvIye0lUaPs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL23pOjI5dsGZmxvsJ+0+XbVro4V/8emY2l2LTePrn
 x3etDtjZ8dUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYyM2XjA3Tly+adydTv9go
 82zXgt0foowb+83TFLZri7ismrCa792zU/92KT8/lL9DzU3/4TPptwqMDfcisrZcdJWIX+mkwd/
 w/1Gn1yYlp3SLuKYm6czNC9zLko/3Ljp8/oK1/r+lvw4fPnjWCQA=
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

The SRO infrastructure has grown to span multiple files and hooks
but lacks an overview section explaining the overall design and how
drivers should integrate with it.

Add a DOC: overview section to drm_atomic_state_readout.c describing the
various SRO phases and how drivers wire up the callbacks.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/drm-kms-helpers.rst      | 17 ++++++++++++++
 drivers/gpu/drm/drm_atomic_state_readout.c | 36 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index d64f941d34f5..b75bde712faf 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -83,4 +83,21 @@ Atomic State Helper Reference
    :export:
 
+.. _drm_atomic_sro:
+
+Atomic State Read-Out
+---------------------
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic_state_readout.c
+   :doc: overview
+
+Atomic State Read-Out Reference
+--------------------------------
+
+.. kernel-doc:: include/drm/drm_atomic_state_readout.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic_state_readout.c
+   :export:
+
 GEM Atomic Helper Reference
 ---------------------------
diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index de0f27186bea..d0f8665860ff 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -16,4 +16,40 @@
 #include "drm_crtc_internal.h"
 
+/**
+ * DOC: overview
+ *
+ * The atomic State Read-Out (SRO) infrastructure allows drivers to
+ * initialize the KMS atomic state from the hardware state left by the
+ * firmware at boot, rather than programming a new state. This enables
+ * flicker-free boot (also called "fastboot" by i915): if the
+ * firmware already configured the display, the first userspace
+ * modeset can be skipped when the requested mode matches.
+ *
+ * The SRO lifecycle has two phases. The first phase is the readout
+ * itself: at driver registration time, each KMS object (CRTCs, planes,
+ * connectors, bridges, private objects) has its
+ * atomic_sro_readout_state hook called to populate a
+ * &struct drm_atomic_sro_state from hardware registers.
+ *
+ * The hardware may have been programmed with a configuration that
+ * the driver doesn't support. The readout hooks are then expected
+ * to return a negative error code, and the state initialization
+ * will fall back to the regular path.
+ *
+ * The second phase is the installation. Once all states have been read
+ * out, drm_atomic_sro_install_state() walks through the
+ * &struct drm_atomic_sro_state and assigns each readout state as the
+ * object's current state. Before doing so, it calls the optional
+ * atomic_sro_install_state hook on each object. This gives drivers a
+ * chance to acquire the resources needed to keep the hardware state
+ * active, such as power domains, clocks, or interrupts. This hook
+ * cannot fail.
+ *
+ * Drivers integrate with SRO by implementing the readout hooks in their
+ * object funcs vtables and setting the
+ * &drm_mode_config_funcs.atomic_sro_readout_state and
+ * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks.
+ */
+
 static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
 module_param_unsafe(atomic_readout, uint, 0400);

-- 
2.55.0

