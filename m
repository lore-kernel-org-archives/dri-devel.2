Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50987CD98CF
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 21:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CF110E0D2;
	Sat, 13 Jun 2026 21:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QeJ3t4H0";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFAB10E0D2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 21:37:54 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so1282973a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781386673; x=1781991473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MfPgGYbUm8nj37ORB1VbQeWiG3oQfXInp8XqV1czevs=;
 b=QeJ3t4H0KS4SJsewyHBRjT16rQr1Q0BUSgpScThetDy77CsatDeJRwJIhDOUN8uE1R
 bUpVbMMecxi9Hm/bsWshdIno0ZDZH0XWCHG96X7dnEmpux+25fyKdB0laTZnVXumcLal
 LfXdRwbPQhO1ABbNEASEOA9spwZGau+7B0WEqng/Fqyvz8qxSJO+/AswcAgIEQiaFdYx
 PPKD2K2PJwA4acmlf+MCtAkNSTi+kN91E+VWMVnjQc44hBO/KQGX7KZ/GDCBqrj1v4V+
 fKdCn8OtX791ot9jwC5VnW8pdI7lwLSUmXyG5t6ltynRB8ZcNgcjInIcg+OabUQU62al
 CpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781386673; x=1781991473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfPgGYbUm8nj37ORB1VbQeWiG3oQfXInp8XqV1czevs=;
 b=BF4KF6THC9JvZ67H/V+a4bj7xgKhQhOHuPP73hHB6FJ/ivmIJrynl9cX7g8k1rJUWu
 spQ9DiRP+bZaeHCnKx5vPlZWc/HfeTXrp63W4IdVSPZyOD0FVfui9l5NbrbCr6DLMGnv
 vYNpONJNYohkAMmpcFFpclzghoMBwhJK66QbYMeVfJaTo9GB6u/nXqjYf7+LRyaJYTqo
 +5y6Qn0BroKgZVe54BrmHLhBG41lWymxD2C8coaiG/UDgCeRcAZN11GkjhLFYgqhjnKQ
 DO4GJQDvj8RxA8JMgZEDkhOWMNYHu3VZL49VbLEQ5hnpgIUrYc/zoJIYI14hqjdkG28o
 4xAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hzBpQk42sJrtvBK+HemyLGD8u1nivkcaeNW9gDxMbsE8AFSkP9OJpLCQxEOZJviWf8qCiaj/ZQl8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnPTjNvhHKDm7PADJz487YPzsRYjB6zyVRDbic6Wv7jremsR1e
 lgQRkySEGRIyJFExq3wv+tnajAfLtAcEKLne5h7FboMClX7pv+96cWpp
X-Gm-Gg: Acq92OE+cMW3BwAfNnLLegvzRsozn8+dpKktzCX1s6e8rMkViDipSJrVYXYCP6kCkMc
 CeBPDbhvfdavkeH122Ci+YFGjokLVpPY6s5vzeY++l/d+JuS3Gh5JmuqKwSpzl2oa64mY3AP2ek
 fuopYXew6OIjp79ef86tZu4hsoppd2ECQcUSK1IFn40ZxDynB32YNfZ4ghBTMaalzDq1o7bFWQ3
 omJ5U5BQiz0FB4GCiZwd0glbZzPE6XLSPnJZNZW2Mvb9WVT3YNrP5D1bl9tF/bDUFrx1VlN4TQn
 Ur0wXrixr3UpbsbDS2KCzAJyOaVyvLNDWamh+399IiaRMftzjE4qwOiS6PRClh6fwWBxfsiv3iS
 ephM+G0XIHIpDzParcGxfmmdqpOQgbtFJPA5PdpS535lEeJbOlWeAo8INJd6TlG9awGF26PwCg9
 Q+yOU6fKWiXCcxYoRw+6ftY8FUAUE7DQhTdr+hhfqNDkQJ7hrtFgKyFiEID4bX2cII7DGTajcSB
 cX+D66LSc2RfnXoXJe5
X-Received: by 2002:a17:90b:4a11:b0:36a:4074:9aa6 with SMTP id
 98e67ed59e1d1-37a01b3f8b6mr8250263a91.6.1781386673358; 
 Sat, 13 Jun 2026 14:37:53 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([103.129.134.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37a20dbc386sm5822002a91.11.2026.06.13.14.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 14:37:52 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Max Zhen <max.zhen@amd.com>, Mario Limonciello <superm1@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel/amdxdna: Validate sync BO range before flushing
Date: Sun, 14 Jun 2026 03:22:47 +0545
Message-ID: <178138666764.88126.6546036881766614184@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

amdxdna_drm_sync_bo_ioctl() takes offset and size from userspace and
uses them to build the address and length passed to
drm_clflush_virt_range() for BOs that have a kernel mapping. The values
are not checked against the BO size, so an out-of-range request can pass
an address outside the BO mapping to cache maintenance.

Reject ranges outside the GEM object. Treat zero-length ranges as a no-op
before cache maintenance, because drm_clflush_virt_range() still flushes
end - 1 on x86. Leave the existing SYNC_DIRECT_FROM_DEVICE debug-buffer
sync behavior unchanged.

Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 6e367ddb9e1b..c56c8fd86276 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1040,20 +1040,33 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	}
 	abo = to_xdna_obj(gobj);
 
+	if (args->offset > gobj->size ||
+	    args->size > gobj->size - args->offset) {
+		ret = -EINVAL;
+		goto put_obj;
+	}
+
 	ret = amdxdna_gem_pin(abo);
 	if (ret) {
 		XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, ret);
 		goto put_obj;
 	}
 
-	if (is_import_bo(abo))
-		drm_clflush_sg(abo->base.sgt);
-	else if (amdxdna_gem_vmap(abo))
-		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + args->offset, args->size);
-	else if (abo->base.pages)
-		drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
-	else
-		drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
+	if (args->size) {
+		if (is_import_bo(abo)) {
+			drm_clflush_sg(abo->base.sgt);
+		} else {
+			void *kva = amdxdna_gem_vmap(abo);
+
+			if (kva)
+				drm_clflush_virt_range(kva + args->offset,
+						       args->size);
+			else if (abo->base.pages)
+				drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
+			else
+				drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
+		}
+	}
 
 	amdxdna_gem_unpin(abo);
 
