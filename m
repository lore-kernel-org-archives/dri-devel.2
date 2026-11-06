Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6722606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjQO15OU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E91710E4FE;
	Fri,  6 Nov 2026 13:15:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3962410EA07
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B10C3605DE;
 Fri,  6 Nov 2026 13:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7E41F0089F;
 Fri,  6 Nov 2026 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970900;
 bh=Zr8TzRGaHcMF6ELnnCUbqOOdckHDHJI0PUDDdv10xoM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HjQO15OU+RJZQ8wQQGGhgvVg6BFsTXAzrXWohD9QotVPWh91MYUQDp79caws2/LRR
 fcSzjy/HnjJeP33D1y4cyF/a9A3WJ7+cT9HH1nD2C1XUvJYuEpF+Htvk0XklXvs2iM
 TmhZqIiWJQh04l97Tz81HpSRKwrTHgtRQUoThm0imKlR6E11pIVOegARFezXkydM43
 GzSpnebeHDI8xT0zmuFNKDqqEF+wYcVgkFInO1pY3SLzKdxjJtcXNNV+nqdq2Mp4P4
 A+UOxNvigUJ37Lr/CMEZcHAT8WKLsr2JmtcVTUTbWJvfvmFEuAPz21Atj0VBTcn0dV
 9fv5p6FK4EqfQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:18 +0100
Subject: [PATCH v8 05/39] drm/colorop: Export
 drm_atomic_helper_colorop_create_state()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-5-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=mripard@kernel.org;
 h=from:subject:message-id; bh=isUMppVXT92BwDU1OuSl015x+kzbbovU361R8zhyhco=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL62/v/rEph+d57gnFbE1OokzaGf+6vH/FlXIc/fMs
 vj31c3vOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEusIZG97+6rWK9hHa7bzG
 NtBf8Fty/d1AdZd0j6fn1z1jmhEXek0gdDbj6m2eS8/csn+5KphzFmN9ap/4sWVvJKpebX2et3B
 KbFv2vV/nQvjnb7o293uWWP6189J7WVTPhO/3813q4r/43oEdAA==
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

drm_atomic_helper_colorop_create_state() is only called by
drm_mode_config_create_state(), which lives in the same module, so it
never needed to be exported.

The atomic state readout helpers we'll introduce call it
from drm_kms_helper to allocate the colorop states. Without the
export, building the kernel with CONFIG_DRM_KMS_HELPER=m fails at
modpost with an undefined symbol.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_colorop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 95da03d6c65c..319557d1436f 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -649,4 +649,5 @@ drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop)
 	return state;
 }
+EXPORT_SYMBOL(drm_atomic_helper_colorop_create_state);
 
 /**

-- 
2.55.0

