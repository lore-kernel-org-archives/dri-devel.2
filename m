Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AB606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3aSCV43
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5361127B3;
	Thu,  5 Nov 2026 15:33:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD3D1127B5
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C787F600AA;
 Thu,  5 Nov 2026 15:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0538D1F000C1;
 Thu,  5 Nov 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892827;
 bh=ieLaoxiZpaSCzw7Rb0SmIY3nxnmdEYsLch0hsDVDYz4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=i3aSCV43YxJxvjas398VOrBtSlnyShx6XCWgOzCPeCETPiE1v2sDmePhZVK8UAiPE
 IFpv0PwnyXg4QfAdSTqBkFu4yqJEJR3a8uDuK+oSMPNwnllftKfISr/eTXAX9pdlNj
 vsjfXGeWn+Ovs8qc74caaVRCKHHAzWKnd3kQyvLNSvMpdj2UlyvAPy2DRF+0SyfT2U
 lHgSiYMA81YGe8I4WsK8nUiVVMfdMPAlognFOAyoAD7UB7E9NedyDY1WyaJwRd7Zvg
 /pFLz2wCIkxqlqrVODZntoy0nGXMgcYecG4yUkNZQUtMZSyQa0TQhCBF/N0ugEdpbI
 vXkvJHqHEPEYg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:08 +0100
Subject: [PATCH RESEND 59/83] drm/tilcdc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-59-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=mripard@kernel.org;
 h=from:subject:message-id; bh=39IXTOdZ/PGp4fXZsC5cn7WFsDv4OWBrOuDuZ5Smq/8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnw/tJxh/bcrS2a8UU6u/WXGfC+h3lKncvFxc1ahb
 Xaq18qiOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEijYzNlzNLlr8YZ4kt4Xz
 jONrNC5l61by7tlbKHnA3HjmUtnCA7vEE7Zvve/H+1NLgn3+jbkxUxjrUx4Ub5DVTefYOfNVvci
 y7RyJziZ/RJyOmsilfNjgMZU3+93h9ZeWT3C7PWNGmFVWf9Q/AA==
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
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..da718d9cb1d6 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -423,5 +423,7 @@ static int tilcdc_pdev_probe(struct platform_device *pdev)
 	}
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret)
+		goto stop_poll;
 
 	drm_kms_helper_poll_init(ddev);

-- 
2.55.0

