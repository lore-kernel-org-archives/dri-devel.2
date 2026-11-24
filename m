Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB5606A323
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XO7c3SyH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB51910EC98;
	Tue, 24 Nov 2026 16:57:10 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A696810EBDB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:57:03 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so30968285e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795539422; x=1796144222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jbUthWdRMMj51XLCsqRl2+vc3sJ3ROclkjX4dXujHnA=;
 b=XO7c3SyHY7d6DcUPBg8JIahBADVcjT2mKPiJI0bs/0o3h+U1lT35OA5DrIQG0NsY8o
 qR/OPD5AkmO6XQfC+mA8U2vvwSKO0ZRiWPZdKLYoUIva8+B97tX/6lCVQHloK+mCCLAO
 tjldV3IQqg+d78jkS9Vx9BphtR3m3+59hmNVZov5tQGDNM4FPEZSg4YiFy26ZdD9C56W
 zpwdlzMpe07gQg4bVsKEwnwFTv+JKlYc0uIlFSa4ZEsDJza+dOrezgIK+75MoVkSF41/
 WBi1ZNaxOXB++fQSCPEij4RUhc//Ga1W2mx3S03akVeqX+ctRfBHL8TFZUEmkV/l7vEv
 gaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539422; x=1796144222;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jbUthWdRMMj51XLCsqRl2+vc3sJ3ROclkjX4dXujHnA=;
 b=QXO+rlGSBNoqyUOsGzfBtBm62L21lcd+qmTmOqG2yc4kY3cRQ/Gt1GpmRYhDx9f220
 ytU5eFBtL2dWEH8LpWqN4h+KphlC1u8kaBBF3f+27ieXPb/E1qLXJIim8sxHLXh64qd6
 PIRTEeindSjwzw6DUVhr3CXXDSOb67zkyL9LVnVJBxLHDctenHlnGNVAFGlTTEleKhmo
 Iy2ljb3RRS3iIG6jGpO53ytwFuyrSTphJjyYbWhKB3TqysV1xPgxZvg0eOxzwd/Ja/N3
 ZsRIqLWwBpsOeX3ATP36/F0C+JcUrSQ408moyPoKGKWNBGGQcuiftV9o8R2gUzRLTB1n
 wohA==
X-Gm-Message-State: APuU4Z8ntUzL6eyF8ySyDIF2ua+IDnXnbIEVgESx3KKAs5THtMA/q4t1
 uD5vTAwLWx30Lj8KuwLodYS72Us7VGo40zs5ChZ/xVV5ETfQ3ZRptog=
X-Gm-Gg: AZFdTZeWFOfSBzM2y/vWX041lrm5fvqsSC3Z/LGwOkrsLFIui2W9ASie21vD3wTy8mZ
 Ve/6TcTI7q4upyhBDpYbsiW3HhnnZ6oosilYyj68ABGz5acTI9ZF7GToWjawtFAWAGegSYNPZwf
 igGm+4Iczefg3XGNwDwtoi7nPasPt8BoMs24AF4zAc6wJyg9ZNnYb8m/vws3Am89cadewf3t6NR
 sGBKIiY/s5ro/9pMkUwGGEahGB8maA6q6rZ9sr6aSK+MomfiYY4pCE6JoEAMN4rSS/FNOWJvF4l
 Soj6HTy/ias8utZvZO4UGai0hbxhxOIUkp6M0svrXeyI6PdnbRYYgR1vRXDQ5nusowjfTjV0BAd
 m6lRZj3MNL7npdpyTLi7C3kxEUHNKNS1J0doTYLfoO66FDl+ZbjI2ZDpv/tUe3YnAdwYny8TPDK
 eTlIT5CdEXZtCnGPxAP2DaNdtDmtE93P1mbPQgdALPelHjrkmp2XWLVZ9IJw238CVjnFpzB8brP
 X66z/9rYx9/b2myWYUKLTy6nXeh8U8zp+BU/WNOo5KTMecu+TAM+l6xt84ueg9FEwP+QVkiYyux
 gktA430l8hX468N9LVeTZ/gNDPR1+w==
X-Received: by 2002:a05:600c:c173:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4bb88800134mr299004235e9.11.1795539421842; 
 Tue, 24 Nov 2026 08:57:01 -0800 (PST)
Received: from Vivobook.home ([80.116.179.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm503208055e9.10.2026.11.24.08.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:57:01 -0800 (PST)
From: ivano <ivano.cristofolini@gmail.com>
X-Google-Original-From: ivano <ivano@Vivobook.home>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Ivano Cristofolini <ivano.cristofolini@gmail.com>
Subject: [PATCH] drm: add min-backlight quirk for ASUS Vivobook 14 M1407KA
 (CSW MNE007QS3-6)
Date: Tue, 24 Nov 2026 17:56:43 +0100
Message-ID: <20261124165643.10016-1-ivano@Vivobook.home>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivano Cristofolini <ivano.cristofolini@gmail.com>

The ASUS Vivobook 14 M1407KA (AMD Krackan iGPU) uses a CSW MNE007QS3-6
eDP panel.  Its ATIF backlight caps report a minimum input signal of
12/255, so amdgpu clamps the PWM backlight at 12/255 (3084/65535) —
far too bright for the lowest slider step in dark environments.
Windows on the same machine reaches visibly lower levels.

Add a drm panel backlight quirk lowering the minimum to 1/255
(257/65535), following the existing Framework entries.  The panel is
stable at these levels; no flicker observed.

Tested on ASUS Vivobook 14 M1407KA, BIOS M1407KA.332, kernel
7.0.0-44-generic.  Boot log:

  amdgpu 0000:03:00.0: [drm] Applying panel backlight quirk, min_brightness: 1

and writing 200 to /sys/class/backlight/amdgpu_bl1/brightness now
yields actual_brightness 257 (stock driver clamps at 3084); maximum
brightness unchanged.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6198
Signed-off-by: Ivano Cristofolini <ivano.cristofolini@gmail.com>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 2d02383..0ee711d 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -54,6 +54,16 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.name = "NE135A1M-NY1",
 		.quirk = { .min_brightness = 1, },
 	},
+	/* ASUS Vivobook 14 M1407KA: ATIF caps keep the PWM minimum at 12/255,
+	 * which is far brighter than the panel can safely go
+	 */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ASUSTeK COMPUTER INC.",
+		.ident.panel_id = drm_edid_encode_panel_id('C', 'S', 'W', 0x143f),
+		.ident.name = "MNE007QS3-6",
+		.quirk = { .min_brightness = 2, },
+	},
 	/* Steam Deck models */
 	{
 		.dmi_match.field = DMI_SYS_VENDOR,
-- 
2.53.0

