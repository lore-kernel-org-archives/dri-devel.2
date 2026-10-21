Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F8606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E1KR00/r;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c4c3TaNA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F8F10FD1B;
	Wed, 21 Oct 2026 09:26:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB5010FCE7
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j0S2756369
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2iddebWXn7PUCxROMEP3SYghJdqyKc/W0mQtZfkMMkQ=; b=E1KR00/rz6olJNK/
 RMOWFBIdpIq8s7x5gp3xdhyHzwD6De9nkB4o814y9VC9SdvMv/zRA4QLvOd7p5ci
 g5pRVZU8n4EfLtq9Upk9Yue6fAn8MkKfPveVQgtI9ohnJmmS+58QtOC0fFCFb+N7
 4LClWIJRcrsvOACaAoCd65AdDg8cQj2ErbsSlyi1gKWi4EaRGB6y2D/ZqFzza1pw
 Nqnmefy0DHwOPLjwAkDba6BX+3Tuaq6lNERcLD9+u3citYoWMSRZLkkh1moQ9kdy
 OM1bq6WitJc4tA3uhqHSiSexlc0kHryfXohoZJm7G/NrVJh3EnxP5e1r5XIGofUF
 I3kfPA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4u7ch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so2413937eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792574767; x=1793179567;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2iddebWXn7PUCxROMEP3SYghJdqyKc/W0mQtZfkMMkQ=;
 b=c4c3TaNATm07tf1hlkng6A1u2CTG2Y4Aalzyutn+1ujBL+mQhPcUzesqxB1+UfkgBP
 Hyw9RdimsVQ95NqEoz5/wRIkf2mQMKUWjzH+bEdjBWXHvYG40CAue0oVnzmeTV3gprBX
 VpjBxoHPp2bBeg7BAGljA6lOA/wNNjskN4hqyJ/Lik3XzInb1D9aKnnoDV2KmZDaJXhw
 RYJMKZhRXUO3aVPn8Pouv9wZ4g/IPS2WXxmu7rO2JE5ekyqSfznl7FLcjCcQwS4c8ERD
 nEdMM8SYNHzxKNqmhVMjy3WGarJactAtD9oKT/YwkEjCFObwW25m3AMiGPYxwo+34PA2
 nXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792574767; x=1793179567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2iddebWXn7PUCxROMEP3SYghJdqyKc/W0mQtZfkMMkQ=;
 b=RKJWzW+MME01HfmxXyh4Uc9bzG7J3gzBmYtaFRLmaxWE9buJZ0PgFs4b/O/6eZu1LZ
 RljwGFmMmLDrLiGtawO/+CVc5bg5ce0rYyrfY8mT2T+4ZGpwsCvQI6mql6oZO/CqrjtX
 g9Mb3U1cRrSAkMJYy+6+dXmQuvK+5E2Ub/u3jm0m3rCLMvydTKmHciOa0o9F3PtH6OXF
 TYg1/Qf5qontJ0tqaQaIyuc3HkwkFQi2rySlJUrk0uqpZBsv31hyW8ifIP7+aMsGPUDV
 waKc2UVdAyZDP1fa50KhBVn98NYkyj1ApeK1jh1yN54hgOJM1jdVNNq803WBN4xuyo/v
 B13w==
X-Forwarded-Encrypted: i=1;
 AKwUvByjCu1hu9MNhM0Ss3oPCMWTohkxGHSGtJOlnE659je/+Xynh8vgKBFHwSvR7anCEk0YXLmrTaGouJg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI+5gfdIkvvPtvCN1Y2LVM+9+8mCCJ0vdvIuoQdrcySKAw2W81X
 k/fbr8skncAVw2f6F3/hM8bnoYXhCXY8RtNiHN+5a6qWtDEVFj85ACafbtYbepl0hXj9MYR5yNJ
 ue10kwzI+SFab4bJh7v8uz850CfBaE8GJfQU+IgTpu4bHY/GkTYxCWF45cI8Bi2uOtW7MS6s=
X-Gm-Gg: AYBFou0hfeVpUH7BRTDnYQ5PnG95z7djqzhZCZWDAK+yS5Gx7IZZXVDA7ZgR/gXh29R
 iXYgJ81JQelIUJsW5WTEI5gvT0h+JHu6uLjLDodgTvwrHyO4cE2b1VA6HBbmS4ixbHENRvaGpL4
 ajqthhUjZ8IVHhrq5urn0d58Vv4pq6dms5SGTEBN0t8rA8yXfS+R97UF8ZH7B8nMCm4NktNVpGA
 EloMIxIA7f5oE6nLgKyUDvThtTIlBWZid9G3T0zz5zW5+1ywpz5OD7677X2pPLnvuK16M2bPZIp
 cbjgubzvjoue7n/bHHVXmLaERHuCSug0PvidpY21gQudobQG2CAA7tgSIDIa5unED5Lnf2cUWsO
 O0EIQRtf5Zqe9olduBD+2SEqv5VxNrkya
X-Received: by 2002:a05:7300:fe89:b0:360:8596:657d with SMTP id
 5a478bee46e88-3674e04eb02mr2352413eec.32.1792574766626; 
 Wed, 21 Oct 2026 02:26:06 -0700 (PDT)
X-Received: by 2002:a05:7300:fe89:b0:360:8596:657d with SMTP id
 5a478bee46e88-3674e04eb02mr2352376eec.32.1792574765898; 
 Wed, 21 Oct 2026 02:26:05 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc8439sm6155671eec.11.2026.10.21.02.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:26:05 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:55:47 +0530
Subject: [PATCH v6 1/3] misc: fastrpc: iterate CB nodes manually instead of
 of_platform_populate
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-dup-sessions-v6-1-578ab52ba66c@oss.qualcomm.com>
References: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
In-Reply-To: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792574754; l=5896;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=lc7pys2jl8b6IeEdNwVX+R72jMwQXYcFVXfMeNww1go=;
 b=I3hQVmbkOrOFRuheTwQMtCKvT+0RJmbh/FYnDX1zO0sMyKYnUeGHmBBvUoplAf9aLJVJmLVJB
 8yxr/o7d1QeApc/hWO0brnsOPoTKSo9SsThle8MD079927/1O5v5aQb
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: 4SXehM-wc7wfiNgV0c25urD8U-5y5MrR
X-Proofpoint-GUID: 4SXehM-wc7wfiNgV0c25urD8U-5y5MrR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfX+i/iS3ZIpeRO
 miRH3pN/mNnY/O/1p/o4EmLVGCXkZv7A9Lpx5CO9TcQeyWLFV2F2DnGlqXPVrmN+7u8/s2cDRp0
 o7J6nry57yMj7xUasJIkAExwa65cltw=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8852f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=mOEaRXDu9pUODS4UlNoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfX94CnEBH/9O59
 Oqt8YWwT/D8Cs4DLjxoI9SKIpVEUHJPd/Hfxcj/wkqUfGb+ywmrHsIi25aCqRCQLKT0YN0UG1+i
 D0GQJSo72xIFJmTQXRUuPIogTAi7zCc0CM+rKwb94BBmFAFiQiIV9dlTMTgWKTCjorD3Sx8Li/A
 LJiiTynAjOipsSaOZd+C+0Y43AJM6Qv3lbutR3f+r+has7kpag8rwu8zRs5+EIM1Ju3Kf4juJpK
 KLfkrYbEAtU1jL5a4QVAxjDwzj+8c9fTOr9gWX/P0jTE4WI24GzuDZMjdwJ7t8ulJYJws5OiBOO
 Z78IUGUWsLxgrPC+xb5ZVuFKYMx8kC+gd9S7vHy9XxxDBlbY+kZ/AirhFcEzzRewEBU8Nn2moEg
 3Z+42WY4cHSs/s//zS8Ae5EgeLJLEj+Oniu9VhcKzFdIkzkiRzTi27MjUg9SKPRNvaIHfzb774P
 kHrG1JiA/tbYTiTRRzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210037
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/misc/fastrpc.c | 95 ++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..caa479f304c1 100644
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
@@ -2363,7 +2363,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
-	dev_set_drvdata(dev, sess);
 	sess->sid = sid;
 
 	if (cctx->domain_id == CDSP_DOMAIN_ID)
@@ -2389,37 +2388,51 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void fastrpc_cb_remove(struct platform_device *pdev)
+static void fastrpc_cb_devices_destroy(struct rpmsg_device *rpdev)
 {
-	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
-	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
+	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct device *rdev = &rpdev->dev;
 	unsigned long flags;
 	int i;
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
-		if (cctx->session[i].sid == sess->sid) {
-			cctx->session[i].valid = false;
-			cctx->sesscount--;
-		}
-	}
+	for (i = 0; i < cctx->sesscount; i++)
+		cctx->session[i].valid = false;
 	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	device_for_each_child_reverse(rdev, NULL, of_platform_device_destroy);
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
+			return -ENODEV;
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
@@ -2639,7 +2652,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->rpdev = rpdev;
 	dev_set_drvdata(&rpdev->dev, data);
 
-	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	err = fastrpc_cb_devices_create(rpdev);
 	if (err)
 		goto err_deregister_fdev;
 
@@ -2711,7 +2724,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
 	}
 
-	of_platform_depopulate(&rpdev->dev);
+	fastrpc_cb_devices_destroy(rpdev);
 
 	fastrpc_channel_ctx_put(cctx);
 }
@@ -2798,33 +2811,7 @@ static struct rpmsg_driver fastrpc_driver = {
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

