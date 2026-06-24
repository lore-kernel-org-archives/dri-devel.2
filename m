Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBB9CDE002
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744D110F146;
	Thu, 25 Jun 2026 07:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTFFDBwk";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BCA10E0EC
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:15:01 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-804e46366d7so14984507b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782328500; x=1782933300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7sROD5HlkA+LmTbleM4dPRK+UQLEfjLcyo66jmPeZ7M=;
 b=GTFFDBwkBZw2uZoPobrjeF7vyH0CJCkRHPLXbycich7sORoBkRcGZ9XbsRB4HwIcCQ
 vGvx2g4EuN2gy0bFLl1Z5ddmF2ZzNr0UWIa2et1lQtN8Q71x6IbY7aEyWUd9rI67yJyO
 /Jf7OKXrEok24jxVI7sMatqWr5qaxLd9LLYrnJm4EV5JRY9VwfJ+qk741rlyTwhl9efV
 UH9YL5i1AZsOZ5igFCoZtewvc/jJlzMdR8UdHw2xt48/py4+ZpEs1qAZlY3nRl+bJZvK
 EF+lIvO32QXZ57X+rp9nxkNz/I+I/EvIEY8iVPU4fO+fcSs1vID5Cv+VcfTHLKy9vXet
 NYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782328500; x=1782933300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sROD5HlkA+LmTbleM4dPRK+UQLEfjLcyo66jmPeZ7M=;
 b=XMxTQG/ZBiSH4GKLC/cbQW/qIW2h98n4nhWX9n3RDP6iv+/o+wWBWI3eVsgKtLPJ0O
 gvEVlAxxXPE66jjjfM4ZGca/4aMeNm1nPJClRzCGjVaetn9C68C/L+/Pp2MtQx5ELGkF
 geNtyzSD20RaGAdbNrVWQP2n/oFoXffLqOva7Ag3X/CK90cHh1gjFVzvuY9RWOUZeLfc
 Z6yKbIt3hUabFnsjrDDc5sWZdiTNYWxPYGP4LOxSJagM0FmvG/3nDmDQQgeA16RTH72E
 grtfQuyj0WKSIqS0nd+RakGu+uI7zpn0+LKJe5QFAiqDg5NzyXmPX0pKGsCbTEr2F6qo
 GELw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrs9zxQStuaYAyFc5grUxvqCc8qX+YkW4aec06xpQElpk9kHK0NJh0/QlquecQIUQTxpxxCYW35hWw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMf6vOVdwBfCwdpVYz13ekyqPddVZi/29MiLW67PZQVivgIUuj
 v/I5iyhYt/ta3LounHbcMA+Gw8gdDT0eQPmPoLTDJtZ5zocg02HEqalw
X-Gm-Gg: AfdE7cmPWRNCZwV+9biKPZ5cYNmLOIwNBShWPMUFzon8oSmaOPP7H5xyfASw+pl+u7n
 m6l9uvbQNoK1CUHooIVie94eXuCaVmsVBnU8FsMY00azsQRRtUkBItricCVsLeHzqp/jZ90TGP2
 aMAsoQbzbXdQvhOkGj9iugvUkaRq8wqOkCYEH/YVucEYW54ddLchEmL4cWS+hNydQ9l5cwhqibO
 3QWZX5i+GdxzA6gx9NnH3W+dY8PK6RuAS4uJyUOjINgA2MAmGY6gyTY1mBO7VYhg3GQsSkOpObv
 paTdKrikCRvDfQR6bVg8SljjNO8CdyXWULl7obvv9v8BPHVKa84VwBv771MIVrcFjRFgbkScgui
 Ee9GIOwDQZNRqFyso2eEQeyBUPSxp4WRhSw7TpAPB7ZNbLlAYtHpqlgjVhgId2d0N1zyitmQidy
 We/5BwPbd/rkvk4pu8wkKHJo198w==
X-Received: by 2002:a05:690c:b14:b0:7d4:3090:f39 with SMTP id
 00721157ae682-806c43f58f3mr92422577b3.42.1782328500344; 
 Wed, 24 Jun 2026 12:15:00 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025cf63680sm62743047b3.19.2026.06.24.12.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 12:14:59 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: ignore unsent and duplicate invoke replies
Date: Wed, 24 Jun 2026 21:14:15 +0200
Message-ID: <20260624191415.4034-1-alhouseenyousef@gmail.com>
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

fastrpc_rpmsg_callback() drops the invoke reference taken before sending
the request. The callback can currently consume a reference for a guessed
context ID before the request has been sent, and duplicate replies can
schedule multiple puts for the same send reference.

Track whether an invoke has been sent and whether a reply has already
been accepted while holding the channel IDR lock. Reject unsent and
duplicate replies so only the first valid response consumes the send
reference.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c91d5da42..4eaecee1b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -250,6 +250,8 @@ struct fastrpc_invoke_ctx {
 	uintptr_t *buf_pv;
 	struct fastrpc_buf_overlap *olaps;
 	struct fastrpc_channel_ctx *cctx;
+	bool sent;
+	bool completed;
 };
 
 struct fastrpc_session_ctx {
@@ -1239,6 +1241,8 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_user *fl = ctx->fl;
 	struct fastrpc_msg *msg = &ctx->msg;
+	unsigned long flags;
+	bool put_ref = true;
 	int ret;
 
 	cctx = fl->cctx;
@@ -1255,10 +1259,23 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 	msg->size = roundup(ctx->msg_sz, PAGE_SIZE);
 	fastrpc_context_get(ctx);
 
+	spin_lock_irqsave(&cctx->lock, flags);
+	ctx->sent = true;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
 	ret = rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
 
-	if (ret)
-		fastrpc_context_put(ctx);
+	if (ret) {
+		spin_lock_irqsave(&cctx->lock, flags);
+		if (ctx->completed)
+			put_ref = false;
+		else
+			ctx->sent = false;
+		spin_unlock_irqrestore(&cctx->lock, flags);
+
+		if (put_ref)
+			fastrpc_context_put(ctx);
+	}
 
 	return ret;
 
@@ -2586,6 +2603,10 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
+	if (ctx && (!ctx->sent || ctx->completed))
+		ctx = NULL;
+	if (ctx)
+		ctx->completed = true;
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (!ctx) {
-- 
2.54.0

