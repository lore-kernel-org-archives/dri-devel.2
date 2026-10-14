Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4A2CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B1A10FEAC;
	Wed, 14 Oct 2026 17:27:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED7F410FE7D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6BD4403E5;
 Wed, 14 Oct 2026 17:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400FC1F000C4;
 Wed, 14 Oct 2026 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998857;
 bh=79p2mQsdonKCSAOD8Y+wfTrHUb/IePASH7Njp5lQ5P0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=R0LuYCfT/TyN4KSJnx7eUxcWj5a7ndBbmEQyLmmg6Cjzf/ahjJdQoUxGRfAqDHHFi
 k0UlUOrGXwcPaMDFnPpcytarUTUxbt22MuLSDCNDB7bK63cWOrBgEXSypOXQPBbR5I
 YFaS7mh3K4FLWxUXe00FigNFLhkV13u56Dcy1P/rrn+jZ2Reao+fnJTNbKWtu3psop
 4W29PZp+v0O5ARFmxIhSXcQjLgDunxJNws7wMWuNbWzlYtM+HA9VnxeeuF2MkWmTXX
 twZbuVNqABWPN5jM/lhuEXd+XGSAwq6v0vD0eJIsx8ERvcoA1xj7s7tBfbFZdWebQu
 0+extHMXntApA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:30 +0200
Subject: [PATCH 07/75] drm/ast: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-7-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KpalsHl7VtQmioNuf1pIOcQMt205/cOaT6bt9Tf9b04=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/t+Voi4UFk/f9aOED3tzdOKxff8DSixddlyZLLS2
 jn2v5z4OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEpmgx1lc/u1LDUth8rlFt
 QeCn5Irt2tt23NnQ5eYgqBhzWn+lZ+Ihhs49thdK2bN6A5wePosQYqz3FNOft2qx5QPFbYmC2R3
 r8k0WzPbRKJ0nIMBh5i8SdLGFw/yDabnbJ8EbGj5zfmx71AYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The ast connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

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
index 6d6ccfad1415..9380c3d54e97 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -544,11 +544,11 @@ static const struct drm_connector_helper_funcs ast_dp501_connector_helper_funcs
 	.get_modes = ast_dp501_connector_helper_get_modes,
 	.detect_ctx = ast_dp501_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs ast_dp501_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
diff --git a/drivers/gpu/drm/ast/ast_sil164.c b/drivers/gpu/drm/ast/ast_sil164.c
index be01254dd48a..b84d9b254d88 100644
--- a/drivers/gpu/drm/ast/ast_sil164.c
+++ b/drivers/gpu/drm/ast/ast_sil164.c
@@ -64,11 +64,11 @@ static const struct drm_connector_helper_funcs ast_sil164_connector_helper_funcs
 	.get_modes = ast_sil164_connector_helper_get_modes,
 	.detect_ctx = ast_sil164_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs ast_sil164_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
diff --git a/drivers/gpu/drm/ast/ast_vga.c b/drivers/gpu/drm/ast/ast_vga.c
index abe0fff8485c..56a4524f5a8a 100644
--- a/drivers/gpu/drm/ast/ast_vga.c
+++ b/drivers/gpu/drm/ast/ast_vga.c
@@ -64,11 +64,11 @@ static const struct drm_connector_helper_funcs ast_vga_connector_helper_funcs =
 	.get_modes = ast_vga_connector_helper_get_modes,
 	.detect_ctx = ast_vga_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs ast_vga_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

