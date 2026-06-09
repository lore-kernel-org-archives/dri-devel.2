Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AEDCD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848B610E24E;
	Tue,  9 Jun 2026 10:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="graAYAY7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IN1CIRzx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A585510E250
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:34:02 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6599xFEv2208513
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 10:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=brBIXNGGsispYvZS00KeXP
 2e5A/MhRPM3DYvmbD3NqE=; b=graAYAY7dhI35EEP/+Ly+UY1VNhai7HyYv1Sw9
 Lejbdt15CCHlfAS8jnFXnr3G2NTJFA/ikn3iRCl2aJfx6z0tazk8l1t9UfTvMh3n
 ACSfFxsZrRIR8HAa3zENi9eaMK6oDLyPJgx7ggvB1g4pnvfNiPqvGIj+OPHxKcZX
 JOyAdX+131oJ097Kh3FDTlO6RR56XJJKF9cOag+2yU3q6E0nmFVAJQCX0YySoS2a
 08neS4Op3kdxDGRoIMCwDz4DhH57HZiefSrkXzUY2nugIxH4ae4K8f1qyvWedo68
 mgo2gT2fo2nQeaYc1v5dFnhx0fBfis6L8/aCpvdBkhfHCryg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4gre6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 10:34:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85edbb10dfso2945434a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781001241; x=1781606041;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=brBIXNGGsispYvZS00KeXP2e5A/MhRPM3DYvmbD3NqE=;
 b=IN1CIRzxTu7ZE0D5lwkU+8ugwBASiW9DmbrYDmfpp9ft7eMfVv4hk5FaJLGWTA7y9i
 1m3z3ynG3DI6HfNn3sRg3Bo2PCys9YWpa8OYH78AgW39V/FQuAnMP3C6KhctBNW1DBcN
 wrY3KlrWg9G3obSq3uHHQ5TeEpPNsH8lZd00CGuBSJjhqZR6VT0LEhw6ei2io8IenVUI
 gO6V3aW9JV+U/KLkIHGgb61FRmSMI8ElRHPpHSaLdGeMTQElynN6HyL8uk1xZKs8C8LQ
 2dej+U2tjqGVNoYvEELAQMPgfxgyaXPK/DDAQtichSEKNVPkWkqEOt515Z/EfHQtn3Zz
 2A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781001241; x=1781606041;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brBIXNGGsispYvZS00KeXP2e5A/MhRPM3DYvmbD3NqE=;
 b=imykIeltrPX/rqei5b8An4GtK4FvNeljgJaU0Ln1Yz/9j2whGtgJ4cbeZxFvdumbfF
 evAErHMjKqf4enGbNDDTrW1WRE+tzm1XdkJAg+cUDDmqlMaIBmjRlWWCZJTsQSZww925
 EuICcKb7FdclVV1LubYaRyIP/b+JAMtS0DAv/woDrsvPLBkFdnfF590ZZnK/zZyh5w+m
 3UEBOUwaBtJ2si8ATRhOakwARR1c/5Ecf6VSM7JbwfvcRUTfu2zldskBIffKtcNs1bim
 uIbV+vN/VQ17q8tK5NuzRiEQzPyE9c+z3yKTdC0ARzdmRBcPFsQ4IL5eB6k/IQQ7x5VM
 AHww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qFl/A6vbinBu2JrFGMxi5+oC6faR95zgO7TTnojESfaAGboh+HOnA/CwlNASm7xQcW8P6Wp6ZTug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaLd1nl2QoMewyyOKNv0H+ua+sl3Nn0rzMntOG1e8e4aI/yI23
 ormldJxKlZjn+orNrLq3iG4MvHIEOldFR8z91rdd/yXFZ8eNskWBNLs/6Lq+EZBvnRYAx05OXZ+
 TV4iwzUndOxvqKUexz4pttS+5ZjKT/qxwg0o6Sy6+JRrnpjzXrurQ6pwyk1Pz9KDaVciNnyg=
X-Gm-Gg: Acq92OEeuLP6ILJFVgibzYLbgHbOndd45wijm+RDZB5LBbcnQYe7a0aO9U0920Zn6bg
 Mi4KHciXJc8/QsYDDHOJ43STWOL0vbm+IBzBO07C52Wn3HdZlx88x1UcvOxGg5m78PWTi3ApAHA
 6AidNZ1LzUAHZ62f3qCpVg0jmHo/BIJOtD/3XuBqiqm2+Bm1CC1UM/ghIe57K/nOp4lAAZknLH8
 iDMAVfNnupQnJPX6yfi4JPDE8jLw7wiVGE8XaJr6PUg+7gKGF+++RzK+zdqBWbMkMhy59w1IBgk
 90CnaE1jOAO/8LB+5wM4QOfG+6fTrwDrhrL+nICsd8Z/WdvwyW3s00Kyes0IfWJR9d2NiMWbUVJ
 p8iP4g6l1Sh1OR4f+IPYditm0nJ0N1VaI5WiqXruLPI1CG80j4sO2L22x3zDsOpZXUg==
X-Received: by 2002:a05:6a21:699:b0:398:6ec6:b06d with SMTP id
 adf61e73a8af0-3b4d3dd0543mr17149844637.34.1781001240641; 
 Tue, 09 Jun 2026 03:34:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:699:b0:398:6ec6:b06d with SMTP id
 adf61e73a8af0-3b4d3dd0543mr17149809637.34.1781001240195; 
 Tue, 09 Jun 2026 03:34:00 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0a4afdsm21001446a12.19.2026.06.09.03.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 03:33:59 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 16:03:11 +0530
Subject: [PATCH] misc: fastrpc: create duplicate sessions after all CB probing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAObrJ2oC/x2MQQqAIBAAvyJ7TlAJwb4SHRbdai8mLkUg/T3rO
 DAzDYQqk8CkGlS6WPjIHeygIO6YN9KcOoMzzhtvgk5n0ULyeaIJHUbEaEMYoSel0sr3v5uX53k
 BRVWeW14AAAA=
X-Change-ID: 20260609-dup-sessions-ea2acaac1994
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781001236; l=3981;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=JskPNUjl/unnUFjATN8VxXMvtu7xQ8Bn9aXHNcT2bA8=;
 b=wSC1WwlpkDiGveaxKjULB608p6GB63IHA5iIprbeYniOxm+B+EYXH5aZF1p4xC8N+oFF53YFx
 mLiMqgf/bG7Co5c4pE0N/YAGQ11l1b8/n88fZg6xVBvkyo5ebSLiUY6
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27ec19 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_Cnv2d4ds2Bg63dH_xgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: t0piLM041zv4446C7qndnpMebJ_u64Fd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5OSBTYWx0ZWRfX18fZ+dj85O6b
 RqWtrEUVtqJDBpM3vCGyw7Oyued1Poe6U0DsMfRYaQpf89LYmT7/kpcZuuowcYhDRDEIRdO6qh3
 C04/0eNcK5+dih+bBPUyWpzcMsK9k6rrUiswTgQs2p1GgaXYr03kRVT05DEavlREY+IEcXAQ2W2
 ZA1S0nn/O77IBpkI2i6unU2Qc5EfZFWVDZ+HWK6owkDKuM27tTlQK6NMegFIAv2RdkknNcXPj3G
 fOTHlxqYb6gACdoz3RrJFxQZkIBqx+j+I3r2FtXGVa2shiL02r72n4oRF1wMyskUURm4cWI/HuD
 PanVJVvT012evaGEhm7AcWVgpHs27aEep/OTGowxzNYkf+yOTcnst9fXjo+nni/6QGCVEh1NnWI
 4W2NI4rIhb5hwazsVrxfMsP5vOHwK9U9whTZdRld3Qygxpz//cvb9F80kumMNf5asAvUtSIep3B
 qxSzQEPdo5r780hkTWw==
X-Proofpoint-ORIG-GUID: t0piLM041zv4446C7qndnpMebJ_u64Fd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090099
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
 drivers/misc/fastrpc.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..46afbae9c234 100644
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
@@ -2445,6 +2433,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (err)
 		goto err_deregister_fdev;
 
+	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
+		struct fastrpc_session_ctx *last_sess;
+		struct fastrpc_session_ctx *dup_sess;
+		unsigned long flags;
+		int i;
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

---
base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
change-id: 20260609-dup-sessions-ea2acaac1994

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

