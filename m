Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADA2CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D65C10E555;
	Wed,  7 Oct 2026 08:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPtTSZib";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7tppqmi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2E210E555
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:45:09 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977kN3N3812847
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 08:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=22/EzgF3eNH
 k3tF3ZBt8AlBMV+Qj6qZL9Uo0C5iD4e0=; b=pPtTSZibPL4np4OcArWt5IJ5USQ
 OtGrAURpfc6cVrcHCBbWznYzpat0zVft44H7L3obzge5yDPoGBdvWOuXOKUHKr5Z
 e11AlAf0RwNmwPLJXc0DUTT9eiB5PD9DXAjSr7/09s6iJGjM6SHL+TnQ2ohkyQjK
 7Ms1l/RrjHp6DaY0Cd7iZXXEPbKtsk5I7elcObHMYwLHvOKDHCrtzhhqK9KsfAqU
 kZAgEeYf3irLEAiYkJ5xS2Bqt1LS0oxMW8G/PUcqxi6S+7EcGJeNQsPFzPalGVJp
 ZvcbIyl9phP5wzbrwrU3JXhIxAhkVKlpP3N8WnA8LrhzpkeZE21J2gCPCcg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvrre59-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:45:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so445784a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791362707; x=1791967507;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=22/EzgF3eNHk3tF3ZBt8AlBMV+Qj6qZL9Uo0C5iD4e0=;
 b=D7tppqmi5yVIdFTlBQwAeESg8oMbspnBGKpvPFvsF+J8FBIYqdO+4PbCbOgH/VF+LK
 dUd7AStRoDV6g8egWSw+xVQDowqrr9K01LWBTh8XNaSKeqvj23z4tXphMklkeym2Z6ps
 NFxU0genlnc5pz4cWvVvB+VKd/z27uLb0eKYEtS1Aa7DM8BlZMEW2oOoTC1MBKj4o704
 n7789MQK24Xkr1EB1uBqqrfBSahg1zAqcsu7D9jm5lGxz+xXS4wKFZoa+qOamk5KX0+6
 tCqPcJ1vy1Nt0ThLWzI57VSCxcSmUctuj4ZpmLVg0EqL3UQpvhcYN4lUgZMl2tIzuTPw
 DAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791362707; x=1791967507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=22/EzgF3eNHk3tF3ZBt8AlBMV+Qj6qZL9Uo0C5iD4e0=;
 b=QEdF0ZWkaz/Mk8T9fXlw1tMHiLkITVbKkFQ6IsEPwfmqX2SNBe4fMx7kRMViuMCfhi
 oUFQGcNPhvzQy7plfPOx4TdZq/323jYskaGcaivzz937WkcznMptz+g27gYWRwhTsT+l
 +QY6Y3JEonTr+jFwS822y/07zWOVqyqB3QrpF4mwllTgcZIYUWbOuU/w3e9rodqzxBVt
 UeYgbXi+r0wWYd7oWGdIphfU5v8Xr0YaLBlB+OyuFLuMlVceynKjdJ6Luab2A4rYmlF/
 HMdP+P5T2Cywndz2tjlBMvMrWWwmyYAC0X7+80O3luzLV6epRdDmgivG3sXqz46lSPgw
 gxhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUBdFiAY4n6tZg5pnyopgRXDYMh5BmjLZAGY2eSU1JnrxERFh4uaOUaRcdSjPzuK0vUbtyKPPUo7c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRIwFC5viGKY4evCeSkOzL5gCpVsmlklUpaZ13vUlN0V9tAXVJ
 VbJBWk82MixQLYk0uV/fTYdzCI7a2dLeERdN5LLpmWa9QPLypFnkxol76ERMxAj7OD2CdOq1wYV
 Geo0XStGX1nBk3ggvCX8sAQDx2NhCcXQk8t1QRpxSw0V1r4aKaKTag2da1lJj9itPaCrYb5kOSe
 YrUG4=
X-Gm-Gg: AYBFou0YjN/sl31P9SkoA5KhQivu/hKxgdSAQDjae68izZePUjbjE9HxgXh+JxYFK5l
 IJDz1Boan+jRqHo1/ctR0jINCerjCfovGYhUR7qIUxpz2pRh+UWW7fbfAbqto5BzASsdhgwBaFd
 tu+y3jnWLVxPfUOz7bAdaY/yQTk+dXdmmO1p6zvC2IunJ/UcnXFnrzrl0jpSPrxljuCatFUFjtj
 5gdZcmmqTTQ/lKjkZQeqUtEPXbX+9Uo23F3k2FyFbeXx3FpMs30CvE/2mjQ1N30n9cF2DosGcGX
 YqXvtAsfiJVih6gftzUhFR4lN5kq7qXatkQGhjmGwT6buD37u4FoYKpLIbZkRkj2tm87c+VHZV5
 siQ8rh5E6FUdWjKNFvVEDUZg9XiVRMbv3LZt1daRx7qe6vyx9EP1I8eOnhbzCk9+Z1ZUkeMg=
X-Received: by 2002:a05:6a21:6b0f:b0:3da:5eda:d167 with SMTP id
 adf61e73a8af0-3e133db9c3bmr1118660637.5.1791362707350; 
 Wed, 07 Oct 2026 01:45:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b0f:b0:3da:5eda:d167 with SMTP id
 adf61e73a8af0-3e133db9c3bmr1118640637.5.1791362706877; 
 Wed, 07 Oct 2026 01:45:06 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a8b0616esm1075091a12.6.2026.10.07.01.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 01:45:06 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: [PATCH v1 3/3] misc: fastrpc: drain in-flight invokes before tearing
 down context banks
Date: Wed,  7 Oct 2026 16:44:47 +0800
Message-Id: <20261007084447.922-4-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac60694 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=XraR69nYKyiK7xGMLcsA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Z7b-dNPP-IlRdtHn1L3_fZyjVM7Auery
X-Proofpoint-GUID: Z7b-dNPP-IlRdtHn1L3_fZyjVM7Auery
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX7dixTwXFsTGv
 sZJKubur8whi9ujfmHgMGrM2GdLkGep/riJdrhi0Yx1qH9Hc8cdzbhWbeWyeSnMuCdVJsA8tc26
 HA/6Z4b6TmrWwcynHTKVJaU3j4y4PdIJA0SbGrHqMKedF23XrvuiFVOZqqhgsze1duawnNXvcun
 DQptyO5ry2vCDf9KhgJVy5002nvPmQ3umd/xyqeuIJLoWoOdLFnRx8IZY14KI0O/21okb3K87zp
 Cp+qMzCQX0paWzSnpteskC96tXZE6+xmVu1oSmIewYeIKrADgl7yOyHwHeIRNI2b8ITK6N+bJ0m
 oSL/qfoTEPREe4SJIRfF0f+VKlO8GdcHC85V2l+BHShDPe3fwctn7gwdBPOetg2f7iJqSigDX8d
 0zDcMTFrgKhp0kYvcVJhD96G2zsmco+u3QHNDqPZL/5VGiApEqQG27AfOuIw+BuYtk2vogXkCin
 sRW89IfsBVRwolpwE4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX+Ujo+wayeN2f
 iQZGlo6IyiX+09wV2U2xSZ/BmdHi+juWny2XRGr6MJjCUKPVcu4+ntj/P98LOQGiDF5rBqGDvsf
 AKvuCzS8ee5WaTU6Yek+xusOUGigesU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070034
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

fastrpc_rpmsg_remove() clears cctx->rpdev, wakes every pending invoke
with -EPIPE through fastrpc_notify_users(), and then goes straight on to
of_platform_depopulate() the context bank devices, with nothing
synchronising the two:

 - The only thing stopping new work is the unlocked rpdev check at the
   top of fastrpc_internal_invoke(). A thread can observe a valid rpdev,
   get preempted, and resume in the middle of the teardown.

 - Invokes that were already admitted are woken and head for the bail:
   label, where fastrpc_context_put() releases ctx->buf through
   dma_free_coherent(). If the depopulate wins, the call runs against an
   unbound context bank and falls through to dma_direct_free(), which
   treats the IOVA as a physical address.

Close both windows under cctx->lock:

 - Add cctx->teardown, set at the start of fastrpc_rpmsg_remove().
   fastrpc_internal_invoke() checks it and, in the same critical
   section, increments cctx->invoke_cnt, so an invoke is either rejected
   or counted. The count is dropped on every return path.

 - fastrpc_rpmsg_remove() waits for invoke_cnt to reach zero before
   clearing rpdev and before touching any other channel resource.

The gate lives in fastrpc_internal_invoke() rather than in the ioctl
dispatcher so that it also covers fastrpc_device_release() ->
fastrpc_release_current_dsp_process(), which sends INIT_RELEASE outside
of any ioctl.

Teardown is kept separate from rpdev because the two have different
lifetimes: the gate must close immediately, whereas rpdev has to stay
valid until the admitted invokes have finished rpmsg_send(). Clearing
rpdev up front, as the code does today, lets an invoke that was sleeping
in an allocation dereference a NULL rpdev:

  Unable to handle kernel NULL pointer dereference at virtual address
0000000000000358
  CPU: 2 UID: 0 PID: 2003 Comm: adsprpcd
  pc : fastrpc_internal_invoke+0xb40/0x1398 [fastrpc]
  Call trace:
    fastrpc_internal_invoke [fastrpc]
    fastrpc_device_release [fastrpc]
    __fput
    __arm64_sys_close

The faulting address is the offset of ept within struct rpmsg_device,
i.e. the cctx->rpdev->ept dereference in rpmsg_send().

Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 60 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c54c450cb571..3036925632d0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -328,6 +328,15 @@ struct fastrpc_channel_ctx {
 	atomic_t ctx_seq;
 	u64 dma_mask;
 	const struct fastrpc_soc_data *soc_data;
+	/*
+	 * Set once fastrpc_rpmsg_remove() starts tearing the channel down.
+	 * Checked under @lock so that no new invoke can begin afterwards.
+	 */
+	atomic_t teardown;
+	/* Number of in-flight invokes; guarded by @lock */
+	int invoke_cnt;
+	/* Woken whenever @invoke_cnt drops to zero */
+	wait_queue_head_t ssr_wait_queue;
 };
 
 struct fastrpc_device {
@@ -1350,12 +1359,23 @@ static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
 	return fastrpc_wait_for_response(ctx, kernel);
 }
 
+/* Caller must hold cctx->lock */
+static void fastrpc_channel_update_invoke_cnt(struct fastrpc_channel_ctx *cctx,
+					      bool enter)
+{
+	if (enter)
+		cctx->invoke_cnt++;
+	else if (--cctx->invoke_cnt == 0)
+		wake_up(&cctx->ssr_wait_queue);
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   u32 handle, u32 sc,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
 	struct fastrpc_buf *buf, *b;
+	unsigned long flags;
 
 	int err = 0;
 
@@ -1365,14 +1385,25 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (!fl->cctx->rpdev)
 		return -EPIPE;
 
+	spin_lock_irqsave(&fl->cctx->lock, flags);
+	if (atomic_read(&fl->cctx->teardown)) {
+		spin_unlock_irqrestore(&fl->cctx->lock, flags);
+		return -EPIPE;
+	}
+	fastrpc_channel_update_invoke_cnt(fl->cctx, true);
+	spin_unlock_irqrestore(&fl->cctx->lock, flags);
+
 	if (handle == FASTRPC_INIT_HANDLE && !kernel) {
 		dev_warn_ratelimited(fl->sctx->dev, "user app trying to send a kernel RPC message (%d)\n",  handle);
-		return -EPERM;
+		err = -EPERM;
+		goto out;
 	}
 
 	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+	if (IS_ERR(ctx)) {
+		err = PTR_ERR(ctx);
+		goto out;
+	}
 
 	err = fastrpc_get_args(kernel, ctx);
 	if (err)
@@ -1428,6 +1459,10 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
+out:
+	spin_lock_irqsave(&fl->cctx->lock, flags);
+	fastrpc_channel_update_invoke_cnt(fl->cctx, false);
+	spin_unlock_irqrestore(&fl->cctx->lock, flags);
 
 	return err;
 }
@@ -2635,6 +2670,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
+	atomic_set(&data->teardown, 0);
+	data->invoke_cnt = 0;
+	init_waitqueue_head(&data->ssr_wait_queue);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
 	dev_set_drvdata(&rpdev->dev, data);
@@ -2678,11 +2716,25 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
-	cctx->rpdev = NULL;
+	atomic_set(&cctx->teardown, 1);
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
+	/*
+	 * Wait for every invoke that was already past the gate to finish.
+	 * They have all just been woken with -EPIPE, and no new one can be
+	 * counted, so this is guaranteed to make progress.
+	 */
+	spin_lock_irqsave(&cctx->lock, flags);
+	while (cctx->invoke_cnt > 0) {
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		wait_event(cctx->ssr_wait_queue, cctx->invoke_cnt == 0);
+		spin_lock_irqsave(&cctx->lock, flags);
+	}
+	cctx->rpdev = NULL;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
 	if (cctx->fdevice)
 		misc_deregister(&cctx->fdevice->miscdev);
 
-- 
2.43.0

