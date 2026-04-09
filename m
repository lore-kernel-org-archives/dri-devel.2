Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70660E9DE41
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 07:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C676410E745;
	Thu,  9 Apr 2026 07:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="e0yTabb5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0426210E745;
 Thu,  9 Apr 2026 07:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775718080; x=1807254080;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+mkfDbhtIyI5hf22TsqdnKZPfqiAA/Oa3PYI4JJSSEw=;
 b=e0yTabb59IThJzPm/MO41Yk9NEMh1WFmrvPLD9qpyM3KBeYRwmgacDs8
 FzJvcOLmP648sWWcAfPbXqkiiiU8drq6wXt2cO0yqF2lHrLX104nOfHiA
 2zfwuOx41HSkmCpsJ7pOaH3Ra5in3Qe4iI+9H85bRVetMCckMZbFmSYAG
 +sF5OlObj6iP3koMadr/2S+ndOaVwMG4r1QAAOokUYZi9sMtIIQFr2G1H
 MvHd+FIlPsuB/+p3FIViZhioi9RNHUpGdCcsK9Ptu4Luf61qi+O2xurna
 jX1H7pkGMk05HVGzwQTRhWPs76WEiNubwkXYLQB9JJFcHDt3ELMhhpI4L Q==;
X-CSE-ConnectionGUID: 7IUD6rrSR9++qR5sSE4RtA==
X-CSE-MsgGUID: ELVziG2CRdCWF+ORLTlAsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76836472"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76836472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:01:20 -0700
X-CSE-ConnectionGUID: BZfY6AYDQ/yfqTRvXMwUdw==
X-CSE-MsgGUID: asSMI837S3m7WJAK6POEgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="233576542"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:01:13 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, anvesh.bakwad@intel.com,
 maarten.lankhorst@linux.intel.com, Riana Tauro <riana.tauro@intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 1/2] drm/drm_ras: Add clear-error-counter netlink command
 to drm_ras
Date: Thu,  9 Apr 2026 13:03:19 +0530
Message-ID: <20260409073318.2909379-5-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260409073318.2909379-4-riana.tauro@intel.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
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

Introduce a new 'clear-error-counter' drm_ras command to reset the counter
value for a specific error counter of a given node.

The command is a 'do' netlink request with 'node-id' and 'error-id'
as parameters with no response payload.

Usage:

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":1}'
None

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
 Documentation/gpu/drm-ras.rst            |  8 +++++
 Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
 drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
 drivers/gpu/drm/drm_ras_nl.h             |  2 ++
 include/drm/drm_ras.h                    | 11 ++++++
 include/uapi/drm/drm_ras.h               |  1 +
 7 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 70b246a78fc8..4636e68f5678 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -52,6 +52,8 @@ User space tools can:
   as a parameter.
 * Query specific error counter values with the ``get-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Clear specific error counters with the ``clear-error-counter`` command, using both
+  ``node-id`` and ``error-id`` as parameters.
 
 YAML-based Interface
 --------------------
@@ -101,3 +103,9 @@ Example: Query an error counter for a given node
     sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
     {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
 
+Example: Clear an error counter for a given node
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
+    None
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 79af25dac3c5..e113056f8c01 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -99,7 +99,7 @@ operations:
       flags: [admin-perm]
       do:
         request:
-          attributes:
+          attributes: &id-attrs
             - node-id
             - error-id
         reply:
@@ -113,3 +113,14 @@ operations:
             - node-id
         reply:
           attributes: *errorinfo
+    -
+      name: clear-error-counter
+      doc: >-
+           Clear error counter for a given node.
+           The request includes the error-id and node-id of the
+           counter to be cleared.
+      attribute-set: error-counter-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes: *id-attrs
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b2fa5ab86d87..d6eab29a1394 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -26,7 +26,7 @@
  * efficient lookup by ID. Nodes can be registered or unregistered
  * dynamically at runtime.
  *
- * A Generic Netlink family `drm_ras` exposes two main operations to
+ * A Generic Netlink family `drm_ras` exposes the below operations to
  * userspace:
  *
  * 1. LIST_NODES: Dump all currently registered RAS nodes.
@@ -37,6 +37,10 @@
  *    Returns all counters of a node if only Node ID is provided or specific
  *    error counters.
  *
+ * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
+ *    Userspace must provide Node ID, Error ID.
+ *    Clears specific error counter of a node if supported.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -66,6 +70,8 @@
  *   operation, fetching all counters from a specific node.
  * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
  *   operation, fetching a counter value from a specific node.
+ * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
+ *   operation, clearing a counter value from a specific node.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 	return doit_reply_value(info, node_id, error_id);
 }
 
+/**
+ * drm_ras_nl_clear_error_counter_doit() - Clear an error counter of a node
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the node ID and error ID from the netlink attributes and
+ * clears the current value.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
+					struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	u32 node_id, error_id;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
+	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->clear_error_counter)
+		return -ENOENT;
+
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->clear_error_counter(node, error_id);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 16803d0c4a44..dea1c1b2494e 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
+static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+		.doit		= drm_ras_nl_clear_error_counter_doit,
+		.policy		= drm_ras_clear_error_counter_nl_policy,
+		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family drm_ras_nl_family __ro_after_init = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 06ccd9342773..a398643572a5 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 				      struct genl_info *info);
 int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 					struct netlink_callback *cb);
+int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
+					struct genl_info *info);
 
 extern struct genl_family drm_ras_nl_family;
 
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 5d50209e51db..f2a787bc4f64 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -58,6 +58,17 @@ struct drm_ras_node {
 	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
 				   const char **name, u32 *val);
 
+	/**
+	 * @clear_error_counter:
+	 *
+	 * This callback is used by drm_ras to clear a specific error counter.
+	 * Driver should implement this callback to support clearing error counters
+	 * of a node.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
+
 	/** @priv: Driver private data */
 	void *priv;
 };
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 5f40fa5b869d..218a3ee86805 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -41,6 +41,7 @@ enum {
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
+	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.47.1

