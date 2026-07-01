Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BF9C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F5610F1E0;
	Thu,  2 Jul 2026 07:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YlDiWRNm";
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A2C10E20F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 19:22:33 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-6a190528769so445823eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782933753; x=1783538553; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RTaa1f3vcFQz1JXAdbVo3mJ6YMjKrRzWYP+nH66vQBE=;
 b=YlDiWRNmF6g02HnGxlxb47Nd487x2UKLhyNJIG+AIWX5wdTiEXqviygraDIP+z5AGw
 nIsHOz4kKYLwR2JxqutiPPtJWnUUcEZdrB07/1Vc745QnmHmKmTlpIQpJIF2icgVgr6S
 IQafxuRNZAJbJgv/nTb9E1fK8mJIIffnDA81FQmTDgZHzE/oB8T5liRLYSlrssdqSJzf
 Zm5P9CKat1afLI9w0p2dkuaL69nqYOISOw6idS4gwfT+8nPVqZb4cSRj+xmvkKjOHS/h
 4hxcjcfHzEniNxXXQRufivIVwrCJtfsXxshyMXiUH6TJBF8SdqA8G+Fd6vrg19fTYA0F
 gXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782933753; x=1783538553;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTaa1f3vcFQz1JXAdbVo3mJ6YMjKrRzWYP+nH66vQBE=;
 b=DE8jHp7pNg6B3bIYl9vPQa6aYy1Oh0234C2s4xXw5g/8tohU/IxKxN9I4q64RDPoF2
 rPuaH+79gvwJI9oA1ki0+iMbJN6ofKOXrq18F3Mfu95fj7xHanpOlIpGzJ9C5ZSlk71f
 LnPVAy3mL8htGffzc3q68g5/k260SWzzbgHBIuquJ/wvNv11+yapjqcv//0xbQ6vjuHU
 KFsExFxsB+KZAeRwLmPQz/RTn5GyprBdeBYaWSmE0oDvTwJK9qGuBuGNyYpS4NfhsW4/
 4ef8+OOuJEaNYwjLpNlgPm3xo/H5dcqoBUjyucg4waypfAus0QhG4/nzBYdZ+l+nBpgR
 D2wQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4VGFEMxHFMAjYzhXNdRItRmFj+mwD4mxAUoO0+SaJ0KDaN+ayAeJMmRXbLgmaPYybvkETg/TXhiU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUUwty/IG+XRRox6b42r2+Jlx21teC18z75OethdFazHEvcb0V
 Vo2Nb9O3ApCiXEbikA2G6lmV/YEl85S3YDSkpNtUz5sTGA2tKJGAEmV7
X-Gm-Gg: AfdE7ck7hIBm9ddJIzk+JAJehlujIAQ1lpqcOv2hv4oQY37oq/KcgxzlPs39dQP1EOU
 fcXx6YiCv0uBUMu+V1qeTyYNUa/l69D0eoSTjDglcyC8iE5FvU9vaQlxTtJWY1xzH67JoRCJjvL
 iOgohOenIOesz16XmkVzohH1CZqlJmYKLyZRF7xny9s58UqI0oQx/tNjDLHKa/sSg63sT7WNWJ5
 8cmli9R0hEz5nuFxuFsEqGRh2+o65a5u22hrsgSGyxVVW+yDn/fGq8/4bdsY+v0/lz2KuNAoGBx
 SrSD+LetkIzsk6+GSy+WYsnJJnWnAyHW940fjEIC8uilg85nIfnJLsw0m6wxo/DH8KpxFSrGblG
 QLQZQu7saDhRtTV85Djf4FuaL0NsKW0iXr8u9W3OMwIgM6NsFNKUnsQUQsSKAWAYwQsY5LyyMv3
 OrBp8b0ujmmWpNyKYn8bQ=
X-Received: by 2002:a4a:e904:0:b0:6a1:50e7:5c1c with SMTP id
 006d021491bc7-6a309be5591mr1545058eaf.71.1782933752754; 
 Wed, 01 Jul 2026 12:22:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103cddefsm608995eaf.13.2026.07.01.12.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:22:32 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v4 0/3] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Wed, 01 Jul 2026 12:22:23 -0700
Message-Id: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPBoRWoC/23PQWrDMBCF4auIWXuCNBNLxKveo3QhK+NEEMtBE
 iIl+O4F04UJXj/4Hv8biuQoBQb1hiwtlrgkGNS5UxDuPt0E4xUGBaTJaqsJa3heZ3z4fBNMcWk
 Fe9sTe/ZGOwedgmeWKb428xuSVEzyqvDTKbjHUpf8u501s+3/Lh+4zaDGiZ0/+2Ad2fA1S/Wns
 Mwb1mgHGHMEEGoUoXEyvbie+APgPXBU1hg1eh7thcXZKYw7YF3XP7v7NSI9AQAA
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
 dw@davidwei.uk, Joe Damato <joe@dama.to>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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
Changes in v4:
- ncdevmem: fix the possible overflow in ncdevmem (Sashiko)
- drop the udmabuf patch because the fix is now already in net-next
- silenced two pylint complaints in devmem_lib.py
- Link to v3: https://lore.kernel.org/r/20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com

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
Bobby Eshleman (3):
      net: devmem: allow rx-buf-size > PAGE_SIZE per dmabuf binding
      selftests/net: ncdevmem: add -b option to set rx-buf-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

 Documentation/netlink/specs/netdev.yaml            |  8 +++
 include/uapi/linux/netdev.h                        |  1 +
 net/core/devmem.c                                  | 55 +++++++++++---------
 net/core/devmem.h                                  | 13 +++--
 net/core/netdev-genl-gen.c                         |  5 +-
 net/core/netdev-genl.c                             | 19 ++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 12 ++++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 59 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 36 +++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 +++-
 11 files changed, 180 insertions(+), 40 deletions(-)
---
base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

