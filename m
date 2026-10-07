Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14B9CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D26010EDA2;
	Wed,  7 Oct 2026 11:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DHe6B8YK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7ipmZkb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080B210E7E1
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:38:24 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BV43A3687328
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 11:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FrnDcSaNRyROaC289Oqmi/Hqql0JDCxDd21OUiOnXQ=; b=DHe6B8YKImhJyVcZ
 vAKEaRF7m6OHR9HpbfqoQ8RrMx5bDIBATGI2k5xJGPBHKS5LmKjiu9P/jo2TSKQZ
 +7ATPhZYsFH+0ptv8H4qmTevn5StVuJH34Uk0Vn5bG7FG4Aj72JS63WqgsnAq03I
 9p5jK4kS+WRfYWoE3ge7wKr4TaizphVwPgQAPIIFV0Y88lk3iCHFyms6Wng7o5Cz
 rueyengCs7vD02fp+3ZEuN6Pe8ody1+7ghnjGDwy+TYYs7L88Ft+26ZGEF+iVJPO
 FN7xdhXXAONXwekqB0+V6hX2BUWlV7JqYVDQLw71Ic4HOSYy61i7w9tmAM1wTLBF
 kZBhOg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mgr866p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 11:38:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso4904243a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791373103; x=1791977903;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3FrnDcSaNRyROaC289Oqmi/Hqql0JDCxDd21OUiOnXQ=;
 b=F7ipmZkbq2EPTJqpaMeg9XctGl0HBIUceWstma3dqB+Ikzglbanx3wGDonGhXGU8US
 rCnoL8Z9byTlsoRUKuHaFjkBQ8YNbqvRB2pUOoNTMN34J/+xGVwBxyRmaySZO1dzrekh
 A24Hc5wB4SzC8klGZ6AfzKkUcoRm/AitQxdjup+g13GvT4Qw95jObju1R6bLlIwvHCVq
 ZmIlBCwgLix+k0jFVc9eacNJWitySzKUcXYLNM7ARZMZu5HYfFyXcaN/mQRPDzt3MdAW
 GVPXjrjRmGjUqi7PQdJ8Pe3XuQn3htrqmyTc1Q+qeuh15scnW/U4TQehv9lFBPel8l9Q
 cn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791373103; x=1791977903;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3FrnDcSaNRyROaC289Oqmi/Hqql0JDCxDd21OUiOnXQ=;
 b=RdrEua81LqrMjeTa52hesLbfWG+StPz47OKvpTdk+h5+kw4KYFhGKN/ZxUAfqELmbN
 DG8bhNRu8xdwWz8MWojvuQfVVEmB69ZQinQotwfdLeBnfGzpgSjrsl4xS3l5wMxUNx/M
 FQOKi3BKguu03cEDcAQ/eNXUzA1gRYYnlRaDxnd3sXP2tIPlQXRaRunZHgR7POfa9Xhz
 yNP2qgRUi705DUxxCbEPOiwIl/3nYRSmeJapYB9XG6e9GTc6gtMVc4XqcTdhlPNKUvcC
 KvYDkO+GiI9ngN14a5ChSMMwke8Xd+o9E2PC8wWt/7X5sVVm867pCsg3TtNz/AoSFchX
 0QiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzripfNxFrhv+QUXfR8T7thj8QFisQ9Tzd5t3MlWgTpv8aoc959DQbM5pK+IUMv7dYgjDcu+57wQhQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYISoNcoWhzOPSdWOiNu3Nha/3yEn0Q7UgBt8n/Cizg8YZmvmyLg
 /14FADyJC0GfFABFU4Iv+E3oz0sfxm22VYFqlXQWAAXzQgRjgV9Rn1ANNjVW49bPrC7ccdHoKDK
 cKZTif5rH9ULTAHzLlNrZ78+7nU+BQioKMXS9ApuRHqlpzyETGFO8yFAEqeFfxZxQDZ7gKf4=
X-Gm-Gg: AYBFou1wfqMgvSy6d1Imwf4nX59lnNJHhVJa3sJIfcDNKkLLK0zKyoYIbt1yVc3f2W3
 Y+/8qChUYTPg++gBujopfukh/IYsWl2QSBU/whr2LiclJDrD//CHLOwwuJFUnR06TG8hJm7XjaA
 PUQD4d+/PoMiqOVdEjDNwXLkMCee7BA261Gzf2vk6mVHLoe3CPem4nLJxKhA+EPlVBnDj7rqunm
 Q7TzaLjvsuKSpQiQUyaHy7zerCAnYT+xtz0M2jOKLbm7rnrtszwXvor+jgZewKiLaTgtnBsJJAn
 7RRYtK1eSzNS6CjoTRobI6LQrtEoxSmGu3DpJW6pE4fW0CcItpNg8A2qBfmZw64EfsaVRKc8SzI
 hJlOwitcan2/viXPnE1CKQNUNxQ97VGcg
X-Received: by 2002:a17:90b:2e46:b0:3a6:582e:5e17 with SMTP id
 98e67ed59e1d1-3a8a11c886cmr1203104a91.48.1791373102768; 
 Wed, 07 Oct 2026 04:38:22 -0700 (PDT)
X-Received: by 2002:a17:90b:2e46:b0:3a6:582e:5e17 with SMTP id
 98e67ed59e1d1-3a8a11c886cmr1203088a91.48.1791373102242; 
 Wed, 07 Oct 2026 04:38:22 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8a5e0eeb6sm1454001a91.2.2026.10.07.04.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:38:21 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 17:07:50 +0530
Subject: [PATCH v2 3/4] misc: fastrpc: add extended context bank support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-extended-mapping-v2-3-5dca3aa2c2d3@oss.qualcomm.com>
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
In-Reply-To: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791373080; l=3139;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=afuy3gcJG6X0tcLVajc4e83VvGe2ro49y2oZvp2SD88=;
 b=SW0+U9QGKo98uatXv0VcoeV5PqwBiNnwxs+rI8CLa5KpJj3AyqGUm521Zqk56NWTlvjE8IhSn
 Oqru44pRNe1A9safRUCqkNPZsTSXyE1qlj8tECZAXz9atJuFddzAUnS
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXxPkKnhQp+SKT
 Wlcl0UCunzhwGX0yYx6O8wvVib3SApu5RLyTTT/CqllQQfOFAPcCi70cq2iAUesXXFaKrOHa72v
 0F4yMXyl2s6+/5Z6ykB8IEd6xa7GromArVad8vSNEOdORK1akfhF8ng7bkeVhsyVHjT8wV3AHpN
 BIWov1gTTrS6zNb028W5PvxP7Cez59w6zXoceTgpsG+kkuZrHKXmlc7CByNwbl5sukpjPIyDld2
 p+Mw6XjO7AYc0zD4GM4uWCsZ99mmJAve6iGMU6sRXHhjAynSudUY5ou6YsWWBQr6xWQlaabyK8r
 5xaBegAxW7nNRb8jE53/VCUqH8EFWgn/aSK8DO+xvnEUBN6k+PoTiJDpX//fD8L/gQ6nR+ziozY
 bR/lfq10Pck5ryruU/mZYELUklP5lzCaK3RShjwROutJ1y+VZbIJ0cX+eCmo8JeXghEnBXzIiLg
 ApNuPuGyEdcgTKuqy6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX62lAWkJmOXfH
 Z4XCF2cz4lE8X8MUJlZPuAU1K8FiKlPTO+Fbn7ye1LWQbCKF7RxUgMoa1+cB+mUaB4/aVX2Vws3
 cWieLXZtY7y223ZIxCNMu/7zgAd6hJk=
X-Proofpoint-ORIG-GUID: AKZD2TqHUQoF1qwax_9ggDRATmAJRssF
X-Proofpoint-GUID: AKZD2TqHUQoF1qwax_9ggDRATmAJRssF
X-Authority-Analysis: v=2.4 cv=OYkNnRTY c=1 sm=1 tr=0 ts=6ac62f2f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=x2TTKIeUeEtxnJ4G98YA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046
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

Detect extended context banks by the presence of iommu-ranges on the
context bank node. Register them in a separate ext_cb array so the
mapping layer can direct large allocations into the wider IOVA window.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5c7bb56cf46d..d40cdcd5dec3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -307,6 +307,8 @@ struct fastrpc_channel_ctx {
 	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
+	struct fastrpc_session_ctx **ext_cb;
+	int ext_cb_count;
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
@@ -538,9 +540,13 @@ static int fastrpc_remote_heap_alloc(struct fastrpc_user *fl, struct device *dev
 static void fastrpc_channel_ctx_free(struct kref *ref)
 {
 	struct fastrpc_channel_ctx *cctx;
+	int i;
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	for (i = 0; i < cctx->ext_cb_count; i++)
+		kfree(cctx->ext_cb[i]);
+	kfree(cctx->ext_cb);
 	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
@@ -2343,6 +2349,7 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	u32 dma_bits;
 	u32 sid = 0;
 	int rc;
+	bool is_extended_cb = false;
 
 	cctx = dev_get_drvdata(dev->parent);
 	if (!cctx)
@@ -2352,6 +2359,43 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 				       of_n_addr_cells(dev->of_node) - 1, &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
+	if (of_property_present(dev->of_node, "iommu-ranges"))
+		is_extended_cb = true;
+
+	if (is_extended_cb) {
+		struct fastrpc_session_ctx **new_ext;
+
+		sess = kzalloc_obj(*sess);
+		if (!sess)
+			return -ENOMEM;
+
+		rc = dma_set_mask(dev, DMA_BIT_MASK(40));
+		if (rc) {
+			dev_err(dev, "40-bit DMA enable failed\n");
+			kfree(sess);
+			return rc;
+		}
+
+		new_ext = krealloc(cctx->ext_cb,
+				   (cctx->ext_cb_count + 1) * sizeof(*cctx->ext_cb),
+				   GFP_KERNEL);
+		if (!new_ext) {
+			kfree(sess);
+			return -ENOMEM;
+		}
+
+		spin_lock_irqsave(&cctx->lock, flags);
+		cctx->ext_cb = new_ext;
+		sess->valid = true;
+		sess->dev = dev;
+		sess->sid = sid;
+		dev_set_drvdata(dev, sess);
+		cctx->ext_cb[cctx->ext_cb_count++] = sess;
+		spin_unlock_irqrestore(&cctx->lock, flags);
+
+		return 0;
+	}
+
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
 		spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2391,6 +2435,8 @@ static void fastrpc_cb_devices_destroy(struct rpmsg_device *rpdev)
 	spin_lock_irqsave(&cctx->lock, flags);
 	for (i = 0; i < cctx->sesscount; i++)
 		cctx->session[i].valid = false;
+	for (i = 0; i < cctx->ext_cb_count; i++)
+		cctx->ext_cb[i]->valid = false;
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	for_each_available_child_of_node(rdev->of_node, np) {

-- 
2.34.1

