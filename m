Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE4606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJewrb36
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3AF10EDC8;
	Mon, 16 Nov 2026 10:31:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0CE10ED7C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16914461F3;
 Mon, 16 Nov 2026 10:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5131F000C9;
 Mon, 16 Nov 2026 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825105;
 bh=WoProLCDQoys0ydmoIJ1y+M1TaKf2RDCy8kDGhjoHTM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VJewrb36jcXWGFjnvRdJCuAUEpZfeFJZOzkIy6ibFeSD/xFYMw6kRBqzXIJdXTIRY
 aJyT4NkX4E1IPz5pCeRN380zrhd4yt+nnjAcii/tJ0hpDKSKbswCkYEdQ+PMROGCZO
 LCBQnUa4m6q6ObuXMQujIOzAEUadnJENt/5JHG06dBerrekCQQG8PI78PyZ5EFdYoO
 WGhGn/CFd9cWjXAzVZkL/9ziazybklpM7wel23fPDLGGxdkNNgG066mjuLfaYjaYmw
 H3h3uzeiSF7gA7vx76GwjtsHV3IqZwFoYeSeHpQonrVc3JqFrQMVJqfzuIchBYslI4
 3DnoF2SuUF2ug==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:31 +0100
Subject: [PATCH v2 15/64] drm/kmb: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-15-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=mripard@kernel.org;
 h=from:subject:message-id; bh=w1HqhxqdpYK/2O7zu4O8fWqetLy3opl8efTb6vh66hE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brvlH43/e5Flg5XJE4/nm+xMulOaPnipdnYlXZbt7
 pYujrzdMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYSo8VYp9CclCv0J1lN9NUk
 5XRtzaA/ds9WrJQ4EJk08cu0fV9+SVhXbvttHGB7MMx9xjyf6TZbGBv2zpjRtODSfmNe3dt1z8I
 OXpzP0PaV18x4nVHgz786f+f/vrRbRsBROnHFx0fmCcwN8w4AAA==
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
Cc: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..fc8ab5124bd6 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -196,12 +196,11 @@ static int kmb_setup_mode_config(struct drm_device *drm)
 		drm_err(drm, "failed to initialize vblank\n");
 		pm_runtime_disable(drm->dev);
 		return ret;
 	}
 
-	drm_mode_config_reset(drm);
-	return 0;
+	return drm_mode_config_create_initial_state(drm);
 }
 
 static irqreturn_t handle_lcd_irq(struct drm_device *dev)
 {
 	unsigned long status, val, val1;

-- 
2.56.1

