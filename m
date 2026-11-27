Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F1606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLVWLZqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FF8112947;
	Fri, 27 Nov 2026 09:56:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DEC112931
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 276B462610;
 Fri, 27 Nov 2026 09:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4B81F00A15;
 Fri, 27 Nov 2026 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773298;
 bh=LVcqMPL/cVjj07Ag9jA9Tchgu+aX50FVq/RUUKGDd+E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WLVWLZqUGOQa0CrTZFjTNkXmQQRNMyHHSOoHCU0nT3KFE+rWhZncFupUuonbsVqT3
 aD+QK+x80DULQzQhNvzKQxsdUk5nE8xoi5TqKu2McQYYVEHSiBlo8R1/T0FJu8hHzM
 YuQeMtABebKZHSDowO037LfUoUD80o399usoZt9H4qFI97SopiB1WabyQzg844pRFG
 IVFBR0mgUg8MDSsvoLVT2gt8FRrENFmM+J24P/cGNDAFH6uuv+QgW3LpF+lFtWOz31
 Fv44X22ftiGoev8NHl6qVdUx+uSlb4u048omBmdFFrPQK3yMtmRoc1lBiTetFdHhz2
 dQ1DkKwBriTkQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:11 +0100
Subject: [PATCH v10 29/36] drm/tidss: kms: Hook up hardware state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-29-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349; i=mripard@kernel.org;
 h=from:subject:message-id; bh=j53T2XJ2/TUEz9lH3HBjNxg3SCldDQuCBvpkD+KMxlo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwZz5Vn6WmQm+EfZr2beaSk7q4vyavk0sQb40YeVBh
 543K053TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgImwqDDW2W3K2xOb9yg1+tw+
 CRdBNdsFcoW2P2WNjs3fsf6ze6PPnj1am81fXqrIfiJ2bUPdRoVGxob5P3cLvt/SF+l8Jki3trj
 6g/qb0q1yd17uf/+oJsFlezSzc+LeixYhs29KLKn7u+ra7UwA
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

The CRTC, plane and bridge state readout hooks of the tidss driver are
only called by the KMS core if the device opts in to the state readout
infrastructure.

Set drm_mode_config_funcs.atomic_sro_readout_state to
drm_atomic_helper_sro_readout_state(), and
drm_mode_config_helper_funcs.atomic_sro_build_state and
drm_mode_config_helper_funcs.atomic_sro_install_state to
drm_atomic_helper_sro_build_state() and
drm_atomic_helper_sro_install_state() respectively, which implement the
standard readout sequence on top of the per-object hooks.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_kms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index fd7bb2c88931..32e11e36627d 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -4,10 +4,12 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
@@ -62,11 +64,13 @@ static void tidss_atomic_commit_tail(struct drm_atomic_commit *old_state)
 
 	tidss_runtime_put(tidss);
 }
 
 static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
-	.atomic_commit_tail = tidss_atomic_commit_tail,
+	.atomic_commit_tail	= tidss_atomic_commit_tail,
+	.atomic_sro_build_state = drm_atomic_helper_sro_build_state,
+	.atomic_sro_install_state = drm_atomic_helper_sro_install_state,
 };
 
 static int tidss_atomic_check(struct drm_device *ddev,
 			      struct drm_atomic_commit *state)
 {
@@ -131,10 +135,11 @@ static void tidss_hw_reset(struct drm_device *dev)
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = tidss_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_sro_readout_state = drm_atomic_helper_sro_readout_state,
 	.hw_reset = tidss_hw_reset,
 };
 
 static const char * const tidss_internal_bridge_compatibles[] = {
 	"ti,j721e-dsi",

-- 
2.56.1

