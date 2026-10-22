Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9E606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPbawoug
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102C61125AB;
	Thu, 22 Oct 2026 12:34:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9061125A3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78D344053B;
 Thu, 22 Oct 2026 12:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D437D1F000C1;
 Thu, 22 Oct 2026 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672481;
 bh=b9lXaTA5qsSoYuhuOiJfWNArepp6t3WiIrwj9pn0+Qw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jPbawougMZcqZXsjnM4a6c04zL1TOTPe6wvCJIVvHubnH7IXKR7rSDYW3ANPMhIfp
 daVztypkyNgkUvXIwQgvp0epZxLRBWg4Ll98TNzCtVvR2F7+drFFGVhdP4jH9yxzzp
 Mmer3sB5uyr4bHDr7/zzZ1lsKlHg93lb1F0bUOjC1Dy45FuZH/+gWYDtuBx1w3nFOw
 znVDYnpQY6M+5UlwmPnAffQgYztB/HVHxjXE/46Nd3ga8zEj0OJi9KQ6X6HGv38o6N
 blgNoFR8t1phq1XGz/N6r2tITzQ9hfLqxeyqtqRdpms2gJnGqLwp4UM9SOxLEn7UuC
 jCySII2W+r6DA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:14 +0200
Subject: [PATCH v2 15/59] drm/bridge: tda998x: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-15-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8jgjWm9NxBI2eGP8BVbiYuSoTyN6G56g0decASzis+s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mKZoKC0WEvKTOJ9/4YwQRyjTvj+Vhr1Lt9y5yq3Q3
 un1VdagYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExE/Rhjw7b2y7PNXX8nN15X
 fDv9C0/d4S9lmesvv7Z8sO/s932dncnZH7vfTf92XvHDdnPFA011Loz1ZR5J6Ze7Oab/eV28g3+
 /7ebV/ffLuDM94+errnseu1fwn7V1uP7KgyvKf7ov3pm4sek5AA==
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

The bridge: tda998x connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 9a4c47134fc4..54ef526a1133 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1210,8 +1210,8 @@ tda998x_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs tda998x_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = tda998x_connector_detect,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

