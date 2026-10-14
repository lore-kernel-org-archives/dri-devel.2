Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097BACC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6292C10FEF3;
	Wed, 14 Oct 2026 17:30:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7210510FEE7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AFEB404FB;
 Wed, 14 Oct 2026 17:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B707D1F000C4;
 Wed, 14 Oct 2026 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998999;
 bh=aNm3JAfa8K4S+OIgEC8smRMtCD17sctT3fLQ6Z+GbdY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VYl/EAQNArtoPlidtqsPznAdRfVEcu1EvfjMMfUEeOrKFKu2vICNbEIL99f3fsFwZ
 ZiyqYLjXSah+Txp5tWboAx6WV5opWdsV3y8sm4unPd2h8VbOPrptZYgYVCrf7UU3s+
 o0ZiRrJKFrhYGD+qC+I6qvN8yp9zq4TThiSqDOgUF9jlWodvNiywnqhUZEaCTe8cxO
 6w7JgHfBmIOoGPkzXnkB+PFw3epdbST5wNVCvlvA5UUnb2f3+72Nzg0Am/x3UXHCGX
 XKq2rMQWlOFMyI/qU64CcTHd/pUQNPkjhxoHUQfBnAPc7LCpz8h2NWppTaLXxveBFO
 yv9ABpJNynuuQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:09 +0200
Subject: [PATCH 46/75] drm/tiny: pixpaper: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-46-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yvw+k5V231LKRaRwFvih6w3iag2Z9JDfHL6jQZmsfhU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8d5a4vNUqo6LF1zY8JDVj8vs20sR/XOZHwz3rZw5
 vTkiqsiHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi/RaMddodnoc/7dtiG/H5
 5emTUzjlzz8Sd5v7SvbWT3eDpsoEKyXLjQFb3fZ+mmn6Iyx9W1//RsaGZv99+xV231ik7Wjv1md
 24OFOjYYJ0RPuShgel+nUjw9/Yvv/6wu2/8q6e9uZujjOn30JAA==
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

The tiny: pixpaper connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/pixpaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index b69e7c30607e..331656b1989b 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -989,11 +989,11 @@ static const struct drm_crtc_helper_funcs pixpaper_crtc_helper_funcs = {
 static const struct drm_encoder_funcs pixpaper_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
 static const struct drm_connector_funcs pixpaper_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

