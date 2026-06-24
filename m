Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C26CDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2B510F138;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UwP6TAZb";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E240910E0F1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:22:37 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4924e6fda5dso7478345e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782328956; x=1782933756; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uaPww1pWXi5Q4D8htcYS+X1youQrkpsB4ZWwVylX53E=;
 b=UwP6TAZb5rUlzCcxLhw5BX2zwLOy2pvq19vnSFkRy1dW/kVotE37AoCVbLj6f7ICA2
 MqqRNQBnyh217KT8dv9HQevPKGyXOht5iuAPgC2eWIiC/Z6NNym2TvOIUg5SHqiZvahr
 9qCtI6D0oCdLq8j6lKT6lXkLjamW0F9J7PbbL3CDHWpBz3QcBMnrFpXZbi02W6rBYSBX
 6ZhpezkD8TvWMXA4sdp93MAAPRHHoHGH4uWMLh5bt9ZCM3yaW+ShvOlvDN2rZ9EDkFVG
 ykc6eyIk2Xa37tlmXe3j4e5Q4WHvCtEaZGd/c2mkCMjNSoPzVg56g401/yd2ckpWxxer
 adNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782328956; x=1782933756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaPww1pWXi5Q4D8htcYS+X1youQrkpsB4ZWwVylX53E=;
 b=cXpZvFkbDQ5mlfEz4FFKSVl2LfLNvazC5wmbm1OCWLNvhaqTnP9ZDfE48YXA0ZRD/p
 DIXtIxeocHy9HqqN1UJAfX9BDYCiNkIftb5crvpMpIu6onXiOw6o1LoGaz7s5u4YrWmP
 aQi96MRFipu3jk7nvLyAueHsWDS+x6QYSOnNo93/dym5j/kCLpWo140TuMnEFWwiQ5OH
 6QS0/52u9/WDMTXK7ObsQPPqIlcbmgAy0TTZRjeCdql3jXz2J/eoJAI3Wr0T/zvgjMP0
 M3Nrq3j4boCRpw05HQkaTBe4W0aVK6J9IuCrGY9i0iF80G5PcIJas440+pVf0SG0SHJF
 a6Hg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ELTwM8WWDZp1Ri6JdAnCp6u0IWoFclJex7g4XQLC/IRhiDV5VBHI6dMVx6lz5d3YOieolz2uY/vY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+u/qXrwbGOTGWiqc6JuIhxwrAzZo2vuYWlQ/54InkmUotW2e6
 MNHDg8PG8oMiXvyl5V0pOh/v7TVDzjC1+Sstw7Rw0aKTt8NNEHjgigh6
X-Gm-Gg: AfdE7cmow4dUJ6FD3ySmsWgxKt3GaNQTixnhJZjSdQWIm8oRltjbos8ne+wmJ4Qjff/
 A9x/eUmtXxBBIx3+z8I2HJtIPT0zsSodE9sODOmkH8fdnnubFjFk0wasN36IBAy0SYSJazyGln3
 lGlbZyJ89/Qs7EQFoK6ZUwZzIZc4fRIyK8iRiWHXxyOaNXf1msLvogFeorNdXEJJGVmmUQFP30u
 tpvSXuyrT8ZEZwLvsHMn5juea92YchNHruBAkknNHKY8nY1nCCfdKN2CBkc4ZBnShVP7ksOi2mt
 sDgvIStN1t3kjyM2RAsG2E4PDRzA3VDTF/k+p420Qnz368mMpw4ireS6xo9bFwMdXJIiFTcDP3N
 1BFdvw0XfakbBGCm914UsocnXkD4+qSNFlZfBe74VBLLJD7eItsso7YBN335zNjj1PHmcplopwJ
 tEnJIURfdUi9+SY3TSbmdk292Xsw==
X-Received: by 2002:a05:600c:3f14:b0:490:b446:fb8 with SMTP id
 5b1f17b1804b1-4924908ac6cmr296967175e9.11.1782328956186; 
 Wed, 24 Jun 2026 12:22:36 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93d8sm15740889f8f.23.2026.06.24.12.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 12:22:35 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: reject overflowing invoke payload sizes
Date: Wed, 24 Jun 2026 21:22:25 +0200
Message-ID: <20260624192225.4508-1-alhouseenyousef@gmail.com>
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

fastrpc_get_payload_size() accumulates the metadata and inline argument
payload sizes before allocating the coherent invoke buffer. User-provided
argument ranges can make this accumulator wrap, leaving a buffer smaller
than the later serialization expects.

Return an error when the payload size arithmetic overflows or cannot be
represented as an allocation size. This prevents an undersized DMA buffer
from being used for invoke argument serialization.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4eaecee1b..ed0041076 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -997,7 +997,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 	return size;
 }
 
-static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
+static int fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen,
+				    u64 *out_size)
 {
 	u64 size = 0;
 	int oix;
@@ -1007,15 +1008,22 @@ static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
 		int i = ctx->olaps[oix].raix;
 
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1) {
+			u64 len = ctx->olaps[oix].mend -
+				  ctx->olaps[oix].mstart;
 
 			if (ctx->olaps[oix].offset == 0)
 				size = ALIGN(size, FASTRPC_ALIGN);
 
-			size += (ctx->olaps[oix].mend - ctx->olaps[oix].mstart);
+			if (check_add_overflow(size, len, &size))
+				return -EOVERFLOW;
 		}
 	}
 
-	return size;
+	if (size > SIZE_MAX)
+		return -EOVERFLOW;
+
+	*out_size = size;
+	return 0;
 }
 
 static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
@@ -1068,7 +1076,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	metalen = fastrpc_get_meta_size(ctx);
-	pkt_size = fastrpc_get_payload_size(ctx, metalen);
+	err = fastrpc_get_payload_size(ctx, metalen, &pkt_size);
+	if (err)
+		return err;
 
 	err = fastrpc_create_maps(ctx);
 	if (err)
-- 
2.54.0

