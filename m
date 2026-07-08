Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F8BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 03:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181B810EFC3;
	Wed,  8 Jul 2026 03:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kU50F+pV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YegNmjSg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9D610EFC3
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 03:59:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Md3p7964512
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 03:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FaiG/eJTya26hN8ZkkimAahZgkkyWSyTo5eeeXV0qN8=; b=kU50F+pVW7duPG1j
 nguPI7KgKlvCv8FZO/yiiROpFLdzH7MlwlqUXra65hFEtHxzizT4k2NbBEeqdecc
 ZEgnUcD/9JiIDo1n7rX7pBjTThjbNWCdA8SMJ0SsCeXP0AR+mqNgdJdTCzb7SXV5
 bWV2Q2n64zKJzT4QvnFRxjfnEM1my56AwtcJ7aaFOJLZLua6cf8hQOtm1FkeSOyf
 qYqjn7SVAlF2Cgfe9H8uLS7Jqu0zk92ADQi3zRslEpdJeRbhOMS2nPyTE2MhaWQV
 P0dgQQ6fLYsEbw5A+ioY4CqN78Kd0dNfMbdDsBdp7ldtWqG9cy5bi0CqlydMkkDy
 TKwCvg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep4jps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 03:59:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9667280edeso302628a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783483141; x=1784087941;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FaiG/eJTya26hN8ZkkimAahZgkkyWSyTo5eeeXV0qN8=;
 b=YegNmjSg0rz77TAFTWfXKJJftSde2V73cZdXyYGsUcHcVKgcwdNDevhLtk2RYvqRQq
 XmpbLWwvIgB3DqdZZ5yYMoAvR7MHALKHz0nZu8Xivzk9i0WwTC364NRellqpMU7QJcoD
 uAI5+vnaWE4Hu9ypxmvV1cFtn40eDscpCZ6Px0Fcan8/fhAFnIreniDAg8rbeXnLZJ2o
 U5UVwY32TVPxQQriHy6jAXATWsnKtDs/wNAdUxZyldkGHZ/VFdqit2ZYe5C7w1zI61q8
 0mMfuGtfNv7OgDb7bevX9vlMoV2s1GagQKp6d2wg90NY5BGPEU8ZQ0x8Qwtoa1CFgzSo
 tYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783483141; x=1784087941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FaiG/eJTya26hN8ZkkimAahZgkkyWSyTo5eeeXV0qN8=;
 b=BKATB+iMkCacb/+cDedRWJz3p+MtcuWxCxTkZikn7v9ScH3xN4ps+Dwe2HvxWlfKBi
 S9OVR33Rk0Yv0c9FiIRiy/VLz3mPHNQwYnowkbvb89b0ydF/2p/voj/ZUhm7TiudeIUG
 S/DLnZ3po95FXUyfzuv51AOzKL3zta2yLf/Y7usQ3fZUU/vXClZnku+z20dbyRWiZOKi
 /QE6AuW2Fss4TQaZXY7xhUynbP5tQ4kwahbkqYuGri/dWqAieAsBNvxPpKa5BrSmvH9+
 WFVph4j1XUvBNrd9fiiQZF4QLV3qNIY8thfreBknWjYBmm2FpUQ8ehiApPgUG4rBCG5G
 Qnnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkuyJ04JfJOicNVGEiCzHWYbdKGqO4IWXIqgtxaKSp1R3QK99B0XEZX0KyXGbeAbH2UB6jQ21c/c4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKMSGM4MdX10fcIpol9tpKYSzbo1MA86OCTXdwmtjLvrYXuSa6
 vBlnRP0Aet0JYYyMRfgZAHUlOAerG5VB4AuZMweq0YG9zps7tAESUGdKs1Q1WsWUwgdSAILILVh
 jFZKzHMSnka4poldZQInaZd/r2Rbzx/sLXTkqtRgXfbjgKpDJ3llz2kLnhKpqkkuKJNyC+KI=
X-Gm-Gg: AfdE7cmiddiFNj23QQp5LN3LKpz9kzROgizpDVG0NFrE3yAv2GgZsC3q646n1wJcwEK
 AcQf+A6q20zg1JyMsJN+qradqj3YwhBazBirE0SuXhih1epaCJ6Rk4ST4SuniOsYOIyl2WSrhdg
 yETQ+lHSFeDVdGLc1pCYOZy2ingwlX1N07jGOp7GiQ2UrHIbCLEokAjZGrNrxwNGop5l+/MO3v7
 aNsmuI1hF7ySt+coEgq/6nX2VGZ+tQjMyjkZtdjvMHaAz2qhqa5aAoEpvtJnG2eiaLPc1HXccjV
 AqqHWE/4vaB7LzKMEdXaeNYhzOIvTbyTNP6jmx8bQG7xoGp31aUae+tF3wiVOwr+mLDkMWB0qjO
 Sa4pRG6oH8wJUTj1dBcyxgoxyK0tJYKqK2PJKGlaMIBUt
X-Received: by 2002:a05:6a21:62c8:b0:3bf:aa1a:d2ef with SMTP id
 adf61e73a8af0-3c0bd164cd0mr666224637.56.1783483140621; 
 Tue, 07 Jul 2026 20:59:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c8:b0:3bf:aa1a:d2ef with SMTP id
 adf61e73a8af0-3c0bd164cd0mr666186637.56.1783483140117; 
 Tue, 07 Jul 2026 20:59:00 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm14487136eec.3.2026.07.07.20.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 20:58:59 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 09:28:33 +0530
Subject: [PATCH v2 2/2] misc: fastrpc: create duplicate sessions after all
 CB probing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dup-sessions-v2-2-da40f9c98a2b@oss.qualcomm.com>
References: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
In-Reply-To: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783483125; l=3803;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=E1UlleUpatfwJfXD7CvEFNe2U0LGFAfWDhnzotj82/o=;
 b=vzZxLNd7liU/JhRSS81E494juiP4krazhNrpl1MhaEYQUKdt7OFLSrYc9HzaqlKyJUsaTdVEH
 eYM4q03WfjQAGUl8BUukX599/aTRK0Z40NuRBc4TAVEgbqe/Pw8XdGZ
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: yFx0qpsz8g6dBrNlfOzniwFhBeOBMhKy
X-Proofpoint-ORIG-GUID: yFx0qpsz8g6dBrNlfOzniwFhBeOBMhKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfX9Y8XcsE27Xal
 Upw+aKSQB5mZy4n32BVDHKnKlOFdLWECVX5xP/3K9f8E46bqH/7NAqv+JqV9sRZ5yYweKCnCVCH
 mGMV3vXhbLgxiwYvCMFWHfnvbyBKSkrBcog8Iy8gYCJxM7xXjfULCUU7sckXPXrlhqU5DIPuDaR
 R/YR9kGvqdj7TiTwKsPP1O9ICMKTCGdto8/whTQXGomHuqedwZAF4TPoRLP6fcWBbHY/miD4G1K
 LmutfKScOLtpkNWQf23Ya4XrVTor7ZFLPrHBKr46Va6hQ/qTnBlHbnQejOVjofaStKLgjhBryLe
 atoGVgX1aL0Hbx04OhJEaFUIY3y9+GjDMEoBx/v7NEMpRuu+KGtr7Fzfqp5VBRXlSCgj0FkscBS
 X3CXMpZbe+u8HunTtn/M9W6+iVOl4TJg60PpIzf9yKjorB3hIpZdHbcoi0OGXAJCHx9aWFoDcMg
 ipR4Gw2nUXNV2xsd9Lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfX4vENsWhQfKeZ
 MXqTGqHF4IcXvKhx7Z4HYxKi7+pzudTExdZs7bS5iPSZ7iILMlrxmLe3qseN1uz8TUvRbX8F2TV
 MIhJmnWxGl38F8Ai2f0kAulSZO6iIzk=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4dcb05 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_Cnv2d4ds2Bg63dH_xgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080035
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

To address this limitation, a Device Tree change was used till now:
  qcom,nsessions = <5>;

However, feedback from the upstream community indicated that this change
should not be made in the Device Tree. Instead, it was recommended to
handle this as a driver-level change.

Instead of duplicating sessions inline during fastrpc_cb_probe() using
the qcom,nsessions DT property, defer duplication until after
of_platform_populate() returns in fastrpc_rpmsg_probe(), at which point
all compute-CB child nodes have been probed and the session array is
fully populated.

For the ADSP domain, append FASTRPC_DUP_SESSIONS (4) copies of the
last probed session once of_platform_populate() succeeds. This keeps
the per-CB probe path simple and ensures duplicates are always derived
from a stable, fully-initialised session state.

The qcom,nsessions DT property is no longer consumed by the driver; the
binding and DT sources are left unchanged.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..8a3944f6c036 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -30,6 +30,7 @@
 #define CDSP_DOMAIN_ID (3)
 #define GDSP_DOMAIN_ID (4)
 #define FASTRPC_MAX_SESSIONS	14
+#define FASTRPC_DUP_SESSIONS	4
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
@@ -2195,7 +2196,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
-	int i, sessions = 0;
 	unsigned long flags;
 	int rc;
 	u32 dma_bits;
@@ -2204,8 +2204,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
-
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
 		dev_err(&pdev->dev, "too many sessions\n");
@@ -2225,16 +2223,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
 
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
@@ -2445,6 +2433,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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

