Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54F8C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5117110F05A;
	Fri, 21 Aug 2026 14:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TdiZxrCv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA68110EFD2;
 Fri, 21 Aug 2026 14:40:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F93761834;
 Fri, 21 Aug 2026 14:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9E01F000E9;
 Fri, 21 Aug 2026 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323203;
 bh=R/wr3BnRW2h74QzRjCstkBDHB0wUDUGJuBpar7/eCTc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TdiZxrCvFtfaw9xpHwriBbLhIYxE0duk+8PUQ5NliFJUDYcQ2YRYmLXxxKhGOrSVe
 dkH+3k3BV9L7xc+0tiWB/Xq69+N9BKQilXrArDztqR8dbxcc+UKQK4kpxR4p74ZMIG
 gnmLyf6qh+7BdRPThoov474crWd+BKY26dVlIou9h4KWG5PBWFrGWROuF/PYb+cByV
 NxcEw0jHcAUjmUFhduzUmhRn/deFbv9Jq35b0lH7f69qyfG9uGdSCulxahyEPVwHj7
 ka4mx/pkBgMn0Fw+HwuKCmao7qUUGRc3yfGA6wk5vsXhORCaBu1daQsgc1DIqPrAEo
 hiX6yiKJleDTw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:53 +0200
Subject: [PATCH 17/70] drm/msm: mdp4: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-17-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=mripard@kernel.org;
 h=from:subject:message-id; bh=GH8nQshyLLnzmePPkdHs/dNDNb7kP5GsBV4zWI8Cxns=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSf+r72xud4pqf7eGY/fen/LpSt+jDyffae2erXvoa
 tETvQTfjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARMVXGhg/1ZTN2v76eOI/j
 c8itU4minZp2V+qt/ijP+v5FVneD3gKWqgMcm7f/DHPlOSV0/ML5YsaGuTInqtluHY5qfF23tfP
 klCn6ZzbturW0pXi9KHvNLHenmZsOu7dwSH3aEVn7y6Lyj4ECAA==
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

The mdp4 crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>
Cc: freedreno@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index 57dfce58450b..93050b3c3548 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -475,11 +475,11 @@ static int mdp4_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
 static const struct drm_crtc_funcs mdp4_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.cursor_set = mdp4_crtc_cursor_set,
 	.cursor_move = mdp4_crtc_cursor_move,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank  = msm_crtc_enable_vblank,
 	.disable_vblank = msm_crtc_disable_vblank,
 };

-- 
2.55.0

