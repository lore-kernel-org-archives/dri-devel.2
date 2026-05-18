Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10F3CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0289110E7AA;
	Mon, 18 May 2026 10:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ma9BCzgv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A065510E7AA;
 Mon, 18 May 2026 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779101268; x=1810637268;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z7GDOEL9xgB5CG2t9gdtRCqN59Azz1oSXFr7RgGNboE=;
 b=Ma9BCzgvlrqKGFu9Pv8Tev76UaARqMoZKMa1zOclVf7fhMJ03xNbaKLx
 2G5vfcn8gWgScOA4Wh8PgRGYC8imfcQfSQbtBhtI3ilOFXIU7yi7ZrUQ/
 OC1gkCP/pvyvViUbSXtX+gDGi5KXn42Y4hEKVGqwib4ph2VEtIioLFFPX
 Dtn8V65neal/2bYYE608oVo71+TZRRPd2IXv+iEOKuSarFxFIiQTVJ9Ly
 axTIevvDgSXr4T7hCztrwsZmfUYRYLy6U2ZIz22tCg3UjERIuNS74LWEB
 pAVbCmjd8XdW4+b2HfzFJ55j1PSw0FH714E8Dk20dsZQZbG1GgfaOkfIw g==;
X-CSE-ConnectionGUID: WdtXYrZyQGCxf6u+QQwdzg==
X-CSE-MsgGUID: QXAKZ4CDT9e+gHo6CvAmeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79802396"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="79802396"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 03:47:47 -0700
X-CSE-ConnectionGUID: zSOBEullSgGKECFM2bsU/Q==
X-CSE-MsgGUID: sxmE36U8T0CMjJzQg6cZ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="243688525"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 03:47:40 -0700
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
Subject: [PATCH 1/2] drm/drm_ras: Add drm_ras netlink error event
Date: Mon, 18 May 2026 16:50:50 +0530
Message-ID: <20260518112048.1746280-5-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260518112048.1746280-4-riana.tauro@intel.com>
References: <20260518112048.1746280-4-riana.tauro@intel.com>
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
'error-notify' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Userspace must subscribe to 'error-notify' to receive 'error-event'
notifications.

Usage:

    $ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras \
      --subscribe error-notify

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 50 ++++++++++++++
 drivers/gpu/drm/drm_ras.c                | 86 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 +++++
 7 files changed, 187 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 83c21853b74b..5a96dde75539 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -56,6 +56,7 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Clear specific error counters with the ``clear-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Subscribe to the ``error-notify`` multicast group to receive ``error-event`` notifications.
 
 YAML-based Interface
 --------------------
@@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
 
     sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
     None
+
+Example: Subscribe to ``error-notify`` multicast group
+
+.. code-block:: bash
+
+    sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --output-json --subscribe error-notify
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
index e113056f8c01..d94c73a61aea 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -69,6 +69,35 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the requested error counter.
+  -
+    name: error-event-attrs
+    attributes:
+      -
+        name: device-name
+        type: string
+        doc: >-
+             Device name chosen by the driver at registration.
+             Can be a PCI BDF, UUID, or module name if unique.
+      -
+        name: node-id
+        type: u32
+        doc: Node ID of the node that triggered the event.
+      -
+        name: node-name
+        type: string
+        doc: Node name of the node that triggered the event.
+      -
+        name: error-id
+        type: u32
+        doc: Error ID of the counter that triggered the event.
+      -
+        name: error-name
+        type: string
+        doc: Name of the error that triggered the event.
+      -
+        name: error-value
+        type: u32
+        doc: Current value of the error counter.
 
 operations:
   list:
@@ -124,3 +153,24 @@ operations:
       do:
         request:
           attributes: *id-attrs
+    -
+      name: error-event
+      doc: >-
+           Notify userspace of an error event.
+           The event includes the device, node and error information
+           of the error that triggered the event.
+      attribute-set: error-event-attrs
+      mcgrp: error-notify
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
+      name: error-notify
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..6696ec21782e 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,11 @@
  *    Userspace must provide Node ID, Error ID.
  *    Clears specific error counter of a node if supported.
  *
+ * 4. ERROR_NOTIFY: Subscribe to this multicast group to receive error events
+ *
+ * 5. ERROR_EVENT: Notify userspace of an error event. The event contains device, node
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
@@ -222,6 +255,59 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	return genlmsg_reply(msg, info);
 }
 
+/**
+ * drm_ras_nl_error_event() - Notify listeners of an error event
+ * @node: Node structure
+ * @error_id: ID of the error
+ * @error_name: Name of the error
+ * @value: Value associated with the error
+ * @flags: GFP flags for memory allocation
+ *
+ * Sends a notification to all listeners about an error event on a specific
+ * RAS node.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value, gfp_t flags)
+{
+	struct genl_info info;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int err = -EMSGSIZE;
+
+	if (!error_name)
+		return -EINVAL;
+
+	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_NOTIFY))
+		return 0;
+
+	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, &info);
+	if (!hdr)
+		goto err_free_msg;
+
+	err = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
+	if (err)
+		goto err_cancel;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_NOTIFY, flags);
+	return 0;
+
+err_cancel:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return err;
+}
+EXPORT_SYMBOL(drm_ras_nl_error_event);
+
 /**
  * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
  * @skb: Netlink message buffer
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index dea1c1b2494e..ac724bb87a3b 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 	},
 };
 
+static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
+	[DRM_RAS_NLGRP_ERROR_NOTIFY] = { "error-notify", },
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
index a398643572a5..17e1af8cc3b3 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
 
+enum {
+	DRM_RAS_NLGRP_ERROR_NOTIFY,
+};
+
 extern struct genl_family drm_ras_nl_family;
 
 #endif /* _LINUX_DRM_RAS_GEN_H */
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index f2a787bc4f64..d4a275efdbb0 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -78,9 +78,14 @@ struct drm_device;
 #if IS_ENABLED(CONFIG_DRM_RAS)
 int drm_ras_node_register(struct drm_ras_node *node);
 void drm_ras_node_unregister(struct drm_ras_node *node);
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value, gfp_t flags);
 #else
 static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
 static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
+static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
+					 const char *error_name, u32 value, gfp_t flags)
+{ return 0; }
 #endif
 
 #endif
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 218a3ee86805..bb2a8a872a44 100644
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
 
+#define DRM_RAS_MCGRP_ERROR_NOTIFY	"error-notify"
+
 #endif /* _UAPI_LINUX_DRM_RAS_H */
-- 
2.47.1

