Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC3606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8iZEfQv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C734410EA3D;
	Fri,  6 Nov 2026 13:16:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A9C10EA3D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3931601BF;
 Fri,  6 Nov 2026 13:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DBB1F0089F;
 Fri,  6 Nov 2026 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970958;
 bh=j8XesR0ShX9J3SXWxT0BQRpWfd5OvV9ljf2CN3+ugGY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=l8iZEfQvDBtSUZ528s5EwtxeG4iKHcYwaAAouKiBaln6A26zMDeM4fcYqoiwItWe8
 fHz3ibLq17zXe9DlXYYFZJWhqLB2Uv5fWDmqo35kvdAJLn/AO/iw1PtdB+viHipn2Q
 UAsCkx3q7s+BtmlwPn6XJ68F9zzJZjGje5a6axj2Pe6KSo1txHJodv8h0E0N2RSEo9
 eR0a5FBWrCqgCtA+QLGzkWnX2Z+W033FluFuW9n5N1XJq1KxIxd9syHX/ImmZPvYjd
 ZhF2KS8hGEtkU2A92AkXBmp82EXWoN1S9QvGeOBmTUo/e2qICaVZUdLrfDpsq5Upam
 7WBetzgXMCBsQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:34 +0100
Subject: [PATCH v8 21/39] drm/mode-config: Introduce hw_reset hook
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-21-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924; i=mripard@kernel.org;
 h=from:subject:message-id; bh=P2T95rJCJxk/i+sWllfXptAZI7cObOEQW/d0Hbi8UfQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL217qMbZbHXNeYnJwV8np/28kn6M3zW26YbWXPnoq
 ddcP+et6ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATKc5mrPdZdSSZbzVvwqMd
 7O8fhcvrhWe1be/3izlQWPJGiYXliXnW0vrfp85EFS2ae+WiWDvjNMZ69+1xG9vna9ga3bSd/O5
 V2I9XSnEBu3bHpx+vkJ3yzvCzHP/+1erC87r7uicfqgwOOjIRAA==
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
index 9f242e2654c8..1b70a15765c6 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -408,5 +408,6 @@ static int drm_mode_config_create_state(struct drm_device *dev)
  * read-out the initial state from the hardware for all objects if state
  * read-out is enabled and the driver supports it. Then, if state
- * read-out isn't supported or fails, it creates a new, pristine state
+ * read-out isn't supported or fails, it resets the hardware using
+ * &drm_mode_config_funcs.hw_reset() and creates a new, pristine state
  * using the objects atomic_create_state callback.
  *
@@ -442,4 +443,9 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
 	}
 
+	/* Reset the hardware first ... */
+	if (dev->mode_config.funcs->hw_reset)
+		dev->mode_config.funcs->hw_reset(dev);
+
+	/* ... then allocate a new pristine state */
 	ret = drm_mode_config_create_state(dev);
 
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index dd555f8727ad..ce9e48824dee 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -110,4 +110,36 @@ struct drm_mode_config_funcs {
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

-- 
2.55.0

