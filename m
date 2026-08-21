Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9769AC5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B8F10EE68;
	Fri, 21 Aug 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZ4fkmXC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCB810ED90
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3734861834;
 Fri, 21 Aug 2026 14:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698981F000E9;
 Fri, 21 Aug 2026 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323181;
 bh=//+pLRZ0VDS0z4RfcySU8FR50B7ze8GI8gmB1SLOVLk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MZ4fkmXClqcO8SEFQZz6Wum/qU2vJLuxZUHKyy5LQwdJ9foGqHOSpuDAMGRqMFhni
 wInIs56rm5O/MtVtApcJzeiwS6P+vFuJOZCxvfASk17gSI4MlrZSfIhop6XRIjkZCk
 x6vExkZmQYfa5NBeHNFY3cQzPXgDQi8Sxgjk6qBzvWJtDAf9owG9JC0Zpiczyi4GDn
 wery+HWG8jfQ7aDLfbvXoQLJEI2EygiASd3OALkTgxsgAGiYvu+YGR1Hmd5I1t1CDn
 52LTtTQ/9EnB1k8LSCDbUTkuG2ArSxWf3+q/ls20lohkMyRu6SjBNfs3IQpfkz1AwA
 qqd8TOlj6rZKQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:44 +0200
Subject: [PATCH 08/70] drm/hisilicon: hibmc: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-8-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Yongbang Shi <shiyongbang@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FbUZ1XHcDyHGgghRXDUPVRHqwBKdGTF3LPzzxRnPcro=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSb8fPslOcSy285ipqHBX6yHP1DU6/Sqbjuqtytfh1
 A10i5brmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNJDGeslZO9uHH7U7V9tYWe
 QpxpfXFOLblna2R01beK2WjUX/K545CxKWMGj0rKMyGl9c8YTrcxNkz575Xw8uLBl19+l/P9lKx
 ZvGLnpqSb/SKfz/q4b/GIzz9ZuN9zc/eJzG+NE/ki1ys6PQUA
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

The hibmc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Yongbang Shi <shiyongbang@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index b4ab53db1c08..33402cf54072 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -489,11 +489,11 @@ static int hibmc_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 
 static const struct drm_crtc_funcs hibmc_crtc_funcs = {
 	.page_flip = drm_atomic_helper_page_flip,
 	.set_config = drm_atomic_helper_set_config,
 	.destroy = drm_crtc_cleanup,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state =  drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank = hibmc_crtc_enable_vblank,
 	.disable_vblank = hibmc_crtc_disable_vblank,
 	.gamma_set = hibmc_crtc_gamma_set,

-- 
2.55.0

