Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D02C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2756610E71E;
	Mon,  3 Aug 2026 16:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="naKIZT0u";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E5B10E71E
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso36278665e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773487; x=1786378287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WnZE5eYLucvHUcpEznH4hSEo3d2Mtfchio0f8Z2eXVU=;
 b=naKIZT0uHQ62RyBMn9dKyuK59ofyGfVYVLEfBg7DyEx4NnMFrVfQVUeIlg7mqQ12AA
 iTsb0JxzBA0eH8y9XFvXrJIjMAcDtBh8+M8r5et+j0dEJvwjPdSqgjZWzHSapRg8Pjx0
 HXpkWrWuM1fXBb7z8TZEbjR6OXWJWJKyHbCKeyrhRDd0rwzDqg+X6o/BHB8Cat+RPf/H
 6HB37a6+Adf5cEfX8blh8j7VObm3SiSHiaNmA/4+nr8WT2JEczbNVr5zyPNhkhQjK6oF
 Fv+DH3CVw/zATb+MIosykydckZM9t528EjW8dzp5X+fDmC5EZZ8s5QO5GTgdGCYUlG3E
 qBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773487; x=1786378287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WnZE5eYLucvHUcpEznH4hSEo3d2Mtfchio0f8Z2eXVU=;
 b=NgXQtS6lYfW1l6jl/o1jnUX7IRsjr2nd+BTn/zU/d1aeGV0AqW9NCpIJtfO5K4mSPS
 RgtbvumVk9WWAh5KnmG40V/QbIja/LvKnoQL0fPtumVXMf72Y+3Whk0yJQwS4HzUfWic
 Iu9pJyuTEytXoj4XbxOAb85xo/3l/V+ulMMbu7gZeN5BHMBAueWjnhFx2HK5WtZ0XgEN
 BcpYnhGoFh5jOrjBahkV2GmpuTuL6VI2/ochCquhAmU0ThUHOBg6vOxdL+PsPJNwI7T9
 fmk3P968RwXe46Lp27PkDm1sHmQDqkaeuTF99wDXsjWNmB1ZrMdWFZDR3SPkFv2a6RsL
 OeWg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqe6N6zwqpXq/jXWU10tBEQbOVcPEcCW7d8Vj/Yj82x2PwL8ZzHLpq2z1I8jiA6DcaH4zuvAbJFitw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywm5DIIccT4r94/aX55im3OEAaXOHf/xKyD5vC75c75RUOZDLen
 yn/tDruOa0WgNAAfEFLwz1Xa+/r3AoxltTGCXmt8oBDDeT9rO3dLmuAA
X-Gm-Gg: AR+sD11VxmRf7iyk0M/iL227hUwz1YR0hz2t7IqOgThvaRGO3WtrNnZBZ2b9BpmUDUB
 NkAIiv6ULdNqFeVoYuXMPggX43kabdRF+lRaMtRTwykrPwchH8foPWWw6LOBgpbHuRXOkSuO9bc
 suG3f8tsN3Pzx6MQfJLin13WXGB5jOLdx91XOdP/HGYmZL/iFezLkIAKmI/Eg/i5rsLFupa9Raj
 g8eyiotmXdzXL2ljM5OAaNgBpBdesbKCJKBCt2hPhwAh4DkoP0Wf0Rnv1M+0bGhLXeqzJKhY97z
 t4GTdTNcjSXndm3xvxsBCD+lwiwz3/dD9rRtXjiyH96zI/7mggxmyNRaCKs3sQABq0zOF9EziFF
 nHUeceIPRn7dBPE6bG7jzlCI+W9wmBaxgj0g/BysYF1BieWuwUcq0Kmo8ZOnKu8lIEPHwsBIfhs
 u01PqUwNBCZnxc1QK5V8l5hEkYwLuyoFppUu0qpOE9OImdKBfNSAcAGwW93jWyrElsW4wxgdhsc
 NWh6138pX5QEnpCZmORJq6+SgffLhcD8uyDiu2LpmjVWL6EIhu0DvtjEDP0vha6S9Hi5cknspw3
 aDYl5i1PZQVq2YghYdWLPOeZWfexFiZJdvyzblpLvLJIJ6pMekY4kadetj7nuMEyQ7pm4adaOT7
 fFODHNNdwIZDCcbP3Mg/yK//r6MDTnNP9v/FHtp/NzE6Pq4Lvpop5hm0dSEPCMfnmMNJFomzMhA
 yC5eZ/5jAy+4Xb4Q==
X-Received: by 2002:a05:600c:4f87:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4980c66c7d9mr217127655e9.3.1785773487184; 
 Mon, 03 Aug 2026 09:11:27 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:26 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 06/13] drm/sun4i: tcon: Drop TCON TOP device reference
Date: Mon,  3 Aug 2026 18:10:44 +0200
Message-ID: <871a3108086c15a483eef23301984c8d2254dfa7.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

of_find_device_by_node() takes a device reference. Drop it after mux
configuration succeeds.

Fixes: 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index ea7c90fef316..de2d66623f7a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1409,7 +1409,7 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
 {
 	struct device_node *port, *remote;
 	struct platform_device *pdev;
-	int id, ret;
+	int id, ret = 0;
 
 	/* find TCON TOP platform device and TCON id */
 
@@ -1432,21 +1432,20 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
 	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
 	    encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
 		ret = sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
-		if (ret) {
-			put_device(&pdev->dev);
-			return ret;
-		}
+		if (ret)
+			goto out_put_device;
 	}
 
 	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP)) {
 		ret = sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
-		if (ret) {
-			put_device(&pdev->dev);
-			return ret;
-		}
+		if (ret)
+			goto out_put_device;
 	}
 
-	return 0;
+out_put_device:
+	put_device(&pdev->dev);
+
+	return ret;
 }
 
 static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
-- 
2.43.0

