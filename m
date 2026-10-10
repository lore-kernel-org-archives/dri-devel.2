Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE8DCA9EBD
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49D710EB6B;
	Sat, 10 Oct 2026 02:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UAEbiRv2";
	dkim-atps=neutral
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC0E10EB66
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:55:34 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34d49d8dee1so553293eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 19:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791600934; x=1792205734;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nr/wh3D04jCOdxRooqTq4ckJalsK9oapi786CLs1riY=;
 b=UAEbiRv2XS7ye0pJbbaEf5+6kwVMdE48cm6p8I91+CCELmo2JJs4IHH/ghVhnaY8Vw
 RFBQCiVfhY0wmtfJpP1EVKNRKFvKi5MPAgRkav19sRMirbJtenlEnBpg/jX3aayO5GaD
 0Kn70NLUV4AkZNd7p54QrgcGvaIC0E8Xl1xRQiQOpp8+sdcnxYZNPEEtK+QSpgcl/9GZ
 uef+hds6h2jX3UM/U3VIEToMPd0dUezFM9nsz90+X70EgkIzrjhAR+1xL5pkHROBdnX5
 YSQTlPo37dBneL635YqC7oX5Qz2OEPPOVYRiLxFJxSV/5GD/+heEKcmOgGidlkc15ecj
 HTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791600934; x=1792205734;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nr/wh3D04jCOdxRooqTq4ckJalsK9oapi786CLs1riY=;
 b=OWXAt7BlE2pGbI3GlatqyGw0q9WRRt1KBsykk2PnK8hduJMR0Tp1ivxYo98qWUxv9f
 b7G3O03zHuipES3jdvss33mygejSFbZVkXAAPXpH1dcAUxy3xKxJ2065f51Xpmhjg18A
 tfmAEvKD7Uij3APXVoneSnFv7yE9polSxM11vr9hwqE1Jk/GPWXKAuTlTyH4L5Z2FoTM
 /Rf9yZZvFWgA8XThR6Xe8HQknFLb5/IgI4zJHsjFsMDsAViHXL2LGssi97MLpJ13BnlG
 k58JQ44KNOv9sJrWrjV9opMZiQHaw4HWLuikrRhnG/BvUllpapS1J7T0uqFkCljDR/d0
 D4HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxX2kGx1VSplAKS1ub0yqkFy9iZ5UeFfhK4SIku9WQ8GOSIqg/sLnshEiQkQYg8dXeE0EPSQQrcb4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL28VJuTwwxAyChH3lm2/MDuDx4tjJIKl8Tc9IRie3r5mLIyZGv
 FCrv7Qhp6Ho/uXhhpQg58Ii/TtM3pLEO9Bqk/5f9W6PPCAHCc8qP9Sl3TtxjhmM/gkvkOpZEw7r
 xEm40rxR3KQEaw9gejoxUWtWMXg==
X-Received: from dlbqs7.prod.google.com ([2002:a05:7023:d07:b0:146:59b2:8236])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4211:10b0:14a:a6dc:9cd7 with SMTP id
 a92af1059eb24-16a57a16ef2mr4717399c88.2.1791600933127; 
 Fri, 09 Oct 2026 19:55:33 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:55:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010025532.839559-1-almasrymina@google.com>
Subject: [PATCH net v1 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
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

Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
add netdevsim support plus selftests covering both RX and TX device
unregistration:

1. net: devmem: unmap dma_buf synchronously on queue uninstall
   Synchronously unmap and detach binding->attachment under binding->lock
   when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall(),
   preventing slab-use-after-free in dma_unmap_sg_attrs() when the netlink
   socket closes after dma_dev is freed.

2. net: devmem: detach TX bindings on NETDEV_UNREGISTER
   Add net_devmem_dev_unregister() on NETDEV_UNREGISTER to fully detach and
   unmap TX bindings when binding->dev unregisters, or clear binding->vdev
   alone when only a virtual device unregisters while binding->dev lives.

3. netdevsim: support devmem RX and TX bindings
   Enable PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_NETMEM, 64-bit DMA mask
   on nsim_bus_dev, and NETMEM_TX_DMA on netdevsim so devmem RX/TX bindings
   can be exercised in software selftests.

4. selftests: net: add devmem RX and TX netdev unregister tests
   Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
   to tools/testing/selftests/net/nl_netdev.py.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>

Mina Almasry (4):
  net: devmem: unmap dma_buf synchronously on queue uninstall
  net: devmem: detach TX bindings on NETDEV_UNREGISTER
  netdevsim: support devmem RX and TX bindings
  selftests: net: add devmem RX and TX netdev unregister tests

 drivers/net/netdevsim/bus.c              |   1 +
 drivers/net/netdevsim/netdev.c           |  21 +++--
 net/core/devmem.c                        |  68 +++++++++++++-
 net/core/devmem.h                        |   5 ++
 net/core/netdev-genl.c                   |   1 +
 tools/testing/selftests/net/nl_netdev.py | 108 ++++++++++++++++++++++-
 6 files changed, 192 insertions(+), 12 deletions(-)


base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.56.0.385.gd3acb90ef8-goog

