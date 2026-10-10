Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDD2CA9EBB
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84BE10EB71;
	Sat, 10 Oct 2026 02:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="iw9IpbJU";
	dkim-atps=neutral
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF6D10EB66
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:55:36 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35158d674e1so1456759eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791600936; x=1792205736;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=87muJ1tbWnWvEna277XYC9fNu6butp/C0K6k1Uhxmjg=;
 b=iw9IpbJUfcEtT+VwG+cF4CLCBzp4KW2Kkx+YgBUlw6M3g19yOMRZqL3945ptMwapCc
 6LBupISX+dpZ3JY+XU5CqFuPCavWEngoGpr9MfReKiaY3u/xKiBIvpOl4im6wJHrGSpv
 Ky9bwUTWm1fgN96B1S4gmSEVs/vgoAk/NlhvbiQvaRNniaOUeB/gk/FKOjUwXuoro7Fu
 6Es0McwwAQ7nfs0LlPSd00I9qeMvJNYY2YkA6SqcvINEggm4UUboktyfufojg00Maw4I
 oYu61ZNcHnQ5pkDaQvVb9nJlHZRYYDK1MjhXMDpqXBBnJCKwrHGehowZlwhWC19url+e
 UDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791600936; x=1792205736;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=87muJ1tbWnWvEna277XYC9fNu6butp/C0K6k1Uhxmjg=;
 b=OhfBnKCasK2F1FYtuvVziJHimVMj3d2okmEqti5J1hUp0+TTfBwoKHbjSq+8aI2NJq
 tlOSJ1BqImD/h6uurmw+/eG0T0LGk1puCjgFdLgLBqDg9bKHWvi/HcruCZ2NGMjhmN0t
 QumSkSStwDusQEoPxTPRZxmiKzBxWTuLRuG0BZiBLVK1yKEJDPQfCTiGDXtCsucWyKNV
 ntS8cgtDH80zgszwaK20hjdH8voVoEXqQJ/sscaRZ58+AjQzIuCtlpL4Ss/66sra/71d
 8tcvGbBpoIisOKh+0QBd7AAkxfhnjAu3w0sHkIL7MkaaRxHdmipXKSw9fQP8ZHRjbN6i
 uMrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKuDWv5XwzgV85wX5oqEkAe5OS2wuJg0qUn9Os0iMoEIJ6wJ9G3L17wzQ+lUZ4krpdspCSxl25Zng=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIWKZfdz6m1zo8GGGTrtIIMNJ/sz74f/AqUILvYbDY6jSH/uzhZ
 59cnJjEsW6Bbe4XYTa4K/640hDVkTye+gEoAPoi4NRbrvVWI8CIwvyi0l7I1sd2eu+StyzWan3U
 Vu7awSHMXzeFHlU31VE3n9IsvKA==
X-Received: from dycrm15.prod.google.com
 ([2002:a05:693c:2a0f:b0:355:e5a8:715f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:26c7:b0:34e:2b79:3ca0 with SMTP id
 5a478bee46e88-3537df8cecbmr5165163eec.13.1791600935744; 
 Fri, 09 Oct 2026 19:55:35 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:55:14 +0000
In-Reply-To: <20261010025532.839559-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261010025532.839559-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010025532.839559-3-almasrymina@google.com>
Subject: [PATCH net v1 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
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

TX devmem bindings (NETDEV_CMD_BIND_TX) have no bound RX queues, so
mp_dmabuf_devmem_uninstall() never runs when binding->dev or
binding->vdev unregisters. As a result, binding->dev and binding->vdev
dangle pointing to freed struct net_device memory, and the dma_buf
remains attached and mapped after device removal.

Closing the netlink socket after netdev unregistration dereferences the
freed struct net_device in netdev_nl_sock_priv_destroy():

  BUG: unable to handle page fault for address: ffff88824ca9b000
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:netdev_nl_sock_priv_destroy+0xbd/0x1e0
  Call Trace:
   genl_release+0xf5/0x190
   netlink_release+0xd01/0x18d0
   __sock_release+0xb0/0x270
   sock_close+0x18/0x20

Add net_devmem_dev_unregister() called on NETDEV_UNREGISTER:
- When binding->dev (the physical DMA-capable device) unregisters,
  erase the binding ID, clear both binding->dev and binding->vdev, wait
  for in-flight RCU/TX readers via synchronize_net(), and unmap the
  dma_buf under binding->lock.
- When only binding->vdev (virtual device) unregisters while
  binding->dev lives, only clear binding->vdev so no new TX sends match
  the virtual device while allowing in-flight TX packets on binding->dev
  to finish DMA safely.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Fixes: 1abe839b34ae ("net: devmem: support TX over NETMEM_TX_NO_DMA devices")
Cc: Kaiyuan Zhang <kaiyuanz@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c      | 45 ++++++++++++++++++++++++++++++++++++++++++
 net/core/devmem.h      |  5 +++++
 net/core/netdev-genl.c |  1 +
 3 files changed, 51 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 5e4070b82df44..da7b3e8abaa13 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -169,6 +169,51 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	percpu_ref_kill(&binding->ref);
 }
 
+void net_devmem_dev_unregister(struct net_device *dev)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	unsigned long xa_idx;
+
+	rcu_read_lock();
+	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
+		if (!percpu_ref_tryget(&binding->ref))
+			continue;
+		rcu_read_unlock();
+
+		if (xa_empty(&binding->bound_rxqs)) {
+			if (READ_ONCE(binding->dev) == dev) {
+				xa_erase(&net_devmem_dmabuf_bindings,
+					 binding->id);
+
+				mutex_lock(&binding->lock);
+				WRITE_ONCE(binding->dev, NULL);
+				WRITE_ONCE(binding->vdev, NULL);
+				mutex_unlock(&binding->lock);
+
+				/* Ensure no tx net_devmem_lookup_dmabuf() or
+				 * validate_xmit_unreadable_skb() are in flight
+				 * after detach.
+				 */
+				synchronize_net();
+
+				mutex_lock(&binding->lock);
+				net_devmem_dmabuf_binding_unmap(binding);
+				mutex_unlock(&binding->lock);
+			} else if (READ_ONCE(binding->vdev) == dev) {
+				mutex_lock(&binding->lock);
+				WRITE_ONCE(binding->vdev, NULL);
+				mutex_unlock(&binding->lock);
+
+				synchronize_net();
+			}
+		}
+
+		net_devmem_dmabuf_binding_put(binding);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+}
+
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 4a293a7d1149c..b572013d602c7 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -100,6 +100,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
+void net_devmem_dev_unregister(struct net_device *dev);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
@@ -196,6 +197,10 @@ net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 }
 
+static inline void net_devmem_dev_unregister(struct net_device *dev)
+{
+}
+
 static inline int
 net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct net_devmem_dmabuf_binding *binding,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 33b9f4eb9565a..5bfcd513fb0e8 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1487,6 +1487,7 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
 		netdev_unlock_full_to_ops(netdev);
 		break;
 	case NETDEV_UNREGISTER:
+		net_devmem_dev_unregister(netdev);
 		netdev_lock(netdev);
 		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
 		netdev_unlock(netdev);
-- 
2.56.0.385.gd3acb90ef8-goog

