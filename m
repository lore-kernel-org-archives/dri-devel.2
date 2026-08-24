Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D74AC5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7AA10E6F8;
	Mon, 24 Aug 2026 10:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jO5SiWJS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PaRPBOwN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120A310E6E8
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99Dqn2355868
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CypDPS5i+7FSZgzBsU0HBDl5Ax6l8lVjcrNheaMq+rw=; b=jO5SiWJSeSxfrPxw
 5K31x3BpHJAEaSvodqZtxqIqjb5MFtqtuW7VX9cCnGNnmKh22oJtncaZ84nLbA7P
 U8vViu1GyyjvdmgWCoSvZuzIWLX6XrBixvBXJQTU2eRsYlzaj6s4w/+K5KwoYlFn
 crYS83URoRdUpzViHHgG83ite8U7HYDwAvrqDRG1emNf2mfD+YV9C3tMhe3uWuo7
 vPnbzjZAe2seXqa1OGKpAXLttcy9PyZ79HlfqJaBrYu9W2xVgkvX8C+bLuM46sVZ
 isdJlUA2q3nRigMfr0NLS/lJ1/vnTfsnJXsGiaWyTDvY3hEC7J5Qaq83SDso+F57
 SZWt7A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn93t8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so4702059a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787568566; x=1788173366;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CypDPS5i+7FSZgzBsU0HBDl5Ax6l8lVjcrNheaMq+rw=;
 b=PaRPBOwNAoMJX8Kyg8eb0UGidznm5WX/sRjK+Zn4x5oNWkpu4FU4gyN+Z4eCOYUyJ1
 HH133IhwvPh0hi5jZSf0jbIUvM1GH5oI1zJxKL8A3E7Q6DWYkPw8dGMpF4TGcioXGAgq
 Q5885N02ELF2NqJxqDmVqQhtROCYg8quVlgWoiGfg5NLNvcj//yW7h9K9uXVF7VRsBth
 qAlbN7ieZz6Z69ITt9vh7/v0ls5/dAfbw1y5sHzt6p4yAUBuy+G+ZI6od4PpYYCfO1wA
 jUNlA/ayyzhQ4ilP15+BD1dYS4pAmOu8A9S7dPVHTTgsyv4Aloqj5u6TfaH+Vk5f6Cwq
 claw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568566; x=1788173366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CypDPS5i+7FSZgzBsU0HBDl5Ax6l8lVjcrNheaMq+rw=;
 b=KYfiFIU36Lt0fsKh7Mb3tpKddpGin3v7vz45mtJRFlsariCc0Xu+QHe8d2kCSwimFu
 PTNmVfgGCgIOGMbAn0rWFeurLqG4Ic6zkRDXdA8q6c1WpjZZVEfDgnAuV0+4vZo1Ri0e
 rflncw67DKJ54vO820NsenAZV9/MdA8pswOn8/LFUEawshiQWr7cHCxzhJZZSIYucQCu
 LoOnwftlcgWuqci8yv6Gc3YfsVDtLP19mXQMtM3FvHS3u+kAgBGsS5leRJ3TUn1KSlJG
 OQrO6mk281eUgx+0cW3gAIeoDVmfsE1UN14Kd27mvks+C0N6SBshtpwNtln7x6iVP9Pj
 xYdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX/2dULs8RG/M9BYRvZTqZBeDTbQRnEPLBbqsuXBRlJdqphwahg7YhRsfWklEed7WD2DTeGKJMjBQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpybhpCWXpEuXQ9GStxNkWrE+KSFOjG6awL1jypMa10U069lQ2
 9H0cLcZfH9MLQ332fJkgbpneKT+T6zdC38eyfygikI7Z8vu2bS7aLZ/r5hZz8fuSI7SI/WU/PD1
 l6eiWd1n8JQqNNAW6bSsq29RG8p1E8BJyCq8ETUHtdYt3Cwj/670bjBa1l6mBc+a/Y9NKwoQ=
X-Gm-Gg: AR+sD11lDpgiGzaE7VE0pM8ZRS8A70F/vY77gbbde0liHajiRxULgPxHtL3NLnXSQJo
 lk+5PqvUnf79lsyfGM2BSqoRHt6JvQnfzS8vY29YAsHZgC8QQm6X9ozXCa6lritOkF7X0g7X2z9
 77ivhz5TO7kL4M6DZp+7zzatz0o5KbdHl5Is3AE05ZqRvmBSzP2It0k2BJdYesZY8nwCYowmRHA
 rSE8aRX0KLcb4viBg7nniH8ifTiA+SftDyF+AgEVJHBH0H+O40PULmIF9zRpVyVzxFYCEwlEjFT
 APqVE7re0+MuRqACPNkq+SYbd8+0dPHxMClnZCraZbnN4e2pTX+REWgGkh2jUGidlrmMWCZaSUl
 9RH7wMc960ok9YlT3paZFvTjWZs3fSbfmqg==
X-Received: by 2002:a17:90b:3e8d:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-395c4fa444bmr15906923a91.5.1787568565652; 
 Mon, 24 Aug 2026 03:49:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3e8d:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-395c4fa444bmr15906880a91.5.1787568565184; 
 Mon, 24 Aug 2026 03:49:25 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c91ce453sm4125829a91.4.2026.08.24.03.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:49:24 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:19:05 +0530
Subject: [PATCH v3 1/3] misc: fastrpc: iterate CB nodes manually instead of
 of_platform_populate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-dup-sessions-v3-1-4b019def4e0b@oss.qualcomm.com>
References: <20260824-dup-sessions-v3-0-4b019def4e0b@oss.qualcomm.com>
In-Reply-To: <20260824-dup-sessions-v3-0-4b019def4e0b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787568554; l=5195;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=hmRfD5hv2hilDC52QM6CRPaznt6Vo0mIHRScEu9qbZ0=;
 b=WiLB15isE1CXfEtAmICuz+9YH7t6oI0RHaX/M/hHzzWWE+okxkiNABiQCDn8U8ROqDR4phd4k
 3nnCU8IPFTfBEDIFeXqV4KR0mCGcV4G22actsREthxJEAkBiyB2ueca
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfX+60U/dscxadG
 pF/70RYhp/v6rAbpj05CF8bElMIFm+G2l72GyPty3xY+JB9s+TJBRnVotPFjOI5OLRXi+NUDdPP
 ucc4nHN7PJtIIYe3HlOpC9PgWeUnbaU=
X-Proofpoint-GUID: OkMqqEl4Et7E_orxnzPBaZtvInkbIQGM
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c21b6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0tPlnvf1ouYV9MwHMgkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfX1g2DFbwXct/Y
 3+sW0hbUxnlzuSqzNqX9+wqAmp+2UQjKzVAWF9Raufp3hEDc1zHFghrVV/jQdhFs89oC261myvI
 na7FuTB7Avs80jmpB8RLWDwfXF2Y2m94+UGjA8EtleM9oLvxDRsiP25/zA7iVE4brNe09C2HYSY
 yc4ROjifLLKlKYtPRktdeiMZuLcJFUOoVFEHOUGPPZu+CbDxdE0uF1TyAvBLmAFjcSYMWFGqN+G
 JuS/aXSv6GdjtKW0Samw+YUFMO/Kd44Z0QKCfwTZgErS7CXEf/f6NEp0nejPW66iMZnzO8Z8CA4
 Yv9xVH2J1vscsg7z4LlK0IPC90ARJXBMB/Y5xA+yFNt1d3au9Tp088nN51He6Sqc4f564Tej3JS
 AUZaotVgr0kBmsDOP21iLBX/WYX8LJXLrZu7xXSioWI9exbcIjZmxLcBeFlPFuZQqV3zC+re4Ea
 mRUiPrHwMTwHIqn/jHg==
X-Proofpoint-ORIG-GUID: OkMqqEl4Et7E_orxnzPBaZtvInkbIQGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240090
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
 drivers/misc/fastrpc.c | 82 ++++++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..fe127bb0c115 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2190,7 +2190,7 @@ static const struct file_operations fastrpc_fops = {
 	.compat_ioctl = fastrpc_device_ioctl,
 };
 
-static int fastrpc_cb_probe(struct platform_device *pdev)
+static int fastrpc_cb_init(struct platform_device *pdev)
 {
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
@@ -2208,7 +2208,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
-		dev_err(&pdev->dev, "too many sessions\n");
+		dev_err(dev, "too many sessions\n");
 		spin_unlock_irqrestore(&cctx->lock, flags);
 		return -ENOSPC;
 	}
@@ -2245,37 +2245,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
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
-	{ .compatible = "qcom,fastrpc-compute-cb", },
-	{}
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
 
 static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
 				   bool is_secured, const char *domain)
@@ -2441,12 +2410,29 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
 
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
@@ -2476,6 +2462,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int i;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2496,6 +2483,11 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
+	spin_lock_irqsave(&cctx->lock, flags);
+	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++)
+		cctx->session[i].valid = false;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
@@ -2556,28 +2548,12 @@ static struct rpmsg_driver fastrpc_driver = {
 
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

