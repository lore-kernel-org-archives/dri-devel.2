Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3524FC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6201E10E24F;
	Fri, 24 Jul 2026 21:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rnWIVJUP";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E1510E24F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:21:44 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so940477b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784928103; x=1785532903; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FQ2nZV4mae9urUpcNtLvt+1onS2Wo4KozDXQHkgV0sw=;
 b=rnWIVJUPPDIFcBS151rLve9JgMrt1cAnxeBNmtLEt8nLvieBqypKMsZVJalb5QHvDI
 3vJGqm999lRgEEZCg3MeLpDwDcMLQsYS3BcpngEbpGt5ih9morMiy6raBprjoekNpGyq
 P0D8zJq6o+pouBRpaErb+oDWbkgFQdKBP2i+EctHMM7wLVclOfXqGVgEERBm8QBUyCNe
 QhAwKMG6JPMz3CFSgHxEzZNnTp5ybRe/GSFcJqZJ1ycz0FSdv/qJbF9PMDuZ58ztw339
 fstQUXsxnOmBAazSdNNhmDBczcDmpnU4qCTca5KE5N4Dkv2NdcXHoBJ4c1+Ze1h8rU+8
 Gz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784928103; x=1785532903;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FQ2nZV4mae9urUpcNtLvt+1onS2Wo4KozDXQHkgV0sw=;
 b=sshm8VCFdKDDXmt3AUd3regWFP6lGY8LYO9lk+1xy5wliXBvE9KdkAPHZyaUf4bpBr
 6LNZEaISCrHPoV/6QMw8ebEFjfelSQ66iI+jBIqx/f2bDwC9ECpS3gABiyYczrGAQaSH
 nSa003ruYEPULFn8LXOL2Us3jo02egRA9s6bcRsOAymza3fZcxkCD3EAVZeiINHi+vBc
 fnneXoepW2tUXdybdOjKpaszK2v/13q7h5ZVsxoGWjbpO2pgv769tstvN/80d8ZqeowI
 BZHvII9YHvaF0BcxIgrPLAQaF2qIQYPQtu7ItER4QTzfcF2wZ+t13JoCLooS1CqR9FeR
 AFSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKa43+5g+39LesJwQ5WuiDsILpdpaem1cJIVSW8Eld2oy4QDPLqGVzChoXz13s3W73E6aEHG3GCUo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5dUZDEWYNQh1/H/jH/wkupFZOMd4Zooat8raZwl1SoRQno3FG
 zVMQbMF/SF64QsjBAA2wHqxBEMW6hBgLkaCXUvKwLHn+fFkK84cy1ztv
X-Gm-Gg: AR+sD13zIu+eIJ4vmUYjqDnd/J34xs59nG9jdgRuCAu3BrS+cxbeoD3nQYhcA9TotHM
 Wf1SW8WbMgGmu60PxhM6A2zg0PSfoJlsOYZzFo4/IKzPOykeYQ25Mr2KHGePqsz76bVGsz8RHmr
 WKRpRH6fc/l+NZ/rvFoNS85SF3id7stO5PXq0/5PJHVkhe/prxKZKcV+vmGFyhqiAd+lwYf03vd
 xkJTCpkxwV3T6c2eq8liGCQWxjwWehxBYRNDYOtQtEIVzU19q7QKlEeFAnGpbc8HxZO2OeO8BZs
 Oqha46FEC7BBr3mB58/tsRaCcmY16tQH2k5RCQ11VY6ADBaYYwKuarLJYD7H+D5RpDBIW3q4i4o
 VkXIWF/G0zuAhdVZxfnJ+gtVVvMKr8rDpLCF92HvyPzksYZtJV0tQ7FZ1vsQFXVDqViMcgh/ZIF
 Mi2CQqQWyhOZKBDOrEQ2z5rRuK81wiDVmpPwU1qf4H6baKERcJgfFQUB8=
X-Received: by 2002:a05:6a00:4213:b0:84c:241e:9070 with SMTP id
 d2e1a72fcca58-84e4e915478mr1649451b3a.17.1784928103363; 
 Fri, 24 Jul 2026 14:21:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5327f7cesm453963b3a.18.2026.07.24.14.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:21:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v6 0/3] net: devmem: allow rx-buf-size > PAGE_SIZE
 per binding
Date: Fri, 24 Jul 2026 14:21:14 -0700
Message-Id: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErXY2oC/23PzWrDMBAE4FcRe/aWlVY/jU99j9KDrKwSQW0H2
 4iU4HcvmEKN8Xngm5kXzDIVmaFVL5iklrmMA7TKNwrSPQ43wXKFVoEh48mTwSU9rj1+x+kmOJS
 xzui8Mxw5agoBGgWPSXJ5buYnDLLgIM8FvhoF9zIv4/SzlVW95X8un7hVI2HmEG1MPhifPnpZ4
 lsa+w2rZgdofQYYJBQxXdZOgjN8AHgPnD2rjISRO39hCT6n7gDYfyDQ6QKLhCla72zm4AIdALc
 H3s8Ah4Rsu+xzTBer9wvWdf0F0DtiCr8BAAA=
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

 Documentation/netlink/specs/netdev.yaml            | 17 +++++++
 include/uapi/linux/netdev.h                        |  1 +
 net/core/devmem.c                                  | 49 ++++++++++--------
 net/core/devmem.h                                  | 13 +++--
 net/core/netdev-genl-gen.c                         | 11 +++-
 net/core/netdev-genl-gen.h                         |  1 +
 net/core/netdev-genl.c                             | 18 ++++++-
 tools/include/uapi/linux/netdev.h                  |  1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   | 11 +++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 59 +++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  | 36 +++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 10 +++-
 12 files changed, 190 insertions(+), 37 deletions(-)
---
base-commit: 89d8006259b81dd25c962f6cc8d7ab268d6ea426
change-id: 20260602-tcpdm-large-niovs-56523a3a1077

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

