Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAAECD6E71
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D7011270E;
	Thu,  4 Jun 2026 07:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXvE7EPP";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31831124F6
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 00:43:09 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c858dc05ee3so96556a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780533789; x=1781138589; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xPElRdLQqSlIpSLm9S4Z23ki+7V6eQuSW40WuLFvr5g=;
 b=gXvE7EPPAd/Ue0ufS0jb6aNjqowgmMGUrMXnoXRmAeJDzUzLymUsIthsKkVZdb4hq9
 wrPEG4kO87xRYTptEC4MazP0ItU9CGCMBhLP/ohZss/mnNy52A1thHtThxlnfg5CDny8
 ISy9rLi+ts6XrDgQVL4ai+ZMHjlIwVTJgzutCE/jsFz3meY3VQEe0Tn/0mjdMXWSVuIQ
 PrsZHtv47gGlQFWiXwX2dmkvZ8+VhGeTMLEGNgv8ZX9YKJiyGkxy1WrrLfoYgFgtzmia
 B0W4FgtMwzzQAH6qDuAR1dml9n1Q9BDm9CK679nSQLp3sUTQSZmlTnYiw6XO7hZA/kOD
 X38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780533789; x=1781138589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xPElRdLQqSlIpSLm9S4Z23ki+7V6eQuSW40WuLFvr5g=;
 b=TBdbVipLiC+sk72TWt7dYA+Yk4/Tap1g/lvi6ELps8XcYtZoOsaaHu+TBsqZLvYMPW
 PiG2+vKzrOSjL0TkLrvprv7fkqHWOiVTD5f2ZGnXyksRE5rVMQs5OhYN4iwuv1J+OvnB
 60XlzBEEaDyOePZduWUUG2bG+uGDD2PCkhtx/7MyVO9j60n51zAJfySsh+sg1wX/oqhg
 L2nKkKeP3ZX1KyVyQP6TM/X20Fvc93jGSmILSJvE2EuAaEEGqtBAhDpvXM8WXR9UrrNg
 AcCPq1oZ8wybX8thWZZhcBXSxY6ArvZ43+lwKgl+/vYqu3uC0KelWjGOa3po0plb+QNb
 7tqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ89wQ9E4CAQYLTyhcix3yby7mGnh3Pv7ek5jAY3sRLxxP5aZ4UJzyKSBl4LUr4Ozx0I4EZwVkvb6Zc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcK5q/uqnacL5Bn8Du9YstRNcCpEM0gVoQ6GdCdpPWNyaA4uEz
 TpGYGxaBRMwtkY+v1006jLJB7NIOh947vNVKvNNxyBUzJaSpCN3b51uP
X-Gm-Gg: Acq92OEFxLDC0xB0tv9tk3wbc8Kp81qWvvZ911ORKgzhImneY2hMh5OKxa3+vo2ZVCQ
 lgEExGW9BoacpUT9h3sQ1OXQX0hFTBdd94/CgxqHVnviEMuNvsOThPzH1ewodttpIl7YFYWVGUE
 Wae3iWPh4GVMCd7ijWvrgSpLdwEoCyRSDZ4U22Ci21WzJ+Kjr9oRjXdfTma6Dms8qf8LXWh9m44
 D3URygBv7ALEkCUPMjFPLZ1xXl6S3hJsWM2YEzDc10WxFc7d7fO6u7HNq8Yk/uLbeUs30a92cNw
 kgh2eiyaOMWDIobLKtqDiHYaHdnZhRTydJL6eMVjXnEROP6i3VGC2KppQTGDpuoXZXIqywjcfta
 3T4/EYt3hk4dWtT6X85iH+AiHJ7i2kAa5sFpK1VpMjzG/WIvShzA/oEYmvxq4ioM+wD6zUS+8a9
 rFPlck/fivEEIPrAtUZ0mHdLWt6PTbWQ==
X-Received: by 2002:a05:6300:67ca:b0:39f:3ca8:a331 with SMTP id
 adf61e73a8af0-3b4974cc6d4mr6579788637.16.1780533789092; 
 Wed, 03 Jun 2026 17:43:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df04a0e9sm2879012a12.13.2026.06.03.17.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:43:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 03 Jun 2026 17:43:00 -0700
Subject: [PATCH net-next 3/4] selftests/net: ncdevmem: add -b option to set
 rx-buf-size on bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-tcpdm-large-niovs-v1-3-f37a4ac6726c@meta.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
In-Reply-To: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
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
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:30 +0000
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
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 49 +++++++++++++++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index b9f406dd7282..388721bee553 100644
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
index d96e8a3b5a65..325c128191e2 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -61,6 +61,7 @@
 #include <sys/time.h>
 
 #include <linux/memfd.h>
+#include <sys/param.h>
 #include <linux/dma-buf.h>
 #include <linux/errqueue.h>
 #include <linux/udmabuf.h>
@@ -79,6 +80,7 @@
 #define PAGE_SHIFT 12
 #define TEST_PREFIX "ncdevmem"
 #define NUM_PAGES 16000
+#define MB(x) ((x) << 20)
 
 #ifndef MSG_SOCK_DEVMEM
 #define MSG_SOCK_DEVMEM 0x2000000
@@ -100,6 +102,7 @@ static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
 static bool fail_on_linear;
+static uint32_t rx_buf_size;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -142,6 +145,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 {
 	struct udmabuf_create create;
 	struct memory_buffer *ctx;
+	unsigned int memfd_flags;
 	int ret;
 
 	ctx = malloc(sizeof(*ctx));
@@ -156,9 +160,14 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 		goto err_free_ctx;
 	}
 
-	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	memfd_flags = MFD_ALLOW_SEALING;
+	if (rx_buf_size > (uint32_t)getpagesize())
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
+
+	ctx->memfd = memfd_create("udmabuf-test", memfd_flags);
 	if (ctx->memfd < 0) {
-		pr_err("[skip,no-memfd]");
+		pr_err("[skip,no-memfd%s]",
+		       (memfd_flags & MFD_HUGETLB) ? " (need hugepages)" : "");
 		goto err_close_dev;
 	}
 
@@ -168,6 +177,11 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
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
@@ -699,6 +713,8 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	netdev_bind_rx_req_set_ifindex(req, ifindex);
 	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
 	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+	if (rx_buf_size)
+		netdev_bind_rx_req_set_rx_buf_size(req, rx_buf_size);
 
 	rsp = netdev_bind_rx(*ys, req);
 	if (!rsp) {
@@ -1411,7 +1427,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:n")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:nb:")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
@@ -1446,6 +1462,33 @@ int main(int argc, char *argv[])
 		case 'n':
 			skip_config = 1;
 			break;
+		case 'b': {
+			char *endp;
+			unsigned long val;
+
+			errno = 0;
+			val = strtoul(optarg, &endp, 0);
+			if (errno || endp == optarg || *endp || val == 0 ||
+			    val > UINT32_MAX) {
+				pr_err("invalid rx_buf_size: %s", optarg);
+				return 1;
+			}
+			if (val & (val - 1)) {
+				pr_err("rx_buf_size must be a power of 2");
+				return 1;
+			}
+			if (val < (unsigned long)getpagesize()) {
+				pr_err("rx_buf_size must be >= PAGE_SIZE (%d)",
+				       getpagesize());
+				return 1;
+			}
+			if (val > MB(2)) {
+				pr_err("rx_buf_size > 2 MB not supported");
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

