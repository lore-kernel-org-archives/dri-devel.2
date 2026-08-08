Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E057FC5B56E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9ED010E657;
	Mon, 10 Aug 2026 06:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hRp7EkFN";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA5910E092
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 23:21:35 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-4af173320f9so416200b6e.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786231295; x=1786836095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiJX8qY4m/Gl+WOQ3C6pY3ZsgDQqJAp9f5uHxhFARuE=;
 b=hRp7EkFNwfeduBvgOHWUyNMXPxYr2FiDiEsoiCaL7QxghLLRbnhIvPhsoXUMj0+nOr
 XygVMZwcYRq9SjnfpOkjjCM5w95okOcYAE9U313dbvbyDAKMPUAwJaWpXzADNGG5o1UB
 H/6NTE6xsO2SamVeNV2tJwjOQvgKYq1Y1ToFxqJtoHKTgPWi2jkhLwGwcTyMZYF0aa6o
 HHtwqTNSra5yBHibkAg2+DDzfYKEoqe1vs3gzjPOy0fUxTCREX3z5JtQ+zLHuoxKlqFH
 cAK7hWzrjiSPRuSOp3st6qlfO+eSigH2uKsQXcmGo1fZs6nUMrwCRZIEhGaguRvjdsH1
 C8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786231295; x=1786836095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiJX8qY4m/Gl+WOQ3C6pY3ZsgDQqJAp9f5uHxhFARuE=;
 b=S35ZV0E+7fVunIR8fmVY26iXhYKrp3pR26VEu2a5lygKt9jaCHJ9JtJA1xny4ffBPr
 clgyONsqVDA7X5yMAvnKdpsPQWCYWayteGp8tDxtIorTJZifZFThU98gh83dvU+qdAju
 Ltc3yOiJ+x47cKaHVzUJUfVnrNfyAJzrDNUVtDEtQzIJSzIK0Dgp3pD67ahPsDoXATUm
 bje/TXmddeSju88iXVAo89HhTrU1AmUg95BWehEyG/vXeaCy9OR4ZfPkBasa0OOY2/s6
 32y37l8lL+qcawwouYDf6mZ86UREvslf6y1TM6nnv+JDGQfeU4+NHUfbdZa1CNXZbYB9
 a9Og==
X-Forwarded-Encrypted: i=1;
 AHgh+RoThT5pXBt8Dj9Ehp4z/Ef546AjQCvMX8JnuJrq8COKVSIrZd8wbNCMICjeUOYokrE30qIn27g+90Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuLYE6mCSrtQ8UNb1sDUuQ/RYcI92D2C3QxOZqHARjkcHbziT7
 bMiJag2FPlSikqOPrZTh5tsqMbyHj1U0gLsAnjXzCy3R26VDqOs8SPsQ
X-Gm-Gg: AR+sD11Zaess5RdM2OugRFek980JGHd6TqGTf/jVU0k8BkkprkRShVyiyHIEqNr7Gqz
 ct8ODp0q/nBOUaw79lzRewjJcapZlCIycLQvpf0B0HsWrLcA+wXPhzZaiokiqa1lzlm48mzS5KB
 jUvNAbLZjxzWelYkgwMPn7FB/USmZxd8Mxu0DTK/uQ0HlN137ay2KFOPT3Ax2RgNyCfsPjCvFi8
 XzKuormwUotwO9xYHX19QQA6ejMdAQGxJuHbLQ4UWgjvIaYeO7TiuJRLOE2VCsuFYku5hDBhcNY
 vvraKU7DvF7yOVZ0K8GtdxE1Bj/QiIcUV6pbccTooDJ9AEXKS7iV6UgkzQEgVl43oqKVg/8clOM
 HNNsY1gg2JbRBEwDASBro8yIti6Nr7ys61DAiPU9+IMjGQYf/DYIe6kD7XzAWplHPViKRuar882
 a/b0pt5nvL8B6GY8jIkWuistKrja4EqCqJzzAOxqx37pue8vmxfzBfkMXYirEuC5MMIwsoJHtWT
 GS+4ZkG4gA2PQG6+89/DrUqCbDn3wIXwA==
X-Received: by 2002:a05:6808:c3ed:b0:495:ff85:d33d with SMTP id
 5614622812f47-4b133471288mr11124028b6e.12.1786231294951; 
 Sat, 08 Aug 2026 16:21:34 -0700 (PDT)
Received: from davr.damaestro.us ([73.3.255.173])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1af688c1asm3026269b6e.17.2026.08.08.16.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 16:21:33 -0700 (PDT)
From: Jonathan Steffan <jonathansteffan@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Steffan <jonathansteffan@gmail.com>
Subject: [PATCH] drm/edid: Add HTC Vive Cosmos to the non-desktop quirk list
Date: Sat,  8 Aug 2026 17:21:17 -0600
Message-ID: <20260808232120.23817-1-jonathansteffan@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

The HTC Vive Cosmos and Cosmos Elite head-mounted displays report an
EDID with manufacturer ID "HVR" and product code 0xaa03. Like the
original Vive (0xaa01) and the Vive Pro (0xaa02), they are VR headsets
whose panel must not be treated as a regular desktop output. Flag it
non-desktop so userspace leaves it alone and can acquire it via DRM
leasing / direct mode instead of extending the desktop onto it.

Signed-off-by: Jonathan Steffan <jonathansteffan@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index df3c25bac..437751ed3 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -245,9 +245,10 @@ static const struct edid_quirk {
 	EDID_QUIRK('V', 'L', 'V', 0x91be, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('V', 'L', 'V', 0x91bf, BIT(EDID_QUIRK_NON_DESKTOP)),
 
-	/* HTC Vive and Vive Pro VR Headsets */
+	/* HTC Vive, Vive Pro and Vive Cosmos VR Headsets */
 	EDID_QUIRK('H', 'V', 'R', 0xaa01, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('H', 'V', 'R', 0xaa02, BIT(EDID_QUIRK_NON_DESKTOP)),
+	EDID_QUIRK('H', 'V', 'R', 0xaa03, BIT(EDID_QUIRK_NON_DESKTOP)),
 
 	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
 	EDID_QUIRK('O', 'V', 'R', 0x0001, BIT(EDID_QUIRK_NON_DESKTOP)),
-- 
2.55.0

