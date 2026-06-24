Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E488CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9FD10F13C;
	Thu, 25 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/6nFwhJ";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DFB10EFF9
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:47:39 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-7fe8bc0a01bso14399737b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782323258; x=1782928058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S9uT2nEBsVBOjOqOHhykIfJmB66KxhmqDufZGyy0LUQ=;
 b=T/6nFwhJNcAy5v5v7SGjZbCFr+JlE90avLVn/h9TY/xdEXdywcF5bldifOM97j5DOK
 sxfwbYXUyNwRsrnA3AX9NPhBdUmH2mb6oiNp2uXmEdSJgujIA3fXfSuBAD2Twb5StNBS
 7VEzBxZe+jpI3+V97tW9hiiB5IBf4xd2mV6+98ukrgTq8dJAXuiOWsGKCSafLjx6qsdE
 SnHQPKsB3jlX181cq5cOtOl5CCGiiIcE+fLN/yDepBKp+MTw+qbfuY2UxZ2aCSdEN7P/
 hJJBrRDuW0sKQvOsSxkTLVetLa/5AgIWmYHKymQ0XF/ZIZ6l0U9wZmWS8mL98h637P2X
 NKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323258; x=1782928058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9uT2nEBsVBOjOqOHhykIfJmB66KxhmqDufZGyy0LUQ=;
 b=QUiPHVqQcDr0SzGSIEXkLHi00R/xhLj06wB3UQyelqU2SXONZIaUH5EwXgBWgPBPc8
 q8QUtiFdl9+tAECHgcfdb+FnUto3303c7JMyldFawSSmIXj1KXKzW5SHyryZR2ZWB1MM
 UJLiz21C4oU0pM4s8NZRtYywbAPk1dLUDsA7r2u4IWhMu4GzF8v/g3wN+Mxd0UlRS3Gt
 y7ygS05WtkXpzHcA+7DammJHiY9Rou2NyoGf101F5yF86bEGbegNnggkMeNHxIGUUmtE
 pcW37vSXrPF2eyaK9kqxfUw/VFfRXphCPI1dKnwIFE7mNC4lVQI1lltVs4nzfgQELf5C
 Qffw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRUFSGdOkR7SL+p1mGr6nN8p1sd/6faQUXLHXU82LnXyMLVRTOQPbnWQj1Dzio+7SyWzFwqixvtQo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwljkJDQjiP5HjlaUqz5craBhvM3XYtNd8f1FMJ01UUzQkx08RK
 2SA3KywjMucfpqfg9yUKa9x44YnQAwOBZ1azeCarUQYYPWo6BRCYYFkh
X-Gm-Gg: AfdE7cn5fxW3wcSLFdFyEvOrGkDvNuWKl7Jt6SodPWSLcH8Lp9TfBjxSXjjrdKCinnH
 m7pRanC+FqFS4QTyDjYmBlYHl6g3WuQByVc8bPkSlK4b02/2ExmsnW12hL6J3esH3Gj8hsKdvA2
 vuJVASf17QIPcnwR5JQbuQ7m2PHL72dIuvxBcM1GxuUFsTRI1lWPlEph7CBWsvOvqP4MdgFpANQ
 FVPf1TOLqtcb40QLMf5zE/4WDteotCZ4zDZpVKXauaylAPWKUtqbAGnJCGL0+NN6K1u3/YrICHd
 Xeig/YlHjFpGskG8zJAx7TD6Fy81TZL+H2LelLnnzFgILIHkWwGEYRBRlBKVF8lsrwWVj87qWcs
 7AGQgsCzaHngcARLUs5HfMTNs6Oul23KpM6HAUhuBOF4NWWnzSn/AJ5vGJNDmvBmwgbr8JuxAEE
 A2iqs8O/iHuuH5GHKQaXEmucaVWw==
X-Received: by 2002:a05:690c:c4c5:b0:7fd:5297:28da with SMTP id
 00721157ae682-807f00ea515mr37907337b3.49.1782323258458; 
 Wed, 24 Jun 2026 10:47:38 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-80259d20d84sm61310697b3.0.2026.06.24.10.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:47:38 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: remove mmap entry before remote unmap
Date: Wed, 24 Jun 2026 19:46:52 +0200
Message-ID: <20260624174652.6792-1-alhouseenyousef@gmail.com>
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

FASTRPC_IOCTL_MUNMAP looked up a buffer and dropped fl->lock.

It only deleted the list entry after the remote unmap succeeded.

Two threads can therefore find the same entry and unmap it twice.

That can lead to a double list deletion and double free.

Detach the entry before invoking the DSP.

Put it back if the remote unmap fails.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ba4ade874..6a5239b1c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1902,7 +1902,8 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
 		spin_lock(&fl->lock);
-		list_del(&buf->node);
+		if (!list_empty(&buf->node))
+			list_del_init(&buf->node);
 		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
@@ -1917,6 +1918,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1925,6 +1927,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
 			buf = iter;
+			list_del_init(&buf->node);
 			break;
 		}
 	}
@@ -1936,7 +1939,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	err = fastrpc_req_munmap_impl(fl, buf);
+	if (err) {
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->mmaps);
+		spin_unlock(&fl->lock);
+	}
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
-- 
2.54.0

