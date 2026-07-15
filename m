Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFD9C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1E710EF6D;
	Wed, 15 Jul 2026 10:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZEk2b+L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IViYzlBQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3791210EF6D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:18:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F6hUNM2796328
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=R6N0CWGkPVZZZBaPfB3WmWHTmuDOaLDUgxD
 EGdffRFw=; b=lZEk2b+LNVUSg/1a8Nuf9mafJTg9ai8UIjsVqnY9L1PfDiuawkn
 RwM2Dh15emzuB8cGKqrqWvS1KInsUGKThkLn+oZDEm/PsdYIbOpGUbsuSbO5dx40
 04cUmCbgxlhnwnkrPU41FghT70XzMfeJVTe0jRwVVghRHHPN4Mgs8IIKRZ+9KRnN
 CZXKI2UB9FNAcWdykzAoK2vaS8KMfJx+3Rx9JyQQu+GliLYldzCuaAsVGIYDXiYj
 Z5o58RgRLcuAppHbUNiNK/PtckDtaBhAGo5JID9WCc1iFZbS9uodAlvuc+j/0FYy
 52bLZJlH0y8/AdFyntaUOcKI3DUeP0YxU3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe56h8suy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:18:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2caa9a3cf7aso6008245ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784110696; x=1784715496;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=R6N0CWGkPVZZZBaPfB3WmWHTmuDOaLDUgxDEGdffRFw=;
 b=IViYzlBQkBo21LGEmT3qCGOelxBvEsEoFBxjJsd04+GQ3H/vw97xhC8GWUFve+86/X
 Viwc/h0s8Zc5ziRiZf5MIToTH84opT37J9hhc9ntt1SevvzJuL4o/6Dee4DwTVSfsR29
 uCIPOKOdb8lTBZEew5c6X428BIBgPKstikq0EE/8QB9BiFkOTV6QVNWP9/3C6z2+D0Ln
 xsIFuCznEiPhcKQf0wCC0+VJT8sXYgH0xt/sZyNcWf6IwB6ADGnX10H9yVsv0aSiD+4y
 B9Zq/9s7sWyiJvNGskMjflJAf4Z3W3hsbLZqnyWNnz+WX1W2xY2TwEpP5emhZMLWKeHK
 I9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784110696; x=1784715496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R6N0CWGkPVZZZBaPfB3WmWHTmuDOaLDUgxDEGdffRFw=;
 b=jer4BxTreoPHw6e5FWbnXUsMOVy3owrsl9w+1/1J7WGC+IrZQ+Zr8BHeI3+1BenUg7
 dRbXSnhE3hVCktPSsfjBTKlglAXTnP7zFl5gPWv+JNJ9i6pxjkn0lU0eulyx9OrRYY/7
 Auje/8XO8UIOCnwk41gHWGgoCNpZJmOgC3nwUkx6T+NH5EyLboKs9BU27lT5/diXTzoW
 PLkMy+nFZokDID/wPJDpigpbIieZT2PPZSCNtvfrYk9p5Rh+sIOuEk2kangFJMxbRlZU
 8Myh5oxlBf0roteOOVB8+gavC8slNWrd+m12X9O0BwNJWUNz/TCTtCrDGF0LjlzeXSsI
 tNvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/uHqyPodHd52rZGDiS35O4mY/dnT3AdY/HyUY9+0OivGPfAiZmH1FwCylNtw9iiyG/PHLSFai7pc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHeYllwsXbsJxahqVuQPmGY63ZM6oDEUJEf6GOPnK5VnXsCGAj
 uexHpVJf1OKMsoTRl0tEEs3xCNzOlsF6G82tBNNLrAD6x0DwWJsFGr3QTT6mDs8i8iJNJwIQiOU
 0OLwU9bF50l/w3yShr+k1LJOnBLXhvb5rPEd3M6YqGXzUos9EJUu1wDDslMeH5drMbOez1s4=
X-Gm-Gg: AfdE7cmzwxVsWtKdL3tJwaVxdGPQxmPOgRzsbQ2eC59/dTbPBGrTEN7VqFmyoj6svDt
 NQY5DMZL78VIIYlQnrxoQj2NJ4X6sJT+Qc57G2V9yYTiwt8G0cgXzzxjKohXpNGhmT8K51bIGhE
 XrTqrZO9+T87fWor4lsIj42O9Wx5ykde3iBj4uBmOzlncjUvMG+i24TrDU2Re8/eHR3oj6gKm14
 hmA72XKwEN4NG3Ug+Nlj1FoCJaWcPPRTqjhGf0twjsDzg7hbib+0oPzH8+OyTQoSaS8NvqLx6y1
 6DghYxMaHsCYUw0LwB7Y8AugzAFnjJbgRpppfC5Gz+t2TP5+GTiDJ3y3hACpVIrgra25w9ghwWy
 wNmwMkEk59PLyKBkbSN62/PYn9jmVpxME5z3vw1Wt0ZtF1A==
X-Received: by 2002:a17:902:d510:b0:2c9:e846:a589 with SMTP id
 d9443c01a7336-2cea17f9ccamr157653545ad.13.1784110695740; 
 Wed, 15 Jul 2026 03:18:15 -0700 (PDT)
X-Received: by 2002:a17:902:d510:b0:2c9:e846:a589 with SMTP id
 d9443c01a7336-2cea17f9ccamr157653245ad.13.1784110695206; 
 Wed, 15 Jul 2026 03:18:15 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm129267985ad.74.2026.07.15.03.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:18:14 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
Date: Wed, 15 Jul 2026 15:48:05 +0530
Message-Id: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEwMCBTYWx0ZWRfX/KQwzX4urztv
 uwUBcnobqVAe9JoyrpFB8H48/2rlceL/OvkqeXLRkEufRLTuOaukbDo2VGzv3zcH6UD+44dvr5V
 M5u3KdruUpLNgpYfZF1s2cyTvaBTD/Q=
X-Proofpoint-ORIG-GUID: sBsA85edf1GWb-jhY4d00nu-T0FpeY3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEwMCBTYWx0ZWRfX3+N2P2/8q7zJ
 +HqyxnF0LenlgRVftExmu0YzZ+quweAu+BjLff40KS7odQpup8HUZmi7GNitQaNf//1id4X5/9p
 0kWVAaqhYdF+wWCrRP3CnW+pnQqJUbkAPQD9XlsRjePboE9afE53UEqLfW3jfsoDU5CUhogQEv+
 PzWuOPcxzkpY9HC4Um3CGKyYYc7YKJ+9sLGMJLMe3s+nxOrlXhiErcqcaBdrqA5jHTVbbmq2ZvS
 Na4x8wKIR32MObEpSuEkU95v8TXYqRoohTQ1N6XDRpNgi+pBPmaht5pCmFM5s8SAq+G2qVuv4Qu
 psOOoSX63hEvTVeZhecr+8nIpUOpIKbRHI0U+0Y1wUsMuYZCbwZSwS2r6iTPP+oII8l2g8oFNWE
 7fatrH5T82IgxVs2lmTqPd3dfHDkmFS2WXajFDD9dLQ6xsMxdQrnBjU0Q0eASXUz8JvomWeLeZN
 UkSQXNBprt9hjGbKo6A==
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a575e68 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=z1CpEO-fZNADMcIYu6MA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: sBsA85edf1GWb-jhY4d00nu-T0FpeY3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150100
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
with a 10x safety margin over the theoretical wire time. Add a 300 ms
floor to account for I2C clock stretching and other situations where a
slave may keep SCL asserted for an extended period, including faulty
devices holding the bus.

This replaces the fixed 1-second timeout with a transfer-specific
timeout while preserving sufficient margin for software overheads and
bus-level delays.

For GPI multi-descriptor transfers, use the maximum message length
across all queued messages as the per-completion timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in V5:
- Updated the commit message as per the review comments.

Changes in V4:
- As per konrad suggestion used mult_frac() for bit_usec to avoid
 intermediate overflow on 32-bit targets.
- Updated the commit message and added a driver comment explaining the
 rationale for the 0.3-second minimum timeout floor value.

 drivers/i2c/busses/i2c-qcom-geni.c | 47 +++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..f011d2564cd2 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -74,9 +74,14 @@ enum geni_i2c_err_code {
 #define PACKING_BYTES_PW	4
 
 #define ABORT_TIMEOUT		HZ
-#define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
+#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
+
+/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
+#define I2C_TIMEOUT_MIN_USEC		300000
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -204,6 +209,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
+static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
+{
+	size_t bit_cnt = len * 9;
+	size_t bit_usec = mult_frac(bit_cnt, USEC_PER_SEC, gi2c->clk_freq_out);
+	size_t xfer_max_usec = (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
+			       I2C_TIMEOUT_MIN_USEC;
+
+	return usecs_to_jiffies(xfer_max_usec);
+}
+
 static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
@@ -445,7 +460,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -470,8 +485,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		gi2c->dma_buf = dma_buf;
 	}
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -484,7 +500,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -512,8 +528,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (!dma_buf) /* Get FIFO IRQ */
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +608,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +618,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +629,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +753,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
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
@@ -851,8 +876,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
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

