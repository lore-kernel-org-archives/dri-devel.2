Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B320606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqGP/3Xr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A3C1128B5;
	Fri, 30 Oct 2026 15:15:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280D310E58D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08D134166E;
 Fri, 30 Oct 2026 15:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AF81F000C1;
 Fri, 30 Oct 2026 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373338;
 bh=iift74J2BcJLjOmAJCEOfXrZiV7cQ7a8CkgROfOHGRw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NqGP/3XrBSU9mKjAtTmo0ON2DKayBmXx4vLc6QAZZbMKMAz28k8LsP0JszZAa9Qxk
 E1q/8rnjbCPGmwdDHNl1SFCMBbwSBCw0lA6Dy5zes5v+UFoa0vjXRcgdX3sqxcY9rM
 5yOv7PXmZwRRVbErvYr6UhZWfKntduy9Pau/zS0Qr7CiDtOzkiUoflqnJm3yJmJGzu
 TAmIXxaKhck+or7vSk5UCpqh+A2lf8/IXq1EtC9X1q1QOfDAkkj9zix/9pGJjj/B7c
 6RQUDtv7R/ayLdgVXY1juhY+n7o2wuCQRBU7RmJ/QEFQ7fGFGcVeWhl95YXI0djo2L
 QbAzQTt1qswSQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:59 +0100
Subject: [PATCH v3 29/37] drm/sun4i: tv: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-29-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kGTs0Nop/pM8g/eLbAmv9j8gKg2hgWhBLCx8ej3AHWQ=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrktCrI7xROyP1Qk2kr5n2CkA50TbX+KBTIlrWzHoeys1z9C
 4iVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrktCoACgkQJ1/OGaI9vnbdKgGA8hwS
 AK5zkzXRBiAaF5hpTRehUIRBE7Z18gV+6JzV508fFaVrHwwc/lb2vEEfuRjTAX9B6gQwN/Q9cPr
 DmpP2GNZF0ikQonjDsKry41Vbvi5vxPkPnTDROVSWj90xWOX71Xc=
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

The sun4i TV connector reset implementation creates a pristine state
and initializes the analog TV properties. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
---
 drivers/gpu/drm/sun4i/sun4i_tv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index ea86f8a6a35e..a68e5f7a03d2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -406,8 +406,16 @@ static const struct drm_connector_helper_funcs sun4i_tv_comp_connector_helper_fu
 };
 
-static void sun4i_tv_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+sun4i_tv_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	drm_atomic_helper_connector_tv_state_init(connector_state, connector);
+
+	return connector_state;
 }
 
@@ -415,5 +423,5 @@ static const struct drm_connector_funcs sun4i_tv_comp_connector_funcs = {
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= sun4i_tv_connector_reset,
+	.atomic_create_state	= sun4i_tv_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

