Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F44C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5002310E74E;
	Mon, 29 Jun 2026 08:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DIUiXJwT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA33710E740
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14A93600B0;
 Mon, 29 Jun 2026 08:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4730E1F000E9;
 Mon, 29 Jun 2026 08:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721073;
 bh=KwZT9hl/KfB+jYFDcjHcN5f7n7bsXlEq59U5hO7dKJU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DIUiXJwTxBbdT9LXx6fN+8Yo2Od/h0QGlL6+wyFSauISNeQyI7LyYKtROI56xJiu/
 j1nkuyHv0NlR9VErQ6Wxg+ZcH892I0QlKaAQpVABx9MjTSKJ/GDvXpND0RLqEkY5qL
 aWIrx5yZZRbLUtwulXwTPXl9D5vb7mgC0tnLogesJ5ecmLPJ7Qk8crresS2K3MroeV
 3+EwTxPF6U1bm7PkbxSbta8eHQLCMzfz5ERJ0x8FrKT9Fu2popGjVdYVXVpm732UTA
 K3n6qEgjMwQG1pKU3hMaGCQBw/YhmpFgrjGAbxQZxEzQqDz1own+7V3qJu7/9sHaWY
 WTaY7upIGHm4w==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:12 +0200
Subject: [PATCH v4 14/30] drm/atomic_sro: Create documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-14-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=mripard@kernel.org;
 h=from:subject:message-id; bh=04iiJDZg8Y3shr225hJ5LraTfnhSxL0+W1zMmHBJXyo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWmx5XTlh210WOj6MWLRDvcKJf+5Nr7Im5v7J4vLl5
 tuDPld0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlE1TJWs7bee/jPlH/+/pV9
 Rb0uBjKJ0zwOmV7f+WX75xCpZSdWFr5e9yP73JqtYUn8YbtctlwVZGzYdPqQZJPIioBuuXC5zYf
 mfQ3dx3h0Q9hEQe2jokn1/OVOJs3equwmgltX7anYu0f8qgYA
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
index 0c63f880002d..1243046dbfb0 100644
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
2.54.0

