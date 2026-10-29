Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9D606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UN8BKipR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C68010FFE7;
	Thu, 29 Oct 2026 07:35:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445BB10FFD3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0287F40E86;
 Thu, 29 Oct 2026 07:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547281F01828;
 Thu, 29 Oct 2026 07:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259332;
 bh=Qaf3tUL71i1Eyk/vxyrNcqVK/TbkJi8Ie1SrMY+fmJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UN8BKipRw6BDWsXhuWpLoREruDFPZrihMIZ1V1It4c3K/8AE9PUW+UFDpiY5TssRW
 9iVZmBg/yJs5sHIW9e9ycKrbWzonh6O2/tvcsGx+XD6xUA37NUtTxHqYCBbsBPCAYa
 N/pIx/0r61vYSL2hGCRjDFPF6+Q0OJ45K6avE5TDEDe6oggRzyAWiDvr0MA9x9+mYq
 YnCHxc1ohCwSJONdal6gAocb5EJOR9pwKVvrBk0VvaWEpUdH7EZemVsKynVmvkO6ir
 ZMzKuGXoLba7XCsCyaInDHEZXh0B1aPsxqTn2vjUyR5skRPXAw6b/l8EQoDOEPb5kF
 1Z6GCpjz5hm6Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:09 +0100
Subject: [PATCH v7 19/34] drm/modeset-helper: Add
 drm_mode_config_helper_hw_reset()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-19-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nWWTVrDQdQv2ZF3yqEZFUGX9xsIOqVh7fKMZJfYyqxI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvn3le7h4X7RIYW71/hzNAs8zvpfNtt2XFZnjbaVn9
 Z6z2qG4YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEMoexPlfY8uNj159cR2cr
 nExwkI/5OXF72ctbcU3qMa7TxZVib5pyu09rvDDD7+tfq70ma/5zMjZ85NtnX9X3UFTzjxyLVMv
 KJ622th1+JcwZgV0xvjYVyVe3uE7r1L+0UazdUb3A6aY8AwA=
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

drm_mode_config_create_initial_state() calls
&drm_mode_config_funcs.hw_reset when the hardware state readout fails,
to put the hardware in a known-good state before creating pristine
software state.

Provide drm_mode_config_helper_hw_reset() as a default implementation of
&drm_mode_config_funcs.hw_reset that resets all the objects requiring
it.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_modeset_helper.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_modeset_helper.h     |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index cca623eb23e5..1a49ab8a0e41 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -263,2 +263,33 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_mode_config_helper_resume);
+
+/**
+ * drm_mode_config_helper_hw_reset - default &drm_mode_config_funcs.hw_reset implementation
+ * @dev: DRM device
+ *
+ * Resets all KMS objects that provide a hardware reset hook to a
+ * known-good state, without touching the software state.
+ *
+ * Drivers can assign this function as their
+ * &drm_mode_config_funcs.hw_reset implementation.
+ */
+void drm_mode_config_helper_hw_reset(struct drm_device *dev)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dev) {
+		const struct drm_crtc_helper_funcs *helper_funcs =
+			crtc->helper_private;
+
+		if (helper_funcs && helper_funcs->hw_reset)
+			helper_funcs->hw_reset(crtc);
+	}
+
+	/*
+	 * TODO: Reset encoders once the semantics of
+	 * encoder->funcs->reset have been clarified. Some drivers
+	 * (e.g. i915) reset both hardware and software state, while
+	 * others (e.g. loongson) only reset hardware registers.
+	 */
+}
+EXPORT_SYMBOL(drm_mode_config_helper_hw_reset);
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index 7e3d4c5a7f66..bd4193fbd907 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -43,4 +43,5 @@ int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 int drm_mode_config_helper_suspend(struct drm_device *dev);
 int drm_mode_config_helper_resume(struct drm_device *dev);
+void drm_mode_config_helper_hw_reset(struct drm_device *dev);
 
 #endif

-- 
2.55.0

