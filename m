Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4450DC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFC010EB13;
	Wed, 26 Aug 2026 13:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VBuKGqmL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YqRhIyf4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54ECB10EB13
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCM3E0699283
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ulzrg5Jgbzcu7NdvzxEDb+qFiWQRuMHzc+1iwLtcyyo=; b=VBuKGqmLiocUIwHt
 0iPDM39Avaueimj6DQynSuQtrxeXR2hrt4lUfIu0mKH456ajW4UTxZMwiYvEZJ6t
 Qx0AKeeVCL4Ox/EZDdLyuTCZOfe3hl7U52dY8dYvxOGn7dhb6AaFBJDZ8xSxlrkU
 1U4bHrLMjoik9OGXK4iWtCYkqp+oVJNTb4Ys+DWyeORKWr9lr4XyIj/JLpAd/5JB
 nDORMRVKOQv8rbvrCupunqmb932IItna0cLDS+oJvkfzkOtsPiOl44HayYT3qBew
 mEgLgk+awdOc2IpDQ/0Y4Mkw9PC70t2BeA64JfS8G6Gxnv5q3CplY6hpP+PzbrzH
 vB93KA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03a87xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:26:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso1330646a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787750773; x=1788355573;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ulzrg5Jgbzcu7NdvzxEDb+qFiWQRuMHzc+1iwLtcyyo=;
 b=YqRhIyf4uvQJS1b0/qEXIHyc4qfzfCFOaPqba3KTiJUJVNmH+I/p4u+9aVxZCitng7
 67789iiSWZ8CKpqQcyoBMGGoxwLKWYDWhIK5kZi7Aa4qyZE4KMUFRUWOGPhkkoNwi1cI
 WiVeTsYsVh0H9P6R/7KZXXB0TuGG3DI2EamYeLFnyZXf03UAa2aRfcu7URYjw39wbMGy
 7NWZu7+kFFJeG7UtOBnF7iCxKZ5z0h+6D1WYVh1Q7/lZLcWNBmhrTquTd3asGl/VoInE
 jE1/Rdx0Frdj1JJqAZMsbrYDT8m7Yf2GFwU0FY2yxXFlNCOiA9ydFUP3AQuqSbdIYsjU
 1B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787750773; x=1788355573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ulzrg5Jgbzcu7NdvzxEDb+qFiWQRuMHzc+1iwLtcyyo=;
 b=WWBTMQHGhv2OhAIDtf/2ehu3o45b9Dn+kD2xMA3LmOPDuy6i1GWVmViPBU7AKp44JQ
 Fl/VAe6WZ6mH2xQHOf1TF7jChAgTAEXEVMh/tFQytbDdCSc/5E/bYwmrejruptdpfaAm
 8tfQ3Gcu9P9FwI5nNB7rAcWdR0OEWBFTLfCpo3xL4UGWMbQhdHLTJ27HS1f/33+eudwK
 255cw7Gqm51zjEk1U2/B8m9f+SU2HSI/OukW4N+Hso8XOUw2kXENJLkIlNBDDRtEWEAT
 zn7cke6jPAz9E4VpbSPAfleQFqrGszZqyexUdYpllrZN7jD0Zvj5GkOHBBvcuzpiKpTU
 outw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCWRyOZUWS57F37YjwXZ86/sR/MDLl+XJcPXk6VOaUjv1NNK9BwB77AOFqxEWdfgkgZEUCr8UTS1g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQCEAc/GDdGDnNeo1c1rvojNKZJNTVxBAJjqFFZEOaSoyGhfRR
 GIuekQvL1i2QHYWWclRPyqJID53AQPT1UzqbsqPlvUWGSDk4qbn96xsN2NA+v02p8LydkQClasE
 rMEKp2KAG9eABaTsOxUgIrTCxnHahPqDmRsiarDkIajMpBm/l11NTUU8At6CGoZJBixaBqcg=
X-Gm-Gg: AR+sD13ypZqvZETMtZBD/8s3ZQsVgrprWy6YIUyFVSSRMCQcu/EjwLbkD1ue50y87u7
 /LAQUOOtMS/mJu+9mNqQaxbelyvV+ir+9FVtOvvCGPu7SEuX7mff1TZkl2Rz8zjcsgJKqKuONBY
 XZ7S6YW7zlUOMhS3nG03nP9YitrPNaf+hRKq75h1fFNCWCVuK68v5BMuwXR2c9n1oUT8iJ/R056
 vy4svAEzPmidVDig+PHdzACTIrZMbHXR96BHvV2MkjEtlTNTwqYvCsmFp4WOOlfNR4ngzCxIt0L
 Ge77cC0Hyz05lNb8IxPyhQa65iycYP43hrUXW85BjjBqpiCUUJG3BbMQJaIwDKtlvJEE55GjRC4
 PNKphJLUANjGL8UslXJOnStMV83k2/wIDbQ==
X-Received: by 2002:a17:90b:1845:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-3966d85dd8dmr15798782a91.9.1787750773092; 
 Wed, 26 Aug 2026 06:26:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1845:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-3966d85dd8dmr15798645a91.9.1787750772646; 
 Wed, 26 Aug 2026 06:26:12 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668767d65sm4581108a91.8.2026.08.26.06.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:26:12 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 18:55:50 +0530
Subject: [PATCH v4 2/3] misc: fastrpc: move ADSP duplicate session creation
 to the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-dup-sessions-v4-2-35555d2bfed4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787750757; l=3234;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=Zza1N3Y2FKmg1mQy2qIK8tXblDJiQpYmkV3BRv9IN/g=;
 b=MvYtIoBfRHzr+9ZlxzKLLMoppQsZDe6pf/KPNN/1QMZ5lRfEuP0Dwulclq9H09nsqHriGV/ys
 J1Twvj9xDNPBP2Fdaacm+ZxMCdQ9/9E7ncnRt/0xCCt2ksAYoackshw
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: qFlXTrBkqxiTBK_2VXll6WMSk6zew60V
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8ee976 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cClR-N3A75S5OZrvWOIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: qFlXTrBkqxiTBK_2VXll6WMSk6zew60V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfXwARemEOPWaU8
 rtN401JrtywaLBTSWQYh5uF4DLGHiRlXydyq9gk7nF9JjkWM30GrninuDgWmYgXvfsZDq5N5OB+
 yufYrM8P/fF/2M9NNwzGX+iar7WXMK93t42mzslOqUYhQ6eMtR3tyoR8tKl8sNvCcNOgI66Q76N
 mKWojxYU/bRUayybBh+eL+hhOspZ0xJwM14ialqRi5v4CLFMxzk3LSSzkS4/ds8NxUvtW8by9F6
 B2BavKq7llTJbqiJ46p3ufrQobyIC8Sn9t5XbQFOrCBp4FkwFezfO30Wb7QqY9IgGozKj9VpHtL
 gZUKyRS34E7F63JBVxS1bJg6lWeUlBfoP+TRIdgWkTwd59iKqFmLSb97ubth6Uza+V4hKEih91s
 wDhwLgurYgrtFnVSrl8C2jOTn2aeN2vJ50WP4gErQ9IszkwT7wINYuaFQUN7uTSMzotiy8RlMUi
 /sqmlSNMQ9xapzLjMtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMSBTYWx0ZWRfXyiZ0wZDL5mZz
 HOs1tumXTNFvxIuzTflTc5DSnN0HCY2rk+yTge7phVhg0zkb7zClXLuxaD3xCze8Iyj8SUHFPCr
 lG9fOgezxf2264ZDj/XJaFQxzM4LEe4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260111
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

For ADSP, only a limited number of FastRPC context banks (CBs) are
available. Each CB supports a single session, which means only a few
processes can run on ADSP simultaneously. If all sessions are consumed
by fastrpc daemons, no session remains available when a user application
starts, causing the application to fail.

To work around this, qcom,nsessions = <5> was set in DT to duplicate
sessions inline during fastrpc_cb_init(). This policy does not belong
in DT and should be handled at the driver level instead.

Remove the qcom,nsessions DT property read and the per-CB duplication
logic from fastrpc_cb_init(). After all context banks have been
initialised in fastrpc_rpmsg_probe(), append FASTRPC_DUP_SESSIONS (4)
copies of the last session for the ADSP domain.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a153107d0085..98a61b8b9013 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -34,6 +34,7 @@
 #define CDSP_DOMAIN_ID (3)
 #define GDSP_DOMAIN_ID (4)
 #define FASTRPC_MAX_SESSIONS	14
+#define FASTRPC_DUP_SESSIONS	4
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
@@ -2368,7 +2369,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
-	int i, sessions = 0;
 	unsigned long flags;
 	u32 dma_bits;
 	u32 sid = 0;
@@ -2378,7 +2378,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
 	if (of_property_read_u32(dev->of_node, "reg", &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
@@ -2399,16 +2398,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (cctx->domain_id == CDSP_DOMAIN_ID)
 		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
 
-	if (sessions > 0) {
-		struct fastrpc_session_ctx *dup_sess;
-
-		for (i = 1; i < sessions; i++) {
-			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
-				break;
-			dup_sess = &cctx->session[cctx->sesscount++];
-			memcpy(dup_sess, sess, sizeof(*dup_sess));
-		}
-	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
 	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
 	if (rc) {
@@ -2629,6 +2618,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			goto err_depopulate;
 	}
 
+	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
+		struct fastrpc_session_ctx *last_sess;
+		struct fastrpc_session_ctx *dup_sess;
+		unsigned long flags;
+
+		spin_lock_irqsave(&data->lock, flags);
+		last_sess = &data->session[data->sesscount - 1];
+		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
+			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
+				break;
+			dup_sess = &data->session[data->sesscount++];
+			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
+		}
+		spin_unlock_irqrestore(&data->lock, flags);
+	}
+
 	return 0;
 
 err_depopulate:

-- 
2.34.1

