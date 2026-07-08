Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7073C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25B110F3E6;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iz4BTnZs";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55CC10E374
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:55:14 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6a183eb9689so714949eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 15:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783551314; x=1784156114; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EzUjmP9XIEW9/Nh3Po0jQynHplRQUkqS1YMrmb8xU7M=;
 b=iz4BTnZsPwVS1cRa7ZV1HyGqg7QjtlvaxYDwNP8udD1PMsTLV8JdU+Guzep9bQyovk
 Nj0r46UEjR6ziIr5HKnWWG/Dv9WHWK3dhpFZXzCXey3GprF2Bv6N+ud7ENy9je5WkFPQ
 wqR3wlSNnB00v+2sCBQg7YfNxj8doZ3NxlzfMvmWBvCaBTYLki2TZqiGf7HbQ2qsGpl8
 CHpQqhayFpbecvomAC+yIkyxSsbG1wql4Ci61JffpuMW7S00P1gUd+iigGnFMWA56/c1
 6l3614iP0tizexiYJLQO2L2nNSHUoF8lh8UQoxEJ4b54iT5hVmh498TAD+ZhGjAA5ed3
 Ln3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783551314; x=1784156114;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EzUjmP9XIEW9/Nh3Po0jQynHplRQUkqS1YMrmb8xU7M=;
 b=F0QhzmnITP8J3xFylQY1t9FFti27E/i6dJTRAOK7zvRePnQhYo+g80ciZOZzLrpeP4
 sEYyZ7PCypgHKq5ErixS+UdAaah2okr803Oxx7QPAtr5fnkmKET2A+4lVHpNrjwwajq0
 O7W8qvbgdsWzcvqtsGmDPh5+kQpiRRHAhvGYF4RFBpHqHJB7LK/9lhkDMl1FzOyEEVAY
 CHRZ+9lHFRTFSB6u4m0Sj8+tN6EYeujRdMnADgJJHzI3m8OsI1PyvjBqkgDGnZF09/MC
 9gE3EetrFr3+r54jaKNG0arabcvVHIx9SAGZCsPDC11TBg9CMzxgmje1A4rmwBpzIXev
 ukDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KD8GSLiW5C12JzdaaFryFgU5abtKLzo+I6FYwYmDSCzH3Q158CgQxwRGaBH1HtTaUB7ifPihmCC0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywnqzwq7WM2rTx9WkweLUgPTCI1BSvK9ynM0ep31b8nX6KCgkP2
 Hze0GB+KgZfU3zEXj0Xf7tPv4HHqiErKhdFOaWFIPIuqvmpSL8nEQ5VL
X-Gm-Gg: AfdE7cmL6tD5cN4re+vuSKUHhZWpOKlVpurBa5UlcU9oS8rx4iuhkzLf1lkSqXo/wlY
 tBwJvtXNz8EBI9FTgtu/0A4d44LTKpiEGxU6Mksc8Guy7Byz5pQnMThvzI5dlxEXeQSTd5jDt/q
 XVyJdIf0xD0ZAj03IsdAcF4T5ykwnQ62KEG9Fg1wUWm1ZJe1PirP6zQozEtc7ywzqry77P4f0EV
 Pk2VlC/E6m94wudsZiZJTIUK2UpM1khCAdoxbe9MfzHuQBohOiazv5VXrx032RCh99xNOstd7Kl
 W81dJvw3M60N7xZwJZt+DOlCZCjqKdGkb3P4GL9H1jo8w7+/hP+8gKeZTchfK/D865C6If2oeCt
 YsCuTHBP1DkAvz2hOcV1+sDgO7OWRnRCtDMn4+JYWEdVrTUj1sU/kNhjVU82NPIZeAdW2YnKPCV
 /OKTgSfz8=
X-Received: by 2002:a05:6820:80cb:b0:6a3:89f:62b1 with SMTP id
 006d021491bc7-6a36d9c95cfmr3040744eaf.31.1783551313607; 
 Wed, 08 Jul 2026 15:55:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a83eb2dsm2784367eaf.10.2026.07.08.15.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:55:12 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v5 0/3] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Wed, 08 Jul 2026 15:55:03 -0700
Message-Id: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEjVTmoC/23PzWrDMBAE4FcRe/aW1T/1qe9RepCVVSKo7SAJk
 RL87gVTqAk+D3wz84TKJXOFUTyhcM81rwuMwg4C4i0sV8Z8gVGAIuXIkcIW75cZv0O5Mi557RW
 ts0oHHSR5D4OAe+GUH7v5CQs3XPjR4GsQcMu1reVnL+tyz/9cfeJ2iYRJ+2BCdF65+DFzC29xn
 XesqwMg5RmgkJBZTUla9lbpF0AfgbNnXSNh0JN71+xditMLYP4BT6cLDBLGYJw1SXvr6QBs2/Y
 L/1iW2n4BAAA=
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
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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
NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov
size (power of two >= PAGE_SIZE). Drivers must opt in via
queue_mgmt_ops.QCFG_RX_PAGE_SIZE.

Measurements:

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
Changes in v5:
- removed unnecessary change from ssize_t to size_t (Mina)
- removed '--------' lines in the commit message (Paolo)
- removed commit msg about CONFIG_HUGETLB since that change was already
  merged
- Link to v4: https://lore.kernel.org/r/20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com

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
 net/core/devmem.c                                  | 51 +++++++++++--------
 net/core/devmem.h                                  | 13 +++--
 net/core/netdev-genl-gen.c                         |  5 +-
 net/core/netdev-genl.c                             | 19 ++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 12 ++++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 59 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 36 +++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 11 +++-
 11 files changed, 178 insertions(+), 38 deletions(-)
---
base-commit: 474cff6868129755cf889edf40d7f491729fc588
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

