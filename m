Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91211606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKsXQq15
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD38E112594;
	Thu, 22 Oct 2026 12:34:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA821112594
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A38B9447DE;
 Thu, 22 Oct 2026 12:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2FD1F000C6;
 Thu, 22 Oct 2026 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672452;
 bh=CGCCewg7+U8EKiFufRLPBzivndbwughZmYmxz3+EA8s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GKsXQq15cwmPCYB82OACx6rUrZGrAlQSa549Xt3r+FrMgC3ByTBMbGaHkiUz0t2gY
 EA0WZSgHoUIxuxIWmEiggkWT8dUTRkEFEw0GoUFX5Qf21JX+9KPknee7HeHoUclQ1V
 uK+FRbgK5mrX8/KqrYnMyCDBDWhunB3G1hITD/Ogj+tsYDPgFmh2ZrDCzs778iMQ/Z
 kjUcFYp/ldHxmK/uKDxefhh0OQZXuaKy+LSCiKz7seN+v2DGZ9tlImJK+bJJ+2jGp1
 LbXCrbas3ht4QS1PK7D5Sai8WohPPEQGu6wCKGO4IvAhhy2ZHGC695ykOVVP7Kx1kp
 1wTCBUCoXMWYw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:06 +0200
Subject: [PATCH v2 07/59] drm/ast: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-7-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7glheR4wlOHrHzgeWkYfVCjdnxDmk1YnTLr/QIWFIkc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mCbkJO+aH9j6KrvYf+d+Bn7emc0/jq4+u+FE6d+qB
 AE3vyezO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBELv5hrM+fVMetmXKu56lL
 qvbv5qeqXQYhG7d/5theejby2uMXXntrMvcEeL42XJ/guPjVhC0qMxkbGlyfL89aGS76hdNGpu/
 gXctZC7LNdefOSw0UY3zFUWlmozh5mt/pAEmPtVl7X04/XXQOAA==
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

The ast connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_dp501.c  | 2 +-
 drivers/gpu/drm/ast/ast_sil164.c | 2 +-
 drivers/gpu/drm/ast/ast_vga.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 6d6ccfad1415..fd357ff97cd4 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -547,7 +547,7 @@ static const struct drm_connector_helper_funcs ast_dp501_connector_helper_funcs
 
 static const struct drm_connector_funcs ast_dp501_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/ast/ast_sil164.c b/drivers/gpu/drm/ast/ast_sil164.c
index be01254dd48a..baefee645533 100644
--- a/drivers/gpu/drm/ast/ast_sil164.c
+++ b/drivers/gpu/drm/ast/ast_sil164.c
@@ -67,7 +67,7 @@ static const struct drm_connector_helper_funcs ast_sil164_connector_helper_funcs
 
 static const struct drm_connector_funcs ast_sil164_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/ast/ast_vga.c b/drivers/gpu/drm/ast/ast_vga.c
index abe0fff8485c..bc415ec91547 100644
--- a/drivers/gpu/drm/ast/ast_vga.c
+++ b/drivers/gpu/drm/ast/ast_vga.c
@@ -67,7 +67,7 @@ static const struct drm_connector_helper_funcs ast_vga_connector_helper_funcs =
 
 static const struct drm_connector_funcs ast_vga_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

