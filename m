Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBE8CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D2A10E198;
	Thu, 25 Jun 2026 07:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liifelaR";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1525310E0F1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:25:06 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso11041235e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782329104; x=1782933904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eTNgkQdTW5rge9w2rIY/43V8cY+8H+JG9cF1K9K10rg=;
 b=liifelaRwwxJib+SWzLVyRPwNNPaXAG0aC3cKfjf2PDXSC0NMfjlRVAxom+/uCd6DW
 d01bzrZLVffN/4OVaINy8Qk4gS49A1Bfmlm1URdLPgwyr2XQ9EtxT1qfQ8odEr7Hco9d
 kGvfqeprfBIx31XGHm0YX5llwa03rCL+N9kC4rhZ1Wjl+IOQbOcxLogbQ4KgjKzt92mx
 ZliId5Jx6PLfBotzB+OcVksr1gWeIkvQelxOnRgIZmI80xPzlq+zmLiRBWNA7fGhYuI0
 AU1mCgOEP0g02zC84M/6p0em2JkTWELjx9pngq0mK0Y9A0zDeSfEetBpxs2m7w0P4M44
 ffgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782329104; x=1782933904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTNgkQdTW5rge9w2rIY/43V8cY+8H+JG9cF1K9K10rg=;
 b=li+xKpyv/8Ojm0sz59sqjHb0atIy227LutoGXCOeQ35Sr5JP1YseYWpj9HiNkC6lJs
 YWbEDe8KG34M5XmEXhf4dotKqGmam29hoDG8zWVdboYV1JHEB7qfRmIgZlEm1zawKNtU
 NGKrfHlwmtHb3YgdFXgZ+9UrENnUi7ps9UYdOuQo+gQ5rDProFD+J+0weyKnWvB2RDLg
 X6KxkPIbvty7zirtqS0AvIV8fasEoDywD7BH4SiFJ0U0ovzrMz/yU60ioTqv6hFqc/28
 Nm5i9VosBxlGtOco+4f/x30lGj00y+2Pt1qHSoiDYzji2y2vOL3gzOj1zdqISdZ3T6WQ
 UGLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uORgN012YLsXezRMyk7zDVjlr+ZWa5gITs/6js7ZNT+BkRUZDaAzwLJrd9cvjzhp1OqsyjFhU8is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGvb08ZvZqO1HqsXLkx/O41Hv4E+dRTJKK88gAQMwsnGxQf5JH
 nmpskiPJMTzSPR/T8Re1nUWK8+RqxIhotjyPr7WWL5WO+aRhgt6sqjiQ
X-Gm-Gg: AfdE7cm6ximufhNa/1bARWmdZd6s6Z287b/vWTKsKQV9mzxdaU3oKfvKfJu9b9ELSyd
 xRIXSjWpkqclmHgnUHCOBl6oiRnJDBzZp1UKyzmhkUk8kYlhr7qw9naprEmuc4hp0OIecEZm7rf
 Gepbx2841pXeHaDWsbYJpZO9gF446SjLCZtpUgv1FOZQreROmpG70jBzQysGGE6tEXqNLY3iHyT
 dqPLN44MDKUlDRZ4gG6S/zcCcKOlPWw2PIfzEd05IpkKKeeW4Y2jlvcEIENJMrVydXW9HW1F0ug
 zNN/Iacc+gIXK5U4iZBJARcYYnmzvqa7axw5oCumExqFbfokOLV/2GGxeZQK7KqQIArwUrKFR7D
 eib5VgVhh7FqWEo1UP8AwqKLcI/Nz56ryxQiKFllcE36rD7kdKWysZaeKMsXtFdILlR+6Xel3cJ
 LpNm1LacyzW6+/XpiswcfVw7Lt9g==
X-Received: by 2002:a05:600c:4443:b0:491:8043:5c4a with SMTP id
 5b1f17b1804b1-49260879105mr68640375e9.31.1782329104364; 
 Wed, 24 Jun 2026 12:25:04 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm6955406f8f.3.2026.06.24.12.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 12:25:03 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: hold rpmsg device while using endpoint
Date: Wed, 24 Jun 2026 21:24:52 +0200
Message-ID: <20260624192452.4949-1-alhouseenyousef@gmail.com>
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

Invoke and remote heap setup paths dereference cctx->rpdev after only a
lockless NULL check. fastrpc_rpmsg_remove() can clear that pointer while
an ioctl is preparing an invoke, leaving the send path to dereference a
NULL or stale rpmsg device pointer.

Take a device reference while holding the channel lock before using the
rpmsg device. Return -EPIPE if the rpmsg endpoint has already gone away.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1b70acc10..4b258dbcd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -486,9 +486,24 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 static int fastrpc_remote_heap_alloc(struct fastrpc_user *fl, struct device *dev,
 				     u64 size, struct fastrpc_buf **obuf)
 {
-	struct device *rdev = &fl->cctx->rpdev->dev;
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct rpmsg_device *rpdev;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	rpdev = cctx->rpdev;
+	if (rpdev)
+		get_device(&rpdev->dev);
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	if (!rpdev)
+		return -EPIPE;
 
-	return  __fastrpc_buf_alloc(fl, rdev, size, obuf);
+	ret = __fastrpc_buf_alloc(fl, &rpdev->dev, size, obuf);
+	put_device(&rpdev->dev);
+
+	return ret;
 }
 
 static void fastrpc_channel_ctx_free(struct kref *ref)
@@ -1260,6 +1275,7 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_user *fl = ctx->fl;
 	struct fastrpc_msg *msg = &ctx->msg;
+	struct rpmsg_device *rpdev;
 	unsigned long flags;
 	bool put_ref = true;
 	int ret;
@@ -1279,10 +1295,18 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 	fastrpc_context_get(ctx);
 
 	spin_lock_irqsave(&cctx->lock, flags);
+	rpdev = cctx->rpdev;
+	if (!rpdev) {
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		fastrpc_context_put(ctx);
+		return -EPIPE;
+	}
+	get_device(&rpdev->dev);
 	ctx->sent = true;
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	ret = rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
+	ret = rpmsg_send(rpdev->ept, (void *)msg, sizeof(*msg));
+	put_device(&rpdev->dev);
 
 	if (ret) {
 		spin_lock_irqsave(&cctx->lock, flags);
@@ -1312,9 +1336,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (!fl->sctx)
 		return -EINVAL;
 
-	if (!fl->cctx->rpdev)
-		return -EPIPE;
-
 	if (handle == FASTRPC_INIT_HANDLE && !kernel) {
 		dev_warn_ratelimited(fl->sctx->dev, "user app trying to send a kernel RPC message (%d)\n",  handle);
 		return -EPERM;
-- 
2.54.0

