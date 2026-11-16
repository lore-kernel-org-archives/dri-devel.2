Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C98606A33B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWUgqVO8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F01C10EECE;
	Mon, 16 Nov 2026 10:31:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5061810E843
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C80856288C;
 Mon, 16 Nov 2026 10:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18221F000C6;
 Mon, 16 Nov 2026 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825073;
 bh=+QdHq32lmpaziVRSepQ7UD2bf71RxUG3LlDjorjmWbM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kWUgqVO8oj0B7OOvv0rFxEqL6Rxkahs0r7bXpCGdMy2CJjBvYkv43QTl6Zq/BTVEj
 JAJJu73hgcCGZCrH3ch5b8cGzKBq6shGxz5QOCouP/9RZJT467izpR/j+PHZUwQZPZ
 Pvz2uTEklkt+asbUe5azu4nu9yL4N8GFb4g88OLDEtUFJYtBvAQfA0tVYZtALbTq3b
 3YZOkCPRohz8+GUZRgYbzOBDV+HK+Rjp3aTQc0O2vKJ6+iOaQPfciHBhdpwyqymaUp
 NZs5hZHS14MiD/kXWjPUU/jYcwtzcHE4ugXCD+FnDr5efEdQIJXcenu9gdhuA2Oz8x
 CYbiMrpbVrOyg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:21 +0100
Subject: [PATCH v2 05/64] drm/armada: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-5-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=mripard@kernel.org;
 h=from:subject:message-id; bh=eT/63kxlNU4xRpZ1KxBsQE1OKK9P+Byl7C5rkt3ejr8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjvl7lv+Zg2j/UW52+wr4mq5tJgi89f8fMy44c7Vj
 WeK3p5W7ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+arCWF9bKSgvoZgxOU5h
 omCe7FPv/O99bd99Hu6fWD3/5lnNgk8xb1ewG9o1TNYOnaMe9/QTE2PDMaYJtiUFyscOJSz0tJa
 sW5dd1cp1+ynDUpl5x85KFEppSWvevc3hu8tv4rpvV4zFZuwCAA==
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
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/gpu/drm/armada/armada_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index cae25ad66c74..5c19923c85b0 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -124,11 +124,13 @@ static int armada_drm_bind(struct device *dev)
 
 	ret = drm_vblank_init(&priv->drm, priv->drm.mode_config.num_crtc);
 	if (ret)
 		goto err_comp;
 
-	drm_mode_config_reset(&priv->drm);
+	ret = drm_mode_config_create_initial_state(&priv->drm);
+	if (ret)
+		goto err_comp;
 
 	drm_kms_helper_poll_init(&priv->drm);
 
 	ret = drm_dev_register(&priv->drm, 0);
 	if (ret)

-- 
2.56.1

