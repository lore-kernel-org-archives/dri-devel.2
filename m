Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318CFC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D64910E63E;
	Fri, 24 Jul 2026 21:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mju7a23F";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E451710E471
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:21:48 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84847482584so696452b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784928108; x=1785532908; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bwbrRJxFtRMglJHsKStZHneRkjfPxcqBpbuMqDOPwOI=;
 b=Mju7a23F7nBHjOb8ZAdfLI0g6agbrkJ5ETqN06zXQ0+J3xMZmR31pQ1KcEk50pcOHi
 1rT+FhC3f2cnAL8qZjsrTfynUb3t8jL6zawxT6Mh0eyYdu2aHOivJTsoLS6Rtr4IcMuG
 JK2XtGydZLpLXUQjbghl3eJlEUIe8VlWiSY7RD/nq/aYF2wfuPZxJ37xrcoAGYhPBiT9
 /PFPeU2rM8QNvJfBIi9Lr5kI22XYNlw/VQb+dn14K8P9it78pCIhyg96mT2feFdgoA73
 D+OvgSP4ALt9np7JhvZ3rNeXFrW2RR2C2MeQUe4bTH8ndtxn/JQYhAMCkzv0D4SVIoXB
 F7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784928108; x=1785532908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bwbrRJxFtRMglJHsKStZHneRkjfPxcqBpbuMqDOPwOI=;
 b=MGYRrqDF6WmAsSzH5sY0CX4WUtTWh8oaWl6QxfB/rw+rH2Tln6/KIQFEFO/Bxcz5bj
 Cd9zv1Z52+7O7aoZNSDkhrTy1mReXhI5hnEpVoFanBOHlFvaB9YdcSlENBDD2vyPEnv8
 dhnz6jzZfNbZGKCcmSzj/lIZFMWFkHCbXDbJqeuS+NY3s2QHSijwxD9PIf4Gvr7aSfVB
 QtiONhcQ1e/1S+/Gpd+/I6AwC5HKm8yLlhuSB3EiqlRMYb1jNFASiJc3JSYEw7RqVJaO
 fNeZp/baUXSf3aUJaUWuu4n3rYKye2IyYQ6QOk4sAR1dwz9ycqrSR2P/BYXA9w1qMW8e
 nlzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RouIucLtCdxBUswwGcMOgiNtSL4rVSig8MmqZ5tM5/SXSNgW3S4YVeggBTHDbT4TWe4kGbZPbz+LFI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2KyfznfBIA9S/iAFZxPgmcF/indgwsss7AIUCJInfmYR+zG0+
 mcPV6byMpFxmO7F+1WXorJsXnZzt+UZx3y2QUYMSl7a1RXhdGa13wT47
X-Gm-Gg: AR+sD12xdrw7bcb/jrC15cEoRuRz0Hz5QlsYzaoQ7qWTwKvmg3T1/JCoMwKP8S0hnwL
 rFM6tiHtur0Lzgzvgo+GT0IV5mMhs5/dNkjLiFxPXN0e4D3roks8zQOPPdoeESLRHxxV1j3Szrb
 1hT8Fddir67q75KiZlGlvWDAkSUFCpssdfDE2B8dGZxJ7yEH3J6aINiUVKipKvGA5tOeFPQFA1v
 j1EGGyc/JO8KVjbVPuHorxTQOFwi3dvfKr6yDILO79Odw21i8IrzPGZm967F0xmpGbgoAsipZwx
 UXHn1O2VDlcLFJQlclR8eWQ/B8hC+ZPi/ienWFaR5dUePFhBp4FZgkHZui9k7fHZlfVMUzhyPFE
 M8aAcmfUXV8vLY4RTwVb1JNHluxwCn6j36ikERtCJRwFh2nukov77lbZ3qP5R8eKj5wbZ1fKj
X-Received: by 2002:a05:6a00:8007:b0:848:40f5:ff5e with SMTP id
 d2e1a72fcca58-84e4e4283b9mr1491520b3a.37.1784928108422; 
 Fri, 24 Jul 2026 14:21:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5341d68asm411468b3a.46.2026.07.24.14.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:21:46 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 24 Jul 2026 14:21:16 -0700
Subject: [PATCH net-next v6 2/3] selftests/net: ncdevmem: add -b option to
 set rx-page-size on bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-tcpdm-large-niovs-v6-2-7975f62cdfbb@meta.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
In-Reply-To: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Joe Damato <joe@dama.to>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add -b <bytes> to request a non-default niov size via
NETDEV_A_DMABUF_RX_PAGE_SIZE. When the value exceeds PAGE_SIZE,
udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
hugepage produces one naturally-aligned sg entry.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index d96e8a3b5a65..ffe8eb05fac0 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -40,6 +40,7 @@
 
 #include <linux/uio.h>
 #include <stdarg.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -61,6 +62,7 @@
 #include <sys/time.h>
 
 #include <linux/memfd.h>
+#include <sys/param.h>
 #include <linux/dma-buf.h>
 #include <linux/errqueue.h>
 #include <linux/udmabuf.h>
@@ -79,6 +81,7 @@
 #define PAGE_SHIFT 12
 #define TEST_PREFIX "ncdevmem"
 #define NUM_PAGES 16000
+#define MB(x) ((x) << 20)
 
 #ifndef MSG_SOCK_DEVMEM
 #define MSG_SOCK_DEVMEM 0x2000000
@@ -100,6 +103,7 @@ static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
 static bool fail_on_linear;
+static uint32_t rx_page_size;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -142,6 +146,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 {
 	struct udmabuf_create create;
 	struct memory_buffer *ctx;
+	unsigned int memfd_flags;
 	int ret;
 
 	ctx = malloc(sizeof(*ctx));
@@ -156,9 +161,14 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 		goto err_free_ctx;
 	}
 
-	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	memfd_flags = MFD_ALLOW_SEALING;
+	if (rx_page_size > getpagesize())
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
+
+	ctx->memfd = memfd_create("udmabuf-test", memfd_flags);
 	if (ctx->memfd < 0) {
-		pr_err("[skip,no-memfd]");
+		pr_err("[skip,no-memfd%s]",
+		       (memfd_flags & MFD_HUGETLB) ? " (need hugepages)" : "");
 		goto err_close_dev;
 	}
 
@@ -168,6 +178,11 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 		goto err_close_memfd;
 	}
 
+	if (memfd_flags & MFD_HUGETLB) {
+		size = roundup(size, MB(2));
+		ctx->size = size;
+	}
+
 	ret = ftruncate(ctx->memfd, size);
 	if (ret == -1) {
 		pr_err("[FAIL,memfd-truncate]");
@@ -699,6 +714,8 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	netdev_bind_rx_req_set_ifindex(req, ifindex);
 	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
 	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+	if (rx_page_size)
+		netdev_bind_rx_req_set_rx_page_size(req, rx_page_size);
 
 	rsp = netdev_bind_rx(*ys, req);
 	if (!rsp) {
@@ -1411,7 +1428,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:n")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:nb:")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
@@ -1446,6 +1463,19 @@ int main(int argc, char *argv[])
 		case 'n':
 			skip_config = 1;
 			break;
+		case 'b': {
+			unsigned long val;
+
+			errno = 0;
+			val = strtoul(optarg, NULL, 0);
+			if ((val == ULONG_MAX && errno == ERANGE) ||
+			    val > UINT32_MAX) {
+				pr_err("invalid rx_page_size: %s", optarg);
+				return 1;
+			}
+			rx_page_size = val;
+			break;
+		}
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.53.0-Meta

