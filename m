Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B93606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kKMtXU4Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MRk1EAWh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1DF10EC09;
	Mon,  2 Nov 2026 08:31:47 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE1210EC18
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:31:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A27qgfq3863009
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 08:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sl/C0ue7XKBR5JLbZ/3q4Bcos5iFaHn+Kv1/3l6xjqY=; b=kKMtXU4QPRmZmwTs
 8yi9pLSXsl4/YLmX1A6kg2U6IKKBVqC+B9bNiJ2G3N3Y/+aexXEXSgjTO1cJNBqT
 gkEG8SdOhLKWmhEuK2mz5k05SrtSTbCvdODmN/2Le3oWWEgJIq88iCMlmyD403I5
 xm2RPm68r9Hs29soP0GQgM2Xgk9I7qJcSfXaqOZesfo32VxGgRAt8e2LQIIlJshf
 D/3xRT1KKGdUaCv9JCuYcrLHAvHDRxV5dj/G123eKmp0SGOTnzRwsLM1Kc8NWYtj
 1FdXcgyqYMqsUxlDblBW3Antk1IpA4lIedUQP9xwQoUZa+jX3aNyk1VgCsWslwSH
 BROLug==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph18574-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:31:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a065d0e9deso2667496b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608290; x=1794213090;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sl/C0ue7XKBR5JLbZ/3q4Bcos5iFaHn+Kv1/3l6xjqY=;
 b=MRk1EAWh1VWiW/gNacACtjHuAnSIraxHBuMuIQcsURwcN/gaFa8nClPeXGHWCkfWRr
 rAseMXcqcbCkecXVZLdfaXeqHo9jSh/5c3jBcM2mAiJl9IIB5HNsBo8TFCGueYE++OIM
 GJccrpkDwNZJSbzGqksUFPmPpMEabt/9wACj5et8vE4q5iBcTCXpvwsbo+sOAPOT8osK
 U8rWTupF7fuiEYxcRE8WpjfdlZ+2kc52mxj1BFKcGaJUUV59IAmPTDm+V4U8L/1VojwL
 NKNTFIe1NSBql0qzI2Ve5povqBmFI5F+PGJjcvOsyNkXrrCH5KuziUFpMC2ZgfbCrQix
 YpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608290; x=1794213090;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sl/C0ue7XKBR5JLbZ/3q4Bcos5iFaHn+Kv1/3l6xjqY=;
 b=ki1RDKV637AeeT8Bc+HJVSv9ROiHbMDm8hu+QoeoMrHQ4AbTiHkMSEf6CkoF2J+dID
 yBUiE6NNfBLDvFxlZjCk0OZKdwh5cpL0p/yBt5fIMO7AXhkvpXZWEctqmnVkrgKrvSP6
 mAEhyKu2kNpxS0XeMmeKFtWnJ8uzazDogpbxoCPufbiIHZQ/ABzXW9p/i7/awdF3ky9c
 otG1VSYuiag7eBkHBHxjDqc2SLt0elBa5k8gk4eGk3VBtVshjkk+F9PonDg8VCaOAi+D
 m/yfyF1oqKA/2FV6mPQJI7z2wXPbZYK7+ACV4ggTxKcZwq6t/5Ydo0eiPNGSGUYZuGZj
 hE7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBziXC6zbusXoehRgYOmXE85gEBzonkex0f789FVfrA//wWFIJhNv441saOb/6cyM4sJFqtLBUvdXWY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9sAs2UPfQEVdRGKCaEyiIihG3HyyG3H1dmP/YDAEnhS284JL1p
 ESuF4X28TKXI6sos18vBelVFRM9v1D234CbLwglXOuuKpZyyDzkYWrhktLJ+m3MQcMSwjkkL7Dy
 4UWnWSWM2Nks0mqKqYCQAL//MVEDOP0vRrFQqY1t+k0efcb2RzsabPa86crAanQGWudEcDLU=
X-Gm-Gg: AYBFou13ltXxp1eAid5vti3lzVWsd78I62DxnLQMQ4fz28KfpJoaqdUHX7ok3ZPkDeo
 Qs7ESEurKXwCN2HtxlOmwrMKcuoKV+K3fEJR1JEC3NRnln/qmHiCTYMsvVdTvEnLpnvbor33Vp+
 dZTjnn9qQhg1sjWukSm3EA8jEvH9F+WpsLjAYfkmMXBIbDndI/Tz9YBLhjrB87qrunBtPKQk1yX
 rr1rAqXj9gEr7zi7oxQm1Keu+cONGTsbbXo8s6WkpC0f6Rio5bGzzecM9hnIVG69iKMtqO7NkDZ
 wyxdvNRiMszPAM5W/TVqG0Y2kM9pV4SlF3V+174ke8uvLGNiWE3SsQJoZbwLCHL6HuzWWtFrWmn
 EDocS88Xz/y1x8iFF3S0eMiMOD7UVhLiqfxjVcDNn5pZ33PvjFabWgo+xsQ/Jj96ZV8vNwEIepq
 0LTl1yNA==
X-Received: by 2002:a05:6a00:2e24:b0:8a0:3d98:6901 with SMTP id
 d2e1a72fcca58-8a8317dd9b0mr7526917b3a.16.1793608290176; 
 Mon, 02 Nov 2026 00:31:30 -0800 (PST)
X-Received: by 2002:a05:6a00:2e24:b0:8a0:3d98:6901 with SMTP id
 d2e1a72fcca58-8a8317dd9b0mr7526892b3a.16.1793608289571; 
 Mon, 02 Nov 2026 00:31:29 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad9d03be0sm1674680b3a.27.2026.11.02.00.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:31:29 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 14:01:03 +0530
Subject: [PATCH v7 2/3] misc: fastrpc: move ADSP duplicate session creation
 to the driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dup-sessions-v7-2-03f06c014e78@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793608273; l=3389;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=GzcRHbNO2LaB8PuGTjCYn9dNPlPk5e9cggwn9DNEpK0=;
 b=yg1+cd5W5+ps5gLLwfz1IOCzeKnefgGcJpN8uae6dE3CkNoxSlHbgaZ8tfUKjoBUh/R5+Xpyw
 zITO6NzG3Y6CDPt2wrqK+XTiILEQ5FQ3hr3OU8hYTcSYkoz5mA4pkcp
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: ojy71ilybmedX2_R9QhpJaxz-Z4CjzCI
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae84a63 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_Cnv2d4ds2Bg63dH_xgA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: ojy71ilybmedX2_R9QhpJaxz-Z4CjzCI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX6x9p2YGoazX6
 oAqOMQ/0K8kOHeHcY0lsbYdM+jARzjkEUgd+A+upDfcTjqrXBTQhzlgIg0zON3Y+2E/9w5rjLPH
 wIhIE1csxx8WH/XPUsDrnuo0ZfyOsoAjEb+ZmlJUQWsPdbIu4/sleNDuRv3u6M6zA+alvWKFD0e
 H4bDuy1GTDWfOlol/RZ6rtPfG20LRE2P45g3Gd1r9hmNG6XQgwYQJfSCqAj07oIM6O8NBbx3w3I
 OO0C7/ZqPtkQEvekRMtX1mjtj5E20q1JjJn3W/0EVMiAQQg1vttGyItoaS6N3rDHbhf1qOLIyFG
 BwtDyVVs2gjZy7C9fToOXxpa49XaVHJjNMsPLX+oZTIG0SBMlC6jPN5Tu31UHsLslDQ3aHZUN9G
 XaggZIIauLOVKX9ByDAvERW3FyHuDpBFU5VwV7/Fj5jJS86gXJjxU4CsG6ZjC9leM/63gvTAzyk
 FIPgPP5KNrvpz9AauWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX3hKkstpwuknN
 I/lRXYdGydegYVUUJ8v/4RSozgzyaw+gHFv5q2wfzewFpcmgcNeDfsxU3T504RkUmw/7OZj6Bwo
 X1h/kA+x9XbsAoltgovtaspCi8m6KoA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020033
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
copies of the last successfully initialised session for the ADSP
domain.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7441e9b8940d..b4be0ee2bc18 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -35,6 +35,11 @@
 #define CDSP_DOMAIN_ID (3)
 #define GDSP_DOMAIN_ID (4)
 #define FASTRPC_MAX_SESSIONS	14
+/*
+ * Extra ADSP sessions duplicated from the last CB, as each CB supports
+ * only one session.
+ */
+#define FASTRPC_DUP_SESSIONS	4
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
@@ -2339,7 +2344,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
-	int i, sessions = 0;
 	unsigned long flags;
 	u32 dma_bits;
 	u32 sid = 0;
@@ -2349,7 +2353,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
 	if (of_property_read_u32(dev->of_node, "reg", &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
@@ -2369,16 +2372,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
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
@@ -2681,6 +2674,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (err)
 		goto err_deregister_fdev;
 
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
 
 err_deregister_fdev:

-- 
2.34.1

