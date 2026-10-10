Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D6CCA9EBD
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0577610EB76;
	Sat, 10 Oct 2026 02:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VDsGhyso";
	dkim-atps=neutral
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFFD10EB71
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:55:39 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso1160251eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791600938; x=1792205738;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0d9kx5oWqQ1CybegjOdsNGS+P/geGKBslG4tLGyxeVI=;
 b=VDsGhysobrm4kqizJHXVJQdDKPfUKMy8ttvi6N1XOAKgeOS25PXqgK/LWWQsYB4MTZ
 4qcf0WCo2c5teGJ9kD4aNLA9b7vEkaNCZ4R6Fy+KTC26Ciik0ao8aFYMzkQ20RkULfj+
 aqvmGnT3qGAv1t+4k6v4jbm7vszVxA2w6mtD4rvBytWovp9BPbyLbBUVc5URlRd3a3ja
 5zBFwG6SdtZoeJb/cfFLfY49/8oqXKFqLP2U1U7fiRofUdxA7QQMWAzjF/d+zMqDvT7W
 Y89WqFMreSHCuvpsPU8Wr2ujDHD21lzglLb8yvD+FV35OanFiccaN5jzyH0deTMKamkr
 78AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791600938; x=1792205738;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0d9kx5oWqQ1CybegjOdsNGS+P/geGKBslG4tLGyxeVI=;
 b=VKBfr2Ja3Sr2Pizar5m5HNsCaj9ATa97/hDDoeW5iOnroMRQZUjIkzcCaOqFam1Kox
 XOYINLt6if/dufyU0PMi5sWmSimq9XahJb4qgm6bXblE5o0i3lpzSO65dygqHPKA2MZS
 osHKgNvWOhwicZYzswzwcLr7EAC6gr5kvkG3hN32uVgC5meK7dVMa78AUIZ02ex19kWr
 wgwiWskLSx+G3IPxBZLKfE2t1qP0Fyqm8Bes51OArLuGIrd0RyRw9bI3wsSaewnI/SIP
 lwU1Ia9BETb8nmfQ1EO/Fh/HKgmVO3pQiWActRoyU8CXFN+MPB+5LTcGS4ucg3Nam1lV
 u77w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlUgD65FA4HFQU5Oy0mQRmoLObiRG1TVKqNCjwjk6Y50qAvHMu36wgNIOJXE5quRUcXyghiBbi2GI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJNPpix0RtB2RXjF5+4WfaOy30bex+FsX6ZNVf+0H+E5RTICQpk
 tfM/4bR4y8HrB9LiEE+Y0z/DPRX1GIm7HGJKV7WmaH2aDg24aM0QbYOWt152Ku6+C25pP0OP5rA
 qOV+M+leNS7k4H0OagkakBVTUIg==
X-Received: from dyvj1-n2.prod.google.com
 ([2002:a05:693c:87c1:20b0:355:5354:7d27])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:895a:20b0:351:f762:a10c with SMTP id
 5a478bee46e88-3537dc3ca81mr5067199eec.0.1791600937866; 
 Fri, 09 Oct 2026 19:55:37 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:55:16 +0000
In-Reply-To: <20261010025532.839559-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261010025532.839559-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010025532.839559-5-almasrymina@google.com>
Subject: [PATCH net v1 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
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

Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
to nl_netdev.py to verify that unregistering a netdevsim device while a
netlink socket holds an active RX or TX devmem binding synchronously
detaches the dma_buf attachment and cleanly closes the netlink socket
without use-after-free or page faults.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/net/nl_netdev.py | 108 ++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index ceb44c8e1fec5..bad230ee9dcd2 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -6,10 +6,14 @@ Tests for the netdev netlink family.
 """
 
 import errno
+import fcntl
+import mmap
+import os
+import struct
 from os import system
-from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_run, ksft_exit, KsftSkipEx
 from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_raises, ksft_busy_wait
-from lib.py import NetdevFamily, NetdevSimDev, NlError, defer, ip
+from lib.py import EthtoolFamily, NetdevFamily, NetdevSimDev, NlError, defer, ip
 
 
 def empty_check(nf) -> None:
@@ -366,6 +370,102 @@ def page_pool_stats_ifindex_check(nf) -> None:
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.info.id')
 
 
+def _create_udmabuf(num_pages=64) -> int:
+    """Create a sealed memfd-backed udmabuf fd for devmem tests."""
+    if not os.path.exists("/dev/udmabuf"):
+        raise KsftSkipEx("/dev/udmabuf is not available")
+
+    size = num_pages * mmap.PAGESIZE
+    memfd = os.memfd_create("devmem-ksft", os.MFD_ALLOW_SEALING)
+    os.ftruncate(memfd, size)
+    fcntl.fcntl(memfd, 1033, 0x0002)  # F_ADD_SEALS, F_SEAL_SHRINK
+    devfd = os.open("/dev/udmabuf", os.O_RDWR)
+    req = bytearray(struct.pack("IIQQ", memfd, 0, 0, size))
+    dmabuf_fd = fcntl.ioctl(devfd, 0x40187542, req)  # UDMABUF_CREATE
+    os.close(devfd)
+    os.close(memfd)
+    return dmabuf_fd
+
+
+def _dmabuf_attached_devs():
+    """Return attached device names from debugfs dma_buf/bufinfo if available."""
+    path = "/sys/kernel/debug/dma_buf/bufinfo"
+    if not os.path.exists(path):
+        return None
+    with open(path, "r", encoding="utf-8") as f:
+        text = f.read()
+    attached = []
+    in_attached = False
+    for line in text.splitlines():
+        if line.strip() == "Attached Devices:":
+            in_attached = True
+            continue
+        if in_attached:
+            if line.startswith("\t") and line.strip():
+                attached.append(line.strip())
+            else:
+                in_attached = False
+    return attached
+
+
+def devmem_bind_rx_unregister_check(_nf) -> None:
+    """Verify RX devmem bindings detach dma_buf synchronously on netdev unregister."""
+    dmabuf_fd = _create_udmabuf()
+    nf_priv = NetdevFamily()
+    ef = EthtoolFamily()
+    nsimdev = NetdevSimDev(queue_count=2)
+    nsim = nsimdev.nsims[0]
+
+    ip(f"link set dev {nsim.ifname} up")
+    ef.rings_set({"header": {"dev-index": nsim.ifindex},
+                  "tcp-data-split": "enabled"})
+    nf_priv.bind_rx({
+        "ifindex": nsim.ifindex,
+        "fd": dmabuf_fd,
+        "queues": [{"id": 1, "type": "rx"}],
+    })
+
+    attached = _dmabuf_attached_devs()
+    if attached is not None:
+        ksft_ge(len(attached), 1)
+
+    nsimdev.remove()
+
+    attached = _dmabuf_attached_devs()
+    if attached is not None:
+        ksft_eq(len(attached), 0)
+
+    del nf_priv
+    os.close(dmabuf_fd)
+
+
+def devmem_bind_tx_unregister_check(_nf) -> None:
+    """Verify TX devmem bindings detach cleanly on netdev unregister without UAF."""
+    dmabuf_fd = _create_udmabuf()
+    nf_priv = NetdevFamily()
+    nsimdev = NetdevSimDev(queue_count=2)
+    nsim = nsimdev.nsims[0]
+
+    ip(f"link set dev {nsim.ifname} up")
+    nf_priv.bind_tx({
+        "ifindex": nsim.ifindex,
+        "fd": dmabuf_fd,
+    })
+
+    attached = _dmabuf_attached_devs()
+    if attached is not None:
+        ksft_ge(len(attached), 1)
+
+    nsimdev.remove()
+
+    attached = _dmabuf_attached_devs()
+    if attached is not None:
+        ksft_eq(len(attached), 0)
+
+    del nf_priv
+    os.close(dmabuf_fd)
+
+
 def main() -> None:
     """ Ksft boiler plate main """
     nf = NetdevFamily()
@@ -379,7 +479,9 @@ def main() -> None:
               page_pool_check,
               page_pool_dump_ifindex,
               page_pool_ifindex_leak_check,
-              page_pool_stats_ifindex_check
+              page_pool_stats_ifindex_check,
+              devmem_bind_rx_unregister_check,
+              devmem_bind_tx_unregister_check
               ],
              args=(nf, ))
     ksft_exit()
-- 
2.56.0.385.gd3acb90ef8-goog

