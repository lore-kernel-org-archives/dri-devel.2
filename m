Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6279606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsL+aZRs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66E510E575;
	Fri, 30 Oct 2026 15:14:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1917710E5C2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 900576061A;
 Fri, 30 Oct 2026 15:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2161F00A1A;
 Fri, 30 Oct 2026 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373248;
 bh=NnI+paeLAWkx+tLnZL1j3RznF/EIlk0dhomKgq3LX1Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QsL+aZRsmM+z9g7KEkwYfU71fR3MaybLAGzTc/YtpINTKSYy8C5e8BesWmKm1cV4j
 Nnbf56uYZfxrERxLkok5Um8ReHwsZJKVSPjBsbV4BpH91FJfk3j9Alr72HHhcecCbn
 NXiGET5UkGpBdkgFUGba3JuVMijKL7OkpKwWN5eDq5M0ZAt+kdJjXqE5B1VVs+z7ep
 V9FEC3qV3N8Uta9/QYnwrose8RD6jrAvcUlsmukCI5GDhQMGUOqBDlBUbKfLeEmAGN
 p28VnmDr1GDnT5LOI85ZsW6n1GGPqy5ai4e6gLpQ/CsQ6t42rEnlZ/oQYX0y2aKBGD
 gDqGTl5zKW1bA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:34 +0100
Subject: [PATCH v3 04/37] drm/bridge: chrontel-ch7033: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-4-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9MXgui6M7Z1PskgFKn6ulSO9OdP1Kgev9gjKc6y4q4w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtsjvXfz5tLHZc8sVnSIl0o5Skl+XVrka91zbaHDN7
 nLNJp/YjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR7xmM9c7SbxWNDrptvB65
 eKeagM1B/qq/kxhNhB5ERHwQd7V7sP54lr74XN+eRpc9pkLL2Ow8Gev0A2N4tH8ZbxQ76MT2Kia
 dMei///tzdsVLit9tSvRjWxpjI/9vH7f7zL2cB7Zwql/5xA0A
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

The bridge: chrontel-ch7033 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 4bc64b2885f7..3d48b42c38a0 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -219,8 +219,8 @@ static enum drm_connector_status ch7033_connector_detect(
 
 static const struct drm_connector_funcs ch7033_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = ch7033_connector_detect,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

