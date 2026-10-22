Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB90606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZyQE722
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCFF1125A1;
	Thu, 22 Oct 2026 12:34:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7046A1125A7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E916D60200;
 Thu, 22 Oct 2026 12:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284171F000C1;
 Thu, 22 Oct 2026 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672470;
 bh=x4PXyn2FdvXt09HpcaPk5CN6Dvez/8m8fqv5rq8FKFk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VZyQE722uCZW0b7dr5fYWRODISPCVDchins2lqmKxTCyS7aDVTpKZ0/Rlx0+d2gVL
 dP+6Kyb2h+UnUVsHH9xoWhEXvEC2x5aYjqemAN4kuZAYVux3bEuvXppb+krzs4NCfz
 7bsmF/qk2KQHUrVLOU9qswqbEJFrE2pHNyPqdnuLzSC5sNISgd2HTI5/e6tb/8nICa
 sDo/QuaEXfL7oC4y0BTtsoYvmfSv0l6NZxAVeyyv8yz2jl14dN5j79LoQRdHl7xO/Q
 j5mB+VhCjvptYvLSxGnMGs6olWMatxVJ2uBKpFuhIr9SGfzpMOLfsWsYPTNh/1ldMp
 WQRnwny8KcYjg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:11 +0200
Subject: [PATCH v2 12/59] drm/panel: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-12-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=mripard@kernel.org;
 h=from:subject:message-id; bh=szNxU1Wk+lkreCe/A1W5oI9orkNdp/mnL9cXIJ2vZk8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mCb1922PnaQZI2b+NfNVW19IxRzNyzuy7/LWun3cH
 9DrYNzYMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbC8oixYVLtvx6OfNbIDa7F
 e/6lsJR23jrLqd6vd/t/h6vFg8Y7eRfvnJ9gVd7gK2Dz88rXc5efMNaKX9BVTIieFPvnzLNlHWy
 XE7YXZB88dVdVP6angyFJU6x2a8DxrT3roppjMphtY25ViAEA
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

The bridge: panel connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 313053c123d1..760f074f947e 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -71,7 +71,7 @@ panel_bridge_connector_helper_funcs = {
 
 static const struct drm_connector_funcs panel_bridge_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

