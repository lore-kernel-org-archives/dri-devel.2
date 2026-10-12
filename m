Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D462CC6B01
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7110710E632;
	Mon, 12 Oct 2026 17:43:13 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FF010E632
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:43:07 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so6124839eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791826987; x=1792431787;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+IPXKRkhi+tNf7WTVrgtIUiWsyJoo8B14Fo7i04lARs=;
 b=IZzgd4WtIHc9zWw0GJVy5wuJ9wHi4nwJKKJcuj7/7kvbH3KEnBm6MA4zbFT2LVHYaL
 So0yn6R5fecH++BbjmfszUVQljAJI35u+VGKv15+ZLqPLvcsGzJg4LfqLNLXxstZniGV
 t/Bj/rzk3y/AGM8GbBQqVVWt5j4nha41rseCrZJgFsFQOehpCn9anIyZsWIJmJJFva7P
 NDt7c2xe3S8I1P5FKEPfWTidhuTfM4Q1p+C1Cf2u9T6iSDiXDtBOPJcERXk82Y6oxyM5
 30cz01qa+W7XGo9n4g3Q6Ml3eBXUo+VUTwQlmHheo3udxc92nWgUNLaDvCBMiggE4PDi
 vHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791826987; x=1792431787;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+IPXKRkhi+tNf7WTVrgtIUiWsyJoo8B14Fo7i04lARs=;
 b=JzLgXFaoGXBj+KwoLqQtbCryYUhfAdYO5mYmz493kJQpC4mKvEyI8htPPAeXDEeuVJ
 JFQet9xIkleSLuufgjvT2uiDcIMDuebLCte5+ilnZcXP+5W574n6+0qiujrDShlUY+dq
 gNiSz3BuKLS0cVid3WqloyZ1WMxBxzknOZTaqk9sHlqhVjWOS/6lU1BEDAmWCzV/7ych
 Oa3JvLISRITKA3lxQvZfkydIkw6RUor/HRAE8QHh7Wrhh3QHmrB1Kc1wkvzj8KpmhLbf
 wo3IUacYYCJPy0Frb6nwHv0bstYE9YYzEetUq8e2jlcJj5AWwBIf24v/PWXP9wEcILxd
 H4Rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw46b7QfogWauPqOrd/U2oE3MkjdCM05AeLCLSy3U+VRuu3by5jCeHj5HUE7geS1AIIXE3sVGxXV5A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYHU1R8BqRRrwYibDoKIPunLtWozxh5NThUsOyj2/5H22jT9Il
 wkXWStsUld37qL5copoPMXoPPpcfd86xezYqNDDj6j9o1qJ1oCVMr+AqWf260ajv6Z9/LibD7vu
 Fbwy8RX/cdLWRsZ7ldm20jRDrGA==
X-Received: from dyay11.prod.google.com ([2002:a05:693c:62cb:b0:33c:286e:b614])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:ce13:b0:35a:3045:3aff with SMTP id
 5a478bee46e88-35a3054a74bmr6086881eec.29.1791826986262; 
 Mon, 12 Oct 2026 10:43:06 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:42:58 +0000
In-Reply-To: <20261012174300.2338784-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261012174300.2338784-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012174300.2338784-3-almasrymina@google.com>
Subject: [PATCH net v2 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
 Pavel Begunkov <asml.silence@gmail.com>, Mina Almasry <almasrymina@google.com>,
 Taehee Yoo <ap420073@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
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

Extend net_devmem_dev_unregister() to TX bindings, including ones
whose netlink socket is already closed but which TCP retransmits keep
alive:
- When binding->dev (the physical DMA-capable device) unregisters,
  clear the binding's NET_DEVMEM_BINDING_LIVE mark, clear both
  binding->dev and binding->vdev, wait for in-flight RCU/TX readers via
  synchronize_net(), and unmap the dma_buf under binding->lock.
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
v2:
- Build on the net_devmem_dev_unregister() walk from the previous patch,
  so unbound TX bindings are also detached (Sashiko). Clear the
  binding's LIVE mark instead of erasing its ID.
- The walk holds net_devmem_lock, which the final free also takes
  before erasing the binding, instead of using RCU and
  percpu_ref_tryget(), so it no longer takes a binding reference
  (Stanislav).
---
 net/core/devmem.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 02d607cc87217..a1c029f6ae47f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -192,6 +192,36 @@ net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
 	mutex_unlock(&binding->lock);
 }
 
+static void
+net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
+			     unsigned long xa_idx, struct net_device *dev)
+{
+	if (READ_ONCE(binding->dev) == dev) {
+		xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
+			      NET_DEVMEM_BINDING_LIVE);
+
+		mutex_lock(&binding->lock);
+		WRITE_ONCE(binding->dev, NULL);
+		WRITE_ONCE(binding->vdev, NULL);
+		mutex_unlock(&binding->lock);
+
+		/* Ensure no tx net_devmem_lookup_dmabuf() or
+		 * validate_xmit_unreadable_skb() are in flight after detach.
+		 */
+		synchronize_net();
+
+		mutex_lock(&binding->lock);
+		net_devmem_dmabuf_binding_unmap(binding);
+		mutex_unlock(&binding->lock);
+	} else if (READ_ONCE(binding->vdev) == dev) {
+		mutex_lock(&binding->lock);
+		WRITE_ONCE(binding->vdev, NULL);
+		mutex_unlock(&binding->lock);
+
+		synchronize_net();
+	}
+}
+
 void net_devmem_dev_unregister(struct net_device *dev)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -201,6 +231,8 @@ void net_devmem_dev_unregister(struct net_device *dev)
 	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
 		if (binding->direction == DMA_FROM_DEVICE)
 			net_devmem_dev_unregister_rx(binding, xa_idx, dev);
+		else
+			net_devmem_dev_unregister_tx(binding, xa_idx, dev);
 	}
 	mutex_unlock(&net_devmem_lock);
 }
-- 
2.56.0.385.gd3acb90ef8-goog

