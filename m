Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B072DC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 13:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF74110E1A3;
	Sun,  5 Jul 2026 13:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLvetTQb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RgeXViL2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0704A10E1A3
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 13:57:50 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6651jmFi391370
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=cx6T4Swtw2rzqvcjubzMgz9kj6YnISYvg3z
 E4tt4Nsk=; b=iLvetTQbJBGIRKQBK/HWeTVaWLuOFF6CPVg/Ea3qbP/0w1atT8h
 OfsRhTkzjJtyODEVjV7Ely5Ksc38gKi/ZcqC1bahNPwiv1gBjKWEkico1Z7McXkT
 uZmq82UV0wGRvKSQJIRaOfKGjgBIJ7gmotoxgs4F2mFcXeRkSCGZo77JW89e5mQG
 7FPQqLoyrd7rNRAIxq9vF4Fb6URRulmeH2bzJnqGDgHWUTj3kx+oeC+1He9Yj5OP
 dW5hRsuhVWYiyiJ2VrQP/Rd5aoPR+R3PAt4jRg3F5s3eOjsacDg+lWX9zeCF/KDs
 iDpNVwp1f++L3xRmbbDgN5UVvq878faJpoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh2v0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 13:57:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9e994869aso35524575ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783259869; x=1783864669;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cx6T4Swtw2rzqvcjubzMgz9kj6YnISYvg3zE4tt4Nsk=;
 b=RgeXViL2PTZar64qJ90V53RB2OHHPmbYd+rsMKp4uyuS+2146wTEOiKqn5qXzucz+f
 XLFONMb90uuO061HFJWuL7Lo+NSVclL0/mj4Q2zYt4dKd81BGApr2lM+b3I/29O33i01
 eL5DC7/G+qIXw12fuRX6siIo7FUqqWsG4T4ojnDUPlxyVahYnCkfW8oN8mMjVeYe+k2j
 uRMXWIoPX1PaKNrzUOMpCkTL2I62Ct+3Bn9jskbO6gtP/Z35axgIhkOuRu8zUN9nnrp9
 ofL7UEBi3cryb0XVETe8csBRBlZ7nU+keiwKrgH2nFumuhgDYdH+/xIhkqETry7JZyNw
 EELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783259869; x=1783864669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cx6T4Swtw2rzqvcjubzMgz9kj6YnISYvg3zE4tt4Nsk=;
 b=IKhJfChJaDVJOyf5bGACAhNMtMVtYCY4qYb+wMW551Xd8nFIYjp5STX70gTPKyExfT
 MnZrp33dd+IcFIRHZseo+xapwEQ8lv8pG13ADqOJ20MkpDmapkjK8QiI5xdFbNMu3vLj
 HZbettfDjX5EVan2Stl3c++39fKTfHqYF6MpvYNVktrfA51XMCoPWXr3an3mA3ccatqQ
 PMW+WN76v0xRfvdoMD8Rp2w1ClvAxNOAEIh8wJ4CBD4kC2ePScyVUuVW90TGB+WfgC19
 nTtco/OYCFY1Gn2sBbGK31Y35pV9KjbXOwL4XPUuZn20QUqdQABT21m62f1GJtU3LZMB
 ODkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO6peB07X/jwNqPMff8/cZzfoH83GTEgKQxrmXShz02jtMQsb7w7wAovFa7H9SKogCO4t6B4X5Oyc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIi90uKav8urhhFQrN4w4hO4e3odELlOk1OoGhyNLogkpGHB4W
 urOTQCXsMgcc5ocUSmvZzykbGcIugMyS10EFzdNNH7q9ZjnHBJI1zdvS91DkdfWaYPSUNpgmzrd
 1UJMdeIGYv/AfM1rTDAJ1DnPRF1aUUdPNg/pWEON8r5KldPkeEBIWkiF4hMIa2pEuiik/Xjc=
X-Gm-Gg: AfdE7cm/aJu5MEKzwflZF7GjxILibMcRiE49IGXwAqQmW4dMP4uKWKM+1auYhSN4RqL
 2mO1NbFvlss3EpkeT/ZWc2eGi4ThQBs1WOHGckGWG5vIXKDy4HkjhzC6s5ddAVYPFd1e/Fbsi2E
 bFJIq7N1Hm7Ncces73SeLHOTbHrogPaWMfAVcfZCQinTU8s1NlzOHOX7zF3yioe9KT0g8TuYUil
 UUAuTml1V5afrTKV0UH1+zgxuhoaBDnmJdJ018W8ggMMTOypEt2njgGPWCvwyTRBHz0ib/3lnx0
 BGB/ZESNY+7/hTdu3T3g0sdv/uYZYgIOg2H5CQZTYaTfe9Sd9lOR6vREQCmslTGtnC6l3SrDGdt
 LlGqa+q5u/sjIRaOnXzKHSaA4a9S1lOn7NppHOqq+UH/wTQ==
X-Received: by 2002:a17:902:e948:b0:2c0:b5c1:8e22 with SMTP id
 d9443c01a7336-2cbb7502856mr65740765ad.12.1783259868688; 
 Sun, 05 Jul 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a17:902:e948:b0:2c0:b5c1:8e22 with SMTP id
 d9443c01a7336-2cbb7502856mr65740605ad.12.1783259868255; 
 Sun, 05 Jul 2026 06:57:48 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7ef188sm40891603c88.2.2026.07.05.06.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 06:57:47 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
Date: Sun,  5 Jul 2026 19:27:39 +0530
Message-Id: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4a62dd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=oMrrxSgkesIj4bXReV0A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE0NyBTYWx0ZWRfX6p2qxalqKZfW
 Z/+FEmQlEGSwwuzBdNIjH4s7Rv/JTSm1YMVM6NBVdRrs3D5xQ9zOTIWhGf9j5nVc6bx/zZPMiTB
 XDkFGQkHtXr9IuD+if7Dc1fLcxG6QUoVr0zFVFMOtWuzqMw5rhPidjZhGK9rVJEk0zV2TOxLyoR
 78BTm/AiMR+idLX6UuokYC289Z+EDFS6F8JI9+atqfDxzBnBE2IrtfrWjJwgX8ubEcyXj58r0A/
 1AssLoZ+YllRrGba35Wsbv122poEU1rd5S8EMUqEIeeGJFY7h4UJjRsHF2bUVbJYyVlqfefq46s
 omnbgWxKCmtaI1gRuUQ0BIz7Ia9jKOquZCjPLaac9MMH4eFTDsVjP/6sk3H1lk14+ZSkrtWOMkD
 DmZcRWu+M1tCv6Tyv/TVdcKHDT5hUM0VblxuCVHrlOhH91jq82qEMppzzKXc/RHxLI1EKXH7m09
 tPbEk9LX2IB95OKeyZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE0NyBTYWx0ZWRfX14gXw4akq8Gp
 vubglqNlMEQWaV6XVRUg/k/vhZfgAJIyzSj6oTGOonR8o0cnZz3wJwRGn/L5bozUYz1fQm8QgIm
 lWfvC++kPu1cnXQu7B9UsFb4prVsttc=
X-Proofpoint-ORIG-GUID: U4dOsp-kH_2qoHYoig5pEfQUpHb5iZdm
X-Proofpoint-GUID: U4dOsp-kH_2qoHYoig5pEfQUpHb5iZdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050147
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

Changes in v2: 
 - Remove accidental defconfig change.

 drivers/i2c/busses/i2c-qcom-geni.c | 37 +++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..43ae2121f01c 100644
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
@@ -471,7 +484,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	}
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(gi2c, len));
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -513,7 +526,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(gi2c, len));
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +604,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +614,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +625,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +749,15 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		dma_async_issue_pending(gi2c->tx_c);
 
 		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
+			size_t max_len = 0;
+			int j;
+
+			for (j = 0; j < gi2c->num_msgs; j++)
+				max_len = max_t(size_t, max_len, msgs[j].len);
+
 			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
-								      XFER_TIMEOUT, &gi2c->done);
+								      geni_i2c_xfer_timeout(
+								      gi2c, max_len), &gi2c->done);
 			if (ret) {
 				dev_err(gi2c->se.dev,
 					"I2C multi write msg transfer timeout: %d\n",
@@ -852,7 +872,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 
 		if (!gi2c->is_tx_multi_desc_xfer) {
 			dma_async_issue_pending(gi2c->tx_c);
-			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+			time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(
+								gi2c, msgs[i].len));
 			if (!time_left) {
 				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
 				gi2c->err = -ETIMEDOUT;
-- 
2.34.1

