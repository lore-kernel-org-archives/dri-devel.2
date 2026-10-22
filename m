Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091960A2611
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3ErXA3N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aTxLKsmI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B262112441;
	Thu, 22 Oct 2026 09:09:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190D1112422
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M6xrFg2171944
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HjfWDRPzYl5PNTaWP9ttZL/Fu+3IQzVkWXRGbtuepsA=; b=b3ErXA3NK6BbgHoJ
 Xrfe5LF1YuKsQFI+mcFcBuqsTWz/ou9wj9dooSaVafC7BpmvW4I9DFPa9Uw3a9f4
 JxVWJvH9ss44Y5Zemv7KvroirpVXgx/eZ51LbiETmz/ejYQ7pX1GCyj4xikIw32k
 32s1r3XTUO+D0CR5iJK3jrJAYb/hxdPAMsOA1eYTZfS6juehv0NIySdmJwy4fudR
 I1SSRqc+TWc4TnOHwKkFm2IZAZ5Zl+ydlo4k8N5m6KvD5E8JVoQb2oJJMit7pSYA
 iGqXY13Py0+iZgzEQD2wKJ0LjhugBOmwKK6L/mUlqAVSShJHduUVqZJ1cRarOG3M
 KxFuhw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahm09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:09:38 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-151ba226e1bso2936416c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792660178; x=1793264978;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HjfWDRPzYl5PNTaWP9ttZL/Fu+3IQzVkWXRGbtuepsA=;
 b=aTxLKsmIUkK2evZBFcNc8ZflXc2b4ZPcZB9pJEGDqVehGqr5ZeFMwftlWFq3M8V7Mr
 gxlq0xC8iWqJljMRjGZMAUAqTgi6TLAATMLncAjHNhUGWCI6HJBXbGQTl4VNonGaR1+n
 Awpmp6ZmHAjPllK79DitpN1H0HAfOyBW+021zTwN0DPJaqrqikt2iTjZYy97xvps/j1m
 nXuySsDNc4X6rnUBtnJLu3SYchsY9JkuPgqnMfpnwm7P7BEVkSk3qvvyqqiAEwBsfihG
 lESXqBJfRtbyZQE/0hptJBQoH9OF5VW/uoag8V7ceSzPiCcFeH/MMAAaIhDtJWRtpvm0
 H01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660178; x=1793264978;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HjfWDRPzYl5PNTaWP9ttZL/Fu+3IQzVkWXRGbtuepsA=;
 b=BStHw0Za3r7i7MLLG5pjRvkjqVs8mjLyh+ZW7JSp/t+T3sxcKFTAcFNKPL6+0RL7f6
 SqTLC68cX7bGDln9Lr7gIp+ndp8/0wr666hHOX3DudL2QvRrcG4enyV2Wl/q+1q+zbFl
 jugC+kLbCDFux1GmPdTwURWPJzkXgfVU8Ul3dYEriz8DKOF1gJH5P5KSqaDdnY5f7hcj
 tSlYCfOPRpGvnNGDbN1ir3dvb+mEzbQCXsK2guLmXQmBcpKijG8DZH7bwmKdiKaVWR67
 36dCECKw4J7mBApXhtpEs0EK+fl76qtSYzrrx6EM1DVUsws0wZOLse0ILFuG7+tkeH9n
 EGhg==
X-Forwarded-Encrypted: i=1;
 AKwUvByLPv9d+QgQjqMTE4q7fGjzm0kicfBrVue09vpqSDEaIp67vFBVGbjJRmAwyQhQkmpNkhpqWZeMInY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLH/2uaZOt7/+KigJ3Kz35ptPcREAZ1xEbk50hUdF2akiahXiWV
 3SpHUzf+NNPuE4qKuXJTiDC9/F4FrOGsyVD1OdrmqSK/F5dtVez5gkck5hKfCzEPxIXRDrzoBvc
 gpguEKosC5ihs40lzj++Kb0gQuNRtsjTmvJklHPVLZpSrUnQoc1FMvh+RPfCdqebaDERJ9BcCLo
 P2UUA=
X-Gm-Gg: AYBFou0S6RCWFQA8w+C+1JzkBE2pk88qBHUikqvxVHzsoH32PG5EuWYHUNnVHw6jlAD
 1K0H6C073s69zefDOHtemzsY8lCpmfQMg8OPRxIJ7b+i5qGoJPYMji60H3dFJZWae/AVunmRrap
 y8st+5MY7K2eSWvWNJhUSDvNgYEVxrfjSaZnbT7dVB14PShcMRL/GnqkVEHWKtO7MSNOltsFtku
 Vc7KhVXphMuFsJijaEcuddRANYPlrLv+HZ/IB6QpGdhL3g943YXUMTLUUS+kTlNRAXGNksSHiE+
 2Qi09LoHU8nZ/Ew68+ABXA036MINFIXYJeVX43ppZ7syoiAXmhufp6I2IZdMa1QvYwtoHqQ4vMz
 MdrYnYBwGoVnuXKYCxijQ/+HtAXppwLdA
X-Received: by 2002:a05:7022:691:b0:149:d501:b990 with SMTP id
 a92af1059eb24-190a599a59fmr8274762c88.25.1792660177701; 
 Thu, 22 Oct 2026 02:09:37 -0700 (PDT)
X-Received: by 2002:a05:7022:691:b0:149:d501:b990 with SMTP id
 a92af1059eb24-190a599a59fmr8274735c88.25.1792660177165; 
 Thu, 22 Oct 2026 02:09:37 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a180b9esm20475694c88.4.2026.10.22.02.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:09:36 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:38:48 +0530
Subject: [PATCH v2 2/2] misc: fastrpc: fix init ordering race in rpmsg
 probe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-fastrpc-probe-fixes-v2-2-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660163; l=7445;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=zUgEbnWLsDTknLyFxpzFJGnr20DIE7GXMRNqYKnIzjk=;
 b=rmpt0ZUKSJ5j1Ux8PcHksq0tkZILGFGnayKQum0+doGDcNPo84jXam4cm0VCiRZunLLFhVusl
 zEbfz+cg7LjDJUs7v9wtC9r9xYt6P8EdcjFRNLoXFHUlcz49rC15cb0
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: g3ZSAtYbtw5LCZ_La06wMl0YdgVVVKL6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX58sFC3kN1EM+
 Vae4cKabtLPLQ/rlVrey5bxeGIp7uDS6H3svSxrx1KnAIflh/8QYVAvHZENwzqbU6zmLsNM+1JO
 YF+hZVcrEl5mAvFcBOZOooZSiJb7zCc=
X-Proofpoint-ORIG-GUID: g3ZSAtYbtw5LCZ_La06wMl0YdgVVVKL6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfXyz3DV33PoYsG
 JZyhXlD2CT3oOqBKRhdCeLThNi6SfaTZQHintBvvLpBXKWbddcdLRLWKjP07A54nqY8Ohgvyhme
 4ZveGfHmL/HfowTHN9f9W3GikXLgBiZl/uUHmkN25blkAZLQMdiAasRTdz/2AnhDDgavKEy46IO
 MkUXpYTQx4GWW1lgZNs1wQmQgjG3NUCT9HWfnrkMCPnhDc3Si6x7no1s0jSBegxnVfo6hitJOt6
 6KrXTna8S0SPYt3FXsdX3GuXGBNfG5svSp5yTCVkFPORfsKAW3q6mhHo8YdyBTz/va2e86GWUQq
 jHaZVcWe9L/h5HDbQTHTgMhY+Kgt5XbJlj1lklrxuA+3bER29GaJxkcnV73kI9tVUyalozSy+d3
 lyr49BJeR1czFYZegab42EU9BFpWWriM3PiDHSRiCm3o53k6+3NBP85Dj3AcPUPTetKVyGgJ5jm
 dzS03vMLFZ1r/wWh5zg==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ad9d2d2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RafEaDNIwz_KoXd2q0MA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220036
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
to clean up the compute-cb children.

On CDSP/GDSP the secure node is registered before the non-secure one, so
an application may already have opened the first node and hold a channel
context reference when the second registration fails. Freeing the
context with kfree() there would leave that user with a dangling
pointer. Handle it like fastrpc_rpmsg_remove(): after the nodes are
deregistered, clear rpdev, wake pending invocations with -EPIPE and drop
only the probe reference with fastrpc_channel_ctx_put(), so the last
holder frees the context. Move fastrpc_notify_users() above probe so it
can be used there.

Fixes: 3abe3ab3cdab ("misc: fastrpc: add secure domain support")
Cc: stable@vger.kernel.org
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 83 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f280bff2edf0..fc09cd27af4b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2548,6 +2548,18 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 				  cctx->vmperms, cctx->vmcount);
 }
 
+static void fastrpc_notify_users(struct fastrpc_user *user)
+{
+	struct fastrpc_invoke_ctx *ctx;
+
+	spin_lock(&user->lock);
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+	}
+	spin_unlock(&user->lock);
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2557,6 +2569,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	bool secure_dsp;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
 	const struct fastrpc_soc_data *soc_data;
+	struct fastrpc_user *user;
+	unsigned long flags;
 
 	soc_data = device_get_match_data(rdev);
 
@@ -2605,6 +2619,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
@@ -2613,7 +2644,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
@@ -2621,7 +2652,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
 		if (err)
-			goto err_free_data;
+			goto err_depopulate;
 
 		err = fastrpc_device_register(rdev, data, false, domain);
 		if (err)
@@ -2629,30 +2660,12 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
-		unsigned long flags;
 
 		spin_lock_irqsave(&data->lock, flags);
 		last_sess = &data->session[data->sesscount - 1];
@@ -2673,23 +2686,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (data->secure_fdevice)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
+err_depopulate:
+	/*
+	 * A registered device node may already have been opened, so a user
+	 * can hold a cctx reference. Drop only our reference instead of
+	 * freeing the context directly.
+	 */
+	spin_lock_irqsave(&data->lock, flags);
+	data->rpdev = NULL;
+	list_for_each_entry(user, &data->users, user)
+		fastrpc_notify_users(user);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	fastrpc_cb_devices_destroy(rpdev);
+	fastrpc_channel_ctx_put(data);
+	return err;
+
 err_free_data:
 	kfree(data);
 	return err;
 }
 
-static void fastrpc_notify_users(struct fastrpc_user *user)
-{
-	struct fastrpc_invoke_ctx *ctx;
-
-	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node) {
-		ctx->retval = -EPIPE;
-		complete(&ctx->work);
-	}
-	spin_unlock(&user->lock);
-}
-
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);

-- 
2.34.1

