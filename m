Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB1C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FC310E98E;
	Wed, 26 Aug 2026 13:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzSeb6wk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DhuG+S/0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7FD10E98E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCUGAJ949382
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /1NtfMNjXT0T5Ju/tm8MIwOoIu61gHB1srsVawFDusc=; b=UzSeb6wkv3B55J0E
 WQTlbIerm2ahsEtxtU2MXsOxcC09NyyqHC1vIBeWZRhT/GWVvdt2e3u5efj1Zw+y
 Y8Ce9bLhwOEoLhnJ++SPkbcNgIOso+7wKZ3C2oizFNzZq85PvMNzwfjk7ADNvVUL
 8hDZ+RS//lNA7hNRwGqo1AOE0mzY7nkAnDlf9HanbEIjNhm0cE7JoSQEWepP0f9T
 5CcnIC07dCcNgpvRZSub+ZAG7FJlUr7An5UFR7sVhwjQEitWF0Sd/dQW0tpjYd5h
 E1+dBoLlx1ZARDJmjTEWDcUT5bvOeuNKX8iHEZXojIx8CkA5aKZXHOBEZCiOo9St
 lHXHlw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga07586nx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-396901263b6so405239a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787750770; x=1788355570;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/1NtfMNjXT0T5Ju/tm8MIwOoIu61gHB1srsVawFDusc=;
 b=DhuG+S/04A5V/zPz7NaxphDZMpppDro8MUnZfx11j+JoRzqW18ahV+ySDIaTEuvE8+
 oRiqU6VChVJfDkQDp5koapkBLpeAAe4r4W/NUK7kIrFokSUXYtrx3sDAyrd04x5r5jks
 1TIwfm7QnqSizXvurytJZcRhXlZFENCmsO7xYTzHLCXWgrcOLm6tUSktje3jW1+1sw0S
 7c1BVWuMY7NCIrDVpq1ZlBco7zpGHO89ZSOFcbgoNvXc4D3b6NUBOEVy5jyzPngX1cgZ
 5ma17FKUfjTAtxybujFngFmoRMwNJyrpvxyEyaznnLEMps5z5c0sBb+ZGsVL3Ey2ThMw
 ASUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787750770; x=1788355570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/1NtfMNjXT0T5Ju/tm8MIwOoIu61gHB1srsVawFDusc=;
 b=fVmW2VWBspyhkWymZxZ5e4AsZR9djL54DEnEBdrTJDmSKn0VUGZDZ1i5GnZvu091eG
 K/vwneVf0+cRGvj6eVUK7C00JBM5KRUbp2uvGSCrMKi+oiv9oAIiTEg+dXY85opyPZN8
 P4urQaznsmWm2/A24toGB7GrRvWhcgXIzHYH7ah7T5szTJdxPjqS6FD4hzpUwr6RW+6C
 olAWM3AMCnHTf7jKL418vvrpPuVQkOxv+RLZcUfSH/MtdbmiVFQkIQiqU/6PBp+4KOV7
 8hzOGkRbBAC39Qu7SLQpunvS1rmEfwwAfDGZNrDMrX8AL/laeugw6FzNblG7HlIi1ZvX
 mHhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGvQDsM0vGcIDWtR7deV0mBpzaHfyzVpDHVh7aKtjrzp97yVk/20Qbaq4iH1tl4GJNXIl36DPzHvo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nIqhXJ1DO+cnld45+kV8Pcy+eSphWAP7y57ntsef4k4vYtloI1
 1//gpnZbMat4H68tM7OxAXXFd7FIASRnyfMRe2s0c0QYYxsNAFpU6MqxXMeslvDdWaxPJKOLkOd
 FAWfv6GiUB2ZhWr70SGjmOfqY1WtQwXAQ+3+raCIwiNwSB3+7ePZ6xuHiQQXro86Gl4lrOy8=
X-Gm-Gg: AR+sD11XT4dz/U8be24faN5BZR6uK+9eYbk5PpKVjccetbgW6N1+SymiUo14vGwjt3A
 a+iqgCrKgGTUPXTam3CimK9//APKLc7cFUIVNjomMFKvqfFf1/5kn3UWZYRx/AHdKO/MuhdjNYm
 KfjwoJK015zdQxAm5n4dk25cCHp9kMJxwBgKfsQGtJxqbHrdM4BlxZ2PUyxvl9b1p3Qo9rQEM+9
 k8DQl7bUSwPuCv4pa5mKBWqOSao37eSbGMBWc8oHT1dAnX+IzDk07MlEkAN4b4d0FEJGW5aXv8P
 ZQs/CMu/U4vDFqID0DORB202F5jY4pVMtb2w360ikpyZIB7AZy1P9mZzYNWAfG9mMmOUc/ZABkP
 golEwhLU61Gj/84nD0yWFPLiGbPBQ+9dWug==
X-Received: by 2002:a17:90b:4e88:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-3966d4488cbmr15782741a91.11.1787750768195; 
 Wed, 26 Aug 2026 06:26:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4e88:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-3966d4488cbmr15782610a91.11.1787750767715; 
 Wed, 26 Aug 2026 06:26:07 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668767d65sm4581108a91.8.2026.08.26.06.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:26:07 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 18:55:49 +0530
Subject: [PATCH v4 1/3] misc: fastrpc: iterate CB nodes manually instead of
 of_platform_populate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-dup-sessions-v4-1-35555d2bfed4@oss.qualcomm.com>
References: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
In-Reply-To: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787750757; l=5256;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=TPMCLTDubnlYeSj2OYg28HGBF4sYYUCTAMZ6mmfr1Y4=;
 b=rtf85DxaxIVXlZxJuVEjZMk7uqHRFjgWoi5Nd9/cmK0eGzZEnd6X/m13pe49ZFB6VAVYjN5gH
 yW2lGXF1ZscDy8DRUywyUzty+CMOmcllSM/7EsFo6G2Y3fYW1C3mQJo
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: gepz9Ns7-qea4vRpsz-jfQ03IKaOvQ4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfX4uHYF1JD1wsE
 AK5d8wU48cAs9GFveSlelFrIpahFcyyBx6REQkb/LITrImBcROjMtLl46dl21mnttwf/85mPx3h
 FZ+o0/EQeCXMgskrsqrM9Xv56YJOGp8NNMcSUj76WabhZ29nDA9UETGY7PPFNpvYLagCQC+hsBQ
 Y+kKJhwyO31Dm1p/CIuhuGrDP/rwHhWG8WplLM4/YZEEdvQ1JWziGMOdXzpmOIGgluOgjCLS19+
 ekUJ1AWdZDJfPyDTxvD+jtEbc++75m1t9rHtVECmovGLM1OaMZ51lFTehCYz6bH3IGtksaFrMW1
 SI3bA45R/QEJGU70MOPjDGCPgajFuuveHnCHqKhh5/NdE5AhKPy7c/PI2Z6lcVLJ7DHMm/Ek0U5
 GiXY43RUHEzEtDrdlWJLmtvYheRSKmj2N25+Nwk3MJM1k+RjspigSUNOVRRSyYTRp3W4/yXG3BJ
 GsgI05iGfdf6w7YxaAw==
X-Proofpoint-GUID: gepz9Ns7-qea4vRpsz-jfQ03IKaOvQ4w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfX5rtI8Zo8bDoq
 oYFWTGgQI/uuKu8UvxeheNJpl7mjzOIGV/j0SAxqThe+0xHPQ2NlmciVq463ZuetOLDQuwrL3iz
 26B0YKGVAidrZfQ7WIRIsDAAl7nv8dM=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8ee973 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0tPlnvf1ouYV9MwHMgkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260111
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

of_platform_populate() only guarantees that child devices are registered,
not that their probes have completed before it returns. This creates a
window where fastrpc_cb_init() may not have run for all context bank
nodes, leaving the channel context partially initialised.

Iterate over the child device tree nodes directly, initialising each
qcom,fastrpc-compute-cb device synchronously. This ensures all context
banks are fully initialised before fastrpc_rpmsg_probe() returns. Since
fastrpc_cb_driver is no longer needed as an independent platform driver,
remove it along with its match table and remove callback. Set
OF_POPULATED_BUS on the rpmsg node so that of_platform_depopulate()
correctly removes the manually created CB devices on teardown.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 83 ++++++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d4fac2caca86..a153107d0085 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2363,7 +2363,7 @@ static const struct file_operations fastrpc_fops = {
 	.compat_ioctl = fastrpc_device_ioctl,
 };
 
-static int fastrpc_cb_probe(struct platform_device *pdev)
+static int fastrpc_cb_init(struct platform_device *pdev)
 {
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
@@ -2385,7 +2385,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
 		spin_unlock_irqrestore(&cctx->lock, flags);
-		dev_err(&pdev->dev, "too many sessions\n");
+		dev_err(dev, "too many sessions\n");
 		return -ENOSPC;
 	}
 	dma_bits = cctx->soc_data->dma_addr_bits_default;
@@ -2419,38 +2419,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void fastrpc_cb_remove(struct platform_device *pdev)
-{
-	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
-	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&cctx->lock, flags);
-	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
-		if (cctx->session[i].sid == sess->sid) {
-			cctx->session[i].valid = false;
-			cctx->sesscount--;
-		}
-	}
-	spin_unlock_irqrestore(&cctx->lock, flags);
-}
-
-static const struct of_device_id fastrpc_match_table[] = {
-	{ .compatible = "qcom,fastrpc-compute-cb" },
-	{ }
-};
-
-static struct platform_driver fastrpc_cb_driver = {
-	.probe = fastrpc_cb_probe,
-	.remove = fastrpc_cb_remove,
-	.driver = {
-		.name = "qcom,fastrpc-cb",
-		.of_match_table = fastrpc_match_table,
-		.suppress_bind_attrs = true,
-	},
-};
-
 static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
 				   bool is_secured, const char *domain)
 {
@@ -2642,12 +2610,29 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->rpdev = rpdev;
 	dev_set_drvdata(&rpdev->dev, data);
 
-	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
-	if (err)
-		goto err_deregister_fdev;
+	of_node_set_flag(rdev->of_node, OF_POPULATED_BUS);
+
+	for_each_available_child_of_node_scoped(rdev->of_node, np) {
+		struct platform_device *pdev;
+
+		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb"))
+			continue;
+
+		pdev = of_platform_device_create(np, NULL, rdev);
+		if (!pdev) {
+			err = -EINVAL;
+			goto err_depopulate;
+		}
+
+		err = fastrpc_cb_init(pdev);
+		if (err)
+			goto err_depopulate;
+	}
 
 	return 0;
 
+err_depopulate:
+	of_platform_depopulate(rdev);
 err_deregister_fdev:
 	if (data->fdevice)
 		misc_deregister(&data->fdevice->miscdev);
@@ -2677,6 +2662,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int i;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2697,6 +2683,11 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
+	spin_lock_irqsave(&cctx->lock, flags);
+	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++)
+		cctx->session[i].valid = false;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
@@ -2786,28 +2777,12 @@ static struct rpmsg_driver fastrpc_driver = {
 
 static int fastrpc_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&fastrpc_cb_driver);
-	if (ret < 0) {
-		pr_err("fastrpc: failed to register cb driver\n");
-		return ret;
-	}
-
-	ret = register_rpmsg_driver(&fastrpc_driver);
-	if (ret < 0) {
-		pr_err("fastrpc: failed to register rpmsg driver\n");
-		platform_driver_unregister(&fastrpc_cb_driver);
-		return ret;
-	}
-
-	return 0;
+	return register_rpmsg_driver(&fastrpc_driver);
 }
 module_init(fastrpc_init);
 
 static void fastrpc_exit(void)
 {
-	platform_driver_unregister(&fastrpc_cb_driver);
 	unregister_rpmsg_driver(&fastrpc_driver);
 }
 module_exit(fastrpc_exit);

-- 
2.34.1

