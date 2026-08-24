Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB5C5DF9B
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182C310E148;
	Mon, 24 Aug 2026 15:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gGxKTkXG";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF2310E148
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:26:20 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c2055f5a993so408419466b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787585179; x=1788189979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9F2J5SRbAwAJnLOAmG/aWzQgdURy+BfWx3XTRWy62I0=;
 b=gGxKTkXGiJ7UkIJNBDhj4c2CJKYPfbNQssK8sxL07JCsahTUDP8RxAvIsCCauF5Lzs
 r8Lk998x5VyGTdkN29q4sVHIktSSbq/mJ2Eqql4AANyUgm3RMNU83dWoQFdP2do+TYa/
 /Lyf4OfttjUt+uKJQvJlIovkCGo+7WoSK73c0YuUavYIHGhdiCsV7yhEwhwLJzaCjQKQ
 eYykSsKahiNDBMoa4G78/QCBhr4lVjWxk+b1+Ri3Pol2J+ZHDXoQcaQxSQ7CXj6LHgON
 hVgNQvgo+iDHgw/j10z4moBmv1NHps3BSu31SIgMszoLuTFxSOduNucGpVwbIupq58UR
 IftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585179; x=1788189979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9F2J5SRbAwAJnLOAmG/aWzQgdURy+BfWx3XTRWy62I0=;
 b=MzrQiXXHY68ear4Z3B8JNBzIZ1Mh9g7ufzmN1TA2ygRQQ/emSkJpXwFy8G8XRr3OJM
 b2k9zRGkBbIS30ccc/TDt0O41/mTQsHQjRROerxekePBeacYiVjpm4gQYVLq1t5Mqcel
 Wm9FUwiKKEXkBavTKqHOFJoqMOJV8H0oMbMUZC0uqGJEg37uAlXbiErMXnzV4P85n739
 0mv7Y1AtBVxdCBcAraAE8CpTo2KRUGo2KcksjZZGohepQqvy1lcK0noDQDb7FuMAxfwu
 6Xm7mHM/0d705b4arUNyoiyCPrBWbn7p6Lph3LVxCLNKTYesGu0xhdnMkBxPQjG+I7s4
 61rw==
X-Gm-Message-State: AFuF++mCKKQeNkiChnd2fo5TIHwNCNQRATAA+jz+BONc4Matuno2XWA0
 g2LDaEk87zgB7DCW8oufrd5gb4Qmtpz/SDOJ05Z5X4cxcJIyROs0q53X
X-Gm-Gg: AR+sD11i+zwPPv5bcCJGCC1riygoARzI4IF+n8xrVOKmeBiiu8Ph4ec4iBBI1zjBT7R
 F1jH12Kkc7qCNICcG/orGrZ64LNbquAo+Hw9XTA0HbAs99GXRU/XfkDEc9+J3exTwyUH9Gpdsla
 a6l2TegFcJJiRhhCngneMFcWUK2g/uHwHbnjejMUv0tc3+jIDNmStS6GE/b7WXng97vpq8z/sfE
 QDSfMnkqNInFiRyojrpw2d2YL0QiFT7ZFy9vKfK2q2wtV3CUBMOWTRUOM0slxNYhVhTF7TqElxx
 6GwNgZ2aZRIl6egZMK8MwmW0SJqO6Nc731URCAgfdTHDz7WbKKe9ns/YSIBQDfc547iXsN8h0fn
 kWlSYKoH+900G5fIfz9XAVneTmczhVkfLEvfJ+wCrfdezJgMFZoNy6bHvOXKlzIfBbltUmEqTzJ
 G2p8KZQq2glalXCQbbO9jf8gpVaycu7sXe2xE6Y8pKeBj3p7tLYU6aSlLIrgRBGxbYvgMc/MDCm
 3ZQ+ZqjAzQ4bmQc1025bFXxlEcRD3iJ5AgSufJMRu4Gf7oY7Qvo9yIxXayUHPBhJKSKgUUbirP5
 4jwjAd/JjWV6As2FI9mI3Q4=
X-Received: by 2002:a17:906:fe03:b0:c16:242a:472f with SMTP id
 a640c23a62f3a-c246b4af7e1mr3441361466b.23.1787585179115; 
 Mon, 24 Aug 2026 08:26:19 -0700 (PDT)
Received: from tapdecorti.home (cst-prg-46-213.cust.vodafone.cz.
 [46.135.46.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa97sm1158783366b.57.2026.08.24.08.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:26:18 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Frank Li <Frank.Li@nxp.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] accel: ethosu: Don't read the U65 rounding mode as a storage
 mode
Date: Mon, 24 Aug 2026 17:26:11 +0200
Message-ID: <20260824152612.751007-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.54.0
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

Bits 15:14 of NPU_SET_{IFM,OFM}_PRECISION select the activation storage
mode on U85 only. On U65 the same field holds the rounding mode, and the
command stream parser has read it as a storage mode since the driver was
added.

That went unnoticed while unknown values fell through the switch, but
now that they are rejected, every U65 command stream that asks for
natural rounding (2) fails CMDSTREAM_BO_CREATE with -EINVAL. Mesa emits
it for average pooling, concatenation, split, unpack, strided slice, LUT
and argmax, which is 72 failures of the Teflon test suite on an i.MX93.
Truncating rounding (1) is misread as well: it picks the two-tile
address path and computes a bogus feature map size from tile bases the
command stream never set.

Read the field as a storage mode only on the hardware where it is one.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Fixes: 6b7e0066294d ("accel: ethosu: Handle U85 internal chaining buffer")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index d50fed64d4d9..fa37a190e9ff 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -204,7 +204,7 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 			      struct feat_matrix *fm,
 			      u32 x, u32 y, u32 c, bool ofm)
 {
-	u32 element_size, storage = fm->precision >> 14;
+	u32 element_size, storage = ethosu_is_u65(edev) ? 0 : fm->precision >> 14;
 	int tile = 0;
 	u64 addr;
 
-- 
2.54.0

