Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F3ACDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB10510F47C;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fp3uUYNl";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FE710E1C9
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:57:49 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso12421775e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782377868; x=1782982668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I7mK938UvamZb4f9XlJ0eXBktak5gapPH+AoT8mY1/M=;
 b=fp3uUYNljsXhKF4yMQgfJpFiU0OanwNUMGNt+FtDf/QJ4P6JdWlDoRZJIBN77j3Fm4
 dUxvL+Ya3XPJ4RRhmCuXse09uPrPuzl40GLDESy+du6s/SSGXZIHR5Uzv9909Lx09pob
 GmR0uBbvnczogc94mm2Jax0JIglvMnT6hvxrEJI8JT8koIEdBWn5YK9BQDSfuvVHkP5U
 ZJkM9W17jPE29usY9MC3yGtQOXSTBJS02L+dcbFj+wC/BNt+akeapGajkZxtKlWmvxqV
 jq4ZQn/ZQ4wCM7mHVKxgybQuaHe7G0fpV391sHLHW4BIIHVpbUBNNia5huJii9joGIex
 oQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377868; x=1782982668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7mK938UvamZb4f9XlJ0eXBktak5gapPH+AoT8mY1/M=;
 b=AmPjmdSzxNVsO79IltM7fV3gqsINKsdVmQPZ6JR6o1VrL2k9RzTEplJ2w5mvDLTtIw
 leJIhpVgj2X7twKN4LWY6vTuK6boyMJfipneXu0DsqSl02WLrz/J0xqkB4K2eTY876In
 WMJlWZVJvc4hPYH3R4UwKyFOgp8YR3vT8DvAg736u1fr0+wTdizc4i7t2USrraY5VtUR
 45juLEIjXQjQMBJqSteCzY+I/BHm80uQtUEPGkgCqSRSVuzOh9XVXYpUl5J9Vy+gNWxq
 OcsjxsHYOt2WEJUpd5/h861nahwfev+flCBmG6Xug2OH8AIHmNwGFcv99dLUme3s4/tM
 yzmw==
X-Gm-Message-State: AOJu0Yyb53PZZHmNvTC5Zb5P7St/HG5F0Mtvrw3QzsvxvBMmjAqEFiu6
 tKAp0DFoldehErvKB+oxe/f4UbGaTMjA2K2TkEkT846Ix7+TWobAZgp4
X-Gm-Gg: AfdE7cml1c3S5jzCFJ/GG7UHI+t+rc0j5r8u7ZorzRKmHHvR54pvAM3fD4kuTcI3A+w
 yMHmSMVqFmcso1/ftxUEY8wvP2nIllrCoCv2PC9H3PNlDS/5qx6btygoGg0cwqOZnWNPpAhBrhf
 bgkctKkEOPOk22hJR3sKQxdu79F41Clt0Am3GbliZUdvLLHHUGTMat3K9JkpsXRG8q/5ex6KL0d
 f3R72vf5warYRTPGqSnpZ7+nUx9x3csoOug49ZjEg4kQa7Q4AheOA+677M2AAhmUa/p56WIremt
 1v5RyEYnUeld4/wDn15PT1RTY/DX1JKTT2zIyo62OVFWefvPFAFG3eOB0LowRZfoAtkDf5D/8pa
 HfikLs/07zuptKSpRYQlFEE3r+wJ/WDmpKiVIVFsHDxvk5f22y8VouE+DDdzMeRACZ3k2W5cEyY
 Vhn23wkZ4IphOaaYcP/tp7u+rfcA==
X-Received: by 2002:a05:600c:a12:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-492668ad891mr20377325e9.30.1782377867583; 
 Thu, 25 Jun 2026 01:57:47 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926541e03asm40015555e9.2.2026.06.25.01.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:57:47 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] dma-buf: udmabuf: make list limit unsigned
Date: Thu, 25 Jun 2026 10:57:35 +0200
Message-ID: <20260625085735.4488-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

UDMABUF_CREATE_LIST uses list_limit only as an upper bound for the
unsigned entry count supplied by userspace. Negative values have no
useful meaning and complicate the bounds check.

Make the module parameter unsigned and keep the checked array copy so
large counts cannot wrap the allocation size before udmabuf_create()
walks the copied list.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/dma-buf/udmabuf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index b4078ec84..620113df3 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -16,8 +16,8 @@
 #include <linux/vmalloc.h>
 #include <linux/iosys-map.h>
 
-static int list_limit = 1024;
-module_param(list_limit, int, 0644);
+static uint list_limit = 1024;
+module_param(list_limit, uint, 0644);
 MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
 
 static int size_limit_mb = 64;
@@ -469,12 +469,10 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	struct udmabuf_create_list head;
 	struct udmabuf_create_item *list;
 	int ret = -EINVAL;
-	int limit;
 
 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
-	limit = READ_ONCE(list_limit);
-	if (!head.count || limit <= 0 || head.count > limit)
+	if (!head.count || head.count > READ_ONCE(list_limit))
 		return -EINVAL;
 	list = memdup_array_user((void __user *)(arg + sizeof(head)),
 				 head.count, sizeof(*list));
-- 
2.54.0

