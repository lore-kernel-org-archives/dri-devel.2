Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B5606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaVb4/ls
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9793411277F;
	Thu,  5 Nov 2026 15:31:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4264811277F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B15C418C9;
 Thu,  5 Nov 2026 15:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8736F1F000C1;
 Thu,  5 Nov 2026 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892697;
 bh=ETksxGjrdbnjpf/hSHW2Eb8E1O1upSrUBvgX9QeQCgc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kaVb4/lsLRUOg6JC4c3PfalpbRRs1c/MJ+/viqi+WZSuNRrlUat55mFx+G4yKE718
 gEQ72MR1eE0bCS7Iaz1VuCOm8AIeqylTB4O7Cw2U90VnErPXSY584KJAbrEWwCh9GG
 WKFX0D3oVDjb0ZE8t3oMLO7YEHWBH1nmdeFy0mFZgXkhnD1b+lsoN9B9mVhIAXPIz7
 ZLlaS45e6faPrSwP0SALVZ88wEjq0z0id4wBtfkncgM8xpRRNes861mO0MTVCYLT/J
 W+XTiynm1Q83MzbCjnWpObVZuvteuCPVrmjeFrDWKqm9aoU4e4B5XcrLMyHyUkRgl1
 2Y6bzpLoZJW9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:32 +0100
Subject: [PATCH RESEND 23/83] drm/loongson: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-23-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=mripard@kernel.org;
 h=from:subject:message-id; bh=oTUiBrt0qVkRH9uvz7qqXmWO5rvbhgzK/WLdy/q0auY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjz/0RKh8d63f23/+ylP03kuCK9vZYz60LF7ddcVn
 cTfpjKCHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi/WcYG770fTjSXK0+d1Xu
 uqnrrFkS8/RczZXP9GtMlr81+9/C7JuhUy1r+r9dv8HetfU+a0r5c8Y6zWvxf4PvT7zKXv577c0
 j83JEdMKnah/Y2D9rS4Vunq3Kwkf1tzMWxv5qvipw96BzQ9d0AA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>
Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: Qianhai Wu <wuqianhai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/loongson/lsdc_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 5a13df31eb90..fbb2658acce4 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -248,5 +248,7 @@ lsdc_create_device(struct pci_dev *pdev,
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return ldev;

-- 
2.55.0

