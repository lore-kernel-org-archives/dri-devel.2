Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98896CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BB410F488;
	Fri, 26 Jun 2026 07:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qzr6Mbsq";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B8110E1C2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:57:23 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-662dc3879acso1877095d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782377842; x=1782982642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B4FF8nNbzEIIdzHCql4jtvlByyo4hD6ECsylMtCq6+k=;
 b=Qzr6MbsqcjC+aMiHlQ5tFSSbzdbIKLYEAqvf1q5j0rPnwFRDzTd7jhtUaiPEWUM/Z9
 wCoJnFjG3eHD3UZeemwSL5QMlCoeySNq5EbaW/Q8kSC7PJpf4GpTsY169n3/pBVMDH+u
 0J8Spw9zHZSnF81AKX6hTqPLeqR/Q2cb/QjWQ+tFdpASPWhPacZ5oexTqmkxx3wNVLGF
 PjiKI1LGHjD/qQu20zsiSE+pfJYQ6jUjFcUeLkqwjRnlZtxPhV0lo+V4eNbjjdVvNoNG
 3Fzgy2TJRUYHXRhdHkvYtTpWj9McYYyrYpBtcfxGBRwc+4w6z4pWSqaii+RXjNFiswGq
 rBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377842; x=1782982642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4FF8nNbzEIIdzHCql4jtvlByyo4hD6ECsylMtCq6+k=;
 b=Tof7kXnqzcjZWsKuPmuduoXNxtqLQjFLmJ0ZzU78Z+NXqr0py/5IyhjkCN79TGp1qN
 le62I/PydHOs4kX6G4MaA4JfHURhdnAyZ2mHahp64cPSr3LiAkDRUKtKGAaKdrL2Of37
 UCr0jSwIh1l1eYgLvoT3ffcX2bwPPTHaAmY0wpwngwDiQPPgpK7gkVMdR4Nwo4vNJfpy
 EQ+h+R7Femx9z+G7wcV4xblHvObTlQIsgApCU5oHJ0ZRNJd5PdWhepMEZn5qehXw1Q5T
 nKg+zF1bYHC6ddUmWTm+9XZE2Oi3pSgkOOts9EATJCOVS1yiU+jtLXIA/fj41DZILsEt
 l53g==
X-Forwarded-Encrypted: i=1;
 AHgh+RogL7mT3D8PiMUsaYiz+Rs77HD+mLMfvVlYMGPLi07bTJMklTZltUyFVc5kp8VOb4lXJofyxv7XA3U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4KPtoNB+lN8oSxxX+xRr2HTh7UDfitnQlKRzzEa7KYmFGjv7b
 IWjOjVFfRZJr6HiLYet+11eDAOVSiQBmdUmlCV+flRaczLeaQgpAzToQ
X-Gm-Gg: AfdE7cl5IkuK26OaGnyi8I9Um9vZM++FEIh5jb18GEy/+drS8SeygXHZOv6eN/fvSoE
 7I2ExUE504/rjItTy84J9NXBGwnK8NZdzAPRu2QUFiMwFAq/jEKFSJEKmTYfJNTmQ3FX4Cr6YID
 c5ZXrqZJSqCT38wSaJihgSQ+cjkvjDhYDxi3NrIWL83/NgIKWEKxxistqF6d8jCRPODCzTdOhVc
 sb3XoHy8GkV6z37mIJ8HvlHqMVJFasG7sSXCHMV/nSUUrrRgBqQeVeUrGtIzz9pmBMJNW4twPjW
 H+fxjsWFJuOa/4RlDHzSRrZLfkCKll7MSO12yKri3T6ycZh5Pt3cWhv3bEvDOk6uaezWAjV8hMC
 tmWlELI/zM8QpSvDwd2Ds23iZXLHXjwMdwiCkzZEQ7RDh/oRLtA32odUb9bMMepDOzqWJBmZkwd
 zyjI10IXqQ6OteaOnbEL5L7rdBJmrv4tef+tGI
X-Received: by 2002:a05:690e:e8f:b0:662:e0b5:33b with SMTP id
 956f58d0204a3-66487debde5mr1230262d50.8.1782377841950; 
 Thu, 25 Jun 2026 01:57:21 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6647f785f6bsm1105061d50.6.2026.06.25.01.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:57:21 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 1/3] misc: fastrpc: reject oversized DMA allocations
Date: Thu, 25 Jun 2026 10:56:57 +0200
Message-ID: <20260625085659.4469-1-alhouseenyousef@gmail.com>
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

FastRPC keeps invoke and mmap buffer sizes in u64 fields, but coherent
DMA allocation takes a size_t. On 32-bit builds, a size above SIZE_MAX
can be truncated before allocation while the larger value is still used
in the message sent to the DSP.

Reject sizes that cannot fit in size_t before allocating the DMA buffer.
Also make the inline payload alignment step overflow-aware so a
near-U64_MAX accumulator cannot wrap before the later bounds checks.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index bfdf8ab6a..8992b5c0c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -437,6 +437,9 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 {
 	struct fastrpc_buf *buf;
 
+	if (size > SIZE_MAX)
+		return -EOVERFLOW;
+
 	buf = kzalloc_obj(*buf);
 	if (!buf)
 		return -ENOMEM;
@@ -1035,8 +1038,14 @@ static int fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen,
 			u64 len = ctx->olaps[oix].mend -
 				  ctx->olaps[oix].mstart;
 
-			if (ctx->olaps[oix].offset == 0)
-				size = ALIGN(size, FASTRPC_ALIGN);
+			if (ctx->olaps[oix].offset == 0) {
+				u64 aligned;
+
+				if (check_add_overflow(size, FASTRPC_ALIGN - 1,
+						       &aligned))
+					return -EOVERFLOW;
+				size = aligned & ~(FASTRPC_ALIGN - 1);
+			}
 
 			if (check_add_overflow(size, len, &size))
 				return -EOVERFLOW;
-- 
2.54.0

