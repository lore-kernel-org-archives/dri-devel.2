Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129C606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6fq0x69
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3801129F5;
	Fri, 20 Nov 2026 12:56:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABD41129E0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA9D96286D;
 Fri, 20 Nov 2026 12:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4231F000EE;
 Fri, 20 Nov 2026 12:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179392;
 bh=v7w7uSjAovGYJNRUO21jQkoxCOHR8xe538FO+KhfmbI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=e6fq0x69wBUbBtK3q0Bomkf6pg+7j5cb+yvuTovUb00Etazd7pF/uiWW2W1G2u4cY
 RWpOy+5tHpohP2uPY38RxMJjQZo52av09s1g0phOSxfjWGJ/Cw23WdWizibxeU+8TG
 6On91X8zjbjz64YKC0ACQ9i7qkroDSFXSLrRqpdcUwy3MoUiRDeSRDmnxw8Zv2U6Cj
 uBQ6/QA7IeAc08gHEZe7R26SjuN9LQWeohaobew9UXJW2InELZWnj6Dajayn/x95Lp
 QMs7D2PueSWm+5GIgQBedghUN8hrPl4nitSt0Rx5eJlzV5ErK9IYsXKKjtgDyVYYli
 mJUd5/TOFeMXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:13 +0100
Subject: [PATCH v9 21/42] drm/modeset-helper: Add
 drm_mode_config_helper_hw_reset()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-21-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3575; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HaegtoF4ToUpJO52JB9WFWmWeWxUfa0nm0aoEsaPc5o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMztqVcxsXbzJvmqt1QJnp9xOr3d8M9Y7q+KeblwkcN
 +09mp7YMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYSfZyx4fs/v1kPz4vVm60+
 vfv/BY0y3tNcVz7Hfn29xidAd2ny5Us7CzJ3TV5zP7il4mBgWuVsLcb67PPfPmc1lrhdWfkhyk0
 7XUrEdc49Bzu2c5rvHJdM9tUzn+nzsaG6amlOyg6hyTXWUT0A
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
 include/drm/drm_mode_config.h        |  5 +++++
 include/drm/drm_modeset_helper.h     |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index cca623eb23e5..1a49ab8a0e41 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -260,5 +260,36 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
 		drm_kms_helper_poll_enable(dev);
 
 	return ret;
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
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 42d37f4aba84..9f8674870248 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -133,10 +133,15 @@ struct drm_mode_config_funcs {
 	 * Drivers that implement state readout and need a hardware
 	 * reset on the fallback path should implement this hook.
 	 * Drivers that don't implement state readout at all can keep
 	 * using drm_mode_config_reset() instead.
 	 *
+	 * drm_mode_config_helper_hw_reset() resets all the objects
+	 * that require it, and can be used as the implementation of
+	 * this hook, or called from it once the device specific reset
+	 * is done.
+	 *
 	 * This hook is optional. If not provided, the fallback path
 	 * will create software state without resetting the hardware
 	 * first.
 	 */
 	void (*hw_reset)(struct drm_device *dev);
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index 7e3d4c5a7f66..bd4193fbd907 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -40,7 +40,8 @@ void drm_helper_mode_fill_fb_struct(struct drm_device *dev,
 int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		  const struct drm_crtc_funcs *funcs);
 
 int drm_mode_config_helper_suspend(struct drm_device *dev);
 int drm_mode_config_helper_resume(struct drm_device *dev);
+void drm_mode_config_helper_hw_reset(struct drm_device *dev);
 
 #endif

-- 
2.56.1

