Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B68C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFD710E663;
	Mon, 24 Aug 2026 08:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P7a4gmfG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CF610E67C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:09:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E10C3601E9;
 Mon, 24 Aug 2026 08:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36C51F00A3A;
 Mon, 24 Aug 2026 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787558991;
 bh=J9YA0/VklkwBC0HlZut8enaIr+w0BaSvYJJtJ8AazmU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P7a4gmfGez/qO1x7xgwU+pU7/emGuDi/I42gmpCDIP2Q3+eGqiS3xxnbYYmEx12Kx
 zYC/WocVstHoxx8sHKG2sy9A8OwOrpHaZZC0SHgk8SskF2nnnAJyTqxVO45MKWxMDk
 G2s9If9c4bUDOsBFUYLTNgb1xNZfahQep7Hn4n+9V8ayeS9G6LsivYYT6GyU2KQvks
 Cbphn5Cl+sJtECUZYzldEsa4MxX2lz8su5hS4ucvpKJLfAjrDvRimfv7do2qwhh5F5
 Ehxh6U6tW3Ig6qLSusdl25I5hub94BrZtgKzceEjxEsUIpQq3qP2BpZaPTrvHRCLny
 1jCkD2mFMr46Q==
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
Subject: [RFC PATCH 02/12] drm/fabric: add query uAPI and generated headers
Date: Mon, 24 Aug 2026 11:09:30 +0300
Message-ID: <5e89aa4e8c8cd5febf4146f2e6891272203be3a6.1787552412.git.ksinyuk@kernel.org>
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

From: Ilia Levi <ilia.levi@intel.com>

Add a YNL specification for the drm-fabric Generic Netlink family and
generate its userspace and kernel headers, giving the object model from
the previous patch a userspace-visible wire format.

The read-only ABI provides FABRIC_GET, ENDPOINT_GET, PORT_GET and
PORT_STATS_GET as single lookups and multipart dumps. Notifications report
fabric and endpoint lifecycle, peer adjacency and port state through the
monitor multicast group.

The wire format separates core-assigned object IDs from provider-defined
endpoint and peer identities and carries a topology-generation token.
Document the family, the YAML-as-contract rule and the append-only
stability guarantees in Documentation/gpu/drm-fabric.rst, together with
the full identity and consistency semantics.

Generate the headers from the tree root with:

  tools/net/ynl/pyynl/ynl_gen_c.py --mode uapi --header \
      --spec Documentation/netlink/specs/drm_fabric.yaml \
      -o include/uapi/drm/drm_fabric.h
  tools/net/ynl/pyynl/ynl_gen_c.py --mode kernel --header \
      --spec Documentation/netlink/specs/drm_fabric.yaml \
      -o drivers/gpu/drm/fabric/drm_fabric_nl.h

The generated operation and policy source references the doit and dumpit
handlers, so it lands with their implementation in the next patch. The
generated uAPI header replaces the enums defined locally in the previous
patch.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Co-developed-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst            |  35 ++
 Documentation/netlink/specs/drm_fabric.yaml | 427 ++++++++++++++++++++
 drivers/gpu/drm/fabric/drm_fabric_nl.h      |  36 ++
 include/drm/drm_fabric.h                    |  21 +-
 include/uapi/drm/drm_fabric.h               | 134 ++++++
 5 files changed, 635 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/netlink/specs/drm_fabric.yaml
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_nl.h
 create mode 100644 include/uapi/drm/drm_fabric.h

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
index 99b189dc614e..d2c9e694b67f 100644
--- a/Documentation/gpu/drm-fabric.rst
+++ b/Documentation/gpu/drm-fabric.rst
@@ -140,3 +140,38 @@ error return, warns and performs no teardown. Endpoint registration rejects a
 departed parent the same way. These checks prove current address membership
 only: they cannot tell an earlier incarnation from another object registered
 later at the same address.
+
+Generic Netlink family
+======================
+
+DRM Fabric is exposed through the ``drm-fabric`` Generic Netlink family.
+Dump enumeration and asynchronous notifications fit this multi-object model
+better than one-value-per-file sysfs. The family follows the YAML/ynl
+discipline used by DRM RAS; devlink's device hierarchy does not represent a
+fabric spanning multiple DRM devices.
+
+YAML specification
+------------------
+
+The interface is described in a YAML specification
+``Documentation/netlink/specs/drm_fabric.yaml``, which is the source of truth for
+the wire format. It auto-generates the uAPI header
+(``include/uapi/drm/drm_fabric.h``) and the kernel glue via
+``tools/net/ynl/pyynl/ynl_gen_c.py``. Generated files must never be edited by
+hand; regenerate them with ``tools/net/ynl/ynl-regen.sh`` after any spec change.
+
+uAPI stability
+--------------
+
+The YAML specification is the contract. New attributes, commands and enum values
+are added append-only; existing attribute numbers, command numbers and meanings
+are never reused. Requests are strictly validated, so an unknown attribute in a
+request is rejected; user space should ignore attributes it does not recognize
+in replies and notifications. The family is versioned through
+``DRM_FABRIC_FAMILY_VERSION``.
+
+Kernel-local ``fabric-id`` and ``endpoint-id`` values identify live registry
+objects and are not persistent hardware identities: they remain valid for the
+lifetime of the registered object, but may disappear or be reused after the
+object is unregistered. ``instance-id`` and ``fabric-ep-id`` carry
+provider-defined identity, whose scope is described by the containing object.
diff --git a/Documentation/netlink/specs/drm_fabric.yaml b/Documentation/netlink/specs/drm_fabric.yaml
new file mode 100644
index 000000000000..778443d92a0d
--- /dev/null
+++ b/Documentation/netlink/specs/drm_fabric.yaml
@@ -0,0 +1,427 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: drm-fabric
+protocol: genetlink
+uapi-header: drm/drm_fabric.h
+
+doc: |
+  Common object model for GPU and accelerator interconnect topology
+  (xGMI, UALink and similar), exposed over Generic Netlink.
+
+  A @fabric groups @endpoint objects; each @endpoint owns a fixed set of
+  @port objects; and a @port may carry a @peer naming the directly adjacent
+  far end. The core records direct adjacency only, and a @peer need not
+  resolve locally.
+
+  This read-only interface is confined to the initial network namespace.
+  Providers own topology; userspace queries it and receives notifications.
+  Replies and notifications carry a topology-generation token so an
+  interrupted or changed dump can be discarded and retried.
+
+definitions:
+  -
+    name: type
+    type: enum
+    value-start: 1
+    doc: >-
+      Fabric interconnect technology. New types are added with the provider
+      that first reports them. Zero is not a valid type.
+    entries:
+      - synthetic
+
+  -
+    name: port-state
+    type: enum
+    doc: Operational (link) state of a port, as observed by the driver.
+    entries:
+      - unknown
+      - inactive
+      - active
+      - degraded
+
+  -
+    name: peer-type
+    type: enum
+    value-start: 1
+    doc: Kind of device directly adjacent at a port's far end.
+    entries: [accel, switch]
+
+attribute-sets:
+  -
+    name: drm-fabric
+    enum-name: drm-fabric-a
+    doc: Top-level attributes, shared by all drm-fabric operations.
+    attributes:
+      -
+        name: fabric
+        type: nest
+        nested-attributes: fabric
+        doc: A fabric object (full nest).
+      -
+        name: endpoint
+        type: nest
+        nested-attributes: endpoint
+        doc: An endpoint object (full nest).
+      -
+        name: port
+        type: nest
+        nested-attributes: port
+        doc: A port object (full nest).
+      -
+        name: port-stats
+        type: nest
+        nested-attributes: port-stats
+        doc: Per-port statistics (full nest).
+      -
+        name: fabric-id
+        type: u32
+        doc: Kernel-local fabric identifier, assigned by the core.
+      -
+        name: endpoint-id
+        type: u32
+        doc: Kernel-local endpoint identifier, assigned by the core.
+      -
+        name: port-index
+        type: u32
+        doc: Per-endpoint port index.
+      -
+        name: dev-name
+        type: string
+        doc: Bus-specific identity (e.g. PCI BDF 0000:c1:00.0).
+      -
+        name: bus-name
+        type: string
+        doc: Disambiguate dev-name by bus (e.g. pci).
+      -
+        name: peer
+        type: nest
+        nested-attributes: peer
+        doc: A port's neighbor description (full nest).
+      -
+        name: topology-generation
+        type: u32
+        doc: >-
+          Family-global topology change token, not an event counter. Nonzero,
+          advances on every committed topology-visible transition and may wrap,
+          but zero is never emitted. Compare for equality only; treat any
+          change, or NLM_F_DUMP_INTR on a dump, as a reason to re-dump. A GET
+          or DUMP reply carries its snapshot's generation; a notification
+          carries the generation of its change. Statistics reads do not
+          advance it.
+
+  -
+    name: fabric
+    name-prefix: drm-fabric-a-fabric-attrs-
+    enum-name: drm-fabric-a-fabric-attrs
+    doc: Attributes describing a fabric object.
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: fabric-id
+        type: u32
+        doc: Kernel-local fabric identifier, assigned by the core.
+      -
+        name: type
+        type: u32
+        enum: type
+        doc: Fabric interconnect technology, see enum type.
+      -
+        name: name
+        type: string
+        doc: Human-readable fabric name.
+      -
+        name: instance-id
+        type: u64
+        doc: Vendor-unique fabric instance identifier (e.g. a hive ID).
+
+  -
+    name: endpoint
+    name-prefix: drm-fabric-a-endpoint-attrs-
+    enum-name: drm-fabric-a-endpoint-attrs
+    doc: Attributes describing an endpoint object.
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: endpoint-id
+        type: u32
+        doc: Kernel-local endpoint identifier, assigned by the core.
+      -
+        name: fabric-id
+        type: u32
+        doc: Identifier of the parent fabric.
+      -
+        name: fabric-ep-id
+        type: u64
+        doc: Vendor's stable fabric-local endpoint identifier.
+      -
+        name: name
+        type: string
+        doc: Human-readable endpoint name.
+      -
+        name: dev-name
+        type: string
+        doc: Bus-specific identity (e.g. PCI BDF 0000:c1:00.0).
+      -
+        name: bus-name
+        type: string
+        doc: The bus of the backing device (e.g. pci).
+
+  -
+    name: port
+    name-prefix: drm-fabric-a-port-attrs-
+    enum-name: drm-fabric-a-port-attrs
+    doc: Attributes describing a port object.
+    attributes:
+      -
+        name: port-index
+        type: u32
+        doc: Per-endpoint port index.
+      -
+        name: endpoint-id
+        type: u32
+        doc: Identifier of the endpoint that owns this port.
+      -
+        name: oper-state
+        type: u32
+        enum: port-state
+        doc: Port's operational state.
+
+      -
+        name: max-lane-count
+        type: u32
+        doc: >-
+          Maximum provider-reported lane count (link width capability).
+          0 means unknown or not reported.
+      -
+        name: max-lane-signaling-rate-mbps
+        type: u32
+        doc: >-
+          Maximum provider-reported per-lane signaling rate in decimal
+          megabits per second, before encoding, FEC and protocol overhead.
+          Zero means unknown. This is a capability, not the negotiated rate
+          or usable payload bandwidth.
+      -
+        name: peer
+        type: nest
+        nested-attributes: peer
+        doc: Peer info, absent if the port has no neighbor set.
+
+  -
+    name: peer
+    name-prefix: drm-fabric-a-peer-attrs-
+    enum-name: drm-fabric-a-peer-attrs
+    doc: Attributes describing a port's neighbor (peer).
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: peer-id
+        type: u64
+        doc: >-
+          Type-qualified identity of the directly adjacent far-end object.
+          For type=accel, this is the far-end accelerator's fabric-ep-id; for
+          type=switch, it is an opaque provider-defined identity naming no
+          local endpoint. Accelerator and switch identities occupy separate
+          namespaces, and neither must resolve locally.
+      -
+        name: type
+        type: u32
+        enum: peer-type
+        doc: Kind of peer device; selects the namespace and meaning of peer-id.
+      -
+        name: port-index
+        type: u32
+        doc: Far-end port index, in the peer's own port numbering.
+
+  -
+    name: port-stats
+    name-prefix: drm-fabric-a-port-stats-attrs-
+    enum-name: drm-fabric-a-port-stats-attrs
+    doc: |-
+      Per-port statistics. All-or-none: on success every base counter is
+      present and zero is a valid count. A provider unable to supply the
+      complete base set returns -EOPNOTSUPP.
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: endpoint-id
+        type: u32
+        doc: Identifier of the endpoint that owns the port.
+      -
+        name: port-index
+        type: u32
+        doc: Per-endpoint port index.
+      -
+        name: read-bytes
+        type: u64
+        doc: Bytes received on the port.
+      -
+        name: write-bytes
+        type: u64
+        doc: Bytes transmitted on the port.
+      -
+        name: link-down-count
+        type: u64
+        doc: Number of link-down transitions.
+      -
+        name: retrain-count
+        type: u64
+        doc: Number of link retrain events.
+
+operations:
+  enum-name: drm-fabric-cmd
+  list:
+    -
+      name: fabric-get
+      doc: Enumerate registered fabrics
+      attribute-set: drm-fabric
+      do:
+        request:
+          attributes:
+            - fabric-id
+        reply:
+          attributes:
+            - fabric
+            - topology-generation
+      dump:
+        reply:
+          attributes:
+            - fabric
+            - topology-generation
+
+    -
+      name: endpoint-get
+      doc: Enumerate registered endpoints, optionally filtered by fabric-id
+      attribute-set: drm-fabric
+      do:
+        request:
+          attributes:
+            - endpoint-id
+            - dev-name
+            - bus-name
+        reply:
+          attributes:
+            - endpoint
+            - topology-generation
+      dump:
+        request:
+          attributes:
+            - fabric-id
+        reply:
+          attributes:
+            - endpoint
+            - topology-generation
+
+    -
+      name: port-get
+      doc: Enumerate ports, optionally filtered by endpoint-id
+      attribute-set: drm-fabric
+      do:
+        request:
+          attributes:
+            - endpoint-id
+            - port-index
+        reply:
+          attributes:
+            - port
+            - topology-generation
+      dump:
+        request:
+          attributes:
+            - endpoint-id
+        reply:
+          attributes:
+            - port
+            - topology-generation
+
+    -
+      name: port-stats-get
+      doc: Query port-scoped statistics
+      attribute-set: drm-fabric
+      do:
+        request:
+          attributes:
+            - endpoint-id
+            - port-index
+        reply:
+          attributes:
+            - port-stats
+      dump:
+        request:
+          attributes:
+            - endpoint-id
+        reply:
+          attributes:
+            - port-stats
+
+    -
+      name: port-change-ntf
+      doc: |
+        Port state change notification. Reuses the port-get
+        reply shape (full port nest).
+      notify: port-get
+
+    -
+      name: port-peer-create-ntf
+      doc: A port's neighbor has been set.
+      attribute-set: drm-fabric
+      event:
+        attributes:
+          - endpoint-id
+          - port-index
+          - peer
+          - topology-generation
+
+    -
+      name: port-peer-delete-ntf
+      doc: A port's neighbor has been unset.
+      attribute-set: drm-fabric
+      event:
+        attributes:
+          - endpoint-id
+          - port-index
+          - peer
+          - topology-generation
+
+    -
+      name: endpoint-create-ntf
+      doc: |
+        Endpoint registration notification, fired after the endpoint is
+        committed to the registry. Reuses the endpoint-get reply shape
+        (full endpoint nest).
+      notify: endpoint-get
+
+    -
+      name: endpoint-delete-ntf
+      doc: |
+        Endpoint unregistration notification, fired before the endpoint is
+        removed from the registry so its identity is still resolvable.
+        Reuses the endpoint-get reply shape (full endpoint nest).
+      notify: endpoint-get
+
+    -
+      name: fabric-create-ntf
+      doc: |
+        Fabric registration notification, fired after the fabric is committed
+        to the registry. Reuses the fabric-get reply shape (full fabric nest).
+      notify: fabric-get
+
+    -
+      name: fabric-delete-ntf
+      doc: |
+        Fabric removal notification, fired before the fabric is removed from
+        the registry so its identity is still resolvable. Reuses the fabric-get
+        reply shape (full fabric nest).
+      notify: fabric-get
+
+mcast-groups:
+  list:
+    -
+      name: monitor
diff --git a/drivers/gpu/drm/fabric/drm_fabric_nl.h b/drivers/gpu/drm/fabric/drm_fabric_nl.h
new file mode 100644
index 000000000000..8cedc004260f
--- /dev/null
+++ b/drivers/gpu/drm/fabric/drm_fabric_nl.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/drm_fabric.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_DRM_FABRIC_GEN_H
+#define _LINUX_DRM_FABRIC_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/drm/drm_fabric.h>
+
+int drm_fabric_nl_fabric_get_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_fabric_nl_fabric_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
+int drm_fabric_nl_endpoint_get_doit(struct sk_buff *skb,
+				    struct genl_info *info);
+int drm_fabric_nl_endpoint_get_dumpit(struct sk_buff *skb,
+				      struct netlink_callback *cb);
+int drm_fabric_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_fabric_nl_port_get_dumpit(struct sk_buff *skb,
+				  struct netlink_callback *cb);
+int drm_fabric_nl_port_stats_get_doit(struct sk_buff *skb,
+				      struct genl_info *info);
+int drm_fabric_nl_port_stats_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb);
+
+enum {
+	DRM_FABRIC_NLGRP_MONITOR,
+};
+
+extern struct genl_family drm_fabric_nl_family;
+
+#endif /* _LINUX_DRM_FABRIC_GEN_H */
diff --git a/include/drm/drm_fabric.h b/include/drm/drm_fabric.h
index 68d8acec2d38..136100b3da67 100644
--- a/include/drm/drm_fabric.h
+++ b/include/drm/drm_fabric.h
@@ -4,8 +4,8 @@
  */
 
 /*
- * DRM Fabric driver API: common object model for GPU interconnect topology
- * (fabric, endpoint, port and peer relationships).
+ * Common object model for GPU interconnect topology: fabric, endpoint, port
+ * and peer relationships.
  */
 
 #ifndef __DRM_FABRIC_H__
@@ -16,22 +16,7 @@
 #include <linux/types.h>
 #include <linux/xarray.h>
 
-enum drm_fabric_type {
-	/* Zero is invalid; concrete fabric types start at 1. */
-	DRM_FABRIC_TYPE_SYNTHETIC = 1,
-};
-
-enum drm_fabric_port_state {
-	DRM_FABRIC_PORT_STATE_UNKNOWN,
-	DRM_FABRIC_PORT_STATE_INACTIVE,
-	DRM_FABRIC_PORT_STATE_ACTIVE,
-	DRM_FABRIC_PORT_STATE_DEGRADED,
-};
-
-enum drm_fabric_peer_type {
-	DRM_FABRIC_PEER_TYPE_ACCEL = 1,
-	DRM_FABRIC_PEER_TYPE_SWITCH,
-};
+#include <uapi/drm/drm_fabric.h>
 
 struct device;
 
diff --git a/include/uapi/drm/drm_fabric.h b/include/uapi/drm/drm_fabric.h
new file mode 100644
index 000000000000..b6c7bd6e35f0
--- /dev/null
+++ b/include/uapi/drm/drm_fabric.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/drm_fabric.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_DRM_FABRIC_H
+#define _UAPI_LINUX_DRM_FABRIC_H
+
+#define DRM_FABRIC_FAMILY_NAME		"drm-fabric"
+#define DRM_FABRIC_FAMILY_VERSION	1
+
+/*
+ * Fabric interconnect technology. New types are added with the provider that
+ * first reports them. Zero is not a valid type.
+ */
+enum drm_fabric_type {
+	DRM_FABRIC_TYPE_SYNTHETIC = 1,
+};
+
+/*
+ * Operational (link) state of a port, as observed by the driver.
+ */
+enum drm_fabric_port_state {
+	DRM_FABRIC_PORT_STATE_UNKNOWN,
+	DRM_FABRIC_PORT_STATE_INACTIVE,
+	DRM_FABRIC_PORT_STATE_ACTIVE,
+	DRM_FABRIC_PORT_STATE_DEGRADED,
+};
+
+/*
+ * Kind of device directly adjacent at a port's far end.
+ */
+enum drm_fabric_peer_type {
+	DRM_FABRIC_PEER_TYPE_ACCEL = 1,
+	DRM_FABRIC_PEER_TYPE_SWITCH,
+};
+
+enum drm_fabric_a {
+	DRM_FABRIC_A_FABRIC = 1,
+	DRM_FABRIC_A_ENDPOINT,
+	DRM_FABRIC_A_PORT,
+	DRM_FABRIC_A_PORT_STATS,
+	DRM_FABRIC_A_FABRIC_ID,
+	DRM_FABRIC_A_ENDPOINT_ID,
+	DRM_FABRIC_A_PORT_INDEX,
+	DRM_FABRIC_A_DEV_NAME,
+	DRM_FABRIC_A_BUS_NAME,
+	DRM_FABRIC_A_PEER,
+	DRM_FABRIC_A_TOPOLOGY_GENERATION,
+
+	__DRM_FABRIC_A_MAX,
+	DRM_FABRIC_A_MAX = (__DRM_FABRIC_A_MAX - 1)
+};
+
+enum drm_fabric_a_fabric_attrs {
+	DRM_FABRIC_A_FABRIC_ATTRS_PAD = 1,
+	DRM_FABRIC_A_FABRIC_ATTRS_FABRIC_ID,
+	DRM_FABRIC_A_FABRIC_ATTRS_TYPE,
+	DRM_FABRIC_A_FABRIC_ATTRS_NAME,
+	DRM_FABRIC_A_FABRIC_ATTRS_INSTANCE_ID,
+
+	__DRM_FABRIC_A_FABRIC_ATTRS_MAX,
+	DRM_FABRIC_A_FABRIC_ATTRS_MAX = (__DRM_FABRIC_A_FABRIC_ATTRS_MAX - 1)
+};
+
+enum drm_fabric_a_endpoint_attrs {
+	DRM_FABRIC_A_ENDPOINT_ATTRS_PAD = 1,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_ENDPOINT_ID,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_FABRIC_ID,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_FABRIC_EP_ID,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_NAME,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_DEV_NAME,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_BUS_NAME,
+
+	__DRM_FABRIC_A_ENDPOINT_ATTRS_MAX,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_MAX = (__DRM_FABRIC_A_ENDPOINT_ATTRS_MAX - 1)
+};
+
+enum drm_fabric_a_port_attrs {
+	DRM_FABRIC_A_PORT_ATTRS_PORT_INDEX = 1,
+	DRM_FABRIC_A_PORT_ATTRS_ENDPOINT_ID,
+	DRM_FABRIC_A_PORT_ATTRS_OPER_STATE,
+	DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_COUNT,
+	DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_SIGNALING_RATE_MBPS,
+	DRM_FABRIC_A_PORT_ATTRS_PEER,
+
+	__DRM_FABRIC_A_PORT_ATTRS_MAX,
+	DRM_FABRIC_A_PORT_ATTRS_MAX = (__DRM_FABRIC_A_PORT_ATTRS_MAX - 1)
+};
+
+enum drm_fabric_a_peer_attrs {
+	DRM_FABRIC_A_PEER_ATTRS_PAD = 1,
+	DRM_FABRIC_A_PEER_ATTRS_PEER_ID,
+	DRM_FABRIC_A_PEER_ATTRS_TYPE,
+	DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX,
+
+	__DRM_FABRIC_A_PEER_ATTRS_MAX,
+	DRM_FABRIC_A_PEER_ATTRS_MAX = (__DRM_FABRIC_A_PEER_ATTRS_MAX - 1)
+};
+
+enum drm_fabric_a_port_stats_attrs {
+	DRM_FABRIC_A_PORT_STATS_ATTRS_PAD = 1,
+	DRM_FABRIC_A_PORT_STATS_ATTRS_ENDPOINT_ID,
+	DRM_FABRIC_A_PORT_STATS_ATTRS_PORT_INDEX,
+	DRM_FABRIC_A_PORT_STATS_ATTRS_READ_BYTES,
+	DRM_FABRIC_A_PORT_STATS_ATTRS_WRITE_BYTES,
+	DRM_FABRIC_A_PORT_STATS_ATTRS_LINK_DOWN_COUNT,
+	DRM_FABRIC_A_PORT_STATS_ATTRS_RETRAIN_COUNT,
+
+	__DRM_FABRIC_A_PORT_STATS_ATTRS_MAX,
+	DRM_FABRIC_A_PORT_STATS_ATTRS_MAX = (__DRM_FABRIC_A_PORT_STATS_ATTRS_MAX - 1)
+};
+
+enum drm_fabric_cmd {
+	DRM_FABRIC_CMD_FABRIC_GET = 1,
+	DRM_FABRIC_CMD_ENDPOINT_GET,
+	DRM_FABRIC_CMD_PORT_GET,
+	DRM_FABRIC_CMD_PORT_STATS_GET,
+	DRM_FABRIC_CMD_PORT_CHANGE_NTF,
+	DRM_FABRIC_CMD_PORT_PEER_CREATE_NTF,
+	DRM_FABRIC_CMD_PORT_PEER_DELETE_NTF,
+	DRM_FABRIC_CMD_ENDPOINT_CREATE_NTF,
+	DRM_FABRIC_CMD_ENDPOINT_DELETE_NTF,
+	DRM_FABRIC_CMD_FABRIC_CREATE_NTF,
+	DRM_FABRIC_CMD_FABRIC_DELETE_NTF,
+
+	__DRM_FABRIC_CMD_MAX,
+	DRM_FABRIC_CMD_MAX = (__DRM_FABRIC_CMD_MAX - 1)
+};
+
+#define DRM_FABRIC_MCGRP_MONITOR	"monitor"
+
+#endif /* _UAPI_LINUX_DRM_FABRIC_H */
-- 
2.43.0

