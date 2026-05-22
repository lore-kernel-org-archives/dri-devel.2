Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F66CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BF110F527;
	Fri, 22 May 2026 10:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqjpioQF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvsPEgn4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25EA10F527
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:16 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M9uUb3312917
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=; b=jqjpioQFFAri1m2v
 HbJL84xCVFhlIq0d2UiQ47xNCEwDEpYfl4QL2066E9UNWXygtvKtJX6KVopUig/B
 DNCs1cdIbKI7+ComLVYO15cK90mYoNtvznOcMR7Pw8RmqruWrK/FwqkO21zVgCBK
 BGtMJPVA+o5ViB3j7kd4mCSt1nju/CF1aR0HxDv8B2oJFbuE0NkFGMdP0EDG41PL
 2EARo6n8CCNkcRm9atfIEi0uo7M3xl0W6uCWvjaXHbMUrrZvkd43nV+sABOxFnxR
 QFVHmfwgpIAYWljVCxKScvyUUXS3b4Wc3qsYtvf0yKf+zVnB4cPFQ+LMUzoQGMTs
 inJCFg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88338sv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82fa7c6699fso11152238b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444075; x=1780048875;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=;
 b=gvsPEgn4UaR0YxxBLWq+caqQxyj+dLFS6OfjYupUNjNbhJjxhiOij4W2f9MrkQoSqk
 CHbEQ6H6UyVE3mAGS7C5QehzjRLJnccVINCTK4llsSmdTy6NKFecyk8LI7DysF6FrIo8
 c+GOaYE7v56UJ9qHDmUBLQnrZpDNYoQIvGuQiet3SQPT1NB6CJTRR0ZwnvZ5Tj9ZxTJ8
 anJ9ReKASjTgPWUA9s1scK/41dgTxFf8cFj26UTvUWQj0qXL3ZF9ZzdICY/ENbX4TbMH
 Acq4jVq6z17/dOEdk3RJSZKEAB51dM0UOXzGwgjXqpJA+TsxjSuw/p4iu9JsGn+R89n5
 6xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444075; x=1780048875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=89GZyqjxzP4kzPz+TzUkPQL4cVAEH+s+D1a55Or7dm0=;
 b=adi50JkAuEYqIDxpZBf296+wVwOa9/05g0qFTdoCRj3D6HgrwExbusSbCjhtCRKrsU
 ivQzgsreuPnMR6rIzA40mla1pn8DTXhUiNWfCXTEo7glIZWvIAHeT2Q7IiNlt5VuXJSq
 v/cfcZaABRfz4dXg4PqQH5iucpBn3SYGMWJjo0Lk7dFcf9T//qEZv7EVVKZJzzyFVms+
 YRFDoATLhD/K5P2Qhb1wQOwCgOciwYmkJJGF/iFG4+aJXDZRYJ7alamIs8V8aZukokUH
 9XKFZUpuJXXx5GzNnzwl75vuIwhA10mkSRwl3OxSsS/Ijsyn7TMUrXgqBkeA2uHE9Lhd
 yQoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kc8AfwuEqBK3ksQFQCC/mmDTPqRN8HxUxL6O1MLHTlSkjqfx/kYP6EqyD0qu0SV1luo3gj9myi/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHOnR4CxQa60eaEcEAKbwJi4Q0RYViL3i6xWMfSfH5XQSuLSQk
 BePW9o6mGLD+T+iNu6h9x7VnLzJiRl+sf1G6b/Ire2VhOcG6qyjIbtQaJoMhmuQt9DMGU7wP/p9
 W6i+/EQX6EhXh6XyLBuJ6ooA4vfWsVfbl5n8gn34TvVLRb2ZUszfJZF/XgRgDjTF15Uf4Zd0=
X-Gm-Gg: Acq92OG5s3umC0E04SNWjeWSV6mKS2wnJYiTxCJ3BPAnNkJF3OTFpsZrJC2LUQDXDXP
 TxqD1BkiStqVAx8dgHNTwDSyyy+VmtS5dH1rfpaiHPrtHkphbER/o45Y70hz5Qub1BD21OTzWt1
 93/Rs+uIa3CHEfGJy5VlOJMVwmvu/AKiDwmb2gDJ/WH/CYAnZBGqPh+u2MB/5vlIUI41Q7v8Hj9
 XDksk0fc57/E9QcIFpmRKm3IHjdEE3ZjhzRqcqAsgQ0BL2TodTKxHZuaDmWCutcbo19G5TauWqj
 LHEqCJcoXOQ/Ql07tlKnnZxWXbnqDFg4vWTnGaJyypzvgZJ7EFoW0uda3LM7UVuIoWcAfU/HVOR
 ZSX5CHsORTlpxakHNQUxgwGqv8Yl/ctwFhhjBX1QIhEgOQ3Bk947wgMjy
X-Received: by 2002:a05:6a00:1807:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-8415f330494mr3326870b3a.25.1779444074783; 
 Fri, 22 May 2026 03:01:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:1807:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-8415f330494mr3326808b3a.25.1779444074141; 
 Fri, 22 May 2026 03:01:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:01:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:34 +0530
Subject: [PATCH v2 3/6] net: mhi_net: Hold runtime PM during active data
 path operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-3-fbebf41a82bb@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, netdev@vger.kernel.org,
 mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
 vivek.pernamitta@oss.qualcomm.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=4173;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=y3Md+/LJdRoPfa8fSBTst//7iA3QrqSh3tsJRClRwKA=;
 b=s+sHbgZoUcbrkhk1NuhJt9uKCZYJuw6T6gtb1ZC0H9M7hSgDCA1Etn58jrZgjHnvT0SCRG62Q
 V7oqxMJp/lHBjYl/lZQf2obhPMwRXspe8hoAXlE3MFihEsy0yCkGb4V
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfX5U/YcNZA8YPl
 Sz/zTtbmQ/OF+l/HINjKCC6csDMf24LlLEz0Cei4yEVBkWzZFLtc+NTLVyLdcaRPc8OlqbICzcX
 m/XEbNAGRtdyYjdXzmdBglAgf9MnGN38J9/MnGqaZy8tVHVnbHCvzfF1RwD7sMq3RY7vIG8wRPD
 NzAXmSRyqhz6GLuR7Thrfc+mbeYA+I6TRjZ+5v7GUmSstJrftJ17KnAzZdS9/8xsXiSDkyYPRbD
 HMuiC84rFzdpzJqosZC9dIIxkFLFJbisVnivMspMhwGpL6CjYCX2ctc22gox8ebN4rKB0M/FcEO
 bhDr5YA4MZfvBCSxzMnPusTSF/g9+vvF+OihFezFTCqbBTEi8Ky4IQpr0ZChpM8NYaakqbghvw2
 reXDwWoC797zqOc2+siQk3y5Bvpr6CTDpdgjA/af5IAZXhiOqx7//U1vFu/967MDADvfXU7mcRB
 OMIoJi6HZ9+OJt8b5LQ==
X-Proofpoint-GUID: 1p1bR25FNRgji3IgPO4ujKxvmcZE6kM2
X-Proofpoint-ORIG-GUID: 1p1bR25FNRgji3IgPO4ujKxvmcZE6kM2
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a10296b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-cKO2LIWXEwUer3o84gA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220099
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

The mhi_net driver does not coordinate with runtime PM, which allows the
underlying MHI controller to be runtime-suspended while transmit, receive,
or RX buffer refill operations are in progress. This can lead to stalled
transfers or failed queueing once runtime PM is enabled in the MHI core.

Add runtime PM reference counting to the mhi_net data path to keep the
controller active for the duration of TX, RX, and buffer management
operations. Enable runtime PM during probe and take/release references
explicitly around these critical paths.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8..5d7f9ccdb17b 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 
@@ -76,11 +77,19 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct mhi_device *mdev = mhi_netdev->mdev;
 	int err;
 
+	err = pm_runtime_get(&mdev->dev);
+	if (err < 0 && err != -EINPROGRESS) {
+		dev_err(&mdev->dev, "pm_runtime_get failed %d\n", err);
+		pm_runtime_put_noidle(&mdev->dev);
+		goto exit_drop;
+	}
+
 	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
 	if (unlikely(err)) {
 		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
 				    ndev->name, err);
 		dev_kfree_skb_any(skb);
+		pm_runtime_put(&mdev->dev);
 		goto exit_drop;
 	}
 
@@ -251,6 +260,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
 		/* MHI layer stopping/resetting the UL channel */
 		if (mhi_res->transaction_status == -ENOTCONN) {
 			u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
+			pm_runtime_put(&mdev->dev);
 			return;
 		}
 
@@ -261,6 +271,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
 	}
 	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
 
+	pm_runtime_put(&mdev->dev);
 	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
 		netif_wake_queue(ndev);
 }
@@ -277,6 +288,12 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 
 	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
 
+	err = pm_runtime_resume_and_get(&mdev->dev);
+	if (err) {
+		dev_err(&mdev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		return;
+	}
+
 	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
 		skb = netdev_alloc_skb(ndev, size);
 		if (unlikely(!skb))
@@ -296,6 +313,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		cond_resched();
 	}
 
+	pm_runtime_put(&mdev->dev);
 	/* If we're still starved of rx buffers, reschedule later */
 	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
@@ -362,20 +380,41 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	err = devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
+		return err;
+	}
+
 	err = mhi_net_newlink(mhi_dev, ndev);
 	if (err) {
 		free_netdev(ndev);
+		pm_runtime_put(&mhi_dev->dev);
 		return err;
 	}
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 }
 
 static void mhi_net_remove(struct mhi_device *mhi_dev)
 {
 	struct mhi_net_dev *mhi_netdev = dev_get_drvdata(&mhi_dev->dev);
+	int err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err)
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
 
 	mhi_net_dellink(mhi_dev, mhi_netdev->ndev);
+
+	if (!err)
+		pm_runtime_put(&mhi_dev->dev);
 }
 
 static const struct mhi_device_info mhi_hwip0 = {

-- 
2.34.1

