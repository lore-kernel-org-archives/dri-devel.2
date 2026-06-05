Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D01CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9F8112D68;
	Sat,  6 Jun 2026 07:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="Kh2D05iE";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AC911A5AE
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:42:56 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-91574384cc2so243429985a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1780674175; x=1781278975;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jDvkiRMPuLtyk7kkNunkFVh4+WhfFUZFqxPcwQnozzM=;
 b=Kh2D05iEz6Q6HQcgxrEAwfQygxW3wgqaQwtmsFgVlGS1xVZ6bXqbPCMioz/2IqqiUF
 2s5wWHhXZ15v7C6WkEP+5uzWH5OIxicpEVp1l/616VI3xEtlNoJF0o0W9SFeQ6aV1gkc
 fMZu5VNeWZgHK8ypStACDwDbG7hRfGAB0gVs/YtfdlNxcyhPMTU6+jNXBBkrFOtTGnTJ
 B2Ggg8RhVZqVulkDNvDplKHjnuSZtQV3R6h/7aKTR4wsCIKHbQoXB0nhr+p/D9Y4PaCu
 2qUZAnWDkm0COQVBDJqAHja3Jqz6nJLFJ1M7aE/OJVIAEBeH2E03/IEHeb15cfMVGhAI
 47AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674175; x=1781278975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDvkiRMPuLtyk7kkNunkFVh4+WhfFUZFqxPcwQnozzM=;
 b=NlMIfB9xR4HMhKzE0Iui1D1JLrP0AV63uc+III6V6oOPJI9jXPZfu9AWkpDMXxJRx/
 ObsnwG29nep5p4fl2IHsLyEIano+PJVTDvk98LMDkqDw198ushu4mfGXEApDWT/4UasX
 xxyyKbcxudylGbj5fU1FY8snIbNrQOrrCkSJv9+rlj7bqu85maBUeUfQ9HEsQ5pyjxQm
 Bmb6ksijSoEtTHQ5s5NRy4tYfiH0AFQtaGkZV74cmOYaJg58y1FozKFUwwiHNAbM9F6p
 1EVtX2fbZVM9ZuDi4lNvv60cMLw2QJzNvt/03eHAhAs+xIxzklpwpdWB/zoknH1gsEqc
 a5wQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ89O00Ct8xYqLTLXHuvyQ3o6fPgGAzISbuWwst29oA9tE+Ya4cX2s/WOTnPPkLraJuavvvjWTXZguo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmBLztNxgXhsjWUNDDvCMvJ4jHb2/Veml1TFyl4mZmCBUtIn+e
 HMqN58QE2t0aR7BFC8SG+aY8z+eLUhAD2DPf/k7OXRdBSSbMUQafhmMCYuEi0PGYjbQB1vX25Qj
 SKZseLpI=
X-Gm-Gg: Acq92OEGBOitmd6iZwTVPix4ZsBHI+2KgOHEkqH9pdakf/SEir62BcY2YjibqJ5nXcK
 76VilF5i/p4Ivf9XLUDRpBzHGfnaAsrIMjuLXre7ZN3yWN58KSExRzSJpK8g/28FAMmqd6vlOSO
 tLrdzfq+hk4Z52x1tGrQFIhxN03l62ekL3T9ODzwwHjci9kdg9S+n/QSqSiNTA0djO+DZmj6gi7
 awt3anUpmUjDeqhyWo8tdRyR/ApOBC57NTdPqfkO4j9prNAoMncxCKm2G3upCaqEYJ3FJYVQK8K
 9QFyPeWutOpp8u49VF/pYvAt/fuU3Jzr4Ito5XSCCJ7yK9pfNq2i8a9DbAQqGpguHhmXebdcuv9
 XCs45oy0clmLfbuoOUG8a5m9QEPf0+awFN+ck8htj8JyADz+D2qyjzQovxZOqV/m7YIJhc+KJFX
 ubwogZ5Sf9IEOVsltzw+EH6R/3JGHT7FntkZ0jUw==
X-Received: by 2002:a05:620a:254a:b0:910:db3a:7bdb with SMTP id
 af79cd13be357-915a9d888demr747343385a.32.1780674175256; 
 Fri, 05 Jun 2026 08:42:55 -0700 (PDT)
Received: from localhost ([161.35.96.86]) by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-9158a37bae6sm927242485a.31.2026.06.05.08.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 08:42:54 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org (open list:USERSPACE DMA BUFFER DRIVER),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING FRAMEWORK), 
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma-buf: udmabuf: validate create-list count before copying
Date: Fri,  5 Jun 2026 15:42:51 +0000
Message-ID: <20260605154252.2125942-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

UDMABUF_CREATE_LIST copies a variable-length list using a byte count
derived from head.count. The list_limit module parameter is signed and
writable, so setting it negative lets a large unsigned count bypass the
limit check. The u32 byte-count calculation can then wrap, causing only
a small list to be copied while udmabuf_create() still iterates over the
large count.

Reject negative list_limit values and use checked size_t multiplication
before copying the list.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 drivers/dma-buf/udmabuf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b8ecb892bb..46b077639bfb 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -13,6 +13,7 @@
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/udmabuf.h>
+#include <linux/overflow.h>
 #include <linux/vmalloc.h>
 #include <linux/iosys-map.h>
 
@@ -489,13 +490,14 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	struct udmabuf_create_list head;
 	struct udmabuf_create_item *list;
 	int ret = -EINVAL;
-	u32 lsize;
+	size_t lsize;
 
 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
-	if (head.count > list_limit)
+	if (list_limit < 0 || head.count > list_limit)
+		return -EINVAL;
+	if (check_mul_overflow(sizeof(struct udmabuf_create_item), head.count, &lsize))
 		return -EINVAL;
-	lsize = sizeof(struct udmabuf_create_item) * head.count;
 	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
 	if (IS_ERR(list))
 		return PTR_ERR(list);
-- 
2.43.0

