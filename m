Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56F5C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F15C10EFA1;
	Tue, 15 Sep 2026 14:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bq6Bznz5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C5110EFA1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FA58600C8;
 Tue, 15 Sep 2026 14:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826761F000FF;
 Tue, 15 Sep 2026 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482305;
 bh=n8nP0WtMbBqSnmNb2qRlE6esngDX5Tt2NEjTq4xX1QQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Bq6Bznz58guAhJKpyfy9Q8TKmc9v17rciFmeQQMxjggGzUSRSbz09C1hmwRHO/lHj
 TNzXS6NyWUEjxJ3062PFMXwaaqAdJ01f9DlCyy/0NlBAznJX7ElL7SOXrgxr5JryMf
 vudy6ATDj6scZ4gnIUgfI8Eb/Sn9MQqG4rZkX/1FC5HEaxETSF9O5K11lv7XZU+thf
 WvW3TeDh4AuKDFYS5Zx7j0V0LO/fLuYKLy7nFK2kSgNWvVdjKW2nQ2RmAfPhmHc4Nz
 NGtEugvCk54aKbz51MvOUsqh5MDzf+tempjZDctbFOjDwUv9F80si0bYxjqmBnW9un
 1coz5BQPNaWxQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:44 +0200
Subject: [PATCH v5 03/11] drm/gm12u320: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-3-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=mripard@kernel.org;
 h=from:subject:message-id; bh=N/PpkSsVbK2W1thjjmo8vh+dqUwZ4Dx/CGPuNJToiy4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ/U2Lj2u5c1y8Mu12PSpx0WZfeRsS9omMse63Ni6Y
 p1Y0fs3HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiRbGM9fXmCs88lr9z/3Uo
 ZFtF2cWr1Y/jM522K0zV2Hyu0kFHe57AG4Mstu1t8y7ULZ5RxLzRi7HhLe/Fw8/8HCYe1704OfN
 JbEDiJJ7iuxWrltXdYfxk9fmz96q5JudMlJba2CrMXfjkxoa1AA==
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

The tilcdc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---

Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/tiny/gm12u320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 754617722a0d..ddc19cd3e03c 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -650,12 +650,12 @@ static const struct drm_crtc_helper_funcs gm12u320_crtc_helper_funcs = {
 };
 
 static const struct drm_crtc_funcs gm12u320_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= drm_atomic_helper_crtc_reset,
 	.destroy		= drm_crtc_cleanup,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 };
 
 static const struct drm_encoder_funcs gm12u320_encoder_funcs = {

-- 
2.55.0

