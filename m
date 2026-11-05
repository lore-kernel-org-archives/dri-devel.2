Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCE606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrTmCWOA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49B21127C2;
	Thu,  5 Nov 2026 15:34:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CBB1127C1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F94E4352A;
 Thu,  5 Nov 2026 15:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85941F000C1;
 Thu,  5 Nov 2026 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892874;
 bh=sCC1C1SH37kKf0UFqSErSeUNFdm37U3I7jn+sX1Giwk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KrTmCWOAFHgRJ5nS9HEpvhbdR05bu8NrA6TAvn31E57aTwYrQkke7J1pNmbxcDbmK
 mILAnoaSjGYqOhzydgkULoYq+zKkBbLihm60Jimpc+DTeChHe8TytgSNrjxe2+Msvo
 M9UfNhN5EtoGDpWiXfDTfh+CvhY8TABbQDS3lNhBiMeg0PrzbCgbppQdIJSQUbGreR
 Wd011qVlB9TgHSdWbm/VgIn4i++tc5x2TCRVOx3CVfsRG7/s6P7iYd9YJnfnfxO/IX
 xjNt/LRFACqC5Y60DmxQEALe53V5vsZSUwL6olLSrvD8Y+fYdsPpWNUqRFIn2rGASH
 4axlWFVUEWtgw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:21 +0100
Subject: [PATCH RESEND 72/83] drm/repaper: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-72-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iS4fRNt5/IeAUBTtUES3EIYKkp0e0H0548+FERQvP2E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvxZx1qV18I98Y2c+28bnZ2HGHrjI1a73Oj76VaUx
 PUgKbi7YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkXRRjQ4vpXPsFNW4Gqo4T
 6p5cUFf2Yd8WzK/fYyNRYlf5ttTjbzbPJQbHjD4+k+e86rcDnZcz1hcfW/SkMnXX+vz+s9/z/aN
 eLb9VN+1wTP+sotfbAzxWth4tfKtyf+ucJY9czJuq9zwOOAMA
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
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/repaper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 25e6a7a4affc..4a0f55e3a9ee 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -1191,5 +1191,7 @@ static int repaper_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

