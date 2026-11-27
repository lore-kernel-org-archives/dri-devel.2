Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCE606A6AA
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g5mFKS9m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bXQ1hlFY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F3A11295E;
	Fri, 27 Nov 2026 09:58:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8088911294E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7GOw41779896
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l+VhiN+deug8QDQvih0hq9pn10Dm6PA95l8MXPAcaIY=; b=g5mFKS9mn+Ktd00u
 AwG7+ZUqenSUpa0QbIP+XEO1PMXB8JXDmYAESjsmniDMM3xlw5DFMJ0fKgOJ9sFL
 BILRV3ZM+nFepvoQ8KuAEALD9iZLSFgGTuy1rKpg8nmiP7Xg99UOepYDCjSJJLuN
 wmc1xTlL3de55PsJYWS8w8OWaxSsr+tqJu8NTsw/2vdw+OyPIZtXjjxikeKzK1DN
 p5SlJRJMQiJs/wPZ1KNg+u/PA+0O1TXvQ78cJD/cxskVS+3Qh4rs5EfH6e6f3ELB
 UM13q4U0fHbjnioAUhc64PSs6uRmU0HYjpF/ZnXMCQST9jl6CDHlWdzcW+nFX5wp
 1rMQIA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhh1jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2f0651873abso57689455ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795773407; x=1796378207;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l+VhiN+deug8QDQvih0hq9pn10Dm6PA95l8MXPAcaIY=;
 b=bXQ1hlFYftXgfOw81cAo76ar2+6j9dCVnlKkhQpmex6kfl7DR/dwBERNB6n3C9wysB
 E4JJ/VOWJ3Zv/rguy3bWvVhUF9X2Amw7US5C/Rwih5BL15TsbyZOwta95uHnULVG9P+N
 QgexOlErsvDhBG0O9LFDlhNF+JpaJZIEhM1giRMr9iTI115qEHFw5husYn0T881zEg21
 XGnEkEAF7H6REGUCSZUCeQtjYTCuaKZBG7M+bab/AfSWIF1fM9u+484vTd7DvU9bUNP5
 yI0asS+SKa+LoMjDw6UE+NEXmofjwH21yL9NIq0y3+nnwsjqNB0nowfA4JSPi8trdVmh
 kvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773407; x=1796378207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l+VhiN+deug8QDQvih0hq9pn10Dm6PA95l8MXPAcaIY=;
 b=c+AT1I55ollwy8VMniMLrHlYQ900ayRj5fJ/X7FAsLjgRhQ15BEcXhGiHEUCZoSKxH
 5UuYPFnWRXea5ycQuWEcJ0JS9Z7b18o2eTx0e8+0WHJetH+EGF6Eb5ZZyiGyeBheC4T7
 s5LzhgYJ0V/AHrXaimvtT8fgLhlX1BhqNzb3kdrgY3BNPomEE1cCHLiHKlCeLFN+eclX
 IcotmLwZsChsG1UeHG1RatbozMKBVddYuhBonwzGCscz9VRTU4grleNsA7FLffFymlk/
 5xwnlrU/T/FYogR3yTlguKgTzPS/hhiDCeont3aZd7GO98TWCxHDCqoErN4CwNBNk/sC
 7U1A==
X-Forwarded-Encrypted: i=1;
 AL+hErGHAyvgoB1OKOfwmsk4Gsj27mu4P8oyou4ZlJSWys60FvKm8prAfa5KJTkxrOg9HwGO/Iye+5bXE9c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/grLAK8Vw5h8qSMhZM4Xy8cp+I5UMET4+41PiFgv1sfmLGO0Mh
 aPpHwSdrVum16KRXUVI7btQHBKUhFmmIYr18ouhLJFq17WQ+733A716y3tMmNDtWLNneZaq+OPC
 /w0MDq3GZigtGpiTrJHB3E319FeZrM9qToE6giCC6GC6ab+GCo7aOBFp+9an2OIshAxLIAio=
X-Gm-Gg: AZFdTZcubkneaAAN2n3uVydXEECvuQNVUkA5LW0Tqy4kj7Gvom1TND2dAXU3MxDdc9f
 JB3eXzqnuHgypYwnq2DBs0Ntl3Oz//Lm+WwqXG+h+UXwo9yEt8uXZkmBs5yDMWXvFDaOMlg+CaK
 tq9N4DL1smEmcc1V0wa8FPCjfAVqrGe2130zsJZkq4Vhy+/K4VUP1f7jEXq3NoKxy98hw0MIfH1
 ZkvFiSeDJq8eHqjgDs5hQksS0E0W8HkJTOzXojb8Qa3I9SxUwRpQv7bCRbQz+sHQiu060kUJHfM
 bY5+rb7lcck9zIPy45Jw0g/fWwB+/LgXsg+GOo6oA46bzPwuqurPuEGu8m3rvto7V2O2KwgO7E7
 AIojSUtcsiKqFafv7Vk+mzPCtOlED+JokHlubUnQX6wgQpu5kzDF/oGhnrhc=
X-Received: by 2002:a17:903:1a24:b0:2f0:8d8b:655d with SMTP id
 d9443c01a7336-2f08d8b68aemr150933855ad.58.1795773407019; 
 Fri, 27 Nov 2026 01:56:47 -0800 (PST)
X-Received: by 2002:a17:903:1a24:b0:2f0:8d8b:655d with SMTP id
 d9443c01a7336-2f08d8b68aemr150933665ad.58.1795773406467; 
 Fri, 27 Nov 2026 01:56:46 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f14a432sm118132255ad.75.2026.11.27.01.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 01:56:46 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:26:38 +0530
Subject: [PATCH 1/2] misc: fastrpc: query the dsp capabilities during probe
 time
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-master-v1-1-f998ec22497b@oss.qualcomm.com>
References: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
In-Reply-To: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com,
 dmitry.baryshkov@oss.qualcomm.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX9QR7n2ap7nj/
 6aGEnWx66WoveN9SDEWxhp8ftdz0ASrPsiT4nvRxH4VSNXv5DGUdzo0eiLzElYF+kt5z0JUr0BM
 GY9lFJ9mymSx3KUMcMyZM+OLFiFB22U=
X-Proofpoint-ORIG-GUID: dshXtwHbdkmwzMBciCg8Hp1fhHElBH1z
X-Proofpoint-GUID: dshXtwHbdkmwzMBciCg8Hp1fhHElBH1z
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b0953df cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=YTtfn113Cs-F0t8Y9QMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX94IZvPTD/S5Z
 s/3SVGoj9gjgoqUQ3JpFPTfOZj2/csLxBuDMsMnJrxX8BRyWhFRxkLI1gs6KExd3122wUJwPCbG
 W35e8kx9+76c+oCKrHX6vxalPV9074ZPBuR7UHACaK8+CqxQH+k2taLQTTCCXET1M4t+MWbQlXn
 029A+KIOE0+GN0FNOF92mAgHR9iZvFmw8y7GRnPsybB4KZk0EdqW4XUvtGo7oCOrjgB9tZlcnjb
 /vkZNA/mdC7FMEGO4JHV/GRTTaqujmKXPd6MJM3o7ew5R8HjbvAcZclZBWxJwsY3lINgnJ519XA
 fMjUTqWv6ew4EfRWicJExMldAKn05leQxrldd13NU5uBvIX7pPiqYWep5kUnj+IQmRf5sYnRFBu
 XL5XzvgmmmHNGmfV6mU5nDUAEfhEFpgeer10KgeDrHI96+FWir6ZE3zQg5LqByxk1ic/uSszpXW
 TtGZJ0rFZzUacJm7OUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270039
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

fastrpc_rpmsg_probe() currently registers the FastRPC device nodes
synchronously before returning, with no way to know the DSP's
compute capability at that point. A later change needs that
capability available at probe time, to decide per domain whether an
additional unsigned PD device node should be created.

Move device node registration into fastrpc_register_devices(), and
run it from a new per-channel ordered workqueue instead of inline in
probe(): queue a work item that first queries the DSP for its
attributes using a throwaway fastrpc_user/session, caches the result
in cctx->dsp_attributes, and then calls fastrpc_register_devices().
Probe returns immediately without waiting on the DSP.

The duplicate-ADSP-session block is also moved into
fastrpc_register_devices(), ahead of any fastrpc_device_register()
call: since device node registration now happens after
fastrpc_cb_devices_create() instead of before it, sessions may
already be allocated by the time the node appears, and duplicating
session state before exposing the node avoids copying a session that
a racing open() has already marked used.

fastrpc_rpmsg_remove() cancels and drains the capability-query work
(after notifying any in-flight invocation so it can't stay blocked
on a DSP that is going away) before destroying the workqueue, so the
work can never run against a channel that has already been torn
down. Device node deregistration is kept after this drain, since the
capability-query work may still be the one registering the nodes.

Device registration moving out from under probe()'s synchronous
control also means fastrpc_device_open() can no longer assume that a
live device node implies a non-NULL cctx->rpdev: it now re-checks
cctx->rpdev, under the same lock fastrpc_rpmsg_remove() uses to clear
it and notify cctx->users, both before doing any work and again right
before linking the new fastrpc_user onto cctx->users.

Note: if fastrpc_register_devices() fails from within this work, it's
just logged for now; retrying is left as a follow-up.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 317 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 264 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5375847d8c9a..48ded6080ddd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -29,6 +29,7 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/iopoll.h>
+#include <linux/workqueue.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -339,6 +340,10 @@ struct fastrpc_channel_ctx {
 	atomic_t ctx_seq;
 	u64 dma_mask;
 	const struct fastrpc_soc_data *soc_data;
+	/* Per-channel workqueue for the probe-time DSP capability query */
+	struct workqueue_struct *cap_wq;
+	struct work_struct cap_query_work;
+	char domain[8];
 };
 
 struct fastrpc_device {
@@ -1854,11 +1859,24 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_device *fdevice;
 	struct fastrpc_user *fl = NULL;
+	struct rpmsg_device *rpdev;
 	unsigned long flags;
 
 	fdevice = miscdev_to_fdevice(filp->private_data);
 	cctx = fdevice->cctx;
 
+	/*
+	 * The device node can still be open()able for a short time after
+	 * fastrpc_rpmsg_remove() has cleared cctx->rpdev (misc_deregister()
+	 * only runs once the capability-query work is fully drained). Bail
+	 * out now instead of racing a NULL cctx->rpdev below.
+	 */
+	spin_lock_irqsave(&cctx->lock, flags);
+	rpdev = cctx->rpdev;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+	if (!rpdev)
+		return -ENODEV;
+
 	fl = kzalloc_obj(*fl);
 	if (!fl)
 		return -ENOMEM;
@@ -1879,14 +1897,28 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 
 	fl->sctx = fastrpc_session_alloc(fl);
 	if (!fl->sctx) {
-		dev_err_ratelimited(&cctx->rpdev->dev, "No session available\n");
+		dev_err_ratelimited(&rpdev->dev, "No session available\n");
 		mutex_destroy(&fl->mutex);
 		kfree(fl);
 		fastrpc_channel_ctx_put(cctx);
 		return -EBUSY;
 	}
 
+	/*
+	 * Re-check under the same lock fastrpc_rpmsg_remove() uses to clear
+	 * cctx->rpdev and notify cctx->users: either this fl is linked before
+	 * that notify loop runs (so it's included), or cctx->rpdev is already
+	 * NULL here (so it's rejected) -- never linked in and missed by it.
+	 */
 	spin_lock_irqsave(&cctx->lock, flags);
+	if (!cctx->rpdev) {
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		fastrpc_session_free(cctx, fl->sctx);
+		mutex_destroy(&fl->mutex);
+		kfree(fl);
+		fastrpc_channel_ctx_put(cctx);
+		return -ENODEV;
+	}
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 	kref_init(&fl->refcount);
@@ -2585,6 +2617,195 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	return err;
 }
 
+static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
+				    struct rpmsg_device *rpdev)
+{
+	struct device *rdev = &rpdev->dev;
+	int err, i;
+
+	/*
+	 * Duplicate the ADSP sessions before any device node is registered
+	 * below: misc_register() lets userspace open() and allocate a
+	 * session immediately, and that allocation can mark session[sesscount - 1]
+	 * used before it's copied into the new slots.
+	 */
+	if (cctx->domain_id == ADSP_DOMAIN_ID && cctx->sesscount > 0) {
+		struct fastrpc_session_ctx *last_sess;
+		struct fastrpc_session_ctx *dup_sess;
+		unsigned long flags;
+
+		spin_lock_irqsave(&cctx->lock, flags);
+		last_sess = &cctx->session[cctx->sesscount - 1];
+		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
+			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
+				break;
+			dup_sess = &cctx->session[cctx->sesscount++];
+			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
+		}
+		spin_unlock_irqrestore(&cctx->lock, flags);
+	}
+
+	switch (cctx->domain_id) {
+	case ADSP_DOMAIN_ID:
+	case MDSP_DOMAIN_ID:
+	case SDSP_DOMAIN_ID:
+		/* Unsigned PD offloading is only supported on CDSP and GDSP */
+		cctx->unsigned_support = false;
+		err = fastrpc_device_register(rdev, cctx, cctx->secure, cctx->domain);
+		if (err)
+			goto err_deregister_fdev;
+		break;
+	case CDSP_DOMAIN_ID:
+	case GDSP_DOMAIN_ID:
+		cctx->unsigned_support = true;
+		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
+		err = fastrpc_device_register(rdev, cctx, true, cctx->domain);
+		if (err)
+			goto err_deregister_fdev;
+
+		err = fastrpc_device_register(rdev, cctx, false, cctx->domain);
+		if (err)
+			goto err_deregister_fdev;
+		break;
+	default:
+		err = -EINVAL;
+		goto err_deregister_fdev;
+	}
+
+	return 0;
+
+err_deregister_fdev:
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
+	return err;
+}
+
+static void fastrpc_cap_query_work(struct work_struct *work)
+{
+	struct fastrpc_channel_ctx *cctx =
+		container_of(work, struct fastrpc_channel_ctx, cap_query_work);
+	struct rpmsg_device *rpdev;
+	struct device *rdev;
+	u32 *dsp_attributes;
+	struct fastrpc_user *fl;
+	unsigned long flags;
+	int err;
+
+	/*
+	 * fastrpc_rpmsg_remove() can race this work and clear cctx->rpdev
+	 * right before cancel_work_sync() waits on it. Take a stable,
+	 * locked snapshot instead of reading cctx->rpdev unlocked: if the
+	 * channel is already gone there's nothing left to query or
+	 * register, and remove() owns the teardown.
+	 */
+	spin_lock_irqsave(&cctx->lock, flags);
+	rpdev = cctx->rpdev;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+	if (!rpdev)
+		return;
+	rdev = &rpdev->dev;
+
+	fl = kzalloc_obj(*fl);
+	if (!fl)
+		goto register_devices;
+
+	spin_lock_init(&fl->lock);
+	mutex_init(&fl->mutex);
+	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->interrupted);
+	INIT_LIST_HEAD(&fl->maps);
+	INIT_LIST_HEAD(&fl->mmaps);
+	INIT_LIST_HEAD(&fl->user);
+	fl->cctx = cctx;
+	fl->pd = ROOT_PD;
+	kref_init(&fl->refcount);
+	fastrpc_channel_ctx_get(cctx);
+
+	fl->sctx = fastrpc_session_alloc(fl);
+	if (!fl->sctx) {
+		dev_warn(rdev, "no session for capability query, skipping\n");
+		fastrpc_user_put(fl);
+		goto register_devices;
+	}
+
+	dsp_attributes = kzalloc_objs(*dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
+	if (!dsp_attributes)
+		goto err_cleanup_register;
+
+	/*
+	 * Linked into cctx->users so fastrpc_rpmsg_remove() can abort us
+	 * via fastrpc_notify_users() instead of waiting out the timeout.
+	 */
+	spin_lock_irqsave(&cctx->lock, flags);
+	if (!cctx->rpdev) {
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		kfree(dsp_attributes);
+		fastrpc_session_free(cctx, fl->sctx);
+		fl->sctx = NULL;
+		fastrpc_user_put(fl);
+		return;
+	}
+	list_add_tail(&fl->user, &cctx->users);
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
+
+	/*
+	 * On -ETIMEDOUT, fastrpc_internal_invoke() leaves the ctx parked on
+	 * fl->pending for a possible late DSP answer or a future SSR to
+	 * resolve, and fastrpc_notify_users() can only find it through
+	 * cctx->users: unlinking fl here would orphan that ctx forever if
+	 * the DSP never answers (e.g. it crashed). Every other outcome means
+	 * the ctx is already fully unlinked, so fl can leave cctx->users now.
+	 */
+	if (err != -ETIMEDOUT) {
+		spin_lock_irqsave(&cctx->lock, flags);
+		/* list_del_init(), not list_del(): fastrpc_user_free() removes fl
+		 * from this same list again on the final put, so leave it pointing
+		 * to itself instead of to LIST_POISON.
+		 */
+		list_del_init(&fl->user);
+		spin_unlock_irqrestore(&cctx->lock, flags);
+	}
+
+	if (err == -EPIPE) {
+		/* Channel is going away; remove() will tear it down. */
+		kfree(dsp_attributes);
+		fastrpc_session_free(cctx, fl->sctx);
+		fl->sctx = NULL;
+		fastrpc_user_put(fl);
+		return;
+	}
+
+	if (!err) {
+		spin_lock_irqsave(&cctx->lock, flags);
+		memcpy(cctx->dsp_attributes, dsp_attributes,
+		       FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
+		cctx->valid_attributes = true;
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		dev_dbg(rdev, "DSP capabilities cached at probe time\n");
+	} else if (err == DSP_UNSUPPORTED_API) {
+		dev_info(rdev, "DSP does not support capability query\n");
+	} else {
+		dev_warn(rdev,
+			 "probe-time capability query failed (%d), will retry on demand\n",
+			 err);
+	}
+
+err_cleanup_register:
+	kfree(dsp_attributes);
+	fastrpc_session_free(cctx, fl->sctx);
+	fl->sctx = NULL;
+	fastrpc_user_put(fl);
+
+register_devices:
+	if (fastrpc_register_devices(cctx, rpdev))
+		dev_err(rdev, "failed to register device nodes\n");
+}
+
 static int fastrpc_get_domain_id(const char *domain)
 {
 	if (!strncmp(domain, "adsp", 4))
@@ -2893,59 +3114,31 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->rpdev = rpdev;
 	dev_set_drvdata(&rpdev->dev, data);
 
-	switch (domain_id) {
-	case ADSP_DOMAIN_ID:
-	case MDSP_DOMAIN_ID:
-	case SDSP_DOMAIN_ID:
-		/* Unsigned PD offloading is only supported on CDSP and GDSP */
-		data->unsigned_support = false;
-		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
-		if (err)
-			goto err_notify;
-		break;
-	case CDSP_DOMAIN_ID:
-	case GDSP_DOMAIN_ID:
-		data->unsigned_support = true;
-		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
-		err = fastrpc_device_register(rdev, data, true, domain);
-		if (err)
-			goto err_notify;
-
-		err = fastrpc_device_register(rdev, data, false, domain);
-		if (err)
-			goto err_deregister_fdev;
-		break;
-	default:
-		err = -EINVAL;
-		goto err_notify;
-	}
-
 	err = fastrpc_cb_devices_create(rpdev);
 	if (err)
-		goto err_deregister_fdev;
+		goto err_notify;
 
-	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
-		struct fastrpc_session_ctx *last_sess;
-		struct fastrpc_session_ctx *dup_sess;
+	strscpy(data->domain, domain, sizeof(data->domain));
 
-		spin_lock_irqsave(&data->lock, flags);
-		last_sess = &data->session[data->sesscount - 1];
-		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
-			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
-				break;
-			dup_sess = &data->session[data->sesscount++];
-			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
-		}
-		spin_unlock_irqrestore(&data->lock, flags);
+	data->cap_wq = alloc_ordered_workqueue("fastrpc_cap_wq_%s",
+						WQ_HIGHPRI, domain);
+	if (!data->cap_wq) {
+		err = -ENOMEM;
+		goto err_destroy_cb;
 	}
+	INIT_WORK(&data->cap_query_work, fastrpc_cap_query_work);
+
+	/*
+	 * Device node registration (and, for ADSP, the capability query that
+	 * decides whether an unsigned PD node is also needed) happens
+	 * asynchronously so a slow or unresponsive DSP cannot stall probe().
+	 */
+	queue_work(data->cap_wq, &data->cap_query_work);
 
 	return 0;
 
-err_deregister_fdev:
-	if (data->fdevice)
-		misc_deregister(&data->fdevice->miscdev);
-	if (data->secure_fdevice)
-		misc_deregister(&data->secure_fdevice->miscdev);
+err_destroy_cb:
+	fastrpc_cb_devices_destroy(rpdev);
 
 err_notify:
 	/*
@@ -2974,19 +3167,37 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
-	if (cctx->fdevice)
-		misc_deregister(&cctx->fdevice->miscdev);
-
-	if (cctx->secure_fdevice)
-		misc_deregister(&cctx->secure_fdevice->miscdev);
-
-	/* No invocations past this point */
+	/*
+	 * No invocations past this point. Do this before cancel_work_sync()
+	 * below: the probe-time capability query may be blocked waiting on a
+	 * response from the very DSP that's going away, and fastrpc_notify_users()
+	 * is what wakes it back up with -EPIPE. fastrpc_device_open() checks
+	 * cctx->rpdev under the same lock before linking a new fl onto
+	 * cctx->users, so no fl added after this point is missed here.
+	 */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
+	/*
+	 * Wait for the capability query (and the device node registration it
+	 * may still be running) to fully finish before deregistering: it
+	 * captured rpdev before this function ran and does not re-check
+	 * cctx->rpdev, so it can still be registering a node concurrently.
+	 */
+	if (cctx->cap_wq) {
+		cancel_work_sync(&cctx->cap_query_work);
+		destroy_workqueue(cctx->cap_wq);
+	}
+
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
+	if (cctx->secure_fdevice)
+		misc_deregister(&cctx->secure_fdevice->miscdev);
+
 	fastrpc_remote_heap_release(cctx, rpdev);
 
 	fastrpc_cb_devices_destroy(rpdev);

-- 
2.34.1

