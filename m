Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1A606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K2cpN58Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFCE10F2D4;
	Tue, 20 Oct 2026 07:36:09 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB78D10E0BD
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:08:37 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1dec056ddso2034535e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792246116; x=1792850916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HsS7zD1Uucl5hqez+slw3pwoFAUHw9mJSijEO6l6OA0=;
 b=K2cpN58Z2/yj9JwLncFOX9sOh8EtGkaNYm5cezWtW0s4DC5ZJECDzsEafk64Wf8anT
 e9N4S4Kx90iVYHu51NEc06x6CdbulWSCpYbfT+RRLuusCrlhLXlqdRE6KuyWhxlnxlBz
 f5DLqg1KtPBHYahuYI8zoByMVkGCYrucWxTwmFC1Q7y3Bi3irjmK2dd/V34ZAqMwJkEU
 jxTYYoZ+hc9625tywYbtqd7C9ee8sODui0CGgFijQyydv2XjxKvMaypUIn5N5U6+2alZ
 YkT71pqTxWq2/c9a5TAGmpuDkAxWqHhxPQS1sTbmwTDMrHPG75Gu1DCQxw+bABfAkjdH
 GmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792246116; x=1792850916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HsS7zD1Uucl5hqez+slw3pwoFAUHw9mJSijEO6l6OA0=;
 b=qDVeGxULzJ3LlHwCDDwjtTHczTjhwWjwZSq8W4d39HDR0eKc25cmdtdF2bM3Z1/Yhw
 BlCzHf2+zBpPeQTHC2Og10lOpWYnaKgeny3M6l/WQtrYAn6jGbNNe/TujnemjzayXJ5a
 BlH0CH8T8Z2A5gVuJYOhHJS2OHHrEPVAb2r2YPK5JQLQcCyDsOOTBe2PGxlpVCvKavVs
 SO7+ERIu34PG5lJl7STePApAOSXnFTGp03+/Vb1JaoxLFfqG5I9bvobIELooe1B+UPGO
 60cbw7/N6Q8o3jjNrageYrjxnUm3GdNrcba+zjq8e9qxRfIz9sMXcJjrVHzJb3dthMBR
 n8nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFRrg9AX6k6dYDsNbUzcPItNdarih4xEw6rwqMrcXWoR6myNJ11esUvWCU2UiquDOK2FogFfPR2B4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNqHQoncoBkWVBdBlNURTz3zAakO3K/5yLuq3SUMQFyqLSfiI/
 H6/aWQUrFOhWpwPcAItCzvz2nO2+XjbYVpBJzRle82waz3Ros4A78X7J
X-Gm-Gg: AYBFou0cZb2pV2YKs2A/iW2l8N3HmOjzdhHVneZW+5dL3x+QoIoUVZaU4mJItcakwKv
 /JXucALWcC39dfI0al5hC9Z6EbLq+yZR+JJwyoAbgIVacHOSx83wMDukoFMbJMohuus6HqjDR5W
 7vBPigtVB1tiYDLar3QEUsobxSSDbWTtQESEzKzPG5kvri6lcOdXpl+MWnGoyEq27uK8KJB86I9
 ap1Pm9BNpXB7AOdBgfa+aXx79G3Af7wuY9K2tUF+Pu4ZRBCbGcLTpvzuBYIoJQb3BLeruXkLzQR
 57wDkPg4WsReR+8A3oClwcDNdynmA01Eg4+qVvP2aRSFtQi2e8cpNXvQNPe50+7duPiYA0wV+qD
 Qwq38u1W3vTHiw7Wp8eKTZFMzHbqGK4HvfDHH2XWhGnwp1cjTewkVR14pwuelExZnoDBAh9hB8q
 xIwKEwa4tU33hJuBv6+moFH4EwWZRgjRalcf5bj1JZp5P+IzjrRG/cSOos0gHVGSQH8zb5kUyhD
 xVKWNSnwmAxlp9sVVvmz81F8ucm6Grf0N4v3L7chi6FyTemWYO7koTog0pwALWwJObm0vHzkhzp
 iA==
X-Received: by 2002:a05:600c:34c3:b0:4a1:df11:45a9 with SMTP id
 5b1f17b1804b1-4a1df11472emr20823185e9.4.1792246115663; 
 Sat, 17 Oct 2026 07:08:35 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:08:35 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 0/7] Input: edt-ft5x06 - add SPI transport and FocalTech
 FT8722 support
Date: Sat, 17 Oct 2026 16:07:48 +0200
Message-ID: <20261017140827.290666-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FocalTech FT8722 is a touch and display driver (TDDI) found in the
Nexphone (QCM6490). Its touch controller speaks the usual FocalTech
register protocol handled by edt-ft5x06, but it is connected over SPI,
has no flash and runs its firmware from RAM, and shares its power and
reset with the display panel.

This series:

 - splits the bus independent core of edt-ft5x06 from the I2C driver
   (patch 1) and moves the controller bring-up into a helper (patch 2),
 - adds an optional per-chip boot hook, used to download the firmware
   after every reset (patch 3), and a per-chip touch data register
   (patch 4),
 - documents the FT8722 touch controller as focaltech,ft8722-ts, keeping
   it distinct from the display side of the chip (patch 5),
 - adds an SPI transport with the FT8722 firmware loader (patch 6),
 - lets the driver follow a DRM panel, like i2c-hid does, so the touch
   controller is powered down and re-initialised together with the panel
   (patch 7).

Tested on the Nexphone by Nex Computers. A board DTS using it will
follow separately.

Luka Panio (7):
  Input: edt-ft5x06 - split the bus independent core from the I2C driver
  Input: edt-ft5x06 - move the controller bring-up into a helper
  Input: edt-ft5x06 - add an optional controller boot hook
  Input: edt-ft5x06 - allow a chip specific touch data register
  dt-bindings: input: touchscreen: edt-ft5x06: Add FocalTech FT8722
  Input: edt-ft5x06 - add SPI transport and FT8722 support
  Input: edt-ft5x06 - support following a DRM panel

 .../input/touchscreen/edt-ft5x06.yaml         |  37 ++
 drivers/input/touchscreen/Kconfig             |  15 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/edt-ft5x06-spi.c    | 475 ++++++++++++++
 drivers/input/touchscreen/edt-ft5x06.c        | 585 ++++++++++++------
 drivers/input/touchscreen/edt-ft5x06.h        |  33 +
 6 files changed, 957 insertions(+), 189 deletions(-)
 create mode 100644 drivers/input/touchscreen/edt-ft5x06-spi.c
 create mode 100644 drivers/input/touchscreen/edt-ft5x06.h


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
-- 
2.55.0

