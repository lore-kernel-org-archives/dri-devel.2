Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD34DF428C8
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D560010E737;
	Wed, 15 Apr 2026 19:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FonjOpS2";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D7810E737
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:13:15 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso3940589b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776280395; x=1776885195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jBcpP2Xf91EXqMzxfz4ls9MLPGhLhWDU+QsE/IF+8uQ=;
 b=FonjOpS2gGVswisxmXfShywuXrcuFvL3Gh2hB/DtfjIoDBie+WEJSxD8YKia0KwQrg
 VJkcFe/S9yak5x06mrS+4kegCREtQ7T7vLPvT+Bi/dwD8JrqYIOPopSxL9ZWUvQpfZau
 X1n/879oyTq7OYINjPN7BEFEsPfyO+z1EK05kB3RerXec9VMU5C9OBDS3GWILVmvNmB/
 yySn8sEyLPW/kUS/XXIwufbb/bQJVRUxSzJCHEpYmfVSJ6z+a4Bnv26jMy4wARHfz+85
 tLbjJnhN+3j8VMjI8FKAL84s9q0K6lBV5RD8aoIg+Vu5draSxNEZ3qSebNCuNwGV+NhO
 IDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776280395; x=1776885195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBcpP2Xf91EXqMzxfz4ls9MLPGhLhWDU+QsE/IF+8uQ=;
 b=dHZaHS8jlLZOMi+FfnrrfFU83B+XUxswTyeyUp4F/3CUrI3FO4jtbE7Qp0ay+5Bd7g
 DR1MPLAhaeYNvOvFNPZ+FfLiVmZsLYYHWYdmtWpn081flCvgDqIR58ucx7OepYAWnQfp
 d/zX+RODWp+mymNl3n6AdFHC/mvH9/thL/J5hIoGCq8DUPIwFUiUxrXzdueTHmV+q5jk
 J6YLSKaOoOqB+XFJGVuiqO2zTqJGcWTrKIVvCHSUa2UKcvb7HgexomGkxKtNbWX1Gc9V
 +i0fhfrSXD6o5UWt8Xr04eal99Hsm2BJmMmvOj2AbBSp3hmKAB/5mVOWdrxjBE+QmqDS
 3SNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uab4SGLvEXO5OYAgW8zamzUfTIUiEGYkpLmZkPHQmOcx3T8veTnyv5eZCeuXgXQqwAdOkw9L7NtE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuxuT6L1RN1DfKuZtvSDlmKiB7VIKMEcp02q7kbPjKFM19BNqR
 +cVy+bteWsMCWp6BDrH0g/lBkhpZEEakR+aA95kZ8GALxGqFCwtbqxu7
X-Gm-Gg: AeBDietDD9Ju7DDTlUjuB6aZh1ooizH1VeJ3BOPrMw53ij5b0UvcDOXrjjvHJ3MT7RJ
 VWRQhMeAbjt1+p4BIewMrSwNzJ4G8f5mmn/KIY5k77suDzP6nefrlSLsu+1fA6NqwXACO6tW8GZ
 MbgiZ10us1w0DmmzgXV7l6LIEeau6ZJcUTLFgZ3/TE0zO2zdk8M8k917WaVNinbMojIyUqv5PFK
 K7B1Wnw5PS7Xc5Tvage2N+c0aH945INO90qyUxckOm09y1QpJhrJusXJv1F165kjTqzygy622ec
 cqLYsBBGUF2BHK+MNbtjQSr1lCxv5JrSkmLbaxZpr2JrXMK1dINt5NieVBLVZ5X3IxzXedBM6xK
 Ysn+Fk4SNTZDH7wL4G2vpodl2MbktKpoqGllc1v6mMXx5qPqSft4u5rrmeFXb1DuQ2ihpZL52GF
 xxdlHoaP2YIc9zjNSjIz6i+93Nt5sjm+g1yIQ=
X-Received: by 2002:a05:6a00:3485:b0:82c:e5d0:5249 with SMTP id
 d2e1a72fcca58-82f0c25abe9mr21497068b3a.8.1776280395057; 
 Wed, 15 Apr 2026 12:13:15 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f6747541bsm2934574b3a.59.2026.04.15.12.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:13:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: q40fb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:13:06 +0800
Message-ID: <20260415191306.3837839-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When platform_device_register() fails in q40fb_init(), the embedded
struct device in q40fb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  q40fb_init()
    -> platform_device_register(&q40fb_device)
       -> device_initialize(&q40fb_device.dev)
       -> setup_pdev_dma_masks(&q40fb_device)
       -> platform_device_add(&q40fb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/q40fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
index 1ff8fa176124..0151a41267b3 100644
--- a/drivers/video/fbdev/q40fb.c
+++ b/drivers/video/fbdev/q40fb.c
@@ -141,8 +141,10 @@ static int __init q40fb_init(void)
 
 	if (!ret) {
 		ret = platform_device_register(&q40fb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&q40fb_device);
 			platform_driver_unregister(&q40fb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0

