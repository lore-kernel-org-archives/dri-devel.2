Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D5FC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BD110E84A;
	Wed, 23 Sep 2026 08:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F7wMsSmd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZHikfzU3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E4F10E84A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:09 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8JTMj3701199
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ottca0EiKIyP7vWmuQi/4WvWfdgC56k4HVx18P6/hbY=; b=F7wMsSmdgQjLZvU5
 2CCvGGk7UpLvzXxhElnevwvA0wsK9FI3rJEYg/KZD7hXBDDr3zX2kwhd30kFL4yX
 pL7CHa7xVSl4YTWqhv6e/ENys4ZL0j4eF9hb6xCVWB6IpjM7HNMOnaKtC+zpLTwI
 uuGAj1aCD1L1LEQ1GVnLHE97WPS6ojYWH3Wyz9LAt63jbITK+nxqWk0YT44jaRh7
 RAh7s2beQmihwxrKf3SRvryJAcDrG4liVjFCvE+tD7thHOP+JrjdB/hJRb8UV33S
 8BGtfwWAfCawmZ7YvQjfIRxV5gLZQpzPwPfdW3hCDcDfHF/aBuGxjYEeJK/nKcze
 FH/9ZA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv428srnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-32b8c2b30c4so989279eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790152808; x=1790757608;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ottca0EiKIyP7vWmuQi/4WvWfdgC56k4HVx18P6/hbY=;
 b=ZHikfzU3PH4Bp3ydzM/BnLkVWhswpbQDRDdZm9w6V4H/VtI6lSFb9hZWWE7J8GZ+kq
 /NILCacN/QJY8f1OL24Tk/H2EzR2POfY69xB8Tc5Woiur6i7X/ZVEq92IZTj4lUk1nIS
 pHSopzNlzHtYhTy6HtqmkTEQcnYIWCm+AF0xZSVOGL9uB8kGgEtQ2fajztBdgF7i4Wm3
 CO6NzvFfyqEIRGSFBOcnIM1hbVdASBYGGM49NirwJL2jN6IEsHDY1pbWJb8U+Cf439HR
 o4BzXhDai6nDfQBSwS4/tkCRQlTh+SXiLEMZE1Z0ekAB7iFGasE8jW/tLLYXn62LbNMX
 /AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790152808; x=1790757608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ottca0EiKIyP7vWmuQi/4WvWfdgC56k4HVx18P6/hbY=;
 b=sTgj5uHtf3hGxI9gLgqDCYbXkvoReAWKNgh2sdvWsKM1IQuvz0yOTbEE49sNEONq4Q
 2zaZxgVWZ6xXem8m8ka+7jwkq5F6Tt1QRKkSuujmlV4OCU+Q5FVQEdw3TcqZ5PGKktAc
 k/F2jiYB3Uuqendlm8lE1RqzYJmpVnQY6YcqGP9GFF3B8jmuripohEyor/V2D5/Dk8aY
 vj4qtBlJ4pgwz1aJ93/EFlMIr/rbHTsVqH0exyKiJrCfD8syAmalLOK1e7VmnGdjWooy
 Qqvs5o2mOSSlhD4IBSoBvaue/aTKpXKd3jtw02a9jUE2EyH02Guye006nDNqkqQN1rZU
 +Ufg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz97ZvXPGfnUlhlV4KW2EVJSPiUy2iV8GEYCLR6MlCVeFO0v4C7vZWLrK5P5Oy2KQJ+Zq/YM3Q/uh8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k8Go5lcPnTaNeFKeZVM3tgpcT87qMfLswGUwRK+iUV5mSxngCb
 79xEOdJs+NqfF7ITHdyJz7iX86btdwIDu/nvwUa5fYRLXsxmes0F6t1dbZuTyYK1na5Q1U1bQ+3
 iSwB/n7wj4cwp7ZGbKgtRqk+L4lvQY06hq5Mc2TmzIi4MGxYzcV4RLqclniZzXl0jq6vcgaw=
X-Gm-Gg: AYBFou05wO4hMsLRfsEGBrplLL7bmwQ6lm9PQpYvyCaRmGYqU8VIb9Gz5YF5hwUmFAp
 kAgsA+gZ4xNhAo0dkb8+VawapPxVzURfl7oFS7UoLxdcSiluEPi5GCWTw9duP5Yku6awhdAU/HT
 60dMUrmr6LsqYBV6lZHAfrpk4w/RC2wr7+7E73QHCA0OOB8PTHCAv+aCW01vjuaOa3cJKIjplVg
 i10Qxh2ungcylSMSfkrQiaG3ppNV8atkI1A/Iqz4sEGJDVsI9ndfLBtjNDi9oP8SllL8zL+ESB0
 m8guM6dUEof+bS2wBUtYo4hM0XXvtYChpzJng8KTNfAfClR/uh21GO1P9qau+9hA8lb1LKRM9Md
 yYc00x1E6Q4m5IvD48DkMp9OqqPR+tOWw
X-Received: by 2002:a05:693c:65d1:b0:33c:b64a:3b82 with SMTP id
 5a478bee46e88-33e8c24a5f3mr1854800eec.10.1790152807758; 
 Wed, 23 Sep 2026 01:40:07 -0700 (PDT)
X-Received: by 2002:a05:693c:65d1:b0:33c:b64a:3b82 with SMTP id
 5a478bee46e88-33e8c24a5f3mr1854783eec.10.1790152807221; 
 Wed, 23 Sep 2026 01:40:07 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96d497e1sm4701275eec.25.2026.09.23.01.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 01:40:06 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:09:34 +0530
Subject: [PATCH v5 2/3] misc: fastrpc: move ADSP duplicate session creation
 to the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dup-sessions-v5-2-e953133a1827@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790152791; l=3250;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=TpBJy16S8qnRUC5bjeqAKGF99NjM6kdKLzu6h6H5AgY=;
 b=N/29XZZ2KO5pgju+btB8IieQgG4KOSTd0lXWxo5oi7fE1R/tYC2WmQBPt/3FoOvHUW/mlk4Ma
 ooHExQpQNfyAlOMaLjv+Yvsy7qeMrbEYL09rXJTHOnkEbEpyCXUiIZ3
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=EZdd0/mC c=1 sm=1 tr=0 ts=6ab39068 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_Cnv2d4ds2Bg63dH_xgA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: LHGLSfaO_8iVLcPXfQs0MPseDm9MymV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfXz1fWKvss+hcO
 HT+SvtIO3SiQqCAfa6uvQcGR20ZfOJFB5F4g/FGegKTLhSLsfZCxFKIxORPuuMtjuRBTG+NtK5E
 HlZ1YR5dOjhODHxMnl/uElBD2M1jII/148k7wsn3XJYpZkTHAwsJ30TOkCL5Gf55RMOcraczLR/
 sEn9SKlzrUSnut6ruoZlAUiBQWC9vOZegPf5WaZhcsUTcPrfMDSfzWdxa1fuWr2Dar94ADw7SnP
 LBMJ4JOAX+U9MOsA/uxIjFdqPpf4WuRKeHT8PJtW5rxyEM8oTqIqclCdMIS+FjpgLsIEavYpliH
 U/cAnf6smmvBnqq5PSQorSoJwKm7zN2h2yeFJ9icql39/QeLEgN73wWuXOOasc1dEu4VYOBkZys
 F2P5inzceNofhu4RMnOYRo7F35PVaRZR2XZrk20XfKSFWN6s06FHuhHBsZvOh73FcITJS+c5YTx
 S69lctZ42G/i3r/iSFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfXwIz6lwR3h3VJ
 ut5Hx+CgI3+01QNTFU3ypfXPXTb1iJwVSdMyXHYC1KKsqc9Zpn2YV80qnpkpnnXLXoS2jTAwW/l
 OMgGQ7+NTOT0BUSjgWgXPF6+uBN3eGk=
X-Proofpoint-GUID: LHGLSfaO_8iVLcPXfQs0MPseDm9MymV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230034
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
index f20d3e5ecc81..b29c1fd00de2 100644
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
@@ -2338,7 +2339,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
-	int i, sessions = 0;
 	unsigned long flags;
 	u32 dma_bits;
 	u32 sid = 0;
@@ -2348,7 +2348,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
 	if (of_property_read_u32(dev->of_node, "reg", &sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
@@ -2369,16 +2368,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
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
@@ -2669,6 +2658,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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

