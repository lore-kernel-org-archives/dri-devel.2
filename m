Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B919606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2PD2Fy9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E84A1125D1;
	Thu, 22 Oct 2026 12:37:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812011125C9
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:37:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05D1560018;
 Thu, 22 Oct 2026 12:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCC1F000C1;
 Thu, 22 Oct 2026 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672620;
 bh=vsPU5Rd41AJw5VWo1MRbwo1mty3ZGuv/PjHYIkj/Egk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=d2PD2Fy98rWiphkM78WRPuHQamYsr4Kag56VFD57EwXAMNllHqikh1MVtydh1YS7v
 3jHe+lJb7YlrAbY8furahAOrIw5xrsXI5UL5gMeqIFr4JDzyMf7ULjaFCT4mQBT4l/
 LyVPfcFkSnlva6jD3vUjBER0Sorxl52Ldbt7zyyx+mglssef2gBS0FTWjuWY4NtyvM
 aAD2yTSvosxqmExeRaFH5373EhkwhTnN0p/rgQqMzHtJOBk5R2yAm3l7GK69kmsgaD
 vWiozQiQUXRmhhZj6y441Rix/Vv7Z4dWx+0+fKON39UN2EhOL1ads18pKWn4sy35sF
 880i+Bc1IFhfg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:53 +0200
Subject: [PATCH v2 54/59] drm/ast: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-54-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ycvdl21TrY16R8+8O6jUX+kznQYXp+0x/XQ/MDYrROA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mJaW5NZb2bYw3mMPmf+Ub11E0NriylgBa0PlJW0GB
 up7Yid0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlE/maslRRmMUncr1OrF+J/
 7uDhspRFVYH5/zSdNqVm2KomPRfjsBGe575frVDFoT9vV7eewVvGhoPetdumJCZuKqxNl1cuPqi
 YOO/bxa8Fph2fPnfyBy6+HNeVZPr2So7lNpfktGcOwesVAQ==
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

The ast DisplayPort connector reset implementation creates a custom
state subclass, but only initializes a pristine state without resetting
any hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_dp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index f22c0c215a21..373608aa10b9 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -470,15 +470,15 @@ static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs
 };
 
-static void ast_astdp_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *ast_astdp_connector_create_state(struct drm_connector *connector)
 {
-	struct ast_astdp_connector_state *astdp_state = kzalloc_obj(*astdp_state);
+	struct ast_astdp_connector_state *astdp_state;
 
-	if (connector->state)
-		connector->funcs->atomic_destroy_state(connector, connector->state);
+	astdp_state = kzalloc_obj(*astdp_state);
+	if (!astdp_state)
+		return ERR_PTR(-ENOMEM);
 
-	if (astdp_state)
-		__drm_atomic_helper_connector_reset(connector, &astdp_state->base);
-	else
-		__drm_atomic_helper_connector_reset(connector, NULL);
+	__drm_atomic_helper_connector_state_init(&astdp_state->base, connector);
+
+	return &astdp_state->base;
 }
 
@@ -514,7 +514,7 @@ static void ast_astdp_connector_atomic_destroy_state(struct drm_connector *conne
 
 static const struct drm_connector_funcs ast_astdp_connector_funcs = {
-	.reset = ast_astdp_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = ast_astdp_connector_create_state,
 	.atomic_duplicate_state = ast_astdp_connector_atomic_duplicate_state,
 	.atomic_destroy_state = ast_astdp_connector_atomic_destroy_state,

-- 
2.55.0

