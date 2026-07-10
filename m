Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBCCC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABE410E121;
	Fri, 10 Jul 2026 16:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="niHyyzJ9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d26RFb7k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BD410E121
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:11:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AEmXO4960697
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9KheAc7I+aBb0Mu9MvhRuCgqeY8ZW+ixLVF
 g/AQ6n/g=; b=niHyyzJ9n6F4jllZESey+VgnsJ0EmhI0zq+OrGKZ2UwTUmL+iVx
 MbG+8FhcJ9BGjmfpQNPgJ10f3rax8Yy1oVVmGZexTbWWfEXs2zyGUEx2Xx+XHoGP
 vec/AL4xZr9vJRXrNgKyhH4BuDWhg85OkpYNKccqNFArk0DywZIIzTLHH2dHMq8V
 tds6InoIiZLKpgKPjpcXteW619tfxI/VIYu+Ulvhf6wFJQRT+g3quUsI4f+lTE5t
 RjXLxLhOWy2vXCbv52voip4K4hdIVLhFXTw66snsH86nWSIz3AmsCUDPsnPrwrsV
 UsOkVzZUIoCF+XKmIP6GrfxsBS4AlrG+hfg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txgb53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:11:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so1488100a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783699867; x=1784304667;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9KheAc7I+aBb0Mu9MvhRuCgqeY8ZW+ixLVFg/AQ6n/g=;
 b=d26RFb7k0phARFAQMuC0oEXs2tNTsn1X3tEraIO9JbgK9W6uQ/OXRNJiHu1XMRtach
 zDU6CxnUeE5GjMttlxJB3Dvb7Oy4X85AD4I1/g+g5x3SEH19QYId+WZGYND6rs1nBvjh
 6lEz9KRRPNxmTezQ+Rzy+U2AX3yFsEjpnmMvqSek7FskpG7jC+9fgLZH/WSWDAeVI3AU
 8RmqI37s9QCQmliVPtXZp3aVw3dl3ibwuCpkabZL55SBBMkkQu2HqOmfBNj9s9qN9Pwo
 +HqnWGqL9gmIj12erwY+Ub5xTYSVrLsMWg8tgQCh52De8rETOIj99B3jO85Uzl+PkgMH
 34Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783699867; x=1784304667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9KheAc7I+aBb0Mu9MvhRuCgqeY8ZW+ixLVFg/AQ6n/g=;
 b=CJ196XxJV34t0Ah7+LKDsoQcAgqbB9glff17jm+rx9D8wLPJ9L3FGPiYbahGN2llnZ
 hV+U75jbfzsTOtMjDYNka+gYgInt78vRUNixq6Xc0jdNo2S2Aul2m9/8To0+WmKgRn8W
 9xbS2S5N/lJYbbn0wLpLCOvD+aI2/FLyFEwhLHpOyxP3VJ4zDmWYMPO7GJA8pWXaVX34
 Dqp78acHAdrLLbRbPZoJXL/poW1slnmcDoUTxotLFDYVil+EqA5WGxsceXWpmOWA8EwQ
 rZ+gUO4sY2VCc6GXN6t2J0nMSYmiEcndgPdDVYbrng/34A3UIs7GxddiMETPUqip0Byr
 OiVA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqn3ZwhL8aWxVfN9rNi5wuA8S0qVrCN3yXjbG60ge7ZGuFYWObfu3+UGDKGQyT5g2UNV1jcTzRKfbs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqYunWuyKOSdBQsq23KVNoTZ1PxC+phOvf+zuiPk0aQePoEXkc
 D8y1+XxEQiAR5FpKLMghvjB9yJjReObHvB1GQmTwyexvmU6InmmQy+Y1jfOxJFSzvaiZZbCcceJ
 v0LP54gUiiUOzkCiHtmgJpJFkh/H+iZ27dO0wpNJRIsHyoGYwPd304LO287xsRfknUpS3p4w=
X-Gm-Gg: AfdE7ckIPc6+K/mFu4oVbETjL+J7sX/+VoqROeLHRph5IUFQm3tZwgxgY03fXL9uU4B
 1zQhZaVJF+ZuCAXD6kUQa081a5JxWy9/1sGL3lYFRWE7G4hUcommulTu57jxJA96eHG1IFYo9/B
 wXRHSQcoUaY+45nvuQyk03eH2SiI26/mczDK588IZdsX3uBGI7H6sETFjKaEpB4MmvHcjvIXVLK
 +i/fB5Lox4aPKed3QrB2gYT7jL1vZ0BJxUGzz2Vw8N4Q0TI7zxhIcPARYYKoixiHRQHeIIaOLZO
 /2fPajlLJdCypJUPDUVlgpYUGNYqbCKt+izS0ObKMY6IOplTpGOs3A676ipeexsi9tLjmk5xeTZ
 mtv6b4XogIikvj294rXSQg++/8D61eUjrIz3XuTLxizYaaA==
X-Received: by 2002:a05:6a20:a123:b0:3bf:97e8:a026 with SMTP id
 adf61e73a8af0-3c0bced45eamr14574924637.25.1783699866553; 
 Fri, 10 Jul 2026 09:11:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:a123:b0:3bf:97e8:a026 with SMTP id
 adf61e73a8af0-3c0bced45eamr14574892637.25.1783699866069; 
 Fri, 10 Jul 2026 09:11:06 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3b251eesm5128818a12.31.2026.07.10.09.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:11:05 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
Date: Fri, 10 Jul 2026 21:40:56 +0530
Message-Id: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a51199b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=z1CpEO-fZNADMcIYu6MA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: TvCepMkSfKZGl1sKJo2SMxVSfMlNQcgp
X-Proofpoint-GUID: TvCepMkSfKZGl1sKJo2SMxVSfMlNQcgp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE2MSBTYWx0ZWRfX/1otppXablyr
 c00bTKz/slGYSc7ugq1EgNravnpEjIxJax6GVqscazr16jTNsRuBQphYqm9PNOxmkDBhTnA62Wq
 qwTtZBffbeEUSdtTuX+BCaivoOrnDkPQY78Vh/4gg8w2p+0V04hbtaVDQB7Uxv+HRjQI837XGC0
 s02yN2mdXjxWoKmCzmzXTtJWxkSe2OvVhbj5bDJMtdrrMvirHhEeSH6Q2UGfraRA6jsn/NOdC2X
 g7eO26iPjw3ofOMWNKtEEYNuTRxuE97clFfQbCbtX6gyRJJcZgweRL20dWMWQRrsEJzgvM/c4rX
 RhJLnBsjKhKzQJU3/72oEOK96sykc6QpStLObAkXLSPi7f/y1Lp/vVMzegAb1cOtfiiXUplqkhZ
 zkc4hzxqjAnm7pfCbO4nZ/YZVVH1aPZuGTupg9ADf1NvKQz/bpJ3FIqs6FkxQ6p5YZcfLAvpwc+
 Lgv48foi5vtFyxwOEJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE2MSBTYWx0ZWRfXx8eeXvfMxZDz
 sYxytMmBXXX1wQlgpFgkn/RswMYl1gZxUxa9t5e7ApIk2bVrWJ8vIv/H+NWz3h8ylVyGEvli+w6
 YOImanBbCJYrutog6lcTl16IMbOL8G8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100161
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
with a 10x safety margin over the theoretical wire time. Add a 300ms
floor to budget for I2C clock stretching, where a slave may hold SCL
low indefinitely during internal processing. This detects real hangs
3x faster than the old 1s static timeout.

For GPI multi-descriptor transfers, use the maximum message length across
all queued messages as the per-completion timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in v4:
 - As per konrad suggestion used mult_frac() for bit_usec to avoid intermediate
  overflow on 32-bit targets.
 - Updated the commit message and added a driver comment explaining the
   rationale for the 0.3-second minimum timeout floor value.

 drivers/i2c/busses/i2c-qcom-geni.c | 46 +++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..c5c3adc8ec77 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -74,9 +74,13 @@ enum geni_i2c_err_code {
 #define PACKING_BYTES_PW	4
 
 #define ABORT_TIMEOUT		HZ
-#define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
+#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
+/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
+#define I2C_TIMEOUT_MIN_USEC		300000
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -204,6 +208,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
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
@@ -445,7 +459,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -470,8 +484,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		gi2c->dma_buf = dma_buf;
 	}
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -484,7 +499,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -512,8 +527,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (!dma_buf) /* Get FIFO IRQ */
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +607,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +617,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +628,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +752,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
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
@@ -851,8 +875,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
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

