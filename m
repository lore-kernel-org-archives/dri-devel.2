Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558E606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZP6RJxAz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kvQxsXRM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D1210FCF7;
	Wed, 21 Oct 2026 09:26:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496F610F9A3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L9Bo1C213353
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2BvnoqZZUe+XxnM0Kp7WCyzOWqPOcb/xTa/1aSW5xJw=; b=ZP6RJxAzcZY4H2aF
 /JLzUqi0gmvmU9LyRhTwvotGe6RgfZ/IHX4qdNcnPEvPLH4UlfQsmi/a4bUta+Jp
 6S8371gAAdiWU+V9ADN1fJT/tsLhNPQdTnAoOcYGH3QbnDHJhRNKo2qCrrYwFSlt
 C66v7dC3D7JHEbzGbmqyDdglCzBEMxMttFb38whW8HghFvbG8oa5yPh6NqcDWrK/
 K1/UiQ/GtvXh/unDC+dBoVSmCBFU8qJY9ST9b2QH9W1M3ZVq2VF4j11Y96BninVT
 S1qQzmXOR8950y0MpU7oKNJZum16YNeO8sJlYHHb6nq7MDmZaXbn2OQ/mGauXv6J
 77xVUA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj481qn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so1214574eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792574772; x=1793179572;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2BvnoqZZUe+XxnM0Kp7WCyzOWqPOcb/xTa/1aSW5xJw=;
 b=kvQxsXRMsz1QbCYuSO9IXktYXC0xNRqRv1DNURsj0y4XHL0ym7wecevI7agwKTMZLK
 PIzFwsE9aqppPsFKlnkBoqWpAHKLrx09fN5OwNeiMCQHWYO/ik8QPamdKNrBMF2IbArG
 /mX5dyDOBwJbchm4bNm62A+ThbxzTO13gk/oPQWZ3/L82ncndnHOoxVPYgVZqK8KLGdJ
 vf0yjIHSzbi9iLWkkVfw1Mk9ilLdZEdW//8/utj+rGifm6/UlpK5JkWdS+xKf6hU87bb
 SmGpB6Lt8eCV5Mf6Em03oJLdSHedfxmiuhNjxO7hUFidUIkPKoXo99E2GkyyEbBCFEGR
 k0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792574772; x=1793179572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2BvnoqZZUe+XxnM0Kp7WCyzOWqPOcb/xTa/1aSW5xJw=;
 b=JhKAd06BAZz7aXdYJNgXauL2JpPiSWh5vWr/qT/TgCSI5rhr0RKkv0LyfmA9u7IzJZ
 0mI1BWWnMqPCgrVPxt9TxRd6dL0QT9ro4c6MJfA7npJn+DqWvdKdO/07Oh0p7u54dXlY
 8XN4Luci99CtjbwnyDIfaF5se9GZRTs7kYxpLPxDTno8cfCXOwUdGMGct7UbquXOZdcc
 G8pgXH+vbcmztSJ0ZHc+3gP41sI0iNf3M9uutXVWO6aO0wMdjc2VEpy6La/JL0KZPUP3
 Rh+kWM18abgmejrqQCEicN4fWEkpM65BtmW7ONIZ/leos9IfxeT/RKLCRww/rUZGb5j+
 OWHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDOrX7E019JK3F1q2IaV7HnMDeSV9etkazuYD8U0iWZqAGj0G3O2lDtFOeq5TH0WLzil4erJDxggw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuFCL8cSsYvNCZ73UgMznWdgxmk+tZVotwELJYAbRJDXbVgEAp
 X0PvP/ElwHEF5Jn4vGYIoWs786pRu+PuGJukI6N2MphpZnQ5Fct+4pWbwGcte8Dw3c5INYaZYpV
 l3m0D9ydEhBsbA2os0k5AHIdyT+qvMJn5KBz3B1e7cdRMXlv0dL3BOqjgxGyJoBIztTMo0As=
X-Gm-Gg: AYBFou3UGHKQtTsw6igEJXMP2gZpLMHp7oFOT2OV4mebQIXDZKMrENkN9ACq8e6iKIR
 9lh6lIdag18gkx4dRJAAczMEmjkmarFmZNFEFivlG3wOSlBNxJstQZIHZCUlJ6eCWFpeDmgsdkD
 RvBUkD3TSefhEue88W63sCr7mNJgfFoe8JV2meZr/aFRs8GgAXRN07GdPMNeA8dTZcDTOD/7VCU
 bhNmNWKUiA+xxfQAigVuGnF6dVE00C1JZLAROp8kpXoV4c+pGh+JiVNRzbqhmcd0vq5pw+s5EXJ
 FDGQaGaC9J8mwcontUwvXCL8vUD1ZSBlA9AVOP+MRau9HUGKbZZ1X11cNMVINLhm9XKDcSPueJ3
 lUvXbM1tvABcoWbqUSvhPurvHXEMfwmsB
X-Received: by 2002:a05:693c:62da:b0:35f:71bf:131a with SMTP id
 5a478bee46e88-3674d13ffeemr2438745eec.28.1792574771964; 
 Wed, 21 Oct 2026 02:26:11 -0700 (PDT)
X-Received: by 2002:a05:693c:62da:b0:35f:71bf:131a with SMTP id
 5a478bee46e88-3674d13ffeemr2438721eec.28.1792574771404; 
 Wed, 21 Oct 2026 02:26:11 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc8439sm6155671eec.11.2026.10.21.02.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:26:10 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:55:48 +0530
Subject: [PATCH v6 2/3] misc: fastrpc: move ADSP duplicate session creation
 to the driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-dup-sessions-v6-2-578ab52ba66c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792574754; l=3363;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=hoyqKe3Xg75nwp77nhRMqSJ1qCMhXfgxFsO2RjAVi4I=;
 b=LC1PJt8KXbUZfy9ow4duAZddRfZhmxUyXouyYDY/1eKvG8XU9wQLssAvCoFt9h3kaF+wkgumf
 eoG9rZcAutiAvulGWlaNiI5ZQ+5HfGx3D9mV3LidBOK9FZ36auSqBJs
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: m4deIYotkup8N5PtVoFcBnWElfuNMTcO
X-Proofpoint-GUID: m4deIYotkup8N5PtVoFcBnWElfuNMTcO
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad88534 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_Cnv2d4ds2Bg63dH_xgA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfXyXwFa5Q2c5un
 3Kggd3L3Cp/hX6dnDL3DQNDpIvYG5u5HPtOCZ+p/0DrWdIvabn1uap/Up4sdzXMzzGyXs6kjddI
 W36h5yUGCodkDwT5rzkFOcgaPjDgjipd+CaO+yvX+DT1gv4+xEoYMkfA8+wO0wYvHw+ki+OldWG
 GTnetkgbXMykzaGXZCl3X8KUo4tvSkbKNBLQMpv0c34fYI0rA3skqLh1+6sZR0T+Qj+LEid115g
 layE0yShK65vhNiWFzw6fOxXKjlznaJb8mnidhyxZJYelSTPtDGpCW+g9g7voGfbkbJFJwG5ppS
 H//QCZNu7MbLs3dxP45jjR3eMT8d6VP/47mODxSj0cP3MWckKXcQ7HTstL24Drze/+Gscu//piX
 tokGjaHMvnuayRpaB+iGeCBzsjo9WFDWnGfhWeNJykQt9T9HWDwRndKTs0roFL3MGiY59fhb4fd
 HLBg1cJwRFtyfQLUgnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfX63PhtGWTeYJg
 39Waaic6fluCIvzgFM2bxAWB2J37lzsZxCJBUmQExMw8orJikjZnO1149XRM1ySyEm5RWDNsEHL
 Q2rU7aOGnE7ZECpapE5wpFUv8m2cxrM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210037
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
copies of the last session for the ADSP domain.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index caa479f304c1..5dd1990d3e2a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -34,6 +34,11 @@
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
@@ -2338,7 +2343,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
-	int i, sessions = 0;
 	unsigned long flags;
 	u32 dma_bits;
 	u32 sid = 0;
@@ -2348,7 +2352,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
 	if (of_property_read_u32(dev->of_node, "reg", &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
@@ -2368,16 +2371,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
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
@@ -2656,6 +2649,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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

