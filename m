Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71C606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IU3X4rBH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2805C10EA26;
	Fri,  6 Nov 2026 13:15:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D12610EA1C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 166384043E;
 Fri,  6 Nov 2026 13:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7415A1F008A1;
 Fri,  6 Nov 2026 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970933;
 bh=7GPOj2hsPSgRd1UD931xgATmTsOjPi7eOPfigkeLPVY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IU3X4rBH8Hh10yCioGkj8lnbDQJSkh6oQQ0TBN4P8v1+5YVzc5MfDfoCxfjjqthM4
 gGYf+JXiQarJCY8NU1UXiROR8Pqu/abv66Ue8VZaepbrlj9j9EdwnWPZQc7pbmdg2/
 /AnEztfZdSk+VMWPnyKx/voVMf6jwyNngP1o/t3p2+uMe8l2MohhFM8ktv6Ry4qCvl
 qAe1pl3k6fs6GDzfZbDgN8+zk5Rtfl13Z9D3tFtEnsaQCQlb/bhZ9OPGI4pRaWHKXd
 ZTTisWpfUBYHOsHk0KENYK8cpOHT+Tw7wvGaz2BfTYE+hPGC6TAxQqQGgiaYKq4bIm
 /XfI2RITz32AA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:27 +0100
Subject: [PATCH v8 14/39] drm/atomic_sro: Create kernel parameter to force
 or disable readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-14-cbe78624e1bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lzYkzMbR5CpTDZd0SrLn154fGZvuGX5UtD85QyFmqME=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL222adA+fN4udlHyy4u3E9qNT8oqc5Ssexr0f7LYB
 hax67OvdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ/E1hrNPZGTGB53pvTNEj
 bVXl2V/lYp+qs+Yv+VCYHPdlfvYF7ot6r4qVNC9u+36Do+K4YqvGdMaG5pDnlWna3satcwJW+3Y
 Kn8jWqTRyag4OvPX4vsvdCB1+sV8P1hyboXxKh20fw8cPujcA
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

The hardware state readout is useful, but might need to be disabled
in case of bugs, or its checks relaxed during development when not
all hooks are implemented yet.

Add a module parameter to control the readout behavior: it can be
disabled entirely, or the checks for missing compare or readout hooks
can be skipped independently.

Suggested-by: Simona Vetter <simona@ffwll.ch>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++
 drivers/gpu/drm/drm_atomic_state_readout.c      | 29 +++++++++++++++++++++++++
 include/drm/drm_atomic_state_readout.h          |  9 ++++++++
 3 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..59ff44c49f31 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1378,4 +1378,16 @@ Kernel parameters
 			any connectors not explicitly specified.
 
+	drm.atomic_readout=	[DRM]
+			Control the KMS atomic hardware state readout
+			(SRO), used to initialize the atomic state from
+			the state the firmware left the hardware in at
+			boot instead of programming a new one.
+			0: disable the state readout entirely,
+			1: enable it (default),
+			2: ignore the objects missing a comparison
+			   implementation,
+			3: ignore the objects missing a readout or
+			   comparison implementation.
+
 	dscc4.setup=	[NET]
 
diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
index 0993d4cdfc2d..4ae435236f82 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout.c
@@ -15,4 +15,33 @@
 #include "drm_crtc_internal.h"
 
+static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
+module_param_unsafe(atomic_readout, uint, 0400);
+MODULE_PARM_DESC(atomic_readout,
+		 "Enable Hardware State Readout (0 = disabled, 1 = enabled, 2 = ignore missing compares, 3 = ignore missing readouts and compares, default = 1)");
+
+/**
+ * drm_atomic_sro_device_can_readout - check if a device supports hardware state readout
+ * @dev: DRM device to check
+ *
+ * Verifies that the device is an atomic driver, that readout is
+ * enabled, and that all KMS objects implement the relevant hooks.
+ *
+ * RETURNS:
+ *
+ * True if the device supports full hardware state readout, false
+ * otherwise.
+ */
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
+{
+	if (!drm_drv_uses_atomic_modeset(dev))
+		return false;
+
+	if (atomic_readout == DRM_ATOMIC_READOUT_DISABLED)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
+
 struct __drm_atomic_sro_plane {
 	struct drm_plane *ptr;
diff --git a/include/drm/drm_atomic_state_readout.h b/include/drm/drm_atomic_state_readout.h
index 5a9333a05796..955e2de9d5b1 100644
--- a/include/drm/drm_atomic_state_readout.h
+++ b/include/drm/drm_atomic_state_readout.h
@@ -16,4 +16,13 @@ struct drm_private_obj;
 struct drm_private_state;
 
+enum drm_atomic_readout_status {
+	DRM_ATOMIC_READOUT_DISABLED = 0,
+	DRM_ATOMIC_READOUT_ENABLED,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
+	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
+};
+
+bool drm_atomic_sro_device_can_readout(struct drm_device *dev);
+
 struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev);
 void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state);

-- 
2.55.0

