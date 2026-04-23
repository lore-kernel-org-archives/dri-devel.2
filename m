Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBE9F99367
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F3C10F04E;
	Thu, 23 Apr 2026 10:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SXwF7bUa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F1A10F04E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 18F44439ED;
 Thu, 23 Apr 2026 10:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDC7C2BCB6;
 Thu, 23 Apr 2026 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938878;
 bh=ew/vbK19D1rti39ABVjAa+5wPwF9OUKTQzsxF5sO9ZM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SXwF7bUabYSvCEucnke2OsB8TE+1WckdMsC/8MTikOzlOLDEFze82n9ANrOcktn+w
 40eo35XdvvC9sZaPuHPI6druqXRxcOEHf5vduP3UzQEC9y7e+ZUVnkQp6iVHaTZoXz
 8fDNTuKhRAgv0j8EHfBCangrkyscySNd1lpaCM2Iq/ZCUhhrVkbQHPMrWlsTkO2gW/
 lqU6hS3YQfXvDqQaIibvw0W7xCrI0Y3RqEteDs5ApgqKqxAleVbTM3bkutsJCa3I4l
 B08slY2oPqZRZNcufg2zVO6hWhuC3hO/YKCYpr6wv2wwDXgeaRn+qaI6OZ7d7NMLuM
 RvacBEqeZMZGA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:52 +0200
Subject: [PATCH v2 14/28] drm/atomic_sro: Create documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-14-6cde1a9910ed@kernel.org>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ew/vbK19D1rti39ABVjAa+5wPwF9OUKTQzsxF5sO9ZM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv3/usVFvnsvTl/MYujU1eX35OY+5x2+SXweHuWsi+m
 DtQvUWoYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwkJJex4ZmhmQbLvE1hKadK
 xCy2Z2lnbxRyLY6qfTL3QYa0uf7SE6EHg3hsuaun1+aflNjJezSbsc60x2i/iajGmZkzenYpH7z
 4Tv/3YYfo1f8/XBG7alNhrbnUoulc0PyYuxF/Vc6H9Tv+1AQA
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
 drivers/gpu/drm/drm_atomic_sro.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
index 7ff67c140ff2..0e62e9d22ecc 100644
--- a/drivers/gpu/drm/drm_atomic_sro.c
+++ b/drivers/gpu/drm/drm_atomic_sro.c
@@ -12,10 +12,44 @@
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
+ * Drivers integrate with SRO by implementing the readout and compare
+ * hooks in their object funcs vtables and setting the
+ * &drm_mode_config_funcs.atomic_sro_readout_state and
+ * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks. The
+ * default helpers drm_atomic_helper_sro_readout_state() and
+ * drm_atomic_helper_sro_build_state() handle the standard readout
+ * sequence.
+ */
+
 enum drm_atomic_readout_status {
 	DRM_ATOMIC_READOUT_DISABLED = 0,
 	DRM_ATOMIC_READOUT_ENABLED,
 	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
 	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,

-- 
2.53.0

