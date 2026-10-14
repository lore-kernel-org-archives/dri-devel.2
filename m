Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D268C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD9510FEB2;
	Wed, 14 Oct 2026 17:27:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6349210FE8A
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B41141353;
 Wed, 14 Oct 2026 17:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1F41F000C5;
 Wed, 14 Oct 2026 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998854;
 bh=2MXREJ2IxBu2OWHzKRRdTvQR2F30ZPR01icm+aivTlM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HoaIWHyGmM7kCdJ5FPOo93VSKrYERwsGf4gCGCDaH/88PhwDaT+z4k5l2G/xkqzpC
 Yy5f+8sstvQkHOIm7KX0vSI1G+nA2Ck/Og0Pv2ot/NGk11bBluYYmLrBJz7DRyVCSm
 /pZkKo/tr5m8m3mOVSlDmU5QJg02VP8mBZ2LdbK23ARmMB7/n/fgUSaIQUGuZtxiB4
 UjARBleJPOJnLqSEY7nlN1tF4XAqSjx3gFoOBH3uZikiUaDkFuIDPzfGqK0XewwYkr
 WBwRHbqLZ5+q2U4hYOI6KIOzgLNoKTi3ur63YqjDv4pvR892j/42vnq3LnyONR96b3
 U02cNiBVW6JpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:29 +0200
Subject: [PATCH 06/75] drm/aspeed: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-6-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=mripard@kernel.org;
 h=from:subject:message-id; bh=B9xwgUcvkbBfiXZC5ULwIG8FNaFKJyXzCOEaOuyruaM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/uazp2peGrivOnTrqvol7l+fP0j1sP+3tVTT5cpS
 u8+NXnW3o6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwEe19jPVx2wX2KYjnWH3v
 WdG0ZIlGU8Kh9X5lhy677e+wc5i/RSH/zvLoxMzN+Wn/hT+V/lzyQpKxhkvAyfPyj3X3RVbc25E
 avXxiz6M7GUtsvyrfET+/c65unmjF/1ki8v4r4gS/3WBIFc6SAgA=
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

The aspeed connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
index 78775e0c853f..83bf5561bf81 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
@@ -19,11 +19,11 @@ drm_connector_helper_funcs aspeed_gfx_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs aspeed_gfx_connector_funcs = {
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
 int aspeed_gfx_create_output(struct drm_device *drm)

-- 
2.55.0

