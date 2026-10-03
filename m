Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AA0CA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 03:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0566A10E6F5;
	Sat,  3 Oct 2026 03:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OkZQbj3y";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B7C10E6F5
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 03:04:48 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-93e50170ba7so13003585a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790996687; x=1791601487; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pbQpt4XN2R0/yiVPfAFgl5CdQcTGytdEwK5oHePqLiQ=;
 b=OkZQbj3yB8n/xuJvkXDRK22uPzcD+rjp27fECjlayWcQcualZeftk8SpEqc5Pfk/rM
 Fi0BLjxcgzXiNh4sID0achPa12kwpgBBGuCB7fHcXA3NpIz676RG8suDoE4lwBd3h5M9
 2fHgXoFG/WUeXIMGyWwswvIYwo24CuU47QX2gXewY+po1qn/Ipd+2iP5vebMM9EIm4gn
 JoX0bc9eYXUph+KaS7yU72L5AMzfZQxuVSyCf/CeCWDfNVOpOMNt1NpzUKs6PVnHqbAO
 T6vvxZi7OY4KcBibpZAXelUornJsCRuar5+5h5vHtaSv/DSkcvUgvMk17P+qK5XnIAXl
 4b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790996687; x=1791601487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pbQpt4XN2R0/yiVPfAFgl5CdQcTGytdEwK5oHePqLiQ=;
 b=L9Xy92VAu0rpJ0nBZzVXKlLlItPNEZB/ATU94p3q/dndWS+h1mSG3eSsNGjCoi7aYB
 6dpaMXVGFSjESJI9MT8TNyRv/XwC//6/50C+vAL5nEMvEDQygPa+zhZRqcuQBiof+7sZ
 2xUJLpnasBwPgBr3hPgQ2zQ4/AErpmon8+g4W0EGc6+pW8In+ZkuZZ21tcF31wFYiNmE
 gfDD36zjQdN6VZGtrxrxPWnOwc6QLTHG9PIL4DMFxq5MN9td1hnkTlmdhu8ghKJNycky
 cOgrsJpvMqr3gE52/zTQ2N3rZwmXAz07SRNCC97x5jFLqWZDuMaXKXAqfsG/PUxxwisk
 63EQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh5vtM2jwV9bM667P7apKxzZE6PnwK3DCo5GVxaU8QKgo4TRar386Mibpei/rfSgEtdyI106Taln8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mUOKdnsbreSS1hdO73hcyNqu77n4rYbSyj0Gat5qVxyjWey5RY
 cCuo/3WBy7S2Aan5PHS8VdpM7W93olpNDX0fkFu0bLy4Ker7ic7GuS0=
X-Gm-Gg: AYBFou12GchebsrIV/wz1+6HDdc0rImmnpHNC8o8yhdSwwZl8kxwTRqMFZaSjau0skN
 +UPFShPs7rhKiQgUW9FNxbaRDdigMfixueO7pRdf7UL37HnKd/WAqqQIwgJmpvyJpRNSKYYO9Xn
 6xZW4P6Nq0v1T6GUYCa6fNaUBT/x3EhPXGTre3C/Avdnzft/6btOX3Y8zYWZWFYT3XdnB6RyjuN
 roRHs42bYq508N6KAdO9r8L6SvxN4MxDRUQVA6BZIq4wmLxqqrmjnSUWAbnRwxjceqU6ak+t+4T
 NYzneN/d51/0HVHY8BMFAwAhAS0jpZwN+SJchKO2q0DyVK+aQhYsYXP6+J5js1eqxDu0oIeI5/U
 Crcu4QAUjEIA9sOwThnSrjVCa5/7gn3U+alRMewYC+ZFa26iiMyAhmrd3pgX2txC7aRQNpKDoSa
 6ihL49xxnRq4lP5hcUK5OHi5oXbgqLQhfvbkxGUgZxDmY3iSgARdZnZ3whq522W9R3UtbbdIhJ/
 +i11lYyUydxP5HBbF097aBBy7KRg6WafPL+cUkLPo8lz4tNk/W00VkfT22iWnUP/2lWnlIyDU1p
 kP1C4hdyfgYkG1gd/DY8N+XtxvrO
X-Received: by 2002:a05:620a:2851:b0:93a:14c:32ad with SMTP id
 af79cd13be357-93e50bfed26mr274906285a.0.1790996687163; 
 Fri, 02 Oct 2026 20:04:47 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0bc8faesm34443696d6.28.2026.10.02.20.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 20:04:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] backlight: lm3630a: Cancel delayed work before destroying
 workqueue
Date: Fri,  2 Oct 2026 23:04:39 -0400
Message-ID: <20261003030439.599330-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The interrupt handler queues delayed work to read the interrupt status.
After free_irq() stops the producer, this work can still be waiting on its
timer. destroy_workqueue() cannot drain delayed work that has not yet been
queued by its timer, so the timer can outlive both the workqueue and the
devm-allocated chip containing the work.

Cancel the delayed work synchronously after freeing the IRQ and before
destroying the workqueue. This also waits for any running status read to
finish before the chip's resources are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8f49e59ce374..8ef8163c7fef 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -591,6 +591,7 @@ static void lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
+		cancel_delayed_work_sync(&pchip->work);
 		destroy_workqueue(pchip->irqthread);
 	}
 }
-- 
2.53.0

