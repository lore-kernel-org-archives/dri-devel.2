Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD859606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S53N1mBF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0023610E2B8;
	Fri, 30 Oct 2026 15:14:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71E711289E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A01F2419BE;
 Fri, 30 Oct 2026 15:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026AA1F000C1;
 Fri, 30 Oct 2026 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373266;
 bh=b9lXaTA5qsSoYuhuOiJfWNArepp6t3WiIrwj9pn0+Qw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=S53N1mBFdi+OD2ccYWlHHgtzDD8FFrauqlny6Ki9vH15l5AXunzPv1PnrcVShweG7
 u9rkwVBbwH5Ky0DucK/zIfElMfw1qXSMN1MsuMSFWIjbCKQeMnem4XNhTESfV4olX3
 LQgvzg28Y8oSNdfnVkVW5Lvh694pTR6KBP6uqqlOQsm8h1d08IzVr+SvNvgoug9FAH
 cDvJkNFriy8YSWvlJroEWgzIvftMMZq4cXqcHKEIndTSG/9ijzI83zuhcQWzTS/0Ga
 D5zB2FvQVyCVJBriuIcMgw9OYZzdiGv6CnF2HJXXIb5IGE9qmAwoiHqLcgDpHcLlki
 eAZU0deMH8beQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:39 +0100
Subject: [PATCH v3 09/37] drm/bridge: tda998x: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-9-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8jgjWm9NxBI2eGP8BVbiYuSoTyN6G56g0decASzis+s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtiiuWfLgUsnzL6+2uW/xmM5qxFfZ+C0pw03Ao8S7b
 TPDE6sNHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiT74y1qnzOR6bXHDlU6j/
 DeZdnw9MWLFvnUtv8rIl7z4e5Une9H3l+YpronWr1x/tZrrjK5f95i1jw/c/8f6PnVJupOpe3lA
 0I2zn5RZZBcGNlnNurvi3d0XmW+FttX8n3dv1THnbQ9F5z/f8dgYA
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

