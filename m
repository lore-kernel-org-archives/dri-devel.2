Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90751606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BuNTRnhH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XwnQVovH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE7C10EC11;
	Mon,  2 Nov 2026 08:31:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851F310EC11
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:31:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24DK522433769
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 08:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uNk7UoVUCyaNPvkUt39ka4U3PEtGKbZzHSnhMCo9iP0=; b=BuNTRnhHCPpJt44k
 cp9W6DTyT+uE2Udvr6puPtOgVvkoupoQ35hDyGF4qK8l3CNm0gS9gBpJeCNd1C9K
 rYzSewasozAkQkcCVyJGaf5edwVr/QCqvSKmlqI10jg254oKzpYQIWS5KdwH1qrs
 R0WGCTwKGa/mO1VSQn4XKaApzDvazbiBrSKyTCzv3WaryibN8hLWSr4Zl05LVbWB
 pVlMZeQgirHbrRz4KdJXptq2he/B39pa+jUwPDeUBnLo/TkrYV1dBSZsaRVZ1Nve
 +FHKoo7XCeErpWjPYea6zoYvWeYEphKTC4Dcd7ThggIx43IdtWGaahJWadlZUHkh
 R1xhKQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka60uws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:31:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8a59717b0c0so2167976b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608285; x=1794213085;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uNk7UoVUCyaNPvkUt39ka4U3PEtGKbZzHSnhMCo9iP0=;
 b=XwnQVovHopcCccgq5IGrhdDpq+feqyiM7s/gjPayZksVfKqwMuaHPgfQnOE1TDTY99
 gToHZknAJ6cqCf51c90mz40/Ebc/haOr4tvAOlrUxwL1Fo1sOUzXuPyek0O2T69Fag3r
 Hp39OfwguFWLzHWNbSR+9OKZDze2TcMPc+8Zxx91KUflp680E/3rqxUSNzuyFxzrVQOm
 UYqu6Pf8/VLZqcvV9wJ5SXcRH0IGks2nL5vfDQiEVLPjB5ZfCof4acjEkL+FhR6kAptQ
 WIQjRFin/KV+6HTZbvPobxyb7Y+nzlGD2woKFSy2xVMt5sxZyECZw1svktqymH1CfEuh
 ceiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608285; x=1794213085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uNk7UoVUCyaNPvkUt39ka4U3PEtGKbZzHSnhMCo9iP0=;
 b=LYPrlgxN1u8qgvJv29GWbDfaVnqGU95lrhO68C2N6EZmGMGZAE+KlYG9byfDN33fP/
 P6fnvQid8t3EKpZFPa3wi7BrRslKm3hBgimEXR8YaYsmenp7NoT+jG5BL14IFYfI2nQe
 BG7Iw/oel1c8UL8y/llLc22fdVCGrRZJ6zbeog3Y30zzgFEb2M1zGs6dpLgO5v2XNhZf
 Qu+tGgA8yYz0r6j4eOzCa1iurv3eCAzrMENrcx8PvG1upWiKywd48ILSG7K/liMwffYl
 EAtvqbtshzpW9eLDtTP3gsiwbm2NV+r73Rmc04jdqfnvHYu9NH8JgwKr1FV1t9qTdYnX
 VCDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBywI/L4ESeQ1ebV1XkqAs0PfduN7aOR8ej5XAx6sfn3kp8P/Fi4UIQenGII7a9BoqxCak9Wbs4NdnY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/0Igri2R4bWRFVYE8YmrUDQSUJFzOMWH8GgXn0+p1yCa4E2Tl7
 1EGyOxi7iwLTda3eo1ta6Ztsssw64bye2rAPWjHEGfGYUTTK7qq++KFkWQVg0W8mzuEs05hnEUW
 Bdv59yrRSYrUyr3LWoqSDVjJnYZaSqONJBRRM400tIdZ0Bh43uYkQ4fi2jP4elHfDyBTmjlkwKo
 Qty8o=
X-Gm-Gg: AYBFou3EfRL4z8GFHzuYNLS1k5oq9384IvdkOdDMV1YuFjluVlJ4psZ8ls4jGAuCMil
 3ZtBxXS/0QS0QS7Ur5SaJVSeui4+Z9acRUpAQSJ/llkZG2Pb5egO/9Xs5dbtJ6hq00WSX0wQV84
 KpSlItuOM8Q4qfkURv+cHlSG6MqDcsiKxhZLyJI2VUEE8MldvAMUfsY8+G8squK6WpRh8LJgt7Y
 R9c1dViMrSSoY1NH18LwNszpSffhsA/bxQIMdjULN+PdZHAikGZktMzJYtYytXm/c8CwBg3xLpE
 Z04IzGCLHy9hm+Ox79KmJg4L8cRbWb6UbiO0j8r5T0ShTwftF1yuv85ACoNDVMhF275S0IG3EB3
 91pcxHnVGaHnGfTTbz2cGcofFF140tGhVPk7eQw8cZ5O2WRgznFhoVCeoKhqBnvC04irOfFwpKU
 Oqqxw0AA==
X-Received: by 2002:a05:6a00:ab05:b0:893:12e5:c07c with SMTP id
 d2e1a72fcca58-8a9be965277mr7867705b3a.27.1793608284981; 
 Mon, 02 Nov 2026 00:31:24 -0800 (PST)
X-Received: by 2002:a05:6a00:ab05:b0:893:12e5:c07c with SMTP id
 d2e1a72fcca58-8a9be965277mr7867678b3a.27.1793608284451; 
 Mon, 02 Nov 2026 00:31:24 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad9d03be0sm1674680b3a.27.2026.11.02.00.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:31:23 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 14:01:02 +0530
Subject: [PATCH v7 1/3] misc: fastrpc: iterate CB nodes manually instead of
 of_platform_populate
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dup-sessions-v7-1-03f06c014e78@oss.qualcomm.com>
References: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
In-Reply-To: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793608273; l=7646;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=1ZCjKkuEklA9dqtgrXzcHhTQLVOklfUh4hr7qs27ZYI=;
 b=Avy1J3E49Dc36+bGc1BPg1IiqDzb4s/n4DFoCSABSKVHfa86jc0nGXFdVAD7YvROrQ+mFq6oK
 35f+phSWQktD8JK2sYAVz7jmgm2WMkPMu5K3UMvQ1qS2BFZvB+vcOVU
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: Gi4w1i1V5HGSu3pQUkRYbxkut5Zex_lZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX8B6UNamlzpeo
 ZHM8PGFgo2/hgQnCsfe3j+6ak0HDdTJiqzlM1NzT+ykCzozBFrwtxnIGDEl7yOSenP5vA6twiDc
 uQ2l0cWvkw7moPIsIfHviF/UJPvmK3s=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae84a5e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=uxAdCuZb9_mwF1n_fQcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfXyJG6pDL6rTqJ
 GOwuba2Y1Dd+QWJLVSVP+2JUt3rzinaO0C2jxnJri6ofC5N2Q+TPPCo3QbZESGmzF4DdQFmym0S
 i+3b5WbDSTK1w/lbMuSJFtl2utKkMxbPZIgzMp2nmeeVH9Y3joUSXhTGWeVgTdR1BkFPSdBWZQy
 S5ZI3DgwQQmQuqhIDz2eWJI4KG6fqd4x8suIDGsoJJGddhE/Ud1SQAJIOzTwaGITHejtj5ZOMR1
 2oZfBWNMPKF3XcI6klrz8YtkrepZScr/RpBP2KAVniP07EZyItvuqN8Cr0beMEOmYSDXNAT7ZCN
 RKOHpOn8s+OFugNTMA74iXlyw8htsuK8rlyxGQ9M2xcdPXSIdDtauQXTuW/nXxh8Jqua70rqOwd
 4VXeVnljdZ99jv5qbDvZGP7vLdGDB1M1yYdtmm9WMTPoRk1cvgW/DqC4TA3as/PzZkoLS6pNjNp
 f1M3EBdBwf/H92lbLQw==
X-Proofpoint-GUID: Gi4w1i1V5HGSu3pQUkRYbxkut5Zex_lZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020033
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

Since no driver binds to the CB devices any more, the driver core no
longer runs dma_configure() for them. Call of_dma_configure() for each
CB so that dma-coherent, dma-ranges and the IOMMU group are set up
before the session is used. If a CB cannot be configured (or has
"iommus" but no IOMMU group), log it, destroy that CB device and carry
on with the remaining ones, rather than leaving a half-configured
device behind for a later IOMMU registration to trip over, or failing
the whole channel probe. -EPROBE_DEFER still fails the probe so that it
is retried once the SMMU is available.

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
 drivers/misc/fastrpc.c | 120 +++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..7441e9b8940d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/of_platform.h>
@@ -2333,7 +2334,7 @@ static const struct file_operations fastrpc_fops = {
 	.compat_ioctl = fastrpc_device_ioctl,
 };
 
-static int fastrpc_cb_probe(struct platform_device *pdev)
+static int fastrpc_cb_init(struct platform_device *pdev)
 {
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
@@ -2355,7 +2356,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
 		spin_unlock_irqrestore(&cctx->lock, flags);
-		dev_err(&pdev->dev, "too many sessions\n");
+		dev_err(dev, "too many sessions\n");
 		return -ENOSPC;
 	}
 	dma_bits = cctx->soc_data->dma_addr_bits_default;
@@ -2363,7 +2364,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
-	dev_set_drvdata(dev, sess);
 	sess->sid = sid;
 
 	if (cctx->domain_id == CDSP_DOMAIN_ID)
@@ -2389,37 +2389,75 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
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
+		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb"))
+			continue;
+
+		pdev = of_platform_device_create(np, NULL, rdev);
+		if (!pdev) {
+			of_node_put(np);
+			fastrpc_cb_devices_destroy(rpdev);
+			return -ENODEV;
+		}
+
+		/*
+		 * No driver binds to the CB devices, so the driver core never
+		 * runs dma_configure for them. Do it here so that dma-coherent,
+		 * dma-ranges and the IOMMU link are set up before the session
+		 * is used. A CB whose IOMMU setup failed is destroyed now,
+		 * instead of being left for the next IOMMU registration to
+		 * retry (and fail on), but does not fail the whole channel:
+		 * failing the probe makes the DSP reopen the channel in a loop.
+		 */
+		err = of_dma_configure(&pdev->dev, np, true);
+		if (!err && of_property_present(np, "iommus") &&
+		    !device_iommu_mapped(&pdev->dev))
+			err = -ENODEV;
+		if (err) {
+			if (err == -EPROBE_DEFER) {
+				of_node_put(np);
+				fastrpc_cb_devices_destroy(rpdev);
+				return err;
+			}
+
+			dev_err(rdev, "skipping %pOF: failed to configure DMA/IOMMU: %d\n",
+				np, err);
+			of_platform_device_destroy(&pdev->dev, NULL);
+			continue;
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
@@ -2639,7 +2677,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->rpdev = rpdev;
 	dev_set_drvdata(&rpdev->dev, data);
 
-	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	err = fastrpc_cb_devices_create(rpdev);
 	if (err)
 		goto err_deregister_fdev;
 
@@ -2711,7 +2749,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
 	}
 
-	of_platform_depopulate(&rpdev->dev);
+	fastrpc_cb_devices_destroy(rpdev);
 
 	fastrpc_channel_ctx_put(cctx);
 }
@@ -2798,33 +2836,7 @@ static struct rpmsg_driver fastrpc_driver = {
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

