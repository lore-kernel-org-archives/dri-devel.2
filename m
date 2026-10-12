Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6D0CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80E710E62B;
	Mon, 12 Oct 2026 17:43:10 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E32E810E62B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:43:04 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso3769836eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791826984; x=1792431784;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3iJ1fd8MwlejaVJSs6HGpqE749ZNI8lIjAO4rDvQDfA=;
 b=UE30Rhc0wzN8PV8EMKM6MElynrMlMnjFCxr8FSGHjcGHdKq8+jpeL/JeMaSONONK15
 vaV8q013OaB5yrmbbZytHhzgYjraZJWZwTis9AhVRova4z2ElTWJS5Ijln8Rc5wVClZM
 1/61jnS3jOvH9Ui+iF4FVZb9w0Navcsi0DAQ+lfUjQHWVzmneCq0o0aCoH7aPtoDZN2G
 hsOxCM6ImhbaqNGsOFz7961RAs5dWLKxmVtVN5mo0t8a7iZqSqxRL5t+oX5pD/WAO7V9
 1qPuEBg9qMDUB2TnET+qHAhQFfBpz+8vA8bER5GC5x1SCSW+cNgZf+kzBCwcpaufM/Ec
 ce9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791826984; x=1792431784;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3iJ1fd8MwlejaVJSs6HGpqE749ZNI8lIjAO4rDvQDfA=;
 b=nKuAcHSwzY89z4wIjaXz6ukevg2e2D3LHxhzWT6hXveFcI3CvyJl018Uqo3csoBKCL
 hHz4GjEbLA1hwIS/QlKlDG9yF69cawksQGneqmVPvMjCIhwg4ywzMQhdG8Qj2Jl5Mdf9
 ICT4uyjlf5WtU0vYhnPYctsSBuD7QYuPnBS+l2Tpu9HkerUe56gmpiUANDX4V1141j7y
 PolaXJaBMyj4qR3iSvR62FW/22xvjK0JwfOnfhDyZhgxnklQO9Rf2w/oUFx3vrz9y5lF
 9fjfkpqCi4TzR0SBm90usW3JMSg/Bvgla2FzSUuJ5epp4NHOtlJIhEY0i3U5Xik2g+0+
 S3GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfAuewWfZTaNxgqP0/BDA0xK/ifs5OGcec/NCdSkE1o5P0QfydVutBoJiJKPzCXbP3OAHRrZtB9hI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJs9De6Kq8HZr8vAwtMKY1KGnU9LJtCYJ+kcqwv+/Oy6O10jG8B
 Zfolb5gN2yHalq9/zhXjmajfKigkZOL4V9GkFSguIAMJg7shQpp7GUmpMLJ5kEPUGUL0KuL49fI
 zax9ALBMoBY2IMM6dgpsbsGSrkQ==
X-Received: from dybfc20.prod.google.com
 ([2002:a05:7300:3e94:b0:35a:6ed3:3ee9])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:de49:b0:35b:b3fa:40f7 with SMTP id
 5a478bee46e88-35bb3fa4218mr1447041eec.38.1791826981179; 
 Mon, 12 Oct 2026 10:43:01 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:42:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012174300.2338784-1-almasrymina@google.com>
Subject: [PATCH net v2 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
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

Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
add netdevsim support plus selftests covering both RX and TX device
unregistration:

1. net: devmem: unmap dma_buf synchronously on queue uninstall
   Synchronously unmap and detach binding->attachment under binding->lock
   when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall(),
   and unmap RX bindings that were already unbound on NETDEV_UNREGISTER,
   preventing slab-use-after-free in dma_unmap_sg_attrs() when the binding
   is freed after dma_dev.

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

---
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
 drivers/net/netdevsim/netdev.c           |  21 ++--
 net/core/devmem.c                        | 121 ++++++++++++++++++++---
 net/core/devmem.h                        |  10 +-
 net/core/netdev-genl.c                   |   1 +
 tools/testing/selftests/net/nl_netdev.py | 108 +++++++++++++++++++-
 6 files changed, 236 insertions(+), 26 deletions(-)


base-commit: 4f6ac74fa594a918d41255c941256e1d51592d3b
-- 
2.56.0.385.gd3acb90ef8-goog

