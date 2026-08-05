Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BAFC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B41110EFE7;
	Wed,  5 Aug 2026 20:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fht1ROQN";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABEA310EFE7
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:43:03 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1514570a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785962583; x=1786567383; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DpTVg5k1UqbxUwZhAR5hTStxErbqbArg2pH84IY9Ob0=;
 b=Fht1ROQNQjXEdkxnRjYUGHspMGQz9SGhDDEidZZVVmJpRUCEPTeT9Hl0y1JYBoL8Ty
 X+Vh/2TeuEHPUH06eVgRG/H3hA+ViGE+YdSVAp+S0F9jKM4Tp9aJCH+AZpBoVuSmmy1H
 Geftle/AP4hCK3v49A8WMgfIgIOydbPMKtNcr55LeTq9ifuf8Smq9rqak3MPwSAI6ThZ
 +K9Ue6qHMoEjIef74ItrFb/sDp9ZSAAPZC2rQCxYQw13R/FBiEeYUTyiF1HeaYw9H3yz
 QdFWyYiNH5zyGVELeIZEzrTC8S8nPal5RogQTZHKRBsTt9FgQbqr4rT7wnZ79LcZd3PV
 f0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785962583; x=1786567383;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DpTVg5k1UqbxUwZhAR5hTStxErbqbArg2pH84IY9Ob0=;
 b=MJpN70Jb/haKc+LEScmiqm/SmjIEqBgJjFPx/4gJQGr8LWRCBMIXfYVvGaFyiUoL9T
 1bVmYkr7evuVmd6o3I3Db1V2es+WgPayBz1r0SpRAy9G/OgaACPBOgY2jMP5PaCuAL8U
 /uCO5qqUQGMZvaV4XS4b6tMn23wmqWCN60bOPPiiINOiX5heacxL7WXpQzomZ3HpwZ1G
 rT1nMsxzG00+8f5m+dECyCANA2zQWMAFC3af5Nq9o/Xjetxzp4FuIKEuvYiPJu0+b33r
 Li421No2w9rS5igv0uYpyUJbs6DQ9P544yGL9cszgOeAlMzj7zLJLFjPkvGuvK0DRmhf
 TxBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRchQym9NWTFUY+mnpMf1P96CxHjs72GOBNMAUl+/jOykYVkSevJ3lO3sghs+9ORbaWuhnRT6KEOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrwOGNQZMN23gSIBtkrRSupXF/jiQaeawG/HS7ySmVixIdTcR3
 A4SYYBxFuZ+vACmkdm6bBMW2TdEmQwvZjIZEA1LSPnxPV+EgHqRgqnZ7
X-Gm-Gg: AR+sD10/8s8OpqO79+9aII6YVEc+HhwMQoS3zgWEo/DtNDAcDE00FXoKo7QR8nYdHyK
 t0Et0zUQqCyCFnmxUf7Hi0HP3SuM30+wkwbO6Cu4T5qw/eQncwfvk613jQYn0UC51KAr66h6R9s
 6VB3/ylW4EiKqUUV1mVqQWp2fU25aLiRtaYwlfy/w00yMwf7Q2cpX8/bjj4B9ofSq5eQb2wjx7w
 vpbiq62vfNXrOhd5ptKqjJR1umvY0+9UmiOl0u4ZJxMm1ojE+qGYsH7xDWTZiDyv8BgLeBRVCG4
 mzrRTiTGndUFYokLDBhY9Be9tymRUP8NClXJrCRqdm5+df+0p1hz3EKVET9aOZdWOMcYQRxhN7i
 nLanvkJDr7//NYaAsZuKNeyXTfwMv1JT/lCQtp+etg2R2ES9AD6v7awfAbf0Bn8me16pOpZhr9o
 tzNrBnrV5FFRqercRdL2OuUnYkaA2YTGT+tWSUZS8diqs/D27OgohOFcY=
X-Received: by 2002:a17:90b:48c9:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-3903c58f06fmr9665499a91.13.1785962583051; 
 Wed, 05 Aug 2026 13:43:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085dbe349sm165165a91.4.2026.08.05.13.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 13:43:02 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v8 0/3] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Wed, 05 Aug 2026 13:42:42 -0700
Message-Id: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKgc2oC/23PwWrDMBAE0F8xOmfLSivtxjn1P0oPsrxKBY0db
 GNSQv69YAo1RueBNzNPM+tUdDaX5mkmXctcxsFcmvOpMekrDleF0ptLYxw6RkYHS7r3N/iO01V
 hKOM6Q+DgKFK0KGJOjblPmstjMz/MoAsM+ljM56kxX2VexulnK1vtlv+5VHFXCwiZJPqYWByn9
 5su8S2Ntw1b3Q6wtgY4QFB1XbZBJTg6ALQHas9WAoRIHbekwjl1B8D/A4LVBR4QUvQcfCYJggc
 g7IFzDQiAQL7LnGNqvT0u4B3gfA1gQJBWQmaX+twdAdkBhDVAAAGJ+nDGyLbtd8Dr9foF5Orx/
 0ECAAA=
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
Changes in v8:
- Remove niov_shift usage from TX paths instead of hard-coding to
  PAGE_SIZE, since it is really only used for RX. This also avoids the
  tx_vec OOB reported by Sashiko (Sashiko).
- Change selftests to pre-probe devmem support for all tested rx page
  sizes and cache the result. This prevents failing the large niov test
  in nk_devmem.py where the leased queue would land in the
  queue range of ncdevmem, causing a devmem probe failure because the
  phys queue and leased queue do not share a dma dev. (Sashiko)
- Link to v7: https://lore.kernel.org/r/20260730-tcpdm-large-niovs-v7-0-033d580a619d@meta.com

Changes in v7:
- require_devmem() skips if rx_page_size multiple of PAGE_SIZE
- fix long line in yaml (Jakub)
- Link to v6: https://lore.kernel.org/r/20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com

Changes in v6:
- Rename rx-buf-size to rx-page-size (Jakub)
- Move the >= PAGE_SIZE check into the netlink policy; doit only checks
  is_power_of_2() (Jakub)
- Drop @ksft_disruptive from check_rx_large_niov() (Jakub)
- Link to v5: https://lore.kernel.org/r/20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com

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
      net: devmem: allow rx-page-size > PAGE_SIZE per dmabuf binding
      selftests/net: ncdevmem: add -b option to set rx-page-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

 Documentation/netlink/specs/netdev.yaml            |  19 ++++
 include/uapi/linux/netdev.h                        |   1 +
 net/core/devmem.c                                  |  37 ++++---
 net/core/devmem.h                                  |  13 ++-
 net/core/netdev-genl-gen.c                         |  11 ++-
 net/core/netdev-genl-gen.h                         |   1 +
 net/core/netdev-genl.c                             |  18 +++-
 tools/include/uapi/linux/netdev.h                  |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |  11 ++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 109 +++++++++++++++++++--
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  36 ++++++-
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |  10 +-
 12 files changed, 230 insertions(+), 37 deletions(-)
---
base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

