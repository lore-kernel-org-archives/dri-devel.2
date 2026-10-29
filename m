Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4271606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=inGkQ490
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8F810E1A4;
	Thu, 29 Oct 2026 20:30:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B87112504
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:30:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjV1o164467; Thu, 29 Oct 2026 20:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1OxeAHfEm/O
 STO21pdPVecxU5mMVtt1kmWJWwX8MPaQ=; b=inGkQ490NvWceIrA5sif055z7CE
 JhhMvEFm8Wzh4o1ybZDwksZOcfhxGxxWnUasvVNtOCTj8vhgM0r8l5Q3rYLKiTOD
 YMdvxBh/IB8dw/TbUn4DvNGWZY0i7MpKeWhCSCmeUWdT99RXbkt6hl40x9RW5Kke
 gT/BirXA0OSpGYLT5huTOZtwcvn2hDA1e9AsVtb1jJfdyg7czEQnpyRlxtEeH0DW
 H6cfdBC5xyxPl7zul8lB3mp9AlJndLKwJxdtjkT7r6U0/1M6FE8bklVUqJE3uoVt
 +o2gOaBazeg4VKDqBBiB27D9Dic/T6dHFp+K/j2UPMix9+ZmKiU8K93BAWA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76220s6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TKUE6h2808200; Thu, 29 Oct 2026 20:30:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69TKUD6o2808182
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id D790524DF0; Thu, 29 Oct 2026 13:30:13 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v2 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Date: Thu, 29 Oct 2026 13:29:59 -0700
Message-ID: <20261029203000.1763447-3-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: Q8D8OF2w6XjeiJA_F4OehGov1QI7NQNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfX0gnrSxfxhuts
 9wunkNz3hORaJz4PdU6Krgesr6mJcV+HF4eWx/XgaVWFx1gs2Rk39ImDAMs8QktRiW7SUo4Nf5/
 tUCuhoD8+RTt1bqTJSR/jszCcERbTI5D7eyOIFq+xVuF55DYilqUSavmYPyPCBIsqZfrUSBFQ5I
 QAxPzLWH7t1gjRT7IGLCTPEzSuW3yowGbLVAooMCJTdDJ0GS3c9iHXwaYs1wTgIwWAK8UswM4x2
 YJyEKsLoMT3mZPHAWxveImiDZg7UZRh5EgGkNcJuGLzkfwWW6iVrxXNFBHNa5/zODknif6hJotG
 CuecUH1EIaTvPZ44e2irCmPm9ItAvVhT305Gdz88VtazaGj0R4YC3wFBj+HNdgsy1x0Hea88nMk
 xgTVYPORvp6PchxXFq03KAyaVzV1XqDFyYZrllxmxH65eFFoKvITx/dt9ja67+Wbs1oXHzB/anQ
 nydw36bk8wS4bfdNdCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfX0W+i4Q4epwJr
 mJEOxaBrmaEMLeYaIZnn9VCK+Mqx0LVw3jfmQCMjx9M2IQxevxj4/lpRazLc/cths1cxa8//mDs
 V9Lf1Z/0klgWPZ9/AXCqqsDTCCM0Yjs=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae3acd7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=W1Vb1946TJxexewSvWYA:9
X-Proofpoint-GUID: Q8D8OF2w6XjeiJA_F4OehGov1QI7NQNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290080
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new node type, attribute set, and doit/dump functions for
performing telemetry read and write operations using the DRM RAS
interface.

ynl-regen.sh was used to regenerate drm_ras_nl.c, drm_ras_nl.h, and
include/uapi/drm/drm_ras.h from the drm_ras.yaml spec.

Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 Documentation/netlink/specs/drm_ras.yaml |  82 +++++-
 drivers/gpu/drm/drm_ras.c                | 308 ++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  53 ++++
 drivers/gpu/drm/drm_ras_nl.h             |   9 +
 include/drm/drm_ras.h                    |  57 +++++
 include/uapi/drm/drm_ras.h               |  19 +-
 6 files changed, 514 insertions(+), 14 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index a88fdab7a1c7..a02aaed8772f 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -16,11 +16,11 @@ definitions:
     type: enum
     name: node-type
     value-start: 1
-    entries: [error-counter]
+    entries: [error-counter, telemetry]
     doc: >-
-         Type of the node. Currently, only error-counter nodes are
-         supported, which expose reliability counters for a hardware/software
-         component.
+         Type of the node. The error-counter nodes expose reliability counters
+         for a hardware/software component, and telemetry nodes expose an
+         interface for reading and writing telemetry values to a device.
 
 attribute-sets:
   -
@@ -100,6 +100,34 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the error counter.
+  -
+    name: telemetry-attrs
+    attributes:
+      -
+        name: node-id
+        type: u32
+        doc: >-
+             Unique identifier for the node.
+             Assigned dynamically by the DRM RAS core upon registration.
+      -
+        name: field
+        type: u32
+        doc:  Telemetry field to be read/written, e.g., SoC temp.
+      -
+        name: field-name
+        type: string
+        doc:  Name of the telemetry field defined by the device's uapi.
+      -
+        name: value
+        type: sint
+        doc: Value of telemetry field that was read/written.
+      -
+        name: status
+        type: s32
+        doc: >-
+             Status of the telemetry operation.
+             Populated by the device in response to the performed
+             telemetry operation. Errors may be hardware specific.
 
 operations:
   list:
@@ -198,6 +226,52 @@ operations:
             - node-id
             - error-id
             - error-threshold
+    -
+      name: telemetry-get
+      doc: Perform a read of the specified telemetry field.
+      attribute-set: telemetry-attrs
+      do:
+        pre: drm-ras-nl-pre-telemetry
+        request:
+          attributes:
+            - node-id
+            - field
+        reply:
+          attributes:
+            - value
+            - status
+      dump:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes: &telemetry-field-attrs
+            - field
+            - field-name
+    -
+      name: telemetry-set
+      doc: >-
+           Perform a write of the specified telemetry field.
+           Telemetry writes are device specific, and may be used to set
+           device limits or other capacities, for example.
+      attribute-set: telemetry-attrs
+      flags: [admin-perm]
+      do:
+        pre: drm-ras-nl-pre-telemetry
+        request:
+          attributes:
+            - node-id
+            - field
+            - value
+        reply:
+          attributes:
+            - status
+      dump:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes: *telemetry-field-attrs
 
 mcast-groups:
   list:
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 4f4777060a4e..5b9c00f28834 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -53,6 +53,15 @@
  * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
  *    Userspace must provide Node ID, Error ID and threshold to be set.
  *
+ * 8. TELEMETRY_GET: Read a telemetry value.
+ *    Userspace must provide Node ID and telemetry field to be read.
+ *    Returns the status of the read and the value read (if valid).
+ *
+ * 9. TELEMETRY_SET: Write a telemetry value.
+ *    Userspace must provide Node ID, the telemetry field to write, and the value
+ *    to be written.
+ *    Returns the status of the write.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -63,7 +72,6 @@
  * Node type:
  *
  * - ERROR_COUNTER:
- *     + Currently, only error counters are supported.
  *     + The driver must implement the query_error_counter() callback to provide
  *       the name and the value of the error counter.
  *     + The driver must provide a error_counter_range.last value informing the
@@ -81,6 +89,15 @@
  *       that are raised by the hardware.
  *     + The driver is responsible for error threshold bounds checking.
  *
+ * - TELEMETRY:
+ *     + The driver must implement the telemetry_get() callbacks, telemetry_set()
+ *       is optional.
+ *     + The driver must provide a list of gettable telemetry fields corresponding
+ *       to their uAPI definitions and values. Settable telemetry fields are also
+ *       required if providing telemetry_set().
+ *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
+ *       to enforce permissions checks on telemetry operations.
+ *
  * Netlink handlers:
  *
  * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
@@ -95,6 +112,16 @@
  *   operation, fetching the error threshold of a specific counter.
  * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
  *   operation, setting the error threshold of a specific counter.
+ * - drm_ras_nl_pre_telemetry(): Implements the TELEMETRY_READ and TELEMETRY_WRITE
+ *   pre_doit operation, returning 0 if valid.
+ * - drm_ras_nl_telemetry_get_dumpit(): Implements the TELEMETRY_GET dumpit
+ *   operation, fetching all readable telemetry values for a telemetry node.
+ * - drm_ras_nl_telemetry_get_doit(): Implements the TELEMETRY_GET doit operation,
+ *   invoking the driver's telemetry_get callback and returning the results.
+ * - drm_ras_nl_telemetry_set_dumpit(): Implements the TELEMETRY_SET dumpit
+ *   operation, fetching all writeable telemetry values for a telemetry node.
+ * - drm_ras_nl_telemetry_set_doit(): Implements the TELEMETRY_SET doit operation,
+ *   invoking the driver's telemetry_set callback and returning the results.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -617,6 +644,264 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	return set_node_error_threshold(node_id, error_id, threshold);
 }
 
+/**
+ * drm_ras_nl_pre_telemetry - Enforce permission checks
+ * @ops: Generic netlink operations
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Enforces a telemetry node's pre_doit conditions (if they exist).
+ *
+ * Returns 0 if no pre_doit is specified, otherwise returns the pre_doit.
+ */
+int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
+			     struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	u32 node_id;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node)
+		return -ENOENT;
+
+	if (node->telemetry_pre)
+		return node->telemetry_pre(node);
+
+	return 0;
+}
+
+static int telemetry_fields_dumpit(struct sk_buff *skb, struct netlink_callback *cb,
+				   const struct drm_ras_telemetry_field *fields)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_ctx *ctx = (void *)cb->ctx;
+	const struct drm_ras_telemetry_field *field;
+	struct nlattr *hdr;
+	unsigned long idx;
+	int ret = 0;
+
+	if (!fields)
+		return -EOPNOTSUPP;
+
+	for (idx = ctx->restart; fields[idx].name; idx++) {
+		field = &fields[idx];
+
+		hdr = genlmsg_iput(skb, info);
+		if (!hdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+
+		ret = nla_put_u32(skb, DRM_RAS_A_TELEMETRY_ATTRS_FIELD, field->value);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			break;
+		}
+
+		ret = nla_put_string(skb, DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME, field->name);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			break;
+		}
+
+		genlmsg_end(skb, hdr);
+	}
+
+	if (ret == -EMSGSIZE)
+		ctx->restart = idx;
+
+	return ret;
+}
+
+/**
+ * drm_ras_nl_telemetry_get_dumpit() - Dump readable telemetry fields.
+ * @skb: Netlink message buffer
+ * @cb: Callback context for multi-part dumps
+ *
+ * Displays the set of readable telemetry fields that is specified by
+ * the device for the given node.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_telemetry_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_node *node;
+	u32 node_id;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node)
+		return -ENOENT;
+
+	return telemetry_fields_dumpit(skb, cb, node->telemetry_fields_gettable);
+}
+
+/**
+ * drm_ras_nl_telemetry_get_doit() - Query a telemetry value
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the telemetry field from the netlink attributes and
+ * reads that value from the device.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	u32 node_id, field;
+	s32 status = 0;
+	s64 value = 0;
+	int ret = 0;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
+		return -EINVAL;
+
+	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->telemetry_get)
+		return -ENOENT;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	ret = node->telemetry_get(node, &field, &value, &status);
+	if (ret) {
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	ret = nla_put_sint(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, value);
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
+/**
+ * drm_ras_nl_telemetry_set_dumpit() - Dump writeable telemetry fields.
+ * @skb: Netlink message buffer
+ * @cb: Callback context for multi-part dumps
+ *
+ * Displays the set of writeable telemetry fields that is specified by
+ * the device for the given node.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_telemetry_set_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_node *node;
+	u32 node_id;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node)
+		return -ENOENT;
+
+	return telemetry_fields_dumpit(skb, cb, node->telemetry_fields_settable);
+}
+
+/**
+ * drm_ras_nl_telemetry_set_doit() - Write a telemetry value
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the telemetry field and value to be written from the netlink
+ * attributes and writes that value to the specified field on the device.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	u32 node_id, field;
+	s32 status = 0;
+	s64 value = 0;
+	int ret = 0;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_VALUE) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
+		return -EINVAL;
+
+	value = nla_get_sint(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
+	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->telemetry_set)
+		return -ENOENT;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	ret = node->telemetry_set(node, &field, &value, &status);
+	if (ret) {
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
@@ -631,14 +916,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	if (!node->device_name || !node->node_name)
 		return -EINVAL;
 
-	/* Currently, only Error Counter Endpoints are supported */
-	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
-		return -EINVAL;
-
-	/* Mandatory entries for Error Counter Node */
-	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
-	    (!node->error_counter_range.last || !node->query_error_counter))
+	/* Currently, only Error Counter and Telemetry endpoints are supported */
+	switch (node->type) {
+	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
+		/* Mandatory entries for Error Counter Node */
+		if (!node->error_counter_range.last || !node->query_error_counter)
+			return -EINVAL;
+		break;
+	case DRM_RAS_NODE_TYPE_TELEMETRY:
+		/* Must provide telemetry_get, telemetry_set is optional */
+		if (!node->telemetry_get || !node->telemetry_fields_gettable)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
 }
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index ff0dc406c27c..19e3683fb35a 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -41,6 +41,29 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_TELEMETRY_GET - do */
+static const struct nla_policy drm_ras_telemetry_get_do_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
+};
+
+/* DRM_RAS_CMD_TELEMETRY_GET - dump */
+static const struct nla_policy drm_ras_telemetry_get_dump_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_RAS_CMD_TELEMETRY_SET - do */
+static const struct nla_policy drm_ras_telemetry_set_do_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_SINT, },
+};
+
+/* DRM_RAS_CMD_TELEMETRY_SET - dump */
+static const struct nla_policy drm_ras_telemetry_set_dump_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -83,6 +106,36 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_GET,
+		.pre_doit	= drm_ras_nl_pre_telemetry,
+		.doit		= drm_ras_nl_telemetry_get_doit,
+		.policy		= drm_ras_telemetry_get_do_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_GET,
+		.dumpit		= drm_ras_nl_telemetry_get_dumpit,
+		.policy		= drm_ras_telemetry_get_dump_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_SET,
+		.pre_doit	= drm_ras_nl_pre_telemetry,
+		.doit		= drm_ras_nl_telemetry_set_doit,
+		.policy		= drm_ras_telemetry_set_do_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_SET,
+		.dumpit		= drm_ras_nl_telemetry_set_dumpit,
+		.policy		= drm_ras_telemetry_set_dump_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 9aef097ea10f..ad3b28f2d809 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -12,6 +12,9 @@
 
 #include <uapi/drm/drm_ras.h>
 
+int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
+			     struct sk_buff *skb, struct genl_info *info);
+
 int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb);
 int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
@@ -24,6 +27,12 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
 int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_ras_nl_telemetry_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
+int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_ras_nl_telemetry_set_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
 
 enum {
 	DRM_RAS_NLGRP_ERROR_REPORT,
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 1765a3130b09..fb10238999dd 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -10,6 +10,16 @@
 
 #include <uapi/drm/drm_ras.h>
 
+/**
+ * struct drm_ras_telemetry_field - A descriptor of a telemetry field.
+ */
+struct drm_ras_telemetry_field {
+	/** @name: The enum or macro name defined by the device uAPI. */
+	const char *name;
+	/** @field: The numerical value of the field. */
+	u32 value;
+};
+
 /**
  * struct drm_ras_node - A DRM RAS Node
  */
@@ -100,6 +110,53 @@ struct drm_ras_node {
 	 */
 	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
 
+	/* Telemetry Related Callback and Variables */
+
+	/** @telemetry_fields_gettable: A list of gettable telemetry fields for a device. */
+	const struct drm_ras_telemetry_field *telemetry_fields_gettable;
+
+	/** @telemetry_fields_settable: A list of settable telemetry fields for a device. */
+	const struct drm_ras_telemetry_field *telemetry_fields_settable;
+
+	/**
+	 * @telemetry_pre:
+	 *
+	 * This callback is used to enforce any pre_doit conditions necessary
+	 * for telemetry. This is an optional callback for telemetry_node.
+	 *
+	 * Returns 0 on success, negative error code on failure.
+	 */
+	int (*telemetry_pre)(struct drm_ras_node *ep);
+
+	/**
+	 * @telemetry_get:
+	 *
+	 * This callback is used for a drm-ras telemetry node to read a
+	 * telemetry value. This is a mandatory callback for telemetry_node.
+	 *
+	 * The callback will read the desired device-specific field into value
+	 * and update status corresponding to a device-specific error code.
+	 *
+	 * Returns 0 on success, negative error code on failure.
+	 */
+	int (*telemetry_get)(struct drm_ras_node *ep, u32 *field, s64 *value,
+			      s32 *status);
+
+	/**
+	 * @telemetry_set:
+	 *
+	 * This callback is used for a drm-ras telemetry node to write a
+	 * telemetry value. This is an optional callback for telemetry_node.
+	 *
+	 * The callback will write the value to the desired device-specific
+	 * field and update status corresponding to a device-specific error
+	 * code.
+	 *
+	 * Returns 0 on success, negative error code on failure.
+	 */
+	int (*telemetry_set)(struct drm_ras_node *ep, u32 *field, s64 *value,
+			       s32 *status);
+
 	/** @priv: Driver private data */
 	void *priv;
 };
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 2f832275ee6e..4776c2f9cb5a 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -11,11 +11,13 @@
 #define DRM_RAS_FAMILY_VERSION	1
 
 /*
- * Type of the node. Currently, only error-counter nodes are supported, which
- * expose reliability counters for a hardware/software component.
+ * Type of the node. The error-counter nodes expose reliability counters for a
+ * hardware/software component, and telemetry nodes expose an interface for
+ * reading and writing telemetry values to a device.
  */
 enum drm_ras_node_type {
 	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
+	DRM_RAS_NODE_TYPE_TELEMETRY,
 };
 
 enum {
@@ -51,6 +53,17 @@ enum {
 	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
+	DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME,
+	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
+	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
+
+	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
+	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -58,6 +71,8 @@ enum {
 	DRM_RAS_CMD_ERROR_EVENT,
 	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
 	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_TELEMETRY_GET,
+	DRM_RAS_CMD_TELEMETRY_SET,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0

