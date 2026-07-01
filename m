Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCA9C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE0B10F1E1;
	Thu,  2 Jul 2026 07:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KPHPIXxt";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A8A10E3D0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:22:13 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c88973b6965so1049243a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782926533; x=1783531333; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ti3ZCjdmjhvLeQB5pNokTmQHpasACJ+pmTKes+VtiM=;
 b=KPHPIXxtD0sqIA6YqtIzrpjk4M/OczprYQgJvS/IMbDVKL4Iw4L6jYjlnWF7Ag05bJ
 l/2Umkv/s0Obj9Evq2RVjhzeLpixaxWPOIz4NnZR2eMzEYnJw4npI1crY11twUrKLluh
 mp2K95V8K8G28DWi+23EQUfbRcXpje0fsOaUIQtrzAqlf2pzyzvXyeAhQOn/94lk6OLh
 7CA5Y8fCpz1rTpVnXtvq/KSrsPcCS03SpyTD5aLQ+HGTxaW5jkv7GmVU7bjCucFh7VxE
 4+cMonpJGNmda6T1yjPXDEqCzleGoJZZil2NGViXmHvqcgjaXiFBuEKNZYE/B4WzdQkM
 knxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926533; x=1783531333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Ti3ZCjdmjhvLeQB5pNokTmQHpasACJ+pmTKes+VtiM=;
 b=tFxC78UXIKzD8a/DERdJnXTgFyB8RQSMWWdsVeS7Fml4AOM0toN0TMGAjWjshKEC+f
 W2HMysLv0TsVItI0IxoF6icXqy7JQzn+9wDODxn1vAx1Jl/mqGuQoHO2wscOV0/CPO02
 sHgcXCe7+d1xw6uj5cSCjHCJxVGH8Rocb19lehHxeXb5ld4WhpQm4mmMZNPtKhc/PkTJ
 BXUPocvxfr7VYwCP08zQoNiLpM0rFFFLQUUMjuEpJxITctloXRSYQt7n1ct/D2IRHpgw
 3NTHbqinEIyaQyhU9sk4YRPMfYU4Nu40pcrvJn3DPRY4owYE4KxVrm400IiWHTMu2Ymz
 tjIg==
X-Gm-Message-State: AOJu0YwUbp2W1fcoax0CmcP8U3peH0D1Lgw0W4O1TsuCBi5qr28dXtOx
 w0jdf89ugVnJdUEaH5nVbfdAFTOie8BAUvJBHSTRKioRE1b5oOd5c3rTUZqdegOjlW0=
X-Gm-Gg: AfdE7clOFcrYwwhHQ4kOP9fijQxd2HVCPqlDuMduZOmB88BSso/qGx9cBmXv+y0XtD6
 3cf9+u5riH8V5LJr3j/zj4aDyO5NvtazffN7lNe8TlHTvcThDmSeCpIJYZ9gg55ShIg3bUIg5ID
 mV2RocDWmRHBdoRS6mnRTRy5v58960HzgGnaX9++zTSXBtzRd4xL5/3mR5J6/HoRU4NMlRiEP4Q
 Z35A2dJlr8BUyudd5NR76XfT9XRtnlivRdoCcMnwhBRlhqRsrtkvnyVtSPdqFbTysyyStftk+q1
 ojcYLOfEEWorPt5rWK3aNj6oDIFrlA+mLLJUujCCS0FsMMcE1X4EHAOeAiOgeic9Ui2J0N2FM7s
 v3NYenMsXKBZC18eV/InijYiMd6tGOPkO9Wgd8tFg7YeR4OFHRoYeM3TD1SUvARIlnG3pVR2iuJ
 nRWz5ZqLTzlQMeTOlSzwML
X-Received: by 2002:a05:6a21:4596:b0:3bf:990d:3fc7 with SMTP id
 adf61e73a8af0-3bfd2849358mr6505679637.20.1782926533285; 
 Wed, 01 Jul 2026 10:22:13 -0700 (PDT)
Received: from RodriguezRyzen.. ([181.229.23.179])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3205993sm23033963eec.24.2026.07.01.10.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:22:12 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: kraxel@redhat.com,
	vivek.kasireddy@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kselftest@lists.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 1/1] udmabuf: reject unknown UDMABUF_CREATE flags
Date: Wed,  1 Jul 2026 14:21:59 -0300
Message-ID: <20260701172159.270872-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701172159.270872-1-ivanrwcm25@gmail.com>
References: <20260701172159.270872-1-ivanrwcm25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

UDMABUF_CREATE and UDMABUF_CREATE_LIST only define
UDMABUF_FLAGS_CLOEXEC. Unknown flag bits were silently masked
before returning a dmabuf fd, so userspace could not detect
unsupported flags. Reject them with -EINVAL, consistent with
dma-heap flag validation.

Document the flag semantics in udmabuf.h and add a selftest.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/dma-buf/udmabuf.c                         |  3 +++
 include/uapi/linux/udmabuf.h                      | 13 +++++++++++++
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 14 +++++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index bced421c0d65..fb36c0d9ffe7 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -358,6 +358,9 @@ static long udmabuf_create(struct miscdevice *device,
 	long ret = -EINVAL;
 	u32 i, flags;
 
+	if (head->flags & ~UDMABUF_FLAGS_CLOEXEC)
+		return -EINVAL;
+
 	ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);
 	if (!ubuf)
 		return -ENOMEM;
diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
index 46b6532ed855..e267856dd510 100644
--- a/include/uapi/linux/udmabuf.h
+++ b/include/uapi/linux/udmabuf.h
@@ -7,6 +7,13 @@
 
 #define UDMABUF_FLAGS_CLOEXEC	0x01
 
+/**
+ * struct udmabuf_create - parameters for %UDMABUF_CREATE
+ * @memfd: memfd containing the memory to export
+ * @flags: %UDMABUF_FLAGS_CLOEXEC only; unknown bits are rejected
+ * @offset: byte offset into @memfd (page aligned)
+ * @size: number of bytes to export (page aligned, non-zero)
+ */
 struct udmabuf_create {
 	__u32 memfd;
 	__u32 flags;
@@ -21,6 +28,12 @@ struct udmabuf_create_item {
 	__u64 size;
 };
 
+/**
+ * struct udmabuf_create_list - parameters for %UDMABUF_CREATE_LIST
+ * @flags: %UDMABUF_FLAGS_CLOEXEC only; unknown bits are rejected
+ * @count: number of entries in @list (non-zero, capped by driver)
+ * @list: flexible array of memfd regions to combine
+ */
 struct udmabuf_create_list {
 	__u32 flags;
 	__u32 count;
diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index d78aec662586..95c781855404 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -138,7 +138,7 @@ int main(int argc, char *argv[])
 	void *addr1, *addr2;
 
 	ksft_print_header();
-	ksft_set_plan(7);
+	ksft_set_plan(8);
 
 	devfd = open("/dev/udmabuf", O_RDWR);
 	if (devfd < 0) {
@@ -189,6 +189,18 @@ int main(int argc, char *argv[])
 	else
 		ksft_test_result_pass("%s: [PASS,test-2]\n", TEST_PREFIX);
 
+	/* should fail (unknown flags) */
+	create.memfd  = memfd;
+	create.offset = 0;
+	create.size   = size;
+	create.flags  = UDMABUF_FLAGS_CLOEXEC | 0x2;
+	buf = ioctl(devfd, UDMABUF_CREATE, &create);
+	if (buf >= 0)
+		ksft_test_result_fail("%s: [FAIL,test-unknown-flags]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS,test-unknown-flags]\n", TEST_PREFIX);
+	create.flags = 0;
+
 	/* should fail (not memfd) */
 	create.memfd  = 0; /* stdin */
 	create.offset = 0;
-- 
2.43.0

