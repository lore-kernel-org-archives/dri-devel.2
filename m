Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1AFC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6032089369;
	Thu,  9 Jul 2026 06:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzUTMwVw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RQrAnYJD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B0289369
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:05:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66960BbP930910
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 06:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=vm7lobBZrOzogeeSZu3t/lsBp/vgw265Z0F
 DOOPQOsk=; b=lzUTMwVwpM86ZbjFJ9yCK7tGFt6FK7njTFZy06AIu0A6AYI9hGR
 lhNajr4rP78OuO3SpD55+gFBUvS2408/pmhljHLiC7sqjaytBTA74ROSLUhNqDyB
 Jf5S5pBTLECW8ENBlct1qxjygssWjgmheodnUWZZb3fucUBFh5d46QROQlObPcwS
 HfXTENoPHBrh3PCY7iW8UEBPD0jRk41WkrgDEdntpaBiLcTmhJk3YxjiHp++AE1E
 J/gCjsspFQAOTPXYRxPMHfbrUB9Bjt88/YpBlJOFKE+TM6wUiFLBqEDcC9wV9Ugp
 mcR2GRT5NLlpKbTeygY+d3BiAMsJVAGwrdQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418geh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 06:05:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cca3673560so9726135ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 23:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783577130; x=1784181930;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vm7lobBZrOzogeeSZu3t/lsBp/vgw265Z0FDOOPQOsk=;
 b=RQrAnYJD4oAFiveO3CguAv4a5MQnL685ehjkm0zaguOyPqhqvALqy6tDaEtgOOauCz
 Jf4UnOMqi6Zzc3zQ2aQ+5XU9dDPkFI8QFSQISv2U+Vi2QXbB1VI4rNiOkh3DAfEntb47
 zDwDqf/ZX/fKeo+5AqYnfRIlHn4LmMuUt0k2Zk9kbfPXhpe9wxo7CWsEJZ4Ct5Q4hbXf
 1TV42LZVdYZ85IQ2vfWcFL9zbJljTk7NLe5zKPTN3Ew6mtgwh2EctLkQ8S+Oe92V+TZ9
 vV1HjobIL+7lZMWQqIKydN2hfdXi5CSC3se10pBRQHSHpwOd3Kpegzl6Hd75bTfQqM46
 iMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783577130; x=1784181930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vm7lobBZrOzogeeSZu3t/lsBp/vgw265Z0FDOOPQOsk=;
 b=ru02xTX1FF5tFF/MxJovLvMIoZ6pNBZA5Mb37KA20jcAXCgsuR6Vj7in+WJvJKy0TI
 cdMb+R72e6oDqbhIdXPxQt0V+JneoDdWZVQIdJvBVrxNOXp3ZC5UH/+bc6qDRhpx637W
 WazeG+kIcJwvND5Grfcjp6GDhHJB+sl1qYddYzI0oi3LHuF6SHgnoCwhfRWoSt8UPV0/
 AZw24O3R7WP9MWXXrGvgeQExrRAaIwEHDdrBFMNunV4BK7pfqmctUWGAIcgxEzcu14z9
 CsFHRqczCKpiK0ru+zTLZqjjob5fGzgU/ItVzjYpVQD4BGiqWgYjXKAPD298NqFxJz7V
 XBLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGTWouYv0EHxoH3cxB93J4fENM7wlSfZrWXVc3+0mBtdJ0WoBMEsoATD9BEYcxan3ANPUV9LOtn/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOFtGki1VK6x7+KR0h1wQkXRGHrf8tOs2y87/HiM3M8iAdxBtI
 TJb3wrlSb2nn4LFllYy3vBVE98MKmNan5XU3cujaKskL1Tk6dgBql6Epu3j0S161CkKCFKDZmfQ
 wJWQCrQwOeHoE+rtfbZK1ZAUFTLsHeOBIMYpc+PAqIVb1IOhrqDZXajhaEwV7jJsGtCBnaW4=
X-Gm-Gg: AfdE7clHQxGOnUxPJdgDSeMcy4dAo2KJhfDHrap+tgGpRDs0uDCsg27H2LidixKwuQp
 8+27PwClX7M4L+nBYbzMon9rYsPwu8xF7/gVjrrrRUVjm0V5B+T4yJMQbYCakwiniApCA8S3Ycy
 sCnf6rBwrbyUA7YzkgIOfblns4oO8XYuhuCy8mGk8xVYRTOqhAOjDHOBv9e9fIkP01tglhdfdVF
 nkDx9ouODObm9LPi34nqADu4zL87jOphDNmqHgROkZ6YkaQMzCmMyBp3RV4PH6RAUH1keu6uJ/O
 zBsYKBA18VQ05Ny5jo8K/mFFji0mo3RjWrPJTFsCOJCFB+6dUekf8oU68VjkZhbbg9oCWnSfUU1
 XFDwKqpShzyc5zCojHTAjV2kMAl/TVMs1vbmIXXGUPCWL0A==
X-Received: by 2002:a17:902:d2cb:b0:2c2:bd7f:ccd4 with SMTP id
 d9443c01a7336-2ccea3e1fdfmr65120605ad.21.1783577130374; 
 Wed, 08 Jul 2026 23:05:30 -0700 (PDT)
X-Received: by 2002:a17:902:d2cb:b0:2c2:bd7f:ccd4 with SMTP id
 d9443c01a7336-2ccea3e1fdfmr65120005ad.21.1783577129651; 
 Wed, 08 Jul 2026 23:05:29 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1f030sm38128135ad.51.2026.07.08.23.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:05:29 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH v3] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
Date: Thu,  9 Jul 2026 11:35:21 +0530
Message-Id: <20260709060521.4091523-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4f3a2b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ThEsosvJOpkTSRB3RXoA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfX51VfLInSZ7R5
 GtXDUP0KaMEOGAQ4+E400fjzdhLdSq2QaBucz9frkJlWkZ9Tu+dVq6cYqjZRKnhslxCS37xLWwa
 TuQSqhSCKJyFL5kXV+tDJUz4HvqSWCFMjGzPAv/WaR2EPlUpC+YCdqKCuNekrnf4kgP0W07HpCP
 pq/8O9BzK48CUuTH00GmC8jHcfz+UMdGlvAt6Dyh0R8YRFtlJfQYCJh3hNM03EJ/KGqPORVzGYc
 9TMGXr0b/tLf1Exj4+cYfTA2jRKZJrRD8F9anSWYc2tJ+JPZ+EsdLGchz7bDlwJotQLVlV7R6yv
 8UyYmaf8JIPTToB93PEIb2M1oLS1p2e3KpEuAiKCino/+T/2uOMEAw3B+gB5Mj++4ju+UIZsOW4
 GDItyFhEjZ3F+SdKs+74mZFPQ2dVXm4xYbu1uv2g+eTl4Qcb/TYO1Bya1xDgxAMdmhpMDLAE/cd
 4kILQOxXFd7zO60ygzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfXzF0JNp2p4r+/
 EY33d9HgqJmBop4SQummwwqr3D8FETqNMN7EgvqevH9+FGNWUUcAixipGL7iEjXcC7RYStjiDXZ
 kXavPUg/pmQWR3we5RkBfsuf6SzO3WA=
X-Proofpoint-GUID: yOGsYb8gij8akgmXL9OylEIL2vSOvG0v
X-Proofpoint-ORIG-GUID: yOGsYb8gij8akgmXL9OylEIL2vSOvG0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090054
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

Changes in v3:
 - Added the extra variable to handle timeout value.

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

