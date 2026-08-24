Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6815AC5DF9D
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F64C10E69C;
	Mon, 24 Aug 2026 08:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IAxgNumn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42FF10E695
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:10:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A775600C8;
 Mon, 24 Aug 2026 08:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E94E1F00A3A;
 Mon, 24 Aug 2026 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559028;
 bh=4jGWZxSVDqebKgJY6tt5FKIO5zpIjU9P3+rEnCj5kWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IAxgNumnzjkRf1o0KIRjQRUtC4UCJYU5vScHxraXKIe9Xg66k3gmdP3vitB41wK1W
 NQe1MS1by7bj3H+YoCpL+rAQFYK8TNGAs1Je4uiy06R+foen0b37P4229CrJ4jFR2p
 cdLP0PHeLhcxhwmI7Z5o4vGeDxf1FST9hYT+ORoqJ0aQHFUkr4nrrDgoq74tPKXmX+
 96crBudQPvpBIlPCtKRC0wuLCGXphgdqoMUeqi22K2ZGCitNeh5i9i8OkqNmeqji0J
 xOUgf7I4uLMUyBXN8vpBsP/mymHVmVlJ674Vu3a689U6QfkFU8qt9+5OdRITKTtzS5
 sRI0UqbDusuvg==
From: Konstantin Sinyuk <ksinyuk@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/12] drm/fabric: add mutation netlink selftests
Date: Mon, 24 Aug 2026 11:09:40 +0300
Message-ID: <5e1a345a60d23b9d13211be009410f9a30ec3bfc.1787552412.git.ksinyuk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add three programs covering CAP_NET_ADMIN enforcement, non-init_net
rejection and end-to-end provisioning: orphan attach, administrative-state
changes, peer installation, link failure and recovery.

Extend the query, hotplug, fault and policy tests for the mutation
operations. The policy probe now builds nested requests with NLA_F_NESTED,
so an out-of-range nested member reaches the range check and is refused
with -ERANGE instead of as a malformed nest.

The run reports 172 results across fourteen programs, all passing in a
booted virtme-ng guest.

Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst              |   3 +-
 .../selftests/drivers/gpu/drm_fabric/Makefile |   3 +
 .../drivers/gpu/drm_fabric/README.rst         |  20 +-
 .../drivers/gpu/drm_fabric/cap_netadmin.py    | 314 +++++++++++++++++
 .../selftests/drivers/gpu/drm_fabric/config   |   5 +
 .../drivers/gpu/drm_fabric/fabric_abi.py      | 156 ++++++++-
 .../drivers/gpu/drm_fabric/fault_abi.py       | 211 +++++++++++-
 .../drivers/gpu/drm_fabric/hotplug_abi.py     | 145 +++++++-
 .../drivers/gpu/drm_fabric/lib_drm_fabric.py  |  17 +
 .../drivers/gpu/drm_fabric/netns_abi.py       | 294 ++++++++++++++++
 .../drivers/gpu/drm_fabric/nl_policy_probe.py | 280 ++++++++++++---
 .../drm_fabric/provisioning_scenarios_abi.py  | 324 ++++++++++++++++++
 .../drivers/gpu/drm_fabric/switch_abi.py      |  31 +-
 13 files changed, 1721 insertions(+), 82 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/cap_netadmin.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/netns_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/provisioning_scenarios_abi.py

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
index 1fd48027eee3..e400c44d32b8 100644
--- a/Documentation/gpu/drm-fabric.rst
+++ b/Documentation/gpu/drm-fabric.rst
@@ -474,5 +474,6 @@ Generic Netlink ABI tests live under
 ``tools/testing/selftests/drivers/gpu/drm_fabric``. They cover the YNL query
 paths, malformed policy input, generated-header synchronization, dump-cursor
 correctness across endpoint removal, ``NLM_F_DUMP_INTR`` handling, the opaque
-switch half-edge, and provider fault handling. See that directory's ``README.rst``
+switch half-edge, ``CAP_NET_ADMIN`` gating and provisioning rejects, and
+provider fault-injection failure atomicity. See that directory's ``README.rst``
 for build and execution commands.
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/Makefile b/tools/testing/selftests/drivers/gpu/drm_fabric/Makefile
index 54d756979d97..6cdf14c44a5a 100644
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/Makefile
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/Makefile
@@ -18,7 +18,10 @@ TEST_PROGS := \
 	hotplug_abi.py \
 	dump_scale_abi.py \
 	switch_abi.py \
+	cap_netadmin.py \
+	netns_abi.py \
 	fault_abi.py \
+	provisioning_scenarios_abi.py \
 	harness_reset_abi.py
 
 TEST_FILES := lib_drm_fabric.py
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/README.rst b/tools/testing/selftests/drivers/gpu/drm_fabric/README.rst
index 6c24581db1f2..33d9618b31d5 100644
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/README.rst
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/README.rst
@@ -4,7 +4,7 @@
 drm_fabric selftests
 ====================
 
-These selftests exercise the ``drm-fabric`` query uAPI against
+These selftests exercise the ``drm-fabric`` query and mutation uAPI against
 ``drm_fabric_sim`` using the in-tree YNL library. KUnit covers the core object
 model.
 
@@ -45,7 +45,7 @@ Suites
   ends the dump.
 
 ``hotplug_abi.py``
-  Endpoint hotplug: CREATE/DELETE notifications.
+  Endpoint hotplug: CREATE/DELETE NTFs and mutation round-trips.
 
 ``dump_scale_abi.py``
   Dump resume under many endpoints (``bulk_add``).
@@ -54,10 +54,19 @@ Suites
   Opaque switch peers whose identifiers do not resolve to an endpoint
   (``topology=switch``).
 
+``cap_netadmin.py``
+  ``CAP_NET_ADMIN`` enforcement for mutation commands.
+
+``netns_abi.py``
+  Rejects commands outside ``init_net``, including with ``CAP_NET_ADMIN``.
+
 ``fault_abi.py``
-  Provider fault injection: errno propagation and no leaked endpoint
+  Provider failures: errno propagation, rollback and no notification
   (``fail_*``).
 
+``provisioning_scenarios_abi.py``
+  Endpoint, port and peer provisioning scenarios.
+
 ``harness_reset_abi.py``
   Recovery after a SIGKILL-terminated predecessor.
 
@@ -71,6 +80,7 @@ A SKIP means a required precondition was unavailable.
 
 Environment
   ``check-spec-regen.sh`` needs PyYAML and writable temporary storage.
+  ``netns_abi.py`` needs ``CONFIG_NET_NS``.
 
 Per case
   A case skips when a required control, parameter or family capability is
@@ -81,7 +91,7 @@ Whole suite
 
 Timing
   The two ``dump_intr_abi.py`` boundary cases may skip if the concurrent
-  topology change misses the required dump boundary.
+  mutation misses the required dump boundary.
 
 KUnit
 -----
@@ -133,4 +143,4 @@ Build out-of-tree, boot with ``vng`` and run the same target in the guest:
        make -C tools/testing/selftests TARGETS=drivers/gpu/drm_fabric run_tests
 
 Dependencies (Debian/Ubuntu): ``python3``, ``python3-yaml``,
-``qemu-system-x86``, ``virtme-ng`` (``pip install --user virtme-ng``).
\ No newline at end of file
+``qemu-system-x86``, ``virtme-ng`` (``pip install --user virtme-ng``).
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/cap_netadmin.py b/tools/testing/selftests/drivers/gpu/drm_fabric/cap_netadmin.py
new file mode 100755
index 000000000000..f3a80c719b7b
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/cap_netadmin.py
@@ -0,0 +1,314 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+CAP_NET_ADMIN enforcement on the mutation commands: an unprivileged child
+(forked, uid dropped before the socket opens) is refused with -EPERM; also
+covers the -EINVAL/-ENOENT/-EEXIST rejection paths.
+
+Requires drm_fabric + drm_fabric_sim loaded; run as root.
+"""
+
+import errno
+import json
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+UNPRIV_UID = int(os.environ.get("UNPRIV_UID", "65534"))
+
+
+def run_unpriv(method, vals):
+    """Run a single `do` under an unprivileged uid in a child process.
+    Returns (ok, err): ok True on success, err the positive errno on
+    NlError. Result crosses via a JSON line over a pipe.
+    """
+    r, w = os.pipe()
+    pid = os.fork()
+    if pid == 0:  # child
+        os.close(r)
+        result = {"kind": "exc", "val": "setup"}
+        try:
+            try:
+                os.setgroups([])
+            except OSError:
+                pass
+            os.setresgid(UNPRIV_UID, UNPRIV_UID, UNPRIV_UID)
+            os.setresuid(UNPRIV_UID, UNPRIV_UID, UNPRIV_UID)
+            _, NlError = L.import_ynl()
+            fam = L.DrmFabric()
+            try:
+                fam.do(method, vals)
+                result = {"kind": "ok", "val": None}
+            except NlError as exc:
+                result = {"kind": "err", "val": exc.error}
+        except Exception as exc:  # noqa: BLE001
+            result = {"kind": "exc", "val": str(exc)}
+        os.write(w, json.dumps(result).encode())
+        os.close(w)
+        os._exit(0)
+
+    os.close(w)
+    buf = b""
+    while True:
+        chunk = os.read(r, 4096)
+        if not chunk:
+            break
+        buf += chunk
+    os.close(r)
+    os.waitpid(pid, 0)
+    result = json.loads(buf.decode())
+    return (result["kind"] == "ok",
+            result["val"] if result["kind"] == "err" else None)
+
+
+class Cfg:
+    def __init__(self, fab, nl_error):
+        self.fab = fab
+        self.NlError = nl_error
+
+
+def test_cap_fabric_new_privileged(ksft, cfg):
+    fab, NlError = cfg.fab, cfg.NlError
+    new_fid = None
+    try:
+        rep = fab.do("fabric-new",
+                     {"fabric-new-params": {"type": "synthetic",
+                                            "name": "captest",
+                                            "instance-id": 0xCA9}})
+        new_fid = rep.get("fabric-id")
+        ksft.check(new_fid is not None, "cap-fabric-new-privileged",
+                   "reply=%s" % rep)
+    except NlError as exc:
+        ksft.not_ok("cap-fabric-new-privileged", "errno=%d" % exc.error)
+    if new_fid is not None:
+        try:
+            fab.do("fabric-del", {"fabric-id": new_fid})
+        except NlError:
+            pass
+
+
+def test_cap_fabric_new_unprivileged(ksft, cfg):
+    ok, err = run_unpriv("fabric-new",
+                         {"fabric-new-params": {"type": "synthetic",
+                                                "name": "nope",
+                                                "instance-id": 0x4E0}})
+    ksft.check(not ok and err == errno.EPERM, "cap-fabric-new-unprivileged-eperm",
+               "ok=%s errno=%s" % (ok, err))
+
+
+def test_cap_port_set_unprivileged(ksft, cfg):
+    ok, err = run_unpriv("port-set",
+                         {"endpoint-id": 0, "port-index": 0, "admin-state": "down"})
+    ksft.check(not ok and err == errno.EPERM, "cap-port-set-unprivileged-eperm",
+               "ok=%s errno=%s" % (ok, err))
+
+
+def test_cap_port_set_privileged(ksft, cfg):
+    fab, NlError = cfg.fab, cfg.NlError
+    ok_priv = True
+    detail = ""
+    try:
+        fab.do("port-set", {"endpoint-id": 0, "port-index": 0, "admin-state": "down"})
+    except NlError as exc:
+        ok_priv = False
+        detail = "errno=%d" % exc.error
+    try:
+        fab.do("port-set", {"endpoint-id": 0, "port-index": 0, "admin-state": "up"})
+    except NlError:
+        pass
+    ksft.check(ok_priv, "cap-port-set-privileged-ok", detail)
+
+
+def test_cap_fabric_get_unprivileged(ksft, cfg):
+    ok, err = run_unpriv("fabric-get", {"fabric-id": 1})
+    ksft.check(ok, "cap-fabric-get-unprivileged-ok", "errno=%s" % err)
+
+
+def test_reject_fabric_del_unknown(ksft, cfg):
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("fabric-del", {"fabric-id": 4294967295})
+        ksft.not_ok("reject-fabric-del-unknown-enoent", "accepted")
+    except NlError as exc:
+        ksft.check(exc.error == errno.ENOENT, "reject-fabric-del-unknown-enoent",
+                   "errno=%d" % exc.error)
+
+
+def test_reject_fabric_new_no_type(ksft, cfg):
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("fabric-new", {"fabric-new-params": {"name": "no-type"}})
+        ksft.not_ok("reject-fabric-new-no-type-einval", "accepted")
+    except NlError as exc:
+        ksft.check(exc.error == errno.EINVAL, "reject-fabric-new-no-type-einval",
+                   "errno=%d" % exc.error)
+
+
+# A zero fabric type has no ynl symbolic name; the raw probe is in
+# nl_policy_probe.py.
+
+USER_PORT = 3
+
+
+def test_reject_port_peer_new_provider_managed(ksft, cfg):
+    """PORT_PEER_NEW on a provider-managed port is refused with -EOPNOTSUPP."""
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("port-peer-new",
+               {"endpoint-id": 0, "port-index": 0,
+                "peer": {"peer-id": 258, "type": "accel", "port-index": 0}})
+        ksft.not_ok("reject-port-peer-new-provider-managed-eopnotsupp", "accepted")
+    except NlError as exc:
+        ksft.check(exc.error == errno.EOPNOTSUPP,
+                   "reject-port-peer-new-provider-managed-eopnotsupp",
+                   "errno=%d" % exc.error)
+
+
+def test_userspace_peer_roundtrip(ksft, cfg):
+    """A userspace-managed port takes PORT_PEER_NEW, rejects a duplicate with
+    -EEXIST, and clears with PORT_PEER_DEL."""
+    fab, NlError = cfg.fab, cfg.NlError
+    peer = {"peer-id": 258, "type": "accel", "port-index": 0}
+    try:
+        fab.do("port-peer-new",
+               {"endpoint-id": 0, "port-index": USER_PORT, "peer": peer})
+    except NlError as exc:
+        ksft.not_ok("userspace-peer-new-ok", "errno=%d" % exc.error)
+        return
+    ksft.ok("userspace-peer-new-ok")
+    try:
+        fab.do("port-peer-new",
+               {"endpoint-id": 0, "port-index": USER_PORT, "peer": peer})
+        ksft.not_ok("userspace-peer-new-dup-eexist", "accepted duplicate")
+    except NlError as exc:
+        ksft.check(exc.error == errno.EEXIST, "userspace-peer-new-dup-eexist",
+                   "errno=%d" % exc.error)
+    # Clear it again so the reject suite leaves the port unlinked.
+    try:
+        fab.do("port-peer-del", {"endpoint-id": 0, "port-index": USER_PORT})
+        ksft.ok("userspace-peer-del-ok")
+    except NlError as exc:
+        ksft.not_ok("userspace-peer-del-ok", "errno=%d" % exc.error)
+
+
+def _reject_incomplete_peer(ksft, cfg, peer, name):
+    """A port-peer-new with an incomplete peer must be refused with -EINVAL.
+    Targets the userspace-managed port, so the rejection is unambiguously
+    peer-attribute validation, not the provider/userspace mode check.
+    """
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("port-peer-new",
+               {"endpoint-id": 0, "port-index": USER_PORT, "peer": peer})
+        ksft.not_ok(name, "accepted incomplete peer")
+    except NlError as exc:
+        ksft.check(exc.error == errno.EINVAL, name, "errno=%d" % exc.error)
+
+
+def test_reject_port_peer_new_no_type(ksft, cfg):
+    """A peer without a type is rejected (no valid peer type is 0)."""
+    _reject_incomplete_peer(ksft, cfg, {"peer-id": 258, "port-index": 0},
+                            "reject-port-peer-new-no-type-einval")
+
+
+def test_reject_port_peer_new_no_port_index(ksft, cfg):
+    """A peer without a port-index is rejected (0 would be a valid index)."""
+    _reject_incomplete_peer(ksft, cfg, {"peer-id": 258, "type": "accel"},
+                            "reject-port-peer-new-no-port-index-einval")
+
+
+def test_reject_port_peer_new_no_peer_id(ksft, cfg):
+    """A peer without a peer-id is rejected."""
+    _reject_incomplete_peer(ksft, cfg, {"type": "accel", "port-index": 0},
+                            "reject-port-peer-new-no-peer-id-einval")
+
+
+def test_reject_fabric_del_provider(ksft, cfg):
+    """FABRIC_DEL refuses a provider-owned fabric with -EPERM."""
+    fab, NlError = cfg.fab, cfg.NlError
+    prov = [f["fabric"] for f in fab.dump("fabric-get", {})
+            if f["fabric"].get("name") == "fabricsim"]
+    if not prov:
+        ksft.skip("reject-fabric-del-provider-eperm", "no fabricsim fabric")
+        return
+    try:
+        fab.do("fabric-del", {"fabric-id": prov[0]["fabric-id"]})
+        ksft.not_ok("reject-fabric-del-provider-eperm", "accepted")
+    except NlError as exc:
+        ksft.check(exc.error == errno.EPERM, "reject-fabric-del-provider-eperm",
+                   "errno=%d" % exc.error)
+
+
+def test_reject_port_peer_del_unlinked(ksft, cfg):
+    """PORT_PEER_DEL on the unlinked userspace-managed port is -ENOENT."""
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("port-peer-del", {"endpoint-id": 0, "port-index": USER_PORT})
+        ksft.not_ok("reject-port-peer-del-unlinked-enoent", "accepted")
+    except NlError as exc:
+        ksft.check(exc.error == errno.ENOENT, "reject-port-peer-del-unlinked-enoent",
+                   "errno=%d" % exc.error)
+
+
+def test_reject_port_peer_del_provider_managed(ksft, cfg):
+    """PORT_PEER_DEL on a provider-managed port is refused with -EOPNOTSUPP."""
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("port-peer-del", {"endpoint-id": 0, "port-index": 0})
+        ksft.not_ok("reject-port-peer-del-provider-managed-eopnotsupp", "accepted")
+    except NlError as exc:
+        ksft.check(exc.error == errno.EOPNOTSUPP,
+                   "reject-port-peer-del-provider-managed-eopnotsupp",
+                   "errno=%d" % exc.error)
+
+
+def test_reject_endpoint_set_empty(ksft, cfg):
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("endpoint-set", {"endpoint-id": 0})
+        ksft.not_ok("reject-endpoint-set-empty-einval", "accepted")
+    except NlError as exc:
+        ksft.check(exc.error == errno.EINVAL, "reject-endpoint-set-empty-einval",
+                   "errno=%d" % exc.error)
+
+
+CASES = (
+    test_cap_fabric_new_privileged,
+    test_cap_fabric_new_unprivileged,
+    test_cap_port_set_unprivileged,
+    test_cap_port_set_privileged,
+    test_cap_fabric_get_unprivileged,
+    test_reject_fabric_del_unknown,
+    test_reject_fabric_del_provider,
+    test_reject_fabric_new_no_type,
+    test_reject_port_peer_new_provider_managed,
+    test_userspace_peer_roundtrip,
+    test_reject_port_peer_new_no_type,
+    test_reject_port_peer_new_no_port_index,
+    test_reject_port_peer_new_no_peer_id,
+    test_reject_port_peer_del_unlinked,
+    test_reject_port_peer_del_provider_managed,
+    test_reject_endpoint_set_empty,
+)
+
+MUTATION_CASES = tuple(
+    case for case in CASES
+    if case is not test_cap_fabric_get_unprivileged
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+
+    with L.fabricsim(ksft) as fab:
+        L.run_cases(ksft, Cfg(fab, NlError),
+                    L.select_cases(fab, CASES, MUTATION_CASES))
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/config b/tools/testing/selftests/drivers/gpu/drm_fabric/config
index 6eaab8a7d771..f7b38c11a5a9 100644
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/config
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/config
@@ -2,6 +2,11 @@
 # Kernel config fragment required to run the drm_fabric kselftests.
 # Merge with: scripts/kconfig/merge_config.sh or make kselftest-merge.
 CONFIG_NET=y
+# netns_abi.py drives the init_net restriction from a non-initial namespace.
+# USER_NS lets it model container root; without it the suite still runs, using
+# a network namespace alone.
+CONFIG_NET_NS=y
+CONFIG_USER_NS=y
 CONFIG_DRM=y
 CONFIG_DEBUG_FS=y
 CONFIG_DRM_FABRIC=m
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py
index 94cc1078a365..92acf47d45aa 100755
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py
@@ -9,6 +9,7 @@ are immune to CLI text changes.
 Usage: fabric_abi.py [--no-load]   (--no-load: modules already loaded)
 """
 
+import errno
 import os
 import sys
 
@@ -246,6 +247,33 @@ def test_port_change_ntf(ksft, cfg):
     L.dbg_write("ep1/port1/oper_state", "active")
 
 
+def test_endpoint_change_ntf(ksft, cfg):
+    # ENDPOINT_CHANGE_NTF is emitted by an attribute change (endpoint-set), not
+    # by unregister -- removing a provider emits ENDPOINT_DELETE_NTF instead.
+    # Toggle a live endpoint's admin state to provoke the change event, then
+    # restore the original state so later cases are unaffected.
+    fab, NlError = cfg.fab, cfg.NlError
+    ep = fab.do("endpoint-get", {"endpoint-id": 0})["endpoint"]
+    cur = ep.get("admin-state")
+    target = "down" if cur == "up" else "up"
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+    try:
+        fab.do("endpoint-set", {"endpoint-id": 0, "admin-state": target})
+    except NlError as exc:
+        ksft.not_ok("endpoint-change-ntf-notification",
+                    "endpoint-set errno=%d" % exc.error)
+        return
+    got = L.wait_ntf(ev, "endpoint-change-ntf", timeout=EVT_DURATION,
+                     match=lambda n: n["msg"]["endpoint"].get("endpoint-id") == 0)
+    try:
+        fab.do("endpoint-set", {"endpoint-id": 0, "admin-state": cur})
+    except NlError:
+        pass
+    ksft.check(got is not None, "endpoint-change-ntf-notification")
+
+
 def test_linear_topology(ksft, cfg):
     """Reload the sim into the linear topology and assert the chain shape.
     Restores the default mesh K_4 on the way out (even on failure), so
@@ -334,6 +362,119 @@ def test_link_down_exact_count(ksft, cfg):
     L.dbg_write("ep3/port1/inject", "recover_to_active")
 
 
+def test_stats_survive_mutation(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("stats-counters-survive-mutation", "debugfs not available")
+        return
+    fab, NlError = cfg.fab, cfg.NlError
+    L.dbg_write("ep2/port0/inject", "link_down")
+    L.dbg_write("ep2/port0/inject", "link_down")
+    pre = fab.do("port-stats-get",
+                 {"endpoint-id": 2, "port-index": 0})["port-stats"]
+    cpre = pre.get("link-down-count", 0)
+    survived = True
+    try:
+        fab.do("port-set", {"endpoint-id": 2, "port-index": 0,
+                            "admin-state": "down"})
+        fab.do("port-set", {"endpoint-id": 2, "port-index": 0,
+                            "admin-state": "up"})
+        # detach then re-attach the endpoint (mutation on membership). An
+        # endpoint must be admin-down to leave its fabric (decoupled lifecycle
+        # invariant), so bring it down first and restore admin-up after.
+        fab.do("endpoint-set", {"endpoint-id": 2, "admin-state": "down"})
+        fab.do("endpoint-set", {"endpoint-id": 2, "fabric-id": 0})
+        fab.do("endpoint-set", {"endpoint-id": 2, "fabric-id": cfg.fid})
+        fab.do("endpoint-set", {"endpoint-id": 2, "admin-state": "up"})
+    except NlError as exc:
+        # The sim does not ordinarily reject this mutation-only sequence (no
+        # fault injection is armed here), so an unexpected failure here is a
+        # real ABI regression, not an environmental limitation.
+        survived = None
+        ksft.not_ok("stats-counters-survive-mutation",
+                    "mutation errno=%d" % L.nl_errno(exc))
+    if survived is not None:
+        post = fab.do("port-stats-get",
+                      {"endpoint-id": 2, "port-index": 0})["port-stats"]
+        ksft.check(post.get("link-down-count", 0) == cpre,
+                   "stats-counters-survive-mutation",
+                   "pre=%d post=%s" % (cpre, post.get("link-down-count")))
+    # Restore everything the sequence above can have changed, not just the
+    # port: a failure part-way through leaves the endpoint detached or
+    # admin-down, and skipping with that state still in place would silently
+    # change the topology every later case enumerates. Re-attaching requires
+    # admin-down first, so drive the full sequence back.
+    for cmd, req in (("endpoint-set", {"endpoint-id": 2, "admin-state": "down"}),
+                     ("endpoint-set", {"endpoint-id": 2, "fabric-id": cfg.fid}),
+                     ("endpoint-set", {"endpoint-id": 2, "admin-state": "up"}),
+                     ("port-set", {"endpoint-id": 2, "port-index": 0,
+                                   "admin-state": "up"})):
+        try:
+            fab.do(cmd, req)
+        except NlError:
+            pass
+    try:
+        L.dbg_write("ep2/port0/inject", "recover_to_active")
+    except OSError:
+        pass
+    # Assert the restore actually took: a silent failure here is exactly what
+    # would make a later, unrelated case fail instead of this one.
+    back = fab.do("endpoint-get", {"endpoint-id": 2})["endpoint"]
+    ksft.check(back.get("fabric-id") == cfg.fid and
+               back.get("admin-state") == "up",
+               "stats-mutation-endpoint-restored",
+               "fabric-id=%s admin-state=%s"
+               % (back.get("fabric-id"), back.get("admin-state")))
+
+
+def test_fabric_new_duplicate(ksft, cfg):
+    fab, NlError = cfg.fab, cfg.NlError
+    params = {"type": "synthetic", "name": "iid-uniq", "instance-id": 0x9999}
+
+    def fabric_cleanup(fabric_id):
+        def drop():
+            """Delete the fabric unless explicit cleanup already did."""
+            try:
+                fab.do("fabric-del", {"fabric-id": fabric_id})
+            except NlError as exc:
+                if L.nl_errno(exc) != errno.ENOENT:
+                    raise
+
+        return drop
+
+    try:
+        fabric_id = fab.do("fabric-new",
+                           {"fabric-new-params": params})["fabric-id"]
+    except NlError as exc:
+        ksft.not_ok("fabric-new-duplicate-instance-id-eexist",
+                    "setup fabric-new errno=%d" % L.nl_errno(exc))
+        return
+
+    L.on_teardown(fabric_cleanup(fabric_id))
+
+    dup = dict(params, name="iid-dup")
+    try:
+        duplicate = fab.do("fabric-new", {"fabric-new-params": dup})
+    except NlError as exc:
+        ksft.check(L.nl_errno(exc) == errno.EEXIST,
+                   "fabric-new-duplicate-instance-id-eexist",
+                   "errno=%d" % L.nl_errno(exc))
+    else:
+        # Arm cleanup before reporting: an accepted duplicate is a second
+        # live fabric that drop() above cannot reach.
+        dup_id = duplicate.get("fabric-id")
+        if dup_id is not None:
+            L.on_teardown(fabric_cleanup(dup_id))
+        ksft.not_ok("fabric-new-duplicate-instance-id-eexist",
+                    "duplicate instance-id accepted")
+
+    try:
+        fab.do("fabric-del", {"fabric-id": fabric_id})
+        ksft.ok("fabric-new-duplicate-cleanup-del")
+    except NlError as exc:
+        ksft.not_ok("fabric-new-duplicate-cleanup-del",
+                    "errno=%d" % L.nl_errno(exc))
+
+
 # Ordered scenario: each case builds on the topology/state left by the prior
 # one (e.g. the linear reload precedes its assertions, and the mesh reload
 # restores K_N for the stats cases). Keep this list in order.
@@ -351,10 +492,21 @@ CASES = (
     test_counters_stop,
     test_port_state_cycle,
     test_port_change_ntf,
+    test_endpoint_change_ntf,
     test_linear_topology,
     test_reload_mesh,
     test_port_change_ntf_full,
     test_link_down_exact_count,
+    test_stats_survive_mutation,
+    test_fabric_new_duplicate,
+)
+
+# Cases that exercise the topology-mutation uAPI.  On a query-only build the
+# family has no mutation ops, so these are filtered out.
+MUTATION_CASES = (
+    test_endpoint_change_ntf,
+    test_stats_survive_mutation,
+    test_fabric_new_duplicate,
 )
 
 
@@ -388,12 +540,12 @@ def main():
     except (OSError, NlError) as exc:
         ksft.skip_all("cannot open drm-fabric family: %s" % exc)
 
-    # fabric-id 0 is reserved; discover the live provider fabric id.
+    # fabric-id 0 is the reserved orphan sentinel; discover the live id.
     fabrics = fab.dump("fabric-get", {})
     fid = fabrics[0]["fabric"]["fabric-id"] if fabrics else 1
 
     cfg = Cfg(fab, fid, L.debugfs_available(), no_load, NlError)
-    L.run_cases(ksft, cfg, CASES)
+    L.run_cases(ksft, cfg, L.select_cases(fab, CASES, MUTATION_CASES))
     ksft.finish()
 
 
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py
index 8ea2d1de93d7..fce15ef3ca5c 100755
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py
@@ -2,10 +2,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2026 Intel Corporation
 """
-Provider fault injection via fabricsim's fail_register debugfs toggle (cf.
-netdevsim's should_fail): a failed provider-driven endpoint create must
-surface the provider's errno and leak no endpoint, succeeding once the
-fault is cleared.
+Provider fault injection via fabricsim's fail_* debugfs toggles (cf.
+netdevsim's should_fail): a failed mutation must surface the provider's
+exact errno through genetlink, leave core state untouched, emit no change
+notification, and succeed once the fault is cleared.
 
 Requires drm_fabric + drm_fabric_sim with fabricsim debugfs; run as root.
 """
@@ -17,6 +17,12 @@ import sys
 sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
 import lib_drm_fabric as L
 
+# Budget for proving a notification did *not* arrive. Short by design: the
+# failing command has already returned before the wait starts, so a success
+# notification would have been queued by then.
+EVT_NEG_DURATION = float(os.environ.get("EVT_NEG_DURATION", "0.5"))
+EVT_SETTLE = float(os.environ.get("EVT_SETTLE", "0.2"))
+
 
 def eps_by_name(fab):
     return {e["endpoint"]["name"]: e["endpoint"]
@@ -51,10 +57,114 @@ def set_fault(name, on):
     L.dbg_write(name, "Y" if on else "N")
 
 
+def set_fail_errno(code):
+    L.dbg_write("fail_errno", int(code))
+
+
+def has_fail_errno():
+    return os.path.exists(os.path.join(L.DEBUGFS, "fail_errno"))
+
+
 class Cfg:
-    def __init__(self, fab, fid):
+    def __init__(self, fab, nl_error, fid, orphan):
         self.fab = fab
+        self.NlError = nl_error
         self.fid = fid
+        self.orphan = orphan
+        self.oid = orphan["endpoint-id"]
+        self.oslot = slot_of(orphan["name"])
+
+
+def test_endpoint_set_fault(ksft, cfg):
+    """A failed ENDPOINT_SET returns -ENOMEM and rolls back; clearing succeeds."""
+    fab, NlError = cfg.fab, cfg.NlError
+    orphan, oid, fid = cfg.orphan, cfg.oid, cfg.fid
+
+    ksft.check(orphan.get("fabric-id", 0) == 0, "fault-orphan-precondition",
+               "fabric-id=%s" % orphan.get("fabric-id"))
+
+    # A failed mutation must not emit a success notification.
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+
+    set_fault("fail_mutation", True)
+    try:
+        got = None
+        try:
+            fab.do("endpoint-set", {"endpoint-id": oid, "fabric-id": fid})
+        except NlError as exc:
+            got = exc.error
+        ksft.check(got == errno.ENOMEM, "fault-endpoint-set-returns-enomem",
+                   "errno=%s" % got)
+
+        ec = L.wait_ntf(ev, "endpoint-change-ntf", timeout=EVT_NEG_DURATION,
+                        match=lambda n: n["msg"]["endpoint"].get("endpoint-id") == oid)
+        ksft.check(ec is None, "fault-endpoint-set-emits-no-ntf",
+                   "unexpected endpoint-change for %s: %s" % (oid, ec))
+
+        now = eps_by_name(fab).get(orphan["name"], {})
+        ksft.check(now.get("fabric-id", 0) == 0, "fault-endpoint-set-failure-atomicity",
+                   "fabric-id=%s (expected still-orphan)" % now.get("fabric-id"))
+    finally:
+        set_fault("fail_mutation", False)
+    ok = True
+    try:
+        fab.do("endpoint-set", {"endpoint-id": oid, "fabric-id": fid})
+    except NlError as exc:
+        ok = False
+        ksft.not_ok("fault-cleared-endpoint-set-ok", "errno=%d" % exc.error)
+    if ok:
+        attached = eps_by_name(fab).get(orphan["name"], {})
+        ksft.check(attached.get("fabric-id") == fid,
+                   "fault-cleared-endpoint-set-ok",
+                   "fabric-id=%s" % attached.get("fabric-id"))
+        ec2 = L.wait_ntf(ev, "endpoint-change-ntf", timeout=EVT_NEG_DURATION,
+                        match=lambda n: n["msg"]["endpoint"].get("endpoint-id") == oid)
+        ksft.check(ec2 is not None, "fault-cleared-endpoint-set-emits-ntf",
+                   "expected endpoint-change for %s, got none" % oid)
+
+    try:
+        fab.do("endpoint-set", {"endpoint-id": oid, "fabric-id": 0})
+    except NlError:
+        pass
+    del_via(fab, orphan["name"], cfg.oslot)
+
+
+def test_port_peer_new_fault(ksft, cfg):
+    """A failed PORT_PEER_NEW returns -ENOMEM and leaves no peer behind."""
+    fab, NlError = cfg.fab, cfg.NlError
+    ep_a = add_via(fab, "add_endpoint", nports=1)
+    if ep_a is None:
+        ksft.not_ok("fault-port-peer-new-returns-enomem", "add ep failed")
+        ksft.not_ok("fault-port-peer-new-failure-atomicity", "add ep failed")
+        return
+    a_id = ep_a["endpoint-id"]
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+    set_fault("fail_mutation", True)
+    try:
+        got = None
+        try:
+            fab.do("port-peer-new",
+                   {"endpoint-id": a_id, "port-index": 0,
+                    "peer": {"peer-id": 0xBEEF, "type": "accel",
+                             "port-index": 0}})
+        except NlError as exc:
+            got = exc.error
+        ksft.check(got == errno.ENOMEM, "fault-port-peer-new-returns-enomem",
+                   "errno=%s" % got)
+        pc = L.wait_ntf(ev, "port-change-ntf", timeout=EVT_NEG_DURATION,
+                        match=lambda n: n["msg"]["port"].get("endpoint-id") == a_id)
+        ksft.check(pc is None, "fault-port-peer-new-emits-no-ntf",
+                   "unexpected port-change for %s: %s" % (a_id, pc))
+    finally:
+        set_fault("fail_mutation", False)
+    pa = fab.do("port-get", {"endpoint-id": a_id, "port-index": 0})["port"]
+    ksft.check("peer" not in pa, "fault-port-peer-new-failure-atomicity",
+               "unexpected peer=%s" % pa.get("peer"))
+    del_via(fab, ep_a["name"], slot_of(ep_a["name"]))
 
 
 def test_register_fault(ksft, cfg):
@@ -84,20 +194,107 @@ def test_register_fault(ksft, cfg):
         del_via(fab, created["name"], slot_of(created["name"]))
 
 
+def test_errno_round_trip(ksft, cfg):
+    """A selectable provider errno propagates verbatim (not flattened to ENOMEM)."""
+    fab, NlError = cfg.fab, cfg.NlError
+    if not has_fail_errno():
+        ksft.skip("fault-errno-round-trip", "fail_errno knob absent (old module)")
+        return
+    ep = add_via(fab, "add_endpoint", nports=1)
+    if ep is None:
+        ksft.not_ok("fault-errno-round-trip", "add ep failed")
+        return
+    a_id = ep["endpoint-id"]
+    # EBUSY is not the -ENOMEM the other cases use nor a code genl raises itself,
+    # so seeing it come back means the provider's errno was preserved verbatim.
+    set_fail_errno(errno.EBUSY)
+    set_fault("fail_mutation", True)
+    try:
+        got = None
+        try:
+            fab.do("port-peer-new",
+                   {"endpoint-id": a_id, "port-index": 0,
+                    "peer": {"peer-id": 0xBEEF, "type": "accel",
+                             "port-index": 0}})
+        except NlError as exc:
+            got = exc.error
+    finally:
+        set_fault("fail_mutation", False)
+        set_fail_errno(errno.ENOMEM)        # restore the default for later cases
+    ksft.check(got == errno.EBUSY, "fault-errno-round-trip",
+               "expected EBUSY(%d), got %s" % (errno.EBUSY, got))
+    del_via(fab, ep["name"], slot_of(ep["name"]))
+
+
+def test_port_peer_del_fault(ksft, cfg):
+    """A failed PORT_PEER_DEL surfaces the errno and keeps the peer (failure atomicity)."""
+    fab, NlError = cfg.fab, cfg.NlError
+    ep = add_via(fab, "add_endpoint", nports=1)
+    if ep is None:
+        ksft.not_ok("fault-port-peer-del-returns-errno", "add ep failed")
+        ksft.not_ok("fault-port-peer-del-retained", "add ep failed")
+        return
+    a_id = ep["endpoint-id"]
+    fab.do("port-peer-new",
+           {"endpoint-id": a_id, "port-index": 0,
+            "peer": {"peer-id": 0xBEEF, "type": "accel", "port-index": 0}})
+    # Subscribe after the successful add, so any event seen below belongs to the
+    # failing delete rather than the setup.
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+    set_fault("fail_mutation", True)
+    try:
+        got = None
+        try:
+            fab.do("port-peer-del", {"endpoint-id": a_id, "port-index": 0})
+        except NlError as exc:
+            got = exc.error
+        ksft.check(got == errno.ENOMEM, "fault-port-peer-del-returns-errno",
+                   "errno=%s" % got)
+        pd = L.wait_ntf(ev, "port-change-ntf", timeout=EVT_NEG_DURATION,
+                        match=lambda n: n["msg"]["port"].get("endpoint-id") == a_id)
+        ksft.check(pd is None, "fault-port-peer-del-emits-no-ntf",
+                   "unexpected port-change for %s: %s" % (a_id, pd))
+        pa = fab.do("port-get", {"endpoint-id": a_id, "port-index": 0})["port"]
+        ksft.check("peer" in pa, "fault-port-peer-del-retained",
+                   "peer unexpectedly removed after failed delete")
+    finally:
+        set_fault("fail_mutation", False)
+    try:
+        fab.do("port-peer-del", {"endpoint-id": a_id, "port-index": 0})
+    except NlError as exc:
+        ksft.not_ok("fault-port-peer-del-cleared-ok", "errno=%d" % exc.error)
+    else:
+        pa = fab.do("port-get", {"endpoint-id": a_id, "port-index": 0})["port"]
+        ksft.check("peer" not in pa, "fault-port-peer-del-cleared-ok",
+                   "peer still present after clear")
+    del_via(fab, ep["name"], slot_of(ep["name"]))
+
+
 CASES = (
+    test_endpoint_set_fault,
+    test_port_peer_new_fault,
     test_register_fault,
+    test_errno_round_trip,
+    test_port_peer_del_fault,
 )
 
 
 def main():
     ksft = L.Ksft()
+    _, NlError = L.import_ynl()
 
-    with L.fabricsim(ksft, need_debugfs=True, need_control="fail_register") as fab:
+    with L.fabricsim(ksft, need_debugfs=True, need_control="fail_mutation") as fab:
         fid = fabricsim_fid(fab)
         if fid is None:
             ksft.skip_all("fabricsim fabric not present")
 
-        L.run_cases(ksft, Cfg(fab, fid), CASES)
+        orphan = add_via(fab, "add_orphan", nports=1)
+        if orphan is None:
+            ksft.skip_all("could not create orphan endpoint")
+
+        L.run_cases(ksft, Cfg(fab, NlError, fid, orphan), CASES)
     ksft.finish()
 
 
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py
index 19a3405fade9..df70403a7e30 100755
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2026 Intel Corporation
 """
-Endpoint hotplug via fabricsim's debugfs lifecycle controls (add_endpoint/
-del_endpoint, cf. netdevsim's new_port/del_port): CREATE/DELETE events
-observed over the read-only query ABI and notifications; only the hotplug
-stimulus uses the debugfs controls.
+Endpoint hotplug via fabricsim's debugfs lifecycle controls (cf. netdevsim's
+new_port/del_port): CREATE/DELETE events and peer-unplug edge retention are
+observed over the real ABI; ENDPOINT_SET/PORT_SET mutation is also issued over
+the real (privileged) genetlink ABI -- only the hotplug stimulus itself uses
+the test-only debugfs controls.
 
 Usage: hotplug_abi.py [--no-load]
 """
@@ -17,6 +18,10 @@ sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
 import lib_drm_fabric as L
 
 EVT_DURATION = float(os.environ.get("EVT_DURATION", "3"))
+# Window for asserting an event is ABSENT: a peer unplug emits (or suppresses)
+# its notification synchronously during the del, so a short window proves
+# non-arrival without burning the full positive EVT_DURATION.
+EVT_NEG_DURATION = float(os.environ.get("EVT_NEG_DURATION", "0.5"))
 # Subscription is synchronous (setsockopt); a brief settle suffices before
 # triggering, after which wait_ntf() polls with a deadline.
 EVT_SETTLE = float(os.environ.get("EVT_SETTLE", "0.2"))
@@ -59,6 +64,7 @@ class Cfg:
         self.fid = fid
         self.NlError = nl_error
 
+
 def _gen(fab):
     """Current global topology-generation, read via a stable initial port."""
     return fab.do("port-get",
@@ -66,9 +72,13 @@ def _gen(fab):
 
 
 def test_provider_topology_lifecycle(ksft, cfg):
-    """Provider grows and shrinks the topology within its fabric.
-
-    Non-destructive: only the endpoints it adds are removed.
+    """Provider grows and shrinks the topology within its fabric: a
+    read-only ABI view of the xGMI-shaped lifecycle where the provider owns
+    membership/adjacency and userspace only observes. Asserts (a) initial
+    adjacency visible, (b) hotplug CREATE/DELETE events each advance
+    topology-generation, (c) a late arrival carries no peer (provider
+    links explicitly, doesn't auto-wire), (d) pure reads never advance the
+    generation. Non-destructive: only the two added endpoints are removed.
     """
     fab = cfg.fab
 
@@ -143,9 +153,11 @@ def test_provider_topology_lifecycle(ksft, cfg):
                "n0=%d now=%d" % (n0, len(eps_by_name(fab))))
 
 
-
 def test_hotplug_lifecycle(ksft, cfg):
-    """Hotplug one endpoint and unplug it: CREATE, DELETE, membership."""
+    """Hotplug one endpoint and unplug it, asserting the CREATE/DELETE
+    events and membership. Self-contained: adds and deletes the same
+    endpoint.
+    """
     fab = cfg.fab
     ev = L.DrmFabric()
     ev.ntf_subscribe(L.MCAST_MONITOR)
@@ -181,9 +193,124 @@ def test_hotplug_lifecycle(ksft, cfg):
             del_ep(fab, slot_of(name), name)
 
 
+def test_peer_unplug(ksft, cfg):
+    """Link two members, delete one, assert the survivor's peer is intact."""
+    fab, NlError = cfg.fab, cfg.NlError
+    ep_a = add_ep(fab, "add_endpoint", nports=1)
+    ep_b = add_ep(fab, "add_endpoint", nports=1)
+    if not (ep_a and ep_b):
+        ksft.not_ok("peer-unplug-link-established", "could not add two endpoints")
+        ksft.not_ok("peer-unplug-survivor-peer-retained", "setup failed")
+        ksft.not_ok("peer-unplug-no-port-change-ntf", "setup failed")
+        # Tear down the half-built setup: an endpoint left behind here joins
+        # the fabric every later case enumerates, turning one failed setup
+        # into unrelated failures further down the suite.
+        for ep in (ep_a, ep_b):
+            if ep:
+                del_ep(fab, slot_of(ep["name"]), ep["name"])
+        return
+
+    a_id, b_id = ep_a["endpoint-id"], ep_b["endpoint-id"]
+    a_fepid, b_fepid = ep_a["fabric-ep-id"], ep_b["fabric-ep-id"]
+    linked = True
+    try:
+        fab.do("port-peer-new", {"endpoint-id": a_id, "port-index": 0,
+                                 "peer": {"peer-id": b_fepid,
+                                          "type": "accel",
+                                          "port-index": 0}})
+        fab.do("port-peer-new", {"endpoint-id": b_id, "port-index": 0,
+                                 "peer": {"peer-id": a_fepid,
+                                          "type": "accel",
+                                          "port-index": 0}})
+    except NlError as exc:
+        linked = False
+        ksft.not_ok("peer-unplug-link-setup", "errno=%d" % exc.error)
+
+    if linked:
+        pa = fab.do("port-get", {"endpoint-id": a_id, "port-index": 0})["port"]
+        ksft.check("peer" in pa, "peer-unplug-link-established")
+
+        ev = L.DrmFabric()
+        ev.ntf_subscribe(L.MCAST_MONITOR)
+        L.settle(EVT_SETTLE)
+        del_ep(fab, slot_of(ep_b["name"]), ep_b["name"])
+        pc = L.wait_ntf(
+            ev, "port-change-ntf", timeout=EVT_NEG_DURATION,
+            match=lambda n: n["msg"]["port"].get("endpoint-id") == a_id)
+        pa2 = fab.do("port-get",
+                     {"endpoint-id": a_id, "port-index": 0})["port"]
+        ksft.check("peer" in pa2, "peer-unplug-survivor-peer-retained",
+                   "peer=%s" % pa2.get("peer"))
+        ksft.check(pc is None, "peer-unplug-no-port-change-ntf",
+                   "unexpected port-change for a=%s" % (pc,))
+    else:
+        del_ep(fab, slot_of(ep_b["name"]), ep_b["name"])
+    del_ep(fab, slot_of(ep_a["name"]), ep_a["name"])
+
+
+def test_orphan_lifecycle(ksft, cfg):
+    """Orphan attach -> admin up/down -> detach, plus a PORT_SET round-trip."""
+    fab, NlError = cfg.fab, cfg.NlError
+    orphan = add_ep(fab, "add_orphan", nports=1)
+    if not orphan:
+        ksft.not_ok("endpoint-set-orphan-created", "add_orphan failed")
+        return
+
+    o_id = orphan["endpoint-id"]
+    ksft.check(orphan.get("fabric-id", 0) == 0, "endpoint-set-orphan-created",
+               "fabric-id=%s" % orphan.get("fabric-id"))
+
+    def ep_now():
+        return fab.do("endpoint-get", {"endpoint-id": o_id})["endpoint"]
+
+    try:
+        fab.do("endpoint-set", {"endpoint-id": o_id, "fabric-id": cfg.fid})
+        e = ep_now()
+        ksft.check(e.get("fabric-id") == cfg.fid and
+                   e.get("admin-state") == "down",
+                   "endpoint-set-attach-keeps-admin-down",
+                   "fabric=%s admin=%s" % (e.get("fabric-id"),
+                                           e.get("admin-state")))
+
+        fab.do("endpoint-set", {"endpoint-id": o_id, "admin-state": "up"})
+        ksft.check(ep_now().get("admin-state") == "up",
+                   "endpoint-set-admin-up")
+
+        fab.do("endpoint-set", {"endpoint-id": o_id, "admin-state": "down"})
+        fab.do("endpoint-set", {"endpoint-id": o_id, "fabric-id": 0})
+        ksft.check(ep_now().get("fabric-id", 0) == 0,
+                   "endpoint-set-detach-to-orphan")
+    except NlError as exc:
+        ksft.not_ok("endpoint-set-attach-keeps-admin-down",
+                    "errno=%d" % exc.error)
+        ksft.not_ok("endpoint-set-admin-up", "setup failed")
+        ksft.not_ok("endpoint-set-detach-to-orphan", "setup failed")
+
+    try:
+        fab.do("port-set", {"endpoint-id": o_id, "port-index": 0,
+                            "admin-state": "down"})
+        d = fab.do("port-get",
+                   {"endpoint-id": o_id, "port-index": 0})["port"]
+        fab.do("port-set", {"endpoint-id": o_id, "port-index": 0,
+                            "admin-state": "up"})
+        u = fab.do("port-get",
+                   {"endpoint-id": o_id, "port-index": 0})["port"]
+        ksft.check(d.get("admin-state") == "down" and
+                   u.get("admin-state") == "up",
+                   "port-set-admin-round-trip",
+                   "down=%s up=%s" % (d.get("admin-state"),
+                                      u.get("admin-state")))
+    except NlError as exc:
+        ksft.not_ok("port-set-admin-round-trip", "errno=%d" % exc.error)
+
+    del_ep(fab, slot_of(orphan["name"]), orphan["name"])
+
+
 CASES = (
     test_provider_topology_lifecycle,
     test_hotplug_lifecycle,
+    test_peer_unplug,
+    test_orphan_lifecycle,
 )
 
 
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py b/tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py
index 30fb0edb02b9..9e5dfd6a6ba9 100644
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py
@@ -267,6 +267,16 @@ def family_has_op(fab, name):
     return name in getattr(fab, "ops", {})
 
 
+def select_cases(fab, cases, mutation_cases, probe="fabric-new"):
+    """Return @cases, dropping @mutation_cases when @probe (a representative
+    mutation op) is absent from the family.
+    """
+    if family_has_op(fab, probe):
+        return tuple(cases)
+    drop = set(mutation_cases)
+    return tuple(c for c in cases if c not in drop)
+
+
 # System helpers (kselftest runs as root)
 
 def is_root():
@@ -462,6 +472,13 @@ def fabricsim(ksft, topology=None, need_debugfs=False, need_control=None,
         if not insmod("drm-fabric.ko") or not insmod("drm-fabric-sim.ko"):
             ksft.skip_all("could not load drm_fabric + drm_fabric_sim modules")
         wait_until(lambda: module_loaded("drm_fabric_sim"))
+    else:
+        # Running against providers somebody else loaded (--no-load, or a
+        # previous suite that restored the sim but kept the core). There is no
+        # module to unwind, but the suite can still add endpoints and peers,
+        # and without a teardown that state would leak into the next suite and
+        # survive the timeout killer's SIGTERM. Restore the default shape.
+        on_teardown(sim_restore_default)
 
     if not module_loaded("drm_fabric_sim"):
         ksft.skip_all("drm_fabric_sim not loaded")
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/netns_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/netns_abi.py
new file mode 100755
index 000000000000..ea165e870130
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/netns_abi.py
@@ -0,0 +1,294 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Confinement is by init_net, not CAP_NET_ADMIN-in-userns: a child that
+unshares into its own user+net namespace (or net-only, without
+CONFIG_USER_NS) and regains root must still be refused, and specifically
+refused *while holding CAP_NET_ADMIN* -- the complement of
+cap_netadmin.py's unprivileged-in-init_net case. Verifies the child truly
+left init_net and the family still resolves before trusting any -EPERM.
+
+Requires drm_fabric + drm_fabric_sim; run as root. Skips without user
+namespace support.
+"""
+
+import ctypes
+import errno
+import json
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+CLONE_NEWUSER = 0x10000000
+CLONE_NEWNET = 0x40000000
+CAP_NET_ADMIN = 12
+
+
+def _cap_effective():
+    """CapEff bitmask of the calling thread, or None if unreadable."""
+    try:
+        with open("/proc/self/status", encoding="ascii") as f:
+            for line in f:
+                if line.startswith("CapEff:"):
+                    return int(line.split()[1], 16)
+    except OSError:
+        pass
+    return None
+
+
+def _map_self(uid, gid):
+    """Map @uid/@gid to 0 in the new user namespace. Ids must be read before
+    unsharing: an unmapped namespace makes getuid() answer the overflow
+    uid, and the kernel only accepts a self-map with the caller's real
+    parent-side id.
+    """
+    try:
+        # setgroups must be denied before gid_map is writable.
+        with open("/proc/self/setgroups", "w", encoding="ascii") as f:
+            f.write("deny")
+        with open("/proc/self/uid_map", "w", encoding="ascii") as f:
+            f.write("0 %d 1" % uid)
+        with open("/proc/self/gid_map", "w", encoding="ascii") as f:
+            f.write("0 %d 1" % gid)
+    except OSError as exc:
+        return "id map: %s" % exc
+    return None
+
+
+def _enter_namespaces():
+    """Enter a non-initial network namespace; returns (mode, failure).
+    Prefers "user+net" (models container root); falls back to "net" alone
+    when CONFIG_USER_NS is absent, which is if anything the sharper case
+    since the caller then keeps the initial CAP_NET_ADMIN, isolating the
+    namespace check.
+    """
+    libc = ctypes.CDLL(None, use_errno=True)
+    uid, gid = os.getuid(), os.getgid()
+
+    if libc.unshare(CLONE_NEWUSER | CLONE_NEWNET) == 0:
+        fail = _map_self(uid, gid)
+        return (None, fail) if fail else ("user+net", None)
+    first = os.strerror(ctypes.get_errno())
+
+    if libc.unshare(CLONE_NEWNET) == 0:
+        return "net", None
+    return None, ("user+net: %s; net: %s"
+                  % (first, os.strerror(ctypes.get_errno())))
+
+
+def _try(fab, NlError, fn):
+    """Return 'ok' or the positive errno the ABI answered with."""
+    try:
+        fn(fab)
+        return "ok"
+    except NlError as exc:
+        return L.nl_errno(exc)
+
+
+def _child_probe(w):
+    """Everything measured inside the new namespaces, reported as one JSON blob."""
+    out = {"stage": "start"}
+    try:
+        mode, fail = _enter_namespaces()
+        if fail:
+            out = {"stage": "unshare", "detail": fail}
+            raise SystemExit
+
+        out = {
+            "stage": "entered",
+            "mode": mode,
+            "ns_inode": os.stat("/proc/self/ns/net").st_ino,
+            "cap_eff": _cap_effective(),
+        }
+
+        _, NlError = L.import_ynl()
+        try:
+            fab = L.DrmFabric()
+        except Exception as exc:  # noqa: BLE001
+            out["family"] = "error: %s" % exc
+            raise SystemExit
+        out["family"] = "ok"
+
+        out["fabric_get"] = _try(fab, NlError,
+                                 lambda f: f.do("fabric-get", {"fabric-id": 1}))
+        out["fabric_get_dump"] = _try(fab, NlError,
+                                      lambda f: list(f.dump("fabric-get", {})))
+        out["fabric_new"] = _try(
+            fab, NlError,
+            lambda f: f.do("fabric-new", {"fabric-new-params": {
+                "type": "synthetic", "name": "netns", "instance-id": 0x4E5}}))
+    except SystemExit:
+        pass
+    except Exception as exc:  # noqa: BLE001
+        out["stage"] = "exception"
+        out["detail"] = str(exc)
+    os.write(w, json.dumps(out).encode())
+
+
+_PROBE = None
+
+
+def probe():
+    """Run the namespaced child once and cache what it reported."""
+    global _PROBE
+    if _PROBE is not None:
+        return _PROBE
+
+    r, w = os.pipe()
+    pid = os.fork()
+    if pid == 0:  # child
+        os.close(r)
+        try:
+            _child_probe(w)
+        finally:
+            os.close(w)
+            os._exit(0)
+
+    os.close(w)
+    buf = b""
+    while True:
+        chunk = os.read(r, 4096)
+        if not chunk:
+            break
+        buf += chunk
+    os.close(r)
+    os.waitpid(pid, 0)
+
+    try:
+        _PROBE = json.loads(buf.decode())
+    except ValueError:
+        _PROBE = {"stage": "no-report"}
+    return _PROBE
+
+
+class Cfg:
+    def __init__(self, fab, nl_error):
+        self.fab = fab
+        self.NlError = nl_error
+        self.init_ns = os.stat("/proc/self/ns/net").st_ino
+
+
+def _entered(ksft, cfg, name):
+    """Common gate: report SKIP or FAIL when the child never got far enough."""
+    p = probe()
+    if p.get("stage") == "unshare":
+        ksft.skip(name, "cannot create user+net namespace: %s"
+                  % p.get("detail", "?"))
+        return None
+    if p.get("stage") != "entered":
+        ksft.not_ok(name, "child did not reach the namespace: %s" % p)
+        return None
+    return p
+
+
+def test_child_left_init_net(ksft, cfg):
+    """Control: the child must really be in a different network namespace.
+    Without it, a kernel lacking CONFIG_NET_NS could leave the child in
+    init_net and every -EPERM below would be vacuous.
+    """
+    p = _entered(ksft, cfg, "netns-child-left-init-net")
+    if p is None:
+        return
+    ksft.check(p["ns_inode"] != cfg.init_ns, "netns-child-left-init-net",
+               "mode=%s child ns=%s parent ns=%s"
+               % (p.get("mode"), p["ns_inode"], cfg.init_ns))
+
+
+def test_child_holds_cap_net_admin(ksft, cfg):
+    """Control: the child must hold CAP_NET_ADMIN, else the -EPERM
+    assertions below would just be an ordinary unprivileged rejection,
+    proving nothing about namespace confinement.
+    """
+    p = _entered(ksft, cfg, "netns-child-holds-cap-net-admin")
+    if p is None:
+        return
+    cap = p.get("cap_eff")
+    ksft.check(cap is not None and bool(cap & (1 << CAP_NET_ADMIN)),
+               "netns-child-holds-cap-net-admin",
+               "mode=%s CapEff=%s"
+               % (p.get("mode"), "?" if cap is None else "0x%x" % cap))
+
+
+def test_family_visible_in_child_netns(ksft, cfg):
+    """Control: the family is netnsok and resolves in the new namespace,
+    else the errnos below would be genetlink failing to find it, not the
+    family refusing the caller.
+    """
+    p = _entered(ksft, cfg, "netns-family-resolves")
+    if p is None:
+        return
+    ksft.check(p.get("family") == "ok", "netns-family-resolves",
+               "family=%s" % p.get("family"))
+
+
+def _expect_eperm(ksft, cfg, key, name):
+    p = _entered(ksft, cfg, name)
+    if p is None:
+        return
+    if p.get("family") != "ok":
+        ksft.not_ok(name, "family did not resolve; errno is not meaningful")
+        return
+    got = p.get(key)
+    ksft.check(got == errno.EPERM, name,
+               "mode=%s result=%s (expected EPERM)" % (p.get("mode"), got))
+
+
+def test_fabric_get_refused(ksft, cfg):
+    """A read is refused too: confinement is not limited to mutation."""
+    _expect_eperm(ksft, cfg, "fabric_get", "netns-fabric-get-eperm")
+
+
+def test_fabric_get_dump_refused(ksft, cfg):
+    """Dumps take the same check as doit handlers."""
+    _expect_eperm(ksft, cfg, "fabric_get_dump", "netns-fabric-get-dump-eperm")
+
+
+def test_fabric_new_refused(ksft, cfg):
+    """Provisioning is refused despite the child holding CAP_NET_ADMIN."""
+    _expect_eperm(ksft, cfg, "fabric_new", "netns-fabric-new-eperm")
+
+
+def test_init_net_topology_unchanged(ksft, cfg):
+    """The refused child must not have created anything in init_net."""
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        names = [f["fabric"].get("name") for f in fab.dump("fabric-get", {})]
+    except NlError as exc:
+        ksft.not_ok("netns-init-net-unchanged", "errno=%d" % L.nl_errno(exc))
+        return
+    ksft.check("netns" not in names, "netns-init-net-unchanged",
+               "fabrics=%s" % names)
+
+
+CASES = (
+    test_child_left_init_net,
+    test_child_holds_cap_net_admin,
+    test_family_visible_in_child_netns,
+    test_fabric_get_refused,
+    test_fabric_get_dump_refused,
+    test_fabric_new_refused,
+    test_init_net_topology_unchanged,
+)
+
+# Only the provisioning case needs a mutation-capable build; confinement of
+# reads and dumps is a query-only contract asserted on either build.
+MUTATION_CASES = (
+    test_fabric_new_refused,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+
+    with L.fabricsim(ksft) as fab:
+        L.run_cases(ksft, Cfg(fab, NlError),
+                    L.select_cases(fab, CASES, MUTATION_CASES))
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py b/tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py
index 0d4d60d45e5a..16afa185e87b 100755
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py
@@ -7,9 +7,6 @@ attrs (wrong type, unknown id, truncated nest, out-of-range enum, missing
 required) must return a clean NLMSG_ERROR, never an oops; a liveness dump
 confirms nothing wedged the family. Also introspects the family and emits
 TAP.
-
-Topology-mutation policy probes arrive with the provisioning ABI; this
-query-only build defines no mutation commands or attributes to probe.
 """
 
 import errno
@@ -116,34 +113,77 @@ def _parse_all_enums(text):
     return out
 
 
+# Symbols the uAPI defines on every build. Their absence means the header did
+# not parse or is not drm_fabric's, which is distinct from a query-only build
+# and must not be confused with one.
+_REQUIRED_SYMS = ("DRM_FABRIC_CMD_FABRIC_GET", "DRM_FABRIC_CMD_PORT_GET",
+                  "DRM_FABRIC_A_FABRIC_ID", "DRM_FABRIC_A_ENDPOINT_ID",
+                  "DRM_FABRIC_A_PORT_INDEX", "DRM_FABRIC_A_PEER",
+                  "DRM_FABRIC_A_PEER_ATTRS_PEER_ID",
+                  "DRM_FABRIC_A_PEER_ATTRS_TYPE", "__DRM_FABRIC_A_MAX")
+
+# Commands that exist only once topology provisioning is present. Whether the
+# header defines them describes the build, which is what lets a command missing
+# from the live family be reported as a failure instead of a skip.
+_MUTATION_CMDS = ("DRM_FABRIC_CMD_FABRIC_NEW", "DRM_FABRIC_CMD_FABRIC_DEL",
+                  "DRM_FABRIC_CMD_ENDPOINT_SET", "DRM_FABRIC_CMD_PORT_SET",
+                  "DRM_FABRIC_CMD_PORT_PEER_NEW",
+                  "DRM_FABRIC_CMD_PORT_PEER_DEL")
+_MUTATION_SYMS = _MUTATION_CMDS + ("DRM_FABRIC_A_ADMIN_STATE",
+                                  "DRM_FABRIC_A_FABRIC_NEW_PARAMS",
+                                  "DRM_FABRIC_A_FABRIC_NEW_PARAMS_TYPE")
+
+
 def _load_ids():
-    # Committed fallbacks (kept in sync with drm_fabric.h, query-only build).
-    syms = {"DRM_FABRIC_CMD_FABRIC_GET": 1, "DRM_FABRIC_CMD_PORT_GET": 3,
-            "DRM_FABRIC_A_FABRIC_ID": 5, "DRM_FABRIC_A_ENDPOINT_ID": 6,
-            "DRM_FABRIC_A_PORT_INDEX": 7, "DRM_FABRIC_A_PEER": 10}
-    src = "fallback literals"
+    """Resolve ids from the uAPI header, or report why we cannot; returns
+    (ids, header path) or (None, reason). Deliberately no built-in fallback
+    table: a stale entry wouldn't fail loudly, it would probe the wrong
+    attribute and still report success.
+    """
     hdr = _find_uapi_header()
-    if hdr:
-        parsed = _parse_all_enums(open(hdr).read())
-        if "DRM_FABRIC_CMD_PORT_GET" in parsed and "DRM_FABRIC_A_FABRIC_ID" in parsed:
-            syms, src = parsed, hdr
-    return syms, src
+    if not hdr:
+        return None, ("drm_fabric uAPI header not found; set "
+                      "UAPI_HEADER=/path/to/include/uapi/drm/drm_fabric.h")
+    syms = _parse_all_enums(open(hdr).read())
+    missing = [s for s in _REQUIRED_SYMS if s not in syms]
+    if missing:
+        return None, "%s does not define %s" % (hdr, ", ".join(missing))
+    return syms, hdr
+
+
+_IDS, _ID_SRC = _load_ids()
 
 
-_SYMS, _ID_SRC = _load_ids()
+def _id(name):
+    """Value of @name, or None when this build's header does not define it."""
+    return _IDS.get(name) if _IDS else None
 
-CMD_FABRIC_GET = _SYMS["DRM_FABRIC_CMD_FABRIC_GET"]
-CMD_PORT_GET = _SYMS["DRM_FABRIC_CMD_PORT_GET"]
 
-A_FABRIC_ID = _SYMS["DRM_FABRIC_A_FABRIC_ID"]
-A_ENDPOINT_ID = _SYMS["DRM_FABRIC_A_ENDPOINT_ID"]
-A_PORT_INDEX = _SYMS["DRM_FABRIC_A_PORT_INDEX"]
+CMD_FABRIC_GET = _id("DRM_FABRIC_CMD_FABRIC_GET")
+CMD_PORT_GET = _id("DRM_FABRIC_CMD_PORT_GET")
+CMD_PORT_SET = _id("DRM_FABRIC_CMD_PORT_SET")
+CMD_PORT_PEER_NEW = _id("DRM_FABRIC_CMD_PORT_PEER_NEW")
+CMD_FABRIC_NEW = _id("DRM_FABRIC_CMD_FABRIC_NEW")
 
-# An attribute id guaranteed to be past the family's top-level maxattr, so the
-# kernel strict-rejects it. Derived from the parsed ids (one past the largest
-# symbol) rather than a magic literal, which would silently stop testing strict
-# rejection once the attribute set grows past it.
-A_UNKNOWN = max(_SYMS.values()) + 1
+A_FABRIC_ID = _id("DRM_FABRIC_A_FABRIC_ID")
+A_ENDPOINT_ID = _id("DRM_FABRIC_A_ENDPOINT_ID")
+A_PORT_INDEX = _id("DRM_FABRIC_A_PORT_INDEX")
+A_ADMIN_STATE = _id("DRM_FABRIC_A_ADMIN_STATE")
+A_PEER = _id("DRM_FABRIC_A_PEER")
+A_FABRIC_NEW_PARAMS = _id("DRM_FABRIC_A_FABRIC_NEW_PARAMS")
+
+A_PEER_PEER_ID = _id("DRM_FABRIC_A_PEER_ATTRS_PEER_ID")
+A_PEER_TYPE = _id("DRM_FABRIC_A_PEER_ATTRS_TYPE")
+A_FABRIC_NEW_PARAMS_TYPE = _id("DRM_FABRIC_A_FABRIC_NEW_PARAMS_TYPE")
+
+# One past the top-level attribute set's upper bound, so every command
+# strict-rejects it: no per-command maxattr can exceed the set it indexes.
+# __DRM_FABRIC_A_MAX is that value by construction, so this tracks the set as
+# it grows instead of quietly aliasing a real attribute once it does.
+A_UNKNOWN = _id("__DRM_FABRIC_A_MAX")
+
+# What the build supports, as opposed to what the running family advertises.
+BUILD_HAS_MUTATION = bool(_IDS) and all(s in _IDS for s in _MUTATION_SYMS)
 
 
 # NLA builders
@@ -158,6 +198,17 @@ def nla(attr_type, payload):
     return struct.pack("=HH", length, attr_type) + payload + pad
 
 
+def nla_nest(attr_type, payload):
+    """Build a nest the way a real client does.
+
+    Strict validation rejects an attribute the policy declares as a nest
+    unless NLA_F_NESTED is set, before it ever recurses into the nested
+    policy. Without the flag a probe aimed at a nested member only ever
+    reaches the outer parse.
+    """
+    return nla(attr_type | NLA_F_NESTED, payload)
+
+
 def nla_u32(attr_type, val):
     return nla(attr_type, struct.pack("=I", val & 0xFFFFFFFF))
 
@@ -173,6 +224,16 @@ def build_msg(family_id, cmd, seq, payload, flags=NLM_F_REQUEST | NLM_F_ACK):
     return nlh + body
 
 
+# One counter for every request the suite sends, so each reply can be matched
+# to the request that caused it and no two requests ever share a sequence.
+_SEQ = [100]
+
+
+def _next_seq():
+    _SEQ[0] += 1
+    return _SEQ[0]
+
+
 # Socket helpers
 
 def open_sock():
@@ -234,17 +295,32 @@ def drain(sock, first_timeout=0.5, more_timeout=0.3):
     return msgs
 
 
+def _getfamily(sock, name):
+    """Send one CTRL_CMD_GETFAMILY and return the datagram that answers it.
+    Only a reply matching our own sequence is accepted: an earlier request's
+    queued ACK or late reply would otherwise look like a family that
+    advertises nothing, silently disabling every introspection check.
+    """
+    seq = _next_seq()
+    sock.send(build_msg(GENL_ID_CTRL, CTRL_CMD_GETFAMILY, seq,
+                        nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00"),
+                        flags=NLM_F_REQUEST))
+    while True:
+        try:
+            data = sock.recv(65536)
+        except socket.timeout:
+            return None
+        (_, mtype, _, mseq, _) = struct.unpack_from("=IHHII", data, 0)
+        if mseq != seq:
+            continue
+        if mtype == NLMSG_ERROR:
+            return None
+        return data
+
+
 def resolve_family(sock, name):
-    seq = 1
-    msg = build_msg(GENL_ID_CTRL, CTRL_CMD_GETFAMILY, seq,
-                    nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00"))
-    sock.send(msg)
-    try:
-        data = sock.recv(8192)
-    except socket.timeout:
-        return None
-    (_, mtype, _, _, _) = struct.unpack_from("=IHHII", data, 0)
-    if mtype == NLMSG_ERROR:
+    data = _getfamily(sock, name)
+    if data is None:
         return None
     attrs = data[NLMSG_HDRLEN + GENL_HDRLEN:]
     for atype, payload in iter_attrs(attrs):
@@ -263,17 +339,8 @@ def get_family_info(sock, name):
     letting callers confirm version, admin-perm on mutators, and the
     monitor group.
     """
-    seq = 2
-    msg = build_msg(GENL_ID_CTRL, CTRL_CMD_GETFAMILY, seq,
-                    nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00"),
-                    flags=NLM_F_REQUEST)
-    sock.send(msg)
-    try:
-        data = sock.recv(65536)
-    except socket.timeout:
-        return None
-    (_, mtype, _, _, _) = struct.unpack_from("=IHHII", data, 0)
-    if mtype == NLMSG_ERROR:
+    data = _getfamily(sock, name)
+    if data is None:
         return None
 
     info = {"version": None, "ops": {}, "mcast": set()}
@@ -306,17 +373,13 @@ def get_family_info(sock, name):
 # dynamic plan printed at finish() instead of a hard-coded count that drifts
 # every time a case is added or removed.
 
-_SEQ = [100]
-
-
 def case_rejected(tap, name, sock, fid, cmd, payload, expect):
     """Pass iff the kernel rejected with one of @expect (positive errno
     values; the netlink error is negative, so we compare -e). The specific
     code matters: e.g. -EINVAL for a malformed attribute, not a generic
     failure.
     """
-    _SEQ[0] += 1
-    sock.send(build_msg(fid, cmd, _SEQ[0], payload))
+    sock.send(build_msg(fid, cmd, _next_seq(), payload))
     msgs = drain(sock)
     rejected = [-e for (t, e) in msgs
                if t == NLMSG_ERROR and e is not None and e != 0]
@@ -364,12 +427,22 @@ class Cfg:
     def __init__(self, sock, fid):
         self.sock = sock
         self.fid = fid
+        # Whether the running family advertises the mutation commands, from
+        # live introspection in main(): True, False, or None when the
+        # introspection itself failed. The three states are kept apart because
+        # "this build has no mutation commands" is a skip while "this build has
+        # them but the family does not offer them" is a failure.
+        self.live_mutation = None
 
 
 def test_malformed_requests(ksft, cfg):
     sock, fid = cfg.sock, cfg.fid
     # Malformed framing/attributes must fail validation with -EINVAL.
     EINVAL = {errno.EINVAL}
+    # Out-of-range enums are caught by the generated NLA_POLICY range checks,
+    # which report -ERANGE and nothing else. Accepting -EINVAL as well would
+    # let a malformed probe that never reaches the range check pass silently.
+    ERANGE = {errno.ERANGE}
 
     case_rejected(ksft, "wrong-type-short-u32", sock, fid, CMD_FABRIC_GET,
                   nla(A_FABRIC_ID, struct.pack("=H", 1)), EINVAL)
@@ -377,10 +450,79 @@ def test_malformed_requests(ksft, cfg):
     case_rejected(ksft, "unknown-attribute-id", sock, fid, CMD_FABRIC_GET,
                   nla_u32(A_FABRIC_ID, 1) + nla_u32(A_UNKNOWN, 0), EINVAL)
 
+    # Policy errors are unreachable when mutation commands are absent.
+    if cfg.live_mutation:
+        # Truncated nest: PEER header claims 64 bytes but carries 4. Rejected
+        # while walking the attributes, before any policy runs.
+        bad_nest = (struct.pack("=HH", 64, A_PEER | NLA_F_NESTED) +
+                    b"\x00\x00\x00\x00")
+        case_rejected(ksft, "truncated-nest", sock, fid, CMD_PORT_PEER_NEW,
+                      nla_u32(A_ENDPOINT_ID, 0) + nla_u32(A_PORT_INDEX, 0) + bad_nest,
+                      EINVAL)
+
+        # Out-of-range enum: admin-state past DRM_FABRIC_ADMIN_UP.
+        case_rejected(ksft, "enum-range-admin-state", sock, fid, CMD_PORT_SET,
+                      nla_u32(A_ENDPOINT_ID, 0) + nla_u32(A_PORT_INDEX, 0) +
+                      nla_u32(A_ADMIN_STATE, 0xFFFFFFFF), ERANGE)
+
+        # Out-of-range enum: peer-type past DRM_FABRIC_PEER_SWITCH, inside a
+        # nest, so this only reaches the nested policy as a well-formed nest.
+        peer = nla_u64(A_PEER_PEER_ID, 0x1) + nla_u32(A_PEER_TYPE, 99)
+        case_rejected(ksft, "enum-range-peer-type", sock, fid, CMD_PORT_PEER_NEW,
+                      nla_u32(A_ENDPOINT_ID, 0) + nla_u32(A_PORT_INDEX, 0) +
+                      nla_nest(A_PEER, peer), ERANGE)
+
+        # Zero fabric-type, which the enum starts above and so never names.
+        # The range check runs before the doit, so the refusal predates any
+        # fabric the request could have created, which the next case asserts.
+        before = fabric_count(sock, fid)
+        case_rejected(ksft, "enum-range-fabric-type", sock, fid, CMD_FABRIC_NEW,
+                      nla_nest(A_FABRIC_NEW_PARAMS,
+                               nla_u32(A_FABRIC_NEW_PARAMS_TYPE, 0)),
+                      ERANGE)
+        after = fabric_count(sock, fid)
+        ksft.check(before is not None and after == before,
+                   "enum-range-fabric-type-not-created",
+                   "fabrics before=%s after=%s" % (before, after))
+    else:
+        # The case set stays the same either way -- the probes are reported
+        # rather than silently omitted -- but only a query-only build earns a
+        # skip. If this build defines the mutation commands and the family does
+        # not offer them, the probes are unrunnable for a reason worth seeing.
+        if cfg.live_mutation is None:
+            report, why = ksft.not_ok, ("family introspection failed; cannot "
+                                        "tell which commands are advertised")
+        elif BUILD_HAS_MUTATION:
+            report, why = ksft.not_ok, ("uAPI header defines the mutation "
+                                        "commands but the family advertises "
+                                        "none")
+        else:
+            report, why = ksft.skip, ("query-only build: uAPI header defines "
+                                      "no mutation commands")
+        for nm in ("truncated-nest", "enum-range-admin-state",
+                   "enum-range-peer-type", "enum-range-fabric-type",
+                   "enum-range-fabric-type-not-created"):
+            report(nm, why)
+
     case_rejected(ksft, "missing-required-port-index", sock, fid, CMD_PORT_GET,
                   nla_u32(A_ENDPOINT_ID, 0), EINVAL)
 
 
+def fabric_count(sock, fid):
+    """Fabrics a dump reports, or None when the dump itself did not succeed.
+
+    None is distinct from zero on purpose: a dump that errored says nothing
+    about how many fabrics exist, and reporting it as zero would let a broken
+    dump satisfy a claim that nothing was created.
+    """
+    sock.send(build_msg(fid, CMD_FABRIC_GET, _next_seq(), b"",
+                        flags=NLM_F_REQUEST | NLM_F_DUMP))
+    msgs = drain(sock)
+    if not msgs or any(t == NLMSG_ERROR and e != 0 for (t, e) in msgs):
+        return None
+    return sum(1 for (t, _) in msgs if t not in (NLMSG_ERROR, NLMSG_DONE))
+
+
 def test_liveness(ksft, cfg):
     """A dump that doesn't hang or error is not enough: it must also carry
     a well-formed, zero-status terminal NLMSG_DONE, or a wedge/regression in
@@ -388,8 +530,7 @@ def test_liveness(ksft, cfg):
     (no data records, just a clean DONE) is still a pass.
     """
     sock, fid = cfg.sock, cfg.fid
-    _SEQ[0] += 1
-    sock.send(build_msg(fid, CMD_FABRIC_GET, _SEQ[0], b"",
+    sock.send(build_msg(fid, CMD_FABRIC_GET, _next_seq(), b"",
                         flags=NLM_F_REQUEST | NLM_F_DUMP))
     msgs = drain(sock)
     errs = [e for (t, e) in msgs if t == NLMSG_ERROR and e != 0]
@@ -412,15 +553,16 @@ def test_liveness(ksft, cfg):
 
 def test_family_introspection(ksft, cfg):
     """Via CTRL_CMD_GETFAMILY: version, admin-perm gating, mcast surface."""
-    getter_ids = [_SYMS[n] for n in (
+    mutator_ids = [_id(n) for n in _MUTATION_CMDS if _id(n) is not None]
+    getter_ids = [_id(n) for n in (
         "DRM_FABRIC_CMD_FABRIC_GET", "DRM_FABRIC_CMD_ENDPOINT_GET",
         "DRM_FABRIC_CMD_PORT_GET", "DRM_FABRIC_CMD_PORT_STATS_GET")
-        if n in _SYMS]
+        if _id(n) is not None]
 
     info = get_family_info(cfg.sock, FAMILY_NAME)
     if not info:
         for nm in ("genl-family-version", "genl-mcast-monitor-present",
-                   "genl-getters-not-admin-perm"):
+                   "genl-mutators-admin-perm", "genl-getters-not-admin-perm"):
             ksft.not_ok(nm, "CTRL_CMD_GETFAMILY introspection failed")
         return
 
@@ -437,8 +579,19 @@ def test_family_introspection(ksft, cfg):
                     "groups=%s" % info["mcast"])
 
     ops = info["ops"]
-    # A query-only build exposes getters only: each must be ungated (no
-    # GENL_ADMIN_PERM), so a normal namespace can enumerate topology.
+    # The mutator admin-perm gate only applies once the mutation commands exist
+    # at all; a query-only build registers no mutators to check. Gate on the
+    # build rather than on the live family, so a build that should advertise
+    # mutators but does not fails here instead of dropping the check.
+    if BUILD_HAS_MUTATION:
+        seen_mut = [c for c in mutator_ids if c in ops]
+        bad_mut = [c for c in seen_mut if not (ops[c] & GENL_ADMIN_PERM)]
+        if seen_mut and not bad_mut:
+            ksft.ok("genl-mutators-admin-perm (%d cmds)" % len(seen_mut))
+        else:
+            ksft.not_ok("genl-mutators-admin-perm",
+                        "seen=%s missing-perm=%s" % (seen_mut, bad_mut))
+
     seen_get = [c for c in getter_ids if c in ops]
     bad_get = [c for c in seen_get if ops[c] & GENL_ADMIN_PERM]
     if seen_get and not bad_get:
@@ -461,6 +614,11 @@ def main():
     if os.geteuid() != 0:
         tap.skip_all("root is required to load drm_fabric modules")
 
+    # Every probe below is built from uAPI ids, so without them there is
+    # nothing trustworthy to send.
+    if _IDS is None:
+        tap.skip_all(_ID_SRC)
+
     if _maybe_load_modules():
         L.on_teardown(_unload_providers)
 
@@ -476,7 +634,15 @@ def main():
 
     sys.stderr.write("# attribute/command ids from: %s\n" % _ID_SRC)
 
+    # Ask the live family which of the topology-mutation commands it actually
+    # offers. Left as None when the introspection fails, so the probes gated on
+    # it report that rather than treating an unanswered question as a no.
     cfg = Cfg(sock, fid)
+    info = get_family_info(sock, FAMILY_NAME)
+    if info is not None:
+        cfg.live_mutation = any(_id(n) in info["ops"] for n in _MUTATION_CMDS
+                                if _id(n) is not None)
+
     L.run_cases(tap, cfg, CASES)
     tap.finish()
 
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/provisioning_scenarios_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/provisioning_scenarios_abi.py
new file mode 100755
index 000000000000..21da97f63615
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/provisioning_scenarios_abi.py
@@ -0,0 +1,324 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+End-to-end provisioning lifecycles, tying the implementation to the
+intended flows rather than the isolated mechanics covered elsewhere
+(cap_netadmin/fault/fabric_abi): orchestrated startup and link
+failure/recovery, each detailed on its own test.
+
+Mutation via the real ABI; operational/telemetry state via fabricsim
+debugfs. Needs drm_fabric + drm_fabric_sim (default mesh, 4 ports); root.
+
+Usage: provisioning_scenarios_abi.py [--no-load]
+"""
+
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+EVT_DURATION = float(os.environ.get("EVT_DURATION", "3"))
+EVT_SETTLE = float(os.environ.get("EVT_SETTLE", "0.2"))
+
+USER_PORT = 3
+
+
+def eps_by_name(fab):
+    return {e["endpoint"]["name"]: e["endpoint"]
+            for e in fab.dump("endpoint-get", {})}
+
+
+def fabricsim_fid(fab):
+    for f in fab.dump("fabric-get", {}):
+        if f["fabric"]["name"] == "fabricsim":
+            return f["fabric"]["fabric-id"]
+    return None
+
+
+def slot_of(name):
+    return int(name.rsplit("ep", 1)[1])
+
+
+def add_orphan(fab, nports):
+    """Register a provider orphan via debugfs; return the new endpoint dict."""
+    before = set(eps_by_name(fab))
+    L.dbg_write("add_orphan", nports)
+    new = L.wait_until(lambda: set(eps_by_name(fab)) - before)
+    if len(new) != 1:
+        return None
+    return eps_by_name(fab)[next(iter(new))]
+
+
+def del_ep(fab, slot, name):
+    L.dbg_write("del_endpoint", slot)
+    return L.wait_until(lambda: name not in eps_by_name(fab))
+
+
+class Cfg:
+    def __init__(self, fab, fid, nl_error):
+        self.fab = fab
+        self.fid = fid
+        self.NlError = nl_error
+
+
+def _gen(fab, ep_id, port_index):
+    return fab.do("port-get", {"endpoint-id": ep_id,
+                               "port-index": port_index}).get(
+                                   "topology-generation")
+
+
+def _port(fab, ep_id, port_index):
+    return fab.do("port-get", {"endpoint-id": ep_id,
+                               "port-index": port_index})["port"]
+
+
+def _ep(fab, ep_id):
+    return fab.do("endpoint-get", {"endpoint-id": ep_id})["endpoint"]
+
+
+def test_orchestrated_startup(ksft, cfg):
+    """Full orchestrated bring-up of a provider-supplied orphan: orphan ->
+    create fabric -> attach -> endpoint admin up -> port admin up ->
+    provider oper ACTIVE -> userspace installs a peer. Administrative
+    intent (userspace) and operational state (provider) move
+    independently.
+    """
+    fab, NlError = cfg.fab, cfg.NlError
+
+    orphan = add_orphan(fab, nports=4)
+    if not orphan:
+        for name in ("startup-orphan-visible", "startup-fabric-created",
+                     "startup-attach-membership",
+                     "startup-attach-endpoint-change-ntf",
+                     "startup-endpoint-admin-up",
+                     "startup-oper-independent-of-admin",
+                     "startup-port-admin-up",
+                     "startup-provider-reports-oper-active",
+                     "startup-oper-active-port-change-ntf",
+                     "startup-userspace-peer-installed"):
+            ksft.not_ok(name, "add_orphan failed")
+        return
+
+    o_id = orphan["endpoint-id"]
+    slot = slot_of(orphan["name"])
+    made_fabric = None
+
+    ksft.check(orphan.get("fabric-id", 0) == 0 and
+               orphan.get("admin-state") == "down", "startup-orphan-visible",
+               "fabric-id=%s admin=%s" % (orphan.get("fabric-id"),
+                                          orphan.get("admin-state")))
+    try:
+        rep = fab.do("fabric-new", {"fabric-new-params": {
+            "type": "synthetic", "name": "startup", "instance-id": 0x57A}})
+        made_fabric = rep.get("fabric-id")
+        ksft.check(made_fabric is not None, "startup-fabric-created",
+                   "reply=%s" % rep)
+
+        ev = L.DrmFabric()
+        ev.ntf_subscribe(L.MCAST_MONITOR)
+        L.settle(EVT_SETTLE)
+        fab.do("endpoint-set", {"endpoint-id": o_id, "fabric-id": made_fabric})
+        attach_ntf = L.wait_ntf(
+            ev, "endpoint-change-ntf", timeout=EVT_DURATION,
+            match=lambda n: n["msg"]["endpoint"].get("endpoint-id") == o_id)
+        e = _ep(fab, o_id)
+        ksft.check(e.get("fabric-id") == made_fabric and
+                   e.get("admin-state") == "down", "startup-attach-membership",
+                   "fabric=%s admin=%s" % (e.get("fabric-id"),
+                                           e.get("admin-state")))
+        ksft.check(attach_ntf is not None,
+                   "startup-attach-endpoint-change-ntf")
+
+        fab.do("endpoint-set", {"endpoint-id": o_id, "admin-state": "up"})
+        ksft.check(_ep(fab, o_id).get("admin-state") == "up",
+                   "startup-endpoint-admin-up")
+
+        # Bring a provider-managed port admin-up; operational state must not
+        # follow automatically -- the provider owns it.
+        pre = _port(fab, o_id, 0)
+        fab.do("port-set", {"endpoint-id": o_id, "port-index": 0,
+                            "admin-state": "up"})
+        p = _port(fab, o_id, 0)
+        ksft.check(p.get("admin-state") == "up", "startup-port-admin-up")
+        ksft.check(pre.get("oper-state") != "active" and
+                   p.get("oper-state") != "active",
+                   "startup-oper-independent-of-admin",
+                   "oper=%s" % p.get("oper-state"))
+
+        evp = L.DrmFabric()
+        evp.ntf_subscribe(L.MCAST_MONITOR)
+        L.settle(EVT_SETTLE)
+        L.dbg_write("ep%d/port0/oper_state" % slot, "active")
+        oper_ntf = L.wait_ntf(
+            evp, "port-change-ntf", timeout=EVT_DURATION,
+            match=lambda n: n["msg"]["port"].get("endpoint-id") == o_id)
+        L.wait_until(lambda: _port(fab, o_id, 0).get("oper-state") == "active")
+        ksft.check(_port(fab, o_id, 0).get("oper-state") == "active",
+                   "startup-provider-reports-oper-active")
+        ksft.check(oper_ntf is not None, "startup-oper-active-port-change-ntf")
+
+        peer = {"peer-id": 0x2A, "type": "accel", "port-index": 0}
+        fab.do("port-peer-new", {"endpoint-id": o_id, "port-index": USER_PORT,
+                                 "peer": peer})
+        pu = _port(fab, o_id, USER_PORT)
+        ksft.check(pu.get("peer") is not None and
+                   pu["peer"].get("peer-id") == 0x2A,
+                   "startup-userspace-peer-installed",
+                   "peer=%s" % pu.get("peer"))
+    finally:
+        for method, vals in (
+                ("port-peer-del", {"endpoint-id": o_id,
+                                   "port-index": USER_PORT}),
+                ("port-set", {"endpoint-id": o_id, "port-index": 0,
+                              "admin-state": "down"}),
+                ("endpoint-set", {"endpoint-id": o_id, "admin-state": "down"}),
+                ("endpoint-set", {"endpoint-id": o_id, "fabric-id": 0})):
+            try:
+                fab.do(method, vals)
+            except NlError:
+                pass
+        if made_fabric is not None:
+            try:
+                fab.do("fabric-del", {"fabric-id": made_fabric})
+            except NlError:
+                pass
+        del_ep(fab, slot, orphan["name"])
+
+
+def test_link_failure_and_recovery(ksft, cfg):
+    """A live link fails and recovers under provider control.
+
+    Uses an initial mesh member (provider-managed port 0 with an established
+    peer, userspace-managed port 3). Asserts administrative intent survives an
+    operational failure, telemetry advances without touching topology-
+    generation, operational transitions do advance it and emit port-change,
+    an identical admin request is a no-op, and a userspace peer is replaced
+    with strict delete-before-new ordering leaving no stale descriptor.
+    """
+    fab, NlError = cfg.fab, cfg.NlError
+    EP, PP, UP = 0, 0, USER_PORT
+
+    fab.do("port-set", {"endpoint-id": EP, "port-index": PP,
+                        "admin-state": "up"})
+    L.dbg_write("ep%d/port%d/oper_state" % (EP, PP), "active")
+    L.wait_until(lambda: _port(fab, EP, PP).get("oper-state") == "active")
+    try:
+        base = fab.do("port-stats-get", {"endpoint-id": EP,
+                                         "port-index": PP})["port-stats"]
+        c0 = base.get("link-down-count", 0)
+        g_active = _gen(fab, EP, PP)
+
+        # Failure: the provider reports the link down.
+        ev = L.DrmFabric()
+        ev.ntf_subscribe(L.MCAST_MONITOR)
+        L.settle(EVT_SETTLE)
+        L.dbg_write("ep%d/port%d/inject" % (EP, PP), "link_down")
+        down_ntf = L.wait_ntf(
+            ev, "port-change-ntf", timeout=EVT_DURATION,
+            match=lambda n: n["msg"]["port"].get("endpoint-id") == EP)
+        L.wait_until(lambda: _port(fab, EP, PP).get("oper-state") == "inactive")
+        p_down = _port(fab, EP, PP)
+        ksft.check(p_down.get("oper-state") == "inactive",
+                   "linkfail-oper-inactive", "oper=%s" % p_down.get(
+                       "oper-state"))
+        ksft.check(p_down.get("admin-state") == "up",
+                   "linkfail-admin-stays-up", "admin=%s" % p_down.get(
+                       "admin-state"))
+        ksft.check(down_ntf is not None, "linkfail-oper-change-port-change-ntf")
+        g_down = _gen(fab, EP, PP)
+        ksft.check(g_active is not None and g_down is not None and
+                   g_down > g_active, "linkfail-oper-change-advances-generation",
+                   "active=%s down=%s" % (g_active, g_down))
+
+        # Telemetry advances; a stats read must not advance topology-generation.
+        s = fab.do("port-stats-get", {"endpoint-id": EP,
+                                      "port-index": PP})["port-stats"]
+        ksft.check(s.get("link-down-count", 0) >= c0 + 1,
+                   "linkfail-link-down-count-increases",
+                   "c0=%d now=%s" % (c0, s.get("link-down-count")))
+        ksft.check(_gen(fab, EP, PP) == g_down,
+                   "linkfail-stats-read-no-generation-bump")
+
+        # Recovery.
+        ev2 = L.DrmFabric()
+        ev2.ntf_subscribe(L.MCAST_MONITOR)
+        L.settle(EVT_SETTLE)
+        L.dbg_write("ep%d/port%d/inject" % (EP, PP), "recover_to_active")
+        up_ntf = L.wait_ntf(
+            ev2, "port-change-ntf", timeout=EVT_DURATION,
+            match=lambda n: n["msg"]["port"].get("endpoint-id") == EP)
+        L.wait_until(lambda: _port(fab, EP, PP).get("oper-state") == "active")
+        ksft.check(_port(fab, EP, PP).get("oper-state") == "active",
+                   "linkfail-recovery-oper-active")
+        g_recovered = _gen(fab, EP, PP)
+        ksft.check(g_recovered > g_down,
+                   "linkfail-recovery-advances-generation",
+                   "down=%s recovered=%s" % (g_down, g_recovered))
+        ksft.check(up_ntf is not None, "linkfail-recovery-port-change-ntf")
+
+        # An identical admin request is a no-op: no generation change.
+        g_pre_noop = _gen(fab, EP, PP)
+        fab.do("port-set", {"endpoint-id": EP, "port-index": PP,
+                            "admin-state": "up"})
+        ksft.check(_gen(fab, EP, PP) == g_pre_noop,
+                   "linkfail-idempotent-admin-noop")
+
+        # Peer replacement on the userspace-managed port: X, then delete, then
+        # Y -- strict delete-before-new ordering, no stale descriptor.
+        peer_x = {"peer-id": 0x101, "type": "accel", "port-index": 0}
+        peer_y = {"peer-id": 0x202, "type": "accel", "port-index": 0}
+        fab.do("port-peer-new", {"endpoint-id": EP, "port-index": UP,
+                                 "peer": peer_x})
+        px = _port(fab, EP, UP).get("peer")
+        fab.do("port-peer-del", {"endpoint-id": EP, "port-index": UP})
+        pmid = _port(fab, EP, UP).get("peer")
+        fab.do("port-peer-new", {"endpoint-id": EP, "port-index": UP,
+                                 "peer": peer_y})
+        py = _port(fab, EP, UP).get("peer")
+        ksft.check(px is not None and px.get("peer-id") == 0x101,
+                   "linkfail-peer-install-x", "peer=%s" % px)
+        ksft.check(pmid is None, "linkfail-peer-del-clears", "peer=%s" % pmid)
+        ksft.check(py is not None and py.get("peer-id") == 0x202,
+                   "linkfail-peer-replace-y-no-stale", "peer=%s" % py)
+
+        # Final query matches the reported stream: oper active + peer Y.
+        pf0 = _port(fab, EP, PP)
+        pfu = _port(fab, EP, UP)
+        ksft.check(pf0.get("oper-state") == "active" and
+                   (pfu.get("peer") or {}).get("peer-id") == 0x202,
+                   "linkfail-final-query-matches",
+                   "oper=%s peer=%s" % (pf0.get("oper-state"),
+                                        pfu.get("peer")))
+    finally:
+        try:
+            fab.do("port-peer-del", {"endpoint-id": EP, "port-index": UP})
+        except NlError:
+            pass
+        L.dbg_write("ep%d/port%d/inject" % (EP, PP), "recover_to_active")
+
+
+CASES = (
+    test_orchestrated_startup,
+    test_link_failure_and_recovery,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+
+    with L.fabricsim(ksft, need_debugfs=True, need_control="add_orphan") as fab:
+        fid = fabricsim_fid(fab)
+        if fid is None:
+            ksft.skip_all("fabricsim fabric not present")
+        if not L.family_has_op(fab, "fabric-new"):
+            ksft.skip_all("mutation ABI absent (query-only build)")
+
+        L.run_cases(ksft, Cfg(fab, fid, NlError), CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py
index 775be4ac2160..152d16cdc464 100755
--- a/tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py
@@ -4,7 +4,9 @@
 """
 fabricsim's "switch" shape links each leaf's first port to an opaque
 switch that is not a registered endpoint: asserts half-edge serialization
-and peer-id non-resolution, not leaf-switch-leaf reachability.
+and peer-id non-resolution, not leaf-switch-leaf reachability. A final case
+reloads at a one-port-per-endpoint request, where the port reserved for
+userspace peers would otherwise consume the only half-edge.
 
 --no-load is ignored (needs a fresh insmod). Run as root.
 """
@@ -78,11 +80,38 @@ def test_switch_id_does_not_resolve(ksft, cfg):
                % sorted(leaked))
 
 
+def test_minimum_request_preserves_switch_wiring(ksft, cfg):
+    """A one-port-per-endpoint request must still leave the switch wired:
+    setup raises the count so the reserved userspace port does not consume
+    the only half-edge.
+
+    Runs last: it reloads the sim, invalidating the snapshot above.
+    """
+    fab = cfg.fab
+    L.rmmod("drm_fabric_sim")
+    if not L.insmod("drm-fabric-sim.ko", "topology=switch", "ports_per_ep=1"):
+        ksft.skip("switch-minimum-request-wired",
+                  "could not load sim with ports_per_ep=1")
+        return
+    if not L.wait_until(lambda: L.module_loaded("drm_fabric_sim")):
+        ksft.skip("switch-minimum-request-wired", "sim did not reappear")
+        return
+
+    eps = [e["endpoint"] for e in fab.dump("endpoint-get", {})]
+    sim_eps = [e for e in eps if e["name"].startswith("sim-ep")]
+    peers = switch_peers(fab, sim_eps)
+    ksft.check(bool(sim_eps) and len(peers) == len(sim_eps),
+               "switch-minimum-request-wired",
+               "ports_per_ep=1: switch-peers=%d leaves=%d"
+               % (len(peers), len(sim_eps)))
+
+
 CASES = (
     test_every_leaf_has_switch_peer,
     test_half_edge_fully_serialized,
     test_single_opaque_switch_id,
     test_switch_id_does_not_resolve,
+    test_minimum_request_preserves_switch_wiring,
 )
 
 
-- 
2.43.0

