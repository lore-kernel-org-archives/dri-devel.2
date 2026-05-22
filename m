Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3FACD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0674A10F528;
	Fri, 22 May 2026 10:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgzlyxGB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IuRMzrFc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D74810F526
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M9wSIJ312895
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P+6QIFUay/hg2xkAFLiW+meafenw/9VGhbxcOU+YUEk=; b=RgzlyxGB94tPSA5n
 VmceMUIf6T/pLYNQQdcpkxCalmE7Lg26vv2WwJqGcuj4W7nHxcjpcLM1mBh+iXE+
 72/xMMGiPCSy7eXlSFdyXhFM5lU2AVcEYijhJ3Pvwg8nESKOBXpZmVgkT4GMycdv
 ic8HSEjmbIz0XqwzDPbrZirpSCFDLRtUNlBVker1EaBUd4nnlU7n8EjkQSNIJLS4
 8Z+eaVoJpuyr42ZlyZia5YePGd9O5XuqnE9GP7ajY929j37pU30rk4XZMrBPB8KH
 5TmBdinMtcQfwbL69AJe9yj5FeSUdPjKDOny2ntiBeYmvcT8iiep0pyxYhJKlwvw
 VQ3lWg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88338u3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-83836443305so3635468b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444083; x=1780048883;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P+6QIFUay/hg2xkAFLiW+meafenw/9VGhbxcOU+YUEk=;
 b=IuRMzrFcYGV2eJXFvlZkzTLyDVeU3wUJ7QdasmnMdeGeS+WVNl/Hzn9VBjPF22GsVS
 0sB6wpf2RcSLIFpedS/2gondIgP/pTnX/aOVfN72onMi1+hAS5grvx/E2qTCxaOf8kMp
 CiHiC+bCoGDO783oeJtZK/+BH8KFjs5HRUQjJrO7D+nJziCK1ndoNo7d2V/HN2Tc9jZ8
 0A41jAAHTVFEnnmQS9qihxsrVjBtfx8gglZdlaKiwzQspV8ML1USZO1KOzOmIpPCRj/e
 pWHnliQZ0S1h4rA6hdYVdaJ/N0VTSrFZjXwdPKkz7AybUxZ1cs2+rAwnTzGyRHlYVzUA
 6jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444083; x=1780048883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P+6QIFUay/hg2xkAFLiW+meafenw/9VGhbxcOU+YUEk=;
 b=GqAq8U8jjaZFy1yOptZ9QLyD+QrJAjXL0aZqiEmar1wAk4QaoiGJ6nD59wefoTtB4U
 m2ubZMoUVmNR7xe/g9F+TzNA1BP1el/ZgNsry1JAkVHev+Jm+H/ek4eSwZS97ku2ZAz4
 zSAA6otcL8aFi9Wru9W1GOGqDhs5WjJlzVhnm0GwRzs6e3uRUSyrG3KovxDxJn4xbGIL
 EQ6/CyKMbifXQn6HyOR1qE3ixbVCsHgEn1mRtZrR9z639kfM3Fn0z/dOuct3/z4sBDnH
 StIakMN9va+/hI5iT72SrabDjkH8DL+BCW5TMdT0uXAWgwt4SVDUmot0ha4txxbV/ys0
 fkIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GfTitZdqIrQFTkdZuOr8VagOKdAFLNxJIF1qmBKDQ3kJD0MBsjmk+959remAeGVDmdOqNmIZj2FE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMDwbqYxjQXJHWsiTkOGl7mKusinZtnrxRK2XZcVc3eet21nQS
 qFTzh9uVDfG9Yzo8DUJKNP03s1sQWdbAtH4pnf0N/q/JqdUkrP7+CYzRppWTEl+PmvGxasOThjv
 Tow+yQsQ7GMFeUdgc+/3ik8IMO49prO0OUsdbGgeVW0FpLMs1oIvKMaeQ0ARY6imLqdJS5Z8=
X-Gm-Gg: Acq92OHmDQ4bZugqdUmwNGgZD8UlGRyHJcTClxPFP4C7pGw/aXBGXoaTWvUnUcgz/Pw
 Pug/85434A5fqEGDT7vMItr41joZmWPieY9ROBThN8FAaxs3G5TvKsrio04kvjGK71j1+PUSI2d
 0C8xfJg7lqSM2hCUNAAWic8aOnxmr02gLNRR5mpcCe9L2VMJf04vRM1k6S9dkOv0sI/hLUfAgsV
 FumIrdR2IeURgbzemqiyJLKL+uOMoEr20DhsuaH/c3tShfuyeFGLx/SHJZL7h54I4diMQX4nYRp
 SYfom1P5sVw/mG6+M4LI/8q9D8srYagTfv2rJRV4VLZKJ75y6ECq+xju4syaPD6HXTAGML+IwiH
 esxTasDAOxc+wvTiuuYVb+F69CQerzbqPl2391Oz1mnqey/QAQe7DcrOd
X-Received: by 2002:a05:6a00:438b:b0:82c:9f7e:518c with SMTP id
 d2e1a72fcca58-8415f32e17amr3015030b3a.25.1779444083207; 
 Fri, 22 May 2026 03:01:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:438b:b0:82c:9f7e:518c with SMTP id
 d2e1a72fcca58-8415f32e17amr3014968b3a.25.1779444082645; 
 Fri, 22 May 2026 03:01:22 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:01:22 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:35 +0530
Subject: [PATCH v2 4/6] net: qrtr: Hold runtime PM during active data path
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-4-fbebf41a82bb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=5157;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=BhFCU11Vli0eY4peRB1YT42TDHVLDyHFog9G3pGgq0Q=;
 b=UVBS6HbShn+y5fJQr2GY5SAYIopHLLknf3feWh42YxN8Cfo16vZuvf1XVAOydKz7dA3b3K6eD
 /OQhLOIVtQKBDTOurt56nsyDbIEnzo5jjzEyQsOPqQr9m2m8ymwcde3
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfXymwRd/PbMfiI
 SuS+SGi+eTi63tmmonyPGfPyNAmmbGM24GFbVHkYEQTX6WO67xOuTbeVeZC9nyFCZwXXybgbQiD
 7KgdD8kCwj4AuILtKTuVEl+de9/o/SBX3O5r5UcLjR027DjfNnNUpnXwjXZGoEVkndwGqub6ini
 FywSREQ/r19u/d6MjGGwl0EH9xvZSB/EABg8ACmazC2dhCj4+fd0esSRxb2m6WWjCbZ62dt8Axr
 q7v/t/ze5gTK7MBLUqZJ1BvrjSXZYjrooanoFp5M52a5bVOYcxF+BKPHpjbnbZ1lkl30BwPCyU1
 se5uoUg4to+r0WDlOXU+S/Gh2hfXLgMeDWuQzOa95zm36ApnS/Yx6gfdfXNvtsgMz3WgpqmnpfI
 aK7LyimDoWIm2XEEh9dEsiTq7Nile6toa1j611T55izbYDeeKkl4KEO02pRmFp6arAzCPOwKjU/
 xlVLzdIEfuq7HjJPq1A==
X-Proofpoint-GUID: XKTsGUVzX4Q4nbK-LdijrBu7LUZKRDaZ
X-Proofpoint-ORIG-GUID: XKTsGUVzX4Q4nbK-LdijrBu7LUZKRDaZ
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a102974 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mqvsnErzViNTL7-QoTgA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
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

The QRTR MHI transport driver does not coordinate with runtime PM, which
allows the underlying MHI controller to be runtime-suspended while
transmit, receive, or RX buffer refill operations are in progress. This can
lead to stalled transfers or failed buffer queueing once runtime PM is
enabled in the MHI core.

Add runtime PM reference counting around TX, RX, and buffer management
operations to keep the controller active for the duration of each critical
section. Enable runtime PM during probe and take explicit references around
these data path operations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 net/qrtr/mhi.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index 80e341d2f8a4..cba7a5daf7a4 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -6,6 +6,7 @@
 #include <linux/mhi.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 
@@ -38,11 +39,20 @@ static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
 	if (rc == -EINVAL)
 		dev_err(qdev->dev, "invalid ipcrouter packet\n");
 
+	rc = pm_runtime_get(&qdev->mhi_dev->dev);
+	if (rc < 0 && rc != -EINPROGRESS) {
+		dev_err(&mhi_dev->dev, "pm_runtime_get failed %d\n", rc);
+		pm_runtime_put_noidle(&qdev->mhi_dev->dev);
+		return;
+	}
+
 	/* Done with the buffer, now recycle it for future use */
 	rc = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, mhi_res->buf_addr,
 			   mhi_dev->mhi_cntrl->buffer_len, MHI_EOT);
 	if (rc)
 		dev_err(&mhi_dev->dev, "Failed to recycle the buffer: %d\n", rc);
+
+	pm_runtime_put(&mhi_dev->dev);
 }
 
 /* From QRTR to MHI */
@@ -54,6 +64,8 @@ static void qcom_mhi_qrtr_ul_callback(struct mhi_device *mhi_dev,
 	if (skb->sk)
 		sock_put(skb->sk);
 	consume_skb(skb);
+
+	pm_runtime_put(&mhi_dev->dev);
 }
 
 /* Send data over MHI */
@@ -69,13 +81,21 @@ static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
 	if (rc)
 		goto free_skb;
 
+	rc = pm_runtime_resume_and_get(&qdev->mhi_dev->dev);
+	if (rc) {
+		dev_err(&qdev->mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", rc);
+		goto free_skb;
+	}
+
 	rc = mhi_queue_skb(qdev->mhi_dev, DMA_TO_DEVICE, skb, skb->len,
 			   MHI_EOT);
 	if (rc)
-		goto free_skb;
+		goto runtime_put;
 
 	return rc;
 
+runtime_put:
+	pm_runtime_put(&qdev->mhi_dev->dev);
 free_skb:
 	if (skb->sk)
 		sock_put(skb->sk);
@@ -90,20 +110,30 @@ static int qcom_mhi_qrtr_queue_dl_buffers(struct mhi_device *mhi_dev)
 	void *buf;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (ret) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", ret);
+		return ret;
+	}
+
 	free_desc = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
 	while (free_desc--) {
 		buf = devm_kmalloc(&mhi_dev->dev, mhi_dev->mhi_cntrl->buffer_len, GFP_KERNEL);
-		if (!buf)
+		if (!buf) {
+			pm_runtime_put(&mhi_dev->dev);
 			return -ENOMEM;
+		}
 
 		ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, mhi_dev->mhi_cntrl->buffer_len,
 				    MHI_EOT);
 		if (ret) {
 			dev_err(&mhi_dev->dev, "Failed to queue buffer: %d\n", ret);
+			pm_runtime_put(&mhi_dev->dev);
 			return ret;
 		}
 	}
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 }
 
@@ -121,12 +151,22 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 	qdev->dev = &mhi_dev->dev;
 	qdev->ep.xmit = qcom_mhi_qrtr_send;
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	rc = devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	if (rc)
+		return rc;
+
+	rc = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (rc) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", rc);
+		return rc;
+	}
 	dev_set_drvdata(&mhi_dev->dev, qdev);
 
 	/* start channels */
 	rc = mhi_prepare_for_transfer(mhi_dev);
 	if (rc)
-		return rc;
+		goto runtime_put;
 
 	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
 	if (rc)
@@ -138,12 +178,15 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 
 	dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 
 err_unregister:
 	qrtr_endpoint_unregister(&qdev->ep);
 err_unprepare:
 	mhi_unprepare_from_transfer(mhi_dev);
+runtime_put:
+	pm_runtime_put(&mhi_dev->dev);
 
 	return rc;
 }
@@ -151,10 +194,18 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 static void qcom_mhi_qrtr_remove(struct mhi_device *mhi_dev)
 {
 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
+	int err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err)
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
 
 	qrtr_endpoint_unregister(&qdev->ep);
 	mhi_unprepare_from_transfer(mhi_dev);
 	dev_set_drvdata(&mhi_dev->dev, NULL);
+
+	if (!err)
+		pm_runtime_put(&mhi_dev->dev);
 }
 
 static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {

-- 
2.34.1

