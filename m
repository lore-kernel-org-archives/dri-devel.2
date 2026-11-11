Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE67606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=6YPCgRK/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCBD10F336;
	Wed, 11 Nov 2026 12:22:41 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0233510F336
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=mZ+YfTL18HsVdL8YZNUUTUPVwVk+UCUNOsnK/2xOcPE=; t=1794399755; x=1795609355; 
 b=6YPCgRK/PttVOt7op0iaG0CKfbhS3RQJNJRZHIHbD28GZMYMvHBtKhPIV0FC0TYHah63cZdiyHP
 wgoxW3FjIw554uCxapp9ssHuvCXLMdN8p0KHELI82u62p73MxceIAc6cMrJ1pU0jsrdaaJiuGj4VH
 XE0JftdSO1S4k6K67mcQouF3PNntmNkytQuZXJCZlAKgs+qKsJPo5VtRvdOgH+V6mS1ln83xDtloL
 28LBjRx/Rzq0iYKGSY8/uu8+xJO1fESN1+oXcNlbV8u9UB/ASLvVXHZJn5uUr8EOyvfPp1RkSi2Cr
 Cr81LI32M0vY8Psb5gwxpGGY/6jxjIOr6O7w==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 11 Nov 2026 13:22:11 +0100
Subject: [PATCH] drm/omap: dss: fix handling deferrals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAPJd9GoC/yWMQQrCQBAEvxLm7EA2mhX8iniIu73rCEaZiSKE/
 N2J6Vs1VM1kUIHRqZlJ8RGT5+gQdg2l2zBWsGRn6touBh/XaWgPnPXBiqqwVeAiXy5HlD6kGJH
 35PpL4fc/fb5sbO/rHWlae7QsPw+508t8AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=31k+GywuKgPH1aDOshD9a7rFWejPIZkjp23zr87NNVg=; 
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq9F30t+ptQJ6jh9qwz4SprN0rYuR4nyZ+wkvG9
 gr8MkjFxXOJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavRd9AAKCRCEYUX6QCjc
 8QnKD/9RKTKkv0Rq2ZMvV5gBRp96kAyV2MVJVCMndbsN887x6didR2tVVzbsNalj5tO9+76jqcb
 IiXMci1nh/1kiW4brbIEigNLHEMgOOrvdL9yPyS+HuFhxpniZF/0bMJZqv0q0MBDh4GEiBfwwVc
 pBCygKmQQQ0X1d8LApBx202hdIRIHayWgHeJF8eLWcJxSLTj6mVknGZueT/0tcGMiNG5+YCEDy8
 VuQWHDE8uTIcbOFTy1vwRsVQitlG3OB5oEQHSZ5MsGl/qgVrbjTwuivic4QAUIYIoe3snm45ANf
 8fNJkzlCYKe03SQyTsfQDq3xwoouVIaVvUZXtQ8x24QqFBBbW/ZOCaahnP2FriVFLvRdIKC122Q
 HAz/wRlDeduGOskFJ30Aiu9xs9KZRcmUXHiAjs9E8XZHbEYYAhfYQjvBkSZhrqPOltcz7wfjD6K
 QmM9+qC/+tB/Ep0ErbIHAZ+VIfrST7Bx6Wxnq4go+lXus3ssqNl06p9bSnYES3j1ulkr1q1/Q0i
 qD1ojcR7q88zQQK0raxZF3wZWuwhVpok9fJ2644hpOOj7k4LLZKqOl2tkemx0f0QFhG0hLoUKo/
 hnRRekIFO7GgZXkSQHFy07kGovv/JUeLRRvvsIteMzZxzkOSaW5naA9jC5ZwfAGR25Fr70QrGN6
 YkKMbmZd3FqAJsA==
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
 drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 36d37deac8026..220ed7e003080 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 
 	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
 	if (IS_ERR(bridge)) {
+		if (PTR_ERR(bridge) == -EPROBE_DEFER) {
+			ret = PTR_ERR(bridge);
+			goto error;
+		}
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

