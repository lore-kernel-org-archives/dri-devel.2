Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9179CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D040B10E0C8;
	Sun, 14 Jun 2026 15:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jLaUDZm1";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A544910EAA1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:28:11 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8422f395a4aso878610b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781281691; x=1781886491; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1gfCjqesfW4kvsUaSrLF2IXLSdKMNWo5TtK5P4zLV3s=;
 b=jLaUDZm1YhFA47jNvdZ9CXcEPqpHCXFAfeJ2cX0wXo3S+ix1fiCN6EARZVY06Hu9U8
 ijg/eHIqzkDUEpUcTYDkYtOWPRoJQZzr+SXJgY5P885wWQ30GikvmaayZduhD7Pv9+yL
 hOHRdQKAzzCFBSZncvCK5KQUk4zFGoJwjsEi0DvvXGjleM5JzeOUR9uCq1Ip5Qb6HJPf
 y3FMNdpx46/nv5vrHtilQOGpjVSC/SkKoqf78obfB+E0ns0PAvduW3UEWglIVcdcDHA4
 VtSPe6Pont5K4fXUWiXAKjNiyWGlBZ+qzfof+HwTZ7kzCf6ye9Yf3SfoAb5BkqlmD04C
 QQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781281691; x=1781886491;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gfCjqesfW4kvsUaSrLF2IXLSdKMNWo5TtK5P4zLV3s=;
 b=E1l3Hx6BSjMutu6NDh75nev5BbaAVHJzgIsJf6xiinBocO6VEmjcpVAlaH+aoOGTJT
 jEYNp1PhJBjsMqWULNOpDubX6QpQqI3+v9ZH3IzsJSTQwknynru8IOVf/FO42DXl5gTj
 EwC1baCDidIhurdWgX3/2uOoMNEenIpCPtCO5ezsc0cBi+lb7tNzqkwZZaPYogsBjMYE
 UfkjASPIT7QY77SVKaSiP1wiIn5QV9gWpxw5dxoLo4elsaPL4zmdK+fCHU3I6VFvQ6BK
 Be+p3FWIlDjsD6qZOFsvlv0At5gUeA6m0N8FSdcnsFZHuquGy81Sk2p1drG1NeQ55yvJ
 jNkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3ku3XlSHJLZUILW9+Kt4A1GjPUKMLcShnVmzzg51F+wabtbnkP2FX3KBMVb6Hi+k1UMI+kQExR5s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc7vqqwtU7kMjclsd61XrmINDEMBk3RkRdqdEtnyxixzc14Nlk
 uZl9KkTdWfCsNE1eJwmZPL3jAhRHtNytV0GwXrXnmv0fC766XBKhyNTt
X-Gm-Gg: Acq92OGg+2GbScVXp3QWOpoNSstXMj2UHeBga40fppF4LzSgCdPSwfnhU+2HHV7iiiV
 1XoLMAhGWMv4aNZYHDr4/AvQMwj+IxJ8Jh6xPPSVKrwzPyyHwH0aq9HHR3FVm/yzfyg2V8xHf1i
 LeSyhiQuhhUxvsnE8KIL9ZPs0kRB5aERgVYUGPybQ3QFWxetU9UZVPIi3ZnUr1w+Zdy10QEg2oN
 NXMamRLs7F51b08GNKGzQm/xa/sPUgYcaV8PzpP0EU3JPCQ1WLUHxTKMBvqHm5hl/7V4GNv9Qpy
 14uJ64bcszcRzuo4NySUs4FRQjtboBhrZfIPvhOkmqoxvU+Lht9aaEBhUyPXqKxXEYxXCzG8TJ5
 5v/Dr1kh+XGkY1YYr7Mbn1N1xHHXbQazyt/ShCT0DL2EyRFRFwv3AQ8c4eyypeibOTygcdBfbVP
 jhOPWh2TYjTjWTeSqIL70=
X-Received: by 2002:a05:6a00:2998:b0:82c:7420:82bf with SMTP id
 d2e1a72fcca58-8434d0b0bc3mr2959505b3a.19.1781281690860; 
 Fri, 12 Jun 2026 09:28:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b05d7d7sm2906069b3a.60.2026.06.12.09.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:28:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 0/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Fri, 12 Jun 2026 09:25:56 -0700
Message-Id: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABkzLGoC/23NQQrDIBBA0avIrDNFx0Yhq96jdGHNpBUaU1QkJ
 eTuBekii64/vL9B5hQ4wyA2SFxDDkuEQehOgH+6+GAMIwwCSJKRRhIW/x5nfLn0YIxhqRl705N
 22ilpLXQC3omnsDbzCpELRl4L3DoBz5DLkj5tVlXrP1f/catCiZO27uy8sWT8ZebiTn6ZG1bpA
 Cj1DyCUyEz3SfVse9IHYN/3L8Foqfj8AAAA
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
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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
Changes in v3:
- fix a bunch of non-reverse christmas tree declarations (Stan)
- remove extra uint32 cast for getpagesize() (Stan)
- remove overzealous strtoul checking (Stan)
- remove value checks that the kernel already performs on rx_buf_size
  (Stan)
- Link to v2: https://lore.kernel.org/r/20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com

Changes in v2:
- Use NL_SET_ERR_MSG_FMT for sg alignment failure details (Stan)
- Keep -E2BIG (not a direct ask, but seemed preferred, Stan)
- Update udmabuf commit message and comments explaining why
  "one sg ent per folio" is useful (Christian)
- Set/restore nr_hugepages in py harness (Stan)
- Link to v1: https://lore.kernel.org/r/20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com

---
Bobby Eshleman (4):
      net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding
      udmabuf: emit one sg entry per pinned folio
      selftests/net: ncdevmem: add -b option to set rx-buf-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

 Documentation/netlink/specs/netdev.yaml            |  8 +++
 drivers/dma-buf/udmabuf.c                          | 52 +++++++++++++++++--
 include/uapi/linux/netdev.h                        |  1 +
 net/core/devmem.c                                  | 51 +++++++++++--------
 net/core/devmem.h                                  | 13 +++--
 net/core/netdev-genl-gen.c                         |  5 +-
 net/core/netdev-genl.c                             | 19 ++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/config      |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 12 ++++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 58 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 36 ++++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 +++-
 13 files changed, 225 insertions(+), 43 deletions(-)
---
base-commit: 518d8d0199538a4d6d5e51064044ece71e0c42e7
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

