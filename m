Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622F606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNToh6hZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCF110FFE5;
	Thu, 29 Oct 2026 07:35:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25BC10FFDE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB3BE409CD;
 Thu, 29 Oct 2026 07:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AF81F01825;
 Thu, 29 Oct 2026 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259314;
 bh=sWU1AmkZw7Da32gb/gs8zA5lzjtpXDFSEJ1my4ZljNg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hNToh6hZh9kc+2qxaV3Wa5233C2u+W/ZHO3eBh4xpOyrrZoUo3MHe32iYswOZpTHD
 dTg3SfVECrybqJW/WGoOtSo6uRLUYxH2XTtApCaJPctIiS+G03QBGVX4ZdPmOU87nE
 mkn8AzTuZbv34C0Zjk5qBbjFXxgxyNIHIOH7cchf9pPwMgNX8IXqADrjof3za17Wjh
 Puo7K2stv7yyo+D5xycImFT9m2hQPhk76xzQn4RJ0d43oiDiU7PwEzWYnytPMeWW+2
 nu8Ic3A1L5gypAOPSwIb+8JurW+Kxrq0Hn1xutz05eUb8FUVt/byUY1GPPBnOcalbH
 RJ+fKDQAwRfuw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:04 +0100
Subject: [PATCH v7 14/34] drm/atomic_sro: Create documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-14-25e5163d75c3@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3505; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3P6xBCCCGXSqSWvHpG4U1kTfJgXPgndSWEdhfvEneVo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn2qsu7doubitebnpsycF05cQRHRWwzDXWXsnqo8r
 PzEME2jYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykRZyx3sOCbWYQ7+o/E+we
 sZ9eP9HP9NrWyr9/2KTq13qeOWixYO7js+sdz7+penCX+/IhCyeGzYwNP2q2T2fvT/ZeLmPhL1X
 xy/J0ON+/oJY1QU53otbUH5q8/U9k7PZ7lXMOXey9ulPHc6UpAA==
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
index a5bc77b3e492..413823579ed5 100644
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
 enum drm_atomic_readout_status {
 	DRM_ATOMIC_READOUT_DISABLED = 0,

-- 
2.55.0

