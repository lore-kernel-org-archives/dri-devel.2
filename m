Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD2BC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F81110F107;
	Fri, 31 Jul 2026 00:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SRkiIFfD";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4BD10E176
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 00:32:55 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so342092a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785457974; x=1786062774; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/lVRsPFiIdtPB9DslbLIhlupoyA5riRltCZqTzlKbSk=;
 b=SRkiIFfD7ktNkUH+1YF9zz5AO90J7M8NIUyTwFK3evAP7WE0J0fuQUa2DKKFPeUs0y
 sSrkiJ95Hdn96/SYvB7QbrpUZsHgY6MmJHDbCfLrFYXoG/PlLK21NXi19zA+xVEOUppL
 gQLs4+vokBOgtixgMQIUgPbTFvAKz2TOhnk/DCm9EpRqzmw6OoVNKUWJ4dtvmKR7toK+
 jvEmXnGD4azCU3363TTL93Q3kNgE7hZmE1cuguwCt2WGVF0JRkoJJSGsdZTeb6FgjNAr
 /IgwT3We+7pwPy/nQS3Bje0fZkrFRdm/289Q9hbT7pvQfcG2X+Sa/HbA5UF6wp298UpN
 RJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785457974; x=1786062774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/lVRsPFiIdtPB9DslbLIhlupoyA5riRltCZqTzlKbSk=;
 b=Ad/8GvkPUuxAYMqs3dP85vLX1mvTo93DdNMzvqsy2nAMtyicuBdzTuH/M+hbVc6WFx
 xV8AM+VRkSCamRggKWxJqZgFQVJRc4WMUGM+hjHnW4o9riXKxAVwbAXbxEkkn5v2jQsi
 brB4WcPP6N8kJQtL9IgvdebgFEKxER8401xEnPVLZmEf5am4b+Ct4yD1qhrCINxI5n3s
 vMy72eH/PUb/JPBhMBbmnW2BRvArEpC4PwAx2dN3rHGvPfLhHDS4Z6sDPP0Gek/Iy1oK
 /YFmm1LLA1eylpGLygGJojtqWxwDX4neovyF8slRUhjJRPcaQcnnxcldisG69JihHg63
 MI9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpjx/lpl/KRg5QSaTBZH4/Ws6cTpdAOp5QLWNq1G7nAtmdSXQ0JSfZZMt3eJwVG4dBCK6Uil1X3mZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz35LCezXAC9R8Uo1erk0s9z/aXDCe0fszcTTgmklpmZc0RJKzt
 tRfK4diHwX1ZarGtxB1aH6Q/Hx4lV3xAVtcSkNWGKLGSeaxsli3Jniys
X-Gm-Gg: AR+sD13O4Dk52R3MSslasHOHYOLbyfq5OptbyAwF1tB2Tpi5kJxi1hsz+R3K/YhVyQo
 RiEPFdSdoi4PDLYISNVWep5tEJ6KmmePV3HCwtSv18qXy1es/DZhraHCINwhltEod7+XWQRgOjD
 KmyIPEHAicOBZCKaJVV2Zxf1pzuUUYSwRcKLQYIiU4G7uTmVQAhEDh6g0lp7wFAE1s9tiX5mX1Q
 K5Pn3KUSmACJ8kCSLTxyEh3kMPSH/lB5yfHjUuleE9wAzOwA4IKeIIrTjKBGdbpmwwWNQryRw9E
 K4PYJYvHB+f6k/Kl1TS/XdX682/HTvP6idjo0CJ+2BEs+LJek13GjI5zZykmvVkrRUNIuFU1opU
 YS1q+iInd4RuKX52Be2E8870IFnGe9BDZ5DmXbA02qCM/y74JnAtJanDaNgIQrpOstCEw7nsGf8
 AVLqEGspsLMTfGC6pPCKtdn+VVE01e9+Iii14jh5isV+E9VOBKd88roj0=
X-Received: by 2002:a17:90b:2685:b0:38f:5801:eaf7 with SMTP id
 98e67ed59e1d1-38f9bece617mr4253015a91.27.1785457974360; 
 Thu, 30 Jul 2026 17:32:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f9b46a048sm1659459a91.7.2026.07.30.17.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:32:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 30 Jul 2026 17:32:12 -0700
Subject: [PATCH net-next v7 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-tcpdm-large-niovs-v7-3-033d580a619d@meta.com>
References: <20260730-tcpdm-large-niovs-v7-0-033d580a619d@meta.com>
In-Reply-To: <20260730-tcpdm-large-niovs-v7-0-033d580a619d@meta.com>
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a new devmem test case for binding the dmabuf with rx-page-size=16K.
The test sweeps RX payload sizes straddling the niov boundary to cover
the sub-niov, exact-niov, and multi-niov RX paths.

Silence pylint invalid-name (`with open() as f`) and too-many-arguments
(ncdevmem_rx grew to 6 args) at file scope.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/devmem.py   | 11 +++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 74 +++++++++++++++++++++-
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 10 ++-
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 031cf9905f65..82c11ffc4add 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -2,7 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from os import path
-from devmem_lib import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
+from devmem_lib import (setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds,
+                        run_rx_large_niov)
 from lib.py import ksft_run, ksft_exit, ksft_disruptive
 from lib.py import NetDrvEpEnv
 
@@ -30,11 +31,17 @@ def check_rx_hds(cfg) -> None:
     run_rx_hds(cfg)
 
 
+def check_rx_large_niov(cfg) -> None:
+    """Run the devmem RX test with rx-page-size = 16 KiB."""
+    run_rx_large_niov(cfg)
+
+
 def main() -> None:
     """Run the devmem test cases."""
     with NetDrvEpEnv(__file__) as cfg:
         setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem"))
-        ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds],
+        ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds,
+                  check_rx_large_niov],
                  args=(cfg,))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
index 0921ff03eb81..cbe3a8e49823 100644
--- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+# pylint: disable=invalid-name,too-many-arguments
 """Shared helpers for devmem TCP selftests."""
 
+import os
 import re
 
 from lib.py import (bkg, cmd, defer, ethtool, rand_port, wait_port_listen,
@@ -8,7 +10,15 @@ from lib.py import (bkg, cmd, defer, ethtool, rand_port, wait_port_listen,
                     NetdevFamily)
 
 
-def require_devmem(cfg):
+def _is_aligned(value, alignment):
+    """Equivalent of the kernel IS_ALIGNED(value, alignment).
+
+    alignment must be a power of two.
+    """
+    return (value & (alignment - 1)) == 0
+
+
+def require_devmem(cfg, rx_page_size=0):
     """Probe ncdevmem on cfg.ifname and SKIP the test if devmem isn't supported."""
     if not hasattr(cfg, "devmem_probed"):
         probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
@@ -18,6 +28,25 @@ def require_devmem(cfg):
     if not cfg.devmem_supported:
         raise KsftSkipEx("Test requires devmem support")
 
+    if rx_page_size > 0:
+        page_size = os.sysconf("SC_PAGE_SIZE")
+        if not _is_aligned(rx_page_size, page_size):
+            raise KsftSkipEx(
+                f"rx-page-size={rx_page_size} is invalid for this platform "
+                f"(must be a multiple of PAGE_SIZE={page_size})")
+
+        if not hasattr(cfg, "devmem_rx_page_size_probed"):
+            cfg.devmem_rx_page_size_probed = {}
+
+        if rx_page_size not in cfg.devmem_rx_page_size_probed:
+            probe_command = f"{cfg.bin_local} -f {cfg.ifname} -b {rx_page_size}"
+            cfg.devmem_rx_page_size_probed[rx_page_size] = \
+                cmd(probe_command, fail=False, shell=True).ret == 0
+
+        if not cfg.devmem_rx_page_size_probed[rx_page_size]:
+            raise KsftSkipEx(
+                f"Test requires devmem rx-page-size={rx_page_size} support")
+
 
 def configure_nic(cfg):
     """Channels, rings, RSS, queue lease for netkit devmem."""
@@ -76,7 +105,8 @@ def set_flow_rule(cfg, port):
     return int(re.search(r'ID (\d+)', output).group(1))
 
 
-def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False):
+def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False,
+                rx_page_size=0):
     """Build the ncdevmem RX listener command."""
     if hasattr(cfg, 'netns'):
         flow_rule_id = set_flow_rule(cfg, port)
@@ -96,6 +126,8 @@ def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False):
         extras.append("-v 7")
     if fail_on_linear:
         extras.append("-L")
+    if rx_page_size > 0:
+        extras.append(f"-b {rx_page_size}")
 
     parts = [cfg.bin_local, "-l", f"-f {ifname}", f"-s {addr}",
              f"-p {port}", *extras]
@@ -202,6 +234,44 @@ def run_tx_chunks(cfg):
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+def _restore_nr_hugepages(hp_file, nr_hugepages):
+    with open(hp_file, 'w', encoding='utf-8') as f:
+        f.write(str(nr_hugepages))
+
+
+def run_rx_large_niov(cfg):
+    """Run the devmem RX test with a large niov (rx-page-size > PAGE_SIZE).
+
+    Sweep payload sizes that straddle the niov boundary: below, equal to,
+    and above rx_page_size, to exercise sub-niov, exact-niov, and multi-niov
+    RX paths.
+    """
+    hp_file = "/proc/sys/vm/nr_hugepages"
+    with open(hp_file, 'r+', encoding='utf-8') as f:
+        nr_hugepages = int(f.read().strip())
+        if nr_hugepages < 64:
+            f.seek(0)
+            f.write("64")
+            defer(_restore_nr_hugepages, hp_file, nr_hugepages)
+    require_devmem(cfg, rx_page_size=16384)
+    configure_nic(cfg)
+    netns = getattr(cfg, "netns", None)
+
+    for size in [1024, 4096, 8192, 16384, 32768, 65536]:
+        port = rand_port()
+        socat = socat_send(cfg, port)
+        listen_cmd = ncdevmem_rx(cfg, port,
+                                 flow_steer=not netns,
+                                 rx_page_size=16384)
+        data_pipe = (f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | "
+                     f"head -c {size} | {socat}")
+        with bkg(listen_cmd, exit_wait=True, ns=netns) as ncdevmem:
+            wait_port_listen(port, proto="tcp", ns=netns)
+            cmd(data_pipe, host=cfg.remote, shell=True)
+        ksft_eq(ncdevmem.ret, 0,
+                f"large-niov failed for payload size {size}")
+
+
 def run_rx_hds(cfg):
     """Run the HDS test by running devmem RX across a segment size sweep."""
     require_devmem(cfg)
diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
index 300ed2a70ab4..61c6f31f01e5 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -3,7 +3,8 @@
 """Test devmem TCP with netkit."""
 
 import os
-from devmem_lib import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
+from devmem_lib import (setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds,
+                        run_rx_large_niov)
 from lib.py import ksft_run, ksft_exit, ksft_disruptive
 from lib.py import NetDrvContEnv
 
@@ -31,6 +32,11 @@ def check_nk_rx_hds(cfg) -> None:
     run_rx_hds(cfg)
 
 
+def check_nk_rx_large_niov(cfg) -> None:
+    """Run the devmem RX large-niov test through netkit."""
+    run_rx_large_niov(cfg)
+
+
 def main() -> None:
     """Run the netkit devmem test cases."""
     with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
@@ -38,7 +44,7 @@ def main() -> None:
                    os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                 "ncdevmem"))
         ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
-                  check_nk_rx_hds], args=(cfg,))
+                  check_nk_rx_hds, check_nk_rx_large_niov], args=(cfg,))
     ksft_exit()
 
 

-- 
2.53.0-Meta

