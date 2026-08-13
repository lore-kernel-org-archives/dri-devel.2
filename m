Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB2EC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F8F10F29D;
	Fri, 14 Aug 2026 07:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgrJZfFq";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8DB89EB1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:42:55 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1804680a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786617775; x=1787222575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ao+G57HqxwG/64HYnW+6X3T+URkSZtqOIft3ps0hfco=;
 b=WgrJZfFq/s2ZgN/BSGcPbMZwRhuOl4lgKlVCHDbfhBp337VU4PVzfUyJL0N4oWGn8o
 APp+GYLiwy3j7uaWJ82UvW/scJEfx4gb9qRE++d9CbukGgUXIgnONtlWMf4AZZV70uXy
 UUdpCmyk/pA1P9XlBEyeq4FksVbljvy/3LTGXgLSu+V27kUPoN4T1OWjSgCYQyIsLDxu
 molgL60S8CqUp++rBXetgNJfX221HRXzCezPdYJFd5s19sqOUD6M8Yf1tYzOy9LZblQY
 uy5qQ8d/lS/Z+L/FKbB6MjYNg4tW5qEe1Wq1B1fKeQvYxC4vqPNMVboewacruzQsTADj
 80jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617775; x=1787222575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ao+G57HqxwG/64HYnW+6X3T+URkSZtqOIft3ps0hfco=;
 b=YZ3e6ugFoSrBCBN/KOgUOZXHtwmdo8xWrl63dPmFsBVFj5PY9s0S8GYP2hmzqZJKAm
 Xmph5NEgREodwntEZdK9wRkuqvrguRo4mAo5/D53uyxta3YxMnGgCXRVRPYjJWuexq3y
 bgojaPCI8fdSOKmYlZeolrgf+2171n9s55qSqj5pR0skcO9nhXfcmlI64fMyp+HUbk2u
 WvV2rzpzqaWG87BI95SiNMu/CvQ4e6RrU/FkpNpPpWhFXEaFvYkxpY5LMXFJ8Z49ya4O
 1UBtlmVdaD14ilFFHE0Q8YiIK7pNSh55N8QI+HM8drqyvC6qc/mPQeGAbyNUcK3mk1bp
 774Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQh1D1a+nPE8M5hvGtvN+7hZMIx/71nVbYt20L/pYU0/7WdaeKJ1W+ufY4gvZpO0NHhHXvThfcGqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyokV+sPqcdPeTvOS11u7Q9Ym7Pf35w6vZCHFw0oj6sszpDee+J
 QfGrRt4zr600q8emqZIqBb0mb2hCaabACsJPezhg2oBC8k0cMidWH5L4
X-Gm-Gg: AR+sD12oGpAdY6w9b0fij6FmcQhlwU/igKN3+0TsdF/qm6uY1OUVjFoHuE9yKlYhiJ4
 pfkfE0ifn/nTnjj1zOxPIO89VG25sn0tZ0mNQ2E8GgG3qaMzPyWgSTmTSxvt3TE6We/SKhqXrgL
 9D5JnoFYEPCldOYROz/SA9wl7bPxcfX9R3Pz7CfqDaUiBdCWsxaUkTMZR5iWeF70S9j5m9r9crq
 vwnCpxUnOx+2/VMBevRzAbThQybwcOuGLM/jS1kcjAw8ammLd/AGNHLivufdtSQuJYLuH5ONvrF
 3SNFxX5TkSjrNPsvkCXZEVao857q23ZYmSx9s2eJ3nIcdaoaq/EwimpNqiAY+Anl1EO+x6RM99s
 iT8iH0nEXiOHdhAbNq3UhbvXj4vIs1+9Hrxo/g9cQb/0LrpfbetmVbido/8noyQfscRhoveJhUx
 TbqxUgp5i29zQ5R6nfuazp74ErU+QZhn+w45S1e7ZMgxql1Z+PVwGT0GrzGcY7px7z2va2+Wa1B
 al5jT31c3OrUzBKAp+Xe+ZbRJ7B6DuqcwUiu9qf/PyJAlLiDTZ7hzYVRGoR0t+Dixg6RXYij8xm
 pA==
X-Received: by 2002:a05:6a21:6b01:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3cc54f4a8c2mr6631396637.6.1786617774704; 
 Thu, 13 Aug 2026 03:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412da7d3cfsm10087279c88.15.2026.08.13.03.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:42:54 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] cgroup/dmem: fix comment typos in dmem.c
Date: Thu, 13 Aug 2026 16:12:36 +0530
Message-ID: <20260813104236.1532-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

Fix "succesful" -> "successful" (x2) in the kernel-doc for
dmem_cgroup_region::ref and dmem_cgroup_try_charge(). No functional
change.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 kernel/cgroup/dmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f..342ea5324e 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -21,7 +21,7 @@
 struct dmem_cgroup_region {
 	/**
 	 * @ref: References keeping the region alive.
-	 * Keeps the region reference alive after a succesful RCU lookup.
+	 * Keeps the region reference alive after a successful RCU lookup.
 	 */
 	struct kref ref;
 
@@ -634,7 +634,7 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
  * dmem_cgroup_try_charge() - Try charging a new allocation to a region.
  * @region: dmem region to charge
  * @size: Size (in bytes) to charge.
- * @ret_pool: On succesfull allocation, the pool that is charged.
+ * @ret_pool: On successful allocation, the pool that is charged.
  * @ret_limit_pool: On a failed allocation, the limiting pool.
  *
  * This function charges the @region region for a size of @size bytes.
-- 
2.46.2.windows.1

