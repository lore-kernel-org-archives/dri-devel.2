Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BB4CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDA910E9C0;
	Wed, 17 Jun 2026 09:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ECg08zUe";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2371310E9D5
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:44:17 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso2606866f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781689456; x=1782294256;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5e5ThiuCQuL2m3Kf27kb7O5XV1gp2X/Il1NBQqxg5Bg=;
 b=ECg08zUesUipWWQJ3pcg39DKZRfPfVXsmdbUflrWZCu6WQ3yRuIOHBaTgCAcqXzHix
 d/G2Y0zWYkxY9X4ZR4IhUmda1CoFb4iLMYHeXfVEU8f/wHQ8n6IHbNSsENU7xsq+HUJ4
 dH+PzqgnsSSnqjkDgfVHe9dRKpr4ezdwDZMv6N85OtpxCODjJn53CsD/hPkALRTlscpQ
 ZAAj+PEYvmRtjw2TgY5Y5OkYJH/ASSAHO10MyQyllpwwhEV9maPPSAKjuO0aZSi9zh0N
 GTmACde5QmpLr2tftXzbiUtekqYlP3IlqWOUfnpFzEBz1LfeGS2UL3FJFf0Caql1kd0I
 4h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781689456; x=1782294256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e5ThiuCQuL2m3Kf27kb7O5XV1gp2X/Il1NBQqxg5Bg=;
 b=RFcGX/vyXrRw/wZPlOgjj059jN7Y3LqmRXaVeolTbkXImHEis4BNkMn80oFiDZI1Qx
 VAw/zLDITLJBzNFW3ilbXX1d+lSM1Jwawyn9qUvGVOKAbgWzIbDlWmZnj8CMFyh6jUHg
 B8UbqrqTdHtI8omhCSZ7OldNV4VXc/hPcPSLK+3t7nB0CCEcqAqZ7QI9dNIHxmgVktu+
 Dyr67KuMFxXCIyWVbSe5260CL9qJwEdiZTWsMEyKhjszuO9veETvRAbXp37e2ZgsTUGw
 37QP0rLuN6DrzxYMFWjqt17HNkScV30VtHiO41iiMTYQ31lOYkefb5TJFbA76l1qtRBK
 vIyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pc9i1jurx6cWt6WIFpf4xmEGhXF2oIh5FuemSzfpa+ymIBWYl3gtCV5F7un9eYlSwcbcO3LBWhyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKUm5VL5ROZn5pTkr6F7SmivaoV/LJUpjfwv+V2LH+FYbo2kVY
 MvyyVclIh+xv9AI0OvD//00THJe1VdHGzQuvrJmpMEYsz0QPep9M9mOPyqmgDADukaw=
X-Gm-Gg: AfdE7clDJW/2yjIlAYEKG1/cZKdbIsKPOG3HjRfzMDzTpvRnSHCieIq5l9oIYq2YSC2
 7Zl7wbeUma+EgWgXnB/9vL447+hTbVFhZT9vP0NMHUVdz5mzEkRWpLY3+htpWEMIXgLWzS2cjo2
 VJ9AGPicGCsUJw3FzYF5lOVIUud9giH+TT5IjquSYfwLQo7KyBegKEN27fJk4idsrrIXHbkoLaq
 hsaCCyGfBdvMbWaUBdXRQMYIpPKHFUJz7PHTLHfRzJ0bvIAZ2aTPbl8y4s3yMUacCvcWtXAb2ar
 zQ7H7WOE+Nic5CO3hLWb5HmBpk1GEtaDDs3tu/+x3F/O/ydmCEb3E6WoD9HCUIGbnz6X3xPXUsC
 EBHn2iKjwyt5B/KsepE5pz5qKsKiR8TblaWV/igpvplDS/pIOtwvY7PehXnYDXCo1gcSfJGCWjH
 qDJ/930OSWRIWzSJoNPrMEUenaTPjYnXbSN8FPt1Y8zvEHF4zMgd0QDlmtEWyzL2UVajigChehQ
 CCL
X-Received: by 2002:a05:6000:2913:b0:45e:ef4a:8192 with SMTP id
 ffacd0b85a97d-46238bc0537mr4819136f8f.38.1781689456251; 
 Wed, 17 Jun 2026 02:44:16 -0700 (PDT)
Received: from localhost
 (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-462236047c8sm7797131f8f.10.2026.06.17.02.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 02:44:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Javier Garcia <rampxxxx@gmail.com>,
 Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] fbdev: vga16fb: Drop unused assignment of
 platform_device_id driver data
Date: Wed, 17 Jun 2026 11:44:08 +0200
Message-ID: <02710e01b80c06230f399afa6a7d247b95b3f2de.1781689394.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=sfrAhb1Z+VzM4SLtBkm5dpCf6X9unUUYYTWLBBKX+Bw=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqMmxppssr45MHySgEWeWZleAyeuAwv3bsYiZiq
 r9lwBexJquJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajJsaQAKCRCPgPtYfRL+
 TnGSCAC2BtWvXO0gmLj+tyQU4J7B+LnhNFDgUzyzNZ7l6PEKXhgel4HZQXSYuEgSkIAzWyRk/ev
 rLK4bC97m/7SdwgoOKsmXgGl/LU2l49JxH9yzxemF0LIshQEp4lO2b8YdVd7TzZVOvEsENyqreM
 PTUsQWuPXtZRbPZQ0gMPvFWHWiYgiO4UUsOobWuDtL2GqAgQtRvjZXHzif0zPPwHNsKVBDz9tMP
 LfuekMSZDeUIiBbNBiosjVGIKs4knvXYk9vARIrSB/gRq6HmTLqVqWPO15at8VixbX5azGXnVNT
 KP0nsPwH+BbFT2heZrEox0WUItbcXRuyQTMEnnmDmev27k4b
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

The driver explicitly sets the .driver_data member of struct
platform_device_id to zero without relying on that value. Drop these
unused assignments.

While touching this array unify spacing and usage of commas and use
named initializers for .name.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/vga16fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 22085d3668e8..cdd6b8de0ceb 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1421,8 +1421,8 @@ static void vga16fb_remove(struct platform_device *dev)
 }
 
 static const struct platform_device_id vga16fb_driver_id_table[] = {
-	{"ega-framebuffer", 0},
-	{"vga-framebuffer", 0},
+	{ .name = "ega-framebuffer" },
+	{ .name = "vga-framebuffer" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, vga16fb_driver_id_table);

base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
-- 
2.47.3

