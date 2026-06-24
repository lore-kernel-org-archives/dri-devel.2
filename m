Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57009CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC25C10E1AD;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bUGO/C4S";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D75E10EDF7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:55:14 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7e1916922b9so18969067b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782327313; x=1782932113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7YgHnl2lJKwXfRhDrg0bud/BfHOtjapxwR6hn+EBYNI=;
 b=bUGO/C4S7Cq5QDBX+jb16gu1NrAwdBvgWwe4XB2TotqhDAVf+0YBe36VlbEhImE9BK
 Duyb1pxSsPrJ6HA+KBBddIedqSOmuwweV8u301bLsINQO9X77OMYAExQhcs0GXyoWe7e
 0vxelj7XX1dnRZmbRdsOm+CDVs3oVd8FvLMx2Nr2nXtjcV2A6iEhkFc1z6RlPRLmif73
 Ip+u+Z7WPg9ekd7dIslnAq0GMNviJCD4kN6jd98aZkAvq09g4oJVSE41RnbqqL+HCLsM
 MVwulRu6Nh6yXDdvAa4IlMmfiNp/cDi1TBgPBAWLc8WfTCFSpDdJ/Gdk2BBIDBcNCxr3
 MDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782327313; x=1782932113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YgHnl2lJKwXfRhDrg0bud/BfHOtjapxwR6hn+EBYNI=;
 b=ald6NzGXsw2CB/fIlRV4F4NvyFQiVqEhD32Jd+k56/GZxb3se9V95mbT9tfYKgall4
 uIurikSbyyA8UtqNpPi7UkZSZdneh7+03fJjXbTTg9BKEnYQSReSwGOl7Wr6LNGuvdGd
 8heTv3QDOeIi7n4txKmsFOWJTkAx/ixkjc7PcKMz0Hy5G5Escu7euB9bggpfsEFVh4oU
 rNl+5afJRizVWG6qCMwlz7X2Fst5Qn8rr+J59WbH6DFtnhxSGsLGUlDxkZ5p1a7datP5
 UjNWfaWKsP+/biGKgP1W/XhPYCN3tp8qBBzb+kmOldOegRaQNf4qKhhBl3uAr07O/4dG
 QJsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlFFsAcPLnQtASSDV9CrDzGdeepuS11dpeI+kGI7AtUL2HvTr3LA2zM7+99tGOAiYmTGrXVT+0NZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzpogz+zw9tkON6TLd9ilWer4s17UUT8AMZxD9me+rwFDZadJN9
 D2s2t8hfEINxuedwYzUyORKtunV+tQWjImu9tPUJmahgawCG7Ze0fVF6
X-Gm-Gg: AfdE7cl24N4OyObdXsgCmpvKk67DD0G181xT9Zy4R3if86wDTnMCNvTnwsjgZJJyCor
 Wgwuot96M4E/k/7AZPzRXaP24uLM5Lkzs1TrxLdEYW+DRx2NgHYffyoqK7AxGESQmQ67Nr96teB
 WHZsPQp3dlToi/mZ/sQCSs+gJFyVdmiF6FlxLRE+eobdsFeOOUX2nysN8mSjArJsKzjU3vuf/54
 YJ+WkLrwYLdKPR6R+NJeIiSA6HuKs75dVBF8MUeoVs7pmYO+MCrK3gqa48UlNtorqwKJTFFxKn9
 djQtqrYg1gZ2SvVoSSi5jneihJejHjRJnGzmOGTGgI4aplDsb+4ITAQEhlRg9wp/jfagt8y+Pf2
 7cjkShzgD91IAms/dBVA1rn+226O+SNkFMlSGB4Aev0tilqFXsZSzkfoIgV1nm21qAZPVGQd4V/
 3ufRBf/XlP9zF+8G4FJW11OHi+ig==
X-Received: by 2002:a05:690c:e241:20b0:809:9422:8c47 with SMTP id
 00721157ae682-80994228e31mr20933047b3.22.1782327313072; 
 Wed, 24 Jun 2026 11:55:13 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025ffc2730sm61645687b3.34.2026.06.24.11.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 11:55:12 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: initialize invoke refcount before publish
Date: Wed, 24 Jun 2026 20:54:27 +0200
Message-ID: <20260624185427.1451-1-alhouseenyousef@gmail.com>
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

fastrpc_context_alloc() adds a new invoke context to the pending list
and the channel IDR before initializing its refcount.

A racing DSP response can find that context by ID and drop a reference
before kref_init() has run. Initialize the refcount before publishing the
context.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6ced210ca..42fc128e1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -703,6 +703,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	ctx->cctx = cctx;
 	init_completion(&ctx->work);
 	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
+	kref_init(&ctx->refcount);
 
 	spin_lock(&user->lock);
 	list_add_tail(&ctx->node, &user->pending);
@@ -718,8 +719,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	ctx->ctxid = ret << 4;
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	kref_init(&ctx->refcount);
-
 	return ctx;
 err_idr:
 	spin_lock(&user->lock);
-- 
2.54.0

