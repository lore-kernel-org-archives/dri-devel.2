Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EFCCDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA8510E1A9;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bqei+oiY";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D4510E0BA
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:44:56 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-7fdb04d774aso18559747b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782323095; x=1782927895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hvdk8auvGr6gBDxJclEr8sSbwpLlIJ8Bx4YIOUeaALw=;
 b=Bqei+oiYDZ8W+G6eIQ1Wl2dUR5EDPN7SHBVtquHptO5LwrSOeW9PoW3HWUQsOdf/PU
 F2HY2kNNfmx5wTdqd/A/Ym09NIVpCcyE1NgtAk/3q71pzKCylNyizCBH37TEFR7N6MdJ
 TEDScQCSd6E7svfndsMsd4NLfB1OciTMJ49oBTvPXnAenl2aPClL8v7LNp0UEE8Gsw95
 9hhAyp3BGrLTu7Qa2dHcuW+eAMlgm884MClRQDVIfTX7anFk9F3hkWMCUXTOesI9EIZw
 LQTN+CpVoC57VTy139Wj9gTrgB0xChw8qMdlsMlrOLr5PAo2hJx64YGzxRgVePwJHYQu
 K6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323095; x=1782927895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hvdk8auvGr6gBDxJclEr8sSbwpLlIJ8Bx4YIOUeaALw=;
 b=bE2hCgCvGJuvUQka+L7/qVPMsOpm0/kicZrfrwbGtR0GJNhMv19Yyv819k6/pA7bBC
 Dl7USE0ts9uC2QfNOFai8G8RCBP1yEhc465VnUK7iMGTM1LNYhOw4v0tvxPO8tYcY2jt
 jO2Y3L1AauquX8UmF73iuschCHVqhAw5d7q+p9NAWQXm0p/I4jJ/bZrI1KOJvxIAuMLI
 kM6Pygn9sRYsGYY2jBHQQj6NtXs/u7rl1s9EnJp9p3j0TOudhAMyvACmr1wOrUHXyAzj
 CJ/Znh6MzRqxRMZW7fpGO/Rpx8zjw18oN4dZck6qKOq8VXR/7Bw9uXMcF66dfUa+ukSO
 +pPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqsq5xBjPvVYN20W+NoLKzZzLbsu57/S8PlkR1idrrZL3TfQ3+8PRgEuHm7gMeEWwzWfZ5H2Irheg4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQYbKdU9rUpGCD5gysaS5MrFMmIsHJ7GPxoWDSPsrojStXIGas
 BL4hkoNxorDojDhW5IUTdswXPsDHiluvjI4AWHd7huay6921Jy5cRdM/
X-Gm-Gg: AfdE7cnkXg9Hbi/O74cXsXr29rm0B+1uEmW7nSFf5TUMFEjf6dgvq1EZUdMffewaMmV
 3xnuxxMTkpnT55nWvQ68LNvUyz9eFVRbU8Uxo4/2Q+DWld8cMkJtsmfFJ1rBoUd8nrlhDvsYBFg
 v3JKUuNNECQBJVfUFpLLW7/AEt4nzoKL0hkpJFnfoJWKenbUacPRd2Hwaugq5Ozr+1cjswxg4rm
 xZaWVyfg7rzN6/FzJcEiqHaYzO+mEPUDeu7Mxu8PQGTwhmPVdtRZACFgGA3Gv9nKDCeLQkmvNcJ
 EZv4Xyq4uee9rhDirwXmGiONi6WZSa46u/g7YXlOVjzVa5shEbMbS2aUyUA2N8T07Ohcv9tKrlj
 ISoSFhB2Mpo1r5ijxCCKQK3EA3hY8S0rALv4gfPqBi6t3NrzG79MLnwAGJOx+WKBVr67WQ8d3tR
 hMJ6aTXyM3AU4PhnH9GQld++5+5A==
X-Received: by 2002:a05:690c:6e0e:b0:7bd:7b2e:f079 with SMTP id
 00721157ae682-80266c36fcbmr218316607b3.44.1782323095111; 
 Wed, 24 Jun 2026 10:44:55 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-80984a02906sm7053847b3.49.2026.06.24.10.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:44:54 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: reject overflowing invoke buffer ranges
Date: Wed, 24 Jun 2026 19:44:10 +0200
Message-ID: <20260624174410.6074-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

fastrpc_get_buff_overlaps() builds end addresses from user ranges.

A wrapped end can understate the payload size.

It can also feed bad ranges into the invoke metadata.

Reject invoke buffers whose pointer plus length overflows.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a493845..ba4ade874 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/of_platform.h>
@@ -607,14 +608,17 @@ static int olaps_cmp(const void *a, const void *b)
 	return st == 0 ? ed : st;
 }
 
-static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
+static int fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 {
 	u64 max_end = 0;
 	int i;
 
 	for (i = 0; i < ctx->nbufs; ++i) {
 		ctx->olaps[i].start = ctx->args[i].ptr;
-		ctx->olaps[i].end = ctx->olaps[i].start + ctx->args[i].length;
+		if (check_add_overflow(ctx->olaps[i].start,
+				       ctx->args[i].length,
+				       &ctx->olaps[i].end))
+			return -EOVERFLOW;
 		ctx->olaps[i].raix = i;
 	}
 
@@ -641,6 +645,8 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 			max_end = ctx->olaps[i].end;
 		}
 	}
+
+	return 0;
 }
 
 static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
@@ -675,7 +681,13 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			return ERR_PTR(-ENOMEM);
 		}
 		ctx->args = args;
-		fastrpc_get_buff_overlaps(ctx);
+		ret = fastrpc_get_buff_overlaps(ctx);
+		if (ret) {
+			kfree(ctx->olaps);
+			kfree(ctx->maps);
+			kfree(ctx);
+			return ERR_PTR(ret);
+		}
 	}
 
 	/* Released in fastrpc_context_put() */
-- 
2.54.0

