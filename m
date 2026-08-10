Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97117C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06F710E7C1;
	Mon, 10 Aug 2026 11:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fjHufcB+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD6910E7C1;
 Mon, 10 Aug 2026 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786360832; x=1817896832;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OlU+WENZXToMxocHkbo9fSBkQWWWAah8nmAoLN+kBFk=;
 b=fjHufcB+VFhiLK/bGVM+OTpjIiQ5llrQr6XbGgfh6PCfKJ7VqojbrUjm
 YHCevYyxtA9ooj9WFB4o/OO13NXZCm2Gw+6n8rnqqbj2owsx1rN/c+ooX
 WzioRus8lNN4yqreQwJjdCOw6TJp7QpFL/WgewObvdlROTmoS6STIuzQh
 aEAMVZIW9/E0fC8wnQ7uRMYrEd+hsgV8u5VrqMgY+JitTBog9J6FaTmGM
 NBvVwHOU08ZKIBJCIPjG6OTngugKwK96KY8f27W+gU2xrGJUiVy9Bvm8t
 bykP9GIIxbMgFT84c7tR7tLkb/jYVCJGOr8xO6ov6jx3IpEh92qDRgh9J Q==;
X-CSE-ConnectionGUID: 4q51Uup2TeaSFwlINlSbhg==
X-CSE-MsgGUID: +ijjTrMXQt68Q0KtzqN80A==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97220929"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="97220929"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 04:20:31 -0700
X-CSE-ConnectionGUID: 95XJPWIFQMSyPe/HsTGMIg==
X-CSE-MsgGUID: UX7ryAhSTLOgUcbgPTyJ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="264998310"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 04:20:25 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, maarten.lankhorst@linux.intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 Riana Tauro <riana.tauro@intel.com>,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Subject: [PATCH v7 1/2] drm/drm_ras: Add drm_ras netlink error event
Date: Mon, 10 Aug 2026 16:50:10 +0530
Message-ID: <20260810112008.1858731-5-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260810112008.1858731-4-riana.tauro@intel.com>
References: <20260810112008.1858731-4-riana.tauro@intel.com>
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

Define a new netlink event 'error-event' and a new multicast group
'error-report' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Userspace must subscribe to 'error-report' to receive 'error-event'
notifications.

Usage:

$ sudo ynl --family drm_ras --subscribe error-report

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v2: rename error-notify to error-report (Raag)
    send event to all network namespaces (Sashiko)
---
 Documentation/gpu/drm-ras.rst            |  21 +++++
 Documentation/netlink/specs/drm_ras.yaml |  48 +++++++++++
 drivers/gpu/drm/drm_ras.c                | 101 +++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |   6 ++
 drivers/gpu/drm/drm_ras_nl.h             |   4 +
 include/drm/drm_ras.h                    |   5 ++
 include/uapi/drm/drm_ras.h               |  15 ++++
 7 files changed, 200 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 83c21853b74b..406e4c49bac1 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -56,6 +56,7 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Clear specific error counters with the ``clear-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
 
 YAML-based Interface
 --------------------
@@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
 
     sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
     None
+
+Example: Subscribe to ``error-report`` multicast group
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --output-json --subscribe error-report
+
+.. code-block:: json
+
+    {
+        "name": "error-event",
+        "msg": {
+            "device-name": "0000:03:00.0",
+            "node-id": 1,
+            "node-name": "uncorrectable-errors",
+            "error-id": 1,
+            "error-name": "error_name1",
+            "error-value": 1
+        }
+    }
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index e113056f8c01..8aed3d4515e5 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -69,6 +69,33 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the requested error counter.
+  -
+    name: error-event-attrs
+    attributes:
+      -
+        name: device-name
+        type: string
+        doc: Device (PCI BDF, UUID) that reported the error.
+      -
+        name: node-id
+        type: u32
+        doc: ID of the node that reported the error.
+      -
+        name: node-name
+        type: string
+        doc: Name of the node that reported the error.
+      -
+        name: error-id
+        type: u32
+        doc: ID of the error counter.
+      -
+        name: error-name
+        type: string
+        doc: Name of the error.
+      -
+        name: error-value
+        type: u32
+        doc: Current value of the error counter.
 
 operations:
   list:
@@ -124,3 +151,24 @@ operations:
       do:
         request:
           attributes: *id-attrs
+    -
+      name: error-event
+      doc: >-
+           Report an error event to userspace.
+           The event includes the device, node and error information
+           of the error that triggered the event.
+      attribute-set: error-event-attrs
+      mcgrp: error-report
+      event:
+        attributes:
+          - device-name
+          - node-id
+          - node-name
+          - error-id
+          - error-name
+          - error-value
+
+mcast-groups:
+  list:
+    -
+      name: error-report
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..39155fb514de 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,11 @@
  *    Userspace must provide Node ID, Error ID.
  *    Clears specific error counter of a node if supported.
  *
+ * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
+ *
+ * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
+ *    and error information that triggered the event.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
+static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
+				     u32 error_id, const char *error_name, u32 value)
+{
+	int ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
+	if (ret)
+		return ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
+	if (ret)
+		return ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
+}
+
 static int doit_reply_value(struct genl_info *info, u32 node_id,
 			    u32 error_id)
 {
@@ -222,6 +255,74 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	return genlmsg_reply(msg, info);
 }
 
+/**
+ * drm_ras_nl_error_event() - Report an error event
+ * @node: Node structure
+ * @error_id: ID of the error
+ * @error_name: Name of the error
+ * @value: Value of the error counter
+ *
+ * Report an error-event to userspace using the error-report multicast group.
+ *
+ * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
+ *          netns, which is unbounded work; callers in interrupt handlers
+ *          or other atomic context must defer event.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value)
+{
+	struct genl_info info;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	if (!node || !error_name)
+		return -EINVAL;
+
+	/* Check the node is currently registered */
+	if (xa_load(&drm_ras_xa, node->id) != node)
+		return -ENOENT;
+
+	/* Currently only Error Counter events are supported */
+	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
+		return -EOPNOTSUPP;
+
+	/* Check the error ID is within the valid range */
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, &info);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto free_msg;
+	}
+
+	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
+	if (ret)
+		goto cancel_msg;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast_allns(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT);
+
+	return 0;
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+EXPORT_SYMBOL(drm_ras_nl_error_event);
+
 /**
  * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
  * @skb: Netlink message buffer
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index dea1c1b2494e..9d3123cc9f9c 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 	},
 };
 
+static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
+	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
+};
+
 struct genl_family drm_ras_nl_family __ro_after_init = {
 	.name		= DRM_RAS_FAMILY_NAME,
 	.version	= DRM_RAS_FAMILY_VERSION,
@@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= drm_ras_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
+	.mcgrps		= drm_ras_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
 };
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index a398643572a5..03ec275aca92 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
 
+enum {
+	DRM_RAS_NLGRP_ERROR_REPORT,
+};
+
 extern struct genl_family drm_ras_nl_family;
 
 #endif /* _LINUX_DRM_RAS_GEN_H */
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 0beede3ddc4e..ee2caa0edc6f 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -80,9 +80,14 @@ struct drm_device;
 #if IS_ENABLED(CONFIG_DRM_RAS)
 int drm_ras_node_register(struct drm_ras_node *node);
 void drm_ras_node_unregister(struct drm_ras_node *node);
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value);
 #else
 static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
 static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
+static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
+					 const char *error_name, u32 value)
+{ return 0; }
 #endif
 
 #endif
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 218a3ee86805..eab8231aa87c 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -38,13 +38,28 @@ enum {
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
+
+	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+	DRM_RAS_CMD_ERROR_EVENT,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
 };
 
+#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
+
 #endif /* _UAPI_LINUX_DRM_RAS_H */
-- 
2.47.1

