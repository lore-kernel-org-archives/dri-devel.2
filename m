Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A770C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A596910E178;
	Fri, 31 Jul 2026 00:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbFE7WS9";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB19510E176
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 00:32:52 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so2719475ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785457972; x=1786062772; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oQn73DnaYnP2eIm20VaPqmI6rB049cGwP1GfXwnXLN0=;
 b=jbFE7WS9cinZ6XXhZ+coKuAare39t9WOaIilLaMhhbnkGohP1jKUApdhLTPBVclZ6/
 4P97hC6ezIck8dCtemJz/UTOrPSw/q7xEhQ3uxU/48nFOV8ooMmMXEhK3aiK90p62YFt
 3SBiYM+pXa+tcu/PeaZwHyLm4aDRRU2TujAETbv8ajFCiaOmX99kVnOMFg5aDbFTBUJx
 MH/hB2EBnfUv/1fM5ntv246RClS72x3OJSxOJRdJXboS4DTTyfKbSG+6D03cJ9eVbkLy
 kEi9T07XHkOfJptchxWlzZOavqkiS74lqMVHt3vEyyITGypErtajbUxuYUzfz0UhgTYD
 VoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785457972; x=1786062772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oQn73DnaYnP2eIm20VaPqmI6rB049cGwP1GfXwnXLN0=;
 b=XqzIR2GTLtBd2b1CvUXKOtxJ9cJelkAa93lL23jZZZO0vfUpkd9H8xB3tOJ1CC2x23
 S3DXoEulhU+U5Sci2BEu0ghn2q+bPVrggfNmHC+ayL964G4JDDmTnktfXDSH3tlDydBp
 9p6WIe87HnHyeQmsqIbvccvyQ61y+rZ6DDWECun7yUHmWhTNwmOJ4vemL6bY8uXXUpXT
 P4xkzXaiqHlmlp/avkfnKFJWLsUGc9IF/j4ZTFlgB+ZQBAwJLIqYxo335w0H2tQnZH5T
 x+M2s5Qfct91AuhEIReDThpIpMhH3kMecGfCl5FTXmBSEDcczJdECfzkTQacsH7hJ65D
 E+WQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBChKzwmo4JyU56UAmmVqWxGVizMB8OnvAlHSS1AHVdXyX9D0UQu8f2bChmnu25YBHZyMZH46VaJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXG0N0mksOvYeArr+nlb52efUL3CEANSOJZ3epNbaaKOnmmK/l
 cZ4PI5tN1F1LtHx/K6e0pJMf/H72nsoLYFPOvQk3f+jecKuHm9OuBVZB
X-Gm-Gg: AR+sD1228/4pV6Nl96Ft7VsO5Sw/0TijbmmWnr6MQLEPvI0oqp9Gp6ByPiC8do6hsMP
 2I124aINJLCr0jNcXlQc3TQB/FfUM7OxKvaWGTgyvoA6aNh7j1M9khMA9KDY2OPsYc7D/FpLFDG
 EGDIwI7VxM+x+H/06dM+H9SSP1Uf+tasOX5Z55LLdFtV735FGTHyDF5Nkf4t97/kl6g8c7U90be
 OOHxZrjD9kCp3Lk/veJNQGJSVWI6YaK5bPozzDpeQZC6+kDAD6XCfeB5FgG/8bMjNTJct6zdtVY
 IWYtRAiQq425FB3++ogyyy7chbRhZsPFCpLWJZGPLCelksfNCL4C3v7bEzt1F/sYoYRw/CC3K/M
 1YY8425aNn5ZIJRffPs8wspNddlZQkJYthGXuTaSeDFkwWZ1dCRKisA5IyVqlAgeoWc4M7ah6UI
 3sY3b294ikvgUA+jUKB/S8kOV/Huyv0wNSmXdmUX6abk5LJ2LAD35nVdkKyQ==
X-Received: by 2002:a17:903:2406:b0:2cc:db7a:251 with SMTP id
 d9443c01a7336-2d03e040e56mr19629885ad.2.1785457972277; 
 Thu, 30 Jul 2026 17:32:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bc6d87sm32755215ad.38.2026.07.30.17.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:32:50 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 30 Jul 2026 17:32:11 -0700
Subject: [PATCH net-next v7 2/3] selftests/net: ncdevmem: add -b option to
 set rx-page-size on bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-tcpdm-large-niovs-v7-2-033d580a619d@meta.com>
References: <20260730-tcpdm-large-niovs-v7-0-033d580a619d@meta.com>
In-Reply-To: <20260730-tcpdm-large-niovs-v7-0-033d580a619d@meta.com>
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

