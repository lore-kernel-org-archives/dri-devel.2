Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D34C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D3210E694;
	Mon, 24 Aug 2026 08:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BxZ3YBNO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9AB10E68C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:10:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 958B86013A;
 Mon, 24 Aug 2026 08:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949DE1F000E9;
 Mon, 24 Aug 2026 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787559014;
 bh=IHxbnhmYc79BAZ0xPS4Yyxb/Ss/0UNZAeN3xqNuXQXc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BxZ3YBNOrBnZ2bhmKpPL8mHxdGQTksgynbNwIY922I2LNhOABfaPEI0OWFbso3jd7
 MEkQOuRZEcm/ZnFDFJ/BZJEhgPTAIM5s1lZomUIjuZYtpKZKnbN3XdUT/GvRXrebQa
 TtC7ejPe3SxBC/wKzQ4aXQnANnEs6B1Q/tNJs207+pg1hOIjAU1BgUysHWCwV6Urg4
 oxYahtoihuf2qNKFNEUl+rby0AblXTsp1mZTDILBi03bwLsviqo+b4wuxhwiI/B+nn
 fHgeyvrGfStk0pe5mkbFu6XwllsarRidBXmueT8++OB5CB3nbTeQJ7OdVPdGS8G9M7
 mqmTVScsO0VEw==
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
Subject: [RFC PATCH 08/12] drm/fabric: add provisioning netlink uAPI
Date: Mon, 24 Aug 2026 11:09:36 +0300
Message-ID: <2e6631d18a5a05e5a6217ce0b342fb5fedd2ca7d.1787552412.git.ksinyuk@kernel.org>
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

Extend the YNL specification with six privileged provisioning commands.

FABRIC_NEW and FABRIC_DEL create and delete empty userspace-owned
fabrics; FABRIC_NEW carries a fabric-new-params nest with the type, name
and instance ID. ENDPOINT_SET changes fabric membership and endpoint
administrative state, PORT_SET changes port administrative state, and
PORT_PEER_NEW and PORT_PEER_DEL manage peer adjacency. All six require
GENL_ADMIN_PERM.

A peer request carries its type-qualified identity and far-end port
index. The descriptor is stored without resolving it to a local object,
as documented in Documentation/gpu/drm-fabric.rst.

Add an endpoint-change notification and extend the existing port-change
and peer notifications to cover userspace-requested transitions.

Generate the headers from the tree root with:

  tools/net/ynl/pyynl/ynl_gen_c.py --mode uapi --header \
      --spec Documentation/netlink/specs/drm_fabric.yaml \
      -o include/uapi/drm/drm_fabric.h
  tools/net/ynl/pyynl/ynl_gen_c.py --mode kernel --header \
      --spec Documentation/netlink/specs/drm_fabric.yaml \
      -o drivers/gpu/drm/fabric/drm_fabric_nl.h

The generated source names the six doit handlers, so it lands with their
implementation in the next patch. Drop the temporary administrative-state
definitions now that the generated headers provide them.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Co-developed-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Signed-off-by: Konstantin Sinyuk <ksinyuk@kernel.org>
Assisted-by: GitHub-Copilot:claude-opus-4.8
---
 Documentation/gpu/drm-fabric.rst            | 117 ++++++++++++---
 Documentation/netlink/specs/drm_fabric.yaml | 155 +++++++++++++++++++-
 drivers/gpu/drm/fabric/drm_fabric_nl.h      |  30 ++++
 include/drm/drm_fabric.h                    |   9 +-
 include/uapi/drm/drm_fabric.h               |  28 ++++
 5 files changed, 312 insertions(+), 27 deletions(-)

diff --git a/Documentation/gpu/drm-fabric.rst b/Documentation/gpu/drm-fabric.rst
index 61e2c18bf0b5..4ee7cb7ef6ac 100644
--- a/Documentation/gpu/drm-fabric.rst
+++ b/Documentation/gpu/drm-fabric.rst
@@ -87,9 +87,11 @@ switch, an accelerator on another node, or a local endpoint that merely
 unregistered -- so only the provider knows when a port's physical adjacency
 actually changed, and only the provider retracts or replaces the descriptor.
 
-``port-peer-delete-ntf`` reports an explicitly retracted half-edge; it is
-not emitted when a peer merely becomes locally unresolvable, so its absence
-is not evidence the far end is still reachable.
+``port-peer-delete-ntf`` reports an explicitly retracted half-edge -- through
+the provider's own report or, on a userspace-managed port, a userspace
+``port-peer-del`` request -- and is never emitted when a peer merely becomes
+locally unresolvable, so its absence is not evidence the far end is still
+reachable.
 
 Endpoint teardown removes the endpoint's owned half-edges without
 generating a separate event for each port: the delete already describes
@@ -170,9 +172,9 @@ the mutation lock, so the nested acquisition would self-deadlock. A successful
 callback therefore cannot be invalidated before commit, and the post-callback
 checks are invariant assertions only.
 
-A fabric records whether it was created by a provider or by userspace. Only an
-empty userspace-created fabric may be deleted through the provisioning core;
-provider-owned and non-empty fabrics are rejected.
+A fabric records whether it was created by a provider
+(drm_fabric_register()) or by userspace (``fabric-new``); see
+`Provisioning`_ for the deletion rules.
 
 Generic Netlink family
 ======================
@@ -216,8 +218,9 @@ User space enumerates topology with four read-only commands, each supporting a
 single lookup (``do``) and a bulk dump (``dump``):
 
 * ``fabric-get`` -- enumerate fabrics (``do`` by ``fabric-id``, ``dump`` for all).
-* ``endpoint-get`` -- enumerate endpoints, optionally filtered by ``fabric-id``,
-  or resolve one by ``endpoint-id`` or backing ``dev-name``/``bus-name``.
+* ``endpoint-get`` -- enumerate endpoints, optionally filtered by ``fabric-id``
+  (0 selects orphans), or resolve one by ``endpoint-id`` or by its backing
+  ``dev-name`` with an optional ``bus-name``.
 * ``port-get`` -- enumerate ports, filtered by ``endpoint-id``. Ports may report
   the provider's maximum capability as ``max-lane-count`` and
   ``max-lane-signaling-rate-mbps`` (zero means unknown); these are maxima, not
@@ -243,10 +246,10 @@ a partial payload and are declared with ``event:``.
      - Trigger
      - Payload
    * - ``fabric-create-ntf``
-     - a fabric is registered by a provider
+     - a fabric is registered (provider or ``fabric-new``)
      - reuses ``fabric-get``
    * - ``fabric-delete-ntf``
-     - a provider-owned fabric is unregistered
+     - a fabric is unregistered or removed via ``fabric-del``
      - reuses ``fabric-get``
    * - ``endpoint-create-ntf``
      - an endpoint is registered
@@ -254,15 +257,19 @@ a partial payload and are declared with ``event:``.
    * - ``endpoint-delete-ntf``
      - an endpoint is unregistered
      - reuses ``endpoint-get``
+   * - ``endpoint-change-ntf``
+     - an endpoint's fabric attachment or administrative state changes
+     - reuses ``endpoint-get``
    * - ``port-change-ntf``
-     - a port's operational state changes
+     - a port's operational or administrative state changes
      - reuses ``port-get``
    * - ``port-peer-create-ntf``
-     - a port's peer descriptor is set by its provider
+     - a port's peer descriptor is set (provider or ``port-peer-new``)
      - partial (``event:``)
    * - ``port-peer-delete-ntf``
-     - a port's peer descriptor is explicitly unset by its provider; never
-       emitted for an implicit half-edge loss (see `Peer semantics`_)
+     - a port's peer descriptor is explicitly unset (provider or
+       ``port-peer-del``); never emitted for an implicit half-edge loss
+       (see `Peer semantics`_)
      - partial (``event:``)
 
 Notifications are best-effort. A listener that detects loss, restarts, or
@@ -274,9 +281,9 @@ Topology generation and dump consistency
 The core keeps a nonzero generation counter and advances it whenever topology or
 exposed state changes. It is surfaced as the ``topology-generation`` attribute on
 ``fabric-get``, ``endpoint-get`` and ``port-get`` replies and on the topology
-notifications. A provider-reported change advances the generation before its
-notification is serialized, so an event carries the post-change value that a
-later ``get``/``dump`` will also report.
+notifications. A committed change -- provider-reported or userspace mutation
+-- advances the generation before its notification is serialized, so an event
+carries the post-change value that a later ``get``/``dump`` will also report.
 
 ``topology-generation`` is a change token, not a timestamp, liveness counter or
 event count: a changed value means topology changed, but the delta between two
@@ -308,8 +315,8 @@ Monitor notifications are likewise emitted only into ``init_net``, so a listener
 that joins the multicast group from another network namespace never receives
 them.
 
-Examples
-========
+Query examples
+--------------
 
 Query the topology with the in-tree YNL tool, pointing it at the spec:
 
@@ -364,6 +371,78 @@ Query a single port:
 
 The family name on the wire is ``drm-fabric``.
 
+Provisioning
+============
+
+The provisioning interface requires ``CAP_NET_ADMIN``. ``fabric-new`` and
+``fabric-del`` are core-owned; the rest are serviced by the provider and
+return ``-EOPNOTSUPP`` where it does not implement the matching callback:
+
+* ``fabric-new`` -- create an empty, userspace-owned fabric. The request
+  carries a ``fabric-new-params`` nest with the fabric type, an optional name
+  and a provider-defined instance ID.
+* ``fabric-del`` -- delete an empty, userspace-owned fabric. Refuses a
+  provider-owned fabric (``-EPERM``) and a non-empty one (``-EBUSY``).
+* ``endpoint-set`` -- attach an orphan endpoint, selected by ``endpoint-id`` or
+  by its backing ``dev-name`` with an optional ``bus-name``, to a fabric;
+  detach it with ``fabric-id`` 0; and/or set its administrative state.
+* ``port-set`` -- set a port's administrative state.
+* ``port-peer-new`` / ``port-peer-del`` -- set or unset a port's neighbor
+  half-edge. Valid only on a userspace-managed port; a provider-managed port
+  returns ``-EOPNOTSUPP`` (see `Peer management mode`_).
+
+Mutation commands carry ``GENL_ADMIN_PERM`` and are additionally confined to
+``init_net``. ``GENL_ADMIN_PERM`` only checks ``CAP_NET_ADMIN`` in the caller's
+user namespace, which a process in a nested user and network namespace may
+hold; restricting mutators to ``init_net`` prevents container-local privilege
+from reconfiguring host-global topology.
+
+A userspace-created fabric additionally pins this module for as long as it
+remains registered: ``fabric-new`` takes the pin, ``fabric-del`` releases it.
+
+Peer management mode
+--------------------
+
+A port uses one peer-management mode, fixed by the provider at registration.
+
+In provider-managed mode, the provider reports peer creation and removal
+(drm_fabric_port_set_peer() / drm_fabric_port_unset_peer()) and userspace peer
+provisioning is unsupported (``port-peer-new`` / ``port-peer-del`` return
+``-EOPNOTSUPP``).
+
+In userspace-managed mode, peer creation and removal are requested through the
+provisioning API and the provider does not independently replace or retract the
+peer (drm_fabric_port_set_peer() / drm_fabric_port_unset_peer() return
+``-EOPNOTSUPP``).
+
+One authority per descriptor prevents concurrent updates from both sources.
+Setting an occupied port returns ``-EEXIST``; unsetting an empty port returns
+``-ENOENT``.
+
+Provisioning examples
+---------------------
+
+Provision with the in-tree YNL tool (root, initial namespace):
+
+.. code-block:: bash
+
+    # Create an empty fabric
+    ./tools/net/ynl/pyynl/cli.py \
+        --spec Documentation/netlink/specs/drm_fabric.yaml \
+        --do fabric-new \
+        --json '{"fabric-new-params": {"type": "synthetic", "instance-id": 42}}'
+
+The command returns a core-assigned ``fabric-id``. Use that value in the
+following requests.
+
+.. code-block:: bash
+
+    # Attach an orphan endpoint to the returned fabric
+    ./tools/net/ynl/pyynl/cli.py \
+        --spec Documentation/netlink/specs/drm_fabric.yaml \
+        --do endpoint-set \
+        --json '{"endpoint-id": 5, "fabric-id": <returned-fabric-id>}'
+
 Synthetic provider
 ==================
 
diff --git a/Documentation/netlink/specs/drm_fabric.yaml b/Documentation/netlink/specs/drm_fabric.yaml
index 778443d92a0d..0c9a56f4b387 100644
--- a/Documentation/netlink/specs/drm_fabric.yaml
+++ b/Documentation/netlink/specs/drm_fabric.yaml
@@ -18,6 +18,16 @@ doc: |
   Replies and notifications carry a topology-generation token so an
   interrupted or changed dump can be discarded and retried.
 
+  The provisioning surface (fabric-new, fabric-del, endpoint-set, port-set,
+  port-peer-new and port-peer-del) requires administrative permission and is
+  restricted to the initial network namespace. fabric-new and fabric-del are
+  implemented by the core and do not depend on a provider callback. The rest
+  are serviced by the provider and return -EOPNOTSUPP where it does not
+  implement the matching one.
+
+  The interface is extensible: new fabric types and attributes can be added
+  without breaking the uAPI.
+
 definitions:
   -
     name: type
@@ -46,6 +56,13 @@ definitions:
     doc: Kind of device directly adjacent at a port's far end.
     entries: [accel, switch]
 
+  -
+    name: admin-state
+    type: enum
+    value-start: 1
+    doc: Administrative (requested) state of an endpoint or port.
+    entries: [down, up]
+
 attribute-sets:
   -
     name: drm-fabric
@@ -108,6 +125,17 @@ attribute-sets:
           or DUMP reply carries its snapshot's generation; a notification
           carries the generation of its change. Statistics reads do not
           advance it.
+      # Provisioning request parameters
+      -
+        name: admin-state
+        type: u32
+        enum: admin-state
+        doc: Requested administrative state.
+      -
+        name: fabric-new-params
+        type: nest
+        nested-attributes: fabric-new-params
+        doc: Creation parameters for ``fabric-new`` (full nest).
 
   -
     name: fabric
@@ -136,6 +164,30 @@ attribute-sets:
         type: u64
         doc: Vendor-unique fabric instance identifier (e.g. a hive ID).
 
+  -
+    name: fabric-new-params
+    name-prefix: drm-fabric-a-fabric-new-params-
+    enum-name: drm-fabric-a-fabric-new-params
+    doc: Creation parameters carried by a ``fabric-new`` request.
+    attributes:
+      -
+        name: type
+        type: u32
+        enum: type
+        doc: Fabric interconnect technology, see enum type.
+      -
+        name: name
+        type: string
+        checks:
+          max-len: 31
+        doc: >-
+          Human-readable fabric name. Bounded to the core's storage so an
+          over-long name is rejected rather than silently truncated.
+      -
+        name: instance-id
+        type: u64
+        doc: Vendor-unique fabric instance identifier (e.g. a hive ID).
+
   -
     name: endpoint
     name-prefix: drm-fabric-a-endpoint-attrs-
@@ -152,7 +204,7 @@ attribute-sets:
       -
         name: fabric-id
         type: u32
-        doc: Identifier of the parent fabric.
+        doc: Identifier of the parent fabric, 0 while orphaned.
       -
         name: fabric-ep-id
         type: u64
@@ -169,6 +221,11 @@ attribute-sets:
         name: bus-name
         type: string
         doc: The bus of the backing device (e.g. pci).
+      -
+        name: admin-state
+        type: u32
+        enum: admin-state
+        doc: Endpoint's administrative state.
 
   -
     name: port
@@ -209,6 +266,11 @@ attribute-sets:
         type: nest
         nested-attributes: peer
         doc: Peer info, absent if the port has no neighbor set.
+      -
+        name: admin-state
+        type: u32
+        enum: admin-state
+        doc: Port's administrative state.
 
   -
     name: peer
@@ -421,6 +483,97 @@ operations:
         reply shape (full fabric nest).
       notify: fabric-get
 
+    -
+      name: endpoint-change-ntf
+      doc: |
+        Endpoint state change notification.
+        Reuses the endpoint-get reply shape (full endpoint nest).
+      notify: endpoint-get
+
+    -
+      name: fabric-new
+      doc: Create a new empty fabric
+      attribute-set: drm-fabric
+      flags: [admin-perm]
+      do:
+        pre: drm-fabric-nl-pre-doit
+        post: drm-fabric-nl-post-doit
+        request:
+          attributes:
+            - fabric-new-params
+        reply:
+          attributes:
+            - fabric-id
+
+    -
+      name: fabric-del
+      doc: Delete an empty fabric
+      attribute-set: drm-fabric
+      flags: [admin-perm]
+      do:
+        pre: drm-fabric-nl-pre-doit
+        post: drm-fabric-nl-post-doit
+        request:
+          attributes:
+            - fabric-id
+
+    -
+      name: endpoint-set
+      doc: Attach/detach an endpoint to a fabric and/or set its admin state
+      attribute-set: drm-fabric
+      flags: [admin-perm]
+      do:
+        pre: drm-fabric-nl-endpoint-pre-doit
+        post: drm-fabric-nl-endpoint-post-doit
+        request:
+          attributes:
+            - endpoint-id
+            - dev-name
+            - bus-name
+            - fabric-id
+            - admin-state
+
+    -
+      name: port-set
+      doc: Set a port's administrative state
+      attribute-set: drm-fabric
+      flags: [admin-perm]
+      do:
+        pre: drm-fabric-nl-port-pre-doit
+        post: drm-fabric-nl-port-post-doit
+        request:
+          attributes:
+            - endpoint-id
+            - port-index
+            - admin-state
+
+    -
+      name: port-peer-new
+      doc: Set a port's neighbor
+      attribute-set: drm-fabric
+      flags: [admin-perm]
+      do:
+        pre: drm-fabric-nl-port-pre-doit
+        post: drm-fabric-nl-port-post-doit
+        request:
+          attributes:
+            - endpoint-id
+            - port-index
+            - peer
+
+    -
+      name: port-peer-del
+      doc: Unset a port's neighbor
+      attribute-set: drm-fabric
+      flags: [admin-perm]
+      do:
+        pre: drm-fabric-nl-port-pre-doit
+        post: drm-fabric-nl-port-post-doit
+        request:
+          attributes:
+            - endpoint-id
+            - port-index
+
 mcast-groups:
   list:
     -
diff --git a/drivers/gpu/drm/fabric/drm_fabric_nl.h b/drivers/gpu/drm/fabric/drm_fabric_nl.h
index 8cedc004260f..03b3d22f180c 100644
--- a/drivers/gpu/drm/fabric/drm_fabric_nl.h
+++ b/drivers/gpu/drm/fabric/drm_fabric_nl.h
@@ -12,6 +12,27 @@
 
 #include <uapi/drm/drm_fabric.h>
 
+/* Common nested types */
+extern const struct nla_policy drm_fabric_fabric_new_params_nl_policy[DRM_FABRIC_A_FABRIC_NEW_PARAMS_INSTANCE_ID + 1];
+extern const struct nla_policy drm_fabric_peer_nl_policy[DRM_FABRIC_A_PEER_ATTRS_PORT_INDEX + 1];
+
+int drm_fabric_nl_pre_doit(const struct genl_split_ops *ops,
+			   struct sk_buff *skb, struct genl_info *info);
+int drm_fabric_nl_endpoint_pre_doit(const struct genl_split_ops *ops,
+				    struct sk_buff *skb,
+				    struct genl_info *info);
+int drm_fabric_nl_port_pre_doit(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info);
+void
+drm_fabric_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info);
+void
+drm_fabric_nl_endpoint_post_doit(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info);
+void
+drm_fabric_nl_port_post_doit(const struct genl_split_ops *ops,
+			     struct sk_buff *skb, struct genl_info *info);
+
 int drm_fabric_nl_fabric_get_doit(struct sk_buff *skb, struct genl_info *info);
 int drm_fabric_nl_fabric_get_dumpit(struct sk_buff *skb,
 				    struct netlink_callback *cb);
@@ -26,6 +47,15 @@ int drm_fabric_nl_port_stats_get_doit(struct sk_buff *skb,
 				      struct genl_info *info);
 int drm_fabric_nl_port_stats_get_dumpit(struct sk_buff *skb,
 					struct netlink_callback *cb);
+int drm_fabric_nl_fabric_new_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_fabric_nl_fabric_del_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_fabric_nl_endpoint_set_doit(struct sk_buff *skb,
+				    struct genl_info *info);
+int drm_fabric_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_fabric_nl_port_peer_new_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+int drm_fabric_nl_port_peer_del_doit(struct sk_buff *skb,
+				     struct genl_info *info);
 
 enum {
 	DRM_FABRIC_NLGRP_MONITOR,
diff --git a/include/drm/drm_fabric.h b/include/drm/drm_fabric.h
index 69e9099a1e57..0479b6435a0e 100644
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
@@ -18,11 +18,6 @@
 
 #include <uapi/drm/drm_fabric.h>
 
-enum drm_fabric_admin_state {
-	DRM_FABRIC_ADMIN_STATE_DOWN = 1,
-	DRM_FABRIC_ADMIN_STATE_UP,
-};
-
 struct device;
 
 /**
diff --git a/include/uapi/drm/drm_fabric.h b/include/uapi/drm/drm_fabric.h
index b6c7bd6e35f0..e004200423e8 100644
--- a/include/uapi/drm/drm_fabric.h
+++ b/include/uapi/drm/drm_fabric.h
@@ -36,6 +36,14 @@ enum drm_fabric_peer_type {
 	DRM_FABRIC_PEER_TYPE_SWITCH,
 };
 
+/*
+ * Administrative (requested) state of an endpoint or port.
+ */
+enum drm_fabric_admin_state {
+	DRM_FABRIC_ADMIN_STATE_DOWN = 1,
+	DRM_FABRIC_ADMIN_STATE_UP,
+};
+
 enum drm_fabric_a {
 	DRM_FABRIC_A_FABRIC = 1,
 	DRM_FABRIC_A_ENDPOINT,
@@ -48,6 +56,8 @@ enum drm_fabric_a {
 	DRM_FABRIC_A_BUS_NAME,
 	DRM_FABRIC_A_PEER,
 	DRM_FABRIC_A_TOPOLOGY_GENERATION,
+	DRM_FABRIC_A_ADMIN_STATE,
+	DRM_FABRIC_A_FABRIC_NEW_PARAMS,
 
 	__DRM_FABRIC_A_MAX,
 	DRM_FABRIC_A_MAX = (__DRM_FABRIC_A_MAX - 1)
@@ -64,6 +74,15 @@ enum drm_fabric_a_fabric_attrs {
 	DRM_FABRIC_A_FABRIC_ATTRS_MAX = (__DRM_FABRIC_A_FABRIC_ATTRS_MAX - 1)
 };
 
+enum drm_fabric_a_fabric_new_params {
+	DRM_FABRIC_A_FABRIC_NEW_PARAMS_TYPE = 1,
+	DRM_FABRIC_A_FABRIC_NEW_PARAMS_NAME,
+	DRM_FABRIC_A_FABRIC_NEW_PARAMS_INSTANCE_ID,
+
+	__DRM_FABRIC_A_FABRIC_NEW_PARAMS_MAX,
+	DRM_FABRIC_A_FABRIC_NEW_PARAMS_MAX = (__DRM_FABRIC_A_FABRIC_NEW_PARAMS_MAX - 1)
+};
+
 enum drm_fabric_a_endpoint_attrs {
 	DRM_FABRIC_A_ENDPOINT_ATTRS_PAD = 1,
 	DRM_FABRIC_A_ENDPOINT_ATTRS_ENDPOINT_ID,
@@ -72,6 +91,7 @@ enum drm_fabric_a_endpoint_attrs {
 	DRM_FABRIC_A_ENDPOINT_ATTRS_NAME,
 	DRM_FABRIC_A_ENDPOINT_ATTRS_DEV_NAME,
 	DRM_FABRIC_A_ENDPOINT_ATTRS_BUS_NAME,
+	DRM_FABRIC_A_ENDPOINT_ATTRS_ADMIN_STATE,
 
 	__DRM_FABRIC_A_ENDPOINT_ATTRS_MAX,
 	DRM_FABRIC_A_ENDPOINT_ATTRS_MAX = (__DRM_FABRIC_A_ENDPOINT_ATTRS_MAX - 1)
@@ -84,6 +104,7 @@ enum drm_fabric_a_port_attrs {
 	DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_COUNT,
 	DRM_FABRIC_A_PORT_ATTRS_MAX_LANE_SIGNALING_RATE_MBPS,
 	DRM_FABRIC_A_PORT_ATTRS_PEER,
+	DRM_FABRIC_A_PORT_ATTRS_ADMIN_STATE,
 
 	__DRM_FABRIC_A_PORT_ATTRS_MAX,
 	DRM_FABRIC_A_PORT_ATTRS_MAX = (__DRM_FABRIC_A_PORT_ATTRS_MAX - 1)
@@ -124,6 +145,13 @@ enum drm_fabric_cmd {
 	DRM_FABRIC_CMD_ENDPOINT_DELETE_NTF,
 	DRM_FABRIC_CMD_FABRIC_CREATE_NTF,
 	DRM_FABRIC_CMD_FABRIC_DELETE_NTF,
+	DRM_FABRIC_CMD_ENDPOINT_CHANGE_NTF,
+	DRM_FABRIC_CMD_FABRIC_NEW,
+	DRM_FABRIC_CMD_FABRIC_DEL,
+	DRM_FABRIC_CMD_ENDPOINT_SET,
+	DRM_FABRIC_CMD_PORT_SET,
+	DRM_FABRIC_CMD_PORT_PEER_NEW,
+	DRM_FABRIC_CMD_PORT_PEER_DEL,
 
 	__DRM_FABRIC_CMD_MAX,
 	DRM_FABRIC_CMD_MAX = (__DRM_FABRIC_CMD_MAX - 1)
-- 
2.43.0

