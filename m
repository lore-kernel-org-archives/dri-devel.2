Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FBACC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02891123EF;
	Thu, 15 Oct 2026 16:39:23 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6FA10EC0D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:39:17 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso189694eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792082357; x=1792687157;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DD74npn17j4yI5LDxhcNiaGvijuuU+ohVy4Pfwe/27o=;
 b=b8wo15Tppp/VL4xuG2uasMTdTx3fpDHRK6ms++swSILrFWPQDBeY/4rXLHrth38TbS
 u53eixrXY3oZ0Wp5OvH7uRNEisUwRtmSqxP9zlzKv2dgyw2+MD/TBDoN1DTjZD4ZGeJk
 zhEJaSpy//hX5/GEB2GooUwfJeqvwzmMA4TWZIyt6s4FW/x5Udn4nog58K5h1IeRMLJP
 4MpD9H40REwf7DY3Q9BtACYteVZhan1KCvOwNiQG+5h4xm5em0mv6ZK/zsWpxEMhnYJI
 R9SnMmJhpVIjyIeV/7ZWwopWVM0oZViXHY6JzqKIjJ3QPL7kDwiqnNehyNp3WHq+rxpL
 PqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792082357; x=1792687157;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DD74npn17j4yI5LDxhcNiaGvijuuU+ohVy4Pfwe/27o=;
 b=acRjDtL2DtYxhx+8fkrgmYVld8eycXmfzqpoGsCbOaEZphVohHoH6An4TXIejLKsf0
 30PNZAyw2sN2cl8WuoJeonK9fJGN5oPtClT8gkd9OLKm2nk2Y4z5Kq5ZiLsMZbmNsfTs
 wRYOxIJntJDKn4qwpVjalxmEuXG0OW4int5a41KSUFl5hKyImrtKq8CMeNXPtx2HfeN2
 YZOijSFZGZ5x8+8/N7UK0Mz9kRcjumg+8EOTE1fyrSqY/YOEggS/YfRmPvYmEluhwTTb
 7sRPUK5aczuJud3PjIXgJ2tdOtQKbrOq7vcitVf4//+n1oOJDjSUks9a7FFM25j5Yn2J
 kCnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3vbb430jCI3rDQyfH6f3UrgNMTbOSfO++n5bGwvrJE5W5k5e/JGlcTo/vjKK3ns7NiuuJ6E5Fl6g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIXOPRhXgGSLm2LmWIoR3yQGO4W5P1ghHb8AWV6zYUoq/XpYZ8g
 SQu8d+cEMcgr/BISKzvCOHsS+LbaTSdDDabOrCuo00XinRXy0mT4za2hZ5Za002mooGqbrzG2Vs
 gJFefERDhyAqUaWw5JTfGT8uRWw==
X-Received: from dlbut14.prod.google.com
 ([2002:a05:7022:7e0e:b0:152:9a82:8c78])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6b9b:b0:156:d588:c881 with SMTP id
 a92af1059eb24-182500534eemr688262c88.2.1792082356249; 
 Thu, 15 Oct 2026 09:39:16 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:39:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015163915.1166043-1-almasrymina@google.com>
Subject: [PATCH net v4 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
 Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
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

Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
add netdevsim support plus selftests covering both RX and TX device
unregistration:

1. net: devmem: unmap dma_buf synchronously on queue uninstall
   Synchronously unmap and detach binding->attachment under binding->lock
   when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall()
   or closed in net_devmem_unbind_dmabuf(), and unmap unbound RX bindings
   whose queue failed to restart on NETDEV_UNREGISTER, preventing
   slab-use-after-free in dma_unmap_sg_attrs() when the binding is freed
   after dma_dev.

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

---
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

 drivers/net/netdevsim/bus.c              |   1 +
 drivers/net/netdevsim/netdev.c           |  27 +++-
 drivers/net/netdevsim/psp.c              |   5 +
 include/net/page_pool/memory_provider.h  |   4 +-
 net/core/devmem.c                        | 157 +++++++++++++++++++----
 net/core/devmem.h                        |  11 +-
 net/core/netdev-genl.c                   |   1 +
 net/core/netdev_rx_queue.c               |  26 ++--
 tools/testing/selftests/net/config       |   4 +
 tools/testing/selftests/net/nl_netdev.py | 125 +++++++++++++++++-
 10 files changed, 314 insertions(+), 47 deletions(-)


base-commit: aa07285705f8d5bac464eb1c5b7412f8e88b91e1
-- 
2.56.0.176.g3575e65682-goog

