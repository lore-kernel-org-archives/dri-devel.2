Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB09D3516C
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBA810ED00;
	Wed,  1 Apr 2026 10:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EcQjUpHd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYSx0CBs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D677710ED00
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:14:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6314Ikkp3363195
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 10:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=EnaTxDzY/SHS22gfoLDFYPunIIYegtMK3o1
 Q5/kWemM=; b=EcQjUpHdFbEXKNQ/vGfUKZ1KOJKi+aE+2oC3k1CVSMeewo+2ORy
 20/hBfCvCAR0AsJf1BRHeHHeyU/6Q9FkUxS48BKl3Gs4WWFNeQDrUxbWyLeOjTjm
 w3GNLs5dSUtyNn66o4BOGO32CjS47lJQMZhphely4uU79bVwKxqy773iaqCSNrbv
 oIw1OVk5qLJlYrj29TXp9TvseLr5eAZvZYHpadqwpDeWOhM90dzssrl/BOxgrMbw
 8RLFkyR+p/KOuPkU29cD+zUzT891yXFOMeHS1iY56enkVPWOHJ8MpnHrbUgeNPaJ
 lZ7XG9Cgj7puJExfi8mPEhT8nibUZDvbeIQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddjubj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 10:14:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a90510a6d1so6990075ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775038443; x=1775643243;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EnaTxDzY/SHS22gfoLDFYPunIIYegtMK3o1Q5/kWemM=;
 b=DYSx0CBsdn3ufRfHHJ6BMhoNm8E2ZcWDWAngQWHkQOGUDS9aW/4p08HP39mo6FJeYM
 dsVGIOBBiHES1pVuSUf4nq7608kFbLHeVHX5Apsu6dKTE/NOJ85RiXojx550/HVR7y5i
 gMsPEYlt85jQnzcbDdyoM8UHnMUNoXmaMKjzzmkLckEnVdtsWXYhDQJwc1f1LVVtpTLi
 YbZ/xA38Xv0jqxZ8pW0A5mwsAR/aQPO7D0R0J7gltcZaDlcxM+NkOYIWYjVzJUNo0tXk
 ACgQVkuhIziGIKGx/g90mpGBXdwEJMEaGtb8m85XUSL/58VPVNMEjE9KYu9d7TgUBw8T
 u6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038443; x=1775643243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnaTxDzY/SHS22gfoLDFYPunIIYegtMK3o1Q5/kWemM=;
 b=QFhj5B3Izn0at51OD0zZ/hHsNv97VBhNgzfMrw+oeuW+1NkqCwZl5xTf952QZwPEKK
 QVvOpIVORuKucT16q3XNG8hD/H9VJasJXZni8dceHyVwTBFAbNF5aLgh/mDuz/CE1ZWf
 /hoGbdOrpe810ILwo+PKyFduO2iydN1vm6vj+RJY5Voh6zdjjLmwX1OueHbUu72dTpPI
 YGGCELEgtMVjyGSCRhkLwuKI9vlsUegmdEnWo7fHGAkON3v7L7Dv4DPPfwKb+VXavYIw
 ZmlBE9aNH4IJePk6ig6sBbBKurNbYP8OkGOASj+043lPTvipDCSlb28iZZB5Zld8xXAp
 pSLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZGqI3IUO1cJqCzGJYcHxr/akPCT9PXBmtR+9DqYtup74AygXVkudp5QErRU0ZYnAwI24KZehMbnE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhuAwaXENaKAXNQVtzRoxlku+jr4THgl9v0GU0cihdHlpeBC8a
 cHzcMZu/SshKQYleLBYd6OXCeX5osnOYjX4QvyWFF2oAjsTqtpqojfGryUVtc/1ldSBdZw4qEXI
 NdAqRkJ7gy0Hdsz/kqPa9NR3z33kqTK0pOGdl/Mm1krmlGaqGOt0rUyCICJGmZsuDDR5StPl8HM
 FP2YRigQ==
X-Gm-Gg: ATEYQzwaYbrCHhKx/YZ1DiZTr4TcEDvvjs/e5yXiLIhx5stO/3PsTEJmG7gTJnIFxSc
 tOB5mJzljrmYuA6r4g707NIK3NsfuHoPghO6Bvd5D15QWcaxoL/6h9FbUq/3geVFrS4t1LDUyWz
 4yj1opDTgmNbFPcwhismjyHMbWcIJ9Fn6i0VASpoPLP91+F1bcPkG+l63A8ALhb8Ay894sV+/kH
 8d0ZhYEyJ0/DBOdTkgtHjOg++Zx6yHT35SJWTCa04LJki/igStZCQ2JTTorCClGxTzvs6DCDAn8
 vyzqSyv9e0ddZYXBoRTy949VcsHeunHxz7LqWrwQR2qO/etBjEydlYSpzyjDIXiJ+lHATeZ4m0r
 eV2Ozmo059MNJwTuyU/3yz+rCkTtNo2THvXK/DP1ZgKWt1C0P/LUtlwrU
X-Received: by 2002:a17:903:1b6b:b0:2ae:5346:d4e6 with SMTP id
 d9443c01a7336-2b25efabff3mr60943125ad.28.1775038442601; 
 Wed, 01 Apr 2026 03:14:02 -0700 (PDT)
X-Received: by 2002:a17:903:1b6b:b0:2ae:5346:d4e6 with SMTP id
 d9443c01a7336-2b25efabff3mr60942995ad.28.1775038442085; 
 Wed, 01 Apr 2026 03:14:02 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427c5f5bsm148503885ad.82.2026.04.01.03.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 03:14:01 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V2] i2c: qcom-geni: Avoid extra TX DMA TRE for single read
 message in GPI mode
Date: Wed,  1 Apr 2026 15:43:52 +0530
Message-Id: <20260401101352.4065798-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69ccefeb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=qPv6kJ6rrmvbaMxWJaQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: C2c0Ay7EgmBNFxNxvNbWVo0dguWlGmyz
X-Proofpoint-ORIG-GUID: C2c0Ay7EgmBNFxNxvNbWVo0dguWlGmyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5MiBTYWx0ZWRfX8QiUSk7reNlv
 M2FriOFeTzSAWQIV2Z0YhlyEk+6n9rISfcp1VAW0xeVp23oJEHlwkaiocOmJpzOMu1dUVJMGjaF
 Cp2DvoqOKjHhA35/TSmVUoB2Igbl+VI+EPqwss/3JqVtc8O64nyhGQ+1I1AQDty4ffCwfqxKg4l
 /w2kxkOSW8ne7A+4EynQUr8pa/iufEkkCRyArP8GLay9OeHDELw4Hgg1a+uHfUQaWAHGc3WNKwC
 xsNaleGfKeVIeN+xW7CWZzsvpK9xBD1OMwVa5hC3iDZnzWuNd69UhtbeXMNEbll4uTFHDI17pSi
 A+xsoTElq2FRa5jrRyInuuSaFo23F1ae3hYgRWudWselyhtuQvEP/Uxf9+OsqcJGm68Qzc4shW6
 lzQqELJdd3RO0S1j3bxpwGqueRjk5KQyh8Be38HdLprRkoRIII58M1zc8Qqz4IgINPN47lD8bw2
 qQ75vAIG9EquQnewinQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010092
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

Changes in v2:
  - Updated the commit message.

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
-- 
2.34.1

