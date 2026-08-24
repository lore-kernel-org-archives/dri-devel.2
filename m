Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4695C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C42C10E67C;
	Mon, 24 Aug 2026 08:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PxJXSKGN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D907310E67C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:09:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 903A8403B6;
 Mon, 24 Aug 2026 08:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F2C1F000E9;
 Mon, 24 Aug 2026 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787558995;
 bh=sgmEngV/0H+9YupU+dhU4GBRRc74iuVjelLbyKxaUn0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PxJXSKGNg4ASJ4Ug8nADtqQpoFyeTVP+Dp8wPRHVw7NLsC7GkpxIYSA/Q+EUYBA2F
 7ZsdcRV5Hvkn36KpLUhTPwvtEQFyQwIJ84wRI8iA+dBh24Z7wRuoNB+JkJvXHTmop+
 A/gaFJS5pWtpuIusNGSC388tRbdDaCw9Ia5sJqUhdjzbECrO8J8FYKD8Hk2OnTfwMr
 QjWhxlSJ/wXEyo9vXtME7hn55aCS6C4B9XMjsXII6ZDZyUM6HOOqSb2CYK+1OncQsk
 c1OJ31fgLzqH8FKqVOsS/sQSoInOBbt2/aG8a851Rq2sx2xcwgOLiOYWrWcSAHbM/c
 +X68+GDx0h3/A==
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
Subject: [RFC PATCH 03/12] drm/fabric: implement query netlink operations
Date: Mon, 24 Aug 2026 11:09:31 +0300
Message-ID: <fea1fb8ce49d7b673a0ccd9e950cdc0fc0565c68.1787552412.git.ksinyuk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Register the drm-fabric Generic Netlink family and connect the four
read-only query commands to the core object model, adding the generated
operation and policy source that dispatches to them. Their reply shapes
are:

  fabric-get       -> fabric, topology-generation
  endpoint-get     -> endpoint, topology-generation
  port-get         -> port, topology-generation
  port-stats-get   -> port-stats

Support single-object lookup and multipart dumps for fabrics, endpoints and
ports, with optional fabric and endpoint filters. Preserve the nested
endpoint/port dump cursor across batches, including endpoint removal and
terminal port indices.

Port statistics are optional: a targeted unsupported request returns
-EOPNOTSUPP, while a dump skips unsupported ports and continues; other
provider errors terminate the dump. Use topology-generation for dump
consistency and report concurrent changes with NLM_F_DUMP_INTR.

Emit fabric, endpoint, port-state and peer notifications through the
monitor multicast group. Advance topology-generation before emitting each
notification, so the event carries the same post-change value as a later
query.

Queries and notifications are confined to init_net. The query commands,
notifications and dump-consistency behavior are documented in
Documentation/gpu/drm-fabric.rst.

Co-developed-by: Ilia Levi <ilia.levi@intel.com>
Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst             |  148 ++-
 drivers/gpu/drm/fabric/Kconfig               |    6 +-
 drivers/gpu/drm/fabric/Makefile              |    2 +-
 drivers/gpu/drm/fabric/drm_fabric.c          |   29 +-
 drivers/gpu/drm/fabric/drm_fabric_internal.h |   19 +
 drivers/gpu/drm/fabric/drm_fabric_netlink.c  | 1035 ++++++++++++++++++
 drivers/gpu/drm/fabric/drm_fabric_nl.c       |  125 +++
 7 files changed, 1345 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_netlink.c
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_nl.c

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
index d2c9e694b67f..a8b33d6cd618 100644
--- a/Documentation/gpu/drm-fabric.rst
+++ b/Documentation/gpu/drm-fabric.rst
@@ -18,8 +18,8 @@ Key Goals:
   (xGMI, UALink and similar), enabling data-center discovery and monitoring.
 * Support read-only enumeration, monitoring and state queries for
   provider-owned topology.
-* Offer a flexible, future-proof interface that can be extended with new fabric
-  types and attributes without breaking the uAPI.
+* Allow new attributes and fabric types to be added without reusing existing
+  wire identifiers, so the uAPI extends without breaking existing consumers.
 * Allow multiple endpoints and ports per provider, so drivers can model
   accelerator attachments, links and their peers.
 
@@ -84,10 +84,14 @@ an accelerator on another node, or a local endpoint that merely unregistered
 -- so only the provider knows when a port's physical adjacency actually
 changed, and only the provider retracts or replaces the descriptor.
 
-Endpoint teardown removes the endpoint's owned half-edges without generating
-a separate event for each port: the delete already describes the transition,
-so removing an endpoint advances the topology generation once rather than
-once per child port.
+``port-peer-delete-ntf`` reports an explicitly retracted half-edge; it is
+not emitted when a peer merely becomes locally unresolvable, so its absence
+is not evidence the far end is still reachable.
+
+Endpoint teardown removes the endpoint's owned half-edges without
+generating a separate event for each port: the delete already describes
+the transition, so removing an endpoint advances the topology generation
+once rather than once per child port.
 
 Driver API
 ----------
@@ -175,3 +179,135 @@ objects and are not persistent hardware identities: they remain valid for the
 lifetime of the registered object, but may disappear or be reused after the
 object is unregistered. ``instance-id`` and ``fabric-ep-id`` carry
 provider-defined identity, whose scope is described by the containing object.
+
+Query operations
+================
+
+User space enumerates topology with four read-only commands, each supporting a
+single lookup (``do``) and a bulk dump (``dump``):
+
+* ``fabric-get`` -- enumerate fabrics (``do`` by ``fabric-id``, ``dump`` for all).
+* ``endpoint-get`` -- enumerate endpoints, optionally filtered by ``fabric-id``,
+  or resolve one by ``endpoint-id`` or backing ``dev-name``/``bus-name``.
+* ``port-get`` -- enumerate ports, filtered by ``endpoint-id``. Ports may report
+  the provider's maximum capability as ``max-lane-count`` and
+  ``max-lane-signaling-rate-mbps`` (zero means unknown); these are maxima, not
+  the currently negotiated width or rate.
+* ``port-stats-get`` -- per-port statistics, filtered by ``endpoint-id``. A
+  targeted request for a port whose provider does not implement
+  ``port_stats_get`` returns ``-EOPNOTSUPP``. During a dump, ports without
+  statistics support are omitted and enumeration continues with later ports;
+  any other provider error ends the dump.
+
+Notifications
+-------------
+
+Subscribe to the ``monitor`` multicast group to receive asynchronous change
+notifications. Full-object notifications reuse the shape of their matching
+``get`` reply and are declared with ``notify:``; peer-link notifications carry
+a partial payload and are declared with ``event:``.
+
+.. list-table::
+   :header-rows: 1
+
+   * - Notification
+     - Trigger
+     - Payload
+   * - ``fabric-create-ntf``
+     - a fabric is registered by a provider
+     - reuses ``fabric-get``
+   * - ``fabric-delete-ntf``
+     - a provider-owned fabric is unregistered
+     - reuses ``fabric-get``
+   * - ``endpoint-create-ntf``
+     - an endpoint is registered
+     - reuses ``endpoint-get``
+   * - ``endpoint-delete-ntf``
+     - an endpoint is unregistered
+     - reuses ``endpoint-get``
+   * - ``port-change-ntf``
+     - a port's operational state changes
+     - reuses ``port-get``
+   * - ``port-peer-create-ntf``
+     - a port's peer descriptor is set by its provider
+     - partial (``event:``)
+   * - ``port-peer-delete-ntf``
+     - a port's peer descriptor is explicitly unset by its provider; never
+       emitted for an implicit half-edge loss (see `Peer semantics`_)
+     - partial (``event:``)
+
+Notifications are best-effort. A listener that detects loss, restarts, or
+receives an interrupted dump must rebuild state with the query commands.
+
+Topology generation and dump consistency
+----------------------------------------
+
+The core keeps a nonzero generation counter and advances it whenever topology or
+exposed state changes. It is surfaced as the ``topology-generation`` attribute on
+``fabric-get``, ``endpoint-get`` and ``port-get`` replies and on the topology
+notifications. A provider-reported change advances the generation before its
+notification is serialized, so an event carries the post-change value that a
+later ``get``/``dump`` will also report.
+
+``topology-generation`` is a change token, not a timestamp, liveness counter or
+event count: a changed value means topology changed, but the delta between two
+values has no defined meaning and the counter may wrap (it skips zero). Statistics
+reads do not advance it.
+
+The same value backs dump consistency. Every multipart dump samples it and calls
+``genl_dump_check_consistent()``; if it changes between dump batches, Generic
+Netlink marks the dump with ``NLM_F_DUMP_INTR``, meaning the snapshot may be torn.
+User space must then discard the partial result and retry the complete dump. The
+generation does not apply to statistics reads.
+
+Only a dump that serialized at least one entry can carry ``NLM_F_DUMP_INTR``,
+because Generic Netlink arms the consistency check on the first entry it emits.
+A dump that yields no entries at all cannot report interruption, so user space
+should treat an empty result as advisory and re-read ``topology-generation``
+before concluding that the topology is empty.
+
+Namespaces
+----------
+
+DRM Fabric objects describe host-global hardware and are not scoped per network
+namespace. Query and dump operations (``*-get``) are therefore accepted only from
+the initial network namespace; a request from any other network namespace fails
+with ``-EPERM``. The Generic Netlink family is registered ``netnsok`` (so it
+resolves in any network namespace and can return that policy error rather than
+being invisible), but the operations themselves remain confined to ``init_net``.
+Monitor notifications are likewise emitted only into ``init_net``, so a listener
+that joins the multicast group from another network namespace never receives
+them.
+
+Examples
+========
+
+Query the topology with the in-tree YNL tool, pointing it at the spec:
+
+.. code-block:: bash
+
+    # List all fabrics
+    ./tools/net/ynl/pyynl/cli.py \
+        --spec Documentation/netlink/specs/drm_fabric.yaml \
+        --dump fabric-get
+
+Replies follow the shapes described above; a provider must be registered for
+the topology to be non-empty.
+
+List the endpoints of a fabric:
+
+.. code-block:: bash
+
+    ./tools/net/ynl/pyynl/cli.py \
+        --spec Documentation/netlink/specs/drm_fabric.yaml \
+        --dump endpoint-get --json '{"fabric-id": 1}'
+
+Query a single port:
+
+.. code-block:: bash
+
+    ./tools/net/ynl/pyynl/cli.py \
+        --spec Documentation/netlink/specs/drm_fabric.yaml \
+        --do port-get --json '{"endpoint-id": 1, "port-index": 0}'
+
+The family name on the wire is ``drm-fabric``.
diff --git a/drivers/gpu/drm/fabric/Kconfig b/drivers/gpu/drm/fabric/Kconfig
index 21fbfae9863d..7e9c569fd258 100644
--- a/drivers/gpu/drm/fabric/Kconfig
+++ b/drivers/gpu/drm/fabric/Kconfig
@@ -4,9 +4,9 @@ config DRM_FABRIC
 	tristate "DRM fabric support"
 	depends on DRM && NET
 	help
-	  Enable DRM fabric support. This infrastructure provides the
-	  core object model and provider API for registered accelerator
-	  interconnect topologies.
+	  Enable DRM fabric support. This infrastructure exposes
+	  registered accelerator interconnect topologies to userspace
+	  through the drm-fabric generic netlink family.
 
 	  To compile this as a module, choose M here: the module will be
 	  called drm-fabric.
diff --git a/drivers/gpu/drm/fabric/Makefile b/drivers/gpu/drm/fabric/Makefile
index 3a76f31f1e83..cf9d9d6be3d3 100644
--- a/drivers/gpu/drm/fabric/Makefile
+++ b/drivers/gpu/drm/fabric/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DRM_FABRIC) += drm-fabric.o
-drm-fabric-y := drm_fabric.o
+drm-fabric-y := drm_fabric.o drm_fabric_netlink.o drm_fabric_nl.o
diff --git a/drivers/gpu/drm/fabric/drm_fabric.c b/drivers/gpu/drm/fabric/drm_fabric.c
index 8769d7bdcde1..ce331656af70 100644
--- a/drivers/gpu/drm/fabric/drm_fabric.c
+++ b/drivers/gpu/drm/fabric/drm_fabric.c
@@ -186,7 +186,7 @@ struct drm_fabric *drm_fabric_register(const struct drm_fabric_desc *desc)
 			       xa_limit_32b, GFP_KERNEL);
 		if (ret)
 			return ERR_PTR(ret);
-		drm_fabric_base_seq_inc();
+		drm_fabric_emit_fabric_create(fabric, drm_fabric_base_seq_inc());
 	}
 
 	return_ptr(fabric);
@@ -270,7 +270,9 @@ int drm_fabric_unregister(struct drm_fabric *fabric)
 		 */
 		if (WARN_ON_ONCE(drm_fabric_has_members(fabric)))
 			return -EBUSY;
-		drm_fabric_base_seq_inc();
+		/* Emit before the erase, while @fabric is still live. */
+		drm_fabric_emit_fabric_delete(fabric,
+					      drm_fabric_base_seq_inc());
 		xa_erase(&drm_fabric_xa, fabric->id);
 	}
 
@@ -410,7 +412,7 @@ drm_fabric_endpoint_register(struct drm_fabric *fabric,
 			break;
 		drm_fabric_get(fabric);
 
-		drm_fabric_base_seq_inc();
+		drm_fabric_emit_endpoint_create(ep, drm_fabric_base_seq_inc());
 	}
 
 	if (ret) {
@@ -499,7 +501,8 @@ void drm_fabric_endpoint_unregister(struct drm_fabric_endpoint *ep)
 	scoped_guard(mutex, &drm_fabric_lock) {
 		if (WARN_ON_ONCE(!drm_fabric_ep_is_registered(ep)))
 			return;
-		drm_fabric_base_seq_inc();
+		/* Emit before the erase, while @ep is still live. */
+		drm_fabric_emit_endpoint_delete(ep, drm_fabric_base_seq_inc());
 		xa_erase(&drm_fabric_ep_xa, ep->id);
 	}
 
@@ -587,7 +590,8 @@ int drm_fabric_port_set_peer(struct drm_fabric_port *port,
 			return -EEXIST;
 		port->peer = *peer;
 		port->has_peer = true;
-		drm_fabric_base_seq_inc();
+		drm_fabric_emit_port_peer_create(port, peer,
+						 drm_fabric_base_seq_inc());
 	}
 
 	return 0;
@@ -612,7 +616,9 @@ int drm_fabric_port_unset_peer(struct drm_fabric_port *port)
 	scoped_guard(mutex, &drm_fabric_lock) {
 		if (!port->has_peer)
 			return -ENOENT;
-		drm_fabric_base_seq_inc();
+		/* Emit before clearing to show the peer being removed. */
+		drm_fabric_emit_port_peer_delete(port, &port->peer,
+						 drm_fabric_base_seq_inc());
 		port->has_peer = false;
 		memset(&port->peer, 0, sizeof(port->peer));
 	}
@@ -654,19 +660,24 @@ void drm_fabric_port_set_oper(struct drm_fabric_port *port,
 		enum drm_fabric_port_state old = port->oper_state;
 
 		port->oper_state = state;
-		if (old != state)
-			drm_fabric_base_seq_inc();
+		if (old != state) {
+			u32 gen = drm_fabric_base_seq_inc();
+
+			drm_fabric_emit_port_change(port, gen);
+		}
 	}
 }
 EXPORT_SYMBOL(drm_fabric_port_set_oper);
 
 static int __init drm_fabric_init(void)
 {
-	return 0;
+	return drm_fabric_netlink_register();
 }
 
 static void __exit drm_fabric_exit(void)
 {
+	drm_fabric_netlink_unregister();
+
 	WARN_ON(!xa_empty(&drm_fabric_xa));
 	WARN_ON(!xa_empty(&drm_fabric_ep_xa));
 	xa_destroy(&drm_fabric_xa);
diff --git a/drivers/gpu/drm/fabric/drm_fabric_internal.h b/drivers/gpu/drm/fabric/drm_fabric_internal.h
index d454225a0b81..7fc5bc3f33f9 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_internal.h
+++ b/drivers/gpu/drm/fabric/drm_fabric_internal.h
@@ -18,6 +18,9 @@ extern struct xarray drm_fabric_ep_xa; /* Endpoint registry */
 
 extern u32 drm_fabric_base_seq;        /* Dump consistency sequence */
 
+int drm_fabric_netlink_register(void);
+void drm_fabric_netlink_unregister(void);
+
 struct drm_fabric *drm_fabric_find_by_id(u32 id);
 struct drm_fabric_endpoint *drm_fabric_endpoint_find_by_id(u32 id);
 struct drm_fabric_endpoint *
@@ -31,4 +34,20 @@ void drm_fabric_endpoint_put(struct drm_fabric_endpoint *ep);
 struct drm_fabric *drm_fabric_get(struct drm_fabric *fabric);
 void drm_fabric_put(struct drm_fabric *fabric);
 
+/* Emits use the post-change generation. */
+void drm_fabric_emit_endpoint_create(struct drm_fabric_endpoint *ep, u32 generation);
+void drm_fabric_emit_endpoint_delete(struct drm_fabric_endpoint *ep, u32 generation);
+
+void drm_fabric_emit_port_peer_create(struct drm_fabric_port *port,
+				      const struct drm_fabric_peer *peer,
+				      u32 generation);
+void drm_fabric_emit_port_peer_delete(struct drm_fabric_port *port,
+				      const struct drm_fabric_peer *peer,
+				      u32 generation);
+
+void drm_fabric_emit_port_change(struct drm_fabric_port *port, u32 generation);
+
+void drm_fabric_emit_fabric_create(struct drm_fabric *fabric, u32 generation);
+void drm_fabric_emit_fabric_delete(struct drm_fabric *fabric, u32 generation);
+
 #endif /* __DRM_FABRIC_INTERNAL_H__ */
diff --git a/drivers/gpu/drm/fabric/drm_fabric_netlink.c b/drivers/gpu/drm/fabric/drm_fabric_netlink.c
new file mode 100644
index 000000000000..fef2d4c8f5bb
--- /dev/null
+++ b/drivers/gpu/drm/fabric/drm_fabric_netlink.c
@@ -0,0 +1,1035 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <net/genetlink.h>
+#include <net/net_namespace.h>
+
+#include <drm/drm_fabric.h>
+#include <uapi/drm/drm_fabric.h>
+
+#include "drm_fabric_internal.h"
+#include "drm_fabric_nl.h"
+
+struct drm_fabric_dump_ctx {
+	unsigned long idx;
+};
+
+static struct drm_fabric_dump_ctx *
+drm_fabric_dump_context(struct netlink_callback *cb)
+{
+	return (struct drm_fabric_dump_ctx *)cb->ctx;
+}
+
+/* Resume cursor for the nested per-port dumps (PORT_GET, PORT_STATS_GET). */
+struct drm_fabric_port_dump_ctx {
+	unsigned long ep_idx;
+	unsigned long port_idx;
+};
+
+static struct drm_fabric_port_dump_ctx *
+drm_fabric_port_dump_context(struct netlink_callback *cb)
+{
+	return (struct drm_fabric_port_dump_ctx *)cb->ctx;
+}
+
+/* netnsok so a non-init_net caller gets -EPERM, not a missing family. */
+static int drm_fabric_nl_host_only(const struct net *net)
+{
+	return net_eq(net, &init_net) ? 0 : -EPERM;
+}
+
+static int drm_fabric_fill_fabric(struct sk_buff *skb,
+				  struct drm_fabric *fabric)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, DRM_FABRIC_A_FABRIC);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, DRM_FABRIC_A_FABRIC_ATTRS_FABRIC_ID, fabric->id) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_FABRIC_ATTRS_TYPE, fabric->type) ||
+	    nla_put_string(skb, DRM_FABRIC_A_FABRIC_ATTRS_NAME, fabric->name) ||
+	    nla_put_u64_64bit(skb, DRM_FABRIC_A_FABRIC_ATTRS_INSTANCE_ID,
+			      fabric->instance_id, DRM_FABRIC_A_FABRIC_ATTRS_PAD)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+}
+
+static int drm_fabric_fill_endpoint(struct sk_buff *skb,
+				    struct drm_fabric_endpoint *ep)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, DRM_FABRIC_A_ENDPOINT);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_ENDPOINT_ID, ep->id) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_FABRIC_ID,
+			drm_fabric_endpoint_fabric_id(ep)) ||
+	    nla_put_u64_64bit(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_FABRIC_EP_ID,
+			      ep->fabric_ep_id, DRM_FABRIC_A_ENDPOINT_ATTRS_PAD) ||
+	    nla_put_string(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_NAME, ep->name) ||
+	    nla_put_string(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_DEV_NAME,
+			   dev_name(ep->parent)) ||
+	    nla_put_string(skb, DRM_FABRIC_A_ENDPOINT_ATTRS_BUS_NAME,
+			   dev_bus_name(ep->parent))) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+}
+
+static int drm_fabric_fill_peer(struct sk_buff *skb,
+				struct drm_fabric_port *port)
+{
+	struct nlattr *nest;
+
+	if (!port->has_peer)
+		return 0;
+
+	nest = nla_nest_start(skb, DRM_FABRIC_A_PORT_ATTRS_PEER);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u64_64bit(skb, DRM_FABRIC_A_PEER_ATTRS_PEER_ID,
+			      port->peer.peer_id, DRM_FABRIC_A_PEER_ATTRS_PAD) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PEER_ATTRS_TYPE,
+			port->peer.peer_type) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX,
+			port->peer.port_index)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+}
+
+static int drm_fabric_fill_port(struct sk_buff *skb,
+				struct drm_fabric_port *port)
+{
+	struct nlattr *nest;
+	int ret;
+
+	nest = nla_nest_start(skb, DRM_FABRIC_A_PORT);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_PORT_INDEX, port->index) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_ENDPOINT_ID, port->endpoint->id) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_OPER_STATE,
+			port->oper_state) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_COUNT,
+			port->max_lane_count) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_SIGNALING_RATE_MBPS,
+			port->max_lane_signaling_rate_mbps)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	ret = drm_fabric_fill_peer(skb, port);
+	if (ret) {
+		nla_nest_cancel(skb, nest);
+		return ret;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+}
+
+static int drm_fabric_fill_port_stats(struct sk_buff *skb,
+				      struct drm_fabric_port *port,
+				      struct drm_fabric_port_stats *stats)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, DRM_FABRIC_A_PORT_STATS);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, DRM_FABRIC_A_PORT_STATS_ATTRS_ENDPOINT_ID,
+			port->endpoint->id) ||
+	    nla_put_u32(skb, DRM_FABRIC_A_PORT_STATS_ATTRS_PORT_INDEX, port->index) ||
+	    nla_put_u64_64bit(skb, DRM_FABRIC_A_PORT_STATS_ATTRS_READ_BYTES,
+			      stats->read_bytes, DRM_FABRIC_A_PORT_STATS_ATTRS_PAD) ||
+	    nla_put_u64_64bit(skb, DRM_FABRIC_A_PORT_STATS_ATTRS_WRITE_BYTES,
+			      stats->write_bytes, DRM_FABRIC_A_PORT_STATS_ATTRS_PAD) ||
+	    nla_put_u64_64bit(skb, DRM_FABRIC_A_PORT_STATS_ATTRS_LINK_DOWN_COUNT,
+			      stats->link_down_count, DRM_FABRIC_A_PORT_STATS_ATTRS_PAD) ||
+	    nla_put_u64_64bit(skb, DRM_FABRIC_A_PORT_STATS_ATTRS_RETRAIN_COUNT,
+			      stats->retrain_count, DRM_FABRIC_A_PORT_STATS_ATTRS_PAD)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+}
+
+int drm_fabric_nl_fabric_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct drm_fabric *fabric;
+	struct sk_buff *msg;
+	u32 fabric_id;
+	void *hdr;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_FABRIC_ID))
+		return -EINVAL;
+
+	fabric_id = nla_get_u32(info->attrs[DRM_FABRIC_A_FABRIC_ID]);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			  &drm_fabric_nl_family, 0,
+			  DRM_FABRIC_CMD_FABRIC_GET);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		fabric = drm_fabric_find_by_id(fabric_id);
+		if (!fabric) {
+			nlmsg_free(msg);
+			return -ENOENT;
+		}
+
+		ret = drm_fabric_fill_fabric(msg, fabric);
+		if (ret) {
+			nlmsg_free(msg);
+			return ret;
+		}
+
+		if (nla_put_u32(msg, DRM_FABRIC_A_TOPOLOGY_GENERATION,
+				drm_fabric_base_seq)) {
+			nlmsg_free(msg);
+			return -EMSGSIZE;
+		}
+	}
+
+	genlmsg_end(msg, hdr);
+	return genlmsg_reply(msg, info);
+}
+
+int drm_fabric_nl_fabric_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb)
+{
+	struct drm_fabric_dump_ctx *ctx = drm_fabric_dump_context(cb);
+	struct drm_fabric *fabric;
+	unsigned long fidx;
+	void *hdr;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(genl_info_dump(cb)));
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		cb->seq = drm_fabric_base_seq;
+		xa_for_each_start(&drm_fabric_xa, fidx, fabric, ctx->idx) {
+			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq,
+					  &drm_fabric_nl_family, NLM_F_MULTI,
+					  DRM_FABRIC_CMD_FABRIC_GET);
+			if (!hdr) {
+				ret = -EMSGSIZE;
+				break;
+			}
+			genl_dump_check_consistent(cb, hdr);
+
+			if (nla_put_u32(skb, DRM_FABRIC_A_TOPOLOGY_GENERATION,
+					drm_fabric_base_seq)) {
+				genlmsg_cancel(skb, hdr);
+				ret = -EMSGSIZE;
+				break;
+			}
+
+			ret = drm_fabric_fill_fabric(skb, fabric);
+			if (ret) {
+				genlmsg_cancel(skb, hdr);
+				break;
+			}
+
+			genlmsg_end(skb, hdr);
+		}
+	}
+
+	if (ret == -EMSGSIZE) {
+		ctx->idx = fidx;
+		return skb->len;
+	}
+	return ret;
+}
+
+/* Identified by core-assigned id, or by bus + dev name. */
+static struct drm_fabric_endpoint *
+drm_fabric_resolve_endpoint(struct genl_info *info)
+{
+	struct nlattr **attrs = info->attrs;
+	const char *devname = NULL;
+	const char *busname = NULL;
+	struct drm_fabric_endpoint *ep;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	if (attrs[DRM_FABRIC_A_DEV_NAME])
+		devname = nla_data(attrs[DRM_FABRIC_A_DEV_NAME]);
+	if (attrs[DRM_FABRIC_A_BUS_NAME])
+		busname = nla_data(attrs[DRM_FABRIC_A_BUS_NAME]);
+
+	if (attrs[DRM_FABRIC_A_ENDPOINT_ID]) {
+		u32 ep_id = nla_get_u32(attrs[DRM_FABRIC_A_ENDPOINT_ID]);
+
+		ep = drm_fabric_endpoint_find_by_id(ep_id);
+		if (!ep)
+			return ERR_PTR(-ENOENT);
+
+		if (devname && strcmp(dev_name(ep->parent), devname))
+			return ERR_PTR(-EINVAL);
+		if (busname && strcmp(dev_bus_name(ep->parent), busname))
+			return ERR_PTR(-EINVAL);
+
+		return ep;
+	}
+
+	if (!devname)
+		return ERR_PTR(-EINVAL);
+
+	ep = drm_fabric_endpoint_find_by_dev_name(devname, busname);
+	if (IS_ERR(ep))
+		return ep;
+	if (!ep)
+		return ERR_PTR(-ENOENT);
+
+	return ep;
+}
+
+int drm_fabric_nl_endpoint_get_doit(struct sk_buff *skb,
+				    struct genl_info *info)
+{
+	struct drm_fabric_endpoint *ep;
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			  &drm_fabric_nl_family, 0,
+			  DRM_FABRIC_CMD_ENDPOINT_GET);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		ep = drm_fabric_resolve_endpoint(info);
+		if (IS_ERR(ep)) {
+			nlmsg_free(msg);
+			return PTR_ERR(ep);
+		}
+
+		ret = drm_fabric_fill_endpoint(msg, ep);
+		if (ret) {
+			nlmsg_free(msg);
+			return ret;
+		}
+
+		if (nla_put_u32(msg, DRM_FABRIC_A_TOPOLOGY_GENERATION,
+				drm_fabric_base_seq)) {
+			nlmsg_free(msg);
+			return -EMSGSIZE;
+		}
+	}
+
+	genlmsg_end(msg, hdr);
+	return genlmsg_reply(msg, info);
+}
+
+int drm_fabric_nl_endpoint_get_dumpit(struct sk_buff *skb,
+				      struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_fabric_dump_ctx *ctx = drm_fabric_dump_context(cb);
+	u32 filter_fabric_id = 0;
+	bool has_filter = false;
+	struct drm_fabric_endpoint *ep;
+	unsigned long eidx;
+	void *hdr;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	if (info->attrs[DRM_FABRIC_A_FABRIC_ID]) {
+		filter_fabric_id =
+			nla_get_u32(info->attrs[DRM_FABRIC_A_FABRIC_ID]);
+		has_filter = true;
+	}
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		cb->seq = drm_fabric_base_seq;
+		xa_for_each_start(&drm_fabric_ep_xa, eidx, ep, ctx->idx) {
+			if (has_filter &&
+			    drm_fabric_endpoint_fabric_id(ep) != filter_fabric_id)
+				continue;
+
+			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq,
+					  &drm_fabric_nl_family, NLM_F_MULTI,
+					  DRM_FABRIC_CMD_ENDPOINT_GET);
+			if (!hdr) {
+				ret = -EMSGSIZE;
+				break;
+			}
+			genl_dump_check_consistent(cb, hdr);
+
+			if (nla_put_u32(skb, DRM_FABRIC_A_TOPOLOGY_GENERATION,
+					drm_fabric_base_seq)) {
+				genlmsg_cancel(skb, hdr);
+				ret = -EMSGSIZE;
+				break;
+			}
+
+			ret = drm_fabric_fill_endpoint(skb, ep);
+			if (ret) {
+				genlmsg_cancel(skb, hdr);
+				break;
+			}
+
+			genlmsg_end(skb, hdr);
+		}
+	}
+
+	if (ret == -EMSGSIZE) {
+		ctx->idx = eidx;
+		return skb->len;
+	}
+	return ret;
+}
+
+static int drm_fabric_port_key(struct genl_info *info, u32 *ep_id, u32 *port_idx)
+{
+	if (GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_ENDPOINT_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_FABRIC_A_PORT_INDEX))
+		return -EINVAL;
+
+	*ep_id = nla_get_u32(info->attrs[DRM_FABRIC_A_ENDPOINT_ID]);
+	*port_idx = nla_get_u32(info->attrs[DRM_FABRIC_A_PORT_INDEX]);
+	return 0;
+}
+
+int drm_fabric_nl_port_get_doit(struct sk_buff *skb,
+				struct genl_info *info)
+{
+	struct drm_fabric_port *port;
+	struct sk_buff *msg;
+	u32 ep_id, port_idx;
+	void *hdr;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	ret = drm_fabric_port_key(info, &ep_id, &port_idx);
+	if (ret)
+		return ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			  &drm_fabric_nl_family, 0,
+			  DRM_FABRIC_CMD_PORT_GET);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		port = drm_fabric_port_find(ep_id, port_idx);
+		if (!port) {
+			nlmsg_free(msg);
+			return -ENOENT;
+		}
+
+		ret = drm_fabric_fill_port(msg, port);
+		if (ret) {
+			nlmsg_free(msg);
+			return ret;
+		}
+
+		if (nla_put_u32(msg, DRM_FABRIC_A_TOPOLOGY_GENERATION,
+				drm_fabric_base_seq)) {
+			nlmsg_free(msg);
+			return -EMSGSIZE;
+		}
+	}
+
+	genlmsg_end(msg, hdr);
+	return genlmsg_reply(msg, info);
+}
+
+static int
+drm_fabric_dump_endpoint_ports(struct sk_buff *skb,
+			       struct netlink_callback *cb,
+			       struct drm_fabric_endpoint *ep, u8 cmd,
+			       int (*fill)(struct sk_buff *,
+					   struct drm_fabric_port *),
+			       unsigned long *s_port_idx)
+{
+	struct drm_fabric_port *port;
+	unsigned long pidx;
+	void *hdr;
+	int ret = 0;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	xa_for_each_start(&ep->ports, pidx, port, *s_port_idx) {
+		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &drm_fabric_nl_family,
+				  NLM_F_MULTI, cmd);
+		if (!hdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+		genl_dump_check_consistent(cb, hdr);
+
+		/* PORT_STATS_GET replies carry no topology-generation. */
+		if (cmd == DRM_FABRIC_CMD_PORT_GET &&
+		    nla_put_u32(skb, DRM_FABRIC_A_TOPOLOGY_GENERATION,
+				drm_fabric_base_seq)) {
+			genlmsg_cancel(skb, hdr);
+			ret = -EMSGSIZE;
+			break;
+		}
+
+		ret = fill(skb, port);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			break;
+		}
+
+		genlmsg_end(skb, hdr);
+	}
+
+	/* Only a partially emitted endpoint keeps its port cursor. */
+	*s_port_idx = (ret == -EMSGSIZE) ? pidx : 0;
+	return ret;
+}
+
+static int drm_fabric_port_dump(struct sk_buff *skb,
+				struct netlink_callback *cb,
+				int cmd,
+				int (*fill)(struct sk_buff *, struct drm_fabric_port *))
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_fabric_port_dump_ctx *ctx = drm_fabric_port_dump_context(cb);
+	u32 filter_ep_id = 0;
+	bool has_ep_filter = false;
+	struct drm_fabric_endpoint *ep;
+	unsigned long eidx;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	if (info->attrs[DRM_FABRIC_A_ENDPOINT_ID]) {
+		filter_ep_id = nla_get_u32(info->attrs[DRM_FABRIC_A_ENDPOINT_ID]);
+		has_ep_filter = true;
+	}
+
+	scoped_guard(mutex, &drm_fabric_lock) {
+		bool first = true;
+
+		cb->seq = drm_fabric_base_seq;
+		xa_for_each_start(&drm_fabric_ep_xa, eidx, ep, ctx->ep_idx) {
+			/*
+			 * port_idx belongs to ep_idx; honor it only if
+			 * that endpoint still resolves.
+			 */
+			if (first) {
+				if (eidx != ctx->ep_idx)
+					ctx->port_idx = 0;
+				first = false;
+			}
+
+			if (has_ep_filter && ep->id != filter_ep_id) {
+				ctx->port_idx = 0;
+				continue;
+			}
+
+			ret = drm_fabric_dump_endpoint_ports(skb, cb, ep,
+							     cmd,
+							     fill,
+							     &ctx->port_idx);
+			if (ret)
+				break;
+		}
+	}
+
+	if (ret == -EMSGSIZE) {
+		ctx->ep_idx = eidx;
+		return skb->len;
+	}
+	return ret;
+}
+
+int drm_fabric_nl_port_get_dumpit(struct sk_buff *skb,
+				  struct netlink_callback *cb)
+{
+	return drm_fabric_port_dump(skb, cb, DRM_FABRIC_CMD_PORT_GET,
+				    drm_fabric_fill_port);
+}
+
+/* Advance the cursor to the next port at or after it, or return NULL. */
+static struct drm_fabric_port *
+drm_fabric_stats_dump_next(unsigned long *ep_idx, unsigned long *port_idx,
+			   bool has_ep_filter, u32 filter_ep_id)
+{
+	struct drm_fabric_endpoint *ep;
+	struct drm_fabric_port *port;
+	unsigned long eidx;
+	bool first = true;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	xa_for_each_start(&drm_fabric_ep_xa, eidx, ep, *ep_idx) {
+		if (first) {
+			if (eidx != *ep_idx)
+				*port_idx = 0;
+			first = false;
+		}
+
+		if (has_ep_filter && ep->id != filter_ep_id) {
+			*port_idx = 0;
+			continue;
+		}
+
+		port = xa_find(&ep->ports, port_idx, ULONG_MAX, XA_PRESENT);
+		if (port) {
+			*ep_idx = eidx;
+			return port;
+		}
+
+		*port_idx = 0;
+	}
+
+	/* Mark the endpoint cursor exhausted. */
+	*ep_idx = ULONG_MAX;
+	return NULL;
+}
+
+/*
+ * Port indices are provider-chosen u32s, so port_index may be U32_MAX;
+ * adding one there would wrap to 0 and re-dump the endpoint forever.
+ */
+static void
+drm_fabric_stats_cursor_advance(unsigned long *ep_idx, unsigned long *port_idx,
+				u32 port_index)
+{
+	if (port_index == U32_MAX) {
+		(*ep_idx)++;
+		*port_idx = 0;
+	} else {
+		*port_idx = port_index + 1;
+	}
+}
+
+/* Advance past an unsupported port so a resumed dump cannot retry it. */
+static void
+drm_fabric_stats_dump_skip(struct sk_buff *skb, void *hdr,
+			   struct drm_fabric_port_dump_ctx *ctx,
+			   struct drm_fabric_port *port,
+			   u32 port_index)
+{
+	genlmsg_cancel(skb, hdr);
+	drm_fabric_port_put(port);
+	drm_fabric_stats_cursor_advance(&ctx->ep_idx, &ctx->port_idx,
+					port_index);
+}
+
+int drm_fabric_nl_port_stats_get_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	const struct drm_fabric_ops *ops;
+	struct drm_fabric_port_stats stats = {};
+	struct drm_fabric_port *port;
+	struct sk_buff *msg;
+	u32 ep_id, port_idx;
+	void *hdr;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	ret = drm_fabric_port_key(info, &ep_id, &port_idx);
+	if (ret)
+		return ret;
+
+	/*
+	 * Pins the port through its endpoint across the unlocked provider
+	 * callback; endpoint_unregister() waits on this pin, so it cannot be
+	 * freed underneath us.
+	 */
+	port = drm_fabric_port_find_get(ep_id, port_idx);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+
+	ops = port->endpoint->ops;
+	if (!ops || !ops->port_stats_get) {
+		ret = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	lockdep_assert_not_held(&drm_fabric_lock);
+	ret = ops->port_stats_get(port, &stats);
+	if (ret)
+		goto out_put;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto out_put;
+	}
+
+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			  &drm_fabric_nl_family, 0,
+			  DRM_FABRIC_CMD_PORT_STATS_GET);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto out_free;
+	}
+
+	ret = drm_fabric_fill_port_stats(msg, port, &stats);
+	if (ret)
+		goto out_free;
+
+	genlmsg_end(msg, hdr);
+	drm_fabric_port_put(port);
+	return genlmsg_reply(msg, info);
+
+out_free:
+	nlmsg_free(msg);
+out_put:
+	drm_fabric_port_put(port);
+	return ret;
+}
+
+/*
+ * Statistics callbacks may sleep. Pin the endpoint, drop the lock, then
+ * resample cb->seq so a mutation in that window sets NLM_F_DUMP_INTR.
+ */
+int drm_fabric_nl_port_stats_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_fabric_port_dump_ctx *ctx = drm_fabric_port_dump_context(cb);
+	u32 filter_ep_id = 0;
+	bool has_ep_filter = false;
+	int ret;
+
+	ret = drm_fabric_nl_host_only(genl_info_net(info));
+	if (ret)
+		return ret;
+
+	if (info->attrs[DRM_FABRIC_A_ENDPOINT_ID]) {
+		filter_ep_id = nla_get_u32(info->attrs[DRM_FABRIC_A_ENDPOINT_ID]);
+		has_ep_filter = true;
+	}
+
+	for (;;) {
+		const struct drm_fabric_ops *ops;
+		struct drm_fabric_port_stats stats = {};
+		struct drm_fabric_endpoint *ep;
+		struct drm_fabric_port *port;
+		u32 port_index;
+		void *hdr;
+
+		scoped_guard(mutex, &drm_fabric_lock) {
+			/*
+			 * Sampled before the cursor check so even a batch
+			 * that emits nothing can report a late mutation.
+			 */
+			cb->seq = drm_fabric_base_seq;
+
+			port = drm_fabric_stats_dump_next(&ctx->ep_idx,
+							  &ctx->port_idx,
+							  has_ep_filter,
+							  filter_ep_id);
+			/*
+			 * Exhausted: 0 terminates the dump with NLMSG_DONE
+			 * instead of re-running the parked cursor.
+			 */
+			if (!port)
+				return 0;
+
+			ep = port->endpoint;
+			ops = ep->ops;
+			port_index = port->index;
+			drm_fabric_endpoint_get(ep);
+		}
+
+		/* Reserve the reply before invoking the sleeping provider callback. */
+		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &drm_fabric_nl_family,
+				  NLM_F_MULTI, DRM_FABRIC_CMD_PORT_STATS_GET);
+		if (!hdr) {
+			drm_fabric_port_put(port);
+			return skb->len;
+		}
+
+		if (!ops || !ops->port_stats_get) {
+			drm_fabric_stats_dump_skip(skb, hdr, ctx, port, port_index);
+			continue;
+		}
+
+		lockdep_assert_not_held(&drm_fabric_lock);
+		ret = ops->port_stats_get(port, &stats);
+		if (ret == -EOPNOTSUPP) {
+			drm_fabric_stats_dump_skip(skb, hdr, ctx, port, port_index);
+			continue;
+		}
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			drm_fabric_port_put(port);
+			break;
+		}
+
+		genl_dump_check_consistent(cb, hdr);
+
+		if (drm_fabric_fill_port_stats(skb, port, &stats)) {
+			genlmsg_cancel(skb, hdr);
+			drm_fabric_port_put(port);
+			return skb->len;
+		}
+
+		genlmsg_end(skb, hdr);
+		drm_fabric_port_put(port);
+
+		drm_fabric_stats_cursor_advance(&ctx->ep_idx, &ctx->port_idx,
+						port_index);
+	}
+
+	return ret;
+}
+
+void drm_fabric_emit_port_change(struct drm_fabric_port *port, u32 generation)
+{
+	struct sk_buff *msg;
+	void *hdr;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = genlmsg_put(msg, 0, 0, &drm_fabric_nl_family, 0, DRM_FABRIC_CMD_PORT_CHANGE_NTF);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, DRM_FABRIC_A_TOPOLOGY_GENERATION, generation) ||
+	    drm_fabric_fill_port(msg, port)) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_fabric_nl_family, msg, 0,
+			  DRM_FABRIC_NLGRP_MONITOR, GFP_KERNEL);
+}
+
+static void drm_fabric_port_peer_event_send(enum drm_fabric_cmd cmd,
+					    struct drm_fabric_port *port,
+					    const struct drm_fabric_peer *peer,
+					    u32 generation)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	struct nlattr *nest;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = genlmsg_put(msg, 0, 0, &drm_fabric_nl_family, 0, cmd);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, DRM_FABRIC_A_TOPOLOGY_GENERATION, generation) ||
+	    nla_put_u32(msg, DRM_FABRIC_A_ENDPOINT_ID, port->endpoint->id) ||
+	    nla_put_u32(msg, DRM_FABRIC_A_PORT_INDEX, port->index)) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	nest = nla_nest_start(msg, DRM_FABRIC_A_PEER);
+	if (!nest) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u64_64bit(msg, DRM_FABRIC_A_PEER_ATTRS_PEER_ID,
+			      peer->peer_id, DRM_FABRIC_A_PEER_ATTRS_PAD) ||
+	    nla_put_u32(msg, DRM_FABRIC_A_PEER_ATTRS_TYPE, peer->peer_type) ||
+	    nla_put_u32(msg, DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX, peer->port_index)) {
+		nla_nest_cancel(msg, nest);
+		nlmsg_free(msg);
+		return;
+	}
+
+	nla_nest_end(msg, nest);
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_fabric_nl_family, msg, 0,
+			  DRM_FABRIC_NLGRP_MONITOR, GFP_KERNEL);
+}
+
+void drm_fabric_emit_port_peer_create(struct drm_fabric_port *port,
+				   const struct drm_fabric_peer *peer,
+				   u32 generation)
+{
+	drm_fabric_port_peer_event_send(DRM_FABRIC_CMD_PORT_PEER_CREATE_NTF,
+					port, peer, generation);
+}
+
+void drm_fabric_emit_port_peer_delete(struct drm_fabric_port *port,
+				   const struct drm_fabric_peer *peer,
+				   u32 generation)
+{
+	drm_fabric_port_peer_event_send(DRM_FABRIC_CMD_PORT_PEER_DELETE_NTF,
+					port, peer, generation);
+}
+
+static void drm_fabric_endpoint_event_send(enum drm_fabric_cmd cmd,
+					   struct drm_fabric_endpoint *ep,
+					   u32 generation)
+{
+	struct sk_buff *msg;
+	void *hdr;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = genlmsg_put(msg, 0, 0, &drm_fabric_nl_family, 0, cmd);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, DRM_FABRIC_A_TOPOLOGY_GENERATION, generation) ||
+	    drm_fabric_fill_endpoint(msg, ep)) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_fabric_nl_family, msg, 0,
+			  DRM_FABRIC_NLGRP_MONITOR, GFP_KERNEL);
+}
+
+void drm_fabric_emit_endpoint_create(struct drm_fabric_endpoint *ep, u32 generation)
+{
+	drm_fabric_endpoint_event_send(DRM_FABRIC_CMD_ENDPOINT_CREATE_NTF, ep,
+				       generation);
+}
+
+void drm_fabric_emit_endpoint_delete(struct drm_fabric_endpoint *ep, u32 generation)
+{
+	drm_fabric_endpoint_event_send(DRM_FABRIC_CMD_ENDPOINT_DELETE_NTF, ep,
+				       generation);
+}
+
+static void drm_fabric_fabric_event_send(enum drm_fabric_cmd cmd,
+					 struct drm_fabric *fabric,
+					 u32 generation)
+{
+	struct sk_buff *msg;
+	void *hdr;
+
+	lockdep_assert_held(&drm_fabric_lock);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = genlmsg_put(msg, 0, 0, &drm_fabric_nl_family, 0, cmd);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	if (nla_put_u32(msg, DRM_FABRIC_A_TOPOLOGY_GENERATION, generation) ||
+	    drm_fabric_fill_fabric(msg, fabric)) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_fabric_nl_family, msg, 0,
+			  DRM_FABRIC_NLGRP_MONITOR, GFP_KERNEL);
+}
+
+void drm_fabric_emit_fabric_create(struct drm_fabric *fabric, u32 generation)
+{
+	drm_fabric_fabric_event_send(DRM_FABRIC_CMD_FABRIC_CREATE_NTF, fabric,
+				     generation);
+}
+
+void drm_fabric_emit_fabric_delete(struct drm_fabric *fabric, u32 generation)
+{
+	drm_fabric_fabric_event_send(DRM_FABRIC_CMD_FABRIC_DELETE_NTF, fabric,
+				     generation);
+}
+
+int drm_fabric_netlink_register(void)
+{
+	return genl_register_family(&drm_fabric_nl_family);
+}
+
+void drm_fabric_netlink_unregister(void)
+{
+	genl_unregister_family(&drm_fabric_nl_family);
+}
diff --git a/drivers/gpu/drm/fabric/drm_fabric_nl.c b/drivers/gpu/drm/fabric/drm_fabric_nl.c
new file mode 100644
index 000000000000..032548405146
--- /dev/null
+++ b/drivers/gpu/drm/fabric/drm_fabric_nl.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/drm_fabric.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "drm_fabric_nl.h"
+
+#include <uapi/drm/drm_fabric.h>
+
+/* DRM_FABRIC_CMD_FABRIC_GET - do */
+static const struct nla_policy drm_fabric_fabric_get_nl_policy[DRM_FABRIC_A_FABRIC_ID + 1] = {
+	[DRM_FABRIC_A_FABRIC_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_FABRIC_CMD_ENDPOINT_GET - do */
+static const struct nla_policy drm_fabric_endpoint_get_do_nl_policy[DRM_FABRIC_A_BUS_NAME + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DRM_FABRIC_A_BUS_NAME] = { .type = NLA_NUL_STRING, },
+};
+
+/* DRM_FABRIC_CMD_ENDPOINT_GET - dump */
+static const struct nla_policy drm_fabric_endpoint_get_dump_nl_policy[DRM_FABRIC_A_FABRIC_ID + 1] = {
+	[DRM_FABRIC_A_FABRIC_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_FABRIC_CMD_PORT_GET - do */
+static const struct nla_policy drm_fabric_port_get_do_nl_policy[DRM_FABRIC_A_PORT_INDEX + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_PORT_INDEX] = { .type = NLA_U32, },
+};
+
+/* DRM_FABRIC_CMD_PORT_GET - dump */
+static const struct nla_policy drm_fabric_port_get_dump_nl_policy[DRM_FABRIC_A_ENDPOINT_ID + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_FABRIC_CMD_PORT_STATS_GET - do */
+static const struct nla_policy drm_fabric_port_stats_get_do_nl_policy[DRM_FABRIC_A_PORT_INDEX + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+	[DRM_FABRIC_A_PORT_INDEX] = { .type = NLA_U32, },
+};
+
+/* DRM_FABRIC_CMD_PORT_STATS_GET - dump */
+static const struct nla_policy drm_fabric_port_stats_get_dump_nl_policy[DRM_FABRIC_A_ENDPOINT_ID + 1] = {
+	[DRM_FABRIC_A_ENDPOINT_ID] = { .type = NLA_U32, },
+};
+
+/* Ops table for drm_fabric */
+static const struct genl_split_ops drm_fabric_nl_ops[] = {
+	{
+		.cmd		= DRM_FABRIC_CMD_FABRIC_GET,
+		.doit		= drm_fabric_nl_fabric_get_doit,
+		.policy		= drm_fabric_fabric_get_nl_policy,
+		.maxattr	= DRM_FABRIC_A_FABRIC_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= DRM_FABRIC_CMD_FABRIC_GET,
+		.dumpit	= drm_fabric_nl_fabric_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_ENDPOINT_GET,
+		.doit		= drm_fabric_nl_endpoint_get_doit,
+		.policy		= drm_fabric_endpoint_get_do_nl_policy,
+		.maxattr	= DRM_FABRIC_A_BUS_NAME,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_ENDPOINT_GET,
+		.dumpit		= drm_fabric_nl_endpoint_get_dumpit,
+		.policy		= drm_fabric_endpoint_get_dump_nl_policy,
+		.maxattr	= DRM_FABRIC_A_FABRIC_ID,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_PORT_GET,
+		.doit		= drm_fabric_nl_port_get_doit,
+		.policy		= drm_fabric_port_get_do_nl_policy,
+		.maxattr	= DRM_FABRIC_A_PORT_INDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_PORT_GET,
+		.dumpit		= drm_fabric_nl_port_get_dumpit,
+		.policy		= drm_fabric_port_get_dump_nl_policy,
+		.maxattr	= DRM_FABRIC_A_ENDPOINT_ID,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_PORT_STATS_GET,
+		.doit		= drm_fabric_nl_port_stats_get_doit,
+		.policy		= drm_fabric_port_stats_get_do_nl_policy,
+		.maxattr	= DRM_FABRIC_A_PORT_INDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_FABRIC_CMD_PORT_STATS_GET,
+		.dumpit		= drm_fabric_nl_port_stats_get_dumpit,
+		.policy		= drm_fabric_port_stats_get_dump_nl_policy,
+		.maxattr	= DRM_FABRIC_A_ENDPOINT_ID,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+};
+
+static const struct genl_multicast_group drm_fabric_nl_mcgrps[] = {
+	[DRM_FABRIC_NLGRP_MONITOR] = { "monitor", },
+};
+
+struct genl_family drm_fabric_nl_family __ro_after_init = {
+	.name		= DRM_FABRIC_FAMILY_NAME,
+	.version	= DRM_FABRIC_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= drm_fabric_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(drm_fabric_nl_ops),
+	.mcgrps		= drm_fabric_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(drm_fabric_nl_mcgrps),
+};
-- 
2.43.0

