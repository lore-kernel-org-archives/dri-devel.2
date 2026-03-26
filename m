Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3AA109E546
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 04:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346E210E91B;
	Thu, 26 Mar 2026 04:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKKR2OBd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TiC7WvWA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238C610E8F7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 04:31:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PKhex3142445
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 04:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jJRKMt5STVkyb1Y7d1ZgMO
 1sueYs1DgBavRo6QS64AI=; b=hKKR2OBdmKOqiTdbZ33hIuMhZ7JhUlOiO93CcH
 DiZtkKn4ZzwolbcR/CwQhTILnreUv0fRddHGSqh7q0cmXbE/A7mxKhFV+R1ogc80
 lhHH8vDCGt17uqM3QSpcv6tfZtbD+MICx7s++bLr/jcSBgS1AnRDFwtNXLG+6ayz
 hRWyuph9K6ZJv/lP6CNm2H2/ExRSupTSt7/cu0Tzu76LkaQFFCyPBepQ2M3/WvIc
 J9xuBcB+qkvEhxejPXgEff/oU7iMB3As+oCu9W/mvN0R5oXzMczXpQY23wX84u+o
 IHBEI8tJUF7r/+BXEfR4A/GWj8EKWFS9KP2gol5WElMqucsg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q0917d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 04:31:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c6dd66f6dso1254447b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774499518; x=1775104318;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jJRKMt5STVkyb1Y7d1ZgMO1sueYs1DgBavRo6QS64AI=;
 b=TiC7WvWA9wr3guOxDuZN39Axe/ruNhnsxJR9pH5fDqxsWhi4zBd1mn7i/fYlLqvd3S
 eO0/q02ZWLo5/PLvufGGMNXzyxzT3Vq63DYQaDpW8SiAXG4OIckY8/7pVYtYSBJAeOBb
 gGVmu7hRQudgZs6HqUL7TEzTVy7608WfmPSlrqERFwyfZGDANOviTSCjjR/iDDs/EdWO
 bSZBxj4+9VtqlYjHPX2u5aDoFHr1ViqEMFo8vB65pQXg55snCQBevuivWFq5tJZxDI32
 xSIFCW+89dherv+EFwlofBAB86/nDQKc42pDYue40dJ9RbflEAMBPTeZtWpbP3fjSrxc
 RMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774499518; x=1775104318;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJRKMt5STVkyb1Y7d1ZgMO1sueYs1DgBavRo6QS64AI=;
 b=qP4f06xLINW383NgOGKaj7oTEKHDC0br70nPOG2O6VSZTocz1sybwKKA3teDBP5Mw8
 t2DaAA8jovhmxtLpfQdHlJspxn/kzQTVt9EyUaA5pyx4M9eJ/TDFO5ie+7qJtSNydV6j
 esOCYtPwVn1GsAXOIAh+/aioufqZs4QaMKIw+RcwxpPPG4npviXcPmqXbGs4PbSXIiXy
 eObVZWjLMuDgmu5swtXaJHdDncxFWgsqBBzIgcdpwWQsz8HphidQ/I6sT6VKRjDvkzb2
 g/zx3ymXDEYBl02HlbFAKc5sIEzPlZhBzhEeEUCTercF5JW1gODnAzb8O6F6NJLrWsbR
 VZXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBR8PABxZjWODHtKMlTtp2Ff1yLjIqa/w4l6ycp/PiphIzrp6dr9vT3CbImfbqQX3d+eVZ2xAX55w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHAaap5oPQOUQsFGOkNkVLveFBjvrTh5Db2J+hu1DWQe4jf80F
 J+n/Obo6zos3asbZho9Qy5hP3jcDwrKDqrWddzOmaZD1//+EsKFLBHf7YowKTgNrOA1sWH5klA5
 E3bmNRqkehwNHmfzaluWCprDdPWhVraA3N5Bqe7qnAJggdRsP6Sr7uV6BI+nHPiaCizdd9hA=
X-Gm-Gg: ATEYQzwj8bIqkWXuketsws+RrqU+PxExouW8zgT+4kjiYD0ZGeJ1EB9W23g7Wjm4s7s
 Gk4jhcgOOtXVp/gD2GVIJIdCI74KUdfqlmQWIkeb9SuNCwV7JWrtxZVLrBtR6SATekay3Pv/ajd
 6ue/uPBNGb5Ff7I4Myg8NIoyeXUzcVMZtU73shRIstXk7ObeRPbmia+zBy3h0+9zPUU3Pb9LxlT
 /Ds0gF5lSYq/fkLb4+MzepLs4TcAS0Q1Eb8y+zd9Vm3T/V9eHtwkviM5jCOmMD1WatCcupHEOcM
 POE6uX0jIHimCYGbj6i2PM+mCEBLlK/vodxS381UZ+WhX02hHD+NOf32dphfv/T3T7u0bhpQel+
 b4W0HMnaYwGJn3NvmUUi3AxkxIOg15Bc8EXXc8vHcaMtD5eCv9c/H9Qov
X-Received: by 2002:a05:6a00:4b0a:b0:829:809e:8981 with SMTP id
 d2e1a72fcca58-82c6e0e616dmr6256933b3a.31.1774499517615; 
 Wed, 25 Mar 2026 21:31:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b0a:b0:829:809e:8981 with SMTP id
 d2e1a72fcca58-82c6e0e616dmr6256897b3a.31.1774499517105; 
 Wed, 25 Mar 2026 21:31:57 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d22c8e8sm1177396b3a.24.2026.03.25.21.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 21:31:56 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:01:48 +0530
Subject: [PATCH v1] i2c: qcom-geni: Skip extra TX DMA TRE for single read
 message in GPI mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-skip_extra_dma_tre-v1-1-deef018895dc@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALO2xGkC/yWM0QqDMAwAf0XyvIKNOLb9yhiltqnLxpwkVQTx3
 +3m4x3craAkTAq3agWhmZW/QwF7qiA8/dCT4VgYsMZz3WBr9M2joyWLd/HjXRYyvgkJMV1svHZ
 QwlEo8fKf3mG28DicTt2LQv7dYNt26Um64XoAAAA=
X-Change-ID: 20260325-skip_extra_dma_tre-a3cf22f81d9b
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>,
 Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774499512; l=2657;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=NpFXvrYh3Fb7+pGlr/Z61Pb78xmA51Vjq3Rxx3qOVtg=;
 b=F4oCSfY3o5eliC5a/9PowUrf5FxpGtSwz/W4vzzQWSTjf14iwuzX8WrayFTCnK9XM9yo9kEL2
 Iw5BwmRKNyMAZKpj1OK+i5GLjGWoi4vXfVo03bhtCg3FGxQGx7hFxXK
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Authority-Analysis: v=2.4 cv=fufRpV4f c=1 sm=1 tr=0 ts=69c4b6be cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QTaY6CSZEmO6sGPGzGoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: wFGCXSRB45Ga0IPiibBdnIdqQt6Tm_iv
X-Proofpoint-ORIG-GUID: wFGCXSRB45Ga0IPiibBdnIdqQt6Tm_iv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAzMiBTYWx0ZWRfX1x++pOMhO6QX
 nN/zonE9GZhbtieleLVlLIIITBQhRIpWLV7Wi0UDFS5icZMUW6HFhfJZH0Oj/n6jHBEdvodsvuV
 vcpUhEtF4oULEqelNn4ubYs3pB9wzxKDkBlg3YRs+BVVgcKCKYZe6xgaqwQSD9Nhj7vUqfI0FTy
 In//tnkOvDuuQdWyBe82zs9z04Q1dh9TFQ1Flg20oicH3gbWqJ3Oe0m3zdmSpP1IGaYZI4cPqaj
 k+G9WA2WcdSIvJxmPHQVtoHHX/Udh+nKkMb+NitiAJ1PqVjz8f/5CqCkNnC1pkG9gEtY19kx+WX
 1uBECVj5zryEeRlt9zCmkblBF2dIqJE/TTVBc3hdCyHUd0PseFC2aaY/+2RgIV0Bp1/3u351Ac4
 QkOUSND0nFPYITnDs01YN5EnTlhH+VxPFQ7Zn+QkdXvTGCkXXuqM7pwTcLWVupebxHE/xpEo0hp
 pH2NnMlJo6T95oxGQfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260032
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

In GPI mode, the I2C GENI driver incorrectly generates an extra TX DMA
TRE on the TX channel during single read message transfer. This results
in an unnecessary write operation on the I2C bus, which is not required.

Update the logic to avoid generating the extra TX DMA TRE for single
read message, ensuring correct behavior and preventing redundant
transfers.

Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a4acb78fafb6..2706309bbebb 100644
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
@@ -639,6 +639,11 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
 	msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
 
+	if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
+		peripheral->multi_msg = true;
+		goto skip_dma;
+	}
+
 	dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
 	if (!dma_buf) {
 		ret = -ENOMEM;
@@ -668,6 +673,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 	}
 
+skip_dma:
 	/* set the length as message for rx txn */
 	peripheral->rx_len = msgs[msg_idx].len;
 	peripheral->op = op;
@@ -740,9 +746,11 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	return 0;
 
 err_config:
-	dma_unmap_single(gi2c->se.dev->parent, addr,
-			 msgs[msg_idx].len, map_dirn);
-	i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	if (op == I2C_WRITE && (msgs[msg_idx].flags & I2C_M_RD)) {
+		dma_unmap_single(gi2c->se.dev->parent, addr,
+				 msgs[msg_idx].len, map_dirn);
+		i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
+	}
 
 out:
 	gi2c->err = ret;

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260325-skip_extra_dma_tre-a3cf22f81d9b

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

