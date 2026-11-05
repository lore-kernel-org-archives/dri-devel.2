Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFA606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLeiuSfs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314E11125E1;
	Thu,  5 Nov 2026 15:31:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CA51125E1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C59A42474;
 Thu,  5 Nov 2026 15:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7A41F00A16;
 Thu,  5 Nov 2026 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892675;
 bh=v3R72Og6052wQsxjZC/mDC8A8e+FpeF+ChSo2fDBrFQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fLeiuSfsBVN3mWM3bocH9qCFCzJkHA0g6a1Vhk3t51EusPePSK7xnIysIhQTqY3xh
 s9eqHWdxGbiCHwnk5eMdw+mPgLMALXoYlBxNIi74jX1ygQuz3bNCokh/xq+Gb3wr2X
 93ct2T9fqdt1fz/Tci4Mm13Lqv9OIJopLZvQqZXLXb+N8L1KTvl0V1dbrCO8HXiAuW
 0rBnd600vCfxpCI9WNVuIO9qQ5FGeXkxACADRZqIgrPdkPTU1794gpvVWsFrdpvXB0
 r18fm6HBILnJxG6i3XW6+FsIJ6kiA1LajUeZc/hbpTrFGOIaLjJB8en0rW0dw8hV7p
 HGzCoKft9rbyw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:26 +0100
Subject: [PATCH RESEND 17/83] drm/imx/dc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-17-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iQY8DKnYDr2y14HmImCUNV690p8KR4+MpimH2Sy+wuY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjw5M9sxfPYZl4Y94SzdL767J0w9PKWY5+uSEMbfD
 UFPfUVud0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJuK9lrBWt92A+YmPGU8m2
 z0LDg7dyDasSQ1e0wzGmuQE+Zn+7Iy1f3G8oElRy0/v0+8q9F0anGRturMk7cP1CQI5eIIdr5Z8
 lvlx8j1VzXyRafbH7vj9hyuJfNzgytpV8yFn5kyffoGZn9iwA
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
Cc: Liu Ying <victor.liu@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: imx@lists.linux.dev
---
 drivers/gpu/drm/imx/dc/dc-kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-kms.c
index 0e2ce6a42548..7e29b51e58fc 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.c
+++ b/drivers/gpu/drm/imx/dc/dc-kms.c
@@ -130,5 +130,7 @@ int dc_kms_init(struct dc_drm_device *dc_drm)
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	drm_kms_helper_poll_init(drm);

-- 
2.55.0

