Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F77606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6cBokOQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F9710FFF1;
	Thu, 29 Oct 2026 07:36:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BD510FFD3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:36:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47DC740995;
 Thu, 29 Oct 2026 07:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A027D1F01829;
 Thu, 29 Oct 2026 07:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259377;
 bh=67eLSmKsYFcKJxMSS4BXhtUb/OGpG1ajBX3mKLPCiO0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=l6cBokOQkx2vhZ8TcWmpUXkDeDWF3950lzku0UNuYeWtoBo+3iFDICN+sSEsuGRDG
 BxCO8dWc7QEnJYxDWYgjDYb+tNUltG9CC2didhl7/KZ0S+J4CT/8TABBgO9E1nAsj6
 7G8wEgOFTrAzaNEwcB65r9E++Pemb26WvvfrUHzfwKcY6H9Y8FH8XuzAZyQqa301Kw
 ycQ7O9VFag2xNaXwy0oiL7vY6PIG8FLPbNMWUxHqtB3aSwmDaPurTsjeiVazdGe78q
 c75M451VTrPIdM+FpZuIrm6W7EdP1bl+3ndgMt9OhGWwN8cVXiq2wQ1NbDnyMZKWPx
 lZr1aVAQcdRTg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:21 +0100
Subject: [PATCH v7 31/34] drm/tidss: Implement hw_reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-31-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2966; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2uhvrG9xhWji3zvUxRmRCNn1JZCxn9iEeAA7P6X2LkE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvv1i2nb/m6KUm8WWWTvERDfEvZtqy6Ptp3mnxjlsk
 VtY6/6lHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAii7wZq9kPd+9Ti9jRojfP
 t1Ugt2fXP/2bt79Mzthd8brqncbaE39fclj0Se98fVBiTd2z42UPZzM2XPu/xVL9wYSusMs/a5n
 3Hzgoue/PdSMrv/lhUpp1Nc53Y58c2LC9jGXHfrFVaq6en+48BAA=
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

The dispc hardware needs to be put in a known-good state when the
driver starts. This was previously done unconditionally during
dispc_init(), but it should only be performed on the reset path when
implementing state readout.

Rename dispc_init_hw() to dispc_reset_hw(), export it, and remove
the call from dispc_init(). Implement &drm_mode_config_funcs.hw_reset
through tidss_hw_reset() which performs the dispc soft reset and then
calls drm_mode_config_helper_hw_reset() to reset the rest of the
objects.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c |  6 +-----
 drivers/gpu/drm/tidss/tidss_dispc.h |  1 +
 drivers/gpu/drm/tidss/tidss_kms.c   | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 5943a5f25432..fd33edd80977 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2910,5 +2910,5 @@ static int dispc_softreset(struct dispc_device *dispc)
 }
 
-static int dispc_init_hw(struct dispc_device *dispc)
+int dispc_reset_hw(struct dispc_device *dispc)
 {
 	struct device *dev = dispc->dev;
@@ -3060,8 +3060,4 @@ int dispc_init(struct tidss_device *tidss)
 			     &dispc->memory_bandwidth_limit);
 
-	r = dispc_init_hw(dispc);
-	if (r)
-		return r;
-
 	tidss->dispc = dispc;
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 2183254f1ab7..e51a2088b40c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -146,4 +146,5 @@ void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
 
+int dispc_reset_hw(struct dispc_device *dispc);
 int dispc_init(struct tidss_device *tidss);
 void dispc_remove(struct tidss_device *tidss);
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index 70c14c3be10d..3b97c08c4f71 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -11,4 +11,5 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
@@ -117,8 +118,21 @@ static int tidss_atomic_check(struct drm_device *ddev,
 }
 
+static void tidss_hw_reset(struct drm_device *dev)
+{
+	struct tidss_device *tidss = to_tidss(dev);
+	int ret;
+
+	ret = dispc_reset_hw(tidss->dispc);
+	if (ret)
+		drm_warn(dev, "Couldn't reset dispc");
+
+	drm_mode_config_helper_hw_reset(dev);
+}
+
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = tidss_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
+	.hw_reset = tidss_hw_reset,
 };
 

-- 
2.55.0

