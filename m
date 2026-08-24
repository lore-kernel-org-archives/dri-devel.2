Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14C8C5DF9D
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9D010E67D;
	Mon, 24 Aug 2026 08:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZZbTvPlJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5836010E67D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:10:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D7CA40AC8;
 Mon, 24 Aug 2026 08:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF701F00A3A;
 Mon, 24 Aug 2026 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559007;
 bh=mx07GtMBFgGI0oqvy9b1IKv9Nm69AuNz1AYewSiFHUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZZbTvPlJCW0+Wc3QMMp5f1rYdbEojmpcl/iMEiHmdJ9Hdn2xHHAqCxCRI2FreizQB
 Iaoa/UaOOWAu5TPIsD7DIxzUqD2haxLWIxhq3PjPnniiTKvkdC4Is4ULu75m01h74e
 uXZAnO13mgPPxe3eMqMPvO9v2UGHBtVKyYoAtJLKsdLqKOCRv1CkbRb8i7vvAlKfXk
 FDXS8bBvmK7Oj6m7SsRjc/ykubXH/g51QQ3FUxoP7KVXKqCmR2nEsgTPWYeKZrySeS
 NNcmRc9JDr9PCxQ8ZZCDDOP1gEqND981ytfRYXefelUtMdwCOD8goGY4etqpZT32QA
 vd31rKJ7u7niQ==
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
Subject: [RFC PATCH 06/12] drm/fabric: add YNL query and policy selftests
Date: Mon, 24 Aug 2026 11:09:34 +0300
Message-ID: <19b16439fe5f81ad983082e84f88405506f73558.1787552412.git.ksinyuk@kernel.org>
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

The read-only Generic Netlink ABI has userspace-visible behavior KUnit
cannot reach: policy validation, multipart dumps, notifications and family
introspection. These paths require a live netlink socket.

Add eleven kselftest programs using the in-tree YNL client against
fabricsim. They cover queries and filters, notifications, malformed policy
input, interrupted dumps, nested port-cursor resumption after endpoint
removal, mixed per-port statistics support, topology churn, opaque switch
peers and provider error propagation.

Shared helpers manage module lifetime and restore fabricsim state between
programs. Add the selftest configuration, README and a regeneration guard
for the generated uAPI header, kernel header and operation/policy source.

  $ make -C tools/testing/selftests TARGETS=drivers/gpu/drm_fabric \
        run_tests
  [...]
  ok 1 selftests: drivers/gpu/drm_fabric: check-spec-regen.sh
  [...]
  ok 11 selftests: drivers/gpu/drm_fabric: harness_reset_abi.py

The run reports 89 results across eleven programs, all passing in a
booted virtme-ng guest.

Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst              |   7 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/gpu/drm_fabric/Makefile |  41 ++
 .../drivers/gpu/drm_fabric/README.rst         | 136 +++++
 .../gpu/drm_fabric/check-spec-regen.sh        | 114 ++++
 .../selftests/drivers/gpu/drm_fabric/config   |   8 +
 .../drivers/gpu/drm_fabric/dump_intr_abi.py   | 361 +++++++++++++
 .../drivers/gpu/drm_fabric/dump_scale_abi.py  | 178 +++++++
 .../drivers/gpu/drm_fabric/fabric_abi.py      | 401 +++++++++++++++
 .../drivers/gpu/drm_fabric/fault_abi.py       | 105 ++++
 .../gpu/drm_fabric/harness_reset_abi.py       | 113 ++++
 .../drivers/gpu/drm_fabric/hotplug_abi.py     | 204 ++++++++
 .../drivers/gpu/drm_fabric/lib_drm_fabric.py  | 481 +++++++++++++++++
 .../drivers/gpu/drm_fabric/nl_policy_probe.py | 485 ++++++++++++++++++
 .../drivers/gpu/drm_fabric/port_cursor_abi.py | 401 +++++++++++++++
 .../gpu/drm_fabric/port_stats_cap_abi.py      | 374 ++++++++++++++
 .../selftests/drivers/gpu/drm_fabric/settings |   1 +
 .../drivers/gpu/drm_fabric/switch_abi.py      | 108 ++++
 18 files changed, 3519 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/Makefile
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/README.rst
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/check-spec-regen.sh
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/config
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/dump_intr_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/dump_scale_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/port_cursor_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/port_stats_cap_abi.py
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/settings
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
index cd98a97e1662..bc7b87c766cc 100644
--- a/Documentation/gpu/drm-fabric.rst
+++ b/Documentation/gpu/drm-fabric.rst
@@ -357,3 +357,10 @@ Testing
 
 The object model is covered by KUnit when ``CONFIG_DRM_FABRIC_KUNIT_TEST`` is
 enabled. The test source is folded into the core translation unit.
+
+Generic Netlink ABI tests live under
+``tools/testing/selftests/drivers/gpu/drm_fabric``. They cover the YNL query
+paths, malformed policy input, generated-header synchronization, dump-cursor
+correctness across endpoint removal, ``NLM_F_DUMP_INTR`` handling, the opaque
+switch half-edge, and provider fault handling. See that directory's ``README.rst``
+for build and execution commands.
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b622052ec3e9..c90eb5d33ec6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -18,6 +18,7 @@ TARGETS += devices/error_logs
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
+TARGETS += drivers/gpu/drm_fabric
 TARGETS += drivers/ntsync
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/Makefile b/tools/testing/selftests/drivers/gpu/drm_fabric/Makefile
new file mode 100644
index 000000000000..54d756979d97
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# kselftests for the drm-fabric Generic Netlink ABI.
+#
+# Each TEST_PROGS entry is invoked separately by the kselftest harness; suites
+# self-load modules when needed (check-spec-regen.sh is host-only).
+#
+# Run:
+#   make -C tools/testing/selftests TARGETS=drivers/gpu/drm_fabric run_tests
+
+TEST_PROGS := \
+	check-spec-regen.sh \
+	fabric_abi.py \
+	nl_policy_probe.py \
+	dump_intr_abi.py \
+	port_cursor_abi.py \
+	port_stats_cap_abi.py \
+	hotplug_abi.py \
+	dump_scale_abi.py \
+	switch_abi.py \
+	fault_abi.py \
+	harness_reset_abi.py
+
+TEST_FILES := lib_drm_fabric.py
+
+include ../../../lib.mk
+
+# A TEST_PROGS entry that loses its executable bit still runs, because the
+# kselftest runner falls back to the shebang, but only after a warning that is
+# easy to miss in a long run. Catch it at build time instead.
+all: check-test-progs-mode
+
+check-test-progs-mode:
+	@for prog in $(TEST_PROGS); do \
+		test -x "$$prog" || { \
+			echo "$$prog: in TEST_PROGS but not executable" >&2; \
+			exit 1; \
+		}; \
+	done
+
+.PHONY: check-test-progs-mode
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/README.rst b/tools/testing/selftests/drivers/gpu/drm_fabric/README.rst
new file mode 100644
index 000000000000..6c24581db1f2
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/README.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+drm_fabric selftests
+====================
+
+These selftests exercise the ``drm-fabric`` query uAPI against
+``drm_fabric_sim`` using the in-tree YNL library. KUnit covers the core object
+model.
+
+Tree layout
+-----------
+
+``Documentation/netlink/specs/drm_fabric.yaml``
+  Netlink specification and source of truth for generated artifacts.
+
+``include/uapi/drm/drm_fabric.h``
+  Generated uAPI header; checked by ``check-spec-regen.sh``.
+
+``drivers/gpu/drm/fabric/drm_fabric_nl.[ch]``
+  Generated kernel policy and operation tables; checked by
+  ``check-spec-regen.sh``.
+
+Suites
+------
+
+``check-spec-regen.sh``
+  Regenerates each artifact from the YAML spec and asserts an exact match.
+
+``fabric_abi.py``
+  Queries, events and topology.
+
+``nl_policy_probe.py``
+  Raw Generic Netlink policy probes and family introspection.
+
+``dump_intr_abi.py``
+  ``NLM_F_DUMP_INTR`` on a generation bump mid-dump, and on ``NLMSG_DONE``
+  when the bump lands after the last entry.
+
+``port_cursor_abi.py``
+  Nested port-dump cursor (``cb->args``) across endpoints under removal.
+
+``port_stats_cap_abi.py``
+  Heterogeneous per-port stats: mid-list ``-EOPNOTSUPP`` skipped, other errno
+  ends the dump.
+
+``hotplug_abi.py``
+  Endpoint hotplug: CREATE/DELETE notifications.
+
+``dump_scale_abi.py``
+  Dump resume under many endpoints (``bulk_add``).
+
+``switch_abi.py``
+  Opaque switch peers whose identifiers do not resolve to an endpoint
+  (``topology=switch``).
+
+``fault_abi.py``
+  Provider fault injection: errno propagation and no leaked endpoint
+  (``fail_*``).
+
+``harness_reset_abi.py``
+  Recovery after a SIGKILL-terminated predecessor.
+
+``lib_drm_fabric.py``
+  Shared helpers.
+
+Expected skips
+--------------
+
+A SKIP means a required precondition was unavailable.
+
+Environment
+  ``check-spec-regen.sh`` needs PyYAML and writable temporary storage.
+
+Per case
+  A case skips when a required control, parameter or family capability is
+  unavailable.
+
+Whole suite
+  A program skips when it cannot establish its initial topology.
+
+Timing
+  The two ``dump_intr_abi.py`` boundary cases may skip if the concurrent
+  topology change misses the required dump boundary.
+
+KUnit
+-----
+
+Keep the source tree free of ``.config`` and use an object directory:
+
+.. code-block:: sh
+
+   export KBUILD_OUTPUT="$PWD/.kunit/dev-kernel"
+
+.. code-block:: sh
+
+   ./tools/testing/kunit/kunit.py run \
+       --kunitconfig drivers/gpu/drm/fabric/.kunitconfig 'drm_fabric*'
+
+Debug configuration:
+
+.. code-block:: sh
+
+   ./tools/testing/kunit/kunit.py run --arch x86_64 \
+       --kunitconfig drivers/gpu/drm/fabric/.kunitconfig.debug \
+       --timeout 900 --qemu_args '-m 2048' 'drm_fabric*'
+
+KASAN, UBSAN, kmemleak, lockdep or atomic-sleep reports fail the run.
+
+Netlink ABI
+-----------
+
+Needs root and a booted kernel carrying the modules. See ``config`` for the
+Kconfig fragment; the runner applies the 300-second timeout from ``settings``.
+
+.. code-block:: sh
+
+   sudo make -C tools/testing/selftests TARGETS=drivers/gpu/drm_fabric run_tests
+
+virtme-ng
+---------
+
+Build out-of-tree, boot with ``vng`` and run the same target in the guest:
+
+.. code-block:: sh
+
+   O=.kunit/vng-drm-fabric
+   vng --kconfig \
+       --config tools/testing/selftests/drivers/gpu/drm_fabric/config "O=$O"
+   make -j"$(nproc)" "O=$O" LOCALVERSION=-virtme
+   vng --run "$O" --user root -- \
+       env FABRIC_DIR="$PWD/$O/drivers/gpu/drm/fabric" \
+       make -C tools/testing/selftests TARGETS=drivers/gpu/drm_fabric run_tests
+
+Dependencies (Debian/Ubuntu): ``python3``, ``python3-yaml``,
+``qemu-system-x86``, ``virtme-ng`` (``pip install --user virtme-ng``).
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/check-spec-regen.sh b/tools/testing/selftests/drivers/gpu/drm_fabric/check-spec-regen.sh
new file mode 100755
index 000000000000..aaf67bd04862
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/check-spec-regen.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+#
+# Check that every generated drm_fabric netlink artifact matches its spec.
+#
+# Documentation/netlink/specs/drm_fabric.yaml is authoritative for three
+# generated files that must not be hand-edited: the uAPI header and the
+# kernel-side policy and operation tables. Stale kernel tables still build and
+# pass every test here, because those tests exercise whatever family the tables
+# describe. Reconciliation is directory-scoped, so an artifact generated outside
+# those three directories is not visible. Host only; skips when the spec, a
+# generated file or the ynl generator (python3 + PyYAML) is missing.
+
+DIR="$(dirname "$(readlink -f "$0")")"
+
+. "${DIR}"/../../../kselftest/ktap_helpers.sh
+
+# Six levels up from this directory is the kernel tree root.
+KDIR="${KDIR:-$(readlink -f "${DIR}/../../../../../..")}"
+
+SPEC="Documentation/netlink/specs/drm_fabric.yaml"
+GEN="tools/net/ynl/pyynl/ynl_gen_c.py"
+[ -f "${KDIR}/${GEN}" ] || GEN="tools/net/ynl/ynl_gen_c.py"
+
+FAB="drivers/gpu/drm/fabric"
+UAPI_H="include/uapi/drm/drm_fabric.h"
+NL_C="${FAB}/drm_fabric_nl.c"
+NL_H="${FAB}/drm_fabric_nl.h"
+
+ktap_print_header
+
+if [ ! -f "${KDIR}/${SPEC}" ] || [ ! -f "${KDIR}/${GEN}" ] || \
+   [ ! -f "${KDIR}/${UAPI_H}" ] || [ ! -f "${KDIR}/${NL_C}" ] || \
+   [ ! -f "${KDIR}/${NL_H}" ]; then
+	ktap_skip_all "drm_fabric spec, a generated file or the ynl generator is missing (set KDIR)"
+	exit "${KSFT_SKIP}"
+fi
+
+if ! command -v python3 >/dev/null 2>&1 || ! python3 -c 'import yaml' 2>/dev/null; then
+	ktap_skip_all "python3 with PyYAML is required"
+	exit "${KSFT_SKIP}"
+fi
+
+# An unwritable tmpdir is an environment limit, not a mismatch: skip.
+if ! tmp=$(mktemp -d 2>/dev/null); then
+	ktap_skip_all "no writable temporary directory"
+	exit "${KSFT_SKIP}"
+fi
+trap 'rm -rf "${tmp}"' EXIT
+
+ktap_set_plan 4
+
+# A generated file carries both a YNL-GEN banner and this spec's path.
+for f in "${UAPI_H}" "${NL_C}" "${NL_H}"; do
+	printf '%s\n' "${f}"
+done | sort >"${tmp}/declared"
+
+sed 's|/[^/]*$||' "${tmp}/declared" | sort -u >"${tmp}/dirs"
+
+: >"${tmp}/found"
+while read -r d; do
+	for f in "${KDIR}/${d}"/*.c "${KDIR}/${d}"/*.h; do
+		[ -f "${f}" ] || continue
+		grep -q '^/\* YNL-GEN ' "${f}" || continue
+		grep -qF -- "${SPEC}" "${f}" || continue
+		printf '%s\n' "${f#"${KDIR}/"}"
+	done
+done <"${tmp}/dirs" | sort >"${tmp}/found"
+
+if diff -u "${tmp}/declared" "${tmp}/found" >"${tmp}/diff"; then
+	ktap_test_pass "generated artifacts in the tree are the ones checked here"
+else
+	sed 's/^/# /' "${tmp}/diff"
+	ktap_print_msg "a file generated from ${SPEC} is not on this check's list"
+	ktap_test_fail "generated artifacts in the tree are the ones checked here"
+fi
+
+# Run from KDIR with a relative spec path so banner and guard match.
+check_generated()
+{
+	committed="$1"
+	mode="$2"
+	kind="$3"
+	name="$4"
+	# Includes derive from the basename; give each its own directory.
+	out_dir="${tmp}/${mode}-${kind}"
+	out="${out_dir}/$(basename "${committed}")"
+	mkdir -p "${out_dir}"
+
+	if ! ( cd "${KDIR}" && python3 "${GEN}" --mode "${mode}" --"${kind}" \
+	       --spec "${SPEC}" -o "${out}" ) 2>"${tmp}/err"; then
+		sed 's/^/# /' "${tmp}/err"
+		ktap_test_fail "${name}"
+		return
+	fi
+
+	if diff -u "${KDIR}/${committed}" "${out}" >"${tmp}/diff"; then
+		ktap_test_pass "${name}"
+	else
+		sed 's/^/# /' "${tmp}/diff"
+		ktap_print_msg "regenerate with: tools/net/ynl/ynl-regen.sh -f"
+		ktap_test_fail "${name}"
+	fi
+}
+
+check_generated "${UAPI_H}" uapi header \
+	"drm_fabric uAPI header matches netlink spec"
+check_generated "${NL_C}" kernel source \
+	"drm_fabric netlink ops and policy match netlink spec"
+check_generated "${NL_H}" kernel header \
+	"drm_fabric netlink kernel header matches netlink spec"
+
+ktap_finished
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/config b/tools/testing/selftests/drivers/gpu/drm_fabric/config
new file mode 100644
index 000000000000..6eaab8a7d771
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/config
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kernel config fragment required to run the drm_fabric kselftests.
+# Merge with: scripts/kconfig/merge_config.sh or make kselftest-merge.
+CONFIG_NET=y
+CONFIG_DRM=y
+CONFIG_DEBUG_FS=y
+CONFIG_DRM_FABRIC=m
+CONFIG_DRM_FABRIC_SIM=m
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/dump_intr_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/dump_intr_abi.py
new file mode 100755
index 000000000000..0f913c38bbc3
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/dump_intr_abi.py
@@ -0,0 +1,361 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Tests NLM_F_DUMP_INTR when a topology change lands mid-dump or after the
+last entry. pyynl decodes attributes but never surfaces nlmsg_flags, so
+this talks raw Generic Netlink.
+
+Needs drm_fabric + drm_fabric_sim, fabricsim debugfs (bulk_add), and root.
+"""
+
+import glob
+import os
+import re
+import socket
+import struct
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L  # noqa: E402 - shared KTAP/module helpers (no pyynl)
+
+# --- Netlink / generic-netlink constants (cf. nl_policy_probe.py) ---------
+
+NETLINK_GENERIC = 16
+NLMSG_ERROR = 0x2
+NLMSG_DONE = 0x3
+NLM_F_REQUEST = 0x01
+NLM_F_MULTI = 0x02
+NLM_F_DUMP = 0x300
+NLM_F_DUMP_INTR = 0x10
+NLMSG_HDRLEN = 16
+GENL_HDRLEN = 4
+CTRL_ID = 0x10
+CTRL_CMD_GETFAMILY = 3
+CTRL_ATTR_FAMILY_NAME = 2
+CTRL_ATTR_FAMILY_ID = 1
+
+# Population large enough that ENDPOINT_GET spans several dump skbs (so there is
+# a between-batch window to mutate). Overridable for slow/fast machines.
+SCALE = int(os.environ.get("DUMP_INTR_SCALE", "600"))
+
+
+def _align4(n):
+    return (n + 3) & ~3
+
+
+def _nla(atype, payload):
+    length = 4 + len(payload)
+    pad = b"\x00" * (_align4(length) - length)
+    return struct.pack("=HH", length, atype) + payload + pad
+
+
+def _msg(family_id, cmd, seq, flags, payload=b""):
+    body = struct.pack("=BBH", cmd, 1, 0) + payload
+    total = NLMSG_HDRLEN + len(body)
+    return struct.pack("=IHHII", total, family_id, flags, seq, 0) + body
+
+
+def _open():
+    s = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, NETLINK_GENERIC)
+    s.bind((0, 0))
+    s.settimeout(5)
+    return s
+
+
+def _resolve_family(sock, name):
+    sock.send(_msg(CTRL_ID, CTRL_CMD_GETFAMILY, 1, NLM_F_REQUEST,
+                   _nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00")))
+    data = sock.recv(8192)
+    (_, mtype, _, _, _) = struct.unpack_from("=IHHII", data, 0)
+    if mtype == NLMSG_ERROR:
+        return None
+    off = NLMSG_HDRLEN + GENL_HDRLEN
+    while off + 4 <= len(data):
+        (alen, atype) = struct.unpack_from("=HH", data, off)
+        if alen < 4:
+            break
+        if atype == CTRL_ATTR_FAMILY_ID:
+            # CTRL_ATTR_FAMILY_ID is a u16; tolerate a u32 encoding too.
+            if alen >= 8:
+                return struct.unpack_from("=I", data, off + 4)[0]
+            if alen >= 6:
+                return struct.unpack_from("=H", data, off + 4)[0]
+        off += _align4(alen)
+    return None
+
+
+def _cmd_id(wanted, fallback):
+    """Resolve @wanted from the generated uAPI drm_fabric_cmd enum."""
+    try:
+        text = open(L.UAPI_HEADER).read()
+        m = re.search(r"enum\s+drm_fabric_cmd\s*\{(.*?)\}", text, re.S)
+        if m:
+            n = 0
+            for raw in re.sub(r"/\*.*?\*/", "", m.group(1), flags=re.S).split(","):
+                item = raw.strip()
+                if not item:
+                    continue
+                if "=" in item:
+                    name, val = item.split("=", 1)
+                    name, n = name.strip(), int(val.strip(), 0)
+                else:
+                    name = item
+                if name == wanted:
+                    return n
+                n += 1
+    except (OSError, ValueError):
+        pass
+    return fallback
+
+
+def _read_msgs(sock):
+    """Read one dump datagram as (msgs, timed_out): (nlmsg_type, nlmsg_flags)
+    pairs. A timeout is reported explicitly, never conflated with a real
+    NLMSG_DONE.
+    """
+    try:
+        data = sock.recv(65536)
+    except socket.timeout:
+        return [], True
+    msgs, off = [], 0
+    while off + NLMSG_HDRLEN <= len(data):
+        (mlen, mtype, mflags, _, _) = struct.unpack_from("=IHHII", data, off)
+        if mlen < NLMSG_HDRLEN:
+            break
+        msgs.append((mtype, mflags))
+        off += _align4(mlen)
+    return msgs, False
+
+
+def _read_batch(sock):
+    """Read one dump datagram as (list_of_flags, saw_done, saw_error, timed_out)."""
+    msgs, timed_out = _read_msgs(sock)
+    if timed_out:
+        return [], False, False, True
+    return ([f for (_, f) in msgs],
+            any(t == NLMSG_DONE for (t, _) in msgs),
+            any(t == NLMSG_ERROR for (t, _) in msgs),
+            False)
+
+
+def _dump(sock, fam, cmd, mutate_after_first=None):
+    """Run an ENDPOINT_GET dump batch-by-batch; returns (batches, intr_seen,
+    err_seen, saw_done, timed_out). @mutate_after_first, if given, runs
+    once between the first and second batch.
+    """
+    sock.send(_msg(fam, cmd, 2, NLM_F_REQUEST | NLM_F_DUMP))
+    batches, intr, err, done, timed_out, mutated = 0, False, False, False, False, False
+    while not done:
+        flags, done, e, to = _read_batch(sock)
+        if to:
+            timed_out = True
+            break
+        if not flags:
+            break
+        batches += 1
+        err = err or e
+        if any(f & NLM_F_DUMP_INTR for f in flags):
+            intr = True
+        if mutate_after_first and not mutated:
+            mutate_after_first()
+            mutated = True
+        if batches > 10000:            # runaway guard
+            break
+    return batches, intr, err, done, timed_out
+
+
+class Cfg:
+    def __init__(self, fam, cmd, stats_cmd):
+        self.fam = fam
+        self.cmd = cmd
+        self.stats_cmd = stats_cmd
+
+
+def test_multi_skb_dump_available(ksft, cfg):
+    """Precondition: the population makes ENDPOINT_GET span >1 dump batch."""
+    s = _open()
+    batches, _, err, done, to = _dump(s, cfg.fam, cfg.cmd)
+    s.close()
+    ok = ksft.check(batches >= 2 and not err and done and not to,
+                    "dump-spans-multiple-batches",
+                    "batches=%d err=%s done=%s timeout=%s (raise DUMP_INTR_SCALE)"
+                    % (batches, err, done, to))
+    if not ok:
+        cfg.abort = True   # the INTR cases below are meaningless single-batch
+
+
+def test_no_intr_when_quiescent(ksft, cfg):
+    """A quiescent dump must complete with a real NLMSG_DONE (not a socket
+    timeout) and no NLM_F_DUMP_INTR; a stalled dump is a failure, not a
+    silent pass.
+    """
+    s = _open()
+    batches, intr, err, done, to = _dump(s, cfg.fam, cfg.cmd)
+    s.close()
+    ksft.check(done and not to and not intr and not err, "quiescent-dump-no-intr",
+               "done=%s timeout=%s intr=%s err=%s batches=%d"
+               % (done, to, intr, err, batches))
+
+
+def _find_oper_state():
+    """A fabricsim per-port oper_state debugfs knob, if any (baseline ports)."""
+    m = glob.glob(os.path.join(L.DEBUGFS, "*", "*", "oper_state"))
+    return m[0] if m else None
+
+
+def test_intr_on_mutation_mid_dump(ksft, cfg):
+    """A base_seq bump during a multi-skb dump must raise NLM_F_DUMP_INTR.
+
+    oper_state writes are synchronous, unlike bulk_add, so the generation
+    changes before netlink's one-skb-ahead prefill snapshots it.
+    """
+    oper = _find_oper_state()
+    if not oper:
+        ksft.skip("mutation-mid-dump-sets-intr", "no fabricsim oper_state knob")
+        return
+    rel = os.path.relpath(oper, L.DEBUGFS)
+    states = ("active", "degraded")
+
+    s = _open()
+    s.send(_msg(cfg.fam, cfg.cmd, 3, NLM_F_REQUEST | NLM_F_DUMP))
+    intr = err = timed_out = False
+    batches = i = 0
+    done = False
+    while not done:
+        flags, done, e, to = _read_batch(s)
+        if to:
+            timed_out = True
+            break
+        if not flags:
+            break
+        batches += 1
+        err = err or e
+        if any(f & NLM_F_DUMP_INTR for f in flags):
+            intr = True
+        # Synchronous generation bump between batches (state must change to
+        # take effect, so alternate the two values).
+        try:
+            L.dbg_write(rel, states[i % 2])
+            i += 1
+        except OSError:
+            pass
+        if batches > 10000:
+            break
+    s.close()
+
+    # The dump must both observe the interruption and still terminate cleanly
+    # (a real NLMSG_DONE, not a stall).
+    ksft.check(intr and done and not timed_out and not err,
+               "mutation-mid-dump-sets-intr",
+               "intr=%s done=%s timeout=%s err=%s batches=%d"
+               % (intr, done, timed_out, err, batches))
+
+
+def test_intr_on_post_exhaustion_mutation(ksft, cfg):
+    """A topology change after the final entry must still be reported on
+    NLMSG_DONE.
+
+    A dump handler that samples the generation only once it has a record in
+    hand leaves a hole: a batch that finds the cursor already exhausted emits
+    nothing, so it never samples, and NLMSG_DONE goes out carrying the
+    generation from the previous batch.
+    """
+    s = _open()
+    s.send(_msg(cfg.fam, cfg.stats_cmd, 4, NLM_F_REQUEST | NLM_F_DUMP))
+
+    name = "post-exhaustion-mutation-sets-intr"
+    try:
+        msgs, timed_out = _read_msgs(s)
+        entries = sum(1 for (t, _) in msgs if t == cfg.fam)
+        if timed_out or not entries or any(t == NLMSG_DONE for (t, _) in msgs):
+            ksft.skip(name, "PORT_STATS_GET did not park mid-dump "
+                            "(entries=%d timeout=%s)" % (entries, timed_out))
+            return
+
+        # Retire everything ahead of the cursor while the dump is parked. The
+        # dump only advances when we read, so settling here cannot let it run
+        # past the mutation.
+        try:
+            L.dbg_write("bulk_del", 0)
+        except OSError as exc:
+            ksft.skip(name, "bulk_del failed: %s" % exc)
+            return
+        L.settle(0.3)
+
+        # Netlink prefills one skb ahead, so the next read still delivers
+        # entries serialized before the mutation. Those carry the old
+        # generation and leave the pending inconsistency untouched.
+        done_flags, entry_intr, err = None, False, False
+        for _ in range(10000):
+            msgs, timed_out = _read_msgs(s)
+            if timed_out or not msgs:
+                break
+            for (mtype, mflags) in msgs:
+                if mtype == cfg.fam:
+                    entry_intr = entry_intr or bool(mflags & NLM_F_DUMP_INTR)
+                elif mtype == NLMSG_ERROR:
+                    err = True
+                elif mtype == NLMSG_DONE:
+                    done_flags = mflags
+            if done_flags is not None:
+                break
+
+        # An entry that already carried the flag means the interruption was
+        # reported mid-dump and the consistency check reset with it, so
+        # NLMSG_DONE need not repeat it. That is the mid-dump path, covered by
+        # the case above, and it cannot stand in for this one.
+        if entry_intr:
+            ksft.skip(name, "interruption reported on an entry; the "
+                            "exhaustion path was not isolated")
+            return
+
+        ksft.check(done_flags is not None and
+                   bool(done_flags & NLM_F_DUMP_INTR) and not err, name,
+                   "done_flags=%s err=%s"
+                   % ("none" if done_flags is None else hex(done_flags), err))
+    finally:
+        s.close()
+        # Restore the population for whatever runs next.
+        try:
+            L.dbg_write("bulk_add", SCALE)
+        except OSError:
+            pass
+        L.settle(0.3)
+
+
+CASES = (
+    test_multi_skb_dump_available,
+    test_no_intr_when_quiescent,
+    test_intr_on_mutation_mid_dump,
+    test_intr_on_post_exhaustion_mutation,
+)
+
+
+def main():
+    ksft = L.Ksft()
+
+    with L.fabricsim(ksft, need_debugfs=True, need_control="bulk_add",
+                     open_family=False):
+        sock = _open()
+        fam = _resolve_family(sock, L.FAMILY.encode())
+        sock.close()
+        if not fam:
+            ksft.skip_all("cannot resolve drm-fabric genl family")
+
+        # Grow the population so the dump pages across several skbs.
+        try:
+            L.dbg_write("bulk_add", SCALE)
+        except OSError as exc:
+            ksft.skip_all("bulk_add failed: %s" % exc)
+        L.settle(0.3)
+
+        cfg = Cfg(fam,
+                  _cmd_id("DRM_FABRIC_CMD_ENDPOINT_GET", 2),
+                  _cmd_id("DRM_FABRIC_CMD_PORT_STATS_GET", 4))
+        L.run_cases(ksft, cfg, CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/dump_scale_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/dump_scale_abi.py
new file mode 100755
index 000000000000..fedf35f51eff
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/dump_scale_abi.py
@@ -0,0 +1,178 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Forces netlink dump pagination (cb->args) with fabricsim's bulk_add/bulk_del,
+past what the small object counts in other suites would ever trigger, and
+verifies every dump returns the full set exactly once, including under
+concurrent churn.
+
+Requires drm_fabric + drm_fabric_sim with fabricsim debugfs; run as root.
+"""
+
+import os
+import sys
+import threading
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+# Enough endpoints that the ENDPOINT_GET reply spans several skbs (each entry
+# carries id/fabric-id/fabric-ep-id/name/dev-name/bus-name/admin nests).
+SCALE = int(os.environ.get("DUMP_SCALE", "300"))
+
+
+def ep_ids(fab):
+    return [e["endpoint"]["endpoint-id"] for e in fab.dump("endpoint-get", {})]
+
+
+def port_count(fab):
+    return len(list(fab.dump("port-get", {})))
+
+
+class Cfg:
+    """Carries the pre-scale baseline counts so the teardown case can assert
+    the population is restored exactly."""
+
+    def __init__(self, fab, nl_error, base_ids, base_ports, fid):
+        self.fab = fab
+        self.NlError = nl_error
+        self.base_ids = base_ids
+        self.base_n = len(base_ids)
+        self.base_ports = base_ports
+        self.fid = fid
+
+
+def test_scale_dump(ksft, cfg):
+    fab = cfg.fab
+    try:
+        L.dbg_write("bulk_add", SCALE)
+    except OSError as exc:
+        ksft.skip_all("bulk_add failed: %s" % exc)
+    L.wait_until(lambda: len(ep_ids(fab)) >= cfg.base_n + SCALE, timeout=10)
+
+    ids = ep_ids(fab)
+    ksft.check(len(ids) == cfg.base_n + SCALE, "scale-endpoint-dump-count",
+               "want %d got %d" % (cfg.base_n + SCALE, len(ids)))
+    ksft.check(len(set(ids)) == len(ids), "scale-endpoint-dump-unique",
+               "%d dups" % (len(ids) - len(set(ids))))
+    ksft.check(set(cfg.base_ids).issubset(set(ids)),
+               "scale-endpoint-dump-keeps-baseline")
+
+    pc = port_count(fab)
+    ksft.check(pc == cfg.base_ports + SCALE, "scale-port-dump-count",
+               "want %d got %d" % (cfg.base_ports + SCALE, pc))
+
+    if cfg.fid is not None:
+        flt = [e["endpoint"] for e in fab.dump("endpoint-get",
+                                               {"fabric-id": cfg.fid})]
+        ksft.check(all(e.get("fabric-id") == cfg.fid for e in flt) and
+                   len(flt) >= SCALE, "scale-endpoint-dump-filtered",
+                   "got %d members" % len(flt))
+    else:
+        ksft.skip("scale-endpoint-dump-filtered", "fabricsim fabric absent")
+
+
+def test_dump_consistency_under_churn(ksft, cfg):
+    """Hammer multi-skb dumps while a helper thread churns the population."""
+    fab = cfg.fab
+    pre_churn = len(ep_ids(fab))
+    L.dbg_write("bulk_add", SCALE)
+    L.wait_until(lambda: len(ep_ids(fab)) > pre_churn, timeout=10)
+    stop = threading.Event()
+    churn_err = []
+
+    def churn():
+        while not stop.is_set():
+            try:
+                L.dbg_write("bulk_del", 0)
+                # Re-check before re-populating so the last iteration does not
+                # add a fresh SCALE population that would race the teardown.
+                if stop.is_set():
+                    break
+                L.dbg_write("bulk_add", SCALE)
+            except OSError:
+                # racy debugfs writes may transiently fail; not a dump bug
+                pass
+            except Exception as exc:  # noqa: BLE001
+                churn_err.append(str(exc))
+                return
+
+    worst_dups = 0
+    dump_err = None
+    # The join below is the real synchronization point; the case aborts if it
+    # times out. Mark the worker daemon so a wedged iteration cannot also hang
+    # interpreter shutdown after that failure has already been reported.
+    t = threading.Thread(target=churn, daemon=True)
+    t.start()
+    try:
+        for _ in range(60):
+            d = ep_ids(fab)
+            worst_dups = max(worst_dups, len(d) - len(set(d)))
+    except Exception as exc:  # noqa: BLE001
+        dump_err = str(exc)
+    finally:
+        stop.set()
+        t.join(timeout=30)          # each churn iteration is bounded
+
+    # A worker that will not terminate is a harness failure, not something to
+    # leave running into the next case; abort so the teardown case cannot race
+    # an in-flight bulk_add.
+    if not ksft.check(not t.is_alive(), "dump-churn-worker-terminates",
+                      "churn worker still alive after join"):
+        cfg.abort = True
+        return
+
+    # Assert *no duplicates* (the invariant a broken cb->args resume would
+    # violate), not *no omissions*: under concurrent churn the population
+    # legitimately changes between skbs, so a missing id is expected here and
+    # only a duplicated id signals a dump-resume bug.
+    ksft.check(worst_dups == 0 and dump_err is None and not churn_err,
+               "dump-consistency-no-dup-under-churn",
+               "dups=%d dump_err=%s churn_err=%s"
+               % (worst_dups, dump_err, churn_err[:1]))
+
+    # Worker has exited: drain the churn population back to baseline so the
+    # teardown case (and the next suite) starts from a known, quiescent count.
+    L.dbg_write("bulk_del", 0)
+    L.wait_until(lambda: len(ep_ids(fab)) == cfg.base_n, timeout=10)
+
+
+def test_scale_teardown(ksft, cfg):
+    fab = cfg.fab
+    try:
+        L.dbg_write("bulk_del", 1)
+    except OSError as exc:
+        ksft.not_ok("scale-teardown", "bulk_del failed: %s" % exc)
+        return
+    L.wait_until(lambda: len(ep_ids(fab)) == cfg.base_n, timeout=10)
+    ksft.check(len(ep_ids(fab)) == cfg.base_n, "scale-teardown-restores-baseline",
+               "want %d got %d" % (cfg.base_n, len(ep_ids(fab))))
+
+
+CASES = (
+    test_scale_dump,
+    test_dump_consistency_under_churn,
+    test_scale_teardown,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+
+    with L.fabricsim(ksft, need_debugfs=True, need_control="bulk_add") as fab:
+        base_ids = ep_ids(fab)
+        base_ports = port_count(fab)
+        fid = None
+        for f in fab.dump("fabric-get", {}):
+            if f["fabric"]["name"] == "fabricsim":
+                fid = f["fabric"]["fabric-id"]
+                break
+
+        L.run_cases(ksft, Cfg(fab, NlError, base_ids, base_ports, fid), CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py
new file mode 100755
index 000000000000..94cc1078a365
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py
@@ -0,0 +1,401 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Full drm-fabric genetlink ABI coverage via YNL against fabricsim: every
+command (do + dump) and event, asserted on decoded reply dicts so checks
+are immune to CLI text changes.
+
+Usage: fabric_abi.py [--no-load]   (--no-load: modules already loaded)
+"""
+
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+EVT_DURATION = float(os.environ.get("EVT_DURATION", "3"))
+# Multicast subscription is synchronous (setsockopt), so a brief settle before
+# triggering is enough; wait_ntf() then polls with a deadline for the arrival.
+EVT_SETTLE = float(os.environ.get("EVT_SETTLE", "0.2"))
+
+
+def _unload_providers():
+    L.rmmod("drm_fabric_sim")
+    L.rmmod("drm_fabric")
+
+
+def fabric_names(fab):
+    return [e["fabric"]["name"] for e in fab.dump("fabric-get", {})]
+
+
+def ep_list(fab, filt=None):
+    return [e["endpoint"] for e in fab.dump("endpoint-get", filt or {})]
+
+
+def port_list(fab, ep_id):
+    return [p["port"] for p in fab.dump("port-get", {"endpoint-id": ep_id})]
+
+
+def peers_in(ports):
+    return [p["peer"]["peer-id"] for p in ports if "peer" in p]
+
+
+def _reload_sim(shape):
+    L.rmmod("drm_fabric_sim")
+    L.insmod("drm-fabric-sim.ko", "topology=%s" % shape)
+    L.wait_until(lambda: L.module_loaded("drm_fabric_sim"))
+
+
+class Cfg:
+    def __init__(self, fab, fid, dfs, no_load, nl_error):
+        self.fab = fab
+        self.fid = fid
+        self.dfs = dfs
+        self.no_load = no_load
+        self.NlError = nl_error
+
+
+def test_fabric_get(ksft, cfg):
+    fab = cfg.fab
+    ksft.check("fabricsim" in fabric_names(fab), "fabric-get-dump")
+    f = fab.do("fabric-get", {"fabric-id": cfg.fid})
+    ksft.check(f["fabric"]["name"] == "fabricsim", "fabric-get-do")
+
+
+def test_endpoint_get_dump(ksft, cfg):
+    fab = cfg.fab
+    eps = ep_list(fab)
+    ksft.check(len(eps) == 4, "endpoint-get-dump", "got %d" % len(eps))
+    epf = ep_list(fab, {"fabric-id": cfg.fid})
+    ksft.check(len(epf) == 4, "endpoint-get-dump-filtered", "got %d" % len(epf))
+
+
+def test_endpoint_get_do(ksft, cfg):
+    fab = cfg.fab
+    e0 = fab.do("endpoint-get", {"endpoint-id": 0})
+    ksft.check(e0["endpoint"]["name"] == "sim-ep0", "endpoint-get-do")
+    e = fab.do("endpoint-get", {"dev-name": "fabricsim.0"})
+    ksft.check(e["endpoint"]["name"] == "sim-ep0", "endpoint-get-do-by-dev-name")
+    e = fab.do("endpoint-get", {"dev-name": "fabricsim.1", "bus-name": "platform"})
+    ksft.check(e["endpoint"]["name"] == "sim-ep1",
+               "endpoint-get-do-by-dev-name-bus")
+    e = fab.do("endpoint-get", {"endpoint-id": 0, "dev-name": "fabricsim.0"})
+    ksft.check(e["endpoint"]["name"] == "sim-ep0",
+               "endpoint-get-do-id-and-dev-name-agree")
+
+
+def test_endpoint_get_do_errors(ksft, cfg):
+    fab, NlError = cfg.fab, cfg.NlError
+    try:
+        fab.do("endpoint-get", {"endpoint-id": 0, "dev-name": "fabricsim.1"})
+        ksft.not_ok("endpoint-get-do-id-dev-name-conflict-einval", "accepted")
+    except NlError as exc:
+        ksft.check(L.nl_errno(exc) == 22,  # EINVAL
+                   "endpoint-get-do-id-dev-name-conflict-einval",
+                   "errno=%d" % L.nl_errno(exc))
+    try:
+        fab.do("endpoint-get", {"bus-name": "platform"})
+        ksft.not_ok("endpoint-get-do-bus-name-only-einval", "accepted")
+    except NlError as exc:
+        ksft.check(L.nl_errno(exc) == 22, "endpoint-get-do-bus-name-only-einval",
+                   "errno=%d" % L.nl_errno(exc))
+    try:
+        fab.do("endpoint-get", {"dev-name": "nope.99"})
+        ksft.not_ok("endpoint-get-do-dev-name-enoent", "accepted")
+    except NlError as exc:
+        ksft.check(L.nl_errno(exc) == 2, "endpoint-get-do-dev-name-enoent",
+                   "errno=%d" % L.nl_errno(exc))
+
+
+def test_port_get(ksft, cfg):
+    fab = cfg.fab
+    p0 = port_list(fab, 0)
+    ksft.check(len(p0) == 4, "port-get-dump", "got %d" % len(p0))
+    port = fab.do("port-get", {"endpoint-id": 0, "port-index": 0})["port"]
+    ksft.check(port["oper-state"] == "active" and "peer" in port, "port-get-do")
+    ksft.check(port.get("peer", {}).get("peer-id") == 257,
+               "port-get-peer-data")
+
+
+def test_port_stats(ksft, cfg):
+    fab = cfg.fab
+    st = fab.do("port-stats-get", {"endpoint-id": 0, "port-index": 0})["port-stats"]
+    ksft.check(st.get("read-bytes", -1) == 0 and st.get("write-bytes", -1) == 0,
+               "port-stats-get-do")
+    stats = fab.dump("port-stats-get", {"endpoint-id": 0})
+    ksft.check(len(stats) == 4, "port-stats-get-dump", "got %d" % len(stats))
+
+
+def test_activity_stats(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("activity-stats-increment", "debugfs not available")
+        return
+    fab = cfg.fab
+    L.dbg_write("ep0/port0/read_rate", 1024)
+    L.dbg_write("ep0/port0/write_rate", 512)
+    L.dbg_write("ep0/port0/activity_enable", 1)
+
+    def _stats():
+        return fab.do("port-stats-get",
+                      {"endpoint-id": 0, "port-index": 0})["port-stats"]
+
+    L.wait_until(lambda: _stats().get("read-bytes", 0) > 0 and
+                 _stats().get("write-bytes", 0) > 0)
+    L.dbg_write("ep0/port0/activity_enable", 0)
+    s = _stats()
+    ksft.check(s.get("read-bytes", 0) > 0 and s.get("write-bytes", 0) > 0,
+               "activity-stats-increment",
+               "read=%s write=%s" % (s.get("read-bytes"), s.get("write-bytes")))
+
+
+def test_inject_link_down(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("inject-link-down-oper-inactive", "debugfs not available")
+        return
+    fab = cfg.fab
+    L.dbg_write("ep1/port0/inject", "link_down")
+    p = fab.do("port-get", {"endpoint-id": 1, "port-index": 0})["port"]
+    ksft.check(p["oper-state"] == "inactive", "inject-link-down-oper-inactive",
+               "oper=%s" % p["oper-state"])
+    L.dbg_write("ep1/port0/inject", "recover_to_active")
+
+
+def test_oper_state_degraded(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("debugfs-oper-state-degraded", "debugfs not available")
+        return
+    fab = cfg.fab
+    L.dbg_write("ep2/port0/oper_state", "degraded")
+    p = fab.do("port-get", {"endpoint-id": 2, "port-index": 0})["port"]
+    ksft.check(p["oper-state"] == "degraded", "debugfs-oper-state-degraded",
+               "oper=%s" % p["oper-state"])
+    L.dbg_write("ep2/port0/oper_state", "active")
+
+
+def test_topology_kn(ksft, cfg):
+    fab = cfg.fab
+    peers = set(peers_in(port_list(fab, 0)))
+    ksft.check(len(peers) == 3, "topology-kn-distinct-peers",
+               "distinct peers=%d" % len(peers))
+    p = fab.do("port-get", {"endpoint-id": 1, "port-index": 0})["port"]
+    ksft.check(p.get("peer", {}).get("peer-id") == 256,
+               "topology-kn-bidirectional")
+    p = fab.do("port-get", {"endpoint-id": 0, "port-index": 3})["port"]
+    ksft.check("peer" not in p, "port-no-peer")
+
+
+def test_counters_stop(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("counters-stop-after-disable", "debugfs not available")
+        return
+    fab = cfg.fab
+
+    def _rb():
+        return fab.do("port-stats-get",
+                      {"endpoint-id": 0, "port-index": 0})["port-stats"]["read-bytes"]
+
+    r1 = _rb()
+    # Proving a *non-event* (counters must NOT advance after disable) needs a
+    # real wait; poll a bounded window and assert the value never moved.
+    moved = L.wait_until(lambda: _rb() != r1, timeout=0.5)
+    ksft.check(not moved, "counters-stop-after-disable",
+               "read-bytes moved from %s to %s" % (r1, _rb()))
+
+
+def test_port_state_cycle(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("port-state-inject-cycle", "debugfs not available")
+        return
+    fab = cfg.fab
+    L.dbg_write("ep2/port1/oper_state", "active")
+    L.dbg_write("ep2/port1/inject", "degrade")
+    s1 = fab.do("port-get", {"endpoint-id": 2, "port-index": 1})["port"]["oper-state"]
+    L.dbg_write("ep2/port1/inject", "link_down")
+    s2 = fab.do("port-get", {"endpoint-id": 2, "port-index": 1})["port"]["oper-state"]
+    L.dbg_write("ep2/port1/inject", "recover_to_active")
+    s3 = fab.do("port-get", {"endpoint-id": 2, "port-index": 1})["port"]["oper-state"]
+    ksft.check(s1 == "degraded" and s2 == "inactive" and s3 == "active",
+               "port-state-inject-cycle", "%s,%s,%s" % (s1, s2, s3))
+
+
+def test_port_change_ntf(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("port-change-ntf-notification", "debugfs not available")
+        return
+    fab = cfg.fab
+    L.dbg_write("ep1/port1/oper_state", "active")
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+    L.dbg_write("ep1/port1/oper_state", "degraded")
+    got = L.wait_ntf(ev, "port-change-ntf", timeout=EVT_DURATION,
+                     match=lambda n: n["msg"]["port"].get("oper-state") == "degraded")
+    ksft.check(got is not None, "port-change-ntf-notification")
+    # The event carries the post-change topology-generation (nonzero); a
+    # subsequent GET reports a generation that is >= the event's.
+    if got is not None:
+        egen = got["msg"].get("topology-generation")
+        ggen = fab.do("port-get",
+                      {"endpoint-id": 1, "port-index": 1}).get("topology-generation")
+        ksft.check(egen is not None and egen != 0 and
+                   ggen is not None and ggen >= egen,
+                   "port-change-ntf-topology-generation",
+                   "event=%s get=%s" % (egen, ggen))
+    L.dbg_write("ep1/port1/oper_state", "active")
+
+
+def test_linear_topology(ksft, cfg):
+    """Reload the sim into the linear topology and assert the chain shape.
+    Restores the default mesh K_4 on the way out (even on failure), so
+    this cannot cascade into later cases that assume the default topology.
+    """
+    if cfg.no_load:
+        ksft.skip("linear-topology-chain", "skipped with --no-load")
+        ksft.skip("linear-topology-adjacent-peers", "skipped with --no-load")
+        ksft.skip("linear-topology-end-no-extra-peer", "skipped with --no-load")
+        ksft.skip("linear-topology-debugfs-works",
+                  "skipped with --no-load or no debugfs")
+        return
+    fab = cfg.fab
+    _reload_sim("linear")
+    try:
+        n0 = len(peers_in(port_list(fab, 0)))
+        n1 = len(peers_in(port_list(fab, 1)))
+        n3 = len(peers_in(port_list(fab, 3)))
+        ksft.check(n0 == 1 and n1 == 2 and n3 == 1, "linear-topology-chain",
+                   "ep0=%d ep1=%d ep3=%d" % (n0, n1, n3))
+        ps = peers_in(port_list(fab, 0))
+        ksft.check(ps and ps[0] == 257, "linear-topology-adjacent-peers",
+                   "ep0 peers=%s" % ps)
+        p = fab.do("port-get", {"endpoint-id": 0, "port-index": 1})["port"]
+        ksft.check("peer" not in p, "linear-topology-end-no-extra-peer")
+        if cfg.dfs:
+            L.dbg_write("ep0/port0/oper_state", "degraded")
+            p = fab.do("port-get", {"endpoint-id": 0, "port-index": 0})["port"]
+            ksft.check(p["oper-state"] == "degraded",
+                       "linear-topology-debugfs-works")
+            L.dbg_write("ep0/port0/oper_state", "active")
+        else:
+            ksft.skip("linear-topology-debugfs-works",
+                      "skipped with --no-load or no debugfs")
+    finally:
+        # Always return to the default mesh K_4 shape for the cases that follow.
+        _reload_sim("mesh")
+
+
+def test_reload_mesh(ksft, cfg):
+    """Defensively re-establish the default mesh K_N topology (idempotent)
+    and assert it, guaranteeing the precondition for the RAS/NTF cases
+    that follow even if an earlier reload failed.
+    """
+    if cfg.no_load:
+        ksft.skip("reload-mesh-topology-restored", "skipped with --no-load")
+        return
+    fab = cfg.fab
+    _reload_sim("mesh")
+    n0 = len(peers_in(port_list(fab, 0)))
+    ksft.check(n0 == 3, "reload-mesh-topology-restored", "ep0 peers=%d" % n0)
+
+
+def test_port_change_ntf_full(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("port-change-ntf-full-port-nest", "debugfs not available")
+        return
+    L.dbg_write("ep0/port0/oper_state", "active")
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+    L.dbg_write("ep0/port0/oper_state", "degraded")
+    got = L.wait_ntf(
+        ev, "port-change-ntf", timeout=EVT_DURATION,
+        match=lambda n: "endpoint-id" in n["msg"]["port"] and
+        "port-index" in n["msg"]["port"])
+    ksft.check(got is not None, "port-change-ntf-full-port-nest")
+    L.dbg_write("ep0/port0/oper_state", "active")
+
+
+def test_link_down_exact_count(ksft, cfg):
+    if not cfg.dfs:
+        ksft.skip("inject-link-down-exact-count", "debugfs not available")
+        return
+    fab = cfg.fab
+    base = fab.do("port-stats-get",
+                  {"endpoint-id": 3, "port-index": 1})["port-stats"]
+    c0 = base.get("link-down-count", 0)
+    for _ in range(3):
+        L.dbg_write("ep3/port1/inject", "link_down")
+    s = fab.do("port-stats-get",
+               {"endpoint-id": 3, "port-index": 1})["port-stats"]
+    ksft.check(s.get("link-down-count", 0) == c0 + 3,
+               "inject-link-down-exact-count",
+               "expected %d got %s" % (c0 + 3, s.get("link-down-count")))
+    L.dbg_write("ep3/port1/inject", "recover_to_active")
+
+
+# Ordered scenario: each case builds on the topology/state left by the prior
+# one (e.g. the linear reload precedes its assertions, and the mesh reload
+# restores K_N for the stats cases). Keep this list in order.
+CASES = (
+    test_fabric_get,
+    test_endpoint_get_dump,
+    test_endpoint_get_do,
+    test_endpoint_get_do_errors,
+    test_port_get,
+    test_port_stats,
+    test_activity_stats,
+    test_inject_link_down,
+    test_oper_state_degraded,
+    test_topology_kn,
+    test_counters_stop,
+    test_port_state_cycle,
+    test_port_change_ntf,
+    test_linear_topology,
+    test_reload_mesh,
+    test_port_change_ntf_full,
+    test_link_down_exact_count,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+
+    if not L.is_root():
+        ksft.skip_all("must run as root (genetlink + debugfs + insmod)")
+
+    no_load = "--no-load" in sys.argv[1:]
+
+    if not no_load:
+        L.rmmod("drm_fabric_sim")
+        L.rmmod("drm_fabric")
+        # Arm teardown before loading so a partial load is unwound, and so the
+        # topology reshapes this suite performs are restored even if the timeout
+        # killer sends SIGTERM (which a bare atexit would miss).
+        L.on_teardown(_unload_providers)
+        if not L.insmod("drm-fabric.ko") or not L.insmod("drm-fabric-sim.ko"):
+            ksft.skip_all("could not load drm_fabric + drm_fabric_sim modules")
+        L.wait_until(lambda: L.module_loaded("drm_fabric_sim"))
+
+    if not L.module_loaded("drm_fabric"):
+        ksft.skip_all("drm_fabric not loaded")
+    if not L.module_loaded("drm_fabric_sim"):
+        ksft.skip_all("drm_fabric_sim not loaded")
+
+    try:
+        fab = L.DrmFabric()
+    except (OSError, NlError) as exc:
+        ksft.skip_all("cannot open drm-fabric family: %s" % exc)
+
+    # fabric-id 0 is reserved; discover the live provider fabric id.
+    fabrics = fab.dump("fabric-get", {})
+    fid = fabrics[0]["fabric"]["fabric-id"] if fabrics else 1
+
+    cfg = Cfg(fab, fid, L.debugfs_available(), no_load, NlError)
+    L.run_cases(ksft, cfg, CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py
new file mode 100755
index 000000000000..8ea2d1de93d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py
@@ -0,0 +1,105 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Provider fault injection via fabricsim's fail_register debugfs toggle (cf.
+netdevsim's should_fail): a failed provider-driven endpoint create must
+surface the provider's errno and leak no endpoint, succeeding once the
+fault is cleared.
+
+Requires drm_fabric + drm_fabric_sim with fabricsim debugfs; run as root.
+"""
+
+import errno
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+
+def eps_by_name(fab):
+    return {e["endpoint"]["name"]: e["endpoint"]
+            for e in fab.dump("endpoint-get", {})}
+
+
+def slot_of(name):
+    return int(name.rsplit("ep", 1)[1])
+
+
+def add_via(fab, control, nports=1):
+    """Drive a debugfs hotplug-add; return the new endpoint dict (or None)."""
+    before = set(eps_by_name(fab))
+    L.dbg_write(control, nports)
+    new = L.wait_until(lambda: set(eps_by_name(fab)) - before)
+    return eps_by_name(fab)[next(iter(new))] if len(new) == 1 else None
+
+
+def del_via(fab, name, slot):
+    L.dbg_write("del_endpoint", slot)
+    L.wait_until(lambda: name not in eps_by_name(fab))
+
+
+def fabricsim_fid(fab):
+    for f in fab.dump("fabric-get", {}):
+        if f["fabric"]["name"] == "fabricsim":
+            return f["fabric"]["fabric-id"]
+    return None
+
+
+def set_fault(name, on):
+    L.dbg_write(name, "Y" if on else "N")
+
+
+class Cfg:
+    def __init__(self, fab, fid):
+        self.fab = fab
+        self.fid = fid
+
+
+def test_register_fault(ksft, cfg):
+    """A failed provider create surfaces -ENOMEM and leaks no endpoint."""
+    fab = cfg.fab
+    n_before = len(eps_by_name(fab))
+    set_fault("fail_register", True)
+    try:
+        reg_errno = None
+        try:
+            L.dbg_write("add_endpoint", 1)
+        except OSError as exc:
+            reg_errno = exc.errno
+        # Confirming a non-event needs a bounded wait: poll a short window for a
+        # late endpoint after the synchronous -ENOMEM.
+        grew = L.wait_until(lambda: len(eps_by_name(fab)) != n_before, timeout=0.3)
+        ksft.check(reg_errno == errno.ENOMEM, "fault-register-returns-enomem",
+                   "errno=%s" % reg_errno)
+        ksft.check(not grew and len(eps_by_name(fab)) == n_before,
+                   "fault-register-no-leak",
+                   "count changed %d -> %d" % (n_before, len(eps_by_name(fab))))
+    finally:
+        set_fault("fail_register", False)
+    created = add_via(fab, "add_endpoint", nports=1)
+    ksft.check(created is not None, "fault-cleared-register-ok")
+    if created is not None:
+        del_via(fab, created["name"], slot_of(created["name"]))
+
+
+CASES = (
+    test_register_fault,
+)
+
+
+def main():
+    ksft = L.Ksft()
+
+    with L.fabricsim(ksft, need_debugfs=True, need_control="fail_register") as fab:
+        fid = fabricsim_fid(fab)
+        if fid is None:
+            ksft.skip_all("fabricsim fabric not present")
+
+        L.run_cases(ksft, Cfg(fab, fid), CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset_abi.py
new file mode 100755
index 000000000000..211613185a39
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset_abi.py
@@ -0,0 +1,113 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Verify recovery after a SIGKILL-terminated test. reset_sim_or_fail() must
+restore topology isolation at the next test's entry.
+
+Requires root, YNL, drm_fabric, and drm_fabric_sim.
+"""
+
+import os
+import signal
+import subprocess
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L  # noqa: E402 - shared KTAP/module helpers
+
+_HERE = os.path.dirname(os.path.abspath(__file__))
+
+# Helper process: load the switch shape, then idle so the parent can kill it
+# mid-life. It deliberately installs no cleanup -- SIGKILL would bypass it.
+_CHILD = (
+    "import sys, time\n"
+    "sys.path.insert(0, %r)\n"
+    "import lib_drm_fabric as L\n"
+    "L.rmmod('drm_fabric_sim')\n"
+    "if not L.module_loaded('drm_fabric'):\n"
+    "    L.insmod('drm-fabric.ko')\n"
+    "L.insmod('drm-fabric-sim.ko', 'topology=switch')\n"
+    "time.sleep(120)\n"
+) % _HERE
+
+
+def _has_switch_peer(fab):
+    """True if any leaf port carries a TYPE=switch half-edge (switch shape)."""
+    for e in fab.dump("endpoint-get", {}):
+        ep_id = e["endpoint"]["endpoint-id"]
+        for p in fab.dump("port-get", {"endpoint-id": ep_id}):
+            peer = p["port"].get("peer")
+            if peer and peer.get("type") == "switch":
+                return True
+    return False
+
+
+class Cfg:
+    def __init__(self, nl_error):
+        self.NlError = nl_error
+
+
+def test_sigkill_topology_recovery(ksft, cfg):
+    """A SIGKILL-leaked switch shape must not survive the next entry reset."""
+    # 1. Bring up the switch shape in a helper and confirm it is observable.
+    child = subprocess.Popen([sys.executable, "-c", _CHILD])
+    try:
+        fab = L.DrmFabric()
+        loaded = L.wait_until(
+            lambda: L.module_loaded("drm_fabric_sim") and _has_switch_peer(fab),
+            timeout=10.0)
+        if not loaded:
+            child.send_signal(signal.SIGKILL)
+            ksft.skip("harness-reset-sigkill-recovery",
+                      "helper could not establish switch shape")
+            return
+
+        # 2. Terminate through the SIGKILL path: no cleanup runs, so the switch
+        #    sim stays loaded exactly as a hard-timed-out test would leave it.
+        child.send_signal(signal.SIGKILL)
+        child.wait()
+    finally:
+        if child.poll() is None:
+            child.send_signal(signal.SIGKILL)
+            child.wait()
+
+    stale = L.module_loaded("drm_fabric_sim")
+    ksft.check(stale, "harness-reset-sigkill-leaves-stale-sim",
+               "sim unexpectedly unloaded by the killed helper")
+
+    # 3. The next test's entry reset must recover a known default shape.
+    # Mid-case: a result was already emitted above, so a failed reset here
+    # must become a not_ok(), not a skip_all() 0-plan (invalid once results
+    # are on stdout). reset_sim_or_fail() already reported the failure, so
+    # bail out rather than emitting a second, precondition-less check.
+    if not L.reset_sim_or_fail(ksft, "harness-reset-sigkill-recovery-setup",
+                                topology="mesh"):
+        return
+    fab = L.DrmFabric()
+    ksft.check(not _has_switch_peer(fab),
+               "harness-reset-sigkill-recovery",
+               "switch half-edge survived reset_sim(mesh)")
+
+
+CASES = (
+    test_sigkill_topology_recovery,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+    if not L.is_root():
+        ksft.skip_all("must run as root (insmod + genetlink)")
+    # This suite drives module load/unload itself rather than via fabricsim().
+    try:
+        L.run_cases(ksft, Cfg(NlError), CASES)
+    finally:
+        # Leave a sane default shape for whatever suite runs next.
+        L.sim_restore_default()
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py
new file mode 100755
index 000000000000..19a3405fade9
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py
@@ -0,0 +1,204 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Endpoint hotplug via fabricsim's debugfs lifecycle controls (add_endpoint/
+del_endpoint, cf. netdevsim's new_port/del_port): CREATE/DELETE events
+observed over the read-only query ABI and notifications; only the hotplug
+stimulus uses the debugfs controls.
+
+Usage: hotplug_abi.py [--no-load]
+"""
+
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+EVT_DURATION = float(os.environ.get("EVT_DURATION", "3"))
+# Subscription is synchronous (setsockopt); a brief settle suffices before
+# triggering, after which wait_ntf() polls with a deadline.
+EVT_SETTLE = float(os.environ.get("EVT_SETTLE", "0.2"))
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
+def add_ep(fab, control, nports=None):
+    """Add via debugfs; diff the name set (polling) to return the new endpoint."""
+    before = set(eps_by_name(fab))
+    L.dbg_write(control, nports if nports is not None else 1)
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
+def _gen(fab):
+    """Current global topology-generation, read via a stable initial port."""
+    return fab.do("port-get",
+                  {"endpoint-id": 0, "port-index": 0}).get("topology-generation")
+
+
+def test_provider_topology_lifecycle(ksft, cfg):
+    """Provider grows and shrinks the topology within its fabric.
+
+    Non-destructive: only the endpoints it adds are removed.
+    """
+    fab = cfg.fab
+
+    # (a) provider-established initial adjacency (mesh) is observable read-only.
+    p0 = fab.do("port-get", {"endpoint-id": 0, "port-index": 0})["port"]
+    peer = p0.get("peer")
+    ksft.check(peer is not None and peer.get("type") == "accel",
+               "topology-initial-adjacency-visible", "peer=%s" % peer)
+
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+
+    n0 = len(eps_by_name(fab))
+    g0 = _gen(fab)
+
+    # (b) grow: add two endpoints; the first is asserted to announce a CREATE.
+    ep_c = add_ep(fab, "add_endpoint", nports=2)
+    c_evt = L.wait_ntf(ev, "endpoint-create-ntf", timeout=EVT_DURATION)
+    ep_d = add_ep(fab, "add_endpoint", nports=2)
+
+    if ep_c is None or ep_d is None:
+        for e in (ep_c, ep_d):
+            if e:
+                del_ep(fab, slot_of(e["name"]), e["name"])
+        for name in ("topology-grow-two-members", "topology-grow-create-ntf",
+                     "topology-grow-advances-generation",
+                     "topology-hotplug-is-member",
+                     "topology-hotplug-endpoint-unlinked",
+                     "topology-reads-do-not-advance-generation",
+                     "topology-shrink-delete-ntf",
+                     "topology-shrink-restores-baseline"):
+            ksft.not_ok(name, "grow failed (c=%s d=%s)" % (ep_c, ep_d))
+        return
+
+    ksft.check(len(eps_by_name(fab)) == n0 + 2, "topology-grow-two-members",
+               "n0=%d now=%d" % (n0, len(eps_by_name(fab))))
+    ksft.check(c_evt is not None, "topology-grow-create-ntf")
+
+    g_grown = _gen(fab)
+    ksft.check(g0 is not None and g_grown is not None and g_grown > g0,
+               "topology-grow-advances-generation",
+               "g0=%s grown=%s" % (g0, g_grown))
+    ksft.check(ep_c.get("fabric-id") == cfg.fid, "topology-hotplug-is-member",
+               "fabric-id=%s" % ep_c.get("fabric-id"))
+
+    # (c) a late arrival is not auto-wired: the provider links explicitly.
+    pc = fab.do("port-get",
+                {"endpoint-id": ep_c["endpoint-id"], "port-index": 0})["port"]
+    ksft.check(pc.get("peer") is None, "topology-hotplug-endpoint-unlinked",
+               "unexpected peer=%s" % pc.get("peer"))
+
+    # (d) pure reads (dump + stats GET) never advance generation.
+    g_pre_reads = _gen(fab)
+    eps_by_name(fab)
+    fab.do("port-stats-get", {"endpoint-id": ep_c["endpoint-id"],
+                              "port-index": 0})
+    g_post_reads = _gen(fab)
+    ksft.check(g_post_reads == g_pre_reads,
+               "topology-reads-do-not-advance-generation",
+               "pre=%s post=%s" % (g_pre_reads, g_post_reads))
+
+    # shrink back to baseline; assert one DELETE event and the restored count.
+    ev2 = L.DrmFabric()
+    ev2.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+    del_ep(fab, slot_of(ep_d["name"]), ep_d["name"])
+    d_evt = L.wait_ntf(ev2, "endpoint-delete-ntf", timeout=EVT_DURATION)
+    del_ep(fab, slot_of(ep_c["name"]), ep_c["name"])
+    ksft.check(d_evt is not None, "topology-shrink-delete-ntf")
+    ksft.check(len(eps_by_name(fab)) == n0, "topology-shrink-restores-baseline",
+               "n0=%d now=%d" % (n0, len(eps_by_name(fab))))
+
+
+
+def test_hotplug_lifecycle(ksft, cfg):
+    """Hotplug one endpoint and unplug it: CREATE, DELETE, membership."""
+    fab = cfg.fab
+    ev = L.DrmFabric()
+    ev.ntf_subscribe(L.MCAST_MONITOR)
+    L.settle(EVT_SETTLE)
+    n_before = len(eps_by_name(fab))
+    new_ep = add_ep(fab, "add_endpoint", nports=2)
+    add_evt = L.wait_ntf(ev, "endpoint-create-ntf", timeout=EVT_DURATION)
+
+    ksft.check(new_ep is not None and len(eps_by_name(fab)) == n_before + 1,
+               "hotplug-add-appears",
+               "n_before=%d new=%s" % (n_before, new_ep))
+    ksft.check(add_evt is not None, "hotplug-add-endpoint-create-ntf")
+    if new_ep is None:
+        ksft.not_ok("hotplug-add-is-member", "add_endpoint produced no endpoint")
+        ksft.not_ok("hotplug-del-disappears", "add failed")
+        ksft.not_ok("hotplug-del-endpoint-delete-ntf", "add failed")
+        return
+
+    name = new_ep["name"]
+    ksft.check(new_ep.get("fabric-id") == cfg.fid, "hotplug-add-is-member",
+               "fabric-id=%s" % new_ep.get("fabric-id"))
+
+    try:
+        ev = L.DrmFabric()
+        ev.ntf_subscribe(L.MCAST_MONITOR)
+        L.settle(EVT_SETTLE)
+        gone = del_ep(fab, slot_of(name), name)
+        del_evt = L.wait_ntf(ev, "endpoint-delete-ntf", timeout=EVT_DURATION)
+        ksft.check(gone, "hotplug-del-disappears")
+        ksft.check(del_evt is not None, "hotplug-del-endpoint-delete-ntf")
+    finally:
+        if name in eps_by_name(fab):
+            del_ep(fab, slot_of(name), name)
+
+
+CASES = (
+    test_provider_topology_lifecycle,
+    test_hotplug_lifecycle,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+
+    with L.fabricsim(ksft, need_debugfs=True, need_control="add_endpoint") as fab:
+        fid = fabricsim_fid(fab)
+        if fid is None:
+            ksft.skip_all("fabricsim fabric not present")
+
+        L.run_cases(ksft, Cfg(fab, fid, NlError), CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py b/tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py
new file mode 100644
index 000000000000..30fb0edb02b9
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py
@@ -0,0 +1,481 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Shared helpers for the drm-fabric selftests (cf.
+tools/testing/selftests/net/lib/py): YNL family binding to drm_fabric.yaml,
+path/module discovery, the DrmFabric wrapper, and a KTAP emitter (Ksft)
+over kselftest/ksft.py.
+"""
+
+import atexit
+import contextlib
+import os
+import signal
+import subprocess
+import sys
+import time
+
+# Path discovery.
+# This file lives at tools/testing/selftests/drivers/gpu/drm_fabric/, six
+# directory levels below the kernel tree root, which ROOT resolves to.
+HERE = os.path.dirname(os.path.abspath(__file__))
+ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "..", "..", "..", ".."))
+
+SPEC = os.environ.get("SPEC") or os.path.join(
+    ROOT, "Documentation", "netlink", "specs", "drm_fabric.yaml")
+UAPI_HEADER = os.environ.get("UAPI_HEADER") or os.path.join(
+    ROOT, "include", "uapi", "drm", "drm_fabric.h")
+
+# Modules: the QEMU harness sets FABRIC_DIR=/modules; otherwise build output
+# lives next to the source.
+FABRIC_DIR = os.environ.get("FABRIC_DIR") or os.path.join(
+    ROOT, "drivers", "gpu", "drm", "fabric")
+
+DEBUGFS = "/sys/kernel/debug/drm_fabric_sim"
+
+FAMILY = "drm-fabric"
+MCAST_MONITOR = "monitor"
+
+
+def _ynl_dir():
+    env = os.environ.get("YNL_DIR")
+    if env:
+        return env
+    return os.path.join(ROOT, "tools", "net", "ynl")
+
+
+def import_ynl():
+    """Import YnlFamily/NlError from the in-tree YNL library, or SKIP."""
+    ynl_dir = _ynl_dir()
+    if ynl_dir not in sys.path:
+        sys.path.insert(0, ynl_dir)
+    try:
+        from pyynl.lib import YnlFamily, NlError
+    except ModuleNotFoundError as exc:
+        print("1..0 # SKIP cannot import YNL library from %s (%s)"
+              % (ynl_dir, exc))
+        sys.exit(4)
+    return YnlFamily, NlError
+
+
+def _ksft_dir_candidates():
+    """Where the kernel's generic kselftest/ksft.py may live."""
+    yield os.path.normpath(os.path.join(HERE, "..", "..", "..", "kselftest"))
+    yield os.path.join(ROOT, "tools", "testing", "selftests", "kselftest")
+    ynl_root = os.path.normpath(os.path.join(_ynl_dir(), "..", "..", ".."))
+    yield os.path.join(ynl_root, "tools", "testing", "selftests", "kselftest")
+
+
+_ksft_mod = None
+
+
+def import_ksft():
+    """Import the kernel's kselftest/ksft.py, or None if unavailable (inline
+    TAP fallback below)."""
+    global _ksft_mod
+    if _ksft_mod is not None:
+        return _ksft_mod or None
+    for cand in _ksft_dir_candidates():
+        if os.path.isfile(os.path.join(cand, "ksft.py")):
+            if cand not in sys.path:
+                sys.path.insert(0, cand)
+            import ksft as _k
+            _ksft_mod = _k
+            return _k
+    _ksft_mod = False   # cache "looked, not found"
+    return None
+
+
+# KTAP emitter
+
+class Ksft:
+    """KTAP emitter delegating to the kernel's kselftest/ksft.py.
+
+    Thin ergonomic adapter (check/ok/skip/finish) over the in-tree primitives
+    (``test_result_*``/``set_plan``/``finished``) so the suites do not reinvent
+    TAP. Falls back to inline printing only when ksft.py is not importable.
+    """
+
+    def __init__(self):
+        self._k = import_ksft()
+        self.cnt = 0
+        self.fail = 0
+        self._started = False
+        # Timing. Suite wall starts at construction so it also covers the
+        # module load / family setup main() does before the first result.
+        # Per-case and per-step deltas accrue as results are emitted; the
+        # digest is printed by finish() as KTAP "# time:" diagnostics.
+        self._t0 = time.monotonic()
+        self._last = None                # time of the previous result
+        self._cur = None                 # [name, t_start, cnt_at_start]
+        self._cases = []                 # [(name, dur_s, steps), ...]
+        self._slow_step = ("", 0.0)      # (name, longest inter-result gap)
+
+    def _tick(self, name):
+        """Record the wall gap since the previous result (a "step")."""
+        now = time.monotonic()
+        if self._last is None:
+            self._last = now             # first result: no prior to measure
+            return
+        delta = now - self._last
+        self._last = now
+        if delta > self._slow_step[1]:
+            self._slow_step = (name, delta)
+
+    def case_begin(self, name):
+        self._cur = [name, time.monotonic(), self.cnt]
+
+    def case_end(self):
+        if self._cur is None:
+            return
+        name, t_start, cnt0 = self._cur
+        self._cases.append((name, time.monotonic() - t_start, self.cnt - cnt0))
+        self._cur = None
+
+    def start(self):
+        if self._started:
+            return
+        self._started = True
+        if self._k:
+            self._k.print_header()
+        else:
+            print("TAP version 13")
+
+    def skip_all(self, reason):
+        # A 0-plan skip is the whole result (standard KTAP, both backends),
+        # which is only valid before any other result has been printed. A
+        # mid-case call is a bug in the caller, not a runtime condition to
+        # report as KTAP -- surface it loudly instead of emitting a plan
+        # that contradicts results already on stdout.
+        if self.cnt != 0:
+            raise RuntimeError(
+                "skip_all() called after %d result(s) already emitted "
+                "(reason=%r); mid-case failures must use not_ok() (e.g. "
+                "via reset_sim_or_fail()), not skip_all()" % (self.cnt, reason))
+        print("1..0 # SKIP %s" % reason)
+        sys.exit(4)
+
+    def ok(self, name):
+        self.start()
+        self._tick(name)
+        self.cnt += 1
+        if self._k:
+            self._k.test_result_pass(name)
+        else:
+            print("ok %d %s" % (self.cnt, name))
+
+    def not_ok(self, name, detail=""):
+        self.start()
+        self._tick(name)
+        self.cnt += 1
+        self.fail += 1
+        if self._k:
+            if detail:
+                self._k.print_msg(detail)
+            self._k.test_result_fail(name)
+        else:
+            print("not ok %d %s" % (self.cnt, name))
+            if detail:
+                print("  # %s" % detail)
+
+    def skip(self, name, reason=""):
+        self.start()
+        self._tick(name)
+        self.cnt += 1
+        if self._k:
+            if reason:
+                self._k.print_msg("%s: %s" % (name, reason))
+            self._k.test_result_skip(name)
+        else:
+            print("ok %d %s # SKIP %s" % (self.cnt, name, reason))
+
+    def check(self, cond, name, detail=""):
+        if cond:
+            self.ok(name)
+        else:
+            self.not_ok(name, detail)
+        return bool(cond)
+
+    def _emit_timing(self):
+        """Print per-case and per-suite wall-clock as "# time:" KTAP diagnostics
+        (ignored by TAP parsers). Per-case lines are gated behind
+        FABRIC_TIMING; the one-line suite summary is always emitted.
+        """
+        wall = time.monotonic() - self._t0
+        suite = os.path.basename(sys.argv[0]) or "suite"
+        if os.environ.get("FABRIC_TIMING"):
+            for name, dur, steps in self._cases:
+                print("# time: case=%s wall=%.3fs steps=%d" % (name, dur, steps))
+        slow = max(self._cases, default=("-", 0.0, 0), key=lambda c: c[1])
+        print("# time: suite=%s wall=%.3fs cases=%d steps=%d "
+              "slowest-case=%s(%.3fs) slowest-step=%s(%.3fs)"
+              % (suite, wall, len(self._cases), self.cnt,
+                 slow[0], slow[1], self._slow_step[0], self._slow_step[1]))
+
+    def finish(self):
+        self.start()
+        self._emit_timing()
+        if self._k:
+            self._k.set_plan(self.cnt)
+            self._k.finished()       # prints totals + exits 0/1 by pass+skip
+        else:
+            print("1..%d" % self.cnt)
+            print("")
+            print("# %d/%d passed, %d failed"
+                  % (self.cnt - self.fail, self.cnt, self.fail))
+            sys.exit(1 if self.fail else 0)
+
+
+# Case dispatch
+
+def run_cases(ksft, cfg, cases):
+    """Dispatch each case, isolating an exception to its own result."""
+    for fn in cases:
+        ksft.case_begin(fn.__name__)
+        try:
+            fn(ksft, cfg)
+        except Exception as exc:  # noqa: BLE001 - isolate one case's failure
+            ksft.not_ok(fn.__name__, "unhandled exception: %r" % exc)
+        finally:
+            ksft.case_end()
+        if getattr(cfg, "abort", False):
+            break
+
+
+# YNL wrapper
+
+def DrmFabric(**kwargs):
+    """Construct a YnlFamily bound to the drm_fabric spec (schema off)."""
+    YnlFamily, _ = import_ynl()
+    if not os.path.isfile(SPEC):
+        Ksft().skip_all("drm_fabric.yaml not found at %s" % SPEC)
+    # schema='' skips slow jsonschema validation, matching the net selftests.
+    return YnlFamily(SPEC, schema="", **kwargs)
+
+
+def nl_errno(exc):
+    """Positive errno carried by a netlink exception."""
+    return getattr(exc, "error", 0)
+
+
+def family_has_op(fab, name):
+    """True if the loaded family advertises operation @name: a query-only
+    build has none of the topology-mutation ops (fabric-new, fabric-del,
+    endpoint-set, port-set, port-peer-new/del), so cases exercising them are
+    filtered rather than raising KeyError.
+    """
+    return name in getattr(fab, "ops", {})
+
+
+# System helpers (kselftest runs as root)
+
+def is_root():
+    return os.geteuid() == 0
+
+
+def module_loaded(name):
+    return os.path.isdir("/sys/module/%s" % name)
+
+
+def insmod(ko, *args):
+    path = ko if os.path.isabs(ko) else os.path.join(FABRIC_DIR, ko)
+    return subprocess.call(["insmod", path, *args],
+                           stderr=subprocess.DEVNULL) == 0
+
+
+def rmmod(name):
+    subprocess.call(["rmmod", name], stderr=subprocess.DEVNULL)
+
+
+def debugfs_available():
+    return os.path.isdir(DEBUGFS)
+
+
+def dbg_write(rel, val):
+    with open(os.path.join(DEBUGFS, rel), "w") as fh:
+        fh.write(str(val))
+
+
+def settle(seconds=0.2):
+    time.sleep(seconds)
+
+
+def wait_until(predicate, timeout=3.0, interval=0.02):
+    """Poll @predicate until truthy or @timeout elapses; return the last value."""
+    deadline = time.monotonic() + timeout
+    val = predicate()
+    while not val and time.monotonic() < deadline:
+        time.sleep(interval)
+        val = predicate()
+    return val
+
+
+def wait_ntf(ev, want_name, timeout=3.0, match=None):
+    """First notification named @want_name within @timeout, else None."""
+    deadline = time.monotonic() + timeout
+    while True:
+        remaining = deadline - time.monotonic()
+        if remaining <= 0:
+            return None
+        for ntf in ev.poll_ntf(duration=min(remaining, 0.25)):
+            if ntf["name"] != want_name:
+                continue
+            if match is None or match(ntf):
+                return ntf
+
+
+# Teardown that survives the timeout killer
+
+_teardowns = []
+_teardown_armed = False
+
+
+def _run_teardowns():
+    """Run registered teardowns once, most-recent first, swallowing errors."""
+    while _teardowns:
+        fn = _teardowns.pop()
+        try:
+            fn()
+        except Exception:  # noqa: BLE001 - teardown must not mask the exit
+            pass
+
+
+def _sig_teardown(signum, _frame):
+    _run_teardowns()
+    # Restore the default disposition and re-raise so the exit status still
+    # reflects the signal (the kselftest runner treats it as a failure/timeout).
+    signal.signal(signum, signal.SIG_DFL)
+    os.kill(os.getpid(), signum)
+
+
+def on_teardown(fn):
+    """Register @fn for normal exit and SIGTERM/SIGINT.
+
+    atexit alone misses the timeout runner's SIGTERM. SIGKILL cannot be
+    caught, so a killed predecessor is recovered at the next test's entry.
+    """
+    global _teardown_armed
+    if not _teardown_armed:
+        atexit.register(_run_teardowns)
+        for sig in (signal.SIGTERM, signal.SIGINT):
+            try:
+                signal.signal(sig, _sig_teardown)
+            except (ValueError, OSError):
+                pass   # not on the main thread; atexit still covers clean exit
+        _teardown_armed = True
+    _teardowns.append(fn)
+
+
+# Suite fixture
+
+def _providers_unload():
+    rmmod("drm_fabric_sim")
+    rmmod("drm_fabric")
+
+
+def sim_restore_default():
+    # Drop the shape the suite loaded and put the default topology back.
+    rmmod("drm_fabric_sim")
+    if module_loaded("drm_fabric"):
+        insmod("drm-fabric-sim.ko")
+        wait_until(lambda: module_loaded("drm_fabric_sim"))
+
+
+def _reset_sim_steps(topology):
+    """Drop whatever a previous test left loaded, then load @topology.
+
+    A test killed with SIGKILL runs no Python cleanup, so isolation is
+    re-established here, at the next test's entry. Returns (ok, reason) so
+    each caller can pick its own KTAP path.
+    """
+    if not is_root():
+        return False, "must run as root (insmod)"
+    rmmod("drm_fabric_sim")
+    if not module_loaded("drm_fabric") and not insmod("drm-fabric.ko"):
+        return False, "could not load drm_fabric"
+    if not insmod("drm-fabric-sim.ko", "topology=%s" % topology):
+        return False, "could not load drm_fabric_sim topology=%s" % topology
+    if not wait_until(lambda: module_loaded("drm_fabric_sim")):
+        return False, "drm_fabric_sim did not appear after reset"
+    return True, ""
+
+
+def reset_sim(ksft, topology="mesh"):
+    """Load @topology, or skip the suite.
+
+    Setup-time only: skip_all() is invalid once a result has been emitted.
+    """
+    ok, reason = _reset_sim_steps(topology)
+    if not ok:
+        ksft.skip_all(reason)
+
+
+def reset_sim_or_fail(ksft, name, topology="mesh"):
+    """Load @topology, or fail the current case as @name.
+
+    On False the caller must bail out; the not_ok() already stands.
+    """
+    ok, reason = _reset_sim_steps(topology)
+    if not ok:
+        ksft.not_ok(name, reason)
+        return False
+    return True
+
+
+@contextlib.contextmanager
+def fabricsim(ksft, topology=None, need_debugfs=False, need_control=None,
+              open_family=True):
+    """Bring the providers up, yield a bound family, arrange teardown.
+
+    A missing precondition skips the suite. @topology reloads the sim even
+    under --no-load and restores the default on exit. @open_family=False
+    yields None for suites opening their own socket.
+    """
+    _, NlError = import_ynl()
+
+    if not is_root():
+        ksft.skip_all("must run as root (genetlink + debugfs + insmod)")
+
+    if topology is not None:
+        # Entry reset: dropping any sim left by a previous (possibly
+        # SIGKILL-terminated) test before loading this shape is what makes a
+        # topology-changing suite start from a known state. See reset_sim().
+        rmmod("drm_fabric_sim")
+        loaded_core = False
+        if not module_loaded("drm_fabric"):
+            if not insmod("drm-fabric.ko"):
+                ksft.skip_all("could not load drm_fabric")
+            loaded_core = True
+        # Arm teardown before loading the sim so a failed sim load (or any
+        # later skip) still restores the default shape and unwinds a core we
+        # loaded here, rather than leaking it into the next suite.
+        on_teardown(_providers_unload if loaded_core else sim_restore_default)
+        if not insmod("drm-fabric-sim.ko", "topology=%s" % topology):
+            ksft.skip_all("could not load drm_fabric_sim topology=%s" % topology)
+        wait_until(lambda: module_loaded("drm_fabric_sim"))
+    elif "--no-load" not in sys.argv[1:] and not module_loaded("drm_fabric"):
+        rmmod("drm_fabric_sim")
+        rmmod("drm_fabric")
+        # Arm teardown before loading so a partial load (core up, sim load
+        # failed) is unwound instead of leaking a module into the next suite.
+        on_teardown(_providers_unload)
+        if not insmod("drm-fabric.ko") or not insmod("drm-fabric-sim.ko"):
+            ksft.skip_all("could not load drm_fabric + drm_fabric_sim modules")
+        wait_until(lambda: module_loaded("drm_fabric_sim"))
+
+    if not module_loaded("drm_fabric_sim"):
+        ksft.skip_all("drm_fabric_sim not loaded")
+    if need_debugfs and not debugfs_available():
+        ksft.skip_all("fabricsim debugfs not available (runtime controls)")
+    if need_control and not os.path.exists(os.path.join(DEBUGFS, need_control)):
+        ksft.skip_all("fabricsim lacks '%s' control (old module)" % need_control)
+
+    if not open_family:
+        yield None
+        return
+
+    try:
+        fab = DrmFabric()
+    except (OSError, NlError) as exc:
+        ksft.skip_all("cannot open drm-fabric family: %s" % exc)
+    yield fab
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py b/tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py
new file mode 100755
index 000000000000..0d4d60d45e5a
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py
@@ -0,0 +1,485 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Adversarial raw-netlink probes the YNL suites cannot reach: malformed
+attrs (wrong type, unknown id, truncated nest, out-of-range enum, missing
+required) must return a clean NLMSG_ERROR, never an oops; a liveness dump
+confirms nothing wedged the family. Also introspects the family and emits
+TAP.
+
+Topology-mutation policy probes arrive with the provisioning ABI; this
+query-only build defines no mutation commands or attributes to probe.
+"""
+
+import errno
+import os
+import re
+import socket
+import struct
+import subprocess
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L  # noqa: E402 - shared KTAP emitter only (no pyynl)
+
+# Netlink / generic-netlink constants
+NETLINK_GENERIC = 16
+
+NLMSG_ERROR = 0x2
+NLMSG_DONE = 0x3
+
+NLM_F_REQUEST = 0x01
+NLM_F_ACK = 0x04
+NLM_F_DUMP = 0x300
+
+GENL_ID_CTRL = 0x10
+CTRL_CMD_GETFAMILY = 3
+# uapi/linux/genetlink.h CTRL_ATTR_* enum:
+#   1 FAMILY_ID, 2 FAMILY_NAME, 3 VERSION, 4 HDRSIZE, 5 MAXATTR,
+#   6 OPS, 7 MCAST_GROUPS
+CTRL_ATTR_FAMILY_ID = 1
+CTRL_ATTR_FAMILY_NAME = 2
+CTRL_ATTR_VERSION = 3
+CTRL_ATTR_OPS = 6
+CTRL_ATTR_MCAST_GROUPS = 7
+# Within a CTRL_ATTR_OPS entry:
+CTRL_ATTR_OP_ID = 1
+CTRL_ATTR_OP_FLAGS = 2
+# Within a CTRL_ATTR_MCAST_GROUPS entry:
+CTRL_ATTR_MCAST_GRP_NAME = 1
+
+# genetlink op flags (uapi/linux/genetlink.h)
+GENL_ADMIN_PERM = 0x01
+
+NLA_F_NESTED = 0x8000
+NLA_TYPE_MASK = ~(NLA_F_NESTED | 0x4000)
+
+NLMSG_HDRLEN = 16
+GENL_HDRLEN = 4
+
+FAMILY_NAME = b"drm-fabric"
+
+EXPECTED_VERSION = 1
+MCAST_MONITOR = b"monitor"
+
+
+# Command / attribute ids: derive from the uAPI header.
+#
+# Hand-written ids drift the moment someone reorders an enum, leaving the probe
+# silently fuzzing the wrong command. Parse them from the canonical uapi header
+# (or its sibling/initramfs copy) so a reorder is reflected automatically;
+# deliberately no fallback table -- skip the whole suite if the header cannot
+# be found, rather than risk probing under a stale guess.
+
+def _find_uapi_header():
+    cand = os.environ.get("UAPI_HEADER")
+    if cand and os.path.isfile(cand):
+        return cand
+    here = os.path.dirname(os.path.abspath(__file__))
+    root = os.path.abspath(os.path.join(here, *([".."] * 6)))
+    for p in (os.path.join(root, "include", "uapi", "drm", "drm_fabric.h"),
+              "/opt/spec/drm_fabric.h"):
+        if os.path.isfile(p):
+            return p
+    return None
+
+
+def _parse_all_enums(text):
+    """Merge values from every enum block into one symbol table.
+
+    Commands use an anonymous enum and attributes a named one, so parsing by
+    enum name is brittle. Symbols are assumed unique; collisions are
+    last-wins.
+    """
+    out = {}
+    for body in re.findall(r"enum\s*(?:\w+\s*)?\{(.*?)\}", text, re.S):
+        body = re.sub(r"/\*.*?\*/", "", body, flags=re.S)
+        body = re.sub(r"//[^\n]*", "", body)
+        nxt = 0
+        for raw in body.split(","):
+            item = raw.strip()
+            if not item:
+                continue
+            if "=" in item:
+                name, val = item.split("=", 1)
+                name = name.strip()
+                try:
+                    nxt = int(val.strip(), 0)
+                except ValueError:
+                    continue
+            else:
+                name = item
+            if re.match(r"^[A-Za-z_]\w*$", name):
+                out[name] = nxt
+            nxt += 1
+    return out
+
+
+def _load_ids():
+    # Committed fallbacks (kept in sync with drm_fabric.h, query-only build).
+    syms = {"DRM_FABRIC_CMD_FABRIC_GET": 1, "DRM_FABRIC_CMD_PORT_GET": 3,
+            "DRM_FABRIC_A_FABRIC_ID": 5, "DRM_FABRIC_A_ENDPOINT_ID": 6,
+            "DRM_FABRIC_A_PORT_INDEX": 7, "DRM_FABRIC_A_PEER": 10}
+    src = "fallback literals"
+    hdr = _find_uapi_header()
+    if hdr:
+        parsed = _parse_all_enums(open(hdr).read())
+        if "DRM_FABRIC_CMD_PORT_GET" in parsed and "DRM_FABRIC_A_FABRIC_ID" in parsed:
+            syms, src = parsed, hdr
+    return syms, src
+
+
+_SYMS, _ID_SRC = _load_ids()
+
+CMD_FABRIC_GET = _SYMS["DRM_FABRIC_CMD_FABRIC_GET"]
+CMD_PORT_GET = _SYMS["DRM_FABRIC_CMD_PORT_GET"]
+
+A_FABRIC_ID = _SYMS["DRM_FABRIC_A_FABRIC_ID"]
+A_ENDPOINT_ID = _SYMS["DRM_FABRIC_A_ENDPOINT_ID"]
+A_PORT_INDEX = _SYMS["DRM_FABRIC_A_PORT_INDEX"]
+
+# An attribute id guaranteed to be past the family's top-level maxattr, so the
+# kernel strict-rejects it. Derived from the parsed ids (one past the largest
+# symbol) rather than a magic literal, which would silently stop testing strict
+# rejection once the attribute set grows past it.
+A_UNKNOWN = max(_SYMS.values()) + 1
+
+
+# NLA builders
+
+def _align4(n):
+    return (n + 3) & ~3
+
+
+def nla(attr_type, payload):
+    length = 4 + len(payload)
+    pad = b"\x00" * (_align4(length) - length)
+    return struct.pack("=HH", length, attr_type) + payload + pad
+
+
+def nla_u32(attr_type, val):
+    return nla(attr_type, struct.pack("=I", val & 0xFFFFFFFF))
+
+
+def nla_u64(attr_type, val):
+    return nla(attr_type, struct.pack("=Q", val & 0xFFFFFFFFFFFFFFFF))
+
+
+def build_msg(family_id, cmd, seq, payload, flags=NLM_F_REQUEST | NLM_F_ACK):
+    body = struct.pack("=BBH", cmd, 1, 0) + payload
+    total = NLMSG_HDRLEN + len(body)
+    nlh = struct.pack("=IHHII", total, family_id, flags, seq, 0)
+    return nlh + body
+
+
+# Socket helpers
+
+def open_sock():
+    s = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, NETLINK_GENERIC)
+    s.bind((0, 0))
+    s.settimeout(3)
+    return s
+
+
+def iter_attrs(blob):
+    off = 0
+    while off + 4 <= len(blob):
+        (alen, atype) = struct.unpack_from("=HH", blob, off)
+        if alen < 4:
+            break
+        payload = blob[off + 4:off + alen]
+        yield atype, payload
+        off += _align4(alen)
+
+
+def parse_dgram(data):
+    """Split one recv() buffer into (nlmsg_type, errno) tuples.
+
+    errno is None when mlen is too short to hold the 4 payload bytes it
+    claims -- distinct from a genuine zero status.
+    """
+    out = []
+    off = 0
+    while off + NLMSG_HDRLEN <= len(data):
+        (mlen, mtype, _, _, _) = struct.unpack_from("=IHHII", data, off)
+        if mlen < NLMSG_HDRLEN:
+            break
+        if mtype in (NLMSG_ERROR, NLMSG_DONE):
+            if mlen >= NLMSG_HDRLEN + 4:
+                (err,) = struct.unpack_from("=i", data, off + NLMSG_HDRLEN)
+            else:
+                err = None
+            out.append((mtype, err))
+        else:
+            out.append((mtype, 0))
+        off += _align4(mlen)
+    return out
+
+
+def drain(sock, first_timeout=0.5, more_timeout=0.3):
+    """Read every datagram the kernel queued in response to one request."""
+    msgs = []
+    sock.settimeout(first_timeout)
+    try:
+        msgs += parse_dgram(sock.recv(16384))
+    except socket.timeout:
+        return msgs
+    sock.settimeout(more_timeout)
+    while True:
+        try:
+            msgs += parse_dgram(sock.recv(16384))
+        except socket.timeout:
+            break
+    return msgs
+
+
+def resolve_family(sock, name):
+    seq = 1
+    msg = build_msg(GENL_ID_CTRL, CTRL_CMD_GETFAMILY, seq,
+                    nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00"))
+    sock.send(msg)
+    try:
+        data = sock.recv(8192)
+    except socket.timeout:
+        return None
+    (_, mtype, _, _, _) = struct.unpack_from("=IHHII", data, 0)
+    if mtype == NLMSG_ERROR:
+        return None
+    attrs = data[NLMSG_HDRLEN + GENL_HDRLEN:]
+    for atype, payload in iter_attrs(attrs):
+        if atype == CTRL_ATTR_FAMILY_ID:
+            if len(payload) >= 4:
+                return struct.unpack_from("=I", payload, 0)[0]
+            if len(payload) >= 2:
+                return struct.unpack_from("=H", payload, 0)[0]
+    return None
+
+
+def get_family_info(sock, name):
+    """Introspect the family via CTRL_CMD_GETFAMILY.
+
+    Returns {version, ops: {op_id: flags}, mcast: set(names)} or None,
+    letting callers confirm version, admin-perm on mutators, and the
+    monitor group.
+    """
+    seq = 2
+    msg = build_msg(GENL_ID_CTRL, CTRL_CMD_GETFAMILY, seq,
+                    nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00"),
+                    flags=NLM_F_REQUEST)
+    sock.send(msg)
+    try:
+        data = sock.recv(65536)
+    except socket.timeout:
+        return None
+    (_, mtype, _, _, _) = struct.unpack_from("=IHHII", data, 0)
+    if mtype == NLMSG_ERROR:
+        return None
+
+    info = {"version": None, "ops": {}, "mcast": set()}
+    attrs = data[NLMSG_HDRLEN + GENL_HDRLEN:]
+    for atype, payload in iter_attrs(attrs):
+        atype &= NLA_TYPE_MASK
+        if atype == CTRL_ATTR_VERSION and len(payload) >= 4:
+            info["version"] = struct.unpack_from("=I", payload, 0)[0]
+        elif atype == CTRL_ATTR_OPS:
+            for _, op_blob in iter_attrs(payload):     # one entry per op
+                op_id = op_flags = None
+                for sub, val in iter_attrs(op_blob):
+                    sub &= NLA_TYPE_MASK
+                    if sub == CTRL_ATTR_OP_ID and len(val) >= 4:
+                        op_id = struct.unpack_from("=I", val, 0)[0]
+                    elif sub == CTRL_ATTR_OP_FLAGS and len(val) >= 4:
+                        op_flags = struct.unpack_from("=I", val, 0)[0]
+                if op_id is not None:
+                    info["ops"][op_id] = op_flags or 0
+        elif atype == CTRL_ATTR_MCAST_GROUPS:
+            for _, grp_blob in iter_attrs(payload):
+                for sub, val in iter_attrs(grp_blob):
+                    sub &= NLA_TYPE_MASK
+                    if sub == CTRL_ATTR_MCAST_GRP_NAME:
+                        info["mcast"].add(val.rstrip(b"\x00"))
+    return info
+
+
+# The KTAP emitter (L.Ksft) is shared with the YNL suites: one emitter, and a
+# dynamic plan printed at finish() instead of a hard-coded count that drifts
+# every time a case is added or removed.
+
+_SEQ = [100]
+
+
+def case_rejected(tap, name, sock, fid, cmd, payload, expect):
+    """Pass iff the kernel rejected with one of @expect (positive errno
+    values; the netlink error is negative, so we compare -e). The specific
+    code matters: e.g. -EINVAL for a malformed attribute, not a generic
+    failure.
+    """
+    _SEQ[0] += 1
+    sock.send(build_msg(fid, cmd, _SEQ[0], payload))
+    msgs = drain(sock)
+    rejected = [-e for (t, e) in msgs
+               if t == NLMSG_ERROR and e is not None and e != 0]
+    if not msgs:
+        tap.not_ok(name, "no response (possible hang)")
+    elif not rejected:
+        tap.not_ok(name, "accepted (no error returned)")
+    elif rejected[0] in expect:
+        tap.ok("%s (errno=%d)" % (name, rejected[0]))
+    else:
+        want = "/".join(errno.errorcode.get(e, str(e)) for e in sorted(expect))
+        tap.not_ok(name, "errno=%d (%s), expected %s"
+                   % (rejected[0], errno.errorcode.get(rejected[0], "?"), want))
+
+
+def _maybe_load_modules():
+    """Standalone runs self-load; a pre-loading harness passes --no-load.
+    Returns True iff this run loaded the providers, so the caller can
+    register teardown.
+    """
+    if "--no-load" in sys.argv[1:]:
+        return False
+    if os.path.isdir("/sys/module/drm_fabric"):
+        return False
+    here = os.path.dirname(os.path.abspath(__file__))
+    root = os.path.abspath(os.path.join(here, *([".."] * 6)))
+    fdir = os.environ.get("FABRIC_DIR") or os.path.join(
+        root, "drivers", "gpu", "drm", "fabric")
+    loaded = False
+    for ko in ("drm-fabric.ko", "drm-fabric-sim.ko"):
+        path = os.path.join(fdir, ko)
+        if os.path.isfile(path):
+            if subprocess.call(["insmod", path],
+                               stderr=subprocess.DEVNULL) == 0:
+                loaded = True
+    return loaded
+
+
+def _unload_providers():
+    subprocess.call(["rmmod", "drm_fabric_sim"], stderr=subprocess.DEVNULL)
+    subprocess.call(["rmmod", "drm_fabric"], stderr=subprocess.DEVNULL)
+
+
+class Cfg:
+    def __init__(self, sock, fid):
+        self.sock = sock
+        self.fid = fid
+
+
+def test_malformed_requests(ksft, cfg):
+    sock, fid = cfg.sock, cfg.fid
+    # Malformed framing/attributes must fail validation with -EINVAL.
+    EINVAL = {errno.EINVAL}
+
+    case_rejected(ksft, "wrong-type-short-u32", sock, fid, CMD_FABRIC_GET,
+                  nla(A_FABRIC_ID, struct.pack("=H", 1)), EINVAL)
+
+    case_rejected(ksft, "unknown-attribute-id", sock, fid, CMD_FABRIC_GET,
+                  nla_u32(A_FABRIC_ID, 1) + nla_u32(A_UNKNOWN, 0), EINVAL)
+
+    case_rejected(ksft, "missing-required-port-index", sock, fid, CMD_PORT_GET,
+                  nla_u32(A_ENDPOINT_ID, 0), EINVAL)
+
+
+def test_liveness(ksft, cfg):
+    """A dump that doesn't hang or error is not enough: it must also carry
+    a well-formed, zero-status terminal NLMSG_DONE, or a wedge/regression in
+    the dump's termination path would go unnoticed. An empty-but-valid dump
+    (no data records, just a clean DONE) is still a pass.
+    """
+    sock, fid = cfg.sock, cfg.fid
+    _SEQ[0] += 1
+    sock.send(build_msg(fid, CMD_FABRIC_GET, _SEQ[0], b"",
+                        flags=NLM_F_REQUEST | NLM_F_DUMP))
+    msgs = drain(sock)
+    errs = [e for (t, e) in msgs if t == NLMSG_ERROR and e != 0]
+    dones = [e for (t, e) in msgs if t == NLMSG_DONE]
+    if not msgs:
+        ksft.not_ok("liveness-dump-after-fuzz", "no response (possible hang)")
+    elif errs:
+        ksft.not_ok("liveness-dump-after-fuzz", "dump errno=%s" % errs[0])
+    elif not dones:
+        ksft.not_ok("liveness-dump-after-fuzz",
+                    "no terminal DONE (dump possibly truncated)")
+    elif dones[0] is None:
+        ksft.not_ok("liveness-dump-after-fuzz", "malformed terminal DONE")
+    elif dones[0] != 0:
+        ksft.not_ok("liveness-dump-after-fuzz",
+                    "terminal DONE error=%d" % dones[0])
+    else:
+        ksft.ok("liveness-dump-after-fuzz")
+
+
+def test_family_introspection(ksft, cfg):
+    """Via CTRL_CMD_GETFAMILY: version, admin-perm gating, mcast surface."""
+    getter_ids = [_SYMS[n] for n in (
+        "DRM_FABRIC_CMD_FABRIC_GET", "DRM_FABRIC_CMD_ENDPOINT_GET",
+        "DRM_FABRIC_CMD_PORT_GET", "DRM_FABRIC_CMD_PORT_STATS_GET")
+        if n in _SYMS]
+
+    info = get_family_info(cfg.sock, FAMILY_NAME)
+    if not info:
+        for nm in ("genl-family-version", "genl-mcast-monitor-present",
+                   "genl-getters-not-admin-perm"):
+            ksft.not_ok(nm, "CTRL_CMD_GETFAMILY introspection failed")
+        return
+
+    if info["version"] == EXPECTED_VERSION:
+        ksft.ok("genl-family-version (v%d)" % info["version"])
+    else:
+        ksft.not_ok("genl-family-version",
+                    "got %s want %d" % (info["version"], EXPECTED_VERSION))
+
+    if MCAST_MONITOR in info["mcast"]:
+        ksft.ok("genl-mcast-monitor-present")
+    else:
+        ksft.not_ok("genl-mcast-monitor-present",
+                    "groups=%s" % info["mcast"])
+
+    ops = info["ops"]
+    # A query-only build exposes getters only: each must be ungated (no
+    # GENL_ADMIN_PERM), so a normal namespace can enumerate topology.
+    seen_get = [c for c in getter_ids if c in ops]
+    bad_get = [c for c in seen_get if ops[c] & GENL_ADMIN_PERM]
+    if seen_get and not bad_get:
+        ksft.ok("genl-getters-not-admin-perm (%d cmds)" % len(seen_get))
+    else:
+        ksft.not_ok("genl-getters-not-admin-perm",
+                    "seen=%s wrongly-gated=%s" % (seen_get, bad_get))
+
+
+CASES = (
+    test_malformed_requests,
+    test_liveness,
+    test_family_introspection,
+)
+
+
+def main():
+    tap = L.Ksft()
+
+    if os.geteuid() != 0:
+        tap.skip_all("root is required to load drm_fabric modules")
+
+    if _maybe_load_modules():
+        L.on_teardown(_unload_providers)
+
+    try:
+        sock = open_sock()
+    except OSError as exc:
+        tap.skip_all("cannot open genetlink socket: %s" % exc)
+
+    fid = resolve_family(sock, FAMILY_NAME)
+    if not fid:
+        tap.skip_all("drm-fabric genl family not registered "
+                     "(load drm_fabric.ko)")
+
+    sys.stderr.write("# attribute/command ids from: %s\n" % _ID_SRC)
+
+    cfg = Cfg(sock, fid)
+    L.run_cases(tap, cfg, CASES)
+    tap.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/port_cursor_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/port_cursor_abi.py
new file mode 100755
index 000000000000..eef6378d5ec2
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/port_cursor_abi.py
@@ -0,0 +1,401 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""Exercise nested port-dump resume across endpoint removal.
+
+A resumed dump must not apply the removed endpoint's saved port cursor
+to its successor. Verify that each endpoint observed after removal starts
+at port index 0 for both PORT_GET and PORT_STATS_GET.
+"""
+
+import os
+import re
+import socket
+import struct
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L  # noqa: E402 - shared KTAP/module helpers
+
+# --- Netlink / generic-netlink constants (cf. dump_intr_abi.py) -----------
+
+NETLINK_GENERIC = 16
+NLMSG_ERROR = 0x2
+NLMSG_DONE = 0x3
+NLM_F_REQUEST = 0x01
+NLM_F_DUMP = 0x300
+NLMSG_HDRLEN = 16
+GENL_HDRLEN = 4
+NLA_HDRLEN = 4
+NLA_TYPE_MASK = 0x3FFF
+CTRL_ID = 0x10
+CTRL_CMD_GETFAMILY = 3
+CTRL_ATTR_FAMILY_NAME = 2
+CTRL_ATTR_FAMILY_ID = 1
+
+SEQ = 2                 # request sequence; replies in the dump must echo it
+
+# Multi-port endpoints so a batch boundary can land *inside* an endpoint (the
+# only case that exercises a non-zero saved port cursor). 15 is near the sim's
+# 16-port cap and rarely divides the per-batch port capacity evenly.
+PORTS = int(os.environ.get("PORT_CURSOR_PORTS", "15"))
+SCALE = int(os.environ.get("PORT_CURSOR_SCALE", "160"))
+
+
+def _align4(n):
+    return (n + 3) & ~3
+
+
+def _nla(atype, payload):
+    length = NLA_HDRLEN + len(payload)
+    pad = b"\x00" * (_align4(length) - length)
+    return struct.pack("=HH", length, atype) + payload + pad
+
+
+def _msg(family_id, cmd, seq, flags, payload=b""):
+    body = struct.pack("=BBH", cmd, 1, 0) + payload
+    total = NLMSG_HDRLEN + len(body)
+    return struct.pack("=IHHII", total, family_id, flags, seq, 0) + body
+
+
+def _open():
+    s = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, NETLINK_GENERIC)
+    s.bind((0, 0))
+    s.settimeout(5)
+    return s
+
+
+def _resolve_family(sock, name):
+    sock.send(_msg(CTRL_ID, CTRL_CMD_GETFAMILY, 1, NLM_F_REQUEST,
+                   _nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00")))
+    data = sock.recv(8192)
+    (_, mtype, _, _, _) = struct.unpack_from("=IHHII", data, 0)
+    if mtype == NLMSG_ERROR:
+        return None
+    off = NLMSG_HDRLEN + GENL_HDRLEN
+    while off + NLA_HDRLEN <= len(data):
+        (alen, atype) = struct.unpack_from("=HH", data, off)
+        if alen < NLA_HDRLEN:
+            break
+        if atype == CTRL_ATTR_FAMILY_ID and alen >= 6:
+            return struct.unpack_from("=H", data, off + 4)[0]
+        off += _align4(alen)
+    return None
+
+
+def _enum(name):
+    """Parse `enum <name> { ... }` from the uAPI header into {member: value}.
+    A value referencing another enumerator (the generated `MAX = (__MAX - 1)`
+    sentinel) fails int() and is skipped rather than silently mis-numbering.
+    """
+    out = {}
+    try:
+        text = open(L.UAPI_HEADER).read()
+    except OSError:
+        return out
+    m = re.search(r"enum\s+%s\s*\{(.*?)\}" % re.escape(name), text, re.S)
+    if not m:
+        return out
+    n = 0
+    for raw in re.sub(r"/\*.*?\*/", "", m.group(1), flags=re.S).split(","):
+        item = raw.strip()
+        if not item:
+            continue
+        if "=" in item:
+            key, val = item.split("=", 1)
+            key = key.strip()
+            try:
+                n = int(val.strip(), 0)
+            except ValueError:
+                continue        # references another enumerator; skip sentinel
+        else:
+            key = item
+        out[key] = n
+        n += 1
+    return out
+
+
+_HDR_PRESENT = os.path.isfile(L.UAPI_HEADER)
+_CMD = _enum("drm_fabric_cmd")
+_A = _enum("drm_fabric_a")
+_PA = _enum("drm_fabric_a_port_attrs")
+_PSA = _enum("drm_fabric_a_port_stats_attrs")
+
+# (wanted name, parsed dict, fallback id) -- fallbacks match the current ABI and
+# are only trusted when the header is absent (see main()).
+_WANTED = (
+    ("DRM_FABRIC_CMD_PORT_GET", _CMD, 3),
+    ("DRM_FABRIC_CMD_PORT_STATS_GET", _CMD, 4),
+    ("DRM_FABRIC_A_PORT", _A, 3),
+    ("DRM_FABRIC_A_PORT_STATS", _A, 4),
+    ("DRM_FABRIC_A_PORT_ATTRS_PORT_INDEX", _PA, 1),
+    ("DRM_FABRIC_A_PORT_ATTRS_ENDPOINT_ID", _PA, 2),
+    ("DRM_FABRIC_A_PORT_STATS_ATTRS_ENDPOINT_ID", _PSA, 2),
+    ("DRM_FABRIC_A_PORT_STATS_ATTRS_PORT_INDEX", _PSA, 3),
+)
+CMD_PORT_GET = _CMD.get("DRM_FABRIC_CMD_PORT_GET", 3)
+CMD_PORT_STATS_GET = _CMD.get("DRM_FABRIC_CMD_PORT_STATS_GET", 4)
+A_PORT = _A.get("DRM_FABRIC_A_PORT", 3)
+A_PORT_STATS = _A.get("DRM_FABRIC_A_PORT_STATS", 4)
+PA_PORT_INDEX = _PA.get("DRM_FABRIC_A_PORT_ATTRS_PORT_INDEX", 1)
+PA_ENDPOINT_ID = _PA.get("DRM_FABRIC_A_PORT_ATTRS_ENDPOINT_ID", 2)
+PSA_ENDPOINT_ID = _PSA.get("DRM_FABRIC_A_PORT_STATS_ATTRS_ENDPOINT_ID", 2)
+PSA_PORT_INDEX = _PSA.get("DRM_FABRIC_A_PORT_STATS_ATTRS_PORT_INDEX", 3)
+
+
+def _walk(buf, base, end):
+    """Yield (masked_type, payload) for well-formed nlattrs in buf[base:end]."""
+    off = base
+    while off + NLA_HDRLEN <= end:
+        (alen, atype) = struct.unpack_from("=HH", buf, off)
+        if alen < NLA_HDRLEN or off + alen > end:
+            break                       # malformed: stop rather than over-read
+        yield atype & NLA_TYPE_MASK, buf[off + NLA_HDRLEN:off + alen]
+        off += _align4(alen)
+
+
+def _parse_entry(payload, outer, ep_attr, idx_attr):
+    """Extract (endpoint_id, port_index) from one dump reply payload. @outer
+    is the top-level nest (A_PORT/A_PORT_STATS); @ep_attr/@idx_attr are the
+    member ids inside it.
+    """
+    ep_id = port_idx = None
+    for atype, data in _walk(payload, 0, len(payload)):
+        if atype != outer:
+            continue
+        for btype, bdata in _walk(data, 0, len(data)):
+            if btype == ep_attr and len(bdata) >= 4:
+                ep_id = struct.unpack_from("=I", bdata, 0)[0]
+            elif btype == idx_attr and len(bdata) >= 4:
+                port_idx = struct.unpack_from("=I", bdata, 0)[0]
+    return ep_id, port_idx
+
+
+def _read_batch(sock, fam, seq, outer, ep_attr, idx_attr):
+    """Read one dump datagram with strict structural validation.
+
+    Returns (pairs, last_ep, done, err). Any malformed length, unexpected
+    family/sequence, or unparseable reply sets err (reported, not silently
+    dropped).
+    """
+    pairs, last_ep, done, err = [], None, False, False
+    try:
+        data = sock.recv(65536)
+    except socket.timeout:
+        return pairs, last_ep, True, True   # a stall mid-dump is a failure here
+    off, end = 0, len(data)
+    while off + NLMSG_HDRLEN <= end:
+        (mlen, mtype, _, mseq, _) = struct.unpack_from("=IHHII", data, off)
+        if mlen < NLMSG_HDRLEN or off + mlen > end:
+            err = True
+            break
+        if mtype == NLMSG_DONE:
+            done = True
+        elif mtype == NLMSG_ERROR:
+            err = True
+        elif mtype == fam and mseq == seq:
+            body = off + NLMSG_HDRLEN + GENL_HDRLEN
+            ep_id, port_idx = _parse_entry(memoryview(data)[body:off + mlen],
+                                           outer, ep_attr, idx_attr)
+            if ep_id is not None and port_idx is not None:
+                pairs.append((ep_id, port_idx))
+                last_ep = ep_id
+            else:
+                err = True
+        else:
+            err = True
+        off += _align4(mlen)
+    return pairs, last_ep, done, err
+
+
+class Cfg:
+    def __init__(self, fam, fab):
+        self.fam = fam
+        self.fab = fab                  # YnlFamily handle (drm-fabric)
+        self.ep_slot = {}               # endpoint-id -> fabricsim slot
+        self.ep_ports = {}              # endpoint-id -> its own port count
+        self.abort = False
+
+
+def _ensure_population(cfg):
+    """Top up to SCALE endpoints and rebuild the endpoint-id -> slot map.
+
+    add_endpoint reuses freed slots, so the map is rebuilt each time.
+    """
+    have = len(cfg.fab.dump("endpoint-get", {}))
+    for _ in range(SCALE - have):
+        try:
+            L.dbg_write("add_endpoint", PORTS)
+        except OSError:
+            break
+    ep_slot = {}
+    for e in cfg.fab.dump("endpoint-get", {}):
+        ep = e["endpoint"]
+        m = re.match(r"sim-ep(\d+)$", ep.get("name", ""))
+        if m:
+            ep_slot[ep["endpoint-id"]] = int(m.group(1))
+    cfg.ep_slot = ep_slot
+
+    # Per-endpoint port count, taken from each endpoint's own topology rather
+    # than the global PORTS: the baseline population and runtime-added endpoints
+    # can differ in width, and the "provably mid-dump" oracle below must compare
+    # against the specific endpoint being suspended, not a module-wide setting.
+    ep_ports = {}
+    for p in cfg.fab.dump("port-get", {}):
+        port = p["port"]
+        ep_ports[port["endpoint-id"]] = ep_ports.get(port["endpoint-id"], 0) + 1
+    cfg.ep_ports = ep_ports
+
+
+def _reload():
+    L.rmmod("drm_fabric_sim")
+    if not L.module_loaded("drm_fabric"):
+        if not L.insmod("drm-fabric.ko"):
+            return False
+    # A tiny baseline; the multi-port population is added below.
+    if not L.insmod("drm-fabric-sim.ko", "num_endpoints=2", "ports_per_ep=2",
+                    "topology=linear"):
+        return False
+    L.wait_until(lambda: L.module_loaded("drm_fabric_sim"))
+    return True
+
+
+def _restore_default():
+    """Restore fabricsim's default shape so the next suite (sharing the loaded
+    module) does not inherit this suite's small/churned population."""
+    L.rmmod("drm_fabric_sim")
+    if not L.module_loaded("drm_fabric"):
+        L.insmod("drm-fabric.ko")
+    L.insmod("drm-fabric-sim.ko")
+    L.wait_until(lambda: L.module_loaded("drm_fabric_sim"))
+
+
+def _dump_removal_keeps_leading_ports(ksft, cfg, cmd, outer, ep_attr, idx_attr,
+                                      tag):
+    """Assert every endpoint still starts at port 0 after a mid-endpoint
+    removal. The stats variant also runs the provider callback off the
+    topology lock during resume.
+    """
+    _ensure_population(cfg)
+    s = _open()
+    s.send(_msg(cfg.fam, cmd, SEQ, NLM_F_REQUEST | NLM_F_DUMP))
+
+    seen = {}           # ep_id -> set(port_index) seen so far
+    deleted = set()
+    batches = exercised = 0
+    done = err = False
+    while not done:
+        pairs, last_ep, done, e = _read_batch(s, cfg.fam, SEQ,
+                                              outer, ep_attr, idx_attr)
+        err = err or e
+        if pairs:
+            batches += 1
+            for ep_id, port_idx in pairs:
+                seen.setdefault(ep_id, set()).add(port_idx)
+        # Delete only when provably mid-dump: the cumulative port set is a
+        # strict, non-empty subset of that endpoint's own width, i.e. the
+        # saved cursor is (last_ep, port_idx>0).
+        ep_width = cfg.ep_ports.get(last_ep, PORTS)
+        if (last_ep is not None and last_ep not in deleted
+                and last_ep in cfg.ep_slot
+                and 0 < len(seen.get(last_ep, ())) < ep_width):
+            try:
+                L.dbg_write("del_endpoint", cfg.ep_slot[last_ep])
+                deleted.add(last_ep)
+                exercised += 1
+            except OSError:
+                pass
+        if batches > 10000:
+            break
+    s.close()
+
+    if not ksft.check(batches >= 2 and not err,
+                      "%s-dump-spans-multiple-batches" % tag,
+                      "batches=%d err=%s (raise PORT_CURSOR_SCALE)"
+                      % (batches, err)):
+        cfg.abort = True
+        return
+
+    if not ksft.check(exercised >= 1,
+                      "%s-dump-exercised-mid-endpoint-removal" % tag,
+                      "no batch suspended mid-endpoint "
+                      "(raise PORT_CURSOR_PORTS/PORT_CURSOR_SCALE)"):
+        cfg.abort = True
+        return
+
+    # The invariant: no endpoint may appear missing its leading ports.
+    bad = {ep: sorted(ports)[:3] for ep, ports in seen.items()
+           if 0 not in ports}
+    ksft.check(not bad, "%s-no-leading-ports-dropped" % tag,
+               "endpoints missing port 0: %s"
+               % ", ".join("ep%d=%s" % (e, p) for e, p in bad.items()))
+
+
+def test_port_get_dump_removal_keeps_leading_ports(ksft, cfg):
+    """Nested PORT_GET cursor survives mid-dump endpoint removal."""
+    _dump_removal_keeps_leading_ports(ksft, cfg, CMD_PORT_GET, A_PORT,
+                                      PA_ENDPOINT_ID, PA_PORT_INDEX, "port-get")
+
+
+def test_port_stats_dump_removal_keeps_leading_ports(ksft, cfg):
+    """Nested PORT_STATS_GET cursor + unlocked stats callback survive
+    mid-dump endpoint removal."""
+    _dump_removal_keeps_leading_ports(ksft, cfg, CMD_PORT_STATS_GET,
+                                      A_PORT_STATS, PSA_ENDPOINT_ID,
+                                      PSA_PORT_INDEX, "port-stats-get")
+
+
+CASES = (
+    test_port_get_dump_removal_keeps_leading_ports,
+    test_port_stats_dump_removal_keeps_leading_ports,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()  # early SKIP if the YNL lib is missing
+
+    if not L.is_root():
+        ksft.skip_all("must run as root (genetlink + debugfs)")
+
+    # Trust parsed ids only when they are complete; require every wanted enum
+    # name when the header is present so a partial parse cannot mis-number.
+    missing = [nm for nm, d, _ in _WANTED if nm not in d]
+    if _HDR_PRESENT and missing:
+        ksft.skip_all("uAPI header present but missing enum(s): %s"
+                      % ", ".join(missing))
+    if not _HDR_PRESENT:
+        print("# port_cursor_abi: uAPI header absent, using id fallbacks")
+
+    if not _reload():
+        ksft.skip_all("could not load drm_fabric_sim")
+    # Primary cleanup is try/finally below; on_teardown() is the backup for hard
+    # exits, including the timeout killer's SIGTERM (which atexit would miss),
+    # so this suite's churned population never leaks into the next one.
+    L.on_teardown(_restore_default)
+
+    if not L.debugfs_available():
+        ksft.skip_all("fabricsim debugfs not present")
+
+    try:
+        fab = L.DrmFabric()
+    except (OSError, NlError) as exc:
+        ksft.skip_all("cannot open drm-fabric family: %s" % exc)
+
+    s = _open()
+    fam = _resolve_family(s, L.FAMILY.encode())
+    s.close()
+    if not fam:
+        ksft.skip_all("could not resolve %s family id" % L.FAMILY)
+
+    # Each case tops the multi-port population up to SCALE (so a dump spans many
+    # batches) and rebuilds the endpoint-id -> slot map before it runs.
+    try:
+        L.run_cases(ksft, Cfg(fam, fab), CASES)
+    finally:
+        _restore_default()
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/port_stats_cap_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/port_stats_cap_abi.py
new file mode 100755
index 000000000000..738ee76884f8
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/port_stats_cap_abi.py
@@ -0,0 +1,374 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+Heterogeneous per-port stats: a dump skips a port whose provider returns
+-EOPNOTSUPP and resumes; any other errno ends the dump. pyynl reassembles
+multipart dumps transparently, so this talks raw Generic Netlink.
+
+Needs drm_fabric + drm_fabric_sim (>= 3 ports on ep0), fabricsim debugfs
+(per-port stats_errno, bulk_add/bulk_del), and root.
+"""
+
+import glob
+import os
+import re
+import socket
+import struct
+import sys
+import time
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L  # noqa: E402 - shared KTAP/module helpers
+
+EOPNOTSUPP = 95
+EIO = 5
+MID = 1  # not the first/last port, so skipping it proves resumption
+
+# Runtime endpoints added for the skip case. ep0 is enumerated first, so its
+# skipped port is necessarily behind a batch boundary from everything added
+# here. Overridable where record size or NLMSG_GOODSIZE change the batch
+# arithmetic enough to leave the dump single-batch.
+RESUME_SCALE = int(os.environ.get("STATS_RESUME_SCALE", "300"))
+
+# --- raw Generic Netlink (cf. nl_policy_probe.py, dump_intr_abi.py) -------
+
+FAMILY_NAME = b"drm-fabric"
+
+NETLINK_GENERIC = 16
+NLMSG_ERROR = 0x2
+NLMSG_DONE = 0x3
+NLM_F_REQUEST = 0x01
+NLM_F_DUMP = 0x300
+NLMSG_HDRLEN = 16
+GENL_HDRLEN = 4
+CTRL_ID = 0x10
+CTRL_CMD_GETFAMILY = 3
+CTRL_ATTR_FAMILY_ID = 1
+CTRL_ATTR_FAMILY_NAME = 2
+NLA_TYPE_MASK = 0x3FFF  # strips NLA_F_NESTED / NLA_F_NET_BYTEORDER
+
+# Small reads keep dump batches small, making resume easier to exercise.
+BATCH_READ = 8192
+
+
+def _align4(n):
+    return (n + 3) & ~3
+
+
+def _nla(attr_type, payload):
+    length = 4 + len(payload)
+    pad = b"\x00" * (_align4(length) - length)
+    return struct.pack("=HH", length, attr_type) + payload + pad
+
+
+def _msg(family_id, cmd, seq, flags, payload=b""):
+    body = struct.pack("=BBH", cmd, 1, 0) + payload
+    total = NLMSG_HDRLEN + len(body)
+    return struct.pack("=IHHII", total, family_id, flags, seq, 0) + body
+
+
+def _open():
+    s = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, NETLINK_GENERIC)
+    s.bind((0, 0))
+    s.settimeout(5)
+    return s
+
+
+def _resolve_family(sock, name):
+    sock.send(_msg(CTRL_ID, CTRL_CMD_GETFAMILY, 1, NLM_F_REQUEST,
+                   _nla(CTRL_ATTR_FAMILY_NAME, name + b"\x00")))
+    data = sock.recv(8192)
+    (_, mtype, _, _, _) = struct.unpack_from("=IHHII", data, 0)
+    if mtype == NLMSG_ERROR:
+        return None
+    for atype, payload in _iter_attrs(data[NLMSG_HDRLEN + GENL_HDRLEN:]):
+        if atype != CTRL_ATTR_FAMILY_ID:
+            continue
+        # CTRL_ATTR_FAMILY_ID is a u16; tolerate a u32 encoding too.
+        if len(payload) >= 4:
+            return struct.unpack_from("=I", payload)[0]
+        if len(payload) >= 2:
+            return struct.unpack_from("=H", payload)[0]
+    return None
+
+
+def _iter_attrs(blob):
+    off = 0
+    while off + 4 <= len(blob):
+        (alen, atype) = struct.unpack_from("=HH", blob, off)
+        if alen < 4:
+            break
+        yield atype & NLA_TYPE_MASK, blob[off + 4:off + alen]
+        off += _align4(alen)
+
+
+def _uapi_ids():
+    """Stats-dump ids from the generated uAPI header.
+
+    No fallback table: an unreadable header skips the suite rather than
+    decoding under a stale guess.
+    """
+    want = ("DRM_FABRIC_CMD_PORT_STATS_GET",
+            "DRM_FABRIC_A_PORT_STATS",
+            "DRM_FABRIC_A_PORT_STATS_ATTRS_ENDPOINT_ID",
+            "DRM_FABRIC_A_PORT_STATS_ATTRS_PORT_INDEX")
+    try:
+        text = open(L.UAPI_HEADER).read()
+    except OSError:
+        return None
+    # Commands are an anonymous enum and attributes are named ones, so merge
+    # every block flatly rather than parsing by enum name.
+    syms = {}
+    for body in re.findall(r"enum\s*(?:\w+\s*)?\{(.*?)\}", text, re.S):
+        nxt = 0
+        for raw in body.split(","):
+            item = raw.split("/*")[0].strip()
+            if not item:
+                continue
+            if "=" in item:
+                name, val = item.split("=", 1)
+                name = name.strip()
+                try:
+                    nxt = int(val.strip(), 0)
+                except ValueError:
+                    continue
+            else:
+                name = item
+            if name.isidentifier():
+                syms[name] = nxt
+            nxt += 1
+    if not all(w in syms for w in want):
+        return None
+    return {"cmd": syms[want[0]], "nest": syms[want[1]],
+            "ep": syms[want[2]], "port": syms[want[3]]}
+
+
+def _record(body, ids):
+    """(endpoint-id, port-index) carried by one stats entry, or None."""
+    for atype, payload in _iter_attrs(body):
+        if atype != ids["nest"]:
+            continue
+        ep = idx = None
+        for natype, npayload in _iter_attrs(payload):
+            if natype == ids["ep"] and len(npayload) >= 4:
+                ep = struct.unpack_from("=I", npayload)[0]
+            elif natype == ids["port"] and len(npayload) >= 4:
+                idx = struct.unpack_from("=I", npayload)[0]
+        if ep is not None and idx is not None:
+            return (ep, idx)
+    return None
+
+
+class Dump:
+    """Records in wire order, plus how the kernel delivered them."""
+
+    def __init__(self, batches, records, done, error, timed_out):
+        self.batches = batches
+        self.records = records
+        self.done = done
+        self.error = error
+        self.timed_out = timed_out
+
+    @property
+    def ok(self):
+        return self.done and not self.error and not self.timed_out
+
+    def __str__(self):
+        return ("batches=%d records=%d done=%s error=%s timeout=%s"
+                % (self.batches, len(self.records), self.done, self.error,
+                   self.timed_out))
+
+
+def _dump_stats(ids):
+    """Run an unfiltered PORT_STATS_GET dump batch by batch."""
+    sock = _open()
+    try:
+        sock.send(_msg(ids["fam"], ids["cmd"], 2, NLM_F_REQUEST | NLM_F_DUMP))
+        batches, recs, done, err = 0, [], False, False
+        while not done:
+            try:
+                data = sock.recv(BATCH_READ)
+            except socket.timeout:
+                return Dump(batches, recs, done, err, True)
+            if not data:
+                break
+            batches += 1
+            off = 0
+            while off + NLMSG_HDRLEN <= len(data):
+                (mlen, mtype, _, _, _) = struct.unpack_from("=IHHII", data, off)
+                if mlen < NLMSG_HDRLEN:
+                    break
+                if mtype == NLMSG_DONE:
+                    done = True
+                elif mtype == NLMSG_ERROR:
+                    err = True
+                else:
+                    rec = _record(data[off + NLMSG_HDRLEN + GENL_HDRLEN:
+                                       off + mlen], ids)
+                    if rec:
+                        recs.append(rec)
+                off += _align4(mlen)
+            if batches > 10000:  # runaway guard
+                break
+        return Dump(batches, recs, done, err, False)
+    finally:
+        sock.close()
+
+
+def _grow(ids):
+    """Grow until the dump spans several batches.
+
+    bulk_add is asynchronous, so read back until two dumps agree.
+    """
+    L.dbg_write("bulk_add", RESUME_SCALE)
+    last, deadline = -1, time.monotonic() + 10.0
+    while time.monotonic() < deadline:
+        now = len(_dump_stats(ids).records)
+        if now == last:
+            return now
+        last = now
+        time.sleep(0.05)
+    return last
+
+
+def _ep0(fab):
+    """endpoint-id of the first init endpoint (debugfs dir ep0, name sim-ep0)."""
+    for e in fab.dump("endpoint-get", {}):
+        ep = e["endpoint"]
+        if ep.get("name") == "sim-ep0":
+            return ep["endpoint-id"]
+    return None
+
+
+def _port_count(fab, ep_id):
+    return len(fab.dump("port-get", {"endpoint-id": ep_id}))
+
+
+def _knob(port, val):
+    # fabricsim's per-port debugfs control: forces @port's next stats
+    # callback to return -@val instead of real data.
+    L.dbg_write("ep0/port%d/stats_errno" % port, val)
+
+
+class Cfg:
+    def __init__(self, fab, ep_id, nports, nl_error, ids):
+        self.fab = fab
+        self.ep_id = ep_id
+        self.nports = nports
+        self.NlError = nl_error
+        self.ids = ids
+
+
+def test_dump_skips_unsupported_port(ksft, cfg):
+    """A mid-list -EOPNOTSUPP port is skipped across a real batch boundary.
+
+    Expectation is the unknobbed dump minus exactly that port, so a lost
+    neighbour, a re-emit after resume, or a duplicate all fail.
+    """
+    name = "stats-dump-skips-unsupported"
+    ids = cfg.ids
+    skipped = (cfg.ep_id, MID)
+    try:
+        _grow(ids)
+        base = _dump_stats(ids)
+        if not base.ok or not base.records:
+            ksft.not_ok(name, "unknobbed dump unusable: %s" % base)
+            return
+        _knob(MID, EOPNOTSUPP)
+        got = _dump_stats(ids)
+        if not got.ok:
+            ksft.not_ok(name, "dump did not complete: %s" % got)
+            return
+        lost = sorted(set(base.records) - set(got.records))
+        extra = sorted(set(got.records) - set(base.records))
+        dupes = len(got.records) != len(set(got.records))
+        ksft.check(got.batches >= 2 and lost == [skipped] and not extra
+                   and not dupes,
+                   name,
+                   "%s lost=%s extra=%s dupes=%s (want lost=[%s], >=2 "
+                   "batches -- raise STATS_RESUME_SCALE if single-batch)"
+                   % (got, lost, extra, dupes, skipped))
+    finally:
+        _knob(MID, 0)
+        L.dbg_write("bulk_del", 0)
+
+
+def test_targeted_unsupported_port_eopnotsupp(ksft, cfg):
+    """A targeted request for the unsupported port still returns -EOPNOTSUPP."""
+    fab, NlError = cfg.fab, cfg.NlError
+    _knob(MID, EOPNOTSUPP)
+    try:
+        fab.do("port-stats-get", {"endpoint-id": cfg.ep_id, "port-index": MID})
+        ksft.not_ok("stats-targeted-unsupported-eopnotsupp", "request accepted")
+    except NlError as exc:
+        e = L.nl_errno(exc)
+        ksft.check(e == EOPNOTSUPP, "stats-targeted-unsupported-eopnotsupp",
+                   "errno=%d (want EOPNOTSUPP=%d)" % (e, EOPNOTSUPP))
+    finally:
+        _knob(MID, 0)
+
+
+def test_dump_aborts_on_real_error(ksft, cfg):
+    """A non-capability provider error (EIO) ends the dump."""
+    fab, NlError = cfg.fab, cfg.NlError
+    _knob(MID, EIO)
+    try:
+        try:
+            fab.dump("port-stats-get", {"endpoint-id": cfg.ep_id})
+            ksft.not_ok("stats-dump-aborts-on-real-error",
+                        "dump completed instead of aborting")
+        except NlError as exc:
+            e = L.nl_errno(exc)
+            ksft.check(e == EIO, "stats-dump-aborts-on-real-error",
+                       "errno=%d (want EIO=%d)" % (e, EIO))
+    finally:
+        _knob(MID, 0)
+
+
+CASES = (
+    test_dump_skips_unsupported_port,
+    test_targeted_unsupported_port_eopnotsupp,
+    test_dump_aborts_on_real_error,
+)
+
+
+def main():
+    ksft = L.Ksft()
+    _, NlError = L.import_ynl()
+
+    with L.fabricsim(ksft, need_debugfs=True) as fab:
+        if not L.family_has_op(fab, "port-stats-get"):
+            ksft.skip_all("port-stats-get op absent")
+        ep_id = _ep0(fab)
+        if ep_id is None:
+            ksft.skip_all("sim-ep0 endpoint not present")
+        # The per-port stats_errno knob only exists on a recent simulator.
+        if not glob.glob(os.path.join(L.DEBUGFS, "ep0", "port*", "stats_errno")):
+            ksft.skip_all("fabricsim lacks per-port stats_errno knob (old module)")
+        # The skip case needs a population big enough to span dump batches.
+        if not os.path.exists(os.path.join(L.DEBUGFS, "bulk_add")):
+            ksft.skip_all("fabricsim lacks bulk_add (cannot reach a resume "
+                          "boundary)")
+        nports = _port_count(fab, ep_id)
+        if nports < 3:
+            ksft.skip_all("need >= 3 ports on ep0 to place a mid-list skip "
+                          "(have %d)" % nports)
+        ids = _uapi_ids()
+        if ids is None:
+            ksft.skip_all("could not resolve stats uAPI ids from %s"
+                          % L.UAPI_HEADER)
+        sock = _open()
+        try:
+            fam = _resolve_family(sock, FAMILY_NAME)
+        finally:
+            sock.close()
+        if fam is None:
+            ksft.skip_all("drm-fabric generic netlink family not resolvable")
+        ids["fam"] = fam
+        L.run_cases(ksft, Cfg(fab, ep_id, nports, NlError, ids), CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/settings b/tools/testing/selftests/drivers/gpu/drm_fabric/settings
new file mode 100644
index 000000000000..694d70710ff0
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/settings
@@ -0,0 +1 @@
+timeout=300
diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py
new file mode 100755
index 000000000000..775be4ac2160
--- /dev/null
+++ b/tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Intel Corporation
+"""
+fabricsim's "switch" shape links each leaf's first port to an opaque
+switch that is not a registered endpoint: asserts half-edge serialization
+and peer-id non-resolution, not leaf-switch-leaf reachability.
+
+--no-load is ignored (needs a fresh insmod). Run as root.
+"""
+
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+import lib_drm_fabric as L
+
+
+def ports_of(fab, ep_id):
+    return [p["port"] for p in fab.dump("port-get", {"endpoint-id": ep_id})]
+
+
+def switch_peers(fab, sim_eps):
+    """All TYPE=switch peers across the sim leaves: [(ep, peer), ...]."""
+    out = []
+    for e in sim_eps:
+        for p in ports_of(fab, e["endpoint-id"]):
+            peer = p.get("peer")
+            if peer and peer.get("type") == "switch":
+                out.append((e, peer))
+    return out
+
+
+class Cfg:
+    def __init__(self, fab, sim_eps, sw_peers):
+        self.fab = fab
+        self.sim_eps = sim_eps
+        self.sw_peers = sw_peers
+        self.abort = False
+
+
+def test_every_leaf_has_switch_peer(ksft, cfg):
+    """Every leaf endpoint has a port with a TYPE=switch half-edge."""
+    ksft.check(len(cfg.sw_peers) == len(cfg.sim_eps),
+               "switch-every-leaf-has-switch-peer",
+               "switch-peers=%d leaves=%d"
+               % (len(cfg.sw_peers), len(cfg.sim_eps)))
+    if not cfg.sw_peers:
+        cfg.abort = True
+
+
+def test_half_edge_fully_serialized(ksft, cfg):
+    """Every switch half-edge carries all three peer fields."""
+    complete = all(
+        {"peer-id", "type", "port-index"} <= set(peer)
+        for _, peer in cfg.sw_peers)
+    ksft.check(complete, "switch-half-edge-fully-serialized",
+               "a switch peer is missing peer-id/type/port-index")
+
+
+def test_single_opaque_switch_id(ksft, cfg):
+    """All leaves name one opaque switch id, each via a distinct switch port."""
+    ids = {peer["peer-id"] for _, peer in cfg.sw_peers}
+    ports = [peer["port-index"] for _, peer in cfg.sw_peers]
+    ksft.check(len(ids) == 1, "switch-single-opaque-id",
+               "switch peer-ids=%s" % sorted(ids))
+    ksft.check(len(set(ports)) == len(ports), "switch-distinct-switch-ports",
+               "switch-side port-indexes=%s" % sorted(ports))
+
+
+def test_switch_id_does_not_resolve(ksft, cfg):
+    """The opaque switch id is not a registered endpoint (local adjacency)."""
+    ep_fepids = {e["fabric-ep-id"] for e in cfg.sim_eps}
+    sw_ids = {peer["peer-id"] for _, peer in cfg.sw_peers}
+    leaked = sw_ids & ep_fepids
+    ksft.check(not leaked, "switch-id-does-not-resolve-to-endpoint",
+               "switch id resolves to an endpoint fabric-ep-id: %s"
+               % sorted(leaked))
+
+
+CASES = (
+    test_every_leaf_has_switch_peer,
+    test_half_edge_fully_serialized,
+    test_single_opaque_switch_id,
+    test_switch_id_does_not_resolve,
+)
+
+
+def main():
+    ksft = L.Ksft()
+
+    # The switch shape is an insmod parameter, so fabricsim is always reloaded
+    # with topology=switch (ignoring --no-load) and restored to default on exit.
+    with L.fabricsim(ksft, topology="switch") as fab:
+        eps = [e["endpoint"] for e in fab.dump("endpoint-get", {})]
+        # Restrict to fabricsim's members (ignore anything a prior suite left).
+        sim_eps = [e for e in eps if e["name"].startswith("sim-ep")]
+        if len(sim_eps) < 2:
+            ksft.skip_all("switch topology needs >= 2 endpoints, got %d"
+                          % len(sim_eps))
+
+        sw_peers = switch_peers(fab, sim_eps)
+        L.run_cases(ksft, Cfg(fab, sim_eps, sw_peers), CASES)
+    ksft.finish()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0

