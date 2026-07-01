Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D05C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6FE10F1C5;
	Thu,  2 Jul 2026 07:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JJnpKdC1";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62BFC10E20F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 19:22:38 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6a1133217easo403336eaf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782933757; x=1783538557; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lebv/FMkf8vjSW8Zb2jP0WYanX61Om+cPKrISlBBrOw=;
 b=JJnpKdC1KHFNNbAgQivMIxs4lApK3TUMY5/ZTXifDxRzzvLY3B3Q9to3k5MkCo0ZFV
 uJbt5UWye94eRnfGRPETKcOwvvGedDQ3567o18Dsck1qKoql2yUMC2p/rxfo/VxWamZR
 C0UJ2kzSvnwB0k5m3fhqrXcdz0lpPuxc6bIS3aB3+MyKyls65LDazStrzdriUO+HC1M0
 vUIp4uge8S5cbnfuxc3Iq93QCBfUo7kaI614o/E+ygtoJQ1Xurx/sUjHfiRcaBXF7Dzs
 gSzX5BzP6x1CBW5Hyk/J7gr9DQ9fHkQPHDXAKxR7K/FktiUuh0FwJe1/3FBWnipL3YeF
 l09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782933757; x=1783538557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lebv/FMkf8vjSW8Zb2jP0WYanX61Om+cPKrISlBBrOw=;
 b=NCF4OxEb1tjnR1JiqzlhbfKfWhRMDD3eHkxzJt3fS1T1ieOLw5pdu4g1h0tteXyP8M
 KxbkyrDQEXJud/tKM/pzAA2U+ajl5yiZmd+smYr3CCg16gfOOSmECy/Jw6DxrtnsAxZz
 11QqrWIXWerOZ3+PACk0qRPuy0a/FTV9XlzEH7upOZY7o5iGKqLG6VpAwhpcs1njkwbx
 EXnpVX/T7n6SBk+fmWvxwY+QoEiFxcZSahsqfXARCLac2iR5SDqk21Fu08+irAaO2vEe
 5x6YOFNjqdnkaDBJs5xFm6NM1P0fNSxbyuca4GTpKDQK6E0gLgHKLGTArjwE9MNN2uvS
 TdSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3mZaTGZMfQ8hjz8Z3o9buRB71zCJfplOhaZb/0qsEWBjICs8pTrUv8LqrD0JH0N1f9UIDAf2T6ws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykbMBAKN1a7i9we9fKCspyj/B2vH4Rtmy3Nww1QRErSf0RtPNt
 KwcKdmtVJnkw+jBPFKbDSL5yTYO1EAbQunGKYUbRxep4iEWfXJNPjvqc
X-Gm-Gg: AfdE7cl7fTHYo6j8/328g/y183vJ+TgmyH6efEedl/oRoEgmnVMejhSHBBwCa0BKO+L
 xPQtbEHRA4jNgQomjTlie9sMiGYxJ2sBBp4wehgfGp+xmgr2Y+NgyQfJ0WovVibBUUyzo5rBQRv
 Fl5hhpx/ipCmO0fmQEGkILq4+ASe44OpBdMUjfCQJbPXZGvPUAgPEuzgJfsQ89BVf80oWp3LDaA
 S9V5KMyDNYc+pcqtuHFvGJe5duUiJPnWo48zdr1QbjX0EFvwCjFroYsEiGX7sO4p67+UgBC1rM3
 KKwdt0eZTMkEG82gGNorxSaDxdpST/A6HWhPo/IJhaqxbwrsU2DZRDfKg6gKAFTMgXqc64znTrx
 E/5+NdeUUhnMhUw5Z263LoeJrDoqbP5gnaJMW89nI6eio8oUQT1np6kBt5BYTJMEQWr76xbZ6x9
 oDsHWDsjRT
X-Received: by 2002:a05:6820:4d06:b0:6a1:50f0:cccd with SMTP id
 006d021491bc7-6a309cda3dcmr1508412eaf.66.1782933757266; 
 Wed, 01 Jul 2026 12:22:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a30ff8e08asm681765eaf.2.2026.07.01.12.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:22:36 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 01 Jul 2026 12:22:25 -0700
Subject: [PATCH net-next v4 2/3] selftests/net: ncdevmem: add -b option to
 set rx-buf-size on bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-tcpdm-large-niovs-v4-2-ca4654f37570@meta.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
In-Reply-To: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add -b <bytes> to request a non-default niov size via
NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE,
udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
hugepage produces one naturally-aligned sg entry.

Add CONFIG_HUGETLBFS=y to drivers/net/hw/config so the new path is
reachable in the CI kernels built for these tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index d96e8a3b5a65..a16e55af51ee 100644
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
+static uint32_t rx_buf_size;
 
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
+	if (rx_buf_size > getpagesize())
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
+	if (rx_buf_size)
+		netdev_bind_rx_req_set_rx_buf_size(req, rx_buf_size);
 
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
+				pr_err("invalid rx_buf_size: %s", optarg);
+				return 1;
+			}
+			rx_buf_size = val;
+			break;
+		}
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.53.0-Meta

