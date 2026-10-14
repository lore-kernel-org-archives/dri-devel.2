Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC96CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58C810FEE9;
	Wed, 14 Oct 2026 17:29:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD7F10FEE9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9439241288;
 Wed, 14 Oct 2026 17:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01221F000C4;
 Wed, 14 Oct 2026 17:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998988;
 bh=6ueo7xEMpBoUCoYe7wcZjVjNlQBQrogcrtWCFrFGW3g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BU+BZts06W3eNCN5D0cXsBZb9xDaxfkpKRSedAsAv5pz8nSx25tx1gojJMKu2oyiD
 CoWrRnAOpxKXPnv2TYAild+fA9pXZMMqmsqe5DPy+cKitcAU5GHcFooJomkGg/bwKh
 07DVYSVwMhI9JnFfZaL+KixX2dy/Hy9T4DQyu4/Q4wt41J1dVObA5WVwx1lYgeePmO
 za7SPNdYgIjf+D/i96KarAtODBjE9s6m9ENAG7TUYZCl63F1wzzhRfIhTBufwNNJeb
 kSAGQ6nQS5WaYn6vnUc4a2zVwQHOXIecNpMlgpdl55enJz1zEp9tL5fH3rTFSa9bwi
 ZVfSZx1tp2sTw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:06 +0200
Subject: [PATCH 43/75] drm/tiny: bochs: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-43-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BXmAQ18Ly3tUsjFv7E8tgnouUnBe4OS3FqA1yU03lmQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8daylS/miQw9Yi3kGOMgEf2zPNCy9dUWUWftDW/2
 8G1V+VYx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI80XGhrs2i4M6I15Nm3hv
 tdIK0Q4R7nyJTtH4TU8uFL28bLXNRzty8d7MCs344yrn3Z33ONrFMzY8zjW/LBtixnN05pMTcmG
 7DPkeJheeDHqzrWKR3vu07oTuzXVXexY+f97zKEwwJrSwQhgA
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

The tiny: bochs connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8192decddbc1..771d59b92f67 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -590,11 +590,11 @@ static const struct drm_connector_helper_funcs bochs_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs bochs_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static enum drm_mode_status bochs_mode_config_mode_valid(struct drm_device *dev,

-- 
2.55.0

