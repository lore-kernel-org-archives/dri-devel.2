Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC452C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E0D10FE9B;
	Wed, 14 Oct 2026 17:28:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A47C10FE9B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 044564024A;
 Wed, 14 Oct 2026 17:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628F21F000C4;
 Wed, 14 Oct 2026 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998886;
 bh=74RWtjcyOJAfTapPoPS+reVhWOOkoRZEmoC3pXY8vEM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fkAJqyXhiE2pFbQgiWGmYZWfZ5eX6/COCHzJdOPPD+D7fDIH8HESZ8kfL+37frUOq
 qcIWQmmBELupVXLSOs1FfmFcayc63BZareXsIqRVJ55AtrU5TXgPYgdy0GwEKV7wuX
 JfGpVpcNsCg8Jwia58CzFAwVf4stsua/dN1H0FauQzEijRrX7HqP5TOwAAZVHrHmoo
 sXmDsSf5dyTYjZ04sE+SB9oRItQKWsUL6zeGTdctkVyOTYrT5pR2vjg8Ff0rLQv4GK
 gjKW0FAr3f6jsQGrs3493YBHpAMptJRA0IXDGuTAielQBRKtrkN70fP+dnxhywHUhY
 xEMcVL/ugO0tA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:38 +0200
Subject: [PATCH 15/75] drm/bridge: sii902x: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-15-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=mripard@kernel.org;
 h=from:subject:message-id; bh=W6b1gph5OMim4P+LVc2TCiBf71xiwzDe5i7N8jZJEQ0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndweuPmJlfV+j/W2IisGf9UkzHmbVlV6+6+bgN8VX9
 U7+jWjpjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRLeGMdUoNf6KOfSvLfjCF
 iaPuj3XrS6WibM61WnEfT5pr6378fOhmw0x5FVtGO+lD3B3tLXzOjA3/LVi0k2ojjRuNiu47pfT
 MffbiSu2C6WWrZLgmhYZVqfpHq/69emTTj4aMtr5rqt9KBQE=
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

The bridge: sii902x connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 9aac44ed5b67..e067c0636e7f 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -279,11 +279,11 @@ sii902x_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs sii902x_connector_funcs = {
 	.detect = sii902x_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static const struct drm_edid *sii902x_edid_read(struct sii902x *sii902x,

-- 
2.55.0

