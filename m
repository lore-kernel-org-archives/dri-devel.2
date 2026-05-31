Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A851CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0052112B95;
	Sun, 31 May 2026 13:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M+eGME0B";
	dkim-atps=neutral
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337FB10E56E
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:13:01 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-39677234558so4980781fa.1
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780218779; x=1780823579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uRmHNETh8QyxZC3rJbR3SzfLqCNfPMJtwTtAlxccZyQ=;
 b=M+eGME0BKEVkeOxU9BQPukx3cJe1XLQRw3u5no7cyzclpe528jcEmaJNVxKnosiGd5
 O4qLN1tZwTeUsRa+XldmOHHAPdXV8mdXQOH9foCQeA/VKvfuVsyulApZld0O4wqkJdjE
 rFzMp604SsdOX1ZnemNJdgj/KfBverE/TP5HtQkGSLYFNi2idmyLjCIN84iDfuR6z7Va
 GZ4RScFwBxsKZE/c2Qs9z1Tv3nwI6ne81RtRv44UuWDmcVSD1hRVKqJy9obl71NElheY
 08/q/PF1LOXE3Ax3KETiGvilrZ+dMQMrvy5nQ5h+aOowLg5o7vMBxdHUYkJVFi7bwiGc
 unsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780218779; x=1780823579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRmHNETh8QyxZC3rJbR3SzfLqCNfPMJtwTtAlxccZyQ=;
 b=N0f0JxpHbXdcb73CRp3819XH3ri9d48Ch84PXCw9WYpXr17aqZmqepCNP9cC6m87DV
 96syPVQNw3BYPu4PvyPct7JpQMARVyN1zWxilt6rN+kuobV30OXFVeIuPzYjPqWLl6sm
 +y3f1VGhx8VNNBr+wsKZzz0WD6arVywcHyO4Vw2HRtTFcvAsJ4IjCwJJccYc28bQrtN9
 DnnV0a3oJlIpPESrfKuHaSw4j0C6pXFGZAV4oMBiTEgSYsJaLV6Hnx2R2LcSwr78CtU2
 hWgsGqxXoLazT1Kjy5GlLQ+NpPIRfkY4w6NKuUNDvVnTeiCvayXviglgVyiBucjxGkNI
 1jDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lEUvYx5pXYn9P9bXHHYwqpjtM/jKnu0yrrZoQUH2W82zMMKBOoK2pKUmragCkkPiY1FvhsK4bGjM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9DE5LzqFOaVzFump1g/zcsNFPpt3gVB532fBOjhHxnCoBB1FZ
 6s82IvaKgOa3I80ngFkwL11g8N7bJ6c+OwKCCk+/NcYgbdiKQ5aTUfCz
X-Gm-Gg: Acq92OEc0otniK+YqJl3fCqvwY1b0KQD1r1Qd2sSmKAd393gylUDf0QPdPZXf3VPHeC
 YMAHS125s2vDFptRsNSK8dFH8SiBxb5JTN5ZxjRR7orUU2/CM9AFIoKtrcxTFj1Vh2BxRepRBT8
 xcrSeG2rlVcaK5G7sHXRoQkjCi5AyIvnjXgCj6Mzwrm4WakAjeN7286k2D280k35NZab7PRVUhj
 ZtHqZixaLVis6JRwkwRpFw/HxTLEQQh7PG47V2PPkGgRVI/rC97rSjBShQslPlfFNeKCKzdbKC2
 0kci1W9C45LkkoUu2M1/qlD1B8iQeRswXgq4yXAQ+xxn8orDklWuImCn3BqkvHM5Oj0NsL5WqlT
 fGWdiQjD/Bc84Z3fWC9BZj0bxtEBRJ+++YUhukZkpwlAebQH2Nq9JvuTNBBvKeXdMzjJCNUIz/j
 AEU19hugCA3yOrNmd01ZbdlBG+fWk6jX2xxGueAlKc3YLj28OAyWXGnUD/MhXDM1RslP8=
X-Received: by 2002:a05:651c:154d:b0:396:7b8a:3da0 with SMTP id
 38308e7fff4ca-3967b8a400dmr4158141fa.26.1780218779027; 
 Sun, 31 May 2026 02:12:59 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39659e86230sm15042351fa.40.2026.05.31.02.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 02:12:58 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: maciej.falkowski@linux.intel.com,
	karol.wachowski@linux.intel.com
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 2/2] drm/accel/ivpu: send exact IPC message size instead of
 union size
Date: Sun, 31 May 2026 12:12:56 +0300
Message-ID: <20260531091256.1783-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:32 +0000
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

The IPC header data_size field is documented to carry the size of the JSM
payload.  Previously it was always set to sizeof(struct vpu_jsm_msg) which
is the size of the full union of all possible payloads, not the size of the
specific message being sent.

Introduce two helpers in ivpu_ipc.h:
  IVPU_JSM_MSG_BASE_SIZE  -- header-only size for messages with no payload
  IVPU_JSM_MSG_SIZE(m)    -- header + sizeof(payload.m) for messages that
                             carry a specific payload member

Thread an explicit msg_size argument through ivpu_ipc_tx_prepare(),
ivpu_ipc_send(), ivpu_ipc_send_receive_internal(), ivpu_ipc_send_receive()
and ivpu_ipc_send_and_wait(), then update all 25 call-sites in
ivpu_jsm_msg.c to pass the appropriate size.

This resolves the TODO comment added in commit introducing the IPC layer.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/accel/ivpu/ivpu_ipc.c     | 27 ++++++-----
 drivers/accel/ivpu/ivpu_ipc.h     | 16 +++++--
 drivers/accel/ivpu/ivpu_jsm_msg.c | 75 ++++++++++++++++++++-----------
 3 files changed, 77 insertions(+), 41 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index f47df092b..0c042a7ee 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -65,7 +65,7 @@ static void ivpu_ipc_mem_fini(struct ivpu_device *vdev)
 
 static int
 ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
-		    struct vpu_jsm_msg *req)
+		    struct vpu_jsm_msg *req, u32 msg_size)
 {
 	struct ivpu_ipc_info *ipc = vdev->ipc;
 	struct ivpu_ipc_tx_buf *tx_buf;
@@ -97,8 +97,7 @@ ivpu_ipc_tx_prepare(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 
 	memset(tx_buf, 0, sizeof(*tx_buf));
 	tx_buf->ipc.data_addr = jsm_vpu_addr;
-	/* TODO: Set data_size to actual JSM message size, not union of all messages */
-	tx_buf->ipc.data_size = sizeof(*req);
+	tx_buf->ipc.data_size = msg_size;
 	tx_buf->ipc.channel = cons->channel;
 	tx_buf->ipc.src_node = 0;
 	tx_buf->ipc.dst_node = 1;
@@ -210,7 +209,8 @@ void ivpu_ipc_consumer_del(struct ivpu_device *vdev, struct ivpu_ipc_consumer *c
 	ivpu_ipc_tx_release(vdev, cons->tx_vpu_addr);
 }
 
-int ivpu_ipc_send(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons, struct vpu_jsm_msg *req)
+int ivpu_ipc_send(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
+		  struct vpu_jsm_msg *req, u32 msg_size)
 {
 	struct ivpu_ipc_info *ipc = vdev->ipc;
 	int ret;
@@ -222,7 +222,7 @@ int ivpu_ipc_send(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons, stru
 		goto unlock;
 	}
 
-	ret = ivpu_ipc_tx_prepare(vdev, cons, req);
+	ret = ivpu_ipc_tx_prepare(vdev, cons, req, msg_size);
 	if (ret)
 		goto unlock;
 
@@ -296,7 +296,8 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 int
 ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 			       enum vpu_ipc_msg_type expected_resp_type,
-			       struct vpu_jsm_msg *resp, u32 channel, unsigned long timeout_ms)
+			       struct vpu_jsm_msg *resp, u32 channel, unsigned long timeout_ms,
+			       u32 msg_size)
 {
 	struct ivpu_ipc_consumer cons;
 	int ret;
@@ -306,7 +307,7 @@ ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req
 
 	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
 
-	ret = ivpu_ipc_send(vdev, &cons, req);
+	ret = ivpu_ipc_send(vdev, &cons, req, msg_size);
 	if (ret) {
 		ivpu_warn_ratelimited(vdev, "IPC send failed: %d\n", ret);
 		goto consumer_del;
@@ -331,7 +332,7 @@ ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req
 
 int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 			  enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
-			  u32 channel, unsigned long timeout_ms)
+			  u32 channel, unsigned long timeout_ms, u32 msg_size)
 {
 	struct vpu_jsm_msg hb_req = { .type = VPU_JSM_MSG_QUERY_ENGINE_HB };
 	struct vpu_jsm_msg hb_resp;
@@ -341,13 +342,15 @@ int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 	if (ret < 0)
 		return ret;
 
-	ret = ivpu_ipc_send_receive_internal(vdev, req, expected_resp, resp, channel, timeout_ms);
+	ret = ivpu_ipc_send_receive_internal(vdev, req, expected_resp, resp, channel, timeout_ms,
+					     msg_size);
 	if (ret != -ETIMEDOUT)
 		goto rpm_put;
 
 	hb_ret = ivpu_ipc_send_receive_internal(vdev, &hb_req, VPU_JSM_MSG_QUERY_ENGINE_HB_DONE,
 						&hb_resp, VPU_IPC_CHAN_ASYNC_CMD,
-						vdev->timeout.jsm);
+						vdev->timeout.jsm,
+						IVPU_JSM_MSG_BASE_SIZE);
 	if (hb_ret == -ETIMEDOUT)
 		ivpu_pm_trigger_recovery(vdev, "IPC timeout");
 
@@ -357,7 +360,7 @@ int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 }
 
 int ivpu_ipc_send_and_wait(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
-			   u32 channel, unsigned long timeout_ms)
+			   u32 channel, unsigned long timeout_ms, u32 msg_size)
 {
 	struct ivpu_ipc_consumer cons;
 	int ret;
@@ -368,7 +371,7 @@ int ivpu_ipc_send_and_wait(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 
 	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
 
-	ret = ivpu_ipc_send(vdev, &cons, req);
+	ret = ivpu_ipc_send(vdev, &cons, req, msg_size);
 	if (ret) {
 		ivpu_warn_ratelimited(vdev, "IPC send failed: %d\n", ret);
 		goto consumer_del;
diff --git a/drivers/accel/ivpu/ivpu_ipc.h b/drivers/accel/ivpu/ivpu_ipc.h
index b524a1985..c1b2ef3d7 100644
--- a/drivers/accel/ivpu/ivpu_ipc.h
+++ b/drivers/accel/ivpu/ivpu_ipc.h
@@ -11,6 +11,13 @@
 
 #include "vpu_jsm_api.h"
 
+/* Size of a JSM message with no payload */
+#define IVPU_JSM_MSG_BASE_SIZE ((u32)offsetof(struct vpu_jsm_msg, payload))
+/* Size of a JSM message with a specific payload member */
+#define IVPU_JSM_MSG_SIZE(member) \
+	((u32)(offsetof(struct vpu_jsm_msg, payload) + \
+	       sizeof(((struct vpu_jsm_msg *)0)->payload.member)))
+
 struct ivpu_bo;
 
 /* VPU FW boot notification */
@@ -97,17 +104,18 @@ void ivpu_ipc_consumer_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *c
 void ivpu_ipc_consumer_del(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons);
 
 int ivpu_ipc_send(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
-		  struct vpu_jsm_msg *req);
+		  struct vpu_jsm_msg *req, u32 msg_size);
 int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 		     struct ivpu_ipc_hdr *ipc_buf, struct vpu_jsm_msg *jsm_msg,
 		     unsigned long timeout_ms);
 int ivpu_ipc_send_receive_internal(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 				   enum vpu_ipc_msg_type expected_resp_type,
-				   struct vpu_jsm_msg *resp, u32 channel, unsigned long timeout_ms);
+				   struct vpu_jsm_msg *resp, u32 channel, unsigned long timeout_ms,
+				   u32 msg_size);
 int ivpu_ipc_send_receive(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
 			  enum vpu_ipc_msg_type expected_resp, struct vpu_jsm_msg *resp,
-			  u32 channel, unsigned long timeout_ms);
+			  u32 channel, unsigned long timeout_ms, u32 msg_size);
 int ivpu_ipc_send_and_wait(struct ivpu_device *vdev, struct vpu_jsm_msg *req,
-			   u32 channel, unsigned long timeout_ms);
+			   u32 channel, unsigned long timeout_ms, u32 msg_size);
 
 #endif /* __IVPU_IPC_H__ */
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 07b1d6f61..a74f5aed8 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -105,7 +105,8 @@ int ivpu_jsm_register_db(struct ivpu_device *vdev, u32 ctx_id, u32 db_id,
 	req.payload.register_db.host_ssid = ctx_id;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_REGISTER_DB_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(register_db));
 	if (ret)
 		ivpu_err_ratelimited(vdev, "Failed to register doorbell %u: %d\n", db_id, ret);
 
@@ -121,7 +122,8 @@ int ivpu_jsm_unregister_db(struct ivpu_device *vdev, u32 db_id)
 	req.payload.unregister_db.db_idx = db_id;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_UNREGISTER_DB_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(unregister_db));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to unregister doorbell %u: %d\n", db_id, ret);
 
@@ -140,7 +142,8 @@ int ivpu_jsm_get_heartbeat(struct ivpu_device *vdev, u32 engine, u64 *heartbeat)
 	req.payload.query_engine_hb.engine_idx = engine;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_QUERY_ENGINE_HB_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(query_engine_hb));
 	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to get heartbeat from engine %d: %d\n",
 				     engine, ret);
@@ -162,7 +165,8 @@ int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine, struct vpu_jsm_m
 	req.payload.engine_reset.engine_idx = engine;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_ENGINE_RESET_DONE, resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(engine_reset));
 	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to reset engine %d: %d\n", engine, ret);
 		ivpu_pm_trigger_recovery(vdev, "Engine reset failed");
@@ -187,7 +191,8 @@ int ivpu_jsm_preempt_engine(struct ivpu_device *vdev, u32 engine, u32 preempt_id
 	req.payload.engine_preempt.preempt_id = preempt_id;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_ENGINE_PREEMPT_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(engine_preempt));
 	if (ret)
 		ivpu_err_ratelimited(vdev, "Failed to preempt engine %d: %d\n", engine, ret);
 
@@ -203,7 +208,8 @@ int ivpu_jsm_dyndbg_control(struct ivpu_device *vdev, char *command, size_t size
 	strscpy(req.payload.dyndbg_control.dyndbg_cmd, command, VPU_DYNDBG_CMD_MAX_LEN);
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_DYNDBG_CONTROL_RSP, &resp,
-				    VPU_IPC_CHAN_GEN_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_GEN_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(dyndbg_control));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to send command \"%s\": ret %d\n",
 				      command, ret);
@@ -219,7 +225,8 @@ int ivpu_jsm_trace_get_capability(struct ivpu_device *vdev, u32 *trace_destinati
 	int ret;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_TRACE_GET_CAPABILITY_RSP, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_BASE_SIZE);
 	if (ret) {
 		ivpu_warn_ratelimited(vdev, "Failed to get trace capability: %d\n", ret);
 		return ret;
@@ -243,7 +250,8 @@ int ivpu_jsm_trace_set_config(struct ivpu_device *vdev, u32 trace_level, u32 tra
 	req.payload.trace_config.trace_hw_component_mask = trace_hw_component_mask;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_TRACE_SET_CONFIG_RSP, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(trace_config));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to set config: %d\n", ret);
 
@@ -259,7 +267,8 @@ int ivpu_jsm_context_release(struct ivpu_device *vdev, u32 host_ssid)
 	req.payload.ssid_release.host_ssid = host_ssid;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_SSID_RELEASE_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(ssid_release));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to release context: %d\n", ret);
 
@@ -278,7 +287,8 @@ int ivpu_jsm_pwr_d0i3_enter(struct ivpu_device *vdev)
 	req.payload.pwr_d0i3_enter.send_response = 1;
 
 	ret = ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_PWR_D0I3_ENTER_DONE, &resp,
-					     VPU_IPC_CHAN_GEN_CMD, vdev->timeout.d0i3_entry_msg);
+					     VPU_IPC_CHAN_GEN_CMD, vdev->timeout.d0i3_entry_msg,
+					     IVPU_JSM_MSG_SIZE(pwr_d0i3_enter));
 	if (ret)
 		return ret;
 
@@ -301,7 +311,8 @@ int ivpu_jsm_hws_create_cmdq(struct ivpu_device *vdev, u32 ctx_id, u32 cmdq_grou
 	req.payload.hws_create_cmdq.cmdq_size = cmdq_size;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_CREATE_CMD_QUEUE_RSP, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(hws_create_cmdq));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to create command queue: %d\n", ret);
 
@@ -318,7 +329,8 @@ int ivpu_jsm_hws_destroy_cmdq(struct ivpu_device *vdev, u32 ctx_id, u32 cmdq_id)
 	req.payload.hws_destroy_cmdq.cmdq_id = cmdq_id;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_DESTROY_CMD_QUEUE_RSP, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(hws_destroy_cmdq));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to destroy command queue: %d\n", ret);
 
@@ -339,7 +351,8 @@ int ivpu_jsm_hws_register_db(struct ivpu_device *vdev, u32 ctx_id, u32 cmdq_id,
 	req.payload.hws_register_db.cmdq_size = cmdq_size;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_REGISTER_DB_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(hws_register_db));
 	if (ret)
 		ivpu_err_ratelimited(vdev, "Failed to register doorbell %u: %d\n", db_id, ret);
 
@@ -358,7 +371,8 @@ int ivpu_jsm_hws_resume_engine(struct ivpu_device *vdev, u32 engine)
 	req.payload.hws_resume_engine.engine_idx = engine;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_HWS_RESUME_ENGINE_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(hws_resume_engine));
 	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to resume engine %d: %d\n", engine, ret);
 		ivpu_pm_trigger_recovery(vdev, "Engine resume failed");
@@ -384,7 +398,8 @@ int ivpu_jsm_hws_set_context_sched_properties(struct ivpu_device *vdev, u32 ctx_
 	req.payload.hws_set_context_sched_properties.grace_period_lower_priority = 0;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_SET_CONTEXT_SCHED_PROPERTIES_RSP, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(hws_set_context_sched_properties));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to set context sched properties: %d\n", ret);
 
@@ -404,7 +419,8 @@ int ivpu_jsm_hws_set_scheduling_log(struct ivpu_device *vdev, u32 engine_idx, u3
 	req.payload.hws_set_scheduling_log.notify_index = 0;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_HWS_SET_SCHEDULING_LOG_RSP, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(hws_set_scheduling_log));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to set scheduling log: %d\n", ret);
 
@@ -429,7 +445,8 @@ int ivpu_jsm_hws_setup_priority_bands(struct ivpu_device *vdev)
 	setup->normal_band_percentage = 10;
 
 	ret = ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_SET_PRIORITY_BAND_SETUP_RSP,
-					     &resp, VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+					     &resp, VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+					     IVPU_JSM_MSG_SIZE(hws_priority_band_setup));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to set priority bands: %d\n", ret);
 
@@ -449,7 +466,8 @@ int ivpu_jsm_metric_streamer_start(struct ivpu_device *vdev, u64 metric_group_ma
 	req.payload.metric_streamer_start.buffer_size = buffer_size;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_METRIC_STREAMER_START_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(metric_streamer_start));
 	if (ret) {
 		ivpu_warn_ratelimited(vdev, "Failed to start metric streamer: ret %d\n", ret);
 		return ret;
@@ -467,7 +485,8 @@ int ivpu_jsm_metric_streamer_stop(struct ivpu_device *vdev, u64 metric_group_mas
 	req.payload.metric_streamer_stop.metric_group_mask = metric_group_mask;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_METRIC_STREAMER_STOP_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(metric_streamer_stop));
 	if (ret)
 		ivpu_warn_ratelimited(vdev, "Failed to stop metric streamer: ret %d\n", ret);
 
@@ -486,7 +505,8 @@ int ivpu_jsm_metric_streamer_update(struct ivpu_device *vdev, u64 metric_group_m
 	req.payload.metric_streamer_update.buffer_size = buffer_size;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_METRIC_STREAMER_UPDATE_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(metric_streamer_update));
 	if (ret) {
 		ivpu_warn_ratelimited(vdev, "Failed to update metric streamer: ret %d\n", ret);
 		return ret;
@@ -515,7 +535,8 @@ int ivpu_jsm_metric_streamer_info(struct ivpu_device *vdev, u64 metric_group_mas
 	req.payload.metric_streamer_start.buffer_size = buffer_size;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_METRIC_STREAMER_INFO_DONE, &resp,
-				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+				    IVPU_JSM_MSG_SIZE(metric_streamer_start));
 	if (ret) {
 		ivpu_warn_ratelimited(vdev, "Failed to get metric streamer info: ret %d\n", ret);
 		return ret;
@@ -543,7 +564,8 @@ int ivpu_jsm_dct_enable(struct ivpu_device *vdev, u32 active_us, u32 inactive_us
 	req.payload.pwr_dct_control.dct_inactive_us = inactive_us;
 
 	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_DCT_ENABLE_DONE, &resp,
-					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+					      IVPU_JSM_MSG_SIZE(pwr_dct_control));
 }
 
 int ivpu_jsm_dct_disable(struct ivpu_device *vdev)
@@ -552,7 +574,8 @@ int ivpu_jsm_dct_disable(struct ivpu_device *vdev)
 	struct vpu_jsm_msg resp;
 
 	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_DCT_DISABLE_DONE, &resp,
-					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+					      IVPU_JSM_MSG_BASE_SIZE);
 }
 
 int ivpu_jsm_state_dump(struct ivpu_device *vdev)
@@ -561,7 +584,8 @@ int ivpu_jsm_state_dump(struct ivpu_device *vdev)
 	struct vpu_jsm_msg resp;
 
 	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_STATE_DUMP_RSP, &resp,
-					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm,
+					      IVPU_JSM_MSG_BASE_SIZE);
 }
 
 int ivpu_jsm_state_dump_no_reply(struct ivpu_device *vdev)
@@ -569,5 +593,6 @@ int ivpu_jsm_state_dump_no_reply(struct ivpu_device *vdev)
 	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_STATE_DUMP };
 
 	return ivpu_ipc_send_and_wait(vdev, &req, VPU_IPC_CHAN_ASYNC_CMD,
-				      vdev->timeout.state_dump_msg);
+				      vdev->timeout.state_dump_msg,
+				      IVPU_JSM_MSG_BASE_SIZE);
 }
-- 
2.51.1

