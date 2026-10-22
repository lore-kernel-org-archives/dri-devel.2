Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F94606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if7y4DmN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C8B1125BC;
	Thu, 22 Oct 2026 12:36:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FD61125B2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E06743CCB;
 Thu, 22 Oct 2026 12:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5A31F000C4;
 Thu, 22 Oct 2026 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672556;
 bh=HLT7FrZ9LNQtlafa/zqzjEqc9t/CmXo26c6qd5upcmI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=if7y4DmNSi4jzNoluxxkBCVoJLZjnBmQ/vLDfwgfjduuWwkXa/5vqIEnZ1Vza6Sxn
 NLdtRSv9GLxoe+ewqTlVHtngFFSoIYp+Ei/8ZXSIUR76ARSH3d5LOMMujV6yFH82+M
 +fQmnHUg6d45XTaNnr4XhZOiRtXtlEto2gofdPDf7RQ9N+GuIAd3arnAU2dCy/aSJ5
 kIqxKLbMD7jtrcvZp0BAaKtu6tOHO58oM/IKsggxl36Ift/kXXRoNWcnduknv4//HM
 aEUCESHqUV4SZLm5sWLezPTolOO8JmqUGAzE6+0MPFm9bTp1S0FVNmPUTmPNoAnHpe
 d3T4CKW1Ot7Gg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:35 +0200
Subject: [PATCH v2 36/59] drm/tiny: pixpaper: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-36-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=mripard@kernel.org;
 h=from:subject:message-id; bh=us9gBM+1TeVY1mAcAr1nen3G0DXyxj4eEsJOi1Y1AvA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOaeObRZpCjjmFx1XcviqWLeO0/uSzh4UWXehs6TM
 jq9cyR4O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE1l1kbFjyy8534tJ9bgV/
 apmiTjlIMpUwtx17rRz0ItU6Wr+1dfm8vrPpwevPc/VoPlg0TepWEmO9gwdP8qb/ylyxq2e6+CZ
 9LgjuLfxvEHo+LrMtNv5ti+6Rj6Inw7Y6Bqozbp1wg0N+kgAA
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

The tiny: pixpaper connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/pixpaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index b69e7c30607e..2a92a28b40f6 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -992,7 +992,7 @@ static const struct drm_encoder_funcs pixpaper_encoder_funcs = {
 
 static const struct drm_connector_funcs pixpaper_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

