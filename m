Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EB3CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BED10FEF7;
	Wed, 14 Oct 2026 17:30:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611AB10FEE7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D848460229;
 Wed, 14 Oct 2026 17:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ABF1F000C4;
 Wed, 14 Oct 2026 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999010;
 bh=LSfAp9SO1P002bPrkIidZlOANeJ9TQV42hHyjQkpBK8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fGL2vKzHSFiOTKl+UYrRbJahgz9MYVxwqS2w7dh0MszjB/4aH5mNcHutA0UHK4cxg
 qhlCOS53+AqklsyU9rJ511+sqpGOdLKua3uucDp7jsvqO5zJUCu64YHHobOwmRt987
 Sq9zeVj0xVc7xIAQt+wEYhq+Ikuv9jemHLTWrp21DP/yEPMO+2XaIm++sBiPeaKEtp
 LoHAJonBvbmYnuCCb1gn5pwz2Fr7LIxdYT/WVoCNcdlMh8+2XXJL2KVwHZvIUNiN49
 UAQgHUBQQRP9Qp98N4FzVnMUoHf5C6av5RL7Lb0M2gfPOOm7qvWXJyt20UFoJwaNUr
 TQ0J7qvpTu+0g==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:12 +0200
Subject: [PATCH 49/75] drm/udl: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-49-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0mm5vsomxr9QD8zV4EtLm0KwDTuya0TvJvFcFXGhnRI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndyeEz7/wvY/rex/LpNBuBsdTKc+Y/bJi5BvZFqW9Y
 hWcVqDYMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbyawdjw96itISlYc1zJjWt
 PvbhTXd8+E7ZVysZF4YtfbOI1TV+9RJ+k4cayQ2W7U+Pf+xSYbX6wVhftGSBStLu7JV+CudvGu1
 bYbeh0PmoW0d92pxtHkw6ztO51vJIFD6ezL1q/7x1h07u4jgKAA==
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

The udl connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/udl/udl_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index dee085406ac2..7470fe3f34ee 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -449,11 +449,11 @@ static const struct drm_connector_helper_funcs udl_connector_helper_funcs = {
 	.get_modes = udl_connector_helper_get_modes,
 	.detect_ctx = udl_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs udl_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

