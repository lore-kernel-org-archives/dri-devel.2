Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D6AE99071
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D877010E928;
	Fri, 10 Apr 2026 10:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndPdVVLn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DCUeU93m";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B3810E920
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:19:58 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AA5aKV1498597
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6jAgrIXul/6oRSYYubPw70Q0si68WXVn+fa
 kGuy+ODE=; b=ndPdVVLnGPt32e2MEzl7sTuz9/zVb7Sk84BklOIbc/rtOnMHJEL
 6J+fQmw38SM2WVmQRhoUZxq1JPCnytnNgArI2MVnT+7H+9+tsq0JMpTHzF/xgKAd
 a6IH4gcMXW9TISx4eJ1JpoF5ESDjtT6gjEquabdsRmduxNHxtVD2uEzbJ34suXz+
 WqwbGrj4lFSE8uqFuyLx/qQcmXTS266MnkSJSXqfy9tCcrS367sBehXCLdq20vlc
 pGC7/r0GVnkNCxZoLcI5VUv4xZkN/l7EaEOGEsMf8cdLCmtyafGpMMA7qSNJr7Va
 QApP0LKWRTcmc5d/DwrpEJSBJgRAMzDg6jA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b024j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:19:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24305cb3cso19063705ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775816398; x=1776421198;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6jAgrIXul/6oRSYYubPw70Q0si68WXVn+fakGuy+ODE=;
 b=DCUeU93m5eFdddgFK2Co2I2c8jI4wTbPw7djHv+X+I9XHP3J6hBEKR8K92wyBsww/1
 rpYjMOPY6S5JtaacHDNCWFmTjLaWc0LE+/orP9lgbFrCTtQ7Fi47j1Cx5fvD5u+WcsNT
 tyJLmtlxCC7sd33e71nRQ3cG1x33dxWHlq8EI0hY+VB9238H+h3I5PBLf8cAcnAyvjqH
 bM2eqMNaGTsouY0HPUea6ZAZvA8kX++mTeUMfUZC8ZjB4CbsXwACFy7Zc0hpGJqGR+jq
 bJ3U6qQAYa/xgLQLRUl94XumHaVX0IRf+XKBV45up2/2SAumjuvZm6E8HtCLgZGAYLaA
 IPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775816398; x=1776421198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jAgrIXul/6oRSYYubPw70Q0si68WXVn+fakGuy+ODE=;
 b=rljiy/s4DECR1qcv2MLRMWVdnoG2MCFPfGZas4023tVnzj4RISq9xsLaz80ECmd41A
 YVOSxFI9it05v2/G637TVf9sPJ0jnAb7y4dBj0eVpLlG/s7pSUwT8hRAGtSCDQXgYTSP
 Z8ZL70AfxcttAsffxvk4iJ/2KHUrQtL/zGnJLUj+kPT3XS1FEP+de+sXPZHHdVbWkgHH
 +AOBqC1b+tBCThJBJtEqnl886kGZZEuGRGBVD53EPC7k+VCAQt6qchYtJ1zMGNo+hEUe
 1gDsW2OUzhuxrGqJsMidTTSn9KKx4BAb4bXhrq2qfCc44XFhugIHLa6b3suX7ADb6dcQ
 CT3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrCFy/17SO+dulNUsYSh6KbtMqrfIgr6nK1emp0xbi6ES8uG+JTn9FjKtaMVBumKM78wwiNUIW9p4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywvu6t5uvnK3MS2vMMGJfrX0rqhZHSmsYXVgEV/VK9PnRwCT0F3
 B6itfhoh6zsih9RWQW2AAaEFRaHSoewBPJ/JfjJ9koSa0WDSjxA3UmTCOjZoHFfec3saSt3eOeq
 ycsofy0L+3puCFFZd66fHkQVMnl+VSdJOQeqyHG8gdNY6Y1TS5NPO+I89AzNqXo+UP306iLc=
X-Gm-Gg: AeBDieslqzPpaiLWgIspp0HUDsihYaPhQvCNMWVK/ywo6BADoKCqlpB+82OM9GwGZ81
 xzByz0LFD0WCEm72D9IviKcWStSrhMD8lrLz4xqR2xQpbpdYaTAni/VveEOB//4RAXJvpetHi28
 IBTkXnZ45kJ/V7eZhMjmK7NmPqu0Te1CCLSgLTedQxITId0+uQJ8+7FyDEYu3pn8r6bS8uLmooO
 YlUIR5YXj9WtaVgKQTScLybdAdKPS9jgCZZEI92Tc/DLQm/SCLhAJEerol+0bz34Ipx6oTLxfbu
 yXdBJTrbpW9XWr7aNusnOe3QxnwiFMQZ4OwIXXMwmIRgHFS2YEXccHJDYlVH1flS2f7cdshzBfq
 INBaVRi9Z9jK/t4hS1ESCDWLnQp5Gwc4joep/EYd7RNZEqVokMfGmK5no
X-Received: by 2002:a05:6a20:9389:b0:398:7855:1596 with SMTP id
 adf61e73a8af0-39fe3c64b7amr3091121637.10.1775816397574; 
 Fri, 10 Apr 2026 03:19:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:9389:b0:398:7855:1596 with SMTP id
 adf61e73a8af0-39fe3c64b7amr3091085637.10.1775816397075; 
 Fri, 10 Apr 2026 03:19:57 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79219c618asm2024362a12.18.2026.04.10.03.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 03:19:56 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V4] i2c: qcom-geni: Avoid extra TX DMA TRE for single read
 message in GPI mode
Date: Fri, 10 Apr 2026 15:49:49 +0530
Message-Id: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7SNfzG0oCAJrPNXYa-e8MOMslKdVVH2l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5NSBTYWx0ZWRfX+mfuHbccaEy+
 rFs7BUJzPpzUfjwEZOOM41zjjLSTkB1yY5TAggNsgrwDWO3yb4vMgVWIrT3aXi+CowfiP9Nys/r
 RvO6Q807ojFGK16t4+gtr2NN2kS8hJisUFES58cF5uIipTUuspNuSGFa7du+OKzw6UbSNz8lQAu
 nQCBjrCBH9k2SN5oi310mK8hb4Qs/AMbvigvl5GP3H2XaXgDcRkOTmybXGwQfF/WgyXFp0qUcGO
 bhmYk+Qtr09YaCuxaJk/lFFkcPCpyab7YJkZCHMqUIdBxvcRrOHx+0WONQNj9g0vdEOZkn6oqh8
 h1+otgR3x9iuQUwfRtzeW+hwIMM85aN64r9J3jTVaPq13x4OMsI96x4qQmMPHG4S2Qk8Do1uapT
 f6qsk1OGAlan2uAa+uxeA2hYpy4vIlkjTidDCoDGHOPcmjyuRShjDVHU0LxuyICfbDRW+9pqX6v
 1X8oGuZQxyPiI5E6jtQ==
X-Proofpoint-GUID: 7SNfzG0oCAJrPNXYa-e8MOMslKdVVH2l
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d8cece cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=g-2Moo4YgOi5Nr3pVm0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100095
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

In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
descriptor (TRE) on the TX channel when handling a single read message.
This results in an unintended write phase being issued on the I2C bus,
even though a read transaction does not require any TX data.

For a single-byte read, the correct hardware sequence consists of the
CONFIG and GO commands followed by a single RX DMA TRE. Programming an
additional TX DMA TRE is redundant, causes unnecessary DMA buffer
mapping on the TX channel, and may lead to incorrect bus behavior.

Update the transfer logic to avoid programming a TX DMA TRE for single
read messages in GPI mode.

Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in v4:
  - Added some more description in comment and changed the label name.
Changes in v3:
  - Added comment in the driver for better readability and changed the
    position of 'skip_dma' label to allow dma engine configuration.
Changes in v2:
  - Updated the commit message.

 drivers/i2c/busses/i2c-qcom-geni.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a4acb78fafb6..a482a4c60744 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -625,8 +625,8 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 {
 	struct gpi_i2c_config *peripheral;
 	unsigned int flags;
-	void *dma_buf;
-	dma_addr_t addr;
+	void *dma_buf = NULL;
+	dma_addr_t addr = 0;
 	enum dma_data_direction map_dirn;
 	enum dma_transfer_direction dma_dirn;
 	struct dma_async_tx_descriptor *desc;
@@ -639,6 +639,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
 	msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
 
+	/*
+	 * Skip TX DMA mapping for a read message (I2C_M_RD) to avoid
+	 * programming an extra TX DMA TRE that would cause an unintended
+	 * write cycle on the I2C bus before the actual read operation.
+	 */
+	if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
+		peripheral->multi_msg = true;
+		goto skip_tx_dma_map;
+	}
+
 	dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
 	if (!dma_buf) {
 		ret = -ENOMEM;
@@ -658,6 +668,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		goto out;
 	}
 
+skip_tx_dma_map:
 	if (gi2c->is_tx_multi_desc_xfer) {
 		flags = DMA_CTRL_ACK;
 
@@ -740,9 +751,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	return 0;
 
 err_config:
-	dma_unmap_single(gi2c->se.dev->parent, addr,
-			 msgs[msg_idx].len, map_dirn);
-	i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	/* Avoid DMA unmap as the write operation skipped DMA mapping */
+	if (dma_buf) {
+		dma_unmap_single(gi2c->se.dev->parent, addr,
+				 msgs[msg_idx].len, map_dirn);
+		i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	}
 
 out:
 	gi2c->err = ret;
-- 
2.34.1

