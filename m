Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB4BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAD310E570;
	Wed,  8 Jul 2026 06:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V2X8g+OT";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41B610E570
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:30:57 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so4098735ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783492257; x=1784097057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RiX4q8N7YLB6NwXUpVKP11/NIKOsQ8F+JImq6gEWdOs=;
 b=V2X8g+OTJROvhLEL4f09V/RsWOvRQDd+H3+sPdN8PKx5qJA5YGJoFmxyNptAHSqU4Y
 plT+Mbjb2ZJPEVBKWLkoJj6uBifgwfcd+54i/VUda8CgU2XizmBujMVqlAAF5Aj81Ao2
 82hyWI7YUhoGD+3dRLBN2wvWaqwvEQaU3uFWKP+q8IqA2y7ZUgmYInhtwMopJv0B871p
 NEIoLgXv1zuZ8ccHUPMscnb6Brk7o0UR1ro2ZyyJd6ozxvixg/f8q3dnR3TNR8m/vyGz
 phrnHEuv75fiqCGScRQJg6whCb+UL0cQTZpQrUK7QJFbB7KNtTAviCNnwd/k0+wZ7O0u
 ouWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783492257; x=1784097057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RiX4q8N7YLB6NwXUpVKP11/NIKOsQ8F+JImq6gEWdOs=;
 b=PJsvVciHa9sZD+LdTx88qr642neLF/hUaDV9bfCJEOkMsy6SYQ2sSH3ryQp4iyeENx
 jEnnMKz/ZrG3el8sVwsx2445eGy2KSQcD6iSJb1Af9SeKLS/J/mJukg+qpqOvcmoMgIk
 Bws5SpAwTbEVvWEdYgxscRSSycrtpz2fTMqE28uD99WOiRJ7+et/l3j8Qw0QQczSHjNf
 sfphbzZ3hfZNzVsLLIP7P5uOp4KjBdYpkJXsNf3zOyly64bBMEtlGAxGDtj7SCCy1qjs
 rVHDmtzuclVos+nSvSlGObHodrWQ8SXjFfzQ8rO2JQb1BySMxtg2LM+23uxOCOv+VjnT
 FIIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5z1XUy8YWvUy29LE5lbJEdyxko9ZtWjTQ4WITTKP7QBjI0u8rymbZiwzTq5Bgm+cGjDCb7EE5ZZo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFPvX2E0s8SS9BarARa8EuAitcgJJe1j/lz1MTBzAuYXvUtOfw
 keMoJMOsEr0+5BVwAQeAM9BBm12joKIGkrLQBRzlPtISCq66I0Iofn3U
X-Gm-Gg: AfdE7clCApnlVTb5S4/JxTwxX3O92tGnzDiHWzM9fLAFu5VsAD+zKKxR51nibDb0yzb
 /QuptMPwF/QQdCzCBOW7unIeut8lqS+Tb2KWR/pPobH/CZxnlpEP26CVUAKwRomi4D6rKmeEkbG
 EF2RmWFSfSdh38YsQertotRbhaFuTLkCRqUUH0fY5li83Z0LyLC3OKqC575hmCW3XjVQTwoYZDG
 7iysFDmQXczhfJhtxAv5gXeiQcxaVO8pjeiPLbZl6T6vobrD3n4LMr37ApxmLQPynCyPzCFgnpL
 5KgVWWNG04o7JWpQyw8lDzn2ap6m5kI4VrP18Pddc21Fv5incE2I7PVJN1j8AlAHZsAtWsTT2e8
 Hanvd+0XlTrKMp+IU6SDpm2zdtMyKPwlBVJaAwPsi2H5YbdeoX/OOf8sUGJoEfqTXzxPjSIw=
X-Received: by 2002:a17:902:d48f:b0:2c6:a981:b591 with SMTP id
 d9443c01a7336-2ccea40c7b2mr12597945ad.30.1783492257240; 
 Tue, 07 Jul 2026 23:30:57 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d474sm23037665ad.70.2026.07.07.23.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 23:30:56 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] accel/rocket: clear rdev on device init failure
Date: Wed,  8 Jul 2026 14:28:45 +0800
Message-ID: <20260708062845.716487-1-lgs201920130244@gmail.com>
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

rocket_probe() stores the return value from rocket_device_init() in the
file-scoped rdev pointer before checking whether it is an error pointer.
If rocket_device_init() fails, rdev is left as an ERR_PTR.

The rdev pointer is also used as the marker for whether the shared rocket
device has already been initialized. A later core probe can therefore see
a non-NULL rdev, skip rocket_device_init(), and dereference the error
pointer when reading rdev->num_cores.

Save the error code and clear rdev before returning from the
rocket_device_init() failure path.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/accel/rocket/rocket_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883..67e7f543fe4c 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -165,8 +165,11 @@ static int rocket_probe(struct platform_device *pdev)
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
 		if (IS_ERR(rdev)) {
+			int err = PTR_ERR(rdev);
+
 			dev_err(&pdev->dev, "failed to initialize rocket device\n");
-			return PTR_ERR(rdev);
+			rdev = NULL;
+			return err;
 		}
 	}
 
-- 
2.43.0

