Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90398E7E348
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0DEA10F3FE;
	Fri,  3 Apr 2026 08:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ej4FKVO2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jx2SOWAq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7349610F3FE
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 08:41:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63344WAe823112
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Apr 2026 08:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=QmKfAmOnOoidKU2K7M065NqSIxZq6+lb/9v
 nAIyjv3o=; b=ej4FKVO2FH0oAp4MNdN5hb1b9k5gUhvwvlo86YCJVpzdmzRdxvR
 tVGpIhdjlHoSoeJQnQY+VGGu8Ul+8RQTGPYnGX6MaynkGvZFP2sZgBKU2uwphhzo
 s5MJt6+hP552oi9ARgCgfGY++KgDQVAKc2sgtxwtD7dK3hni3/1DQDOIcBi/+EN8
 o4uqXMR6qtpoDohrSaLpUpuJfRVVSgt2JgUrMWBNq9DQj/QABvcvWuwPi9pZ6Ju/
 hqfMW06cN+a7m2Zz8zYklHS6vFkvZypXv27+X3/vsSj9u3UDBLwD5taGuJgBncyK
 RLZsY9ex3S8ZCYn58Pvu9/UXYxA1DWpWDvA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da6738rf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 08:41:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82ce0a9e558so1260896b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775205704; x=1775810504;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QmKfAmOnOoidKU2K7M065NqSIxZq6+lb/9vnAIyjv3o=;
 b=jx2SOWAqT6tDWIBVuuICd+SpOF7lJRswBCEa5H/53KFrvUCj+lrnVVhJDP5IRIk/eH
 ZgEj5qITOqmP1NDu1+RQikV5ol1agVe+k4KDQA5Jx4589hTr1LX8KXmkjYTakUw6xRtp
 5dHjOjTTuE3zUIHpETEI9HPeuwC9g0seSWKvrTOnDOnFH0//ssUi8G9M6mDOkqmzgg2v
 3ZKlEt18Omo+HimKC1UUGCOhiZa+aIhv/vZdMVZ6lVg0/isATM7pF4+urHkH6gSWy4kl
 EgZYhy3TFT96Fpddmv8cSF2joKS4a9+FxKmRqFdEKLzNI2O2bwDQldv6qTHKnAoaaHQt
 fYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775205704; x=1775810504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmKfAmOnOoidKU2K7M065NqSIxZq6+lb/9vnAIyjv3o=;
 b=QjG5RxhqJWtG9zF4qu+NPhpeDL8fQn5vM2xRjbUCpnDd0qq+c5W0L9N0R5VZlDjASs
 Ky1SpTjwMiKwx12a+jgb4XW1FD08oYKB8v3dL77ND8oGLchde4Ilf4lwxDjTb3AMYow6
 XbO99qMGEvTsvR0qZuRJEPLYncja253NhgpbZyZ83LDQOMGw6ma/QZN3r2hOKIi1/XM/
 idPm+cAcNB9Zporkz0sHDFj71RFRTXkTLaB/duBnOXt/V1rurOtU4dWtRE+eXCat+w1A
 EOz9+/qfpCI41oLM3BE0b93f3t9LeHMzNhXU63Ixfigca+CtNeZ+osakga46KEXzjgKl
 ytFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9FQWppSmF5mWqPEUQU4js5Dlg5U615oUJ06hRhukmfJ2lCuSel+xaKub3ChcyVf3aeIW2PQXS9C4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxh1CePoOj99NM7kThCf/tpSaBNhlBDE+Sqos39Sop1YmCXs9n9
 a0rlMHY8hIl+xV5cXvfBAg9DdHCy+FNlR73L1NHde9r//ybKTYYw2NddLAIj4Ea4Pl70od0X4n4
 KImh8VBQl01G0xD3FuD3QhfREAorJldSvBbK+YrUQzBZ/8NN/NgFYDTQHWt20t4IB6a8IJhI=
X-Gm-Gg: AeBDieuM16J9uxW3ApoSTWue0tJJCyf3f7PUdcpVJcB3Un6v1a7yTqNc5llE4ZX6BLb
 VcT2jGZahhLDOPR7LJ+odciuhH74ua44avsbyYr/nGX3wlcSCW86GcjGzy9X/H1KXR7XUB+j4bL
 Dp+FIuXs8858j1KIfkRRiWWse+hGH7NsgWIk6LN6ZNa55bTYF57O6Q6doCf9Og1ZfcBAYOXLMGZ
 POsQXiQBSWrRTocwneekPk3GAZ2IygdOcotdzzLQawNUPEFgcSP5d93fXfQrV/lW0Gwlp2bU+hg
 D6g9RhKB0VXsmQvPaixcR6H1swzwSrk7I3qquVNU84Minr9akLQnk6QE35bnu7nwMe8QPTthDxM
 avQYZTl2SuMNx/eh4Dwf8gvD9nOFW13e2nrIuvgHbdKezmq2BPcwwWWBI
X-Received: by 2002:a05:6a00:2d10:b0:82c:9c47:fef9 with SMTP id
 d2e1a72fcca58-82d0da34535mr2228684b3a.2.1775205704177; 
 Fri, 03 Apr 2026 01:41:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d10:b0:82c:9c47:fef9 with SMTP id
 d2e1a72fcca58-82d0da34535mr2228649b3a.2.1775205703692; 
 Fri, 03 Apr 2026 01:41:43 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2714dsm6757172b3a.1.2026.04.03.01.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 01:41:43 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V3] i2c: qcom-geni: Avoid extra TX DMA TRE for single read
 message in GPI mode
Date: Fri,  3 Apr 2026 14:11:35 +0530
Message-Id: <20260403084135.1300931-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=erjSD4pX c=1 sm=1 tr=0 ts=69cf7d48 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=qPv6kJ6rrmvbaMxWJaQA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: KwjLsBjElQWJPvX8F8-u2cvtzKX5tDgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA3NiBTYWx0ZWRfXxjHpUCQD3kgX
 A0jJGYU9zwEx60g/fvSD3UyUjVJHp6UgBMVjCuB5PZ5E6r0hsocFq2Ct8bm31LewyX7Ryab8o6w
 Vc+/El/pOGABjtomn/YKeVdUle+mZV8ESdinvbZW9S+KFJFSn8yjs189aGyjg2XAeUOKQdf1mxC
 L7WyXvjSYar5FReOzczuhElC8MuT959uW6Qb+vvAVb6ZicErJ2CfB+cmnJaU6amP853be2dGOaC
 nbF7MH96eNEywCretVxdq0LhqiuHTcYBun2l6GEcuM9SWATvGyCYTnl57YfRrnRfeqvj3JNeg9x
 Ys1DR9X5+tpjWMmoa1RSfI74JWMw1SMHMjHVKgtKxN89hFntY9v957SiS2TFwSX6+VKLWvdpJWI
 BBiVljq+y7JMEsHiIG1zoKsVgNcjDNYfRvzZHggW4zJ8B60QTEsm00ToMhlRm+t1ZwcP2/Dq99e
 mHuRysF9lWzdqnPli0Q==
X-Proofpoint-GUID: KwjLsBjElQWJPvX8F8-u2cvtzKX5tDgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030076
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
Changes in v3:
  - Added comment in the driver for better readability and changed the
    position of 'skip_dma' label to allow dma engine configuration.

Changes in v2:
  - Updated the commit message.

 drivers/i2c/busses/i2c-qcom-geni.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a4acb78fafb6..78b92db7c7fd 100644
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
@@ -639,6 +639,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
 	msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
 
+	/* Skip TX DMA map for I2C_WRITE operation to avoid unintended write cycle */
+	if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
+		peripheral->multi_msg = true;
+		goto skip_dma;
+	}
+
 	dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
 	if (!dma_buf) {
 		ret = -ENOMEM;
@@ -658,6 +664,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		goto out;
 	}
 
+skip_dma:
 	if (gi2c->is_tx_multi_desc_xfer) {
 		flags = DMA_CTRL_ACK;
 
@@ -740,9 +747,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
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

