Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mRdVfb/z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C3510EC8E;
	Mon, 26 Oct 2026 08:38:23 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D6B10E4D4
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:19:42 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e977109392so15024515ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792999182; x=1793603982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/7E6cgyW6mVxkoKzASfvoF0lL55yu/HxxMm8OCrYBiU=;
 b=mRdVfb/z+slP17ZCBuVVY5tmoHPzldUs7iAmkuJC3jh6JFjkgE2PH09B0vHFpo6Aln
 9UsHeBthE1GrGro0MnsGoimBl73CnoqP0md+kXHR/95rXJ3ScZByhBk/ukjHTbHRrHU4
 zR7WMd+4XuKpKGRp0+YT9EoU8O43e1+50vwgu8BFqptDvRhMd9ZgRwgVEM/EWvpnTMVU
 lCKMqjxAcyCQHvPW2Pql9ubfL01KDC4zRfUeGSEp3AUI6w1wNCO7qVhZN+EzIL/7qHud
 0OqAr7TqLrBBawQzelFirS2BWB5THOzAx6VPOfToWrLjheHSzaSgljGUQCJhuqy3OESd
 Q10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792999182; x=1793603982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/7E6cgyW6mVxkoKzASfvoF0lL55yu/HxxMm8OCrYBiU=;
 b=Uf1bhTQjLBZOL9WsT+5MTWmhuY9SUZRZhNaq78eOhIvhUTJKbKHiIgxpPZtPjeiEe4
 INZJPFX0hTQrVOBQZ8t6sx6Wf/Ks+mzgZKCMjpkqLspgIfDmidsKKxeGecE4Y6HiuFCx
 UBUVX768PYnbWWQQjru75VO2xGhRDv00+2+Onpc9GkxHxVyiy/77vtlF5/AJ/5l4nClG
 ZibMMZIvKgSv+7dUcDRV2Zw1TnZu/ZSJ+34nEL6TuI4jkxCpkZOUa2igYSSz1zx42Sbt
 s3nA0Prl3XCaOKfrsMcSfMw2OnXpMoFFKy2MD3d1J5fpd88XKNZ4G7nl6qohsqWkJkY2
 ugnw==
X-Gm-Message-State: AFq9FYIeUti9meXLcbeScpzB4uVgVun9zRzecgT3vhNgYWAtKCIGbl0X
 jiEG0IpmvAwu7b7RVLNOsweyho+03iRgM9Y2kNoXKECTURFCKcnlO43qLy/xWMunnlI=
X-Gm-Gg: AYBFou2Jy2IGSw1QxO+5Dpr/zhbI15S/OxH0TUHuVvRzK/PSIvTq7Pv1tI8HoC8jHEx
 OC/tTluhyfv9Vpz0VrQuc7qvnDArgaq9Cx/g/t0+kv+faNSeWqnqQfxGaGjWecSGsR1zgkOVZbb
 L4TP8K5t2/DXh9dsbponjOcIuNR//qXuRy2vJRzAngEg3qkhUhufCW/pHxN9hszedJuVOQ/+/+O
 lO6t0Spjv7MjEwQ9c3BXTq4BEAtDX9U84uBTuYd6X2EDdc0M6BzkI+3gAqDbqHjljQC0OiOGSG6
 OzTZmC1ZrNo7Oa5WXw3jydukCTRRIh8BAahrKx0lO4JWuyc11YWKBfdu133vhv8EkyACfMo8bJg
 iv8rHbHjbY/RT5sorKQBOD2BGRXmiQQe32MuHl4tb0PA7CS1Ckp0Llyt/bgTNabzIt2l1Zx8nNy
 LE9r96S6/wqpbU/Y9Gj8GuQOTbkGopU/6nWI4ZZTLV9c/ac/1nGGzV04eFovbEEjEjJrBhF1gXA
 ftxkdu28ganAl/on+MLKD5Z4NKDszx5RycWqWwKMLc8gcM7anDSBMZxBmNjjapFzJsUZb8wBEUe
 66klMB/dol8EHyqL9zv5Cl3LMmikiwNRJUqSe1wyqX9O2p9MXzhKxWssZpZPseezz+SVYjHWzeq
 9oGr0bhVIMomRzR3AqiD1c1s5p09tpNhDU9z57x3Ug7FdyAoAUnLSqqaGjXWJl/RbEpabrKUXWE
 0Q
X-Received: by 2002:a17:903:1446:b0:2e9:79db:449c with SMTP id
 d9443c01a7336-2ea9c84aeb4mr49477755ad.47.1792999182204; 
 Mon, 26 Oct 2026 00:19:42 -0700 (PDT)
Received: from
 codespaces-ebf30b.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b14f5b0sm12546835ad.39.2026.10.26.00.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 00:19:41 -0700 (PDT)
From: Karthik Sarvan <karthiks1mail@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: louis.chauvet@bootlin.com, melissa.srw@gmail.com, simona@ffwll.ch,
 Karthik Sarvan <karthiks1mail@gmail.com>
Subject: [PATCH] drm/vkms: Set preferred_depth to 24 for XRGB8888 default
Date: Mon, 26 Oct 2026 07:19:33 +0000
Message-ID: <20261026071933.48366-1-karthiks1mail@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Karthik Sarvan <karthiks1mail@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531..10337889b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -146,12 +146,8 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.max_height = YRES_MAX;
 	dev->mode_config.cursor_width = 512;
 	dev->mode_config.cursor_height = 512;
-	/*
-	 * FIXME: There's a confusion between bpp and depth between this and
-	 * fbdev helpers. We have to go with 0, meaning "pick the default",
-	 * which is XRGB8888 in all cases.
-	 */
-	dev->mode_config.preferred_depth = 0;
+	/* XRGB8888 has 24 bits of color data stored in 32 bits per pixel. */
+	dev->mode_config.preferred_depth = 24;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
 	return vkms_output_init(vkmsdev);
-- 
2.55.0

