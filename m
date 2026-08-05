Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165DFC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DF610F005;
	Wed,  5 Aug 2026 20:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nCNX5X4P";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E728610EFFE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:43:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so221976a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785962588; x=1786567388; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oQn73DnaYnP2eIm20VaPqmI6rB049cGwP1GfXwnXLN0=;
 b=nCNX5X4POuO2yH1yJf1YavPLMYuGl9eRnENG1bBa9sWFVcqaqv378mQ6DYnMHEee+z
 23wBoZ8qSEbA8Ebg2XDPbFUiLNB2ws3bxYWDD5Jo+wrp3ytY+75AHYn7X/yFWk9OM2RS
 hX46nC6F81kVj+Sv8YXCDBGr49e5xN+yR+WoKlojM5JyY77rvyrFd66UK3jpqSjCushG
 v6rd2E5hWdEhywtk1zn/C0y+adcZCIyhwo+TD9pUp9yS3otJujdZalNZHE7o40SFt3jF
 s1Fl3RhgWDbfJT+Q0W8zyfAzh87UVeCNdTGlMMYN3AtgXMEcZ1XbThc/jrM7IEINAd5H
 tmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785962588; x=1786567388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oQn73DnaYnP2eIm20VaPqmI6rB049cGwP1GfXwnXLN0=;
 b=Pxe0f0+2or1cKLhNSZuCIZ5o/U/9lCuMPDwE/nQLno0lPnBLD/gHrPXhybC6FHFjEY
 4xvzsDX4i95teZ3m1T2b0680Jh6GC0EhPqlwhgqqkbeNaTqhwxrLI4CTQrbo+P+od0zU
 gs3ht+cXVs+S+iSNTa4M747gUHGJkA3vx/dFgJIBFKuuU2IpyCQ7+yFIjYtPKB7qBW04
 K1qJ3qnwFJgUSKvGR01vsV7AOjzJfh0hpf9Gyeso67nQ0XZlyZ6UKhaMhfMiBVVGwh9e
 O2fWlAyyL8SB3jxcvEpwPYDUZsc8GsX9eC6+IATvuDJTnlUIr9JbZbAz1FSp/tn+wZl2
 gBNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1Xz2veGUCZ67PEMALokQ3kxtYwliDoyDyv+9pcQl6Zy5wO44XcoBSdbf6CsfIquQkv5bUp1bbj6U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZ9AqXICHapayzZnIkiQvtr3oyYq6WClQuEysAgQclPDhzwIQP
 dgmpwqqt5ce818go8MMH9r+WzBd5MgjhxeFmg9/vPtupLhVsSbKYWHku
X-Gm-Gg: AR+sD13dkL/txu73g3yZ7BeWDgBWBkoD71QVzj7dAlqdA1pVsy+BnBuE1v469NuF31W
 TXS6TyyDGNZ+HZPFY5bJc/GF5PqZ/M3eVmhl04JdZXmuLpQPulMiwBQdRTVBm77zDBBBlH8mcu5
 8W+XgTSX+pE+h92okIxWZCmykRxKpDC7oA7cROiZmuuvcuxa4GkScIkULz7aiPea2ACmgcmL9xT
 0ZeDJyouxTYDmiZe0XjoFJPnZNOdbWb9V2cHuzSn/7F0GzPanYidDJw08VmA74S4jEBGo/k1lTQ
 NCcbubA266+7JhiNX2sdN17DzAfACK0Iql91UolFfko5kIIyKtINTM0bV99/3KjKHBXNQ2Teo27
 WekqQpJFaIde2FaNTGE3b+/76TzMP5ukZoFar+CE6XBWFzKlv7384CQgUEVCTcTobVexaaU3fsh
 ayyqsF1awe/W6T00PV9T+FJPR4IyKiLOGERC85UA92b1ozkGXfQl7fSllrKL//j8HoC7y6ipXdl
 kjeKQ==
X-Received: by 2002:a17:90b:2e52:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-390839951bamr925253a91.2.1785962588343; 
 Wed, 05 Aug 2026 13:43:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085dbf82csm162821a91.1.2026.08.05.13.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 13:43:07 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Aug 2026 13:42:44 -0700
Subject: [PATCH net-next v8 2/3] selftests/net: ncdevmem: add -b option to
 set rx-page-size on bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tcpdm-large-niovs-v8-2-3e0225e2808c@meta.com>
References: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
In-Reply-To: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index ffe1d5c1fa4e..918e3b51f3b8 100644
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

