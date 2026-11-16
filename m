Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D2606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icKVhQsd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8906310EDDC;
	Mon, 16 Nov 2026 10:32:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E443E10EDC0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD11F42B3F;
 Mon, 16 Nov 2026 10:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF001F000CC;
 Mon, 16 Nov 2026 10:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825115;
 bh=wL1meWLmR9d9gXqNHdrpiY4YZdVNQoeSe12lufqILyo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=icKVhQsdWkxrAY4SOEYK/vNNtJ+9HVA+bil1aSdClEwn/v28cX19JifHnBUuwLS+u
 j4yNay1b/9gv7Gd7Y1mVWveExE0pG6WNfYGsXKiCV8TOgA2240x2Crm+LZ0Ew32Lj0
 Az6TOBp9pK9jr2O3NBwQkdZxZLrSgWTgAyGK/NxG31pns0UcWT5MDYzw44cKTRFs0Q
 JiUshCKPB9LfEuHeQunorwX5cG2q4wCDnGxyx6ilXzexuT/r2UuhZJ9sCyZzkei9Cx
 UHSRlEYtenfbLu2ZKTxIsZXVh8RpgiKCGDiXUgJj5na/q0Xv/ohVR2qKFSptlzcoWB
 AsAoQC+ZYH0LA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:34 +0100
Subject: [PATCH v2 18/64] drm/mediatek: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-18-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=mripard@kernel.org;
 h=from:subject:message-id; bh=VyW5IuhBEXQ2ik9bYvLCSLjzS04fksE7SodiqkIW8Kw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bruzFS/m+rdzwcnNy1ZbfLhvc+Wj0vdwzpXNixPur
 Od1L53G0jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmIi3KWF9Ve/FimS3f0nsb
 d+1W7KlTj9zQOlM+rVpS8MUdpjUbDU0ZDz7cMvfvNk+GRIG9wixNpozVLExxhtcrGNs/nD7940m
 9q8FJrff/xTc+Fft5qsT5svu9S4yKP0pzRDabW3i8D54fJdAAAA==
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
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a8bf0690756a..33246645e5f4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -577,14 +577,20 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	ret = drm_vblank_init(drm, MAX_CRTC);
 	if (ret < 0)
 		goto err_component_unbind;
 
 	drm_kms_helper_poll_init(drm);
-	drm_mode_config_reset(drm);
+
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_fini_poll;
 
 	return 0;
 
+err_fini_poll:
+	drm_kms_helper_poll_fini(drm);
+
 err_component_unbind:
 	for (i = 0; i < private->data->mmsys_dev_num; i++)
 		component_unbind_all(private->all_drm_private[i]->dev, drm);
 
 	return ret;

-- 
2.56.1

