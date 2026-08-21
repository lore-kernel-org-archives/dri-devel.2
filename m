Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF99C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD7E10F2F5;
	Fri, 21 Aug 2026 14:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eqpZKhTk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466F810F2DD;
 Fri, 21 Aug 2026 14:41:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04351413A4;
 Fri, 21 Aug 2026 14:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8E71F00A3A;
 Fri, 21 Aug 2026 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323294;
 bh=exY7e7RcKMPMMFW0ncO9ZMzZZPCMaL0Z2n1EqU+RGwM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eqpZKhTkDq/sDg7WvNetDO1uUsJIgg4+8vF4N1mFh8uBbY2mcq6N32PqYyId5GErl
 qJsbhWdMp5mjeMfV1IQyHvOW6zcOnEtZaHrBiXs6lDj64D1kLt8vijnbqFqxNAiOi4
 z9FwFBIfwKOtNopnh9QmBEGsadWgiCb0fP7B8xz+js7L03be3DByTpUpVTyw9xYw+a
 HQ0H1GZ5IJzzvZms+UHGrhBo1uoGKioPvj9zGE2lFhTZ3DfW0u61FtCyhuSPfZSWt7
 SnVqnCzPC7J8HCHMlHP3nf86k8+ozESluMBtCUgavUMOQku1mVNUeU4IyyQrOZd+UO
 UOKuyL/mJxadQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:31 +0200
Subject: [PATCH 55/70] drm/msm: mdp5: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-55-fb793475c05a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ombmf9hpe+qDj55uMlu1rOHBFFNn3wz6F6EzTnQXKFU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyQKtTHelgw40VIi8kpzDfHL2wQk1/TM+O6yVV3tl4
 bLecnNfx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIFAdjreiH2HPGXbvNZ5Wo
 /Y2ZUyfasDFnr6begm1PDqRyN3St37LHk0nvxrsT4lfmvL1RfubuMcaG/celFi2KDRZIOB66Oy9
 /tzv70ctii78vFnLS38X6vzV7Ff8Ln6K163pP2CgcCng0vfkpAA==
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

The mdp5 crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

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
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 4c4a897fc1ee..1e1fff37380c 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -1126,27 +1126,27 @@ static void mdp5_crtc_destroy_state(struct drm_crtc *crtc, struct drm_crtc_state
 	__drm_atomic_helper_crtc_destroy_state(state);
 
 	kfree(mdp5_cstate);
 }
 
-static void mdp5_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *mdp5_crtc_create_state(struct drm_crtc *crtc)
 {
-	struct mdp5_crtc_state *mdp5_cstate = kzalloc_obj(*mdp5_cstate);
+	struct mdp5_crtc_state *mdp5_cstate;
 
-	if (crtc->state)
-		mdp5_crtc_destroy_state(crtc, crtc->state);
+	mdp5_cstate = kzalloc_obj(*mdp5_cstate);
+	if (!mdp5_cstate)
+		return ERR_PTR(-ENOMEM);
 
-	if (mdp5_cstate)
-		__drm_atomic_helper_crtc_reset(crtc, &mdp5_cstate->base);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
+	__drm_atomic_helper_crtc_state_init(&mdp5_cstate->base, crtc);
+
+	return &mdp5_cstate->base;
 }
 
 static const struct drm_crtc_funcs mdp5_crtc_no_lm_cursor_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = mdp5_crtc_reset,
+	.atomic_create_state = mdp5_crtc_create_state,
 	.atomic_duplicate_state = mdp5_crtc_duplicate_state,
 	.atomic_destroy_state = mdp5_crtc_destroy_state,
 	.atomic_print_state = mdp5_crtc_atomic_print_state,
 	.get_vblank_counter = mdp5_crtc_get_vblank_counter,
 	.enable_vblank  = msm_crtc_enable_vblank,
@@ -1155,11 +1155,11 @@ static const struct drm_crtc_funcs mdp5_crtc_no_lm_cursor_funcs = {
 };
 
 static const struct drm_crtc_funcs mdp5_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = mdp5_crtc_reset,
+	.atomic_create_state = mdp5_crtc_create_state,
 	.atomic_duplicate_state = mdp5_crtc_duplicate_state,
 	.atomic_destroy_state = mdp5_crtc_destroy_state,
 	.cursor_set = mdp5_crtc_cursor_set,
 	.cursor_move = mdp5_crtc_cursor_move,
 	.atomic_print_state = mdp5_crtc_atomic_print_state,

-- 
2.55.0

