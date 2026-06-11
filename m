Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BE0CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF03310F2DD;
	Fri, 12 Jun 2026 07:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HXGsyPY0";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3767F10E827
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:17:17 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c8587427468so3333915a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781194637; x=1781799437; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=og57coQD3NKK4AOSZLfMT1CyFR6j8/1DFkBGKs1z5do=;
 b=HXGsyPY0YVbrNylEuLroGDdB8TSTkxiEMG0Ut4+sF5hHC5hc2qUgt90ltc4U8OxbJR
 u+GFQVR+1yN0NT7rmx3wAVsE4zZUNhE5ggz28w/4SVZdn8BcQbfbPUjLFzdAR2WlpV5L
 ANRgwR9D5LW1MGcXd+O5zbISqMzym8LIvmJuOup1EfvutgyxJUDiyXf060Wop5YMHTXl
 P64j34UAi+F9gKEraMS3nP9LO+XhA0aF7MtQhqYuZhVMBVKMfn8NIKhfLWjlH8Rwq/Uc
 jBxKs4PkOllwz88SdkKOorQ2TqltOZ3It2SJ4lWkSd8npgNgQMZVC9X9TtAh5LOT+xSv
 nbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194637; x=1781799437;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=og57coQD3NKK4AOSZLfMT1CyFR6j8/1DFkBGKs1z5do=;
 b=QThQ157boW9dE5q57IlPvO52CXjSjdnnBQqiNtiUSHwQdqt1NIi5akmunjkOUr/TaK
 P1FgsFtsuGxVQ7m1pmDLdxI7yhL7an2Ct3wC6EHKptk/KQ0cebHt1ccLwK2Mgk0IpE8x
 x4VqKSrrI3/UoAJ/UHeS/+8G+gFSjrMO7Fe0Ym8Xi6zqpkFutvQwTwn2vQbk0aSxG+NR
 2AvVJwNVBTOhb7mIx9YZgUZ3xQsm8paNFBnrxENQ/b80lIdnn4Ovi/tOZg7rKMZrVcBL
 I8iUllIyq3S+NKacMvEV6Iikz7VG0MyIG0DiqznXQQ7on2TSxNJwLBJjUwsLcPf1hf+Q
 jvVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m8250GIKduZke5fH5ifltsQnn53T091QcIQ21EpNnQjNxaL/WDif8zpqO+4dyhVjd6w9C7/hxOkk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7JHsdanVyx7g60UDd4DGepYDI4guq9GAatv3ioDH7yNMcY0A4
 5fZkmhFmeZhyuUAJz7dJE5whaAzlR+2qcAZrCEYvJt3E9XS/2RCjF1l9
X-Gm-Gg: Acq92OEZ963i4fNF6ynwiwX7LwWrJiSHK3RXgKAjbMCfk22ZdaS39OSRkkl6B94IEr0
 61LQwQ2tyo8waRn1JpDVdYVF52mJAsKzBEyHdieaRQDm4AaipGcC1JzrBbVpvo/hWkhhc9B7cUq
 oXdIV6S5uUAcE1oeF+2lrZNfh213jktROY+PBjXAHMz1DAglgLxwrk6WU8BgAAkMDSI7ge9iZep
 JbsZql3MTnw6N0xKioFJoVcHdy9pX0A/NAYNuDb+Oc5M6QAcMPWr7gdakUCtvXSkShGOIujwUhj
 tZShG03/ckdn4UBuZKgA4ag+NdNgjtijqCJ7j8FEbzbzvvY2bRQDBt/p0Q9mjfZOAuig69jWvws
 97n0s3lyymvkZzstAbflke82MBEcC9eeOlsGVppOzhXzuhqqDwTqrf66pjXw5rfkS9jXM+HXGPL
 a9dPiCQaWadUP94zn9R3Q=
X-Received: by 2002:a05:6a20:cc8e:b0:3aa:f9cb:d438 with SMTP id
 adf61e73a8af0-3b5e32c48ccmr4294917637.21.1781194636389; 
 Thu, 11 Jun 2026 09:17:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c865880a1aasm2190461a12.22.2026.06.11.09.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:17:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/4] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Thu, 11 Jun 2026 08:28:41 -0700
Message-Id: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrUKmoC/23NQQqDMBBA0auEWTslJjUBV72HuAhx1IGaSBKCR
 bx7Qbrs+sP7J2RKTBl6cUKiypljgF6oRoBfXVgIeYJegJLKSCMVFr9PG75dWggDx5qxM53STrt
 WWguNgD3RzMdtDhCoYKCjwNgIWDmXmD73rLZ3/7n6j1tblDhr657OG6uMf21U3MPHDcbrur7y/
 TtwuwAAAA==
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
X-Mailman-Approved-At: Fri, 12 Jun 2026 07:45:54 +0000
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
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 49 ++++++++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 +++-
 13 files changed, 238 insertions(+), 43 deletions(-)
---
base-commit: 518d8d0199538a4d6d5e51064044ece71e0c42e7
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

