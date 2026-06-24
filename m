Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CB3CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D93410E19F;
	Thu, 25 Jun 2026 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYsdaL4E";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4C010E0F1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:26:07 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so18003855e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782329166; x=1782933966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BvV+Q7TxmkZErxEzBPmGA9pyzogQykAvWuzenzPuaG4=;
 b=HYsdaL4ElDzK4mtqCC22G4QxSo2U8dge6UZOA6OKjdjXqCcLmFt2GKoU8WBXaGdtbq
 /D06Rf0yebXMdcLHlbBEMwXsprOsorehLErTs3t40Km+DHNpylEpOKYc86CKnp/vCz8F
 3WoX/S2G0+TR77q15p1hgHtgpPs1f67ga4415DEMiwlOedH98dS5wSqCI0adyzNT9J15
 NkJ0Lb0fmHK7dDDdv6YkrP44kfEFAqK6pt/qYuvF5D+aOQkJgD0QJcK9wTkYFrATeWa6
 ybXco4cjkLbx3yVw7/JZQ3xYDuEAw0RmGlcWV64a/n3sekp/+7ZZ30Vq6ptnq2HLTTBk
 waMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782329166; x=1782933966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvV+Q7TxmkZErxEzBPmGA9pyzogQykAvWuzenzPuaG4=;
 b=mxFFnQTpvyS8bNsX6TQMxhOWCh68YlkTPO5QpOsR6uuT2P9UVsU4u7kRfhUbg6BOcF
 oRUg9u6+/O7Bi/6jOkblZ68DUb82XNNjcInMnTNFw6mOj5UxxEfwRvGs6mk5Yk3WSbDq
 a/NNCXyB9vCeAxfjiqXAkrfJOE3XwCzshiKk5oasBYGCQYQ5ld1qZxjYiLoO78nNqq4k
 AYV8eG7jtHmIq93//RlbqS1UQxZSHxk1RFUCLgilPGZ1otciWY+mDDQsiYdlAQitcxfS
 /WIrDhH4qD2agRQ0vtzAesDpGX5P0bcJcWs9bXEjsMgoa4kEHhf7PezgAhboAC06HDBe
 C0nA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kTUsmkXd+kkT1CmgHQuca6daanzShdOZvHqveZcQEwgD3qiqMMCfFJyJfwXWzM5KSu4oLyGrOhLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNS8n5a1x375n0R2LjqRDpZTzzZv5JSWAQMjqjngO7aRLtx1y5
 w5V4YteYSOAo6qXDNj1huflAuD+tU9sjjs42agNNGwHho5h+cvQg/Aje
X-Gm-Gg: AfdE7ckp1xn/A8SJeNxnFwFJmc8QNprqlrBQUgwv6eJyo4mgF5OMzkftDEysb6DPdnw
 vnOcKjlUH9WX/TyW+bvkxnqMUJgTzzoNfEfgpSMAhIh1PRR5pz7Ylo1XlTaXhPpbRMb6HpSQ03z
 VOpdcy84s0MIyuLcpsgNrpoHWgZzS00l90SZ3AQjFZqD93spWoSUcR3Kv5sD7FnGnw52Q0BQ3LF
 lpce4VkV/V5EKn4SlhL/lBB749KCat7QGLZu+0v5X9Z/9YS90J/PMhtQgp4UKL+B5Dc4J+26Z7x
 kn2wjXL+qbZvu9pcl2utN1XvEW9V8WKtFHaJzB4H+NALWkdX6HUizqjNE5SN0wSL2/tTRmcRyLO
 E/YKnxm63eK3BeSi0eCEmXkZW160jJS1jepjOO2eUUNRJ+oY8M6heHMXNj/FzzWp9ny0NjukmoP
 Lq7l4yCq6j5ieJG4bxTcS/VKM208KtiRISwMmy
X-Received: by 2002:a05:600c:3489:b0:492:5068:61fc with SMTP id
 5b1f17b1804b1-4926086c3fbmr73867905e9.19.1782329166203; 
 Wed, 24 Jun 2026 12:26:06 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926417f0c7sm11379775e9.14.2026.06.24.12.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 12:26:05 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: drop invoke context on interrupted waits
Date: Wed, 24 Jun 2026 21:25:54 +0200
Message-ID: <20260624192554.5172-1-alhouseenyousef@gmail.com>
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

fastrpc_internal_invoke() skips removing and dropping the invoke context
when userspace wait is interrupted or a kernel invoke times out. The
context remains on the user's pending list even after a later DSP reply
consumes the send reference.

Remove the context from the pending list and drop the caller reference for
all exits. A late DSP reply still holds the send reference until the
callback releases it, but interrupted callers no longer pin completed
contexts for the lifetime of the file.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4b258dbcd..90281859a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1379,14 +1379,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		goto bail;
 
 bail:
-	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
-		/* We are done with this compute context */
-		spin_lock(&fl->lock);
-		list_del(&ctx->node);
-		spin_unlock(&fl->lock);
-		fastrpc_context_put(ctx);
-	}
-
 	if (err == -ERESTARTSYS) {
 		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 			list_del(&buf->node);
@@ -1394,6 +1386,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		}
 	}
 
+	/* We are done with this compute context */
+	spin_lock(&fl->lock);
+	if (!list_empty(&ctx->node))
+		list_del_init(&ctx->node);
+	spin_unlock(&fl->lock);
+	fastrpc_context_put(ctx);
+
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
-- 
2.54.0

