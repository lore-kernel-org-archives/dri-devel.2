Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68802CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51AF10E11A;
	Fri,  9 Oct 2026 17:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OrFbKr7v";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952D010E11A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:36:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZwO82471179; Fri, 9 Oct 2026 17:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kC1+SWRw5Bt
 +D1asGSDsXm1gAGcyZOCRTrD68Xf3QXU=; b=OrFbKr7v5XIBc5Gme1E4Eg+75Tl
 QMqm3wPmaLMepkyhWFkU4h3z8+n49y2CGaLFaTEW5EyTVEj/iKWCzzh/N0tDTgyz
 fG90HBOBCQHt0SXAokcVeRf2LA4MouG8oSGWLlcGdIKo+9XXWSdz0Tz+/l1Deh5A
 oq/zdAr/4tyGqyqbel0HXfsDLufaRBMrFMHJVz/IHtFT0YAdZeD1i0HK48gXwWMa
 hdPDxI9YNQNN2AVxFInmvvjIo5yhOIoIn9lIr0vd4XGxkKrb9UYZTAfH/gmV2gkw
 SMsdlzYXfxLqOcKWLlDSf2Ta78Yg0LYU9P6TK3WnyQGAWtgt4wXWNaw9lLA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8g03s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 17:36:38 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZALs1157166; Fri, 9 Oct 2026 17:35:10 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 699HZ9wF1157126
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 17:35:10 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id C5EFE229F7; Fri,  9 Oct 2026 10:35:09 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Date: Fri,  9 Oct 2026 10:31:51 -0700
Message-ID: <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=ONOyTiaB c=1 sm=1 tr=0 ts=6ac92626 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=lvw0CApv9O1bdv8pmMwA:9
X-Proofpoint-GUID: jfYjjVZuH73mvXjj0EzkjonsHmCT9eDE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MCBTYWx0ZWRfXyTr8rFVSvCpa
 j58mzcrwKP+8pvDVz+Q9b/n1MIH7LhBuhcJrCfUfU5RGOG503ukWUJwauV+lrhZIBZjLn3wGKJF
 6DLlcVE5pjknvdb/3hshLVtZlUd5CNw=
X-Proofpoint-ORIG-GUID: jfYjjVZuH73mvXjj0EzkjonsHmCT9eDE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MCBTYWx0ZWRfX730qTR3vJKI2
 7lYpxff4qbWSjGpO0AbMT3oRJ5pQikZ9Bc5/RnRDADLCP/AEX5VB5gzMfzD3HayHwgNYMw+dE2i
 UNoPtV8zdPYlseV9JumYDWpFzKF31NREOgHEWYlpvhzt5YOTiF5+O4LaUFXpsWhUmK0XvzGpEaL
 6tDIqgOat7I3zj/Sbi0RAh6YZe9spOjJNeTC710W+fidpbD0m3WG+JspcddcaTxXKis8wLEGG4c
 8bBCdE6Mph7qirQGuyoca4WH6eLPEaHSdTqbGX4+MXrz1PS70aUbHImS4YaRPgDYw+DxsU9IS3p
 OY/m8cXjBi8nX5R5ZJ8Jz1SEGWCRhTL/DzCZ1QJPhMN6u2A8lCtB/Cd66l5Z8xTWwOI8b/pjv3e
 eD0K9SZFjVXPGOgMgQz+wMYn/xOednIsL6NIEsVl95Ft79DM/hZhCAVx8MQWw4SDiz8dlYanAgU
 QwT/FueCpdTYVax1HFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090070
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

Add a new node type, attribute set, and doit function for performing
telemetry read and write operations using the DRM RAS interface.

Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 Documentation/netlink/specs/drm_ras.yaml |  55 ++++++-
 drivers/gpu/drm/drm_ras.c                | 193 ++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  29 ++++
 drivers/gpu/drm/drm_ras_nl.h             |   6 +
 include/drm/drm_ras.h                    |  39 +++++
 include/uapi/drm/drm_ras.h               |  14 ++
 6 files changed, 327 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index a88fdab7a1c7..d558eb1cba3f 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -16,7 +16,7 @@ definitions:
     type: enum
     name: node-type
     value-start: 1
-    entries: [error-counter]
+    entries: [error-counter, telemetry]
     doc: >-
          Type of the node. Currently, only error-counter nodes are
          supported, which expose reliability counters for a hardware/software
@@ -100,6 +100,31 @@ attribute-sets:
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
+        name: value
+        type: u64
+        doc: Value of telemetry field that was read/written.
+      -
+        name: status
+        type: s32
+        doc: Status of the telemetry operation.
+      -
+        name: pad
+        type: pad
+        doc: Alignment padding used for 64-bit
 
 operations:
   list:
@@ -198,6 +223,34 @@ operations:
             - node-id
             - error-id
             - error-threshold
+    -
+      name: telemetry-read
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
+    -
+      name: telemetry-write
+      doc: Perform a write of the specified telemetry field.
+      attribute-set: telemetry-attrs
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
 
 mcast-groups:
   list:
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b099eb67836e..b88293295cda 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -53,6 +53,15 @@
  * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
  *    Userspace must provide Node ID, Error ID and threshold to be set.
  *
+ * 8. TELEMETRY_READ: Read a telemetry value.
+ *    Userspace must provide Node ID and telemetry field to be read.
+ *    Returns the status of the read and the value read (if valid).
+ *
+ * 9. TELEMETRY_WRITE: Write a telemetry value.
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
@@ -81,6 +89,12 @@
  *       that are raised by the hardware.
  *     + The driver is responsible for error threshold bounds checking.
  *
+ * - TELEMETRY:
+ *     + The driver must implement the telemetry_read() and telemetry_write()
+ *       callbacks.
+ *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
+ *       to enforce permissions checks on telemetry operations.
+ *
  * Netlink handlers:
  *
  * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
@@ -95,6 +109,12 @@
  *   operation, fetching the error threshold of a specific counter.
  * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
  *   operation, setting the error threshold of a specific counter.
+ * - drm_ras_nl_pre_telemetry(): Implements the TELEMETRY_READ and TELEMETRY_WRITE
+ *   pre_doit operation, returning 0 if valid.
+ * - drm_ras_nl_telemetry_read_doit(): Implements the TELEMETRY_READ doit operation,
+ *   invoking the driver's telemetry_read callback and returning the results.
+ * - drm_ras_nl_telemetry_write_doit(): Implements the TELEMETRY_WRITE doit operation,
+ *   invoking the driver's telemetry_write callback and returning the results.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -617,6 +637,156 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
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
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+	node = xa_load(&drm_ras_xa, node_id);
+
+	if (node->telemetry_pre)
+		return node->telemetry_pre(node);
+
+	return 0;
+}
+
+/**
+ * drm_ras_nl_telemetry_read_doit() - Query a telemetry value
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the telemetry field from the netlink attributes and
+ * reads that value from the device.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	u32 node_id, field;
+	s32 status;
+	u64 value;
+	int ret;
+
+	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
+		return -EINVAL;
+
+	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->telemetry_read)
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
+	ret = node->telemetry_read(node, &field, &value, &status);
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
+	ret = nla_put_64bit(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, sizeof(value),
+			    &value, DRM_RAS_A_TELEMETRY_ATTRS_PAD);
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
+ * drm_ras_nl_telemetry_write_doit() - Write a telemetry value
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the telemetry field and value to be written from the netlink
+ * attributes and writes that value to the specified field on the device.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	u32 node_id, field;
+	s32 status;
+	u64 value;
+	int ret;
+
+	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
+		return -EINVAL;
+
+	value = nla_get_u64(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
+	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->telemetry_read)
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
+	ret = node->telemetry_write(node, &field, &value, &status);
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
@@ -631,14 +801,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
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
+		/* Mandatory entries for Telemetry Node */
+		if (!node->telemetry_read || !node->telemetry_write)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
 }
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index ff0dc406c27c..4577bc1a333e 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -41,6 +41,19 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_TELEMETRY_READ - do */
+static const struct nla_policy drm_ras_telemetry_read_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
+};
+
+/* DRM_RAS_CMD_TELEMETRY_WRITE - do */
+static const struct nla_policy drm_ras_telemetry_write_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_U64, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -83,6 +96,22 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_READ,
+		.pre_doit	= drm_ras_nl_pre_telemetry,
+		.doit		= drm_ras_nl_telemetry_read_doit,
+		.policy		= drm_ras_telemetry_read_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_WRITE,
+		.pre_doit	= drm_ras_nl_pre_telemetry,
+		.doit		= drm_ras_nl_telemetry_write_doit,
+		.policy		= drm_ras_telemetry_write_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 9aef097ea10f..4bdd7ed268a1 100644
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
@@ -24,6 +27,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
 int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb,
+				    struct genl_info *info);
 
 enum {
 	DRM_RAS_NLGRP_ERROR_REPORT,
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 1765a3130b09..2a2cdd44839d 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -100,6 +100,45 @@ struct drm_ras_node {
 	 */
 	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
 
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
+	 * @telemetry_read:
+	 *
+	 * This callback is used for a drm-ras telemetry node to read a
+	 * telemetry value. This is a mandatory callback for telemetry_node.
+	 *
+	 * The callback will read the desired device-specific field into value
+	 * and update status corresponding to a device-specific error code.
+	 *
+	 * Returns 0 on success, negative error code on failure.
+	 */
+	int (*telemetry_read)(struct drm_ras_node *ep, u32 *field, u64 *value,
+			      s32 *status);
+
+	/**
+	 * @telemetry_write:
+	 *
+	 * This callback is used for a drm-ras telemetry node to write a
+	 * telemetry value. This is a mandatory callback for telemetry_node.
+	 *
+	 * The callback will write the value to the desired device-specific
+	 * field and update status corresponding to a device-specific error
+	 * code.
+	 *
+	 * Returns 0 on success, negative error code on failure.
+	 */
+	int (*telemetry_write)(struct drm_ras_node *ep, u32 *field, u64 *value,
+			       s32 *status);
+
 	/** @priv: Driver private data */
 	void *priv;
 };
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 2f832275ee6e..d39c78a9ed5a 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -16,6 +16,7 @@
  */
 enum drm_ras_node_type {
 	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
+	DRM_RAS_NODE_TYPE_TELEMETRY,
 };
 
 enum {
@@ -51,6 +52,17 @@ enum {
 	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
+	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
+	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
+	DRM_RAS_A_TELEMETRY_ATTRS_PAD,
+
+	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
+	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -58,6 +70,8 @@ enum {
 	DRM_RAS_CMD_ERROR_EVENT,
 	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
 	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_TELEMETRY_READ,
+	DRM_RAS_CMD_TELEMETRY_WRITE,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0

