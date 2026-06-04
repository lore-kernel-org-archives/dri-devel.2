Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3C8CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C234C112712;
	Thu,  4 Jun 2026 07:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KuAiC5Fd";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9471124F6
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 00:43:06 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so99289a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780533786; x=1781138586; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gaSc57t4jmRqWa/tEAw7kwxJOfsrDztjZyVRXA4uTHc=;
 b=KuAiC5FdWgNwq/AYViqoatcgTxvqNVhh0vlZINcvUVpkQzUi9UBgpR1xQwAq/s1lm/
 dFKLG1V1HBawl750QblSnOlEZL9USNUwSR8kUuOKg7pFY9W5VsOgznDVv11IOdZ9j7C4
 aS4YMXUwsnGlmZWiXUV8svsGfddVptRrPu8ibFwpa0wtuYH/VKAZd6+OjF/JTNdwsJmD
 E3mqt8w79alF5YXLyU/fI810m7zKzrp3I3Yo0gYAg4WtPn48qEm/ICAgZASYsnSEFcE3
 Zxptxx39yTW7eqJyiEbBiHBKDFx2Nd5d+fs4FuZIKEF+81r+5nRdczu+XvKgP9DHNkHS
 luJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780533786; x=1781138586;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gaSc57t4jmRqWa/tEAw7kwxJOfsrDztjZyVRXA4uTHc=;
 b=GNwCIEkvArMgGtoutFOie0M7OtqrNsCp27Hv4lU5rvG1urgrdSg71Loe32BQYZ42Jf
 RqpKOSr8ecQB7zyQRIycI5prjqBK62BN6nfjkZMcMKhZVvzSbrVkmviUbQKLHy+BfFK2
 dp6hD5ETzNphvJnFV5dcd5P91Ap+20flI6s1iGgJts06YyeJCkG61PIbU7CozwlD5xXX
 IK+cbWXcm4W7ZJKw0sepHt7h9/Lm+IYmMQ0DBObEYc1du7g27/kWEMSlN1cMFw3NXBuc
 N7IThv0z8B75NnSmLzaE5DxScArJtK/DLhZGcRZ4QjVBm423Xm7vk3edWXsDVUxf15Hy
 Gp3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3cWtqKoo8f58vDyuZVAPDjqBzAygLz8irjAdsnvxQE9L0ORYamr4F+eR1nmxbwHL7c4lTt66/jcE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxh6WY6PcRNRcTnfCZG8f50D8omM9VgPZjGmX8ygKU467gE1KZq
 MWAzz2ncEB3hMGlgp/9N3Kf/a8bnSpOUGEGK6K2tRbyXH3/hr1Qk6xbi
X-Gm-Gg: Acq92OGPeUFqoVm1X4oq4SIJehQ3+AW6j750DSE2osGmmDLO/KvCM4RXCYJgMBodZPM
 AeLhBv3EdNzWA+KAKcTCZed7V3UbeE7kR3idsi6yyMtdW503B1kPWUGt2d4d8atCOR4pojTlLlw
 YYXlFg1Azh22xr/l8dI2+md3O2qeEhoBnQWU19KBnnS2s8w14T55g42D4zQdc6KVDjyjM+BWdbr
 bCVfAwu2AR0ykGdzgyuO+rIF2bLef3EF1m77OSTfKAWj9eXxtYupZWECPYdR0Ae//f1cfHHMDH4
 feybv9MoJi/G11GVyHcqxKi7fERhynDspXkuPnDmgQV3wPqU9oRpWUei7gZkT94sCm2zqBqBPv8
 lyzNMgfg8PZDega5qBJNhYWpI4OOHjjqoC8zr+JAIH4vry+wD3MHufm86g3uv7Lp5tZwZHwNmKm
 uar2aC9/F175WIX9+VzRX7OOdHevriNaCc1ZRpISI=
X-Received: by 2002:a17:90b:3d4e:b0:36b:b3f4:d578 with SMTP id
 98e67ed59e1d1-36e30e17847mr5798820a91.15.1780533786256; 
 Wed, 03 Jun 2026 17:43:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6c668f90sm1067665a91.6.2026.06.03.17.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:43:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Wed, 03 Jun 2026 17:42:57 -0700
Message-Id: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABLKIGoC/x3MQQqEMAwF0KuEvzZQK1boVcRF0YwTmInSFhHEu
 wu+A7wLRbJKQaQLWQ4tuhkitQ1h/iZbhXVBJHjngwvOc5335c+/lFdh0+0o3Ifed6lLrRsGNIQ
 9y0fP9xxhUtnkrJju+wGj3Y/WbQAAAA==
X-Change-ID: 20260602-tcpdm-large-niovs-56523a3a1077
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

Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
On NICs that consume one descriptor per netmem, this caps a single RX
descriptor at PAGE_SIZE and burns CPU on buffer churn.

In this series, we add a bind-time netlink attribute,
NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov size
(power of two >= PAGE_SIZE). Drivers must opt in via
queue_mgmt_ops.QCFG_RX_PAGE_SIZE.

Selftests use udmabuf, but udmabuf sgtables were previously hardcoded to
PAGE_SIZE. This series modifies udmabuf to respect folio sizes in its exported
sgtable. The result is that when backing udmabuf with MFD_HUGETLB 2MB pages,
the sgtable is populated with 2MB entries, allowing devmem's gen_pool to carve
out large (eg. 64K) niovs.

Measurements
------------

Setup: kperf devmem RX/TX cuda, 4 flows, 64 MB messages, 60s, dctcp,
num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov size,
mlx5.

   niov       RX dev Gbps   RX flow avg Gbps         app sys %
  -----  ----------------  -----------------  ----------------
     4K  300.63 +/- 53.21    75.16 +/- 13.30   54.15 +/- 10.23
    16K  321.35 +/- 28.20    80.34 +/-  7.05   41.05 +/-  8.87
    32K  347.63 +/-  2.20    86.91 +/-  0.55   44.54 +/-  3.51
    64K  332.11 +/- 14.26    83.03 +/-  3.56   35.47 +/-  3.11

RX app sys % drops ~19% from 4K to 64K.

kperf support (not yet merged):
https://github.com/facebookexperimental/kperf/commit/8837577f920876bce6986ec18869ac04439ebcd2

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (4):
      net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding
      udmabuf: emit one sg entry per pinned folio
      selftests/net: ncdevmem: add -b option to set rx-buf-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

 Documentation/netlink/specs/netdev.yaml            |  8 ++++
 drivers/dma-buf/udmabuf.c                          | 47 ++++++++++++++++---
 include/uapi/linux/netdev.h                        |  1 +
 net/core/devmem.c                                  | 52 +++++++++++++---------
 net/core/devmem.h                                  | 13 ++++--
 net/core/netdev-genl-gen.c                         |  5 ++-
 net/core/netdev-genl.c                             | 18 +++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/config      |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 12 ++++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 46 ++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 49 ++++++++++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 ++++-
 13 files changed, 220 insertions(+), 44 deletions(-)
---
base-commit: dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

