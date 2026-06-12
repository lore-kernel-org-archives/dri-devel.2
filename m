Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE4CD98DC
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BB010E0CE;
	Sun, 14 Jun 2026 15:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTZY8FY+";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F9010EAA1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:28:15 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so894205b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781281695; x=1781886495; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k3hx3iEvB3FQYubpdUTwVhz53gJdWPirEdfCXBfHIMU=;
 b=gTZY8FY++6vWIf4FFlqi+q7F75ZZcf2rzn3cQ8laCLTwj45z7xI3wAt3OUbAO8U99F
 wp9ygBMhYtYk5tYGV/aFbpJ51wxuJ0+JCXBv1AgjjrZIpR2m0Gyi+LPMxdXM45IU0aVG
 /0Hh0K3as8HuajZTcizmcYMJ81V4fZFjetb1ZYJpPCdJjQ4S6+gNutlgtMrGcrVpG7s9
 ZK4T5VIE4+MOpeuupMWkOKDF4iX3/HDbbOum0GbUzuCOYdYc2IJcbSt8sqCXUJLdJMcr
 xOuesJzJ5NW+9ziJEih5/YUUSggYdAwCoscrMu23hlDPpHd6npchpmEtUVEqxU/CPQIL
 gXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781281695; x=1781886495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k3hx3iEvB3FQYubpdUTwVhz53gJdWPirEdfCXBfHIMU=;
 b=pw4P/JcNOXUvsZ2JbKCM3hg1hvJ2OpGTuv+6cnTy5lygbR0lyeBQzspH9lqbCKKn7K
 z9MnfUlfdXNAnhIbBCoFkG7ql6k+smtTiQkwP90LiOCHYcpzu60tgmyGYg3Ov/7mcSIn
 41UkE7N6z9SnSbSASIaFJJnhIOOHki276A5fmEI2QqZHJRd8/m9/CpQzfUFCJ6jJhVVq
 6O5XwbyzYW763NTkdyi5xgqCBm7JmMwtZol5EAA9eBfsaXgbLLLWnbgT9hG3NwjrhtAE
 jlYjhpJD8SwhK4ww5DTEBVHW05kMFsk4rN/9AADIjxSSzhbAlEP8GAhp51ItjrfvP3PJ
 HOAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RbQg0pUEkKDRzKjU9uwvtCLW3sQowMoYOy/0mbJ3MSOPR2deprEPBr7Z5Xpif5Z3sIt2i0TCovDo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLT4JrGtbeUOvY6ktHoU0DPxebrBFAbHq1FXwdfJx983/jhqfu
 u0WYMK0mbi7WNvpnRXheyTrTWoqeY41NP4W7uvQeao4aGHg6JGm71qj0
X-Gm-Gg: Acq92OFn/Vy4AhhrDLsXudm1J+0oEW7GOEmamYYmynFLjiMC/VKnYD4YQZ77HAMQ4sB
 0vjctFKjo99W0Nw6lYcUZakaAi3HqIxNDOLfHoFKEgAGdMW6F+hbRh+7lwigm5Rxnt/Vq+ukM5I
 fzJgLr+hVcr1VcIZO23+s/Uxdqd6PHOe0D+f7BrGgTf+XK9y6eID4UIrZFMPaijCR6OYp8Z6Cgh
 BlVYtKYehoTYH9xUHB0oYDmEyk7fBDb+ofb5h+1sjTGAjdMaY6/I85wpOTQjYYwnTXQnD7+4sn3
 Zi12H9qIwZbK3cPEWfvg6cMwWwk7MQlsKyqtfGQHJZnvNiWfgcwS0vJrdzvOuIf5nFgnPuktjcv
 05drMBWuNhSMqY/Y436e+ZsFrnre1HRqs4RRHSNZrCrZT9WJAlxoYXgo7jJ81Kl75hdRSSLa9aE
 qaWTPoAiz8GMarACHheI8=
X-Received: by 2002:a05:6a00:a220:b0:842:48ae:1d6c with SMTP id
 d2e1a72fcca58-844e1a28ea1mr391873b3a.24.1781281694728; 
 Fri, 12 Jun 2026 09:28:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b03fd0bsm2690221b3a.50.2026.06.12.09.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:28:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 12 Jun 2026 09:25:59 -0700
Subject: [PATCH net-next v3 3/4] selftests/net: ncdevmem: add -b option to
 set rx-buf-size on bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-tcpdm-large-niovs-v3-3-a3b693e76fcb@meta.com>
References: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
In-Reply-To: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
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
 dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

Reject values > 2 MB up front: MFD_HUGETLB + udmabuf can only guarantee
2 MB per sg entry (one hugepage), so a larger rx_buf_size would fail the
per-sg length/alignment check.

Add CONFIG_HUGETLBFS=y to drivers/net/hw/config so the new path is
reachable in the CI kernels built for these tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/config     |  1 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index cd20024218cd..ed8642b68094 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -3,6 +3,7 @@ CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
+CONFIG_HUGETLBFS=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_ESP_OFFLOAD=y
 CONFIG_INET_ESP=y
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

