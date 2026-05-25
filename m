Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A832CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 07:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0F910E583;
	Mon, 25 May 2026 07:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWJFVdR/";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F16C10E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:14:48 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490686877a1so2269835e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 00:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779693287; x=1780298087; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5YPxs0JzfTvXLL6qyKCCkEFV46IOQigJmqAvNQ18D8=;
 b=TWJFVdR/fFZ2NXTrP+Qt8R2nmFdxzfLwpghJKidleR0Cx9y19WETfaXhkPp7ismxTP
 dazqXfOl8n8lhu6mOvZVZol7d1dPlOo0KQyXTXMbZV35eiRH4YsKNBcGVapfpB6PC0Dp
 PXXfTSwpfmNhslBdd5Qfqfza46Y5STAkE3c93bwqgadVolYi+BlJH6SA7M6u4Ox5BzQw
 V4Pa8v9GN7wHPysF961fuahDC/sqMKDS55/gDFtnnZSiJhHq6zb/yzHpA34+m8gHhIIZ
 TjjxZ8d6UCOwQ3ENgLBmRr0M3qEAUfBXKjCuqc2r+un8m+leqRJ2oFeHde7K+Roc3oq8
 KgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779693287; x=1780298087;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O5YPxs0JzfTvXLL6qyKCCkEFV46IOQigJmqAvNQ18D8=;
 b=T54OFlXE3zE1Mv6rOgvnSYw+87uFDouheZVzEHRtrNNnelZWCa6+K5i2AOaCxsowFl
 aSULUjLmtdshUKHJ3AvJ/EhmymN9s7G124OnCd6DQK2krXcnMQzN9PcjCd6lCWYVEoZM
 Sf0DacGQWE0yI/Ao7UAdu+2iKXoefKVxw3lA+1aNJdAshVxvgjYFoRDGJMez0oD++mzN
 nUVyW2yDU/+rcujyF+FCX0Us8yHBQhDFPrBmRiY7CMNGBWwKmkdzjuoWwQeIR21reL/w
 JG8OL9rd79DJaCjvIXYnLbzTfz5MZGhfaMlcZVtjGOS1eD18zhQXLCkKJGrkcNQ1nG9G
 oO/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3gXIu+TX8Yz+ieM0s8zmoQi4dI055U5LilHbD6ZFWzSD007ybe0GVSU9g7OytEji684op+i/WdL4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMAUBpgJvvAib5W/elbMubkN0Ci0YTLfSGi0Xs9fx9yrd8atsH
 Jgraj1xDJsRyRqheIcmJASYYfCN9Gi3lFiKjqgoRI9OxdBXW/cFamohT
X-Gm-Gg: Acq92OHT2AN4u5WgK6wv7NWUrQPWHtpX4sxpiPemdrrPUKWcvgMMQK2TSBgXaJjgqa6
 WOQ6poucQcq6ay4vvCLZVS++y5VcKnAXp+mJ9vQHHkl8wQ/VmsCr3+TR33Mf9drAkSI0B4/Zpu8
 77n/I55d14i0t2PsfBEUN99U6izyrbmIGKoohHeIrBOt7tmZDfsJrVOZ9Nj0vdkJUeTJuEmf8tF
 XhCDDnMtJ7gQUgHismFQCcPeQmj7wLYifVmKBDrowbGHDJjkQaV8QqNuHvj5tHK8TIaX6RxFXGx
 JcXi70EDzxqDNnGYhOMU1uJrWhyU4r3lgXq3HBaC6RCMqykV8ikiSerrD4aR37zm4E+71tWvDrv
 A12f/a/NC1/YKgGKuY6iIF/2f4cn1/GdBvl/D6UPuiJmj7h9R7mEAoO3n1kEcyYBRnzE1Wg8mnQ
 zze0R7NWLXiI2zrXQTIzl06No=
X-Received: by 2002:a05:600c:8599:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490426ade02mr136310365e9.15.1779693286465; 
 Mon, 25 May 2026 00:14:46 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ea134sm255601535e9.8.2026.05.25.00.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 00:14:45 -0700 (PDT)
Date: Mon, 25 May 2026 10:14:42 +0300
From: Dan Carpenter <error27@gmail.com>
To: Karol Wachowski <karol.wachowski@intel.com>
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] accel/ivpu: prevent uninitialized data bug in debugfs
Message-ID: <ahP24m6Mii9EDL7Q@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

The simple_write_to_buffer() will only initialize data starting from
the *pos offset so if it's non-zero then the first part of the buffer
uninitialized.  Really, if *pos is non-zero then this code won't work
so just check for that at the start of the function.

Fixes: 320323d2e545 ("accel/ivpu: Add debugfs interface for setting HWS priority bands")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/accel/ivpu/ivpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 189dbe94cf14..dc20bc73c6ed 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -450,7 +450,7 @@ priority_bands_fops_write(struct file *file, const char __user *user_buf, size_t
 	u32 band;
 	int ret;
 
-	if (size >= sizeof(buf))
+	if (*pos != 0 || size >= sizeof(buf))
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, pos, user_buf, size);
-- 
2.53.0

