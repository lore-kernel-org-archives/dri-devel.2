Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C7606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=9FEBjT7T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B58410E46C;
	Wed, 11 Nov 2026 21:15:45 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBED10E46C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 21:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=YZA0mL/g+XaMvzLe7dWFyFSxxKt5KDjWkQKQzVStFdo=; t=1794431738; x=1795641338; 
 b=9FEBjT7TxexNoS6NZdxx+LkQY9rITK5LC7GQ2sBZ9TDlzJ6nXAiO+ZgLj+vv/ax6UbjyxiDyP3d
 yQ/sYgmJOadncbwwMTrm34oOrYeYk0zzZnCQZwfcY0FTbANRgAa1uRPjcHbIBzP8VTfHZSpAlQEW5
 MFyn2pzWqe5G/Wzc4XkoVVtCVg1jn1cuHRepFvv7kWQB+DVY+9f9qJevSQvJxIOc7gV+NXaD/zwG4
 /zEuk/D/Ys8S1ZBhu0f0kU8puWs2l15l1c/2SJwnQN7yn/cdhCSlUUBOclgp1M9SVtI2pTbyfmqb0
 CamjPJpbhKs5tHorG+XYqMjJkBNTC8NybZ2Q==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 11 Nov 2026 22:14:02 +0100
Subject: [PATCH v2] drm/omap: dss: fix handling deferrals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAJna9GoC/42NTQ6CMBCFr0Jm7RhaoSSuvIdhUegURmMxUyQaw
 t1t8QLOrL6X97NCJGGKcC5WEFo48hQS6EMB/WjDQMguMehSG5UOh9mWFTp5oNAgFHMAPb/RN+R
 r1RtD7gQp/hRK8l59bX8cX92N+jn3ZcfIcZ7ks28vKvv+mFkUpnekG1d3tjL2cqdHsI6OHPwE7
 bZtXzMUpenVAAAA
X-Change-ID: 20261111-gta04-drm-regression-fix-f7ef51c66ed3
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, 
 hns@goldelico.com, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=K1/4nD/blrdt+2IR2NBi2vL6dVXYJQk3uUPTTqOJMN4=; 
 b=kA0DAAoBhGFF+kAo3PEByyZiAGr02pygYASQbIaOAroFim6KIiMDqNJTEu+EB3RlC6JZu8djR
 4kCMwQAAQoAHRYhBNjrEJkvRMQTVcd8WIRhRfpAKNzxBQJq9NqcAAoJEIRhRfpAKNzxrPEP/1LO
 z9iYICL7nom1ymbXEbuEKu20tqWn7eVXIBr4I+ceFI5mjKUatVEmYmFHWS+J+E0DtU6ls+Ybf1p
 nyVK2W7UACJ2DotrtKLGdphTcyRuyXpzqLdQtviI/fMOTq/VGJr3dsiy45r3JTcx6ezxOEAkW9b
 5mwQGwtpa4SQYrgBs93DuEb5tOEjLM7Kg9pvqGE39jeUC3K+8wan2YkLR9v4sMiFxKkvM8GGPoY
 hQrZUBmS+luTG6mNMrQfbY6cyOf/s1IFFCZso6441UIj/XF9MSxPS2TR3QFAyLXCSNOYISy4i5T
 MScssy2ZyxFspdtiSQZn/JS0tBHv6JhaxScHbCz8GAwOji0Qxjo0Nqk4UodBn1wt8mcfGyplzLr
 pfIiqqPpeCl8DToFqeuEUEdjxeSHtiT/FEJyUAoCbnv9e8LitSQ5CyPfUynKxH9KOhpEy9eXg8L
 rblKMqyj/Drb3EbUE6XRXr1XJIlRzD1Jq5by+bp3i9hvkGtuCxLPjJ/2fHpmh1iHufrTML4HOPJ
 1qcccX5fa3QIhh/FHs8XCpI1veksy/BDxVoBDdAb1066gNR00NKsL3YQa5R0IwKXtB/hhBxV3i3
 mjh6brmjri+P5E/AkkLagifMcyTSl0eMJjzcDIx80ByTamb3Rgu/Uhs9TyEPGf42uwOrev3+m7q
 CZGGG
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

Forward the error given by of_drm_get_bridge_by_endpoint() if it is
EPROBE_DEFER to ensure output gets initialized later when available.

On GTA04/OMAP3 no display was found, but it appeared after doing
rmmod omapdrm ; modprobe omapdrm

Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- do not use the error goto
- Link to v1: https://patch.msgid.link/20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info
---
 drivers/gpu/drm/omapdrm/dss/output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 36d37deac8026..b5cef5093a883 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -24,6 +24,9 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 
 	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
 	if (IS_ERR(bridge)) {
+		if (PTR_ERR(bridge) == -EPROBE_DEFER)
+			return PTR_ERR(bridge);
+
 		dev_dbg(out->dev, "failed to find video sink\n");
 		return 0;
 	}

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261111-gta04-drm-regression-fix-f7ef51c66ed3

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

