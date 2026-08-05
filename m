Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C393C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C3C10EFFE;
	Wed,  5 Aug 2026 20:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyakLY39";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9880B10EFFE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:43:11 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84864086bfeso1240288b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785962591; x=1786567391; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FSorQdxLA2cwFX+rUnYn0LqweS5daHGY10an0vI1+II=;
 b=CyakLY39Cb9yWLukvb+5wXppAImF10DSjF/cq5qY7ZeLsT40K98BVPqkcqBUsOyFia
 XMiJ47ZMtc6PWCG28qmbXh1tyI+gHcuCQ56rXLjCe1nzDD4AhxlohpdqAIlU+yAfRVZL
 EkyfsU98tREso8gNzwyLLqiyvT5MJ3/bRbtGcfMGIuQ90x3Inu5bVkdRMdA1bAbyEpWY
 FSnb29hfGJVO3IHOPhDqIgFDRARzSG0eJAvZ0TF6b3tpZ3Aogvzoj0NkXjW5FAZbYqln
 9rkeyPttEs/aks5J3Hjw2F1FJhJwo4zBF7G+gW9nEAKSoJCcHDHiKUlnuvLhn9VCDnFD
 ZCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785962591; x=1786567391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FSorQdxLA2cwFX+rUnYn0LqweS5daHGY10an0vI1+II=;
 b=OMZRPsYD3YVvtkaAPZRyODrPu4W3CG/SSaA9usGfaP0qBCeb8EEidfquU8kaimQf7o
 5cJQwm5djeffoDS3/Qzjnmq09nivyq9UCwUbtgGOIiO4VmgTymme1RXUoFS5WFDjj3vR
 /27caq6UCFTl91L+45duqbfWmk3X76tEl9NYtEs1Cc4gYv6seayqGgTFbxm5O6jYkNN+
 jYGPIjSfY/oSZX3KI2toJd3RTvEv6Vvwo3GNFBazVnT8wjhne+jmqUPIZRlyIDjMalJi
 ilkxrpOSv8tmGVQxvX0PKAifq6PmZE9tqkd3o2ZfCGgJgSkbA1eFLaeOfvnAMvkkIPdG
 Cxgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVjz0Ty2WGOEmQFY/r9NLVGQvIO/JTJfNlmvEkkbMTSja1nWAk0vu+7UiqtlPGKrOrTZuRbluXQxY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpweIkNMSMw9zUXH5KyN65uy+B0UrG2a1qAis2Khjr2qoTEO1n
 13ia9oQZHVvqait5NJzo5ksec/p2cHvUB+8IU0APTkYxdSmAm+SzEubU
X-Gm-Gg: AR+sD12sb8AsAj6nflW+GPcxhWPP+0lB4NB83+gF1tNku7tpcc2fEeNWlU5Zr9hfpuQ
 EbEnhOSlsuW/Hu4GDeGNtSu/7I3Ouu47paVUZ4Bhtyibzzk0gQZSvc83ez3d1X1NwtxIZe3P8FP
 lbcdimbYWPucI/VKYl1byTzzhO6s3EGHhTVd2VZo7BU30ao45TkM/40oEXsHIsj4dd9qmBJPCtQ
 ZheScIHbGgWVpEO5qWXy9msPL7AkCGtxAtiPkVNUXBxKZAMnyP5bveLI5fpCddTGn4fJH3jZacd
 NRmH+UzicFa1y/Nm/prl2H2MrEndgk4Drsznw74MoT1zuiJ8ojwVomeVy7o/i1IUpJaW/DMma0O
 CyKeT7QMpp0RGNgTqySveIWWQePR5Qd0aXuE2hgL/c5FLin9HXLeGtJI89smWA3WF4/KIFBKxXl
 zgbb7/Y1zQRANoNQuRgYuXZ7nhdMbL02fbiNSXcitRNVWuqFLiN4xY9Xubf4RWE0RUIDI=
X-Received: by 2002:a05:6a00:1388:b0:82f:3a1e:5618 with SMTP id
 d2e1a72fcca58-84f2e017478mr10698688b3a.22.1785962590863; 
 Wed, 05 Aug 2026 13:43:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f459b9ed1sm15387b3a.44.2026.08.05.13.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 13:43:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Aug 2026 13:42:45 -0700
Subject: [PATCH net-next v8 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tcpdm-large-niovs-v8-3-3e0225e2808c@meta.com>
References: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
In-Reply-To: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
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
 tools/testing/selftests/drivers/net/hw/devmem.py   |  11 ++-
 .../testing/selftests/drivers/net/hw/devmem_lib.py | 109 +++++++++++++++++++--
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |  10 +-
 3 files changed, 119 insertions(+), 11 deletions(-)

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
index 0921ff03eb81..209ce3b041e5 100644
--- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+# pylint: disable=invalid-name,too-many-arguments
 """Shared helpers for devmem TCP selftests."""
 
+import os
 import re
 
 from lib.py import (bkg, cmd, defer, ethtool, rand_port, wait_port_listen,
@@ -8,19 +10,82 @@ from lib.py import (bkg, cmd, defer, ethtool, rand_port, wait_port_listen,
                     NetdevFamily)
 
 
-def require_devmem(cfg):
+RX_PAGE_SIZE_DEFAULT = 0
+RX_PAGE_SIZE_16K = 16384
+
+PROBE_RX_PAGE_SIZES = (RX_PAGE_SIZE_DEFAULT, RX_PAGE_SIZE_16K)
+
+NR_HUGEPAGES_FILE = "/proc/sys/vm/nr_hugepages"
+
+
+def _is_aligned(value, alignment):
+    """Equivalent of the kernel IS_ALIGNED(value, alignment).
+
+    alignment must be a power of two.
+    """
+    return (value & (alignment - 1)) == 0
+
+
+def _restore_nr_hugepages(nr_hugepages):
+    with open(NR_HUGEPAGES_FILE, 'w', encoding='utf-8') as f:
+        f.write(str(nr_hugepages))
+
+
+def _reserve_hugepages(want=64):
+    """Raise nr_hugepages to @want and arrange for it to be restored."""
+    with open(NR_HUGEPAGES_FILE, 'r+', encoding='utf-8') as f:
+        nr_hugepages = int(f.read().strip())
+        if nr_hugepages >= want:
+            return
+        f.seek(0)
+        f.write(str(want))
+    defer(_restore_nr_hugepages, nr_hugepages)
+
+
+def _probe_devmem(cfg, rx_page_size):
+    """Return True if ncdevmem can bind cfg.ifname at @rx_page_size."""
+    probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
+    if rx_page_size != RX_PAGE_SIZE_DEFAULT:
+        probe_command += f" -b {rx_page_size}"
+    return cmd(probe_command, fail=False, shell=True).ret == 0
+
+
+def require_devmem(cfg, rx_page_size=RX_PAGE_SIZE_DEFAULT):
     """Probe ncdevmem on cfg.ifname and SKIP the test if devmem isn't supported."""
-    if not hasattr(cfg, "devmem_probed"):
-        probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
-        cfg.devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
-        cfg.devmem_probed = True
+    if rx_page_size not in PROBE_RX_PAGE_SIZES:
+        raise RuntimeError(
+            f"rx-page-size={rx_page_size} is missing from "
+            f"PROBE_RX_PAGE_SIZES, so it was never probed.")
 
-    if not cfg.devmem_supported:
+    if not hasattr(cfg, "devmem_supported"):
+        _reserve_hugepages()
+        # Probe every size upfront: in nk tests a leased queue may land in
+        # ncdevmem's queue range and cause the probe to fail.
+        cfg.devmem_supported = {size: _probe_devmem(cfg, size)
+                                for size in PROBE_RX_PAGE_SIZES}
+
+    if not cfg.devmem_supported[RX_PAGE_SIZE_DEFAULT]:
         raise KsftSkipEx("Test requires devmem support")
 
+    if rx_page_size != RX_PAGE_SIZE_DEFAULT:
+        page_size = os.sysconf("SC_PAGE_SIZE")
+        if not _is_aligned(rx_page_size, page_size):
+            raise KsftSkipEx(
+                f"rx-page-size={rx_page_size} is invalid for this platform "
+                f"(must be a multiple of PAGE_SIZE={page_size})")
+
+        if not cfg.devmem_supported[rx_page_size]:
+            raise KsftSkipEx(
+                f"Test requires devmem rx-page-size={rx_page_size} support")
+
 
 def configure_nic(cfg):
     """Channels, rings, RSS, queue lease for netkit devmem."""
+    if not hasattr(cfg, "devmem_supported"):
+        raise RuntimeError(
+            "require_devmem() must be called before configure_nic(), which "
+            "may lease a queue away and make later probes fail.")
+
     if not hasattr(cfg, 'netns'):
         return
 
@@ -76,7 +141,8 @@ def set_flow_rule(cfg, port):
     return int(re.search(r'ID (\d+)', output).group(1))
 
 
-def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False):
+def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False,
+                rx_page_size=RX_PAGE_SIZE_DEFAULT):
     """Build the ncdevmem RX listener command."""
     if hasattr(cfg, 'netns'):
         flow_rule_id = set_flow_rule(cfg, port)
@@ -96,6 +162,8 @@ def ncdevmem_rx(cfg, port, verify=True, fail_on_linear=False, flow_steer=False):
         extras.append("-v 7")
     if fail_on_linear:
         extras.append("-L")
+    if rx_page_size != RX_PAGE_SIZE_DEFAULT:
+        extras.append(f"-b {rx_page_size}")
 
     parts = [cfg.bin_local, "-l", f"-f {ifname}", f"-s {addr}",
              f"-p {port}", *extras]
@@ -202,6 +270,33 @@ def run_tx_chunks(cfg):
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
+def run_rx_large_niov(cfg):
+    """Run the devmem RX test with a large niov (rx-page-size > PAGE_SIZE).
+
+    Sweep payload sizes that straddle the niov boundary: below, equal to,
+    and above rx_page_size, to exercise sub-niov, exact-niov, and multi-niov
+    RX paths.
+    """
+    require_devmem(cfg, rx_page_size=RX_PAGE_SIZE_16K)
+    _reserve_hugepages()
+    configure_nic(cfg)
+    netns = getattr(cfg, "netns", None)
+
+    for size in [1024, 4096, 8192, 16384, 32768, 65536]:
+        port = rand_port()
+        socat = socat_send(cfg, port)
+        listen_cmd = ncdevmem_rx(cfg, port,
+                                 flow_steer=not netns,
+                                 rx_page_size=RX_PAGE_SIZE_16K)
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

