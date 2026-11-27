Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA56606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=da+ZMpUe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KQW+sDcl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4423510E5C6;
	Fri, 27 Nov 2026 10:04:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0103110E5C6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:04:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7GrMd560538
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=crSCT2EstgNsJNFIMJ/PB7
 /a6XJ6ZtzNwTlJSmVt7QI=; b=da+ZMpUe5WH81l/+r03aDnZ0TKA58g6AynAuFd
 3PbwG8JlvuPo0Usu3/EutVE+ZuEoD1WYA1MNnVovKM/M6eTqO/wb71QJcc4YpqWh
 SfTFPJ4rtyW+eUYdwF2noJpiU/kgp/ymQa0DM45Qsgw6uk7MWxVaOsgyWu5jVA3X
 kxcdRrXzIVhuAyD6uBf0vWfgTUcjkdEMMF/BX+D+zIu4Q0d8KubJYoKFw0dbFZBt
 H2v0yDCYhP5Sn1jJYLxNrZDhhq64t7GmYPyo8A+t/eKp/RU/SPmPuppbKF5gWGgB
 +wc74DZ/0m902XfeXhJRXM9I/L0eSznehOibS3O/h8Dlf/0w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqkdu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:04:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2f05c68629cso53687155ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795773872; x=1796378672;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=crSCT2EstgNsJNFIMJ/PB7/a6XJ6ZtzNwTlJSmVt7QI=;
 b=KQW+sDclB2uDRWzjsWyApZbvNe7HcLNPLIDlXreaF0A5BobEPwm6ypRHDkUprRdb7f
 fNYlyCM2Z5uPiwyIQxGWYKta/MAiSF1crCz3aS0POt2PkmYLTuKnL7o5P4Aflq++AVrM
 m4yWA1IkF6u0kkp+ekagDpbj50U4lZoiiP+M96Kx3wljNAR8bialpObhBW3x1Fz/ju6u
 rFHzb9YJ0I4gj6kTOboSnVUv9cf3bdKyRZD96kETF8HrZw8VJTL+5NSohxsx0+rh9fNd
 o4YGvmNJPA8JRExFs+c/tvkbd8rvDOB+N6CAGKKJK0UNeWIbIbwO3PA2OmjKCYXFK50Q
 5wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773872; x=1796378672;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=crSCT2EstgNsJNFIMJ/PB7/a6XJ6ZtzNwTlJSmVt7QI=;
 b=mA5a4fcqfDe66k32LZnjPXcTolBJ3UOIEPXTwTlvrJYVu6mHrv9Aot4jf/NF/MSeGq
 puRZB6qUwmKlqATEDt56tiSk1AnQhuDm22FKB1AS1Z8HTy2WeIpuvGPxeaAMq1hLTPl1
 O5/+fh1dCvySb9wu+JO6vTePwnuqfZ5p8HeUVdLm5vwG7CC2aR2dJn0l+f1UQ7DvPUEf
 Awjmb+fEliSLnLpW90xDohhCuBIQnT2v8zCSMO0CvayiYejBxT2mgAJv2KpEET0atGAc
 2rPQjvKIBL6ZxXiYGxU/RGi8sTCPkzoPzDxwni+Iqf1mC3gV14Yme9IaYA/hitrRAlHl
 k1kQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGcbYq6XOjYRKv7zqibLCrsqKTi1IjE9dREQd0q+1Lpo5zyuniZUzy5jVouSCGEPcAidNmEIBvTWFc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ssz7uO3KX7vCeUummqsVXu1qKFlTDXGVqbGACTJmhn2MlovO1
 AKMaMrWA6SHpWIlZsEQK+ts7dm9NXz84q5OG1SEkuS0dVLLVMzdORzMGl/pUMdkvx8QlKFSPTH4
 FvEiXmSW8ZPyNrW8csRBIXxsMmx3kai78Dd/nUHLMU65RTN8Ec9VB58IfhkXDqI+XQzO7ZPo=
X-Gm-Gg: AZFdTZfKN5OJb1Kl/NYOXVBkI/3y8h60U4KszCpIbzhWYYHiVwO2ExZdlhsVmcX7LVV
 q1wdnkdn0VZGlqA8fGKGUZM7REEyUIvQuxnzyzUaVfIzJ8vnEmTngRs0pIHzyfas35IastqzFVT
 h4vxTeJVnYT8VTcbdMmVdYUROUXfodIOB5Nz/xvsPD8iIasvu+rqu8fXflZaOz6Q+sxvtojtDyd
 d3G0WuRVoHRy8/KQVoyxL/i+D5DNERnaYdcewjCaJtt7bhTwRbmg9ZwkqIgLQHDdK0Zq3SLuEqx
 Trx72POw4bM1BVaMvRraNy1Nmj0u0tnlsc22HsVIaYvg7NULFTLmcboba/wK+WgLAKny661cxgp
 GGNWRHUVYXLNk/b0wMZuzCtx6Y/0GsQTzULdWN8JQh/J6PEBb1PaB/RQCYScGCRkfFygNa5WKgN
 cRv/jDCg==
X-Received: by 2002:a17:903:298c:b0:2ef:d952:4a65 with SMTP id
 d9443c01a7336-2f03f1babeamr234436265ad.43.1795773871654; 
 Fri, 27 Nov 2026 02:04:31 -0800 (PST)
X-Received: by 2002:a17:903:298c:b0:2ef:d952:4a65 with SMTP id
 d9443c01a7336-2f03f1babeamr234435965ad.43.1795773871108; 
 Fri, 27 Nov 2026 02:04:31 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03ee84425sm119350235ad.6.2026.11.27.02.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:04:30 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:34:09 +0530
Subject: [PATCH] misc: fastrpc: make put_work scheduling lock-free
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-fix-put-work-irq-deadlock-v1-1-3aa66fe4f2c9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJhVCWsC/x2MSQqAMAwAvyI5G7BFKvoV8VDaqEGxmrqB+HeLx
 4GZeSCSMEVosgeETo4clgQqz8CNdhkI2ScGXWijlK6w5xvXY8cryIQsG3qyfg5uwrosbEmVVcY
 QpH4VSvL/brv3/QDk8rlUawAAAA==
X-Change-ID: 20261127-fix-put-work-irq-deadlock-940a4e7a166e
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795773867; l=3329;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=OqkY2gJhqmf+SDUPxG1CDZcFBvDTgZchNgMudL7t/Qk=;
 b=5MKLE+sXxseY5XU3ASLaXjVtD7+w45YSQEWh56Pd300R2ItYC2ml9So0wQT8810n+FESrwQVw
 ODuJ8IBgwp2CLoO247S50g/la23I2d2cgUUSbleyt7gsQbCONtDomkm
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: Hy9hZZCxAkr9BYt6oWEI2WgJ8U9BQcQ1
X-Proofpoint-ORIG-GUID: Hy9hZZCxAkr9BYt6oWEI2WgJ8U9BQcQ1
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b0955b0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ME4ylVHw-GArSQJMD6QA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX8mLiDbCglx73
 J9yo0dLLSA/GbkKiO09h2k194oiTzSZXkv7yTEZ3LYYGGSMVV6Y1HYnpqv/Dgo+VpQfg2Tx6mNQ
 IlkyMUcGpt6KdMmtJ88dEpRLxvXsPCo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX+EGSBtGOWk/L
 +V5HjwbRMnodDQNSo8VED9Kl0eIyZNCrObV/qbZ4paTDaZu63ePOXdKJ/itNeEK6+xRHWCCvekp
 VJbo+kuJMjGFo2UXVBfs14M8JpEfyTwS37SdCp835fffdpiEWZm4DmTcqchazDsDNuZJcv5vfqC
 vd+ZDo5FvZt3b0ojUfNTbE/UJiXep2uJn4S9irP0Dc5LLnzhnrarW5RIKqtj/fMQY8A3Tq0S50z
 hes1x83AepO0MXulL6x+s+TwAHH0u5a6AcPKVwj6dTXL4EeNZKCnim7x4K+qJqMehrgIy3j0OFh
 i2iHEeyQAmoDxmb8L1Io86hR7fAVwLEPEoFL2Fk3YwNHGsIpX6mOZvpnEoHeyInjZ8CXsUU0WVN
 tgvVdFl6IQUmIBFl6VN+Tf2KQHAyeHZL1AcWS+U7+agw+I5bBbGVPRkgZ+33TryPcI06vXgO9d+
 hVRoUebE3JieHRI6W7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
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

fastrpc_context_schedule_put_work() guards the once-only schedule_work()
with fl->lock. That helper is called from fastrpc_rpmsg_callback(), which
runs in hard-IRQ context on the glink rx interrupt, while every other
user of fl->lock takes it with a plain spin_lock() in process context
with interrupts enabled.

If the glink interrupt fires on a CPU that is already holding fl->lock,
for example fastrpc_context_put_wq() -> fastrpc_context_free() or
fastrpc_free_map() running in a kworker on that CPU, the handler spins
on the lock the interrupted code holds. The holder can never run again,
so the CPU hangs with interrupts masked, an RCU stall is reported for
it, and the system is eventually reset by the watchdog. It is easy to
hit because schedule_work() queues onto the local CPU's worker pool, so
the worker that takes fl->lock tends to run on the very CPU that
receives the glink interrupt.

The same helper is also called by fastrpc_notify_users() while it holds
user->lock, and ctx->fl == user, so a context left on fl->pending or
fl->interrupted when the channel is removed deadlocks on the same lock
there too.

The flag is only used to make sure put_work is queued once, so no lock
is needed. Turn it into an atomic_t and claim it with atomic_xchg().
Whichever caller sees the old value 0 queues the work; any later or
racing caller sees 1 and does nothing. This makes the helper safe from
hard-IRQ context and with fl->lock already held.

Fixes: 3f645f6884b5 ("misc: fastrpc: fix context leak and hang on signal-interrupted invoke")
Cc: stable@vger.kernel.org
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5375847d8c9a..3dd9892b11cc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -279,8 +279,8 @@ struct fastrpc_invoke_ctx {
 	bool is_work_done;
 	/* process updates poll memory instead of glink response */
 	bool is_polled;
-	/* set once put_work has been scheduled for this ctx, guarded by fl->lock */
-	bool put_work_scheduled;
+	/* set once put_work is queued; atomic as it's set from IRQ context */
+	atomic_t put_work_scheduled;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -661,17 +661,13 @@ static void fastrpc_context_put_wq(struct work_struct *work)
 	fastrpc_context_put(ctx);
 }
 
-/* Schedules put_work at most once per ctx; racing callers may both try. */
+/*
+ * Schedules put_work at most once per ctx. Must stay lock-free: it runs from
+ * the glink rx hard-IRQ and from fastrpc_notify_users() with fl->lock held.
+ */
 static void fastrpc_context_schedule_put_work(struct fastrpc_invoke_ctx *ctx)
 {
-	bool do_schedule;
-
-	spin_lock(&ctx->fl->lock);
-	do_schedule = !ctx->put_work_scheduled;
-	ctx->put_work_scheduled = true;
-	spin_unlock(&ctx->fl->lock);
-
-	if (do_schedule)
+	if (!atomic_xchg(&ctx->put_work_scheduled, 1))
 		schedule_work(&ctx->put_work);
 }
 

---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261127-fix-put-work-irq-deadlock-940a4e7a166e

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

