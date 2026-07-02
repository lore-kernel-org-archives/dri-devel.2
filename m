Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CC9C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEC510E595;
	Fri,  3 Jul 2026 07:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="onYtxrSR";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B5010F1BC
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:25:46 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-845537740ddso979479b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782977146; x=1783581946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FCmxnXldFzmagzY4ubPmQ/onPJKAAsxLFT7eh00Vk4s=;
 b=onYtxrSRIYePtOyLfhIrcK2xsmUPAPhvSJzDMn1jb790E3aY1lsT8KS3rAo+jqXs9Q
 RwlZ8+TdETPFCMPQ2X79H/WfJ44yN6p2iREm4kCkJKxhTjGN+dz0CcL1GSnr8rQCSNiA
 ce9BRstaMyYMhIE59i09bq1HY+i3W/9fw05ZF4Ewj6QEK0npjGXBfbTBjmrhs7c1JMd9
 DjBtvPx50SwnChYjReVvbb6W54qisW+qW+M23gTJSWhuFtbEJw2A8zpIE9DqCjP7zWmg
 4y7uFTpwwJLr/FeOJilB7cvXFLczoW4NqojAi8UEWdOCm5DR3fr1iFfeUg0+loaqsjoo
 Kx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782977146; x=1783581946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FCmxnXldFzmagzY4ubPmQ/onPJKAAsxLFT7eh00Vk4s=;
 b=exHU5S2dQ0jeWat6YBbUWZ0l9NOORXJ0HFYloXo1Oan5HEGDm5pb0NIuERQHRRLnEb
 ek2jqg3CQr+f872/YeuiAeB+txRM87TQ5cq2khxC/vcxTgAHnBk7JrrE/nfTcBgrQV3U
 dVcvW8L9xaXSeOALz5/DecTUuopV/Llgx7lM0T2koZO3gTZecQdXgJ1t5wfrQ6hKMuc9
 z61nuLQTv1GP84RZUiyWJiigJpR/ny8Mz9QtZ3kM1byw2ZoKHiGolIZzqdDkclbjWbXU
 fDNLqnIjOAdujzYTvU9ec/P48fac/vI/O4YGWW+6jDYnPpxzHrfb4m/13/J4bpizd1fg
 LkdA==
X-Gm-Message-State: AOJu0Yzxrt17YaoJPpZ0LaYi0oQf5ZDI7zELrp5I+PN1zyB9fcfaUhVO
 Sn1MYHv1rMNh5wHkS5QHi2i1lddOZAUFRaCQ3/zsV7anaA5t6a9UPP7w
X-Gm-Gg: AfdE7cldg1nrvaoMvdw20wWGUUGEpyxk75e5GXw/jfqOOLfjgpOsXPtlETK0ed4XY+3
 rzE18NymRllVs1j/1DR81ze/iOoMBVkHtoFYQuu5GRfpiUJdqZiMWptS0wDGKcjdYQOYIA+qsde
 WGTsTC6AIxUJWanD5457ytOZtRUM5Q1FuMKlmrcZ7CWep5++eYq1covljzlc4xoPInBQ+5iIK3z
 Lwk+XYq4EDKqDonXql6ox04TX932O3sS+k3y8fj58rH+aHt8OSE/968S7XZFm6pHApG9TCLLfi6
 aBiJZs0rWPDrug8+XmWGbjcDurJ1YfihwTPtoy77I5VYw4KAOFQaho4ImjVeUfuA6BO9blF0BC8
 cBhM9yAhQ5LKZmjiUuMWevdMIQiPewKULajaEzhtzHHYpf81/rW5ltYbtVMnYpRuHIChqUAZb5o
 K9bg6KO8xsHnGDgksXhW7Tk5R9tA==
X-Received: by 2002:a05:6a20:b786:b0:3b5:489c:7bb5 with SMTP id
 adf61e73a8af0-3bff422d1cbmr5285217637.28.1782977146282; 
 Thu, 02 Jul 2026 00:25:46 -0700 (PDT)
Received: from lenovo-thinkbook.. ([114.143.209.22])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa33asm6415252c88.5.2026.07.02.00.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:25:45 -0700 (PDT)
From: Jhonraushan <raushan.jhon@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jhonraushan <raushan.jhon@gmail.com>
Subject: [PATCH] accel/amdxdna: Fix double drm_gem_object_put() in dma-buf
 mmap error path
Date: Thu,  2 Jul 2026 12:55:40 +0530
Message-ID: <20260702072540.2183601-1-raushan.jhon@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

amdxdna_gem_dmabuf_mmap() takes a reference with drm_gem_object_get()
and, on the vm_insert_pages() failure path, jumps to close_vma which
calls vma->vm_ops->close(). For a shmem GEM object vm_ops is
drm_gem_shmem_vm_ops, whose .close (drm_gem_shmem_vm_close ->
drm_gem_vm_close) already drops that reference. Execution then falls
through to put_obj and drops it a second time.

This underflows the GEM object refcount and frees it prematurely while
the dma-buf still references it, leading to a use-after-free.

Return directly after vm_ops->close() instead of falling through to the
extra drm_gem_object_put(), matching the sibling amdxdna_insert_pages()
error path.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Cc: stable@vger.kernel.org
Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 891112c2cddf..3ac8c345b25b 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -526,7 +526,12 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
 	return 0;
 
 close_vma:
+	/* vm_ops->close() drops the reference taken by drm_gem_object_get()
+	 * above, so return directly instead of falling through to put_obj
+	 * and dropping it a second time.
+	 */
 	vma->vm_ops->close(vma);
+	return ret;
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
-- 
2.43.0

