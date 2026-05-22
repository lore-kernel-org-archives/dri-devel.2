Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CBACD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA7510E673;
	Fri, 22 May 2026 10:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMMVqtwj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZEooQ2I";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F5510E673
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:08 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M6u9Wj779268
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bd+nfDwDIbDnF5mLnuaN9+Mk0Lao6hQ83OhFSeujfCQ=; b=DMMVqtwjFUO5A5ba
 PHXzJrQrW4s5dtoZxgR7e7xc12CAp2Oy8N8Bu3nWnTUq4D7z4ueSCSwOMEt6J6dD
 DGCS1vxxT3Tib9zmxfd0MqOjRP5eH3aBdloXsnXT9iKYvSLZn+iD64amHlA8wJ8J
 SehF/RkyLz71llNTdyhXDbqcdoX9dUZgLvLewrciT9iIQM+1UKwFv/KR7lIB5pOg
 neAzKnI5KVnD2g3fq9+/XgSbcfzd4RZ1hroGzJBj8xONyNiGA0gEM2mUatzUtZ6n
 zXVd2DU9llaqbnAEOK1cTg1EmxMndtF5+/G7Fckskq0e4WM4ghJvZCl+en1SVJrW
 HPFEYg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7at5te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:01:07 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c82ac893940so3547353a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444066; x=1780048866;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bd+nfDwDIbDnF5mLnuaN9+Mk0Lao6hQ83OhFSeujfCQ=;
 b=bZEooQ2Iny8+m/t/hO0MVkoQCWHfefg7FnWa+z9c2wIN9IvkA93yG5e7YgavxEt8JY
 32aSrsM+WUuJ9vQ4Lx0V6sckIUqDhNgHW9lDTTh3TnQkqXO5imr4H0KI25oFHWXJ1zcS
 c3rd8Y6T62mnO8qZKpKeokYOLiV8deqkD4qg46c8advsJm5iPXww439j6MWhD84Y07jw
 6vVslVMlzrBSsKm7wgwrQRyX7ZeQBxBAGbH1k9igiRa+J+dRZOZsfDhxCqxUEybJ1ipE
 slYJ2fW1ywCEGkHgdFlkptGmnRSU9+h+K2dYWx63yGYCRK0oL4dhav4/ZlkkrmpfNfK5
 rQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444066; x=1780048866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bd+nfDwDIbDnF5mLnuaN9+Mk0Lao6hQ83OhFSeujfCQ=;
 b=m/JwOpBgFc0pQfFE4+HD6hLQZwSovXMNU2/cN4E2QJYw/cbmz6pX/K0Rwz59Tz+OCz
 cfYapOsz0zdt3P/SH6pcKhyGe503TibZIpByhBF+zP4q92BeZTce/ZMu8O3pimaVSXi0
 wC9Hdw78VbTBY4P/CvBJlETw+WFF3T4zp1J4ntsK160Eg+PYBYd0i1IoO2n5msocdnxa
 Kp/mSmb2m3oO/LyI1j7kmijEb/y9YNbAgpHbCmriv+toHHRGHaCOETUTC3T5/WYTkpiN
 yGkmzZmOhUlxmtfPPMQXOazaPcwV7SjBSx942OiiIUE15I6j/v+ySg9yDbiwzXi9vuvQ
 jOyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+h0NDZCt/S6n4QwdkFXDPGL66siL2nRe1PzFycgOxrilaIaMNtb/Zc5Lgp1bOLpCImeEZk5VWYQPM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1KF7py3c2qVmZ4okz4rgX2byTgrjFnSbavfh0tUqcRNwfKDic
 63LkfJy4KDksWYB9pQlnoteEo2vqon0jaFiJnX5W3Y7e6IK2w/WbV1cMz5IB8Oe4YFNWXpIJaR8
 WtIN+aKeVcpBguUf0Tk2cktELQlZl/I/iAN9sZaWY07NLwsoTsQ6Ts6azB6ZdO7A/+5ohDVM=
X-Gm-Gg: Acq92OHELQTI1y+4QhghUYIkMoBTGz5ivKiujBKdrhBrMNfhkUM0RgSSJyXQH9UunZy
 vDfRjYSHdw3vPgQVVV/JnTSBZLXh8C6/HFfIQGL9VAYaf0r9tBVZqEvsjNgFMbt/dPjtRqtjTAR
 A2tjFonXxwbZJF3iJ1KvCu/1zWVfJaor/AU3QYhbc+QYoUCDC74w6EflVedg6w3lnATrSAIx6mF
 3WAbZaPQgvyEX1o0gRNUNh6oEcVMeLu0YgzH/7bGJIB27YC6n3reosJzp/o39DQHx62HJLnNBDR
 b8XvjasEGQ8s8IcXdTz+DbtupWEiJyQdcuKh4xq+gDhdqvJ2xVx3c+530BeDiohSTaVH3W1Ht41
 m6PumFV8fXn6XGgz/qdGYPrpTxg3C3KwH8tTDmuf02JCvewmYkFNNFjvv
X-Received: by 2002:a05:6a00:3e04:b0:82a:7471:eb90 with SMTP id
 d2e1a72fcca58-8415f66c854mr3352514b3a.30.1779444066256; 
 Fri, 22 May 2026 03:01:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e04:b0:82a:7471:eb90 with SMTP id
 d2e1a72fcca58-8415f66c854mr3352459b3a.30.1779444065675; 
 Fri, 22 May 2026 03:01:05 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:01:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:33 +0530
Subject: [PATCH v2 2/6] bus: mhi: Drop controller runtime PM callback
 indirection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-2-fbebf41a82bb@oss.qualcomm.com>
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
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=7368;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=UBj9I2ZVbQBtANcm1Eq+93YFWtxJuvyInNBweC3+uv4=;
 b=guQyGJqG4mutdLlQ1ChKaWEf2g1AbTVPnm7d7mM85MeEF+AFm5bB3tofJI+ZSZEhBZZl45OeD
 YNohaHam4p7DV60pWefjYxjri5JSGcRQkh5MsvyEpd1J63k03Al+5Aa
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: m2JivhVnf9UVVmxxIE3YhC4ZDxFoGisx
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a102963 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GfE3bLbzyHi1VA9kviUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: m2JivhVnf9UVVmxxIE3YhC4ZDxFoGisx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfX7p7/sZJzWXr5
 pdeLqGXtCGV+9VZcwgIbSWCoGIAU9VlX/EgqHRrMZ0UFLNmUxO3BtOVPC2UZd2gnfS3lPBypFs4
 mXwVv8jsZ5ZzGdQQHlzyz1yvweU5eq3ayeT19owwlE76XBz48pL55qD+pR8eIth0utspZAXshwK
 +yBNE9mVJQaAldbo1ToZyvGjR2gOkueMQoO8+5ABFjZbr5JjOC0ubKxHNGPSym5en9i00PYDlzW
 B39g2mGhdckm6K7gt9756Udno83BQBqFFEM3rPlULdBX+MrfYTADZ76HeoloDxTBfPQgjLRiMU6
 tPNG6XoIpSmBcB3nxHuOEO4jdoHzokTeuY2n+QYOM/G/aBalt/G9Hn6i+ptKYmcnetKWucbAFZI
 iW+q+s28eZDnA8xwehHLnkrjM5Cgyspwq4JevN+rWPXZKUPR42hZYXUlK6QCDNrbjk6Hn5R4Rn/
 fyq3DwyQy2POWXANvQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
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

The MHI controller interface exposes runtime_get and runtime_put callbacks
to abstract runtime PM handling from the MHI core. This indirection is
unnecessary since the MHI core can directly use the generic pm_runtime_*
APIs, and the existing implementations are either no-ops or trivial
wrappers around those same APIs.

Remove the runtime_get and runtime_put function pointers from struct
mhi_controller and update all users in the MHI host stack to call the
standard runtime PM helpers directly.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/accel/qaic/mhi_controller.c   | 11 -----------
 drivers/bus/mhi/host/pci_generic.c    | 24 +++---------------------
 drivers/net/wireless/ath/ath11k/mhi.c | 10 ----------
 drivers/net/wireless/ath/ath12k/mhi.c | 11 -----------
 include/linux/mhi.h                   |  4 ----
 5 files changed, 3 insertions(+), 57 deletions(-)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 4d787f77ce41..68cabfd2df2d 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -776,15 +776,6 @@ static void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 	writel_relaxed(val, addr);
 }
 
-static int mhi_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void mhi_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
-
 static void mhi_status_cb(struct mhi_controller *mhi_cntrl, enum mhi_callback reason)
 {
 	struct qaic_device *qdev = pci_get_drvdata(to_pci_dev(mhi_cntrl->cntrl_dev));
@@ -845,8 +836,6 @@ struct mhi_controller *qaic_mhi_register_controller(struct pci_dev *pci_dev, voi
 	mhi_cntrl->iova_start = 0;
 	mhi_cntrl->iova_stop = PHYS_ADDR_MAX - 1;
 	mhi_cntrl->status_cb = mhi_status_cb;
-	mhi_cntrl->runtime_get = mhi_runtime_get;
-	mhi_cntrl->runtime_put = mhi_runtime_put;
 	mhi_cntrl->read_reg = mhi_read_reg;
 	mhi_cntrl->write_reg = mhi_write_reg;
 	mhi_cntrl->regs = mhi_bar;
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 750da3dbb4c6..cbd2b442df83 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1220,23 +1220,6 @@ static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
 	return 0;
 }
 
-static int mhi_pci_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_get() MHI callback means:
-	 *    Do whatever is requested to leave M3.
-	 */
-	return pm_runtime_get(mhi_cntrl->cntrl_dev);
-}
-
-static void mhi_pci_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-	/* The runtime_put() MHI callback means:
-	 *    Device can be moved in M3 state.
-	 */
-	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
-	pm_runtime_put(mhi_cntrl->cntrl_dev);
-}
-
 static void mhi_pci_recovery_work(struct work_struct *work)
 {
 	struct mhi_pci_device *mhi_pdev = container_of(work, struct mhi_pci_device,
@@ -1324,7 +1307,7 @@ static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
 	}
 
 	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	mhi_cntrl->runtime_get(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
 	if (ret)
@@ -1338,7 +1321,8 @@ static int mhi_pci_generic_edl_trigger(struct mhi_controller *mhi_cntrl)
 	mhi_soc_reset(mhi_cntrl);
 
 err_get_chdb:
-	mhi_cntrl->runtime_put(mhi_cntrl);
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
 	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
@@ -1385,8 +1369,6 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->read_reg = mhi_pci_read_reg;
 	mhi_cntrl->write_reg = mhi_pci_write_reg;
 	mhi_cntrl->status_cb = mhi_pci_status_cb;
-	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
-	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
 	mhi_cntrl->mru = info->mru_default;
 	mhi_cntrl->name = info->name;
 
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index f994233df2bb..db163a708064 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -226,14 +226,6 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	return 0;
 }
 
-static int ath11k_mhi_op_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void ath11k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
 
 static char *ath11k_mhi_op_callback_to_str(enum mhi_callback reason)
 {
@@ -380,8 +372,6 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
-	mhi_ctrl->runtime_get = ath11k_mhi_op_runtime_get;
-	mhi_ctrl->runtime_put = ath11k_mhi_op_runtime_put;
 	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index ee87f00bc5de..9122837e5206 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -100,15 +100,6 @@ static int ath12k_mhi_get_msi(struct ath12k_pci *ab_pci)
 	return 0;
 }
 
-static int ath12k_mhi_op_runtime_get(struct mhi_controller *mhi_cntrl)
-{
-	return 0;
-}
-
-static void ath12k_mhi_op_runtime_put(struct mhi_controller *mhi_cntrl)
-{
-}
-
 static char *ath12k_mhi_op_callback_to_str(enum mhi_callback reason)
 {
 	switch (reason) {
@@ -256,8 +247,6 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
-	mhi_ctrl->runtime_get = ath12k_mhi_op_runtime_get;
-	mhi_ctrl->runtime_put = ath12k_mhi_op_runtime_put;
 	mhi_ctrl->status_cb = ath12k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath12k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath12k_mhi_op_write_reg;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index fb3ba639f4f8..46ac60d01846 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -361,8 +361,6 @@ struct mhi_controller_config {
  * @wake_get: CB function to assert device wake (optional)
  * @wake_put: CB function to de-assert device wake (optional)
  * @wake_toggle: CB function to assert and de-assert device wake (optional)
- * @runtime_get: CB function to controller runtime resume (required)
- * @runtime_put: CB function to decrement pm usage (required)
  * @map_single: CB function to create TRE buffer
  * @unmap_single: CB function to destroy TRE buffer
  * @read_reg: Read a MHI register via the physical link (required)
@@ -441,8 +439,6 @@ struct mhi_controller {
 	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_toggle)(struct mhi_controller *mhi_cntrl);
-	int (*runtime_get)(struct mhi_controller *mhi_cntrl);
-	void (*runtime_put)(struct mhi_controller *mhi_cntrl);
 	int (*map_single)(struct mhi_controller *mhi_cntrl,
 			  struct mhi_buf_info *buf);
 	void (*unmap_single)(struct mhi_controller *mhi_cntrl,

-- 
2.34.1

