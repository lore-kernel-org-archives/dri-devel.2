Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBA606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1t9rwkpY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDDD112326;
	Thu,  5 Nov 2026 10:32:32 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C0710E263
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:32:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3D53C4E4078F;
 Thu,  5 Nov 2026 10:32:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 13E225FF85;
 Thu,  5 Nov 2026 10:32:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 49F4A10328CE3; Thu,  5 Nov 2026 11:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793874742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DsgoMji8HX7rgl6ZGaufx3E3+p+7GyuvqFHqS6om9Q8=;
 b=1t9rwkpYEKkmnKWt5gH0nZeK5jC94h9sdt60Exw5LTtqWFoP7CGuiZTThOaZlSviDhoeJ/
 nD9YlbRx/Bx/HXhHzUc7OTkB92VesaFxxY33kBSdH9u4v0TUEaAMOiVgbD+SZm2glCphY7
 T+8f78+f6EsfrP8lDam0AI628omTsV1R61m/XO2JKlhLVcc6wRxFUtiiS/HOlMx/gwCZaV
 OOE35QiRyKP1vRwGRvR8JnFhhGdA/auK8/ZtOo7VS2mFOxLsIhcL9dJ/xOgYWriq8gbPcr
 lfGIagC/E1It3P/PZ5K1+g/rC2CabeAR92wpUxDNduTrB63g6R3HJiileIszBQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 05 Nov 2026 11:32:07 +0100
Subject: [PATCH v4 3/3] drm/vc4: dsi: remove unnecessary intermediate
 pointer computation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-drm-fix-of_get_bridge-build-regression-v4-3-906ca343ac1b@bootlin.com>
References: <20261105-drm-fix-of_get_bridge-build-regression-v4-0-906ca343ac1b@bootlin.com>
In-Reply-To: <20261105-drm-fix-of_get_bridge-build-regression-v4-0-906ca343ac1b@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This function computes the 'dsi' pointer from the passed 'bridge' pointer,
but uses 'dsi' just to obtain the same 'bridge' pointer. Remove the
unnecessary pointer dance, just use the passed 'bridge' pointer.

Suggested-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

New patch in v4
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 581b54e04ce4..ec008f766dd5 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1159,10 +1159,7 @@ static int vc4_dsi_bridge_attach(struct drm_bridge *bridge,
 				 struct drm_encoder *encoder,
 				 enum drm_bridge_attach_flags flags)
 {
-	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
-
-	return drm_bridge_attach(encoder, dsi->bridge.next_bridge,
-				 &dsi->bridge, flags);
+	return drm_bridge_attach(encoder, bridge->next_bridge, bridge, flags);
 }
 
 static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,

-- 
2.56.0

