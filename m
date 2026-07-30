Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FA2C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D8610F16E;
	Fri, 31 Jul 2026 06:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+UnfM7G";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8346210EFB8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 15:36:16 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c12614b81c9so409340666b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785425775; x=1786030575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p3SOhHIxVhGF41c8QPWamnwAmuGY/uvO36Ylk3s7hbw=;
 b=H+UnfM7Gmd7uTPLIVQZF73t+9qbUl900+tb1fc7r1dbIqgCicslyXuBg37X20ZWm5a
 DnClRz90lZbeCDBSQf5H+VTuWFdKHPNBUrspxwGaexyv7whfrGW8EQUJNlFst7T2J9+D
 4nbnkFO8auyJ7ZqKrJQ8cybKtsQHGfKFa2ecFbY3+lxCeayHOTB41/2wopYoVKaCV8na
 42zoDoIKwio5J0VsPeg7kpIP9tISpLa4wG+t8qhZN+SOk2DaCMmtq9+pF2sW6RpvfHUs
 xyGWxmx1K8q2wfnD0k3xWG74/d/8NDM09bJ9eMeImfBcofvzzqsLoV8LEZfeJFYEJ3Cs
 k1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785425775; x=1786030575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p3SOhHIxVhGF41c8QPWamnwAmuGY/uvO36Ylk3s7hbw=;
 b=NuZXFazzGnUqrWaUap+LgXx7rfDY4HCFgEw0tS0F1ns4s36Fy9ozpUZaqza1QQdUYe
 ZJZYsRPCWTTrESMcQxz01sGW4iEO/j38kaSDJKTcI7qi0kfS6wy5MN4hjWtGDCgQWLGG
 ZJf7+xb4xWrPebJYwYeeSqeKNPdND6vE6OK7CesVPdmE23qFsjPb+2qDX3ALVCMkXtsd
 mkX3ky8MnUvUSki50F7jxrhfeSfqxZjpBnyx24+1n/t7yFlPT3CqGYXSNAa8fn8tQJGc
 Kp+XSQgMPlHU3PaiFTh/UUAVVCIiwMygkUCH4Z77+EcE3MBlPWLsZbPLp2/Qhl14ul3s
 otvA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr11u+UXty1Ms+PEu/7U3pAuU5cIzqvXSMzjaKDtd3noTjOw6gugTI7rqKgxi0U4piqij0xCKVh1OQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMwfc7bcmTxqfoIfN9Zie8nVljRsNoGCCivb1cu0hPfNC50xpi
 ffnXstpwqQleR0uE1wIXgb7oqy57UL07lEJzpmy663HXxqV7nYZ/hk1+
X-Gm-Gg: AR+sD10vbOf5NOCgIn4DaDHSK2QsdYPB5jPt7xf6Wj4Hk4lcPZFI06INcR/pZnIcVZ/
 esRVQMIeewmvswlX6PJ9ETtBwNEyMvqnLDMcrz2yD6yuyKndMwnInqcV9mz8aD6KwINSnKJ4pCx
 TNt6ff34yFKMI1GwYIxEwADaTqDC5mRH/TEi4+QApvHa9YM8mgL7v+Xv8JghhEBTzqQB3diZt1y
 dZ1sg2d16VIW+GDtLpS2/VhyJiI8xcxk0Rz7GUDeMywH+Adx65trmID9g+ErQ1mfmPGnyqzDpr+
 j+I0MkUnckS/+ux5thHoEbU1TuIp5zGwXQGab1g/KASLASBpgBxirru0B6DVPeSGcxNL3JCT7BK
 hb8UK6uQf0ZCcprPYzEN/Vcmue+VSs3kAo85/QK5LoiWYHQWlEEiHwDuQTG7mQZU/ScfgVTP5d0
 sry83EfST26pJ4T7WYCqFx9lFG3AeDxgdT8ij6QsiukZ+HMKIctT3Ytgzw/BmPb8TD733p7/Ioo
 W0CzRkwdlmEL7Pti5td2C383Cex3qRLjzL1WEtv+Ff75S8kmTGo
X-Received: by 2002:a17:907:d10:b0:c12:959a:1477 with SMTP id
 a640c23a62f3a-c1fa57076cemr160900866b.40.1785425759630; 
 Thu, 30 Jul 2026 08:35:59 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-ee66-8497-94b5-6e78.fixed6.kpn.net.
 [2a02:a463:a071:0:ee66:8497:94b5:6e78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8b762dasm84986366b.38.2026.07.30.08.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:35:59 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amdkfd: reject alloc_memory_of_gpu with wrapping
 va_addr/mmap_offset
Date: Thu, 30 Jul 2026 17:35:55 +0200
Message-ID: <20260730153555.15176-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:54:16 +0000
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

kfd_ioctl_alloc_memory_of_gpu() computes the SVM overlap-check range as
[va_addr, va_addr + size - 1] (and likewise for mmap_offset) and passes
it to interval_tree_iter_first() with no check that the addition can
overflow u64. With va_addr near U64_MAX, the end wraps below start,
interval_tree_iter_first() sees an inverted range and returns NULL, and
the overlap check is silently skipped. /dev/kfd is unprivileged, and
va_addr/size/mmap_offset are plain fields in the ioctl argument struct
supplied directly by the calling process, so this is reachable by any
local user with a single crafted ioctl call.

Reject the ioctl when either va_addr+size or mmap_offset+size overflows,
using check_add_overflow().

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 309510e23315..12954d65503c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1089,10 +1089,15 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	long err;
 	uint64_t offset = args->mmap_offset;
 	uint32_t flags = args->flags;
+	u64 end;
 
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (check_add_overflow(args->va_addr, args->size, &end) ||
+	    check_add_overflow(args->mmap_offset, args->size, &end))
+		return -EINVAL;
+
 	if (p->context_id != KFD_CONTEXT_ID_PRIMARY && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
 		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
 
-- 
2.43.0

