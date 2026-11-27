Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D50606A327
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIwoo8Mf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1474B112927;
	Fri, 27 Nov 2026 09:54:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C99B10E6BD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2FF461DD7;
 Fri, 27 Nov 2026 09:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8001F00898;
 Fri, 27 Nov 2026 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773243;
 bh=v0wOYI9rNuZJuZ5iP1cFOFw7Rw7piVOcCe6x0I+N5OQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PIwoo8MfvbMMVn0UVQUWtedkJrRmNmoCLaQTS6uXt/TSqBQr57yCiSSCg4S3jUzUf
 xYYr0riqctV/KzyN/3rZpuYj3svgPxyBx2AEmxMh1hdJRcl9eZ5VuNkOxVHDeVFAkN
 iooRCaWS1nsOqrepyx/BUF6xYt5rluhx8B0o8KFfBsXqYO3v5KAox/UlRI19wN9hb4
 ty0Cvgb99lJH0LeBXtlVBi1HU3KSOy7zcqeFhbsHSVF8EacCnhthwYh4ag3j/nkCJT
 4SoEhUpn76Ty3TdPaQqFFtmaIiWglM7RHHLH8rGE6304NXWAzYL7N9IPGji7dUqe1N
 q4axGj+y7wEMg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:52:55 +0100
Subject: [PATCH v10 13/36] drm/mode-config: Introduce hw_reset hook
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-13-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4698; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hKsnM2BRbkgN8HD/shzLSf7w0GmQ5UsIB95kL95l/24=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwUwn9bpc7t52/HruRK7Bf1ZRldidtgUpX+S4ZILOO
 khp36zvmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOxcWVsWCrE23wo0OIs99s3
 D0NF5DmXzT92MMP3vdWh6mvH2V2bb7+yftPNe8lc8eTMH58FW3cvYWz4eT9yyiqn7Yoncw/+35D
 BXhKztWnyj5BnjZ+YywSvbazRTErR7Q9R3TR70ZoFxqe0eTYCAA==
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

drm_mode_config_create_initial_state() tries to read out the current
hardware state to build the initial atomic state. If state readout is
disabled or fails, it falls back to creating pristine software state
using the objects' atomic_create_state callbacks.

However, creating pristine state without resetting the hardware leaves
the hardware and software states out of sync. The legacy
drm_mode_config_reset() handles this by calling per-object .reset
callbacks that both reset the hardware and allocate new state, but these
two concerns are intertwined and cannot be reused independently.

Introduce a new hw_reset hook in drm_mode_config_funcs that only
performs the hardware reset, without allocating any software state. Call
it in drm_mode_config_create_initial_state() after state readout fails,
right before falling back to drm_mode_config_create_state(). This
separates the hardware reset from state creation, allowing drivers that
implement state readout to share their reset logic with the fallback
path.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c |  8 +++++++-
 include/drm/drm_mode_config.h     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index d6f92e1a54d2..0259ec48cfbc 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -404,11 +404,12 @@ static int drm_mode_config_create_state(struct drm_device *dev)
  * can use this in e.g. probe to initialize their state.
  *
  * It creates the initial state in several steps. It first tries to
  * read-out the initial state from the hardware for all objects if state
  * read-out is enabled and the driver supports it. Then, if state
- * read-out isn't supported or fails, it creates a new, pristine state
+ * read-out isn't supported or fails, it resets the hardware using
+ * &drm_mode_config_funcs.hw_reset() and creates a new, pristine state
  * using the objects atomic_create_state callback.
  *
  * For historical reasons, drm_mode_config_reset() is similar, but
  * doesn't support state read-out, and will always reset the hardware.
  * It will also ignore all &drm_private_obj.
@@ -438,10 +439,15 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
 		ret = dev->mode_config.funcs->atomic_sro_readout_state(dev);
 		if (!ret)
 			goto out;
 	}
 
+	/* Reset the hardware first ... */
+	if (dev->mode_config.funcs->hw_reset)
+		dev->mode_config.funcs->hw_reset(dev);
+
+	/* ... then allocate a new pristine state */
 	ret = drm_mode_config_create_state(dev);
 
 out:
 	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
 
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index e1124b314524..42d37f4aba84 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -107,10 +107,42 @@ struct drm_mode_config_funcs {
 	 * should be checked in the .mode_valid() hook for each specific object.
 	 */
 	enum drm_mode_status (*mode_valid)(struct drm_device *dev,
 					   const struct drm_display_mode *mode);
 
+	/**
+	 * @hw_reset:
+	 *
+	 * Optional hook for device-specific hardware reset.
+	 *
+	 * Unlike drm_mode_config_reset(), which both resets hardware
+	 * and creates new software state through per-object .reset
+	 * callbacks, this hook only resets the hardware to a known good
+	 * state without touching the software state at all.
+	 *
+	 * This hook is called by
+	 * drm_mode_config_create_initial_state() when the hardware
+	 * state readout (atomic_sro_readout_state) is not supported
+	 * or fails. The call sequence is:
+	 *
+	 * 1. Try atomic_sro_readout_state() to read the hardware state
+	 * 2. If that fails, call hw_reset() to put the hardware in a
+	 *    known state
+	 * 3. Create pristine software state via atomic_create_state
+	 *    callbacks
+	 *
+	 * Drivers that implement state readout and need a hardware
+	 * reset on the fallback path should implement this hook.
+	 * Drivers that don't implement state readout at all can keep
+	 * using drm_mode_config_reset() instead.
+	 *
+	 * This hook is optional. If not provided, the fallback path
+	 * will create software state without resetting the hardware
+	 * first.
+	 */
+	void (*hw_reset)(struct drm_device *dev);
+
 	/**
 	 * @atomic_check:
 	 *
 	 * This is the only hook to validate an atomic modeset update. This
 	 * function must reject any modeset and state changes which the hardware

-- 
2.56.1

