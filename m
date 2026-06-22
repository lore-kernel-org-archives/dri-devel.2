Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1E9CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A889510E544;
	Mon, 22 Jun 2026 08:11:58 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2377610E51A;
 Mon, 22 Jun 2026 08:11:48 +0000 (UTC)
X-UUID: 009e1e206e1211f1aa26b74ffac11d73-20260622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:332e4ab6-7674-4fb4-b2f6-0246a116fa7f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:bb04dd64913e3db9df292eed727a34ad,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
 :0|15|50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 009e1e206e1211f1aa26b74ffac11d73-20260622
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zenghongling@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1799372771; Mon, 22 Jun 2026 16:11:42 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, airlied@redhat.com, ttabi@nvidia.com, bskeggs@nvidia.com,
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v5 1/5] nouveau/gsp/rpc: Document RPC function return value
 contracts
Date: Mon, 22 Jun 2026 16:11:32 +0800
Message-Id: <20260622081136.61695-2-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260622081136.61695-1-zenghongling@kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
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

Add kernel-doc comments to document the return value semantics of
RPC functions in r535/rpc.c. This clarifies which functions can return
NULL, error pointers, or both, helping maintainers validate future
changes.

Return value analysis:
- r535_gsp_msgq_peek(): Never returns NULL
- r535_gsp_msgq_recv_one_elem(): Never returns NULL
- r535_gsp_msgq_recv(): CAN return NULL (when RPC length invalid)
- r535_gsp_msg_recv(): CAN return NULL (queue drained/no matching message)
- r535_gsp_rpc_get(): Never returns NULL
- r535_gsp_rpc_handle_reply(): CAN return NULL (NOWAIT/NOSEQ policies)
- r535_gsp_rpc_send(): CAN return NULL (via handle_reply)
- r535_gsp_rpc_push(): CAN return NULL (via handle_reply)

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

---
 Change in v5:
 -Fix documentation accuracy for r535_gsp_msg_recv() to clarify.
 -Fix documentation accuracy for r535_gsp_rpc_handle_reply() to clarify.
---
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
index 3ca3de8f4340..1f953f042df0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
@@ -204,6 +204,15 @@ r535_gsp_msgq_get_entry(struct nvkm_gsp *gsp)
  *   The user is responsible for freeing the memory allocated for the GSP
  *   message pages after they have been processed.
  */
+/**
+ * r535_gsp_msgq_peek - Peek at next message in GSP command queue
+ * @gsp: GSP device
+ * @gsp_rpc_len: Expected RPC length
+ * @retries: Retry counter
+ *
+ * Return: Pointer to RPC message on success, or ERR_PTR() on error.
+ *         Never returns NULL.
+ */
 static void *
 r535_gsp_msgq_peek(struct nvkm_gsp *gsp, u32 gsp_rpc_len, int *retries)
 {
@@ -229,6 +238,14 @@ struct r535_gsp_msg_info {
 static void
 r535_gsp_msg_dump(struct nvkm_gsp *gsp, struct nvfw_gsp_rpc *msg, int lvl);
 
+/**
+ * r535_gsp_msgq_recv_one_elem - Receive one message element from GSP queue
+ * @gsp: GSP device
+ * @info: Message queue information
+ *
+ * Return: Pointer to received buffer on success, or ERR_PTR() on error.
+ *         Never returns NULL.
+ */
 static void *
 r535_gsp_msgq_recv_one_elem(struct nvkm_gsp *gsp,
 			    struct r535_gsp_msg_info *info)
@@ -283,6 +300,15 @@ r535_gsp_msgq_recv_one_elem(struct nvkm_gsp *gsp,
 	return buf;
 }
 
+/**
+ * r535_gsp_msgq_recv - Receive RPC message(s) from GSP queue
+ * @gsp: GSP device
+ * @gsp_rpc_len: Expected RPC length
+ * @retries: Retry counter
+ *
+ * Return: Pointer to received buffer on success, ERR_PTR() on error,
+ *         or NULL if RPC length is invalid.
+ */
 static void *
 r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_len, int *retries)
 {
@@ -450,6 +476,20 @@ r535_gsp_msg_dump(struct nvkm_gsp *gsp, struct nvfw_gsp_rpc *msg, int lvl)
 	}
 }
 
+/**
+ * r535_gsp_msg_recv - Receive RPC message from GSP message queue
+ * @gsp: GSP device
+ * @fn: Expected RPC function number (0 to accept any)
+ * @gsp_rpc_len: Expected RPC length (0 for POLL mode)
+ *
+ * Return: Pointer to RPC message on success, ERR_PTR() on error.
+ *         When fn!=0: retries until timeout, returns ERR_PTR(-ETIMEDOUT)
+ *                    if no match found (never returns NULL for timeout).
+ *                    When fn!=0 and gsp_rpc_len==0 (POLL mode): returns
+ *                    NULL on successful message processing.
+ *         When fn==0: returns NULL if queue is drained or no matching
+ *                    message found without retrying.
+ */
 struct nvfw_gsp_rpc *
 r535_gsp_msg_recv(struct nvkm_gsp *gsp, int fn, u32 gsp_rpc_len)
 {
@@ -547,6 +587,17 @@ r535_gsp_rpc_poll(struct nvkm_gsp *gsp, u32 fn)
 	return 0;
 }
 
+/**
+ * r535_gsp_rpc_handle_reply - Handle RPC reply based on policy
+ * @gsp: GSP device
+ * @fn: RPC function number
+ * @policy: Reply policy (NOWAIT, NOSEQ, RECV, or POLL)
+ * @gsp_rpc_len: Expected RPC length
+ *
+ * Return: NULL when policy is NOWAIT or NOSEQ (no reply expected),
+ *         pointer to reply data on success, ERR_PTR() on error.
+ *         When policy is POLL: NULL on successful message processing.
+ */
 static void *
 r535_gsp_rpc_handle_reply(struct nvkm_gsp *gsp, u32 fn,
 			  enum nvkm_gsp_rpc_reply_policy policy,
@@ -574,6 +625,17 @@ r535_gsp_rpc_handle_reply(struct nvkm_gsp *gsp, u32 fn,
 	return repv;
 }
 
+/**
+ * r535_gsp_rpc_send - Send RPC message and handle reply
+ * @gsp: GSP device
+ * @payload: RPC payload to send
+ * @policy: Reply policy (NOWAIT, NOSEQ, RECV, or POLL)
+ * @gsp_rpc_len: Expected RPC length for reply
+ *
+ * Return: NULL if policy is NOWAIT/NOSEQ (no reply expected) or
+ *         POLL (successful message processing), pointer to reply data
+ *         on success, or ERR_PTR() on error.
+ */
 static void *
 r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *payload,
 		  enum nvkm_gsp_rpc_reply_policy policy, u32 gsp_rpc_len)
@@ -601,6 +663,11 @@ r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *payload,
 	return r535_gsp_rpc_handle_reply(gsp, fn, policy, gsp_rpc_len);
 }
 
+/**
+ * r535_gsp_rpc_done - Free an RPC message
+ * @gsp: GSP device
+ * @repv: Pointer to RPC payload data returned by r535_gsp_rpc_push()
+ */
 static void
 r535_gsp_rpc_done(struct nvkm_gsp *gsp, void *repv)
 {
@@ -609,6 +676,15 @@ r535_gsp_rpc_done(struct nvkm_gsp *gsp, void *repv)
 	r535_gsp_msg_done(gsp, rpc);
 }
 
+/**
+ * r535_gsp_rpc_get - Allocate and initialize an RPC message
+ * @gsp: GSP device
+ * @fn: RPC function number
+ * @payload_size: Size of the payload
+ *
+ * Return: Pointer to RPC payload data on success, or ERR_PTR() on error.
+ *     Never returns NULL. 
+ */
 static void *
 r535_gsp_rpc_get(struct nvkm_gsp *gsp, u32 fn, u32 payload_size)
 {
@@ -628,6 +704,17 @@ r535_gsp_rpc_get(struct nvkm_gsp *gsp, u32 fn, u32 payload_size)
 	return rpc->data;
 }
 
+/**
+ * r535_gsp_rpc_push - Push RPC message to GSP and wait for reply
+ * @gsp: GSP device
+ * @payload: RPC payload to send
+ * @policy: Reply policy (NOWAIT, NOSEQ, RECV, or POLL)
+ * @gsp_rpc_len: Expected RPC length in the reply
+ *
+ * Return: NULL when policy is NOWAIT/NOSEQ (no reply expected) or
+ *         POLL (successful message processing), pointer to reply data
+ *         on success, or ERR_PTR() on error.
+ */
 static void *
 r535_gsp_rpc_push(struct nvkm_gsp *gsp, void *payload,
 		  enum nvkm_gsp_rpc_reply_policy policy, u32 gsp_rpc_len)
-- 
2.25.1

