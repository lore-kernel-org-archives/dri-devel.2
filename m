Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F264C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFDF10F383;
	Thu,  9 Jul 2026 06:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W18p0KLO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Audynxvc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C57C10F37C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:00:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668N8xHT001269
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 06:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=KVejRE01iSJ9Cu8Vv9/R1+qSCrCIqHbYQPC
 pZLTjswY=; b=W18p0KLOMqGgiuhbsBZ44PvbjZxW6wgKHH4ebgV7ChQ5lzGfKw4
 jKV9zTj/d3hG+ns1/8t6yRA9n1rNkjzW4Xmeb+mKP8WU7IMj1z6nSiQ0qV8cSg6d
 75ZsBmvDJfqz/zoSbxbH/SV+arwQcmJfIY8GRqcbkbFuQk4zGkMluvFFbCRpOkcj
 9oAUklE8k3iJbJKkkvJpxUFMfm8sB8cCXVdHbOmrvj80LV/XmMNFAQ4yxJ31IiNH
 U+YcFj/r6Q/1otLfYS1CoNYbx66HWYu6M4u9qvHPJSBp+HjPluJ+M9DTp8xPAcmt
 19aIauhynvKLn79unjY0DeyJB55v5YA6+bA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvt1ax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 06:00:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c7f385887bso29258735ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 23:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783576808; x=1784181608;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KVejRE01iSJ9Cu8Vv9/R1+qSCrCIqHbYQPCpZLTjswY=;
 b=AudynxvcaiyjzbwLuVs/WCVJclCPKzdJgTDyA9e7EuR/UX5ZH3gsjewBnjKKY6slj0
 sElCWheFvdza1FVin+w2Q10gj4W5U5NmKX22qjvmC/ijVj0jjgVRY9FAt8laBrG1uXzb
 K8eQhO2c/8I786Yh8WN81ATAfXV8W4crQOvtfv2jM43ea9oXKgsWJZB8/wQ0ZAHqhQLa
 A/CYhlnZamjruKlttQLUA+rcooKr+mdO0Sw3mNx8yeb+O445mGaECUs6Q3mYaCRFdbke
 Vh99vLxbNwFQQVfp+iVCgcuM8KbQ9/a7q7q0/yVc4KUeqn6qAtdT7v1vNAgAbBpGKSbZ
 w/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783576808; x=1784181608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KVejRE01iSJ9Cu8Vv9/R1+qSCrCIqHbYQPCpZLTjswY=;
 b=B3i3fY9dHpFQWXtnUXLMwkNwVkodlsjJNlSUWXQ6+5ENvK1XKFG85twQl6JPbxZbCd
 yV0dtOOAKIaylua9Y7kLlk7AE7WcuZutO9ugyqODQQ/SaYjz/5cQN9T8MRpae0NiCIhW
 bqaTMilZEZgU7HVglaeTRPEdJyXg5cKIwbk3AsRYTMSnzHJSWKrVwdQsgo58zzcqjhFS
 OiwaZmQSuA6j9hWu9jcQiR++xoKdzd3sGkWWJCzXYy6haRxZ9TgTc4sMBlM9KjquN+18
 +n4tcoaXwVwU/MkQsmqr/On7blJ4HU5OrQwSeVLVCnAMWKsWFWVO2RPCp2p6vuJ/Kz4o
 Om5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMWT7QWDyOJyUU/xAO/DlpyZriGqaoH/j5a37gsi5q6rQEs0iDiH5CX8j5nbus19fhzftm8EvkdbY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1wjMjLH+/4wXC8EN8uafGq0MW57Q+4S5k79Vras0fQWASlhNh
 a+F2vsFHECcuV+r8AbUufR4ywe1UJNoGKjaQlAYCBRz0yaK0saYKT9rUGCqCiSVJA8of96z66ir
 6kKZwwlp50yB2fj0NZY6+u1+T5M8JFt3EqY1pvPxqNVxOzWfec9+eQN77VnYi0iDaOneuHVk=
X-Gm-Gg: AfdE7clvT0/TGSYJpf8uSvfTQi8mtuL6wrX2GnpUU1xSI6MGTigPIdsr6haIqXI2KW0
 Oo4P6qV8pG4X9IIyhk/aU9yruL4YPjGc7HDkzrpBsQPHR9atenFYKxXQKkUzno/58IVT1mKCz6j
 +L3WKy+djKPAYDcuGkicK7ZduQXYVaPic988sHao5ivxIv7P5+kCHsRrc+zU8ZaBGnRc2EhfFDE
 60GSIC7KvZjFZVCJ+AWVzYQ0FV8zTF98z9wBRjGDlUuwhJ5WzSMjddpg1VHz3OBzywVPsVYbAjN
 1aJXavPSL9L/qLv89gkP813RNpWN7sIljhUrJeKjG0PtzNsTY6HYOkXEm+bpjTiXWHQnOBw7c54
 IvbAC4PH0H38iHMbUqblJ26nwPvhopZiE0rA8a1kE1pKKJQ==
X-Received: by 2002:a17:903:22ca:b0:2cc:777f:d67d with SMTP id
 d9443c01a7336-2ccea42ca48mr61321465ad.30.1783576807286; 
 Wed, 08 Jul 2026 23:00:07 -0700 (PDT)
X-Received: by 2002:a17:903:22ca:b0:2cc:777f:d67d with SMTP id
 d9443c01a7336-2ccea42ca48mr61320405ad.30.1783576806265; 
 Wed, 08 Jul 2026 23:00:06 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d5c361sm37864555ad.80.2026.07.08.23.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:00:05 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
Date: Thu,  9 Jul 2026 11:29:58 +0530
Message-Id: <20260709055958.4089039-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfX7q9whDHGfckM
 KMIVlHqCYtm8VE5Skt31Le1C13wMuJxDDpWxjXiU/8HhWKy7OjMOIgxJF/xvqKCcER1cXPf47Nz
 fId/9NtyPf0GK6a2XSxZTYxtX3Dtupo=
X-Proofpoint-GUID: Pn1l46a-INDRNWTWcQ0OS2ancQxmvahN
X-Proofpoint-ORIG-GUID: Pn1l46a-INDRNWTWcQ0OS2ancQxmvahN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfX/EOrdF8dYeoW
 XUAVcOB5Jjr3JvUkypS5o45c6YxLAT0c9G33jiYip11oXalfdxJtuxM0wKs7K2T/FJi5NqH2BLq
 CrMn+gRxSso8lSXd+RFBxIpbRRbzG5YDXGCrod9nvgpt4uSiqfwUZnoefGlSK8bG6zPbnxUfliu
 CjGA6DvYBB9hkU2SYXc3c5AQK6B2o/vRbEomhm5N+cYu2lrXMOd1FspHYOlHUyprJv5SL+IA5fG
 mQhA+GEUcP2tQhWtc14DrInoYZon+MNmEhYW9vms9zRGT4NAeAIzceS8ufkiOxwulR0BhhH4u3x
 t6qrvQ4L5iEJZpB7JBgOleqxxLge2kN/HvDPjzVSzR7oTne0SqBvjgFn+tatBeFzZuAoQ53dIaT
 NtZkqSS0BQJpKKqX6mY6theXbyTStkZQCz36tlAL7Q/2mLEB0u76V5UQ8GFR2ImY3TczJoo7/Vv
 oXAjsjma7ILzEWS+N4Q==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f38e8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ThEsosvJOpkTSRB3RXoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090054
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

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Compute the timeout dynamically from message length and bus frequency
with a 10x safety margin over the theoretical wire time and a 300ms
floor. For GPI multi-descriptor transfers, use the maximum message
length across all queued messages as the per-completion timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 45 +++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..d43db77b3678 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -74,9 +74,12 @@ enum geni_i2c_err_code {
 #define PACKING_BYTES_PW	4
 
 #define ABORT_TIMEOUT		HZ
-#define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+/* 9 bits per byte (8 data + 1 ACK), 10x safety margin, 300ms floor */
+#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
+#define I2C_TIMEOUT_MIN_USEC		300000
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -204,6 +207,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
+static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
+{
+	size_t bit_cnt = len * 9;
+	size_t bit_usec = (bit_cnt * USEC_PER_SEC) / gi2c->clk_freq_out;
+	size_t xfer_max_usec = (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
+			       I2C_TIMEOUT_MIN_USEC;
+
+	return usecs_to_jiffies(xfer_max_usec);
+}
+
 static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
@@ -445,7 +458,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -470,8 +483,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		gi2c->dma_buf = dma_buf;
 	}
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -484,7 +498,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -512,8 +526,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (!dma_buf) /* Get FIFO IRQ */
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +606,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +616,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +627,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +751,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		dma_async_issue_pending(gi2c->tx_c);
 
 		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
+			unsigned long timeout;
+			size_t max_len = 0;
+			int j;
+
+			for (j = 0; j < gi2c->num_msgs; j++)
+				max_len = max_t(size_t, max_len, msgs[j].len);
+
+			timeout = geni_i2c_xfer_timeout(gi2c, max_len);
 			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
-								      XFER_TIMEOUT, &gi2c->done);
+								      timeout, &gi2c->done);
 			if (ret) {
 				dev_err(gi2c->se.dev,
 					"I2C multi write msg transfer timeout: %d\n",
@@ -851,8 +874,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 		}
 
 		if (!gi2c->is_tx_multi_desc_xfer) {
+			unsigned long timeout = geni_i2c_xfer_timeout(gi2c, msgs[i].len);
+
 			dma_async_issue_pending(gi2c->tx_c);
-			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+			time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 			if (!time_left) {
 				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
 				gi2c->err = -ETIMEDOUT;
-- 
2.34.1

