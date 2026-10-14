Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D358CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CD710FEDE;
	Wed, 14 Oct 2026 17:29:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0955310FEDE
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E1EB64398C;
 Wed, 14 Oct 2026 17:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7FF1F000C5;
 Wed, 14 Oct 2026 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998973;
 bh=Cd+hGP+QGXy67lLTuQ8TOlI6hekxuqcQXS92rX3dTYU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Rltang+X20plFu8ufmKcsUIWfbALj7AazpnHTIaARcJKWP47Hxk9ahFrwEW8gw3kJ
 x3DZC8/MnBirGQYGzfKvO61EaW4qF0lbDdku3cfiWYaXlcvw/Xao0ueknuttGRalYA
 ybWnKqHCIVA/LR6uk/8osqTyHMqPx5U6TPPW1mXhv/+lTXWiEq49kBqW3C2ulDiIiM
 Ou9SjP9eJ6V5f+/e2yECbKC5Yi+1imciiCGTv6n+vCMwBQOf8QbWuzMpbF1SjCBow0
 VJ2KavWiIeTy8fDoiI72q/Zzb8pg9UsqGBRIU89kQVRziaiWb9pXwzgYSoyolk2Jly
 8M9c4erFE08LA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:02 +0200
Subject: [PATCH 39/75] drm/sysfb: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-39-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fODG4FKuMpyywu2dfhnFa4tPrWh0sBoMTAH64qVU8cc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0ebv2g4ZJ+pP1FcZbdeiE6GS9Bkg8RLpmntP5/de
 lf+LC+vYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkdgJjw6tJm/7ndvGtkJyz
 99vGww+NwsvOrPm1cVEMx92GWGYT5fq55SesFmds/CIbuvbJ7ePLLRlrhRf9DdMTDCty3T8l+8h
 xrrzDgYn/XT6KNUs7t2zQZrzIkzq1VI+DIXan+YUqJ4XGjiMA
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

The sysfb connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
index c043428e02fd..6dab27b41c08 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -192,11 +192,11 @@ int drm_sysfb_connector_helper_get_modes(struct drm_connector *connector);
 
 #define DRM_SYSFB_CONNECTOR_HELPER_FUNCS \
 	.get_modes = drm_sysfb_connector_helper_get_modes
 
 #define DRM_SYSFB_CONNECTOR_FUNCS \
-	.reset = drm_atomic_helper_connector_reset, \
+	.atomic_create_state = drm_atomic_helper_connector_create_state, \
 	.fill_modes = drm_helper_probe_single_connector_modes, \
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state, \
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
 
 /*

-- 
2.55.0

