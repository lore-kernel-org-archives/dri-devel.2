Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D9606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pvsjUTz2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SEjIyLE7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC84510E36A;
	Thu, 22 Oct 2026 02:36:12 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D0510E145
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:49 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M1iJIs3411902
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NX7bsqG292S
 tQteEaBo56Z6RlMknr2B+M80QoiufMRA=; b=pvsjUTz2cj0zDLqbE07MDsCoQc1
 HDTaFprqfAcxjqajgEAHVmv2DtWJ70C0AaIPyo8F05NAAk4v07Jjg2znmQLlD3xI
 bmCF+q9m+QwkZvKJVvcUFFOLnesfG7Qe2zooD1crUkmuCU/K09vBYhR+DGp+I/RW
 ixFNWDhDnhFa8qqdMBp93nxCAg2eO2Fh7eJIt70ENEIXcwynktnUjCzr5zuMlmN3
 JmSLRrzE1UhPw+tQ1NRRygPSue0nxZtiANx+5ZVoxbmQ4YqKQ6bH4bSMibApKFpu
 i9uqhnRAVbLQj8ydfkYZwJGT3Z3TsYcrcL5iYj/RPup/jyqZhvSgpg+zR5Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93agb3t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:35:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2df8d1e91c9so20701915ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 19:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792636548; x=1793241348;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NX7bsqG292StQteEaBo56Z6RlMknr2B+M80QoiufMRA=;
 b=SEjIyLE75isqiHytGpJ01BigKOOZ7BvXKMICMhwwKhNR7JoWyYS6MpPVGbVViG9B/L
 eRvY+KcGEsoAYhE+fOOglT9AjsRFx4GMZNXUwr+J5HL1fTD//RNhipyfTn++v6WJda83
 RLwGcqAaZ/JkwRddmupGJN73VSp3Gmgu3HouqPBGUKHsCf69JVAdjRbaIkhzfAqUDyC4
 t8CSPFFO+FD/HSADtsnqGCVHtBGNQO7KeCtY3+mKeiOk7RvPjvlZZv3SWM6kaAqF72rA
 N00I98rcNg0MKOM+yS8AuHf1h6B3Ojxw0xkjHWi+lWkbh6Mm77+EAqk44EdLTAtfsFQd
 eLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792636548; x=1793241348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NX7bsqG292StQteEaBo56Z6RlMknr2B+M80QoiufMRA=;
 b=v4mOESDy3zdmjP8pGOOR/V61BN+ojzyPLwHF3q5dWxbnODq3Vbjmt+nCXUWBJclk9e
 VcOqP1lld6v8H1W3SfuTi0hUUWaDW2kh5OQ0JbZtcmys7IBkoU3zO0pLC6BbbViQZkyH
 K40bAkjJ/Jpldg0PdSsV43Z1JeeQE/vd9uJ2zMICX3ioKA9YOFJsEukEPIzffonW6Ol6
 vHyM+eAeLYQgZQaOT4OucJOucd0FyDVsez2xGikPKz/5eNKEAACftyc39z6o9oRX5L6x
 mmKOIiab2S5UJo2/keubFSYEFxgZxjmFOrlwgYTL4KsZ1+wnINHwxVRzmMrrwE4lDNPx
 S5AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwo6S+/mJsk/MdoJy2f7uIIMc2wZEeOsh+VDbw/SUUFzOf4i4SSyprZXOFWjQDCQ341QWb95uFNKxs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJM396KoJzXK0rre5TY9ifDae5aPThoMqDHZwsJjmzFMnTqHsoM
 qk3CFrCJuxCOdwh+c0v0gukP+QBVx4zmIudnibFystQ00hw2K2TD26HnFSH6abb40T7PpSLWKh4
 XFpNR5MaJMYkvRlRRQBje+QHlvM5zES5/7ihIocpLelBgNKyWEq/cxWXUbpimJImVY0j+jZw=
X-Gm-Gg: AYBFou3FcFzwCPKR9G554bCVUeFdyUlvYtAp27k1RXZETdFWkmEIub74xxn/rbkNX17
 fxnpMXXULIDw/zh4Ziu8c5mw/fKzKszUfVVegEBOVX7YFsIhouA2ojZBKQ6MsO/1RK6wrv9YjwW
 eiw+bexMYtz41lFVAyXj0vZ2LhRazLR6aR7yZ+68EpVahtnA3OpbeN701GiBZHZq5ZtiSrE365l
 qbACm/0g75JMK2cV4bJbXmQupcYmXjw40LtgPuOxIBkDMCOyfby5eOPcme+K0FYSKHc20wjS0PI
 YEHkNtLxJaX1TigGkSvgj+INeBO+tvg9EPCq1/TTADlI+G/nQ8uxArwWDuHELBPKtYIMnQSxiHF
 gsuIPpAqSIUk6fhiKLmolRQiMaFV2groOzgrABbo4uJGiLREZuHjfSYSIL+wJlhAjAs9HfQeg
X-Received: by 2002:a17:90b:37cf:b0:3ab:2d46:1dd6 with SMTP id
 98e67ed59e1d1-3ad86dddc3bmr3988931a91.4.1792636548134; 
 Wed, 21 Oct 2026 19:35:48 -0700 (PDT)
X-Received: by 2002:a17:90b:37cf:b0:3ab:2d46:1dd6 with SMTP id
 98e67ed59e1d1-3ad86dddc3bmr3988903a91.4.1792636547619; 
 Wed, 21 Oct 2026 19:35:47 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada488550esm1959935a91.3.2026.10.21.19.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 19:35:47 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: [PATCH v2 2/2] misc: fastrpc: drain in-flight invokes before tearing
 down context banks
Date: Thu, 22 Oct 2026 10:35:31 +0800
Message-Id: <20261022023531.465-3-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022023531.465-1-jianping.li@oss.qualcomm.com>
References: <20261022023531.465-1-jianping.li@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxMCBTYWx0ZWRfX9PDW+Dp51iur
 H9SR5c8Z0ndBy3A3b4fVT5CkcI/gVfFbj9PV1kurhWrlyfGys8EHYb7kdKW6ZHPehSC/OxXdbIB
 5O1fFbB9aGBkUHRZfE8bVbWm96Rw9OI7vOViaxjtw5G4TlK7vu+sKZ/2YCSiviYxcht5+OaQFtG
 uWVtjF5XMIETomhEotNYi7NX5Q5Gu5i0MORccJrJ+kP/7Sjs9zHyxKfMPmRTAEBjF8zv6asp+ys
 D39r74GahVH/CF7TK+uTRbeYjoHPQF+fMBPZ2y5FD1ZXrC1os/uWl1rTBhR46v8BVmKxM+8DM39
 MLwC+ii/zlKVtgZIhtxQnu8kmUZPbK3cfrAZKsNj6osRhRrCCF3UMec0GKJR0eukOzNHTlvkkwb
 s8mNB33ifKnxfGyM94vcQDXjF/a6ALDHGdB/ax4ddLJuhMhcWMiSBHgsvElNJA5mRHTO1roDxUD
 +6MPVELu4HD5Cvbjzzw==
X-Authority-Analysis: v=2.4 cv=H7FOUOYi c=1 sm=1 tr=0 ts=6ad97684 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=XraR69nYKyiK7xGMLcsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: frsmbl1kpYPg7_B6mOYdt_8I3RchU-NL
X-Proofpoint-GUID: frsmbl1kpYPg7_B6mOYdt_8I3RchU-NL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxMCBTYWx0ZWRfX4QkdNTtgCvP7
 5qrhgamEohjlWDuiCrqohI44hE4XgyTOuh5fEPNJbFo0Kb4LkM9aUNrsDf0OdoIefsnh26v/mcS
 sib2TDIa0VsKoUpIEQaYTKmiSJ9X8W0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220010
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
index d201f26d8e46..cffe96a181a2 100644
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

