Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CD606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m9vSULud
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C0710E228;
	Tue, 24 Nov 2026 18:02:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2150B10E228
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:02:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFLKUL3267090; Tue, 24 Nov 2026 18:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jQi0ly85mgi
 G1ZzvJTLFCsedvOk5JZ2LOX6xla86Ua0=; b=m9vSULudK2d/+B2gAmPQqhT6wfO
 hSGEaK9w/WpRgIIQXjK5v2mpYiOmyqB9klEptM9l4TmFPWUjpX3ikcK56bsge+A8
 wx/Mhwup9mFD2WmLtrY5/UnPNnI2oLD5DAhn3RaFThBTD4J1mq7urm4h4vlI55eu
 ZQ9xi8wxO7/2cXIF2fZtXLdT44EQ0J5SFcGih8COiTqbtt1CAVWyNhI85KntbJ7S
 57qO1Vc1W4HQBa/qfnntpGVBDOvHsqb3qhhqhJgijvwSbB196UFhMXoSF7woISPa
 4Hh4yYS9CBcTe/syro53vxlEt12Qia+8I0Ttjod+gOyMv9N0U8BA6Mwd4iw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7smyr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 18:01:49 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOHuZbN1010820; Tue, 24 Nov 2026 18:01:48 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6AOI1m8D1018805
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 18:01:48 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id 27D6124DE1; Tue, 24 Nov 2026 10:01:48 -0800 (PST)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v5 3/4] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Date: Tue, 24 Nov 2026 10:01:31 -0800
Message-ID: <20261124180137.616249-4-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180137.616249-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261124180137.616249-1-zachary.mckevitt@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfX+ZkRD2se1enc
 zKwOAdTX1MFvUwSo36P+nKZ8lwCgNbjwSkViFHVWt5v7VAToCtiG276+ekqrHbat+0HFt1DhOUk
 ufbECQIWzUcuwGC3/VU1i7jQSVcEqvY=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b05d10d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=oHV1-ezZ6la7O7pV9k0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfX/zoY7S56uAwj
 h1nXHjuMK0ptFzMH9KEmD/rJvivXVKj2W6Cb6jM2dbZKeRk7S7HRXA2qf+3/kKQrtv3DfitzbwJ
 DtxaUVoJZQB45yJ6iUdCQGTbwHhradPs6mfvioSeFLPBcKmQVOHEkjWN00TfyVuvSK37k7hxn92
 mC+RO9/oObe5jhoMQLyo53QGoNwCbANzo+pNJaqwxsaw8i/VTOEze5HaQQgjdgz8stp9HjCVKOF
 bpgicTXEw/kT9ss7JATd3jBfqVKmtAiCzlpO4Fser/D9NwqGz9BzjHb/JvMC0B9I7kASV7b4mAn
 vuzekjuaJ0VJVG6unVf+g3BGUwgesUpi+24WjFha8OMjW2glDcvWqgkBuyDkBJZd4kWicInB+vl
 hV061Xj1XLqieAdknhyautens5h+huas99vWILd5R0H6LZCv7xG6rRb/9R5pgJjKWbSF+aRW3a9
 AEXFAgZW62LoZyzl3ng==
X-Proofpoint-ORIG-GUID: bbanKbbFu1jeccmfJ65Rozv3m9bBuYNi
X-Proofpoint-GUID: bbanKbbFu1jeccmfJ65Rozv3m9bBuYNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240070
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
performing telemetry operations using the DRM RAS interface.

Introduce telemetry_get and telemetry_set operations for reading and
writing telemetry values. The telemetry_list_fields dump operation
reports the telemetry fields that the driver defines, listing the enum
string, enum value, and read/write mode of each field.

Telemetry get and set operations have associated pre and post doit
functions. The pre-doit will retrieve the specified node from the xarray,
increase its refcount, and store a handle to the node in the request
context. This function will also check for an optional node-specified
telemetry_pre function, which can be used to enforce permission checks,
and ensure that the specified node is a telemetry node type.
This node handle is retrieved from the context in the doit, which ensures
the same node remains pinned across the pre-doit and doit functions. The
post-doit will decrease the refcount for the stashed node.

The telemetry_list_fields callback does not have associated pre and post
doit functions. Instead, it takes and drops the node reference within
each call. This ensures an unfinished dump can't block the wait in
drm_ras_node_unregister().

ynl-regen.sh was used to regenerate drm_ras_nl.c, drm_ras_nl.h, and
include/uapi/drm/drm_ras.h from the drm_ras.yaml spec.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 Documentation/netlink/specs/drm_ras.yaml |  97 +++++-
 drivers/gpu/drm/drm_ras.c                | 374 ++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  43 +++
 drivers/gpu/drm/drm_ras_nl.h             |  10 +
 include/drm/drm_ras.h                    |  82 +++++
 include/uapi/drm/drm_ras.h               |  29 +-
 6 files changed, 619 insertions(+), 16 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index a88fdab7a1c7..0f1ceb705d3d 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -16,11 +16,16 @@ definitions:
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
+  -
+    type: flags
+    name: telemetry-field-mode
+    entries: [read, write]
+    doc: Bitmask of access modes supported by a telemetry field.
 
 attribute-sets:
   -
@@ -100,6 +105,41 @@ attribute-sets:
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
+        type: uint
+        doc:  Telemetry field to be read/written, e.g., SoC temp.
+      -
+        name: field-name
+        type: string
+        doc:  Name of the telemetry field defined by the device's uAPI.
+      -
+        name: value
+        type: sint
+        doc: Value of telemetry field that was read/written.
+      -
+        name: status
+        type: sint
+        doc: >-
+             Status of the telemetry operation.
+             Populated by the device in response to the performed
+             telemetry operation. Errors may be hardware specific.
+      -
+        name: mode
+        type: uint
+        enum: telemetry-field-mode
+        doc: >-
+             Bitmask of access modes (read/write) supported by the
+             telemetry field.
 
 operations:
   list:
@@ -198,6 +238,55 @@ operations:
             - node-id
             - error-id
             - error-threshold
+    -
+      name: telemetry-get
+      doc: Perform a read of the specified telemetry field.
+      attribute-set: telemetry-attrs
+      do:
+        pre: drm-ras-nl-pre-telemetry
+        post: drm-ras-nl-post-telemetry
+        request:
+          attributes:
+            - node-id
+            - field
+        reply:
+          attributes:
+            - value
+            - status
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
+        post: drm-ras-nl-post-telemetry
+        request:
+          attributes:
+            - node-id
+            - field
+            - value
+        reply:
+          attributes:
+            - status
+    -
+      name: telemetry-list-fields
+      doc: >-
+           Enumerate the telemetry fields exposed by a node, reporting each
+           field's value, name, and supported access modes (read/write).
+      attribute-set: telemetry-attrs
+      dump:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - field
+            - field-name
+            - mode
 
 mcast-groups:
   list:
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d0d6a3d20fb6..bc30bf0745e5 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/refcount.h>
 #include <linux/xarray.h>
 #include <net/genetlink.h>
@@ -55,6 +56,19 @@
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
+ * 10. TELEMETRY_LIST_FIELDS: List the telemetry fields provided by the device.
+ *     Each field contains the uAPI defined enum string, its numerical value,
+ *     and its mode bitmask, which encodes read/write capabilities.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -80,7 +94,6 @@
  * Node type:
  *
  * - ERROR_COUNTER:
- *     + Currently, only error counters are supported.
  *     + The driver must implement the query_error_counter() callback to provide
  *       the name and the value of the error counter.
  *     + The driver must provide a error_counter_range.last value informing the
@@ -98,6 +111,16 @@
  *       that are raised by the hardware.
  *     + The driver is responsible for error threshold bounds checking.
  *
+ * - TELEMETRY:
+ *     + The driver must implement the telemetry_get() callbacks, telemetry_set()
+ *       is optional.
+ *     + The driver must provide a list of telemetry fields corresponding to
+ *       their uAPI definitions and values, with each field's supported access
+ *       modes (read/write) encoded in its mode bitmask. Fields writable via
+ *       telemetry_set() must have the write mode bit set.
+ *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
+ *       to enforce permissions checks on telemetry operations.
+ *
  * Netlink handlers:
  *
  * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
@@ -112,18 +135,37 @@
  *   operation, fetching the error threshold of a specific counter.
  * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
  *   operation, setting the error threshold of a specific counter.
+ * - drm_ras_nl_pre_telemetry(): TELEMETRY_GET and TELEMETRY_SET pre_doit
+ *   operation. Looks the node up, takes a reference on it and stashes it in
+ *   info->ctx, and enforces the node's optional permission check.
+ * - drm_ras_nl_post_telemetry(): TELEMETRY_GET and TELEMETRY_SET post_doit
+ *   operation, dropping the reference taken by drm_ras_nl_pre_telemetry().
+ * - drm_ras_nl_telemetry_get_doit(): Implements the TELEMETRY_GET doit operation,
+ *   invoking the driver's telemetry_get callback and returning the results.
+ * - drm_ras_nl_telemetry_set_doit(): Implements the TELEMETRY_SET doit operation,
+ *   invoking the driver's telemetry_set callback and returning the results.
+ * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
+ *   dumpit operation, enumerating all telemetry fields and their supported
+ *   access modes for a telemetry node.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
 
 /*
- * The netlink callback context carries dump state across multiple dumpit calls
+ * Per-command netlink context. Overlaid on the callback storage (cb->ctx) for
+ * dumps and on genl_info (info->ctx) for doits. @node pins the node targeted by
+ * a telemetry get/set doit between its pre_doit and post_doit. Dumps never
+ * hold a node reference across dumpit() calls.
  */
 struct drm_ras_ctx {
-	/* Which xarray id to restart the dump from */
+	/* Which xarray id, error id, or field id to restart the dump from */
 	unsigned long restart;
+	/* Node targeted by a telemetry get/set doit */
+	struct drm_ras_node *node;
 };
 
+static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
+
 /**
  * drm_ras_node_get() - Look up a RAS node by ID and take a reference
  * @node_id: ID of the node to look up
@@ -737,6 +779,311 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	return ret;
 }
 
+/**
+ * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
+ * @ops: Generic netlink operations
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Looks up the telemetry node, takes a reference on it with drm_ras_node_get()
+ * and stashes it in @info->ctx so the doit handler can use it without a second
+ * lookup. The reference is dropped by drm_ras_nl_post_telemetry(), which
+ * genetlink only calls when this pre_doit succeeds; every error path here must
+ * therefore drop the reference itself. Also enforces the node's optional
+ * permission check via the telemetry_pre() callback.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
+			     struct genl_info *info)
+{
+	struct drm_ras_ctx *ctx = (void *)info->ctx;
+	struct drm_ras_node *node;
+	u32 node_id;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+	node = drm_ras_node_get(node_id);
+	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+		drm_ras_node_put(node);
+		return -ENOENT;
+	}
+
+	if (node->telemetry_pre) {
+		ret = node->telemetry_pre(node);
+		if (ret) {
+			drm_ras_node_put(node);
+			return ret;
+		}
+	}
+
+	ctx->node = node;
+
+	return 0;
+}
+
+/**
+ * drm_ras_nl_post_telemetry - Release the telemetry node after a doit handler
+ * @ops: Generic netlink operations
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Drops the reference that drm_ras_nl_pre_telemetry() took and stashed in
+ * @info->ctx. genetlink only invokes this post_doit when the matching pre_doit
+ * succeeded, so ctx->node is always the referenced node here.
+ */
+void drm_ras_nl_post_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
+			       struct genl_info *info)
+{
+	struct drm_ras_ctx *ctx = (void *)info->ctx;
+
+	drm_ras_node_put(ctx->node);
+}
+
+static bool telemetry_fields_contains(const struct drm_ras_telemetry_field *fields, u64 value,
+				      u32 mode)
+{
+	unsigned long idx;
+
+	if (!fields)
+		return false;
+
+	for (idx = 0; fields[idx].name; idx++) {
+		if (fields[idx].value == value && (fields[idx].mode & mode))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * drm_ras_nl_telemetry_list_fields_dumpit() - Dump a node's telemetry fields.
+ * @skb: Netlink message buffer
+ * @cb: Callback context for multi-part dumps
+ *
+ * Displays every telemetry field exposed by the given node, along with
+ * each field's supported access modes (read/write).
+ *
+ * The node reference is taken and dropped within each dumpit() call rather
+ * than held across the whole dump, so a userspace dump that is never
+ * completed cannot block drm_ras_node_unregister().
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_ctx *ctx = (void *)cb->ctx;
+	const struct drm_ras_telemetry_field *field;
+	struct drm_ras_node *node;
+	struct nlattr *hdr;
+	unsigned long idx;
+	u32 node_id;
+	int ret = 0;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+
+	node = drm_ras_node_get(node_id);
+	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+		drm_ras_node_put(node);
+		return -ENOENT;
+	}
+
+	/*
+	 * Node IDs may be reused, so the node found here is not necessarily the
+	 * one seen by a previous dumpit() call of this dump. Walk the field list
+	 * from the start rather than indexing at ctx->restart directly, so a
+	 * shorter list can never be read past its terminator.
+	 */
+	for (idx = 0; node->telemetry_fields[idx].name; idx++) {
+		if (idx < ctx->restart)
+			continue;
+
+		field = &node->telemetry_fields[idx];
+
+		hdr = genlmsg_iput(skb, info);
+		if (!hdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+
+		ret = nla_put_uint(skb, DRM_RAS_A_TELEMETRY_ATTRS_FIELD, field->value);
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
+		ret = nla_put_uint(skb, DRM_RAS_A_TELEMETRY_ATTRS_MODE, field->mode);
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
+	drm_ras_node_put(node);
+
+	return ret;
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
+	struct drm_ras_ctx *ctx = (void *)info->ctx;
+	struct drm_ras_node *node = ctx->node;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	u64 field;
+	s64 status = 0;
+	s64 value = 0;
+	int ret = 0;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
+		return -EINVAL;
+
+	field = nla_get_uint(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+
+	if (!node->telemetry_get) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+		return -ENOENT;
+	}
+
+	if (!telemetry_fields_contains(node->telemetry_fields, field,
+				       DRM_RAS_TELEMETRY_FIELD_MODE_READ)) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+		return -EINVAL;
+	}
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
+	ret = nla_put_sint(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
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
+	struct drm_ras_ctx *ctx = (void *)info->ctx;
+	struct drm_ras_node *node = ctx->node;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	u64 field;
+	s64 status = 0;
+	s64 value = 0;
+	int ret = 0;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_VALUE) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_TELEMETRY_ATTRS_FIELD))
+		return -EINVAL;
+
+	value = nla_get_sint(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
+	field = nla_get_uint(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+
+	if (!node->telemetry_set) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
+		return -ENOENT;
+	}
+
+	if (!telemetry_fields_contains(node->telemetry_fields, field,
+				       DRM_RAS_TELEMETRY_FIELD_MODE_WRITE)) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+		return -EINVAL;
+	}
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
+	ret = nla_put_sint(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
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
@@ -751,14 +1098,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
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
+		if (!node->telemetry_get || !node->telemetry_fields)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	/* One reference is held for being registered in the xarray */
 	refcount_set(&node->ref, 1);
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index ff0dc406c27c..589c6445eff7 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -41,6 +41,24 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_TELEMETRY_GET - do */
+static const struct nla_policy drm_ras_telemetry_get_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_UINT, },
+};
+
+/* DRM_RAS_CMD_TELEMETRY_SET - do */
+static const struct nla_policy drm_ras_telemetry_set_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_UINT, },
+	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_SINT, },
+};
+
+/* DRM_RAS_CMD_TELEMETRY_LIST_FIELDS - dump */
+static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -83,6 +101,31 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_GET,
+		.pre_doit	= drm_ras_nl_pre_telemetry,
+		.doit		= drm_ras_nl_telemetry_get_doit,
+		.post_doit	= drm_ras_nl_post_telemetry,
+		.policy		= drm_ras_telemetry_get_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_SET,
+		.pre_doit	= drm_ras_nl_pre_telemetry,
+		.doit		= drm_ras_nl_telemetry_set_doit,
+		.post_doit	= drm_ras_nl_post_telemetry,
+		.policy		= drm_ras_telemetry_set_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
+		.dumpit		= drm_ras_nl_telemetry_list_fields_dumpit,
+		.policy		= drm_ras_telemetry_list_fields_nl_policy,
+		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 9aef097ea10f..7a1cba70fd50 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -12,6 +12,12 @@
 
 #include <uapi/drm/drm_ras.h>
 
+int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
+			     struct sk_buff *skb, struct genl_info *info);
+void
+drm_ras_nl_post_telemetry(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info);
+
 int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb);
 int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
@@ -24,6 +30,10 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
 int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
+int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
+					    struct netlink_callback *cb);
 
 enum {
 	DRM_RAS_NLGRP_ERROR_REPORT,
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 449509c36355..76bdcc6f96a5 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -12,6 +12,22 @@
 
 #include <uapi/drm/drm_ras.h>
 
+/**
+ * struct drm_ras_telemetry_field - A descriptor of a telemetry field.
+ */
+struct drm_ras_telemetry_field {
+	/** @name: The enum or macro name defined by the device uAPI. */
+	const char *name;
+	/** @value: The numerical value of the field. */
+	u64 value;
+	/**
+	 * @mode: Bitmask of supported access modes for this field, built
+	 * from enum drm_ras_telemetry_field_mode (DRM_RAS_TELEMETRY_FIELD_MODE_READ,
+	 * DRM_RAS_TELEMETRY_FIELD_MODE_WRITE).
+	 */
+	u32 mode;
+};
+
 /**
  * struct drm_ras_node - A DRM RAS Node
  */
@@ -102,6 +118,72 @@ struct drm_ras_node {
 	 */
 	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
 
+	/* Telemetry Related Callback and Variables */
+
+	/**
+	 * @telemetry_fields:
+	 *
+	 * A list of telemetry fields for a device, each with its supported
+	 * access modes encoded in its &drm_ras_telemetry_field.mode.
+	 * The list must be terminated by a NULL .name entry.
+	 */
+	const struct drm_ras_telemetry_field *telemetry_fields;
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
+	 * The callback will read the desired device-specific field into
+	 * @value and update @status to a device-specific error code.
+	 *
+	 * The return value and @status report failures at two different
+	 * levels. The return value indicates whether the read could be
+	 * performed at all, e.g. an unsupported field or a driver/communication
+	 * failure talking to the device. @status instead reports an error the
+	 * device itself returned in response to an otherwise successfully
+	 * performed read. @value is only meaningful when this returns 0 and
+	 * @status is 0.
+	 *
+	 * Returns 0 if the read was performed, regardless of @status.
+	 * Returns a negative error code if the read could not be performed.
+	 */
+	int (*telemetry_get)(struct drm_ras_node *ep, u64 *field, s64 *value,
+			     s64 *status);
+
+	/**
+	 * @telemetry_set:
+	 *
+	 * This callback is used for a drm-ras telemetry node to write a
+	 * telemetry value. This is an optional callback for telemetry_node.
+	 *
+	 * The callback will write @value to the desired device-specific field
+	 * and update @status to a device-specific error code.
+	 *
+	 * The return value and @status report failures at two different
+	 * levels. The return value indicates whether the write could be
+	 * performed at all, e.g. an unsupported field or a driver/communication
+	 * failure talking to the device. @status instead reports an error the
+	 * device itself returned in response to an otherwise successfully
+	 * performed write.
+	 *
+	 * Returns 0 if the write was performed, regardless of @status.
+	 * Returns a negative error code if the write could not be performed.
+	 */
+	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
+			     s64 *status);
+
 	/** @priv: Driver private data */
 	void *priv;
 
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 2f832275ee6e..56e0588af5d5 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -11,11 +11,21 @@
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
+};
+
+/*
+ * Bitmask of access modes supported by a telemetry field.
+ */
+enum drm_ras_telemetry_field_mode {
+	DRM_RAS_TELEMETRY_FIELD_MODE_READ = 1,
+	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
 };
 
 enum {
@@ -51,6 +61,18 @@ enum {
 	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
+	DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME,
+	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
+	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
+	DRM_RAS_A_TELEMETRY_ATTRS_MODE,
+
+	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
+	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -58,6 +80,9 @@ enum {
 	DRM_RAS_CMD_ERROR_EVENT,
 	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
 	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_TELEMETRY_GET,
+	DRM_RAS_CMD_TELEMETRY_SET,
+	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0

