Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FC606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NUKkVXXO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B5310E390;
	Thu, 19 Nov 2026 16:27:45 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31E8112573
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:24:45 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1b546061d58so4330443c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795105485; x=1795710285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zViofjQkPVVEUQkfBvPP0RNa3rX/Lm5exoQ3G0lbCX0=;
 b=NUKkVXXOvsG9Xlx4ISkSwF7eVUewhuksU81pgFkF/BW060OWzqIe037qfB+qR8QQSz
 rLnCpGH8bkhtVLwhGLuGqJv5CSp/WRupdq5KMGAaeYUrvWVvV4TC5DO2FPFYZOGwOAOj
 8V8Q3rSqJqtniLxLIWPqrz2OQrOp8qhrOgPJnBQdCHaeBKBE3sjJ8sSqNk9TbdjQbXav
 ln6uNn9RBeaY2clm+yDe5XYPUfhshSr2qygYw3gl2v+n+r2DeRrHr9OdnZvsMP5Ey92J
 +Tc0N5XQFLD24UzlTX6qzwHHllXqOtWKZ4AZpCJL+l9Mc7zI+q2fJLqV5P8Si52ugquV
 NUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105485; x=1795710285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zViofjQkPVVEUQkfBvPP0RNa3rX/Lm5exoQ3G0lbCX0=;
 b=OOCJGDyGimYqVVKUfI92nHdNqSTiqGSUgYoQosQ+VZQI+pktSzUaNjxXczuMq24zVt
 i0twJxBlhAESC55L0ouIK8lLdr2wThvOjYl69v3n8E8TRnKDTq5tV3lCF+ml8IhDUbQ/
 zCz5mU65n/ppGDem2xeFZBUrxZBKoc2ZGaJCdxaOKtaEZAo9ImIHXi5n/iat76oSdR2l
 xdLKyL3LvaQ3s7kHiGbP269YA6FE28IiU+b/Ylm+F/nsHAtEC+8Gb1GknXgRlLValRzc
 zfU78BFopbSKVHbIJ+1jA3N3PRGOGFn0vkWwyULHDGYA2UcAcQRYcZ8gjE5dbUD1Zq+b
 ahsg==
X-Forwarded-Encrypted: i=1;
 AL+hErF5tUouYMupHur7Ro6Dl9LeGRSeT+gMOgnriF7zXzTIC8otp5qC0kf5V23rXYjC5TDmSLex6fZWnzg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8901KZrg51s5Epz4sbhNo99jileIMQqSw4dVf2XJEQncRGfQxT
 KVV9crg9aAi3dS9lFmO3aekz7zs6Tzkuw48W/X5sKtMC+Hr/x1KKirZg
X-Gm-Gg: AYBFou3N1J9xL7EW0ke4ahdkRAXyI8uLVFLkaL3XCCMoywdKI710AKKkHdBAi6rCyf8
 Kg6kwXPnd+XPUMptRqP0kN2Em5pfv5n3d2yFrBbGMl1sNasahUKSxoJ0lgw0woobHpudUpLrZ01
 Np8FeZPrmlchq9LvrpWTva3cYVyYSWtB2Xm+uBu0GQ2z5cgGJY6CTJiVPNszeqOqGwcmi8uJpJk
 oX1SbDomAa92ZXFnoMGDx0GGzVtD6wsrN/zjLimtL8pk2cA1wKbCob6J7hG/t7FNB7LYMd+qHYk
 7hBEcmTu4al1j51KuYIqVRvlWaRuHpjBLMzLdur4kW9Q1jPJnEFtvqvm+olVUyu544O9YTPa0L8
 QRmoP73jtTpTOxNFra8i3P2NNUMQ6CUnRUMUd5/dxf/WjTlOZIPdTXPz+87RRVkG5RQAQD2UQRa
 hMa7ve3IUv+9kAvnuRpiS1jE6Yr+mHA9C0EA9KASSFtJvrWw1oPbWePUN5IIZvlONJ8Rx4jMOgm
 0XdXqzJWmUAxAbJNHpqM/TbulMQDe9bgbxCYm7vHMOD+VmqjUcPBoESwg69khRCwOzSqio2zPCx
 iHleIZPhQLrvvGDiFz91CdB7X9NTnesrrVYtSUuo7EGu
X-Received: by 2002:a05:701a:cc88:10b0:1b2:60ab:1e9d with SMTP id
 a92af1059eb24-1b55690cf1bmr152886c88.37.1795105484976; 
 Thu, 19 Nov 2026 08:24:44 -0800 (PST)
Received: from evo.www.tendawifi.com ([103.98.7.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55681301asm302840c88.8.2026.11.19.08.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:24:44 -0800 (PST)
From: Archit More <architmore303@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Akash Sukhavasi <akash.sukhavasi@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Archit More <architmore303@gmail.com>
Subject: [PATCH 2/3] drm/panel: kingdisplay-kd097d04: Use lowercase hex
 literals
Date: Thu, 19 Nov 2026 21:53:52 +0530
Message-Id: <20261119162353.12962-3-architmore303@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119162353.12962-1-architmore303@gmail.com>
References: <20261119162353.12962-1-architmore303@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 16:27:44 +0000
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

Convert hexadecimal literals in the KD097D04 initialization sequence
to lowercase.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Archit More <architmore303@gmail.com>
---
 .../drm/panel/panel-kingdisplay-kd097d04.c    | 242 +++++++++---------
 1 file changed, 121 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 6a3ecdcc1795..c801e94bc4d0 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -38,137 +38,137 @@ struct kingdisplay_panel_cmd {
  */
 static const struct kingdisplay_panel_cmd init_code[] = {
 	/* voltage setting */
-	{ 0xB0, 0x00 },
-	{ 0xB2, 0x02 },
-	{ 0xB3, 0x11 },
-	{ 0xB4, 0x00 },
-	{ 0xB6, 0x80 },
+	{ 0xb0, 0x00 },
+	{ 0xb2, 0x02 },
+	{ 0xb3, 0x11 },
+	{ 0xb4, 0x00 },
+	{ 0xb6, 0x80 },
 	/* VCOM disable */
-	{ 0xB7, 0x02 },
-	{ 0xB8, 0x80 },
-	{ 0xBA, 0x43 },
+	{ 0xb7, 0x02 },
+	{ 0xb8, 0x80 },
+	{ 0xba, 0x43 },
 	/* VCOM setting */
-	{ 0xBB, 0x53 },
+	{ 0xbb, 0x53 },
 	/* VSP setting */
-	{ 0xBC, 0x0A },
+	{ 0xbc, 0x0a },
 	/* VSN setting */
-	{ 0xBD, 0x4A },
+	{ 0xbd, 0x4a },
 	/* VGH setting */
-	{ 0xBE, 0x2F },
+	{ 0xbe, 0x2f },
 	/* VGL setting */
-	{ 0xBF, 0x1A },
-	{ 0xF0, 0x39 },
-	{ 0xF1, 0x22 },
+	{ 0xbf, 0x1a },
+	{ 0xf0, 0x39 },
+	{ 0xf1, 0x22 },
 	/* Gamma setting */
-	{ 0xB0, 0x02 },
-	{ 0xC0, 0x00 },
-	{ 0xC1, 0x01 },
-	{ 0xC2, 0x0B },
-	{ 0xC3, 0x15 },
-	{ 0xC4, 0x22 },
-	{ 0xC5, 0x11 },
-	{ 0xC6, 0x15 },
-	{ 0xC7, 0x19 },
-	{ 0xC8, 0x1A },
-	{ 0xC9, 0x16 },
-	{ 0xCA, 0x18 },
-	{ 0xCB, 0x13 },
-	{ 0xCC, 0x18 },
-	{ 0xCD, 0x13 },
-	{ 0xCE, 0x1C },
-	{ 0xCF, 0x19 },
-	{ 0xD0, 0x21 },
-	{ 0xD1, 0x2C },
-	{ 0xD2, 0x2F },
-	{ 0xD3, 0x30 },
-	{ 0xD4, 0x19 },
-	{ 0xD5, 0x1F },
-	{ 0xD6, 0x00 },
-	{ 0xD7, 0x01 },
-	{ 0xD8, 0x0B },
-	{ 0xD9, 0x15 },
-	{ 0xDA, 0x22 },
-	{ 0xDB, 0x11 },
-	{ 0xDC, 0x15 },
-	{ 0xDD, 0x19 },
-	{ 0xDE, 0x1A },
-	{ 0xDF, 0x16 },
-	{ 0xE0, 0x18 },
-	{ 0xE1, 0x13 },
-	{ 0xE2, 0x18 },
-	{ 0xE3, 0x13 },
-	{ 0xE4, 0x1C },
-	{ 0xE5, 0x19 },
-	{ 0xE6, 0x21 },
-	{ 0xE7, 0x2C },
-	{ 0xE8, 0x2F },
-	{ 0xE9, 0x30 },
-	{ 0xEA, 0x19 },
-	{ 0xEB, 0x1F },
+	{ 0xb0, 0x02 },
+	{ 0xc0, 0x00 },
+	{ 0xc1, 0x01 },
+	{ 0xc2, 0x0b },
+	{ 0xc3, 0x15 },
+	{ 0xc4, 0x22 },
+	{ 0xc5, 0x11 },
+	{ 0xc6, 0x15 },
+	{ 0xc7, 0x19 },
+	{ 0xc8, 0x1a },
+	{ 0xc9, 0x16 },
+	{ 0xca, 0x18 },
+	{ 0xcb, 0x13 },
+	{ 0xcc, 0x18 },
+	{ 0xcd, 0x13 },
+	{ 0xce, 0x1c },
+	{ 0xcf, 0x19 },
+	{ 0xd0, 0x21 },
+	{ 0xd1, 0x2c },
+	{ 0xd2, 0x2f },
+	{ 0xd3, 0x30 },
+	{ 0xd4, 0x19 },
+	{ 0xd5, 0x1f },
+	{ 0xd6, 0x00 },
+	{ 0xd7, 0x01 },
+	{ 0xd8, 0x0b },
+	{ 0xd9, 0x15 },
+	{ 0xda, 0x22 },
+	{ 0xdb, 0x11 },
+	{ 0xdc, 0x15 },
+	{ 0xdd, 0x19 },
+	{ 0xde, 0x1a },
+	{ 0xdf, 0x16 },
+	{ 0xe0, 0x18 },
+	{ 0xe1, 0x13 },
+	{ 0xe2, 0x18 },
+	{ 0xe3, 0x13 },
+	{ 0xe4, 0x1c },
+	{ 0xe5, 0x19 },
+	{ 0xe6, 0x21 },
+	{ 0xe7, 0x2c },
+	{ 0xe8, 0x2f },
+	{ 0xe9, 0x30 },
+	{ 0xea, 0x19 },
+	{ 0xeb, 0x1f },
 	/* GOA MUX setting */
-	{ 0xB0, 0x01 },
-	{ 0xC0, 0x10 },
-	{ 0xC1, 0x0F },
-	{ 0xC2, 0x0E },
-	{ 0xC3, 0x0D },
-	{ 0xC4, 0x0C },
-	{ 0xC5, 0x0B },
-	{ 0xC6, 0x0A },
-	{ 0xC7, 0x09 },
-	{ 0xC8, 0x08 },
-	{ 0xC9, 0x07 },
-	{ 0xCA, 0x06 },
-	{ 0xCB, 0x05 },
-	{ 0xCC, 0x00 },
-	{ 0xCD, 0x01 },
-	{ 0xCE, 0x02 },
-	{ 0xCF, 0x03 },
-	{ 0xD0, 0x04 },
-	{ 0xD6, 0x10 },
-	{ 0xD7, 0x0F },
-	{ 0xD8, 0x0E },
-	{ 0xD9, 0x0D },
-	{ 0xDA, 0x0C },
-	{ 0xDB, 0x0B },
-	{ 0xDC, 0x0A },
-	{ 0xDD, 0x09 },
-	{ 0xDE, 0x08 },
-	{ 0xDF, 0x07 },
-	{ 0xE0, 0x06 },
-	{ 0xE1, 0x05 },
-	{ 0xE2, 0x00 },
-	{ 0xE3, 0x01 },
-	{ 0xE4, 0x02 },
-	{ 0xE5, 0x03 },
-	{ 0xE6, 0x04 },
-	{ 0xE7, 0x00 },
-	{ 0xEC, 0xC0 },
+	{ 0xb0, 0x01 },
+	{ 0xc0, 0x10 },
+	{ 0xc1, 0x0f },
+	{ 0xc2, 0x0e },
+	{ 0xc3, 0x0d },
+	{ 0xc4, 0x0c },
+	{ 0xc5, 0x0b },
+	{ 0xc6, 0x0a },
+	{ 0xc7, 0x09 },
+	{ 0xc8, 0x08 },
+	{ 0xc9, 0x07 },
+	{ 0xca, 0x06 },
+	{ 0xcb, 0x05 },
+	{ 0xcc, 0x00 },
+	{ 0xcd, 0x01 },
+	{ 0xce, 0x02 },
+	{ 0xcf, 0x03 },
+	{ 0xd0, 0x04 },
+	{ 0xd6, 0x10 },
+	{ 0xd7, 0x0f },
+	{ 0xd8, 0x0e },
+	{ 0xd9, 0x0d },
+	{ 0xda, 0x0c },
+	{ 0xdb, 0x0b },
+	{ 0xdc, 0x0a },
+	{ 0xdd, 0x09 },
+	{ 0xde, 0x08 },
+	{ 0xdf, 0x07 },
+	{ 0xe0, 0x06 },
+	{ 0xe1, 0x05 },
+	{ 0xe2, 0x00 },
+	{ 0xe3, 0x01 },
+	{ 0xe4, 0x02 },
+	{ 0xe5, 0x03 },
+	{ 0xe6, 0x04 },
+	{ 0xe7, 0x00 },
+	{ 0xec, 0xc0 },
 	/* GOA timing setting */
-	{ 0xB0, 0x03 },
-	{ 0xC0, 0x01 },
-	{ 0xC2, 0x6F },
-	{ 0xC3, 0x6F },
-	{ 0xC5, 0x36 },
-	{ 0xC8, 0x08 },
-	{ 0xC9, 0x04 },
-	{ 0xCA, 0x41 },
-	{ 0xCC, 0x43 },
-	{ 0xCF, 0x60 },
-	{ 0xD2, 0x04 },
-	{ 0xD3, 0x04 },
-	{ 0xD4, 0x03 },
-	{ 0xD5, 0x02 },
-	{ 0xD6, 0x01 },
-	{ 0xD7, 0x00 },
-	{ 0xDB, 0x01 },
-	{ 0xDE, 0x36 },
-	{ 0xE6, 0x6F },
-	{ 0xE7, 0x6F },
+	{ 0xb0, 0x03 },
+	{ 0xc0, 0x01 },
+	{ 0xc2, 0x6f },
+	{ 0xc3, 0x6f },
+	{ 0xc5, 0x36 },
+	{ 0xc8, 0x08 },
+	{ 0xc9, 0x04 },
+	{ 0xca, 0x41 },
+	{ 0xcc, 0x43 },
+	{ 0xcf, 0x60 },
+	{ 0xd2, 0x04 },
+	{ 0xd3, 0x04 },
+	{ 0xd4, 0x03 },
+	{ 0xd5, 0x02 },
+	{ 0xd6, 0x01 },
+	{ 0xd7, 0x00 },
+	{ 0xdb, 0x01 },
+	{ 0xde, 0x36 },
+	{ 0xe6, 0x6f },
+	{ 0xe7, 0x6f },
 	/* GOE setting */
-	{ 0xB0, 0x06 },
-	{ 0xB8, 0xA5 },
-	{ 0xC0, 0xA5 },
-	{ 0xD5, 0x3F },
+	{ 0xb0, 0x06 },
+	{ 0xb8, 0xa5 },
+	{ 0xc0, 0xa5 },
+	{ 0xd5, 0x3f },
 };
 
 static inline
-- 
2.34.1

