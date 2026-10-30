Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015CB606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yd0z/dWN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300D910E85B;
	Fri, 30 Oct 2026 08:35:47 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2D910E85B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:41 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1315478eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793349340; x=1793954140;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1JSuP/hmF6Fi8nJPp3ZX98qfwOmuW23quiYMNH551tA=;
 b=Yd0z/dWN6SP2Qi/nLrcFx9oQGJt4go524+CbHEflU1qpCsntGKwWgIj7HZYYkOUiOe
 ZvLM8jrUCiTa5+NsL4nY7Lld3VpSPxJn9roirCj4/1a9QZtWJSl6Zz919F7mDlF1XTyG
 iheNaIVX7Kxq0n2eMOC7XMefsJQHWkDzAED+Gx5a8C0+wpQda00nmJ4y31Pglvv2v5tt
 cHi2jltLVKZOKBnf/GPHxDe6C/+DkLus3hpIxV+ZSrluKvf6Kt7CMLQqG9ErRQzVAQzt
 T4SaVrMtIsG8Xj6x9P+KwqoTY5iZe/GZO779A1xq/B1lX6LMYafahD/ubCcsrB1xy04S
 003g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793349340; x=1793954140;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1JSuP/hmF6Fi8nJPp3ZX98qfwOmuW23quiYMNH551tA=;
 b=T578o0q+uuWSAshIYGZigxiPm/mrxHjj8MWf2ZZx3Me0IIYFELSL5j2c7UXd7Debjg
 sSAZJ5Tp0A+NRkmWbFdh46H3MCujqTPvFZ7Jm2lJxrl7ZWqjIg16GH1P/YIsUtBA2IHM
 bQFfq+Np2IHXl/wQK1JIxzJjK9gZbRlY+48uRQUwnX+R/i2ZaS3W8yyxdse1bwyx6fRh
 LvBhIrHB2XPsueukQ4QK9/KJ+FXf+REH6+XZ2AAFsmBTNNFXB1E6Lb2xVYBAdjR5dOCg
 1watBLsDQqOvbIR3ulUrbDsoyyQDnY4gQi16k96zNYuRr6/p2T5cbYFjt77zlTbwaZs5
 0YsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW4pSZAjVr33iOgnGFpB5VkYY2pVF4gcKur2v0Y/RILhL6ISI31uiWWg63hluRH3S2PYnyUYw2Zl4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLWUGCbmBJ3PTWjxp+aJzdBbo9md0/UGZTiAwWINDTPQEZzpktG
 4vwMf3/GwKY6JQeVJWFmReevGfJlfU2i3ViL618SvL3TFMBjWvJOYW49LTOZZDUK5tSYNcEZcHZ
 lwUFxyiiokVWC+FIjWZEAAW+prA==
X-Received: from dybnj7.prod.google.com ([2002:a05:7300:d087:b0:369:fc78:c914])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4543:b0:353:5d0a:dba4 with SMTP id
 5a478bee46e88-36a4248a4bcmr2685687eec.36.1793349339731; 
 Fri, 30 Oct 2026 01:35:39 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:35:34 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030083539.777877-1-almasrymina@google.com>
Subject: [PATCH net v5 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Paolo Abeni <pabeni@redhat.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Pavel Begunkov <asml.silence@gmail.com>, 
 David Wei <dw@davidwei.uk>, Taehee Yoo <ap420073@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
add netdevsim support plus selftests covering both RX and TX device
unregistration. These issues were found via LLM-assisted code review
(Sashiko) and reproduced and verified with the new nl_netdev.py
selftests on netdevsim (not tested on real hardware):

1. net: devmem: unmap dma_buf synchronously on queue uninstall
   Synchronously unmap and detach binding->attachment under binding->lock
   when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall()
   or closed in net_devmem_unbind_dmabuf(), and unmap remaining unbound RX
   bindings on NETDEV_UNREGISTER, preventing slab-use-after-free in
   dma_unmap_sg_attrs() when the binding is freed after dma_dev. Factor
   out net_devmem_lock_dev() and net_devmem_unlock_dev() to synchronize
   netdev_nl_sock_priv_destroy() and __net_devmem_dmabuf_binding_free()
   against NETDEV_UNREGISTER.

2. net: devmem: detach TX bindings on NETDEV_UNREGISTER
   Extend net_devmem_dev_unregister() to fully detach and unmap TX
   bindings when binding->dev unregisters, or clear binding->vdev alone
   when only a virtual device unregisters while binding->dev lives.

3. netdevsim: support devmem RX and TX bindings
   Enable PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_NETMEM, 64-bit DMA mask
   on nsim_bus_dev, and NETMEM_TX_DMA on netdevsim so devmem RX/TX bindings
   can be exercised in software selftests.

4. selftests: net: add devmem RX and TX netdev unregister tests
   Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
   to tools/testing/selftests/net/nl_netdev.py.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>

---
v5:
- Rebase onto net after the net-next merge and state how the issues were
  discovered and tested (Jakub).
- 1/4: Inline net_devmem_dev_unregister_rx() into
  net_devmem_dev_unregister() (Stanislav). Factor out
  net_devmem_lock_dev() and net_devmem_unlock_dev() and clear binding->dev
  after unmapping and re-acquiring the xarray lock so
  __net_devmem_dmabuf_binding_free() cannot free the binding while
  net_devmem_dev_unregister() is still accessing it, and reject RX devmem
  net_iovs in validate_xmit_unreadable_skb() (Sashiko).
- 2/4: Inline the TX unregistration check into net_devmem_dev_unregister()
  (Stanislav), clear binding->vdev under the xarray lock, and lock
  binding->dev in __net_devmem_dmabuf_binding_free() for TX bindings as
  well (Sashiko).
- 3/4: Configure the DMA mask and dma_parms in nsim_bus_probe() gated on
  dma_pci_p2pdma_supported(), require PP_DMA_INDEX_BITS before setting
  PP_FLAG_DMA_MAP, check for NULL ns->rq in nsim_pp_hold_write(), and drop
  unreadable or net_iov skbs at the start of nsim_start_xmit() (Sashiko).
- 4/4: Tolerate non-UTF-8 dma-buf names in debugfs bufinfo (Sashiko).
- Link to v4: https://lore.kernel.org/netdev/20261015163915.1166043-1-almasrymina@google.com/

v4:
- 1/4: Unmap RX bindings in net_devmem_unbind_dmabuf() once their queues
  are closed, and make netif_mp_close_rxq() report queue restart
  failures, so the NETDEV_UNREGISTER walk only handles bindings whose
  queue failed to restart. Drop net_devmem_lock: walk the bindings under
  the xarray lock and take the instance lock of binding->dev in the
  final free. (Stanislav) Record a queue in bound_rxqs before opening
  it. (Sashiko)
- 2/4: Detach and unmap TX bindings directly from the walk, without a
  grace period or a second pass. (Stanislav)
- Link to v3: https://lore.kernel.org/netdev/20261014161754.3782346-1-almasrymina@google.com/

v3:
- 1/4: Run the NETDEV_UNREGISTER walk under the netdev instance lock,
  and skip it when the device only moves to another netns. (Sashiko)
- 2/4: Detach all matching TX bindings, then synchronize_net() once
  before unmapping them. (Sashiko)
- 3/4: Only request page pool DMA mapping with CONFIG_HAS_DMA, refuse
  pp_hold on memory provider pools, and drop unreadable skbs in the
  software PSP checksum path. (Sashiko)
- 4/4: Check only the test's dma-buf in debugfs, skip instead of passing
  silently, clean up on errors, compute UDMABUF_CREATE per arch, and
  add the needed config options. (Sashiko, Dragos)
- Link to v2: https://lore.kernel.org/netdev/20261012174300.2338784-1-almasrymina@google.com/

v2:
- 1/4: Don't unmap when a leased queue is unleased. Keep bindings in
  net_devmem_dmabuf_bindings until freed, hidden from TX lookups by an
  xarray mark, and unmap unbound RX bindings on NETDEV_UNREGISTER. Update
  the binding->lock and binding->ref comments. (Sashiko)
- 2/4: Detach TX bindings from the same net_devmem_lock-protected walk,
  which now also covers unbound TX bindings, and clear the LIVE mark
  instead of erasing the ID. The walk no longer uses RCU or takes
  binding references (Stanislav).
- Link to v1: https://lore.kernel.org/netdev/20261010025532.839559-1-almasrymina@google.com/

Mina Almasry (4):
  net: devmem: unmap dma_buf synchronously on queue uninstall
  net: devmem: detach TX bindings on NETDEV_UNREGISTER
  netdevsim: support devmem RX and TX bindings
  selftests: net: add devmem RX and TX netdev unregister tests

 drivers/net/netdevsim/bus.c              |   9 ++
 drivers/net/netdevsim/netdev.c           |  33 ++++-
 drivers/net/netdevsim/netdevsim.h        |   1 +
 include/net/page_pool/memory_provider.h  |   4 +-
 net/core/dev.c                           |   4 +-
 net/core/devmem.c                        | 181 +++++++++++++++++++----
 net/core/devmem.h                        |  37 ++++-
 net/core/netdev-genl.c                   |  16 +-
 net/core/netdev_rx_queue.c               |  26 ++--
 tools/testing/selftests/net/config       |   4 +
 tools/testing/selftests/net/nl_netdev.py | 125 +++++++++++++++-
 11 files changed, 373 insertions(+), 67 deletions(-)


base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
-- 
2.56.0.385.gac671c819a-goog

