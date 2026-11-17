Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EE606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HoD3RyuA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DF810E5F1;
	Tue, 17 Nov 2026 23:35:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E36010E69D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:35:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMemJA2105005; Tue, 17 Nov 2026 23:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s4c2aAuGCduG8nFoo2Nk7EbXsbF7dSaKAlYlqk5bHzE=; b=HoD3RyuANNnH9oyt
 DP//tK6Pt6CkGOGLi9T50GfTqQTc1ttlwo97jyIYXThHW/1qFQu7IgWxcF3Jwrov
 t7iErQfiVWYR5O3ckJz4tTgIK2lYw/kMjaZAB2WRlckzwrWMGr16WfbmfeI1n8+r
 TqwEDjXD16lfM7I4pUJi/jfx+nS8mt6Dr5vpvzYSC5ZN3SduskEiRTXNNjcw8AOq
 AoiwcctSdRTFDrTJXJfhjjG7YO1dLseQKZQk+wyGfQV4oRVf5V6NpprT/6Oco6Uq
 5QpMKUDXOJEDt3+orUIeGPr5b2IHLUE/nyeGKdi4xGryP9N230JAAfPw99HiMT+C
 YbkKgA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv705wg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 23:34:52 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHNYpMd1594938; Tue, 17 Nov 2026 23:34:51 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AHNYp991594923
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 23:34:51 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id 416E321C0A; Tue, 17 Nov 2026 15:34:51 -0800 (PST)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 1/4] drm/drm_ras: Reference-count nodes across netlink
 handlers
Date: Tue, 17 Nov 2026 15:34:31 -0800
Message-ID: <20261117233442.407877-2-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: t933ezUTjr-xHkImmBFoi5BqtV5yQJc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MyBTYWx0ZWRfX/M8NWGgiiD+f
 TebZOwCjXcyD3TR+HZLszEEzTyOpeJaJ2n+00lsckZNPRDy5GBP2jfgOfo8HuZwon3ZNs9n/6X6
 Cqf9KQJkhlV2AJ1nzpiaAYlx81ifanKlRZ1LWfDFe2dM6KAKaU+fWRC9Y2uyMDTPubSH4SonVwa
 HsO6G9U13i93evHp4Bj0M1//r72mIvpZ0l86/FSsnhAbTtb820+hEPGQyBn4CPFm1PMjIYgcu2W
 n8+H8fNhcD2uUccoa/MHWSrvJP06uBA1q1+fcmKFyYgZ44pjAhn8D8FPgEAMJ0fJxuoNJcG41q8
 +nusOzg4uyUZ9bXgfbKZDOUt9+dMAnY9LTvEaaiZD9gFx3F4fyzd8R9evauXagZm+6bjoRJVgyV
 /4vqYsl/+Q74vjBYr2S7xFliuSxPf6szS5oeqIkeTO+1adxeoxZw7CRfS2qlHCjRpViV2sOwVG4
 ehFywG2asVIVvmFNEcg==
X-Proofpoint-ORIG-GUID: t933ezUTjr-xHkImmBFoi5BqtV5yQJc1
X-Authority-Analysis: v=2.4 cv=H8xOUOYi c=1 sm=1 tr=0 ts=6afce49c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7dpFvd3J6xJ8gtmSNG0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MyBTYWx0ZWRfX9TdikY/g2qZW
 hZA5k3azge8sb5YKK/nkX79YHmfuZIOdVAPiP5UlYl0/b2YZKl/zKm5XB8fS7cW+GZZ02pKm7bx
 oQ+LmfoKs+tHF1Ljb50AYP5D6VbDBAw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170093
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

The drm_ras generic netlink family sets .parallel_ops = true, so its
handlers can run concurrently with each other and with
drm_ras_node_unregister(). Every handler looks a node up with a bare
xa_load() and then dereferences the returned pointer across GFP_KERNEL
allocations and sleeping driver callbacks, while drm_ras_node_unregister()
only calls xa_erase() and the driver frees the node immediately afterwards.
xa_load() only holds the RCU read lock for the duration of the walk, so the
node can be unregistered and freed while a handler is still using it.

Give each node a reference count. A node holds one reference for being
registered; drm_ras_node_get()/drm_ras_node_get_next() take an additional
reference under the xarray lock, which serialises them against the
xa_erase() in drm_ras_node_unregister() so the bump can never race with the
free. Handlers drop their reference with drm_ras_node_put() once they are
done touching the node. drm_ras_node_unregister() removes the node from
the xarray, drops the registration reference and waits for any in-flight
handler to drop theirs before returning, so the driver can still free the
node as soon as unregister() returns.

drm_ras_nl_error_event() is left unchanged: it is called by the driver with
its own node, whose lifetime the caller already guarantees.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com
Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_ras.c | 239 +++++++++++++++++++++++++++++---------
 include/drm/drm_ras.h     |  16 +++
 2 files changed, 201 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b099eb67836e..75e3403ca71b 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -3,9 +3,11 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include <linux/completion.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/refcount.h>
 #include <linux/xarray.h>
 #include <net/genetlink.h>
 
@@ -60,6 +62,21 @@
  * - drm_ras_node_unregister(): Removes a previously registered
  *   node from the xarray.
  *
+ * Node lifetime:
+ *
+ * The &drm_ras_nl_family uses &genl_family.parallel_ops, so netlink
+ * handlers may run concurrently with each other and with
+ * drm_ras_node_unregister(). Node memory is owned by the driver, which
+ * typically frees it right after drm_ras_node_unregister() returns. To make
+ * this safe, every handler looks a node up with drm_ras_node_get(), which
+ * takes a reference under the xarray lock, and drops it with
+ * drm_ras_node_put() once it is done touching the node. A node holds one
+ * reference for being registered; drm_ras_node_unregister() removes the node
+ * from the xarray (so no new lookups can find it), drops that registration
+ * reference, and then waits for any in-flight handlers to drop theirs before
+ * returning. The driver may therefore free the node as soon as
+ * drm_ras_node_unregister() returns.
+ *
  * Node type:
  *
  * - ERROR_COUNTER:
@@ -107,6 +124,75 @@ struct drm_ras_ctx {
 	unsigned long restart;
 };
 
+/**
+ * drm_ras_node_get() - Look up a RAS node by ID and take a reference
+ * @node_id: ID of the node to look up
+ *
+ * Looks the node up in the global xarray and, if found, takes a reference to
+ * it so that it cannot be freed while the caller is using it. The lookup and
+ * the reference bump happen under the xarray lock, which serialises them
+ * against the xa_erase() in drm_ras_node_unregister(): a node that is still
+ * present in the xarray is guaranteed to still hold its registration
+ * reference, so the bump can never operate on freed memory.
+ *
+ * The caller must drop the returned reference with drm_ras_node_put().
+ *
+ * Return: the referenced node, or NULL if no node with @node_id is registered.
+ */
+static struct drm_ras_node *drm_ras_node_get(u32 node_id)
+{
+	struct drm_ras_node *node;
+
+	xa_lock(&drm_ras_xa);
+	node = xa_load(&drm_ras_xa, node_id);
+	if (node)
+		refcount_inc(&node->ref);
+	xa_unlock(&drm_ras_xa);
+
+	return node;
+}
+
+/**
+ * drm_ras_node_get_next() - Take a reference on the next registered RAS node
+ * @next: in/out cursor; on entry the first ID to consider, on return the ID of
+ *        the node whose reference was taken
+ *
+ * Iterator counterpart of drm_ras_node_get() used by the LIST_NODES dump.
+ * Finds the first node with an ID at or above *@next, takes a reference to it
+ * under the xarray lock and reports its ID back in *@next.
+ *
+ * The caller must drop the returned reference with drm_ras_node_put().
+ *
+ * Return: the referenced node, or NULL if no further node is registered.
+ */
+static struct drm_ras_node *drm_ras_node_get_next(unsigned long *next)
+{
+	struct drm_ras_node *node;
+
+	xa_lock(&drm_ras_xa);
+	node = xa_find(&drm_ras_xa, next, ULONG_MAX, XA_PRESENT);
+	if (node)
+		refcount_inc(&node->ref);
+	xa_unlock(&drm_ras_xa);
+
+	return node;
+}
+
+/**
+ * drm_ras_node_put() - Drop a reference taken on a RAS node
+ * @node: node to drop a reference on, may be NULL
+ *
+ * Drops a reference previously taken by drm_ras_node_get() or
+ * drm_ras_node_get_next(). When the last reference (including the registration
+ * reference dropped by drm_ras_node_unregister()) goes away, the waiter in
+ * drm_ras_node_unregister() is woken so the driver can free the node.
+ */
+static void drm_ras_node_put(struct drm_ras_node *node)
+{
+	if (node && refcount_dec_and_test(&node->ref))
+		complete(&node->unregistered);
+}
+
 /**
  * drm_ras_nl_list_nodes_dumpit() - Dump all registered RAS nodes
  * @skb: Netlink message buffer
@@ -129,44 +215,45 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 	struct drm_ras_ctx *ctx = (void *)cb->ctx;
 	struct drm_ras_node *node;
 	struct nlattr *hdr;
-	unsigned long id;
-	int ret;
+	unsigned long id = ctx->restart;
+	int ret = 0;
 
-	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
+	while ((node = drm_ras_node_get_next(&id))) {
 		hdr = genlmsg_iput(skb, info);
 		if (!hdr) {
 			ret = -EMSGSIZE;
+			drm_ras_node_put(node);
 			break;
 		}
 
 		ret = nla_put_u32(skb, DRM_RAS_A_NODE_ATTRS_NODE_ID, node->id);
-		if (ret) {
-			genlmsg_cancel(skb, hdr);
-			break;
-		}
+		if (ret)
+			goto cancel;
 
 		ret = nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
 				     node->device_name);
-		if (ret) {
-			genlmsg_cancel(skb, hdr);
-			break;
-		}
+		if (ret)
+			goto cancel;
 
 		ret = nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_NODE_NAME,
 				     node->node_name);
-		if (ret) {
-			genlmsg_cancel(skb, hdr);
-			break;
-		}
+		if (ret)
+			goto cancel;
 
 		ret = nla_put_u32(skb, DRM_RAS_A_NODE_ATTRS_NODE_TYPE,
 				  node->type);
-		if (ret) {
-			genlmsg_cancel(skb, hdr);
-			break;
-		}
+		if (ret)
+			goto cancel;
 
 		genlmsg_end(skb, hdr);
+		drm_ras_node_put(node);
+		id++;
+		continue;
+
+cancel:
+		genlmsg_cancel(skb, hdr);
+		drm_ras_node_put(node);
+		break;
 	}
 
 	if (ret == -EMSGSIZE)
@@ -175,13 +262,10 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
-static int get_node_error_counter(u32 node_id, u32 error_id,
+static int get_node_error_counter(struct drm_ras_node *node, u32 error_id,
 				  const char **name, u32 *value)
 {
-	struct drm_ras_node *node;
-
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node || !node->query_error_counter)
+	if (!node->query_error_counter)
 		return -ENOENT;
 
 	if (error_id < node->error_counter_range.first ||
@@ -191,14 +275,9 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
-static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
+static int get_node_error_threshold(struct drm_ras_node *node, u32 error_id,
+				    const char **name, u32 *threshold)
 {
-	struct drm_ras_node *node;
-
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node)
-		return -ENOENT;
-
 	if (!node->query_error_threshold)
 		return -EOPNOTSUPP;
 
@@ -208,14 +287,8 @@ static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name
 	return node->query_error_threshold(node, error_id, name, threshold);
 }
 
-static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
+static int set_node_error_threshold(struct drm_ras_node *node, u32 error_id, u32 threshold)
 {
-	struct drm_ras_node *node;
-
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node)
-		return -ENOENT;
-
 	if (!node->set_error_threshold)
 		return -EOPNOTSUPP;
 
@@ -290,15 +363,22 @@ static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *er
 static int doit_reply_value(struct genl_info *info, u32 node_id,
 			    u32 error_id)
 {
+	struct drm_ras_node *node;
 	struct sk_buff *msg;
 	struct nlattr *hdr;
 	const char *error_name;
 	u32 value;
 	int ret;
 
+	node = drm_ras_node_get(node_id);
+	if (!node)
+		return -ENOENT;
+
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
 
 	hdr = genlmsg_iput(msg, info);
 	if (!hdr) {
@@ -306,7 +386,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 		goto free_msg;
 	}
 
-	ret = get_node_error_counter(node_id, error_id,
+	ret = get_node_error_counter(node, error_id,
 				     &error_name, &value);
 	if (ret)
 		goto cancel_msg;
@@ -317,26 +397,37 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 
 	genlmsg_end(msg, hdr);
 
+	drm_ras_node_put(node);
+
 	return genlmsg_reply(msg, info);
 
 cancel_msg:
 	genlmsg_cancel(msg, hdr);
 free_msg:
 	nlmsg_free(msg);
+put_node:
+	drm_ras_node_put(node);
 	return ret;
 }
 
 static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
 {
 	const char *error_name;
+	struct drm_ras_node *node;
 	struct sk_buff *msg;
 	struct nlattr *hdr;
 	u32 threshold;
 	int ret;
 
+	node = drm_ras_node_get(node_id);
+	if (!node)
+		return -ENOENT;
+
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
 
 	hdr = genlmsg_iput(msg, info);
 	if (!hdr) {
@@ -344,7 +435,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
 		goto free_msg;
 	}
 
-	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
+	ret = get_node_error_threshold(node, error_id, &error_name, &threshold);
 	if (ret)
 		goto cancel_msg;
 
@@ -354,12 +445,16 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
 
 	genlmsg_end(msg, hdr);
 
+	drm_ras_node_put(node);
+
 	return genlmsg_reply(msg, info);
 
 cancel_msg:
 	genlmsg_cancel(msg, hdr);
 free_msg:
 	nlmsg_free(msg);
+put_node:
+	drm_ras_node_put(node);
 	return ret;
 }
 
@@ -372,6 +467,10 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
  *
  * Report an error-event to userspace using the error-report multicast group.
  *
+ * The caller owns @node and must guarantee it stays alive for the duration of
+ * this call (it is the driver's own node), so no additional reference is taken
+ * here.
+ *
  * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
  *          netns, which is unbounded work; callers in interrupt handlers
  *          or other atomic context must defer event.
@@ -455,21 +554,21 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 	struct nlattr *hdr;
 	const char *error_name;
 	u32 node_id, error_id, value;
-	int ret;
+	int ret = 0;
 
 	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID))
 		return -EINVAL;
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 
-	node = xa_load(&drm_ras_xa, node_id);
+	node = drm_ras_node_get(node_id);
 	if (!node)
 		return -ENOENT;
 
 	for (error_id = max(node->error_counter_range.first, ctx->restart);
 	     error_id <= node->error_counter_range.last;
 	     error_id++) {
-		ret = get_node_error_counter(node_id, error_id,
+		ret = get_node_error_counter(node, error_id,
 					     &error_name, &value);
 		/*
 		 * For non-contiguous range, driver return -ENOENT as indication
@@ -478,7 +577,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 		if (ret == -ENOENT)
 			continue;
 		if (ret)
-			return ret;
+			break;
 
 		hdr = genlmsg_iput(skb, info);
 
@@ -499,6 +598,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 	if (ret == -EMSGSIZE)
 		ctx->restart = error_id;
 
+	drm_ras_node_put(node);
+
 	return ret;
 }
 
@@ -544,6 +645,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 {
 	struct drm_ras_node *node;
 	u32 node_id, error_id;
+	int ret;
 
 	if (!info->attrs ||
 	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
@@ -553,15 +655,23 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node || !node->clear_error_counter)
+	node = drm_ras_node_get(node_id);
+	if (!node || !node->clear_error_counter) {
+		drm_ras_node_put(node);
 		return -ENOENT;
+	}
 
 	if (error_id < node->error_counter_range.first ||
-	    error_id > node->error_counter_range.last)
+	    error_id > node->error_counter_range.last) {
+		drm_ras_node_put(node);
 		return -EINVAL;
+	}
 
-	return node->clear_error_counter(node, error_id);
+	ret = node->clear_error_counter(node, error_id);
+
+	drm_ras_node_put(node);
+
+	return ret;
 }
 
 /**
@@ -602,7 +712,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
  */
 int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drm_ras_node *node;
 	u32 node_id, error_id, threshold;
+	int ret;
 
 	if (!info->attrs ||
 	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
@@ -614,7 +726,15 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
 
-	return set_node_error_threshold(node_id, error_id, threshold);
+	node = drm_ras_node_get(node_id);
+	if (!node)
+		return -ENOENT;
+
+	ret = set_node_error_threshold(node, error_id, threshold);
+
+	drm_ras_node_put(node);
+
+	return ret;
 }
 
 /**
@@ -640,6 +760,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	    (!node->error_counter_range.last || !node->query_error_counter))
 		return -EINVAL;
 
+	/* One reference is held for being registered in the xarray */
+	refcount_set(&node->ref, 1);
+	init_completion(&node->unregistered);
+
 	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
 }
 EXPORT_SYMBOL(drm_ras_node_register);
@@ -648,10 +772,17 @@ EXPORT_SYMBOL(drm_ras_node_register);
  * drm_ras_node_unregister() - Unregister a previously registered node
  * @node: Node structure to unregister
  *
- * Removes the given node from the global node xarray using its ID.
+ * Removes the given node from the global node xarray using its ID and waits
+ * for any netlink handler that may still be using it to finish. Once this
+ * returns, no handler holds a reference to @node and the caller may free it.
  */
 void drm_ras_node_unregister(struct drm_ras_node *node)
 {
+	/* Remove from the xarray so no new lookup can find the node */
 	xa_erase(&drm_ras_xa, node->id);
+
+	/* Drop the registration reference and wait for in-flight handlers */
+	drm_ras_node_put(node);
+	wait_for_completion(&node->unregistered);
 }
 EXPORT_SYMBOL(drm_ras_node_unregister);
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 1765a3130b09..449509c36355 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -6,6 +6,8 @@
 #ifndef __DRM_RAS_H__
 #define __DRM_RAS_H__
 
+#include <linux/completion.h>
+#include <linux/refcount.h>
 #include <linux/types.h>
 
 #include <uapi/drm/drm_ras.h>
@@ -102,6 +104,20 @@ struct drm_ras_node {
 
 	/** @priv: Driver private data */
 	void *priv;
+
+	/* private: Internal drm_ras bookkeeping, drivers must not touch. */
+
+	/*
+	 * @ref: One reference is held while the node is registered in the
+	 * xarray; netlink handlers take an additional reference across their
+	 * use of the node. See drm_ras_node_get()/drm_ras_node_put().
+	 */
+	refcount_t ref;
+	/*
+	 * @unregistered: Completed when the last reference is dropped, so
+	 * drm_ras_node_unregister() can wait for in-flight handlers.
+	 */
+	struct completion unregistered;
 };
 
 struct drm_device;
-- 
2.43.0

