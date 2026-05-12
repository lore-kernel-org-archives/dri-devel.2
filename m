Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAEACD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7DA10EBFE;
	Tue, 12 May 2026 19:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dhRDNJWP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1215910EC01;
 Tue, 12 May 2026 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778613605; x=1810149605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s1xkS6WKIbaPetco3InzMtS2OD6rKec/rRDjpQbWFTE=;
 b=dhRDNJWPVuMVqUPbODU0jNPU8ZrSPgA25ws7VpmuL/G29eT69Nx2bRD/
 BpAJfnXSwR9xk0Lg4A5Gu5WUK/rWuO9C4fNKqm6cRsy8ptqbjtuiS+AvA
 gezbOLr496CU2qJniZ5KUnEi7QuwVnmlTo+hYvKTOGwB1CSnDHIifZ+Es
 4iIVSpZ3whgyxFO6KMQLyZsMcbGqz04CFghLcQqicupSuLfTUhodsUJ88
 9JRxpQXrnlGG2tnWFQdySinZooORH8VTY53hG/JWP11Yz9WS3KpqQG0iW
 5rs1AF7u9IXYieO5Dk5hMOpmXMgq3ocpFjOiCEDsExRcy0J1sLE27sbSr w==;
X-CSE-ConnectionGUID: 6JW3Lp2ZTq+SPM+0Gp2ceQ==
X-CSE-MsgGUID: CNtjcOw/Qya6++ELVlqzJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406403"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="83406403"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 12:20:04 -0700
X-CSE-ConnectionGUID: kGvkav1yRn2w8FNr1DA/Mw==
X-CSE-MsgGUID: iTn6FfMmSVuDdAD4C/8ODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237781490"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:19:59 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, anoop.c.vijay@intel.com,
 aravind.iddamsetty@linux.intel.com, Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 3/9] drm/ras: Introduce set-error-threshold
Date: Wed, 13 May 2026 00:46:04 +0530
Message-ID: <20260512191610.1817578-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512191610.1817578-1-raag.jadav@intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
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

Add set-error-threshold command support which allows setting threshold
value of the error. Threshold in RAS context means the number of errors
the hardware is expected to accumulate before it raises them to software.
This is to have a fine grained control over error notifications that are
raised by the hardware.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Document threshold value bounds checking responsibility (Riana)
---
 Documentation/gpu/drm-ras.rst            |  9 +++++
 Documentation/netlink/specs/drm_ras.yaml | 12 ++++++
 drivers/gpu/drm/drm_ras.c                | 51 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             | 14 +++++++
 drivers/gpu/drm/drm_ras_nl.h             |  2 +
 include/drm/drm_ras.h                    | 14 +++++++
 include/uapi/drm/drm_ras.h               |  1 +
 7 files changed, 103 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index dfa72e8becda..07a33d16bad9 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -56,6 +56,8 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Query specific error threshold value with the ``get-error-threshold`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Set specific error threshold value with the ``set-error-threshold`` command, using
+  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
 
 YAML-based Interface
 --------------------
@@ -118,3 +120,10 @@ Example: Query threshold value of a given error
 
     sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
     {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
+
+Example: Set threshold value of a given error
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
+    None
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 016d713069bb..ba7e0a944e7d 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -148,3 +148,15 @@ operations:
             - error-id
             - error-name
             - error-threshold
+    -
+      name: set-error-threshold
+      doc: >-
+           Set threshold value of an error.
+      attribute-set: error-counter-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+            - error-id
+            - error-threshold
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 87e57bd1e8ad..f351147489ca 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -45,6 +45,9 @@
  *    Userspace must provide Node ID and Error ID.
  *    Returns the threshold value of a specific error.
  *
+ * 5. SET_ERROR_THRESHOLD: Set threshold value of an error.
+ *    Userspace must provide Node ID, Error ID and threshold value to be set.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -78,6 +81,8 @@
  *   operation, clearing a counter value from a specific node.
  * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
  *   operation, fetching the threshold value of a specific error.
+ * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
+ *   operation, setting the threshold value of a specific error.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -193,6 +198,24 @@ static int get_node_error_threshold(u32 node_id, u32 error_id,
 	return node->query_error_threshold(node, error_id, name, value);
 }
 
+static int set_node_error_threshold(u32 node_id, u32 error_id, u32 value)
+{
+	struct drm_ras_node *node;
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node)
+		return -ENOENT;
+
+	if (!node->set_error_threshold)
+		return -EOPNOTSUPP;
+
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->set_error_threshold(node, error_id, value);
+}
+
 static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
 				   const char *error_name, u32 value)
 {
@@ -464,6 +487,34 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 	return doit_reply_threshold_value(info, node_id, error_id);
 }
 
+/**
+ * drm_ras_nl_set_error_threshold_doit() - Set threshold value of an error
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the Node ID, Error ID and threshold value from the netlink attributes
+ * and sets the threshold of the corresponding error.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info)
+{
+	u32 node_id, error_id, value;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
+	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
+	value = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
+
+	return set_node_error_threshold(node_id, error_id, value);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index ecec2041c758..02e8e5054d05 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -34,6 +34,13 @@ static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
+static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -69,6 +76,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+		.doit		= drm_ras_nl_set_error_threshold_doit,
+		.policy		= drm_ras_set_error_threshold_nl_policy,
+		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family drm_ras_nl_family __ro_after_init = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 399280c2c6e1..57b1e647d833 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -22,6 +22,8 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
 int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info);
 
 extern struct genl_family drm_ras_nl_family;
 
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 7bb429d85f57..134e20a16abc 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -83,6 +83,20 @@ struct drm_ras_node {
 	 */
 	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
 				     const char **name, u32 *val);
+	/**
+	 * @set_error_threshold:
+	 *
+	 * This callback is used by drm-ras to set threshold value of a specific
+	 * error.
+	 *
+	 * Driver should expect set_error_threshold() to be called with error_id
+	 * from `error_counter_range.first` to `error_counter_range.last`.
+	 * Driver is responsible for threshold value bounds checking.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id,
+				   u32 val);
 
 	/** @priv: Driver private data */
 	void *priv;
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 59530f987ba2..27c68956495f 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -44,6 +44,7 @@ enum {
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
 	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0

