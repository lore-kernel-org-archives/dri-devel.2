Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4691CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A43110E028;
	Thu,  1 Oct 2026 11:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T2VLeLXZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cudWRcjV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21DD110E028
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:02:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xPSQ1933074
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 11:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KiHrKYHs1q0NoEg2GeDpcNzoHKZ7xEAHie7JhW8mVJw=; b=T2VLeLXZphN0RH6C
 2R6fLQ28PdKnWSttxWCnlQQHNmG4gXZW7JLIEtvbCnLKAX2akFoz46yIjx4JqVTk
 8rXWsc+3QNZm1onb/YwI0ZrgID1bfvw7M9ZpqemMQofiuD0hfuSeR7APj+8f+7bh
 lGsGE0qa4fQbw/Y/txXzdyCPNQvuA+z0g2uSDTYebALEDPf014fD6Nec4T6o4/0u
 7ov71h0fMKGrOUohigIS1UXpRWnQ0tvtRcs5ynTA06OfjFHDb7D8zxdXC91OAgkc
 eny4ex4YdnKVORBVN5p3u4b6OCajk8QQM2ZlkyIcIoDZRgt+Lyw2bE3QPAvqdiml
 BvMLhQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfs5xm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 11:02:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-86261e66700so4866196b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790852537; x=1791457337;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KiHrKYHs1q0NoEg2GeDpcNzoHKZ7xEAHie7JhW8mVJw=;
 b=cudWRcjV6DCGzxEF62l+YhByX2CZBAIXjxJUVw1ipcNsXOi0lQOBEdrz4wRpL+WabQ
 zff1hN9WLK5garwI8XGwfIDLJrbSQhW1BLQIMJ7/6/73mnu4hWFbBcQAdxj3HUWs30bG
 44+va9V+xF7Vh1L5Y7toCgoDqAODvmRB6dkQuIlp1mvJrhAkd080zDUJcNlaJLS3iE+k
 jzx5cPk6otMUiSQvRkYcsg8IdRHQLb9Hrl+oJosf/Ef9Jr++0Ssh6VmJV28NUhyEhHbn
 Wt9bBchNyfISzIiW0g+Z/w5XTXsITQ4uBQL5zPxynaxvuZfNlVyYRlWY6dQHOlKorToD
 Sd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790852537; x=1791457337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KiHrKYHs1q0NoEg2GeDpcNzoHKZ7xEAHie7JhW8mVJw=;
 b=s+BLFUx54xSSskvlGQRmJfeaYLV9fgrrkP3PDnx1Z2XvPIkxKA9ErWzgofKdz82hDM
 OAaNHTuN+WlS8eGArxciCaIahMZDfxmsUslNFPo5D4CsehoUT2aYsbBSilveGe+J75UF
 E6Gl9b/OrN+xrxuCtT4GAN8jEpkbXKBAe5zNELGekUMWNrTrhpukI6DpPPQQgsbPCivD
 TaBfOrhi12eXc/eAkrdB7+zDHkglo025FQyRRg/K45Lkv6vSjqyB3b50831GibdL3wOl
 KdWWyr4Mil2cPcBSZ+GBB4rH2oJJV4w7BGlJB0E282glDdPZD3k0hCPySweAIhQr4i+J
 qOqA==
X-Forwarded-Encrypted: i=1;
 AKwUvByMZVOTs4KBJAkDNT21YikTcPjl/Qu81QfYUzm598ya11e2Ur/iWfBjTXJ1IroHF2AXJ8pB/Ny8JrQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++myTl4JmiYV/6+E6j5gRi341ol+WDMKrXhtpoZ1VOHC0sLZU4q/
 0P4dv+Fv6LYWE1tPZG+tXms8uFmTHO0KjLaGb/4cr4g8ag3NIdTlAP2S599GoJ/MHyBvQ0hNTuv
 8W8J3YDrk1ZPiNm8Nl4Jv0yQ2Ws0rIyRtaT78eMX6Gh1BZaUOqV3XReZ85CC6dXv/lALxvUS4aT
 VmsOU=
X-Gm-Gg: AYBFou17VqstsiLwXL8u+T7QaYb+nO3Wzsar0VTkViq3NuJutQPF3sAaZtaVp1WxzQC
 i9iRT23ai5P3Uax1H1PXzdGCh2dNkwTOPJvpHEK+/fnkjBp5NXIPduxMdBDuweH0zWycuqjrLIV
 aN+KSowhp8NN9xxs9fRVpEDFyd6zXznj1qUggiLMhjxjoAyxfDSckbFxUTub2CVuLy3nDI5v52H
 9BBWbAlOOaXqSPmq+zeTrH2GypSBMli31OGSV+FAYl5YbywC0woiaJbmatOoD275LRr4VSRr8cR
 7HlehgmnciBa5yUgAnfrado7QTKsfO0lFIbw++ZiS8cZMFUdsfTkxmJBLkZIG0zMKTcYSe7dWzV
 gvPlk2YL6tpF+tNkc0+4K1R3KD/2n0V9KUQ==
X-Received: by 2002:a05:6a00:9296:b0:87d:d878:5eb1 with SMTP id
 d2e1a72fcca58-8874d29ffc1mr3623342b3a.56.1790852537092; 
 Thu, 01 Oct 2026 04:02:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:9296:b0:87d:d878:5eb1 with SMTP id
 d2e1a72fcca58-8874d29ffc1mr3623306b3a.56.1790852536584; 
 Thu, 01 Oct 2026 04:02:16 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-888197ced69sm886049b3a.48.2026.10.01.04.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 04:02:16 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 16:31:26 +0530
Subject: [PATCH 2/2] misc: fastrpc: fix init ordering race in rpmsg probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-fastrpc-probe-fixes-v1-2-1376d93b8b3e@oss.qualcomm.com>
References: <20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com>
In-Reply-To: <20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852523; l=5052;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=AAlmuP7Zbq46cR3jlCBUJN55F+/3OqGdgksKttWnW20=;
 b=lozHwIEDFFZck/CjJ7xyGQT6NncRY+b1WMRhFBpg9GI4ZSkRrs/aczQl/1+vo98+1u6oLCcY5
 G4dthWGsZ/QDCo9iLfyFsL+g4P3OmoiERG8ZvCWEalWZA5h9dsblH4T
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX4vMxj3SxDb0E
 OyhULJZX6YvNC7FD/IfulF4GV1CQe3+lUOAkvYNaKxyRK9aSIxJdX8qCK+kkC6UN4FxgKlYGeRT
 L2kfuw8NdbgcszZ9nJaDQrSb/YyNKrQ=
X-Proofpoint-GUID: 31F8PbImU85ihyPKkRWl0Zp3Km6EYZFV
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe3dba cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KWbisqpt0Nw2-B9i3BEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 31F8PbImU85ihyPKkRWl0Zp3Km6EYZFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX2zBpGKEqmec3
 VKt5Vo+Zi05D02BrEnQ7SdCER7LSCx2BkkwQS6nvSLIj+BW5WNJ6qanb3CaoVi+mZe492AoeQnZ
 bR/Vwj61nT73qKscYm9wxWWTrMZsBPkih1nU4M/2yKCGnHDjtKd7BgbUQXOnUIlFCrGqps++21z
 ZhznAX3aFMZO18YMZGfdEWynEqe2jUnb8SKHUMWaAuaEif3TpELl1QJR/YS/Vj2tAOBlYJaeMlV
 h5h43k+TNZotRu5LZBKX7sssjp+ksNzo5eiI4OzHpXw1CRfeYC5E47kl5D+BykKbFdtxlNzROse
 GwiMejyNlqG88YTms77nYmGTVQ3YDylYn6z/DXN0Ppju+BAlD74E39mCTXkFdt+y8DBM83Uvr21
 jR4ZBOkrJ2529qGTKfG4AU6rOtTsMZaCVRoR1/UD1r+q4NJWhoyI3ptTCHwmvJJQVgKk98zaw3F
 9VwB+ekrm9CgjholIyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010043
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

fastrpc_device_register() calls misc_register() which makes the device
node visible to userspace. However, kref_init(), spin_lock_init(),
INIT_LIST_HEAD(), dev_set_drvdata() and fastrpc_cb_devices_create()
were all called after the switch/misc_register block, leaving a window
where userspace can open the device and call fastrpc_device_open() on
a partially initialised channel context.

On a concurrent open(), fastrpc_channel_ctx_get() calls kref_get() on
a kzalloc-zeroed, never kref_init()'d refcount of 0, triggering:

  refcount_t: addition on 0; use-after-free.
  Call trace:
   refcount_warn_saturate+0x120/0x148 (P)
   fastrpc_device_open+0x204/0x258 [fastrpc]
   misc_open+0xd8/0x1a0

Additionally, fastrpc_cb_devices_create() not having run means
sesscount is still 0, so fastrpc_session_alloc() returns NULL and
fastrpc_device_open() hits the error path which calls
fastrpc_channel_ctx_put() on the already-bogus refcount. This
triggers the free callback, kfree()-ing the channel context. A
subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
freed spinlock:

  Unable to handle kernel paging request at virtual address ffffcd5841510ca0
  Internal error: Oops: 0000000096000047 [#1] SMP
  Call trace:
   queued_spin_lock_slowpath+0x414/0x5e0 (P)
   _raw_spin_lock_irqsave+0x74/0x90
   fastrpc_rpmsg_callback+0x4c/0xf0 [fastrpc]
   qcom_glink_native_rx+0x6c4/0xf10
   qcom_glink_smem_intr+0x1c/0x38 [qcom_glink_smem]
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

Fix by moving all channel context initialisation (kref_init,
spin_lock_init, INIT_LIST_HEAD, idr_init, dev_set_drvdata) and
fastrpc_cb_devices_create() before fastrpc_device_register(), ensuring
the struct is fully ready before the device node is visible to
userspace.

Add err_depopulate label in the error path since
fastrpc_cb_devices_create() now runs before misc_register(); a
fastrpc_device_register() failure must call fastrpc_cb_devices_destroy()
to clean up the compute-cb children before freeing data.

Fixes: 3abe3ab3cdab ("misc: fastrpc: add secure domain support")
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7ab1cbbf19bb..93d07d28a0f1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2614,6 +2614,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->poll_mode_supported = soc_data->poll_mode_supported ||
 		of_machine_get_match(fastrpc_poll_supported_machines);
 
+	kref_init(&data->refcount);
+	atomic_set(&data->ctx_seq, 0);
+
+	rdev->dma_mask = &data->dma_mask;
+	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
+	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
+	spin_lock_init(&data->lock);
+	idr_init(&data->ctx_idr);
+	data->domain_id = domain_id;
+	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
+
+	err = fastrpc_cb_devices_create(rpdev);
+	if (err)
+		goto err_free_data;
+
 	switch (domain_id) {
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
@@ -2622,7 +2639,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
@@ -2630,7 +2647,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 
 		err = fastrpc_device_register(rdev, data, false, domain);
 		if (err)
@@ -2638,26 +2655,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		break;
 	default:
 		err = -EINVAL;
-		goto err_free_data;
+		goto err_depopulate;
 	}
 
-	kref_init(&data->refcount);
-	atomic_set(&data->ctx_seq, 0);
-
-	rdev->dma_mask = &data->dma_mask;
-	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
-	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
-	spin_lock_init(&data->lock);
-	idr_init(&data->ctx_idr);
-	data->domain_id = domain_id;
-	data->rpdev = rpdev;
-	dev_set_drvdata(&rpdev->dev, data);
-
-	err = fastrpc_cb_devices_create(rpdev);
-	if (err)
-		goto err_deregister_fdev;
-
 	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
 		struct fastrpc_session_ctx *last_sess;
 		struct fastrpc_session_ctx *dup_sess;
@@ -2682,6 +2682,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (data->secure_fdevice)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
+err_depopulate:
+	fastrpc_cb_devices_destroy(rpdev);
+
 err_free_data:
 	kfree(data);
 	return err;

-- 
2.34.1

