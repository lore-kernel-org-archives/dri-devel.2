Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FA7C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D344A10E6FB;
	Mon, 24 Aug 2026 10:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAt365kh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYT5QoOO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C1C10E6FB
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:32 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99dQK2572113
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vVusOYN3ugAh2ecLn7CEAf443UVMgdSl2XvYPqrDBtY=; b=RAt365khN+chPPLR
 D0jMxVq98NrNKKEVYf4o+yASOW+2/4AlVFAQ+x1jh7TGhJ08nftLgC6cnvwfGpdK
 XutpQb2nyANTKg7We6KnZ3XpzjlODeLJBkS0OeJVJ5ZcY5qXWk9pPAhpXQdHVRaq
 i7YReuWXfdg/leew+bHa5z5c6pKkQFk8pbSkVOo4VCK6oPVlwNkKOF2ZJ2PdciuG
 q7skLthocbpD1zep6K3VPEwNcMefxOYaVFySqwDmhtYCpxddqoAao0Ga3P1rKU1+
 s+u2z7ksSTnsJvPAk2ebdMdwof/5J0IRW6gSUnRCRMDe5xxrDXXmIx2AmK91GOKE
 mbMvyQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr22kg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso3352683a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787568571; x=1788173371;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vVusOYN3ugAh2ecLn7CEAf443UVMgdSl2XvYPqrDBtY=;
 b=XYT5QoOO0PRwDZsoJakWd9whEsEzuk9zozVWma+fo1yRl5cM22nlm4kI+onB6HlCl/
 FjiKiJxF0QMTicxTp+niU9l/WP0AU5MlFlEKdaJzvb65BaocRejk/w2n802gGtsjAybL
 SE0fPVj2Pe3SciIOWNU5lIOlNg9IbgeWjevL8n0AMCZkwPlTOg5L9rx84/b2n4JZy7bG
 5touluR0FkTdQh3ujpT1k39R+CogJ1KRf9TlGST5Irfp0OJWwSdEae311bXjefQNduUV
 3SmCwIz/JJ3pgo5hRluFWvAYiISVi/I8nByKdka6S0APyCCMs/t6kh30ZiFJxwUGk+IG
 Yr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568571; x=1788173371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vVusOYN3ugAh2ecLn7CEAf443UVMgdSl2XvYPqrDBtY=;
 b=gCI0m4e1NYkcXLUt8bVGGG+W7piuc4mH9LxcCk5hOYM8HuWp6cEIwdYQDNH9WbrgEp
 T4J9a1HEbTp6mCOeJ/O+QDMUqNfle36nAfcq95IIM+JtC71lra7EOSz7WeD4ab4DTKsH
 TWMKU1NVrW6iU4kKzA0pvMAxsKVwhJpYdOurBEm+2g2y1ZTFv+kBEtSquPkIYdZiyGeb
 LIIZf5MqETyomlWgNizcmxmQnn5TPN1DSyPjdC7vp5bTEOhkYIEMD0zr6hktNU1x4De/
 /zyX/Z3qwgp3iXMO7Fwnc7CWLZbAxZpUBXXGngDJFCzSuoWOp83udyfKffEFp+3seefz
 8rUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+7ue7+zRrtuqiZjaGfGhNLZm81JOQ+MdJ/enu1S2XyGR7/ynkxijmzf154/TkiBm1f7CXjH9JgJo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKqRskROy0lXMeUolqZRgPCiWWH0PG9xe3fjozcYjqWDlT+y4q
 RsOjYJUSbu8d5rxVa46FbVOMnYEeY0gCiOlTzGjPbqEN2+v9ELBM3PL9kwLd7dQ2gz0FwP1uB5U
 oJrVBCfOw9dS/u/+/5Z1QQdzGzPmNdi/sTTli/5kyQY7CGZzMCQ2r5sjgTlI5lkEql7udQpNq+O
 0h4NM=
X-Gm-Gg: AR+sD11xjasM0Cab0yDbXv8x7vgggdayCuxgbWPIvFAPOyodHIuAnqKtMEbw8nU+pwh
 iPe517O5wngp0j/yhdVmRCpWtXc9kO46zcKXbDY56gRH61WGa8eSQahoz7JUE4MhOKsgPQdV9Ba
 KJhc9pbBorv1H6zckdU0Gjtu1CXkyamVK1yJr8nvRrM7sR1zpbvpkDPa8kwFUNiCsG8FEg9JGed
 03oBSxuiciMnWg3kiTuq3996+ZSjD86R4nP07qwGDQxYze9PqlY5T+0rdNj2sOdugK4d/FKqnni
 PIzWogRUaoqY+tQhStA+T6sJGnYc5ZD6s03sumzWYbtEwbAOd6XruDA8aJjxfXCQj9jx6IRrPly
 K/vbbbZYIksMjrCmvJns82gSFY/RZCuaW5g==
X-Received: by 2002:a17:90b:224f:b0:381:1f51:1ff0 with SMTP id
 98e67ed59e1d1-395c354d445mr42198019a91.2.1787568570950; 
 Mon, 24 Aug 2026 03:49:30 -0700 (PDT)
X-Received: by 2002:a17:90b:224f:b0:381:1f51:1ff0 with SMTP id
 98e67ed59e1d1-395c354d445mr42197936a91.2.1787568570362; 
 Mon, 24 Aug 2026 03:49:30 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c91ce453sm4125829a91.4.2026.08.24.03.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:49:29 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:19:06 +0530
Subject: [PATCH v3 2/3] misc: fastrpc: move ADSP duplicate session creation
 to the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-dup-sessions-v3-2-4b019def4e0b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787568554; l=3276;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=HM6nYB94UQqzE++3ZIy64Nq0TZgXvgxYjs2hM/NXndw=;
 b=g9wCclPyZiAPUuGFKMrBlbJy5VBBnr74Oy+TaeeyeXIQ03nk9zb8OlN3NKcrfVGygVSTuUFQe
 ofWIpVDiXiSBgNx6+4kYmUdOO0EBI+0LlaoKSTOI9thyPcjuyE+pSyb
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfX/2hmfFs3F38q
 l/bfmlaXabRbd18mSG7Bcm62d0aROkFwklD8nsJHKojeBKZsMal4mcUxpxbN8hp7jh3DykJ/jtJ
 5S/WFKuhLmlaAZfZNAHS8VBHjAULL8m2Ov4YZl4RPYRdlAdU6O+tZehU/5xq6tlzMkHD26D6NhM
 XsMl3ZnWKB39iUnrcg738SQWuiyrA6hDoOb3gK4DHTGJG62woysxtTPEPukx3A5BuLg/QciPCx9
 OMZhOlNgxTpoonlqTURAuAR8bgLv7prY4GcVsnV4mX7fuRnH/FfRA4b5VNAyiWv2G77mdBAd6cv
 f8EAZb5GjQu3D5agMKtcJpx7RxjaFu48Y8piAOAJWtVzMIOMf/cDKVbG2VVSvT26Xg8L5SfeacN
 IuGSeOgTzpgLYUgQIHMpPynVfN1+PLB0iFnnkngUYKpOrcW1tD3HWLztEAljPoR4PGkLbQ8gY+1
 pOq9tO9HXBmNeRmCV+Q==
X-Proofpoint-GUID: H1pJG_fiU40d3KI5GF_tlZUtCeBhdp9P
X-Proofpoint-ORIG-GUID: H1pJG_fiU40d3KI5GF_tlZUtCeBhdp9P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfX4mWTgh5JG6bb
 bDxdODsjscjXl04OB/+l1G6BRljdLUnh8jKKz/tGM1TPqlYwPO3S5z8nOyiae5GFGZU3C8vzHz1
 AYJkj0plUznqGZIJ9IpKpzLsZqQulKY=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c21bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_Cnv2d4ds2Bg63dH_xgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240090
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
 drivers/misc/fastrpc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fe127bb0c115..55653af223c8 100644
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
@@ -2195,7 +2196,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
-	int i, sessions = 0;
 	unsigned long flags;
 	int rc;
 	u32 dma_bits;
@@ -2204,8 +2204,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	if (!cctx)
 		return -EINVAL;
 
-	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
-
 	spin_lock_irqsave(&cctx->lock, flags);
 	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
 		dev_err(dev, "too many sessions\n");
@@ -2225,16 +2223,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
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
@@ -2429,6 +2417,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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

