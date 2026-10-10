Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B781CA9EBD
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F0E10EB66;
	Sat, 10 Oct 2026 02:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="sa1HKREk";
	dkim-atps=neutral
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F6010EB66
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:55:35 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso1567847eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 19:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791600935; x=1792205735;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BuyDELz7hhEuCW2YvtmlqnI82KO/2H6a0eJ5B6jjRa4=;
 b=sa1HKREkt7S3UypVbv7YmcJ+DgIK/a2GlIz5UszQfysvmOHoqRPi0RvkGuDWl0WQ96
 kYkEAnwInb9aLyuyJz/+Kjal+0kFVQg1kYV9vSXm07N+QgWB5Q9z+0bFSuxUmCZdqf2z
 cyn74rfD8jqtve65EsNFPKKYdtfOCBT41gp1aVv5N5Rm1QW7Dk5zp/irTQ2WZn0uoZmX
 KzO2YKqVJ7XppxtDadxw+m1RszxvQpAFc6Ph/GFsJxo1U3WejXH13GhPUdX9Gd81CARF
 uqgYfvlXgdQ8Q98IH7sT18CNUbd+7wHlpqlL99r4lO4zNwhidKcPS6xYHvLSssDm+zUG
 kYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791600935; x=1792205735;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BuyDELz7hhEuCW2YvtmlqnI82KO/2H6a0eJ5B6jjRa4=;
 b=bVOePU7d2yDw8M4RrNlSFomJMtHSTuGIbdNePdeGdux+QFQCSKbFj+Lv93/uy2NAU8
 ujE1tbQaFAmonLY7hEt2449mn3v2I8204X5k4XztUZYdtGUFJ/iZY60YgZPpxyRseJMx
 VO+XNMl4io66KkGXTu61FfxAldpmIE/on5b2s6RsY4b+nawf6w6AOOLaHibD2e4eAimI
 9GzXeEVakRmtbflWEGKuzPPo7lr1QOIwBpX8y6Gz1nSLxDwlVmELRSRdrofXFlmrgEQQ
 P7zhr9+KUr+Rkx9Yp9K4adwBEakdB3Zl3M04M6VyhzH5b9ZxYjYzs90Z+7tYVKEuqyHa
 ErGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3YAY3fNZWdqLFhZr/KmsYzQofqdUuvAWYj+Cx12GDkTPjxH6t2M+xcDECkyFjKtmK9D9LtT4vCXM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKz+78yUo3AqsCfuV8AF5+YvQ3VLENT6UWAGNneCoGL87i6q3ig
 0d1Z261Tg8CI+DM/2rkoRNmZTdT+8qZ2SR2S7RuUteBm8mtTCU24s9e3uMsIvZ5ZiR2r4Vvah6a
 btKrfULTWnA+f7+6uwyvgxXuqYA==
X-Received: from dyaz17-n2.prod.google.com
 ([2002:a05:693c:6391:20b0:34b:4d35:2884])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:78ca:b0:351:750d:dd3b with SMTP id
 5a478bee46e88-3537dde75a7mr5327189eec.4.1791600934160; 
 Fri, 09 Oct 2026 19:55:34 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:55:13 +0000
In-Reply-To: <20261010025532.839559-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261010025532.839559-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010025532.839559-2-almasrymina@google.com>
Subject: [PATCH net v1 1/4] net: devmem: unmap dma_buf synchronously on queue
 uninstall
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 David Wei <dw@davidwei.uk>, 
 Pavel Begunkov <asml.silence@gmail.com>, Taehee Yoo <ap420073@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
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

When a bound net_device is unregistered while userspace still holds a
netlink or TCP socket reference on a devmem binding,
mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
netdev_nl_sock_priv_destroy() will not touch the unregistered
net_device, but leaves the dma_buf attachment mapped until
__net_devmem_dmabuf_binding_free() runs later on socket close.

Because dma_buf_attach() does not take a reference on dma_dev, device
removal frees dma_dev while the attachment is still mapped. Closing the
netlink socket afterwards triggers a slab use-after-free in
dma_unmap_sg_attrs():

  BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
  Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
  Workqueue: events __net_devmem_dmabuf_binding_free
  Call Trace:
   dma_unmap_sg_attrs+0x76/0x2b0
   unmap_udmabuf+0x8e/0x100
   dma_buf_unmap_attachment+0x145/0x330
   dma_buf_unmap_attachment_unlocked+0x96/0x130
   __net_devmem_dmabuf_binding_free+0x156/0x2e0
  Freed by task 9:
   kfree+0x1b8/0x550
   nsim_bus_dev_release+0xe/0x60
   device_release+0xcf/0x250

Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
and null out binding->sgt and binding->attachment after unmapping so
unmapping is idempotent across queue uninstall and deferred binding
destruction. Call it synchronously when the last bound RX queue is
uninstalled in mp_dmabuf_devmem_uninstall().

Fixes: f8350a4358fc ("net: page_pool: add a mp hook to unregister_netdevice*")
Fixes: 0afc44d8cdf6 ("net: devmem: fix kernel panic when netlink socket close after module unload")
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4d60654ce7fd..5e4070b82df44 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -58,6 +58,21 @@ static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 	schedule_work(&binding->unbind_w);
 }
 
+static void
+net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
+{
+	lockdep_assert_held(&binding->lock);
+
+	if (!binding->sgt)
+		return;
+
+	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
+					  binding->direction);
+	dma_buf_detach(binding->dmabuf, binding->attachment);
+	binding->sgt = NULL;
+	binding->attachment = NULL;
+}
+
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
@@ -74,9 +89,10 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		  size, avail))
 		gen_pool_destroy(binding->chunk_pool);
 
-	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
-					  binding->direction);
-	dma_buf_detach(binding->dmabuf, binding->attachment);
+	mutex_lock(&binding->lock);
+	net_devmem_dmabuf_binding_unmap(binding);
+	mutex_unlock(&binding->lock);
+
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
@@ -535,6 +551,7 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 				mutex_lock(&binding->lock);
 				ASSERT_EXCLUSIVE_WRITER(binding->dev);
 				WRITE_ONCE(binding->dev, NULL);
+				net_devmem_dmabuf_binding_unmap(binding);
 				mutex_unlock(&binding->lock);
 			}
 			break;
-- 
2.56.0.385.gd3acb90ef8-goog

