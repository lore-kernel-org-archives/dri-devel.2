Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D531606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXRa2Ruj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95E910EDFD;
	Mon, 16 Nov 2026 10:32:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 594E910E0FF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 417F640D91;
 Mon, 16 Nov 2026 10:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF211F000C9;
 Mon, 16 Nov 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825089;
 bh=TA6zOrFesw7aL50cbKjrnaUaPtu6yX6Cj/zeufIhDTw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RXRa2RujQfLiU1DzXZsVHkcl7GQvPrVFhT5dynOQuAYCo0PCo5KeH8HsvIsfxdiFB
 mO/nm5tVHadSWd/8XS73pZYRJCpHmvEobMpvMzVy5YUVwaLNphT58t+eSBdDyX7soG
 lgIpkSlnLZNpoH/x9ATnkOq6HXkXcZlxEUGq0fBWvoAM0W5Oq4/D8XziNa5FaFgVP1
 bb3z0VoRGuxUY9uvdUG68pB6WRDPazOBly2PL1bjy2yBmA4aiMFUiAQJ7KODo9LfLk
 r8BdLZtR9lAUmvlQJXLja1n5B954OwP01TyNPMLOig/JDKc/Jwly+Phu2kUA9QDNc+
 lNCwZ15dvK8GA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:26 +0100
Subject: [PATCH v2 10/64] drm/hisilicon/hibmc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-10-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Yongbang Shi <shiyongbang@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UByDnV+ThGFjxtxj4TO0HplD1HfbJJnpkIstgpvBvIM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brtYPEm9ElBwdVKrQf1yyxkv3zDFlL704T9S3cD1Y
 PW1HL8jHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi5rsY6wPulEavzfUQECjf
 d6Dj2sszHiL1Oz1XMak8mvGsbr/xv+d93eWhgfHWCxdsZurbFxS2nrFWzE/8++NjqV9iso88Ndj
 zSWiL0Zl9Gxeu3VW1aMPKX5XWtXvtF3MrPY67fD54gorJ5Ys7AA==
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
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Yongbang Shi <shiyongbang@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 272a8ab6427a..029a2e13b98b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -409,12 +409,14 @@ static int hibmc_load(struct drm_device *dev)
 	if (ret) {
 		drm_err(dev, "hibmc msi init failed, ret:%d\n", ret);
 		goto err;
 	}
 
-	/* reset all the states of crtc/plane/encoder/connector */
-	drm_mode_config_reset(dev);
+	/* Create all the states of crtc/plane/encoder/connector */
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err;
 
 	drmm_kms_helper_poll_init(dev);
 
 	return 0;
 

-- 
2.56.1

