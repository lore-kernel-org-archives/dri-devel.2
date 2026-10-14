Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80773CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E661710E9CA;
	Wed, 14 Oct 2026 16:18:02 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F9010E9CA
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:17:56 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c902e0da2so1464012eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791994676; x=1792599476;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNYbIRDhdg/bji4iVF4z4GKSYuqq0SGaMYsIsVzbu+Y=;
 b=KamGSlTaDKWt2RuxmQZH3jNQYIjOJdAvjDFqDj2jJOvumhjvQzzUp9qlqkbVNPIj1B
 gBIdOqW3LIBma3gLtAEyx8ILcj626MNvet6gLFM6/pEfjaDOUyCZUo6XP+Bax25iQ+RC
 XeGz9V3RbxkhPRM05p2u236OyuG5JUlHLtHCHCiDcBKRgZtN12BAR9XAi5sR7IjWr42Z
 Klet+9PbRR/P9EVCmbDjOGMk8RM2jNGO6FG94qxlhUzFIcF93pAb/hdINd1Oah8Pq0ei
 27wYfmS46hhrRYl1iBUF5Y7nvJsQaY/t4BIZR0x2mxxwl9abtum+dKliYKZ36O7uchEg
 GlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994676; x=1792599476;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNYbIRDhdg/bji4iVF4z4GKSYuqq0SGaMYsIsVzbu+Y=;
 b=H0//6XI7GuwklAzvfb2ti6GZrFmspJ+NaBaT1lem24VDPHwRVXcgoDkzBc6gYEXGeG
 e0WpJs7fCQrk4K7H14KtwEdcGj6KnQUgNf1VVfZPu9XNEUsUes+qfME8/+B+XS8tbi2t
 HraukAT/HDdmRxFr598hpEY5wB1PdCjvWrW9CJ8K0b3WUqNyb5pgWxK6RDvakE/Qb9kh
 jkRRDSnQf7C31kRXT5R45KN/95wYNGjPoXtqGAaWNvQ3v4yD3By3Y2V2HG/zaOe2zRQD
 iiZ3+uJ5SgycSuS2IZsYeSQ9FPlvHvp8sDbOyLQuPKrOCbeRh/fgqx9RDbhZko09jz0H
 GtGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiwdifxgfzbrHaiU3QhFha3zK89iqiciMFZswMGIe//Z6yjV4UPXq2FwTWUGcM20EodNHlWjTXYoo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIYCfmWF5eT6BZNY+JX7lheeXndg+GgpJVlt5hNhsqLlapja3Tx
 Zsrk6C5vwK/OhhI3qaiKQhLNfhkiKYdhrSiNEWLPDlfSlBAEJR4f+vrMa++V8Sia0hFAz92vJLG
 rnz+c+ZtUA5mC2rdlAQXVQiOYuQ==
X-Received: from dli6-n1.prod.google.com
 ([2002:a05:7022:286:10b0:15e:bc16:429a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:c84:b0:146:5f73:d45b with SMTP id
 a92af1059eb24-16a54fab691mr20502668c88.3.1791994675581; 
 Wed, 14 Oct 2026 09:17:55 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:17:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261014161754.3782346-1-almasrymina@google.com>
Subject: [PATCH net v3 0/4] net: devmem: fix RX and TX binding teardown on
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
 Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>, Dragos Tatulea <dtatulea@nvidia.com>
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
Cc: Dragos Tatulea <dtatulea@nvidia.com>

---
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
 drivers/net/netdevsim/netdev.c           |  27 ++++-
 drivers/net/netdevsim/psp.c              |   5 +
 net/core/devmem.c                        | 143 ++++++++++++++++++++---
 net/core/devmem.h                        |  10 +-
 net/core/netdev-genl.c                   |   1 +
 tools/testing/selftests/net/config       |   4 +
 tools/testing/selftests/net/nl_netdev.py | 125 +++++++++++++++++++-
 8 files changed, 290 insertions(+), 26 deletions(-)


base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
-- 
2.56.0.176.g3575e65682-goog

