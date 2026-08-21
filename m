Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5DDC5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2718710F2E5;
	Fri, 21 Aug 2026 14:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KUnwKwfI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A4A10F2D1;
 Fri, 21 Aug 2026 14:41:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90B7C43454;
 Fri, 21 Aug 2026 14:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC401F000E9;
 Fri, 21 Aug 2026 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323292;
 bh=4YySIM4KosiS7XYFs5fzX4tZtV6If24C0BYm/xoN8uI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KUnwKwfIVZJZpshpp5Bq3YW9gJooGmzSmvolB2k6z3vR1KLaUsNAB3TEYAYVw7NOj
 cIsBZ1u+eW7p0XhpRQmG3ZOheXckKVGpdenKI5v8HADcw4OuYKVSq2HXVyFTuItQtC
 2auqB8/sYquXy1DjrRWXer5f4UON9xchLZiwy2lOqg5M7c8McThZIuBLN1P03fBXE3
 CvLLaS1xUDSYYVmtJ0Sk8LB+ZMS5xacQ7cR9WsF+tYhbudzOFWEWQZP53wIO73U4tF
 pSjjjHRAmiYfvJ1RbrmZzTZjAFsbnFo2kjjz8O3dC60lNIDwumdjjx18rIG6QDDtNB
 b85Hvyb2ziTPw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:30 +0200
Subject: [PATCH 54/70] drm/msm: dpu1: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-54-fb793475c05a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2634; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gAAR9JxqZrUHdI4fWljp332+26WQXUo/QQj2HXmplI4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyQL3m5ldv8ZPYSl2l0xeXeTo8/ds0KHp0jvFHk01y
 DfjuJHYMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACaSe4qxPrJN0JK7wde18P2X
 naHiBblKC/U9/x7vfPVf/9ihr9vrbRhClxzXNLrBP5GpXnT3ltNZjA0/DjdsD6hzSjXaZvv95Nt
 pt702Kv+xmn33WchMXe69m3b5aDkWvNvndPCI9RG5hKkf91sAAA==
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

The dpu1 crtc implementation provides a custom reset hook. However,
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b4d5..77a2d1f6700d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1138,21 +1138,21 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 
 end:
 	DPU_ATRACE_END("crtc_commit");
 }
 
-static void dpu_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *dpu_crtc_create_state(struct drm_crtc *crtc)
 {
-	struct dpu_crtc_state *cstate = kzalloc_obj(*cstate);
+	struct dpu_crtc_state *cstate;
 
-	if (crtc->state)
-		dpu_crtc_destroy_state(crtc, crtc->state);
+	cstate = kzalloc_obj(*cstate);
+	if (!cstate)
+		return ERR_PTR(-ENOMEM);
 
-	if (cstate)
-		__drm_atomic_helper_crtc_reset(crtc, &cstate->base);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
+	__drm_atomic_helper_crtc_state_init(&cstate->base, crtc);
+
+	return &cstate->base;
 }
 
 /**
  * dpu_crtc_duplicate_state - state duplicate hook
  * @crtc: Pointer to drm crtc structure
@@ -1841,11 +1841,11 @@ static int dpu_crtc_late_register(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_funcs dpu_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = dpu_crtc_reset,
+	.atomic_create_state = dpu_crtc_create_state,
 	.atomic_duplicate_state = dpu_crtc_duplicate_state,
 	.atomic_destroy_state = dpu_crtc_destroy_state,
 	.atomic_print_state = dpu_crtc_atomic_print_state,
 	.late_register = dpu_crtc_late_register,
 	.verify_crc_source = dpu_crtc_verify_crc_source,

-- 
2.55.0

