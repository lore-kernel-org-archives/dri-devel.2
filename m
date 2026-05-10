Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D71CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328CD10ED16;
	Wed, 13 May 2026 07:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pYZUtnMY";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369EE10E04F
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 20:00:59 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3660b84347dso2121967a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778443259; x=1779048059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R29xRWOosbdM9TadRiN8P+ttpGm4BOCiuJb6z0yqxGA=;
 b=pYZUtnMYfBwzBMG9Ob1HwZSCvLkKZ/kz/8B612WKdoGZ8Um2jYeIFoOmkhX3Azjiwj
 lPE1gdeUeiMT+uvLf5dwprI1TXmUJj48tTqoNByuLepFBtE0wsdmX3EHQuUemxgmK0NM
 VaaBN1biJ8mKcJvSdWSNFjFM98nQfeEfyfw1MBWxiLYxNt3E/3HYEoxL77HqDbSS/615
 yXGHFpgMdOKAZKpDqh5wqH3eF0WjQArfJz454R1ueb30dPbtCh/aJrhPnxpdwhpCq5gE
 Xk6s+9vT1ABdzhCjNF4kauXcHX2KoF8dBbl3Uu2Nufa/pz5/msvEVuuxdISbJbYqWT8K
 gZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778443259; x=1779048059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R29xRWOosbdM9TadRiN8P+ttpGm4BOCiuJb6z0yqxGA=;
 b=Dum7t/mOX3HYmqfwg8rTRn2MaiZWrs9i0zKBGPMnBIRhFjwuY1LHHrs8H7G8OP/TvT
 jNr2l/0Fx9NwXSvev+6ub1pylswh8qr0S0jBK0I5E6v0SE7/7Vcb11kUnwmpbv+0Wl1i
 ZlXThHSQFYfTcj/NFSu36dERBLEoK22WgLH7rPGDyNcYWlNftHPAmBslzpQiyO6sr9cd
 ukr+wea6LLWwJkS4APqbi8tp1+r+7AKX+ByBfc/p4jLOrB5UdOhojc0UBxd3zzuR7LFk
 m8puPAk48+fU89/gy667tVk8wADoRUVDMEbBWt2Q2VkqRbdz+MOevYlgMr9pViVDGXRg
 PXTw==
X-Gm-Message-State: AOJu0Yw+mlYwnla505nOLAZ8Eo8g5rY9yWICUsarK7qdHSdsE7NNhsjf
 3Sc6474XjqBKT7DdpzFXkCIWneIKCocsWHNCALyRC0Ad2BVfvHdaHmzA
X-Gm-Gg: Acq92OG3HT0LA8Gbk/+RxhJzgSwzvfWMX8YeRoCC/N4SsqKrjGow5LoU1WaeufpyxCC
 OM4XJTQkNB+jD0NkruPWpGt1vkonmw67yYqcAf8GXPLDp1nwrmCv8zyK9p6JPI8d4woYyBiEDSt
 HgLN709KJayRO1TZxLuMG7QKD1PAWR5/NT/mLxO9oXqt1mjMC1/6x7il233d0vW0xGxmNjaPxbw
 rup0377UFBG5CKY8kahvHvxkGJhvv9Bp2WTNeweo7aamx1qPKYnhpqQgwaon7c1dXDFOwrU24US
 FW+oOI+GawvclNWV7ycyHwb1AsE0ey9KpPSd227i1X6KY2U6Us0ajmM70IguRxgMHOtyWIfOuZb
 9njQXJg7/QypuwjT7weVfuuxJLchSUma24QzGPAjlxv540tcGxSVbJNEuibDXmuW3Im107lrTq7
 qx+eS9sToYNZOAaakHdR5RhCU1q+6W7fQBrzA/+juwQXYOSqaT1EGfLHJLD/HFptLt4N6Kox0Fp
 MGQJrgwoLMbS67O
X-Received: by 2002:a17:90b:5683:b0:359:87a8:e65c with SMTP id
 98e67ed59e1d1-365ac080573mr22668476a91.17.1778443258494; 
 Sun, 10 May 2026 13:00:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f2:38:d6b4:286e:7088:fd10:80a0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d6262349sm5259124a91.6.2026.05.10.13.00.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 10 May 2026 13:00:58 -0700 (PDT)
From: Kartik Nair <contact.kartikn@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kartik Nair <contact.kartikn@gmail.com>
Subject: [PATCH] accel/rocket: fix ignored return value in rocket_ioctl_submit
Date: Mon, 11 May 2026 01:30:47 +0530
Message-ID: <20260510200047.6117-1-contact.kartikn@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

rocket_ioctl_submit() calls rocket_ioctl_submit_job() in a loop but
ignores its return value. If any job submission fails, the error is
silently dropped and the function returns 0 (success) to userspace,
leaving subsequent jobs potentially in an inconsistent state.

Fix this by propagating the error and breaking out of the loop on
the first failure.

Signed-off-by: Kartik Nair <contact.kartikn@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39..abac26853 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -626,8 +626,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
 	}
 
 
-	for (i = 0; i < args->job_count; i++)
-		rocket_ioctl_submit_job(dev, file, &jobs[i]);
+	for (i = 0; i < args->job_count; i++) {
+		ret = rocket_ioctl_submit_job(dev, file, &jobs[i]);
+		if (ret)
+			goto exit;
+	}
 
 exit:
 	kvfree(jobs);
-- 
2.50.0

