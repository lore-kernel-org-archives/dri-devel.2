Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B6CC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5928C10FED7;
	Wed, 14 Oct 2026 17:30:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C85210FED7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 550EA4195F;
 Wed, 14 Oct 2026 17:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7431F000C4;
 Wed, 14 Oct 2026 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999014;
 bh=MGIvhKGZjYY6oLw+tZaNZqjbqi8wNSDbUniDKnsazzU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=n03bmybWx9+QyfR8t4EYms/xt+uOhu6wl70TpvFNm/kcMyVCCGVm9JO9AE7bHA2KV
 x66FQzwCEftPpvpmdcwRDu8Z4rcVe7VO1R7SRYgy/p8qe2egVlhLdDzXLE4OfqqUD3
 OzlePub5pYk1tBNCXjr3RaS1geuxQCNvGZGVwo6Tj9uN9e87hvyzSHSrEmjcH9t+n3
 xZNWe3TXnDhniihkthNHAZIEqCbLr4X2enXsKhs4nd1OsJ+TepMuLu2N6tiHUDblID
 wYP5HwKSgskN9i9rk01Ew2xBo5SkAR3TshEobsv1CysoF3hDrVS4KOM4OTyZGDqJAA
 DcvLUvbon40bw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:13 +0200
Subject: [PATCH 50/75] drm/vboxvideo: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-50-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WrmIppxHTvstneuj0xRIsytmfEwqunLedghQWV+Hdjo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndye8fp83a3+RnKe5x8k7Zcps/1R4fPqEjtQs8f63m
 llQrvB2x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI7FPGhhmLCjum67ekM/qc
 V2er2a3y/ULBo9sHPm+3COzO3Lf8xffXUaJn3+9tr2tnE8x4v2hKDWPDh4P75sXJhPdnTxDYJ9r
 MI+x9bn/0zWmv8gVmc0xed2ie2P/Cj3Y3VpdXdGysuPnp2Ws3AA==
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

The vboxvideo connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/vboxvideo/vbox_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 7c34299fa531..d66dc1cbbd82 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -798,11 +798,11 @@ static const struct drm_connector_helper_funcs vbox_connector_helper_funcs = {
 
 static const struct drm_connector_funcs vbox_connector_funcs = {
 	.detect = vbox_connector_detect,
 	.fill_modes = vbox_fill_modes,
 	.destroy = vbox_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int vbox_connector_init(struct drm_device *dev,

-- 
2.55.0

