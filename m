Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5807F3380B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F8210E4BD;
	Tue, 17 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLTR0n5c";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453DE10E147
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 14:58:14 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so33736535e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773586693; x=1774191493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zPStZFLXZ4Dkse9i5qAiZ3opia5BJZtkwKvg+f1kXhY=;
 b=WLTR0n5cuWuY0kloE8+mvCfUmQ3JrBq1z6XF+h+3Q+Zvap3/+ts/SpMWQEEUBKTjSW
 yUvYPEKM4dRPkLL4c50Cn0VFzQ6sCYCHCtFvbmB9d8VP8umCwi8Lz8sZk0GW/rHqWJcS
 DMzRaAOht0aHldqLGl6QWsB06e7VTPSXlXyVlA6kBms0jVZn6aQ3gnc/K5TIrFGHmwU5
 6y1XjMSVL7mP9kU5d2Nh2JCh6sbGgefgbmmSDh4/nwbamLWmKLRppRqWQiwgx/zl3B6o
 CETiTHX7hDcQgKpwU+U2G4ca+PAIrF0dEoSG7cgu0rtk84jna/CYeGfhJJbH9MzqChX4
 mpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773586693; x=1774191493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPStZFLXZ4Dkse9i5qAiZ3opia5BJZtkwKvg+f1kXhY=;
 b=jbodt175QR0HOPd7v9tP2vWXBzRNnxfkgJlofKyrfDPCpwZu0IGZU2UycVm2D4JsRF
 Naovl6UFqyk4eDGQd0Xq1X9zHHzSKgE0rh1LgkBykYPh1X+WHTvqRBKqYnAzHtw8XHEu
 hvXTdHsXmDmFxqBwF/iAWknCW524Yn4/29kCDG9pwJyIoC8FaNgOA9nk/Lv6IqiuPqyS
 0wHIYFSnwgOcv+WEchIkSEck0FIG7t/nmz9aNoA8tKK/IiEoMPFnxcUS23p3Bwtb7zqo
 GE1RVaGNMOa44Gieo0fAX4O8OGz45JatgLcHr2Qpfuwe9eTey2Y6ZMC8Osdm0kRkPAEn
 +tag==
X-Gm-Message-State: AOJu0Yzv+YX6fLs5+F3QjcdoXowGjeL5x0FqlgNE/xVKhSWwIS4MvDpz
 DTdf4X4LAa6zInUs58NUgL9BTBsQtLSkKPHbrpCoUOhoYz8iELZFL5U+z90X2arM4Ag=
X-Gm-Gg: ATEYQzyp/XKrNTv0UvFx3CL3lerWCd+VuBItBR/Juix2KK+p16GAyVBlAf/uEZ2Bb7p
 zxluEHLoMps2zvpUQUhQr3VW1U7QfK5PbXzFLZ7G8R100aVvKvaoSMXCnEK4s25UjjLr5FFCYBI
 p+uBL6lTvU2XNfV9etl3qYho7orPKvXEDsgSlarkIiOmHZHFAzhjXD5eGHVI+aBT/7HZrmDhIey
 k5RVrW2j5561Demo53qXFbcZyHyoFhsZfXby+uhGQh9mswGAsi7otvtXDKoILMgIFQ43qEVt0t7
 sgQwaMqTddvXtzSzaWYsRoqkMVpOiEwi+CtNwZ+DveGAslQ7frzcmWGgYJSZdUNEEyMWBLMnLLm
 hhgpnXE0sMkyYYFp1H1toOCKbVdSRRSjICFcR4cTk9/ySslN5b/frxBfuIJw82klvL666VdZc4x
 nUqoQHJzUM2fyZxcjQESg/XgR5nFd4VJ99hEdOWC3OFuNQvp789OhuFBT9s7MoEe+4JNraFfkC/
 3W3KMSMaF11OjUpoNhIYm1bWU4Fmg==
X-Received: by 2002:a05:600c:4689:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-485566cf80dmr161809475e9.3.1773586692556; 
 Sun, 15 Mar 2026 07:58:12 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f708sm763476945e9.11.2026.03.15.07.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 07:58:12 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kit Dallege <xaum.io@gmail.com>
Subject: [PATCH 4/5] backlight: cgbc_bl: fix kernel-doc comment for struct
 cgbc_bl_data
Date: Sun, 15 Mar 2026 15:58:02 +0100
Message-ID: <20260315145802.24224-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Add the required 'struct cgbc_bl_data -' prefix to the kernel-doc
comment so it is properly recognized as struct documentation.

This fixes the following warning:

  drivers/video/backlight/cgbc_bl.c:29: This comment starts with '/**', but isn't a kernel-doc comment

Signed-off-by: Kit Dallege <xaum.io@gmail.com>
Signed-off-by: kovan <xaum.io@gmail.com>
---
 drivers/video/backlight/cgbc_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/cgbc_bl.c b/drivers/video/backlight/cgbc_bl.c
index ab27e14338a8..6b70cd2f0ddd 100644
--- a/drivers/video/backlight/cgbc_bl.c
+++ b/drivers/video/backlight/cgbc_bl.c
@@ -27,7 +27,7 @@
 #define CGBC_BL_MAX_BRIGHTNESS     100
 
 /**
- * CGBC backlight driver data
+ * struct cgbc_bl_data - CGBC backlight driver data
  * @dev: Pointer to the platform device
  * @cgbc: Pointer to the parent CGBC device data
  * @current_brightness: Current brightness level (0-100)
-- 
2.53.0

