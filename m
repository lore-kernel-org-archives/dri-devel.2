Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07892CD37B7
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3830210E623;
	Sun, 10 May 2026 10:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O7kjZKjU";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253ED10E0BA
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 13:19:06 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488b150559bso22007785e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778332745; x=1778937545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=No5okmpafzlZdEog/24G+YrUBfbZYhR0LHn/C63TIY4=;
 b=O7kjZKjUCKwJFfuD1Ml2Y7OeF5rmQN33F1gwQPhsreDdhuZAOI8pThRid3Wq18wUuE
 Uj2zHxBdbhnh5+LcL/vSow4OpWIxkSZ3AZ/26Nu+Gn4voArGX5pbuvqFTKsDzR7NOrBR
 dHxFjzvWz3cs32tsbL9Bjw+63vfOsoYeMdXU3akR+q4Bp7vDp3ipoYzt4zBq02sK5xMW
 j+p1DYdl7ACwHbB/3vfw3cjy+0EJ+fOr1HJBQulZViDaXPOEBX+yvzAq4Pcv8ixs7g5o
 /cfS7/8IyVCzrvucW4j1wIzC2FkWHXHvHqA6uaf6M4hbIH2VJPUK5tWvf7DzTipv2NmA
 R92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778332745; x=1778937545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=No5okmpafzlZdEog/24G+YrUBfbZYhR0LHn/C63TIY4=;
 b=eMTf7kWBNWw/BCKX4FjvyZNamdIuc1+l56uyodj6aVwYgcnMK/nAntwVw9q+t64yiU
 Cr+e/zgnqqg3jBRmEfKUBhMCllvv3IOv/GMA0XJRUmOVLQiz5sF4kdB9Ax1CTD21N+QK
 fNYavSjU3noNJ8VQQFf8Z+YYt50JTDiudH6skdz2mhPe9JyxzqX76VJW47Ac8ahu0kIu
 ubQYU+0IAq9nuXYITitEhYcUC5Rchh7JMPnCnIE+aYqKvpChCEqxncRLpk7rOD1lqq3Z
 RL2dY2cQGVasCcOPVNAm7/yEiR7jDIzqy+68um8WnSjqI79ApVU9hmgSuDQjWtlNVReA
 WHBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OdeI2b3AYS27aHaTgFantd8W+g3XB2PE1N/8e9jNbffaVdAEuNdi0py0fsskna41hicbsOUKrLNE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyALzAcTNaKwAEM7c7r2SVCWC6iAcxcUhV3Gkw8f8oVu/nCjIbC
 PORrUs2p1vCxa7XusKBMaZc4Wf+B2j0O/AzgLPCo9Rks+lRTO+w6ptbm
X-Gm-Gg: Acq92OFkTEkqX78HBByxZI0VVGKFPHiWdlWrr312aKlxpfINc7kHbHV78CY9rVf9uEZ
 +MLcyw/zRu8hRXWjuVvu6bVmJikWZNDWsA6T3oRowy+f4mLhfE8Ck4/3qmOrLBBqt5JmVA8WI+w
 6pDa0Wpirz6sFVuj33kMgyBku+fAlFfTaTPWwiFA5Mmi1YCCs14YXFSqjXJJri4U+gegt7lsjRe
 V+YPuL5Q8OPy0dPlGfSJLcV3aRDO8JN/L6TQQAxfTFwg4WhjgUkAQ67MOkkQl6Qteho/WSniWN6
 25D4VKZIgxBXBUNwvZqELGcvnTiNaLKhYyYeB1oDMQp8B96YSdUYG2tQLcrpcRHunPrk4yNAr5R
 YRV+y7VUMM5C3Nbjx4uFYvc3NIxokVI4dTld/DIfevbc79Njw7oEv5Gv21XeZssFOSlArHjham1
 hI67tIXBXjgpSGZUWV05dAIdlu+2pI+F4nMJ40xwgv4h+5
X-Received: by 2002:a05:600c:3507:b0:489:1b0c:8b43 with SMTP id
 5b1f17b1804b1-48e706ad0e5mr39164175e9.1.1778332744382; 
 Sat, 09 May 2026 06:19:04 -0700 (PDT)
Received: from RM.localdomain ([92.53.30.157])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6daf496bsm31316355e9.4.2026.05.09.06.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 06:19:04 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
Subject: [PATCH] fbdev: chipsfb: add missing MODULE_DESCRIPTION() macro
Date: Sat,  9 May 2026 15:18:31 +0200
Message-ID: <20260509131831.1073-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

The chipsfb driver is missing the MODULE_DESCRIPTION macro which
is required for all kernel modules.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Rahman Mahmutović <mahmutovicrahman5@gmail.com>
---
 drivers/video/fbdev/chipsfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 33caf0b99..946e30fcb 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -526,4 +526,5 @@ static void __exit chipsfb_exit(void)
 	pci_unregister_driver(&chipsfb_driver);
 }
 
+MODULE_DESCRIPTION("Chips & Technologies 65550 frame buffer driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

