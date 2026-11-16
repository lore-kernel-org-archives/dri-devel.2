Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C6606A336
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOWz5mw4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092DF10E171;
	Mon, 16 Nov 2026 10:31:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EC110E171
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7F0E62887;
 Mon, 16 Nov 2026 10:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E156E1F000C4;
 Mon, 16 Nov 2026 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825060;
 bh=to98+DcDmiGeCwQfoQ2VZDTmwt8a8ZGapdZ7nqsXj5k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hOWz5mw4VsXbd3K3Xa8wjwV4Pyao3mt/T6x92bFB8OjglVqxNGlmZ1JCl7QSs1Oaz
 /Wj0UBvnnByfibS/2hIZfndy6d4wJRKMqqKDG+BNhIpQ0EYqWVc+20us0sQbpO9our
 Prk2LhZuFEwK/t5HPQXudOH+tZRDNyAsYJpS48zf7MQO8gWh2o5JkeWA38W2Dwu9bh
 XX71pBNdUZBywGGZBAirTWTk/Rbc+6D07ov4CW6Lx0vQOCdKCPG4+pzPvambtc3cXV
 HUgQzmoeiHHqe74xQcvFaVzHRT/U1iOySwYOSNw+OcgkpKvLAzXQTeEfAC4hWFcIKk
 QlYIRFbPC2/kw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:17 +0100
Subject: [PATCH v2 01/64] drm/adp: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-1-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <k@chaosmail.tech>, 
 asahi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tAVQBol0Lhf572Tv/c1kcRUOOJZcfgh05A5Vz6JqObk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjvcXmFsp9d2YW+CeDVT1xNnthd8u1K4up/ZWE49V
 Vf+u/Z7x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIcRdjw/XWVQ2sWus9Li93
 uZV4sM/g3ZzrP2zYrp6VYSl9vCOsaNn9ynlr7328zW4akstfO3M1G2PDm5LNRsm3RKUKazuZe4v
 kLPWLe1t97y/VOFRpt4h1vcEU07t376jJVMpvz4hY4/fBtAMA
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
Cc: Janne Grunau <j@jannau.net>
Cc: Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev
---
 drivers/gpu/drm/adp/adp_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index fdf0e6316175..795e8a5d3b13 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -448,13 +448,11 @@ static int adp_setup_mode_config(struct adp_drv_private *adp)
 	if (ret < 0) {
 		drm_err(drm, "failed to initialize vblank");
 		return ret;
 	}
 
-	drm_mode_config_reset(drm);
-
-	return 0;
+	return drm_mode_config_create_initial_state(drm);
 }
 
 static int adp_parse_of(struct platform_device *pdev, struct adp_drv_private *adp)
 {
 	struct device *dev = &pdev->dev;

-- 
2.56.1

