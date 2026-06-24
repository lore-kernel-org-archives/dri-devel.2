Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27581CDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0049910F134;
	Thu, 25 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aUTO48wR";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7241010E0F1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:27:49 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-662dc387b7aso1631132d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782329268; x=1782934068; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+BitzJFDbUPVda/ZhCxrpv+F0X4dQ/6HuYsKwRcXpws=;
 b=aUTO48wRyuBNN5OjnFjbNm73kHymhSQyfalyL07vFrnZBmwROcNlA/t2yXycQJ1ywX
 8+zf2XBevqqtuwxBGmazbQjFmGKFZIP5TYQl4fokdiPWgSH6AZTsocgz7FeCeLXroCp6
 8nMx74nvuo4JntmFFQvscO3KTbHu4v6NO+La3FH4IxJhPmY8qOPzJUcECJ5NDIxFfEQI
 VVtKMBk9r5/b3X7mjDzqYKRgcAmXi9XOtyQP83S8MQjIwOXSFVGawO4eLuR58VNt7Qzz
 B8y0dg2tGBo2rp/dDoHe0HcRYkEQ+Y5y5YksoFVikwfw55ceut6OA5Bo74ucVsDnI4Px
 mUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782329268; x=1782934068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BitzJFDbUPVda/ZhCxrpv+F0X4dQ/6HuYsKwRcXpws=;
 b=VZl66fAv6R6gRjXxg8akFLbpFyX+1pLZM3avUtSPTxg6+NyGprqLrSSC16gcwPJibc
 7+u0LYVCL/oIhdsR4BecXt05j8/mfHUGw4Z7IFHkPbd6xOiWPHvTacfSiN6QLCSuxKKR
 REfdSy+VzQoVy4m1I6kF2eUumkaFYvGC+d5+lZvpYLldEW7zfKr5D/QM2gi6rC0rU2R1
 pfbHWQYsZ2weGWOUWT/+R0ZNY5pR0vLeCpnZICJ2EWSu7+D6z5/KRheJDalEAF5cjTwd
 mIiIADrAc4wr9URwMhcbLhQGJbDDHvs0MnNoPySjnNRAFfHv5zCNoG5UUBTy5vr14Kly
 6oXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP4xesuEsFgUk9/Lc8ObQZ22uTKEvzQFzQmmFw3t4G0u0cxy7kauWn6awpBCsmHmiq3veP9gcII3M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNG2+RMwb+VJi9D5dMZOqLW01KxapgDwFI4sPzKnMGge1ezKhv
 VDRDWhy947Rr53Jv6e6oeFV2lds1lQ5uRunbPOSFyFx+odZ0X02SXsGM
X-Gm-Gg: AfdE7ckRbsBIbx8LQUMs7hNq/Y6frLJY6p+lgXXhZoDGkDIBnp77nSJ6V/ar4XKzwW4
 fafaJAgo/IfvJLg4WcWKN+87gxxgwxTpN2gmWbY2DAhBAkO6vWISK6yOZDKTOBANhI6IZoraAEG
 FPeYcJNVvaAncIgAf52x/eALvz8y3hhLybQrd42l4ChVoItqngy2uTD5rA6savBtgMRQtQmW67l
 WaV/xq6Mrb1lkzy6YOZ4CIaHSG9waZ5rAKgxPC3UqSk+FRPaZwoSEtEJX2IIo7BD/ZE1xTIxqdu
 sZFzKWqxjE8CLPl4nQXtWat/tgenvSFID3SauT129bWKLyg1M1NOgDVJA0IiQlI7u9BIZo15u2S
 pn+xjdTSPt0wLJiYu7xzF2O0cEZbXZEWPc0rNTFdDdJmaHmFykm8GI6PtHfctjdGVirponX5BXO
 UgPZN0W8KBjyjMOr+jNAXItW2ypw==
X-Received: by 2002:a05:690e:13cf:b0:65e:a838:e9d1 with SMTP id
 956f58d0204a3-6636e6711d4mr4363227d50.59.1782329268360; 
 Wed, 24 Jun 2026 12:27:48 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6647f926750sm329747d50.12.2026.06.24.12.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 12:27:48 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg removal
Date: Wed, 24 Jun 2026 21:27:00 +0200
Message-ID: <20260624192700.5388-1-alhouseenyousef@gmail.com>
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

fastrpc_rpmsg_remove() wakes pending invoke waiters when the rpmsg device
is removed, but it does not release the send references taken before each
request was submitted. Those references normally disappear only when a DSP
reply arrives, which cannot be relied on after endpoint removal.

Walk the channel IDR during removal, mark in-flight contexts completed,
and schedule the send-reference put while waking waiters with -EPIPE. This
prevents disconnected channels from pinning invoke contexts indefinitely.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90281859a..bfdf8ab6a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2580,30 +2580,31 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	return err;
 }
 
-static void fastrpc_notify_users(struct fastrpc_user *user)
+static int fastrpc_notify_context(int id, void *ptr, void *data)
 {
-	struct fastrpc_invoke_ctx *ctx;
+	struct fastrpc_invoke_ctx *ctx = ptr;
 
-	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node) {
-		ctx->retval = -EPIPE;
-		complete(&ctx->work);
+	if (ctx->sent && !ctx->completed) {
+		ctx->completed = true;
+		schedule_work(&ctx->put_work);
 	}
-	spin_unlock(&user->lock);
+
+	ctx->retval = -EPIPE;
+	complete(&ctx->work);
+
+	return 0;
 }
 
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
 	struct fastrpc_buf *buf, *b;
-	struct fastrpc_user *user;
 	unsigned long flags;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
-	list_for_each_entry(user, &cctx->users, user)
-		fastrpc_notify_users(user);
+	idr_for_each(&cctx->ctx_idr, fastrpc_notify_context, NULL);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (cctx->fdevice)
-- 
2.54.0

