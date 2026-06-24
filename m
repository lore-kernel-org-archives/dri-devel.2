Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA0CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64A010F11E;
	Thu, 25 Jun 2026 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8y5BfBW";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7527610E0CC
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:50:14 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7dfe7712572so12394937b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782323413; x=1782928213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j/uILbh1n2PkpNOCtS0svqEcnFHuP4Pdw3ur3cUKxxI=;
 b=g8y5BfBW7QOOCePdedanBm6tuFYcMQWKeQ33H6ZdSAfrKBeKWQ8m+5J5g+Gi2YnjSr
 GWncPeVFyKIlDdg3qq6D95EbjQEsm3EjGvY4CjM+ZhJVk2ERy5IOvGbhkZMLiMa+jRm7
 noDgIE+W7m8+26DsaCbl3G/0pxfsD0B8X3A4mhgsi/Z686rD9aXmw1vqwiWllycw5GVI
 tJ55oUp9Ir4NWU3zOjrZA43Ph4eyqOhOgG/tMSRbRmEaq3q7paNkKr4gVohvcw4R71OF
 kr5xZnAYnfcWHAvn2GNayUKTRXuyn+dqJx+P3FTB42LVQjx07dKQrTTkmfhZmAjgawPW
 uGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323413; x=1782928213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/uILbh1n2PkpNOCtS0svqEcnFHuP4Pdw3ur3cUKxxI=;
 b=EqZgJmM/9zzRla5Hi8whO/k6Idu2EiZMrXB0SHPSwMLNG1y+ypDA2vDn+vcDHzyVrS
 i9NUVLS1CpPdn0cdhBOEf3xiJTkbhx3tBJ3oBFhhP/dZNg3p6CUUsdxfkcZuExIxTz2C
 IgZMzleN6OCdO9MCq42tUaEOjeIUQVoPfp0Z0rqv5XAbNwFXbzfKAlUqHbkmsTSw7yhn
 OU0/sYImPrWCnwUnX27zSQyZ5YolcK3W9+swMK06OLMX1ByQYc3rhGuNLgfMWbgAYw0c
 FXQAxx92VtHlRAs4udrr9CUaeWpdMSQ+C5WyXZ+SLT3warxfVWtD4AJgIG+siG81x6iK
 M6Yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0xgC1SuPXiDq/QNm5x/vlm52JtR2E+CZkbmHFplJgUd0Kww0Z9trpsiymUQGCKGx4tTjgFL899nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAwPdEtyq4rUP63zoXgP7tIYHJVjD1oxQKovn+ABceH47rw0p1
 dHUAoK4woK5doHeJnrfc0B2lzNKWetAzGMDrr0Qi78Uz4ePfoLQTIRCV
X-Gm-Gg: AfdE7cnMtnQU7xgtdIuJTsL3fk088pZoDTUQTXKJ8IpnatEUmmreanJJCpuyW9wIiYi
 4aCzEpeOx+hNPbopTiD9Bw2VTAlaI7Zh+KjcCRRjp5VFtWtj6Kp0t0/QsTzKNZURr+MgD+yXhyM
 mICJ/t/TZOiaW4aFPxDV51Sfly4boAo8O3ohXBMeRPFLllWSM+hzRvpPv/8tJ1ZnQE54ppon2um
 H4Lf6TjkgTUcq/QWD9Yx7+DyGS2wOC2Im+qz/IKG6DZEWxgd9WksjF+y2Y4QKBULaB2z8bQSjGB
 K8bYM9klw+l0PEP1k1e3ifD6hrbE/S3wuRuzOpq00iEz+DVpL8/1HQHhwYJFz06tVIbzaAc3UtV
 Kn0xtsEqHx21cnAHJ34+hnJv5UBUYmAV/x6+L/BtP9vIt3UbGrKW/maKZuX5Srif2BXBxCd8+W9
 0Z/3oHOOKpexknTmHR/meSP5CrTTDmL0wEnJ4T
X-Received: by 2002:a05:690c:6306:b0:7e1:e20c:1e3e with SMTP id
 00721157ae682-807ef91a515mr44538487b3.28.1782323413407; 
 Wed, 24 Jun 2026 10:50:13 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-80259d20d84sm61339237b3.0.2026.06.24.10.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:50:13 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: remove map before remote unmap
Date: Wed, 24 Jun 2026 19:49:32 +0200
Message-ID: <20260624174932.7419-1-alhouseenyousef@gmail.com>
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

FASTRPC_IOCTL_MEM_UNMAP found a map under fl->lock, then dropped the lock.

It used that map until the DSP completed the unmap.

A second unmap can find the same map and race to fastrpc_map_put().

That can cause a use-after-free or double list deletion.

Remove the map from the lookup list before the remote unmap.

Reinsert it if the remote side reports an error.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6a5239b1c..6ced210ca 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -365,7 +365,8 @@ static void fastrpc_free_map(struct kref *ref)
 
 	if (map->fl) {
 		spin_lock(&map->fl->lock);
-		list_del(&map->node);
+		if (!list_empty(&map->node))
+			list_del_init(&map->node);
 		spin_unlock(&map->fl->lock);
 		map->fl = NULL;
 	}
@@ -2064,6 +2065,7 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 	list_for_each_entry_safe(iter, m, &fl->maps, node) {
 		if ((req->fd < 0 || iter->fd == req->fd) && (iter->raddr == req->vaddr)) {
 			map = iter;
+			list_del_init(&map->node);
 			break;
 		}
 	}
@@ -2088,6 +2090,9 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 				      &args[0]);
 	if (err) {
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
+		spin_lock(&fl->lock);
+		list_add_tail(&map->node, &fl->maps);
+		spin_unlock(&fl->lock);
 		return err;
 	}
 	fastrpc_map_put(map);
-- 
2.54.0

