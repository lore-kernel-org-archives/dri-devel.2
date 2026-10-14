Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CA5C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665D010FEF1;
	Wed, 14 Oct 2026 17:29:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185A710FED7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90A2A60229;
 Wed, 14 Oct 2026 17:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CD71F000C4;
 Wed, 14 Oct 2026 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998959;
 bh=mzBB+M0GL6Z+Hs3ozprg03tcX2o0PtbK9KRKa2HvyC8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VHt03V4SZlYsAhGcrKRPtfvsRXLTSO2iVdqbbJa9UTKJTmSbdSJaYVjRBJhMHi7Jd
 mnZm+KXQzXkFfR8H7fIkf/I5bLL0bjWOce/YX5UKM2keBVMBwRWWn4e3dVPTFE7SgA
 somOFCYHQ5LspH3qhXghy/tt6MgAnWOfs0doWaunUteoOViuVECvMsnnnY95BnEfq+
 EnSLw6TEyDoktwgFeTIeI96DLsDyUD8tbVgMAkv/irbWLih61VixNLpyr49rN65quX
 4VfuVcTUVEerSvAqsDLOxcm2gsMNb7EiKd0Fx9XIn7zsyzPsw2sdb+2mEmQFLzlGkP
 QuPJ3gkboRhYA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:58 +0200
Subject: [PATCH 35/75] drm/solomon: ssd130x: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-35-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ah+eHCsXFbPkbt7hVHu79D76POeuHIHfj8AjsIjS/GY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0eyc6QqbJ931Cw7tTRHrLKwkHvtfu/N827vmWM90
 a52+9SAjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRD+sYG3bXHuP0cPn2qXqu
 i2am/OLHBv9SgpkPu//tORG0afeD+4eTsqKtr+1a/3HqztRJ6pZmMozVrFneAa9dNzC2L4uNdGN
 cMTlAL9P9f1F5RiZP8ez1L/KWvW9mrjUr+b54jtrCjtqa/mwA
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

The solomon: ssd130x connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 8cbf18754487..ee43cf0da879 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1983,11 +1983,11 @@ static int ssd130x_connector_get_modes(struct drm_connector *connector)
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {
 	.get_modes = ssd130x_connector_get_modes,
 };
 
 static const struct drm_connector_funcs ssd130x_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

