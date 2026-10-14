Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F539C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4918910FED3;
	Wed, 14 Oct 2026 17:29:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5CDC10FED3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29D1F602D3;
 Wed, 14 Oct 2026 17:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDE21F000C4;
 Wed, 14 Oct 2026 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998984;
 bh=w5w+eWO5cx55gME82p2Bp1UWoBtpLt6wI7Kh78yNfnU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SS8SJrjgaURGPR5a2xKdfN7fe6Pw8tG0d5uzcEDc2iy3Lif0AUF5De8Muou/WClof
 0mPNUW6qWz+DVUuGXgGvmjXPd7r9QgghCqdltpdMeKi8niOfNf/OyP5TBCzRthVTIM
 S+BoZrco6xcl8s3s3ekcLB77RIx8aJcmUsAUih4h/6X5m19fWWe+YEWvtPlvKuHPuf
 KgoynWKz4t/MVMWyYEr7ox0yge1Uq7u5xx9Usd0V7jICL0LgN1TgQDmwRWhNfHJ5wK
 zDZmW6ekDgxjjOqHH/iU0t4Hw2Fbuak2u24nCtkRqAzxZOwuHFeC/Cc3Pl/EFuasKS
 ope1lkY741R2Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:05 +0200
Subject: [PATCH 42/75] drm/tiny: arcpgu: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-42-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alexey Brodkin <abrodkin@synopsys.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tSPbBJGRiYglFNkI8W6OUOwKJAftVeTxjo8Rd5Z2iMg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8dIqmmwBSmpstgzCUldtHxveXr1s63q4XcvPFTn2
 7Kxzet2x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIjTZjrawdW5PShPM3C789
 a9o7+edXmyO5Rz1Mha7/TndIjPawfPohJfXbnPuHDGP5jpZul347k7E+ZV8P84T/x07fKo999rm
 ESXcCr346T6Oeu+busBd/HCLeft4Rn5covHz3MpPeBQtEt10EAA==
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

The tiny: arcpgu connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alexey Brodkin <abrodkin@synopsys.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index cdbf28db8fa1..d0463bbb1dee 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -96,11 +96,11 @@ static const struct drm_connector_helper_funcs
 arcpgu_drm_connector_helper_funcs = {
 	.get_modes = arcpgu_drm_connector_get_modes,
 };
 
 static const struct drm_connector_funcs arcpgu_drm_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

