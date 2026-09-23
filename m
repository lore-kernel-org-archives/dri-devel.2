Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94908C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002FB10E853;
	Wed, 23 Sep 2026 08:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4/0w7Jn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HqRwdQIJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762E810E840
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8Jgde2975592
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tWqTLAkW4i1E1lvz+cnZILkUyZ8Lt+Lp/+qHaxdTMmQ=; b=b4/0w7Jn9teCNeyn
 0yOhAx2//r7QxLON/6ARL6fPGV1kt74+4rTxnVgKkgZB2/Y1R7tPF5YPdtUL1BNc
 UZ/rmGRrqzvONyNWr/Q2cE2ZT5MTxHTUtgo4ICcb8hjKOv6kL4eh1J1ydF86CgXY
 M/eF+qtYxAWXTzeCPOtdsqXELS/KnuWSxzbbtPIbwMlMY/OY5SO32A6SmV6ZiRrv
 RbujksR1ebVEeQRLXtCqn5CqkFWr+1wE18fxq4t4DZQtKg/OhBmzImzCVigOzIBs
 1M0T0452jO9xxBbEGchOM47+xBB34ydJ3ZoBcdADgHkLWhG5LOYzQw03DD2Zam7D
 qSTYuA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n1146-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:03 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1438492fb40so1025872c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790152803; x=1790757603;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tWqTLAkW4i1E1lvz+cnZILkUyZ8Lt+Lp/+qHaxdTMmQ=;
 b=HqRwdQIJz7T7zx4oOW3hHIixWYxfoLHL6HYkurFWCPsOaoORVzHx1krfRsBLUMwTXU
 PftiUQwPa6btDT0NXEXY3L66wWHneJVXIxTCkRyDFXWmZjGnPKvySxJPtL6aDwxyJ9Lp
 mtjkp/hg/GdQWg1Y6bxndM26ToPqCDy/9D7Nf/vDCqwRpBHEpald/CIwZxhCybzI5WvR
 KXefM4XRE8RVK+0yKfaNBL7YcQeFiGLxMYmPgFVpND8KJWI+bWhT2iq6RWs/WkwHnz4h
 xBxJgQxo8fZBNDAUYhUbkmxj/u//+rfdIGoMAmwfwj+2m56GzKRAruzbbQYcHHxmJhn9
 SvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790152803; x=1790757603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tWqTLAkW4i1E1lvz+cnZILkUyZ8Lt+Lp/+qHaxdTMmQ=;
 b=i6bWcPbxfd4K+SuLUzne1xcZPHC1uz3rGAfUFJqxBFtKy02fwesSkvVaXSzPnUWGdU
 m7hA+X+S1DBUV+3mt3zylPixsb9iuUCHGmgqfoXa3Dm4+n/q5yF+JFCi3iUy/fao+GVC
 fAj7mCQcqTZgJ5QeYga06zNYOxMbEgtUvIn27PabDF+JigDFk29LEpK9UklHEwHAR6mY
 F5Qb7I/l7Vc6lGD9nNpaPypqwtoTwPyePCAw1VtMHjnWE8YXrgnaTkzRwDz1ksOy88PI
 PxTUd/1uhZI/ScWwOcQ699NjlJFZYNoXwfDza5uvcNPux+L4J7yfus0irrWILSeLENNt
 EfUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByK83MLu0msr/QyajfZXJMl/IINpE0kX1yfHNaIJPdw5GNDeyJkmF1+0HEES7PftBhq7c850hvUtgQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lauY/8aH9rdJeb/QHAqsEw0NXfJdm7gc/yeq1wQCYttEdq1QNX
 dAw6/ZCOrrIBKmMnP7OCeLVLTQBugClL8NIL5Ec5ziItaA4GJMnsixPpHqIrqENc4Sx7t+I84Kc
 tEZJHzUZzSG6EZC1bw2IcQ24znCJV93R7526wDqjD1i26sdR49gp53rUaonuIzgXQxNXhFdE=
X-Gm-Gg: AYBFou2z+7QG9MOH8GPRjs9E+Wp1gGkTE3YCUQTU0JGEFzcZa3ORKvzA5A+h3xMUTUh
 z04lZrzyW3L/IMzjHGUu+pqT+2lxlaHgsT+N1CPn51hI0CQEHX/7xgfEBhqGX/kL8YAaMhrZMEN
 9HMqj+YitwmThoA21DY6sd8SM5njo2yeZyJyGkcHRSWaA6HDZzRKmjGDt8C6kQ9v3CfbWc5IjMg
 9JkYM38NQDs4495ca5YIxz8c7GiMfiLQyT9DUdkMuhEe9Q5qmKzguGrUQVVpgn4PGJ3Ybti7mTb
 oh26dNwuL5ulOEN5AaxzOJU7JShS8QCQMEiAOkzhozxIatrE9aW0YHv+zo5YkFfzMhCouwMktAL
 g/mZYyIYRWH97pcyee844c+TxCQPRXgqg
X-Received: by 2002:a05:7022:3a08:b0:143:26ed:2dd5 with SMTP id
 a92af1059eb24-144f917a486mr2880965c88.31.1790152802719; 
 Wed, 23 Sep 2026 01:40:02 -0700 (PDT)
X-Received: by 2002:a05:7022:3a08:b0:143:26ed:2dd5 with SMTP id
 a92af1059eb24-144f917a486mr2880932c88.31.1790152802151; 
 Wed, 23 Sep 2026 01:40:02 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96d497e1sm4701275eec.25.2026.09.23.01.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 01:40:01 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:09:33 +0530
Subject: [PATCH v5 1/3] misc: fastrpc: iterate CB nodes manually instead of
 of_platform_populate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dup-sessions-v5-1-e953133a1827@oss.qualcomm.com>
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
In-Reply-To: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790152791; l=5975;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=2NFyyzgKwY0d5hBYe7MwLGfgwcNpViosAh7hxpTEgkg=;
 b=mONT7plOj00vBr7bPCkQ+mur2h34QQjSDvPD2H0kmekMmjOUwMSZwsS3ccbS3yc+6u4KmFLGf
 bYX09Z4pyaiC54+aur6tmXDbvknthilgX/NO2T3HuR2pJi8XmJEMcSx
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfXxinY+KhOqhY3
 v3RTLswy268cY5jgbKVe1faNuq+J9MgjtKMhv7iR79njlrtC6ClQdzU8f/aR//A1rQHZsqY3BGG
 Q3aUyE2+7dN9d41U/yu6F7DK8dZae24=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX2cmcJ5ycf8xT
 1bLHLwN1Iyg1mRqhYmDc/N6cA1+0HPsGmgUrzSTZdWV4bMluqrsq4Q3DFOtCxOks8GVZ8fdPiMp
 XfMuVJCCdfautToRoY+qhYzkH8tjUhB0MnWd0hpKsRQIqCja0z95ouFOy+dxpSuoVss9owhC+ZB
 9d1Hr/mBLCLyGfQjiJ31FbX/XJMuJy2rc6DvucGNoNa8xIb7JBvhg1yfgGVIHtCbI4+5VXi9gWy
 GVd4/vuwSzKkJWcAugE4qWZqb7jhls/EkHDFx9qtxEkyJ4SML/PCdJwTiXR0VDf5gYpp3SDII/D
 8FvQiyzly2A06XDyRDsW+V0CUGcKDWoqJU31L1lBBNffNB3IX+l9nMXnJ4TLud3cnYmh+WHLPTL
 mI84DeVc5XLAUs4qPPuLKopK66Mc/K//NmSkByRJ3zpz6LwJPAREJSNnXnn1Rq0rudgfFW6pNpO
 NbO5RDsvkEror5oxWeA==
X-Proofpoint-ORIG-GUID: jNyKD4YTrnY09JRO1o8_FJrN4BGunXgH
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab39063 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mOEaRXDu9pUODS4UlNoA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: jNyKD4YTrnY09JRO1o8_FJrN4BGunXgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230034
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

Introduce fastrpc_cb_devices_create() to iterate over child DT nodes
directly and call fastrpc_cb_init() synchronously for each
qcom,fastrpc-compute-cb node. This ensures all context banks are fully
initialised before fastrpc_rpmsg_probe() returns.

Introduce fastrpc_cb_devices_destroy() as the symmetric counterpart.
Before destroying the CB platform devices, invalidate all sessions under
the channel lock so that any fastrpc_user still holding a reference to
the channel context cannot acquire a new session backed by a destroyed
device.

Since fastrpc_cb_driver is no longer needed as an independent platform
driver, remove it along with its match table and remove callback. Use
module_rpmsg_driver() now that only a single driver registration remains.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 104 ++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..f20d3e5ecc81 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2333,7 +2333,7 @@ static const struct file_operations fastrpc_fops = {
 	.compat_ioctl = fastrpc_device_ioctl,
 };
 
-static int fastrpc_cb_probe(struct platform_device *pdev)
+static int fastrpc_cb_init(struct platform_device *pdev)
 {
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
@@ -2355,7 +2355,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
 		spin_unlock_irqrestore(&cctx->lock, flags);
-		dev_err(&pdev->dev, "too many sessions\n");
+		dev_err(dev, "too many sessions\n");
 		return -ENOSPC;
 	}
 	dma_bits = cctx->soc_data->dma_addr_bits_default;
@@ -2389,37 +2389,63 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void fastrpc_cb_remove(struct platform_device *pdev)
+static void fastrpc_cb_devices_destroy(struct rpmsg_device *rpdev)
 {
-	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
-	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
+	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct device *rdev = &rpdev->dev;
+	struct platform_device *pdev;
+	struct device_node *np;
 	unsigned long flags;
 	int i;
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
-		if (cctx->session[i].sid == sess->sid) {
-			cctx->session[i].valid = false;
-			cctx->sesscount--;
+	for (i = 0; i < cctx->sesscount; i++)
+		cctx->session[i].valid = false;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	for_each_available_child_of_node(rdev->of_node, np) {
+		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
+			of_node_put(np);
+			continue;
 		}
+
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (pdev)
+			of_platform_device_destroy(&pdev->dev, NULL);
 	}
-	spin_unlock_irqrestore(&cctx->lock, flags);
 }
 
-static const struct of_device_id fastrpc_match_table[] = {
-	{ .compatible = "qcom,fastrpc-compute-cb" },
-	{ }
-};
+static int fastrpc_cb_devices_create(struct rpmsg_device *rpdev)
+{
+	struct device *rdev = &rpdev->dev;
+	struct platform_device *pdev;
+	struct device_node *np;
+	int err;
 
-static struct platform_driver fastrpc_cb_driver = {
-	.probe = fastrpc_cb_probe,
-	.remove = fastrpc_cb_remove,
-	.driver = {
-		.name = "qcom,fastrpc-cb",
-		.of_match_table = fastrpc_match_table,
-		.suppress_bind_attrs = true,
-	},
-};
+	for_each_available_child_of_node(rdev->of_node, np) {
+		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
+			of_node_put(np);
+			continue;
+		}
+
+		pdev = of_platform_device_create(np, NULL, rdev);
+		if (!pdev) {
+			of_node_put(np);
+			fastrpc_cb_devices_destroy(rpdev);
+			return -EINVAL;
+		}
+
+		err = fastrpc_cb_init(pdev);
+		if (err) {
+			of_node_put(np);
+			fastrpc_cb_devices_destroy(rpdev);
+			return err;
+		}
+	}
+
+	return 0;
+}
 
 static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
 				   bool is_secured, const char *domain)
@@ -2639,7 +2665,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->rpdev = rpdev;
 	dev_set_drvdata(&rpdev->dev, data);
 
-	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	err = fastrpc_cb_devices_create(rpdev);
 	if (err)
 		goto err_deregister_fdev;
 
@@ -2711,7 +2737,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
 	}
 
-	of_platform_depopulate(&rpdev->dev);
+	fastrpc_cb_devices_destroy(rpdev);
 
 	fastrpc_channel_ctx_put(cctx);
 }
@@ -2798,33 +2824,7 @@ static struct rpmsg_driver fastrpc_driver = {
 	},
 };
 
-static int fastrpc_init(void)
-{
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
-}
-module_init(fastrpc_init);
-
-static void fastrpc_exit(void)
-{
-	platform_driver_unregister(&fastrpc_cb_driver);
-	unregister_rpmsg_driver(&fastrpc_driver);
-}
-module_exit(fastrpc_exit);
+module_rpmsg_driver(fastrpc_driver);
 
 MODULE_DESCRIPTION("Qualcomm FastRPC");
 MODULE_LICENSE("GPL v2");

-- 
2.34.1

