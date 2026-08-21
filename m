Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D329C5DF96
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B3310F13E;
	Fri, 21 Aug 2026 14:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D/PBFdrY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16AB610F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D5A661838;
 Fri, 21 Aug 2026 14:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9BE1F00A3A;
 Fri, 21 Aug 2026 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323249;
 bh=yM2iBB0tkG63EQn0T7JtHcA3PhCfcMIKnrEWPQ1v1jM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=D/PBFdrYstOrDjsLQrJCPYwuMOu0CHH2LW5snXArI1KJxdXLoZPMDaVmdYytGjY/X
 eWsk6DQTOozh/7r91pkfpCE8uiUcgAyXfrOCOF0OfwDRHYC6CQFmuSFvcsWXcz39lQ
 1ulc9UUlahGsXwxo327PQsH3XeE1v+SHVhZHoRPZQNtHZmkyL+8jaSKMQMrjfcIBBE
 En9Ry8Lh1dcfujP7XW/eVRHhUgxKJhvbL8mX2UE9QArc13uozR+s38B0GFiuY7GmNi
 HnwDfMZSvmhUGHnL61bz+TBZJfF72giS39NVp/xKP6CZsLkuePIPmt2xgLfXldc64d
 4dVwqOIJFHUVw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:12 +0200
Subject: [PATCH 36/70] drm/udl: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-36-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xKkuJcCsUVaW4iznjjHWHFvTWalMdOUF76P57KkIWRo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyRxl1klFbc93XD7xs+VJ/UKG0EmTbExmxf3/HCW5P
 myztq1Dx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI5V7GhtPO0csPG74VDd2u
 m3JDe2LRdS63r8+eVjdKV7xmXJkQW2kY4xgu+sdnXR7ftYTjMro3GOtLV/zNuhBTILR2S6u4TaC
 Sgv33+/NvzRWLdgi4fjLeUWilVptCqOzBuqMlaW4NIvVPPgEA
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

The udl crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/udl/udl_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 289711035b67..dee085406ac2 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -398,11 +398,11 @@ static const struct drm_crtc_helper_funcs udl_crtc_helper_funcs = {
 	.atomic_enable = udl_crtc_helper_atomic_enable,
 	.atomic_disable = udl_crtc_helper_atomic_disable,
 };
 
 static const struct drm_crtc_funcs udl_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

