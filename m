Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9FDCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C406210E95A;
	Thu, 15 Oct 2026 15:10:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E94710E95A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 771A54186C;
 Thu, 15 Oct 2026 15:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A9B1F000C5;
 Thu, 15 Oct 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076991;
 bh=juPQSdYWs4yqHi+IwCJ1wgBuauiKMdrN1tAg8sExDyM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GBehS+0Dd5hBJWV0+00TtjghjXoL+BM0rJb39ikJNs7TDuKr2KpSpIu4CKDHIEZSp
 xjo/Q5oRFXv7vwbewXh5hVF7LEC85HaWxt9TuNEXDbRVJSZPLj13vlx3Nr7SlJJugP
 9GwwUuun9j62PsdSsnLbNgdgEdFxsjf7iXX7DPB7LDk7ykYrTGTCt4RvCg/EXyjcJT
 yQWfnUB60wcdfK93ieTiuQisYGwbgrYn8RDpcZC4peGucFojW/7LNhgiPksUnTa+LD
 DNwXTZLhvrlW0zEVyhltu0YUqRs74tw44ilnI0xUrAfypvJ4C0SkSb1eTmyuUrnT8k
 1EcwSzGW/YTPQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:02 +0200
Subject: [PATCH v6 10/28] drm/atomic_sro: Create documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-10-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3456; i=mripard@kernel.org;
 h=from:subject:message-id; bh=i3WNBEPJmqHRMqmhvWJsJ+gIVnJqtQsJk/5fJIB2FYI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3vSpdv+MnishdkJd3DdcN7/o1OX2Wr/KRZzzpfaHW
 Wbt+BrdMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbCbclYZ9oftH3vrbPWdi3T
 L3ImXC5Zy7XTnGO26pH+Z9YXnnAeqdi8+p2x/YIleZNn6x+/1Wh9iLFO6565aOK0TZHvbG8Z7H5
 /tU6xrnKaZOpS9u03OB9/Vbfcw7A/fUGh+qaZ/8+L/t7ndtoTAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The SRO infrastructure has grown to span multiple files and hooks
but lacks an overview section explaining the overall design and how
drivers should integrate with it.

Add a DOC: overview section to drm_atomic_sro.c describing the various
SRO phases and how drivers wire up the callbacks.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/drm-kms-helpers.rst | 17 +++++++++++++++++
 drivers/gpu/drm/drm_atomic_sro.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index d64f941d34f5..cba1722a2c91 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -80,10 +80,27 @@ Atomic State Helper Reference
 -----------------------------
 
 .. kernel-doc:: drivers/gpu/drm/drm_atomic_state_helper.c
    :export:
 
+.. _drm_atomic_sro:
+
+Atomic State Read-Out
+---------------------
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic_sro.c
+   :doc: overview
+
+Atomic State Read-Out Reference
+--------------------------------
+
+.. kernel-doc:: include/drm/drm_atomic_sro.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic_sro.c
+   :export:
+
 GEM Atomic Helper Reference
 ---------------------------
 
 .. kernel-doc:: drivers/gpu/drm/drm_gem_atomic_helper.c
    :doc: overview
diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 14fddd760165..6cd002e857d9 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -12,10 +12,41 @@
 #include <linux/module.h>
 
 #include "drm_internal.h"
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
 	DRM_ATOMIC_READOUT_ENABLED,
 	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
 	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,

-- 
2.55.0

