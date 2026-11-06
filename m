Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BF606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i07hsSyF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9AB112207;
	Fri,  6 Nov 2026 13:17:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3FF10EE4D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5346260204;
 Fri,  6 Nov 2026 13:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F971F008A2;
 Fri,  6 Nov 2026 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970998;
 bh=FPnz4viegh40Y8FbVckUOVgc65gekVWbxCYSiJJpdsw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=i07hsSyF/7LNONijtv7s664P+K/vSRRIZ473UKg3BPUEMtIzYSMAHNvaCKHGKh+UH
 kKP48mv4+2/BUjxTC5u6iaIg/xGLnZfM7T3MsMVK4PlI244wTZbupMEo/0/DILpBtO
 ALWg9BkCwtj7fZqUtju289Bo69qSl4NwTSFo17Vpt6WNYI0ylraopNgOXTvBVoxmGr
 zevJ8/+ZE114p8o8yRCtg+xCwtMU7eJICNCmam74W3jEP/byorbTqndm3prVbNC4uQ
 S4SoEiJoG7JPsCz+BXPZdUthQyUg17V9SWqNLv7NY5f4imuFCqxfsGNC32TbsIhxrA
 +Aj2riKCB5UrQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:45 +0100
Subject: [PATCH v8 32/39] drm/tidss: crtc: Add atomic_print_state
 implementation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-32-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vmtxEmtpExW1wORchVnJCeHyXPM+Yje8pPZ5jtRGk2M=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrt0rvIPVGgZjKz/Yx8uucFFIWEmOgtzO9hDsg6AUzrwav86
 4iVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrt0rsACgkQJ1/OGaI9vnZ5TQGAqQjf
 ULsYTYFYLKvtGrtP1Eyngw7paAVd3FmuG57o9ellgJ4gi428qV6LIvRhSHbRAYC9n6PvmT43N42
 FBaHXFwqLBxmTcK8ZE4osd8soyXQVtpVzK7wMWYoLkL9bSN+ks/Y=
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

The tidss CRTC subclasses drm_crtc_state with bus_format and bus_flags
fields that are set during atomic check and state readout. These fields
are not visible in the standard atomic state dumps, making it harder to
debug bus format negotiation issues.

Add an atomic_print_state hook to expose them in debugfs and kernel log
state dumps.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index ae9c66831b6c..d2664bda53a9 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -404,4 +404,13 @@ static void tidss_crtc_destroy(struct drm_crtc *crtc)
 }
 
+static void tidss_crtc_atomic_print_state(struct drm_printer *p,
+					  const struct drm_crtc_state *state)
+{
+	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
+
+	drm_printf_indent(p, 1, "bus_format=0x%08x\n", tstate->bus_format);
+	drm_printf_indent(p, 1, "bus_flags=0x%08x\n", tstate->bus_flags);
+}
+
 static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.destroy = tidss_crtc_destroy,
@@ -411,4 +420,5 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
 	.atomic_duplicate_state = tidss_crtc_duplicate_state,
 	.atomic_destroy_state = tidss_crtc_destroy_state,
+	.atomic_print_state = tidss_crtc_atomic_print_state,
 	.enable_vblank = tidss_crtc_enable_vblank,
 	.disable_vblank = tidss_crtc_disable_vblank,

-- 
2.55.0

