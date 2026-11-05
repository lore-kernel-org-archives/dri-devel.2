Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E975606D827
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyQbWkj8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB31112777;
	Thu,  5 Nov 2026 15:31:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA9811277A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1182760A85;
 Thu,  5 Nov 2026 15:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CF41F00A17;
 Thu,  5 Nov 2026 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892678;
 bh=knwrJcvL7clG1HfpArVpNGWtATX6g5pA/gVZFr5kzV0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CyQbWkj8ULAGkHywxZ7UqhJpS+/pxtvpjbeZqnh6/AT+0Ifj03IoKf0apH7espjDH
 856TOU026loq5w6GiPRIPTxT/NTw4Wr/LOq5GUMdx3GLSnx7slLU0n6orpzx2Qim95
 zDbG2iY+RojiH78yrAM+wppXSWF26pWfsDvHiH9lFL9HgBDMZiFo6st9jk770eNwYo
 V3M5Q1MTFBszLryCK9cYjs45RSCzEdM9D4UQ0rYz9cJnia+GfN1maIxFWCs7QTKF04
 NyqjhnQjOdvMYByguIrnSVXl5owOfvwwaXIYC1Qw7keU25stmBUGuaM9YwaTKTxJVo
 GEZm/T83PmDIg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:27 +0100
Subject: [PATCH RESEND 18/83] drm/imx/dcss: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-18-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gk//ZtUuN08aJvV+if2UwQNlLwY4QXiavgS+/Rit8uk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjz1qQya8HSbVrjRuRkiK/58PPaUI/tbwNmPpdrC3
 d1y2pOUOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEeDUZ63NXvvzoyZNcGSFq
 u2KmVmyp8gWHkKeT/no/P8W7jaFL90z2TLFZP+VdK93d1uQXeitZMzYcEPswZX7Uj6A2v0V5U3e
 eDOVN/av1PoBx8qStTLYzZ2k23Vu8aLbIPJeIi+8WvWNcIRoJAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: imx@lists.linux.dev
---
 drivers/gpu/drm/imx/dcss/dcss-kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 7c5a6e2bc89a..92ac29960e48 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -142,5 +142,7 @@ struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
 		goto cleanup_mode_config;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto cleanup_crtc;
 
 	drm_kms_helper_poll_init(drm);

-- 
2.55.0

