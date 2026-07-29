Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F003C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BC510EAB9;
	Wed, 29 Jul 2026 07:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D55Wl4PI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MylNdSFT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3914810EAB9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:12:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T4cOx0641422
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=SnloaealkmuKUdtscWJ56PcucYTV8n1BDo0
 /2qHaktA=; b=D55Wl4PIFfGlX6RZ5NPDYjWngH2/pfMHmd5XqSkIu+gB09vcCVH
 Uu9m2ObrXnGkYbosiZOx+39w0LhHpWUKXzWM+RROmcn+a9cb2TdJz4Alpxm0V2UG
 ec8lAcHfJP9tI1g5jZ6/eMVmhNvd8zeXIP7ll7Nv/INEu5tiwLWki2vCDhmqwKYu
 0+Xjrv86Ra1vI/9eAigntpWpncihhnZQ7piKlA6JY+xJ/Gam3IDcTZ765/VRnwQi
 FLCeK16+dI6hzZUYR6ZAOr8ARYhZFX3Pcsb5d0wPrhCi5COggWtc9wJFwEmnJT3K
 MHVELnXAsqu0X0w87HVZS9QVp02/5WnMlGQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqa300n1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:12:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso18617745ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785309174; x=1785913974;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SnloaealkmuKUdtscWJ56PcucYTV8n1BDo0/2qHaktA=;
 b=MylNdSFTGVlvSaQznqdxuMD5CkJQy2zwhnPITE21VyT3apzVml7C0KcyLXMfIMbe7X
 05U1DRVgZBh6QR3V0j1kcFo0vG7zswEVTHFYmlI0oZXq9bme7idjh3jnpP79bPPXp3gC
 C01I2yci10/839LS91OUd9t8bGUCqs2QIqPBaJ9QBwMQJ+ZvL2m9KBFQLfkEAx2UmfeV
 dm8fyzBmSPHXntyTek5aDWL7r9k7n+3b/36F+HB/zUs5WjDJf4IZuDcWcA2J+rnhgiT9
 csPqRZIV6P03EB5nSoZT4/4DhvdC8YPDeArTvZSGLGBu25js2Ev9JWmWpipLd49qOu6s
 YdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785309174; x=1785913974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SnloaealkmuKUdtscWJ56PcucYTV8n1BDo0/2qHaktA=;
 b=fQSSV/U8a1sNE8cFKWsS/nilHK7c4G2XpaSxO4xnPkZcJLpg2q9B8C2OfKyS0Vs8Xf
 qgXLYlKyT/9p9IukzMQhMZnwSAXM9UHRusqSFufO9Af30RnH21QlRmWcxmOIx+jhfhPZ
 p8SRx3gGxP03/nAkd5GYOM6Iz67CpinJ/eP6luquDcZmbOoM3I5NsuCw578UV8Hdo9oV
 xum2TSrBpg6DZfJfUMYNrEfRl0YcvmChWuJFPVjA/lKO7jn55fPcKRf0g1rVW6tphG3J
 3gipDGhSdcKLx03AZ/K3EDb6lnVjGd8sXSTymXlwI9qB+GZTBGrj18CE2G7yGvnV0Ey1
 Qi9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+JeN4sHWXnXXzKFUSQAk34gKsFk6nEYtx92Gue4Ao73/poPe7Y7rQNrfmcdSS1ZCwsrSNOT4S6gk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7LgRmVMxXtABmp03Xc/a5DGrfu+sRMiZnhR2/2L4GJOPTzQCo
 DqvquovtfR7LTfbKf+1/obtrj/C4fzm8JeIwmwrCB6BTZBiav7XCZbte2w49Rqf/LQdTpYCizNs
 8bf+30n/x+6VdB4M+3bp9e+Ygw7LzdugCs6GqvdgS6DObasVBeAIV+1FOPi/ZcRNlzda2MrM=
X-Gm-Gg: AR+sD12PYjSAVSCl8LrGQvlaM7u2Ejy3fqSHwRyTB8Hmvl87wgKjv3EYV+XH9MvpRl2
 d2q/M6xJcdbrY9t6g+HoIFkOqtLf1xIjfkhwUCQzOJfgLNz7j4RrqY2e9mPqPYxdkbSm/4vKloM
 q/pZ2KAE1kbsqGFW4KXOdS64KWtcLZO71kJju4AWJb5QwsL287AS88HynQ6B8XSmQ49+h6iy0q6
 PPO3oaFlXeWW5q/Ge4NaAIpWwjqHOebAbA5epcvxVgooF0hH6c8h5xkfBuIKGsP7BZQDtGsjyfs
 rFyWUCGm6I1ohjC/X4FnXDu/1xJGGC+bONOoiWFP/xIqRynyqvADvNYvmfMgZ5wWeTyVI3I1Tcu
 Hp9apXlccju7J/jaF2eNQ2505aUovTms3DodmBI94A2yA/oHFaPsPqwQE77dm
X-Received: by 2002:a17:903:11c3:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2d015f00e62mr57224865ad.22.1785309173917; 
 Wed, 29 Jul 2026 00:12:53 -0700 (PDT)
X-Received: by 2002:a17:903:11c3:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2d015f00e62mr57224315ad.22.1785309172870; 
 Wed, 29 Jul 2026 00:12:52 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com.
 [199.106.103.52]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bc8400sm6719185ad.47.2026.07.29.00.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 00:12:52 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2 RESEND] misc: fastrpc: Drop unhandled DSP PD exit
 notification
Date: Wed, 29 Jul 2026 15:12:35 +0800
Message-ID: <20260729071235.946502-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9iadzhMNUpqDh0fgP070_K0KuAO3Va-g
X-Authority-Analysis: v=2.4 cv=EME2FVZC c=1 sm=1 tr=0 ts=6a69a7f6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=G6LYrpz0uQ56CJO9uQMA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1NyBTYWx0ZWRfX59BGzGjsbwud
 dQ507CQD2cETf9PzsmNmIAVirMxdvwsgyWdtTMem09gnN8+0uq8EnnzNQ0v7DQpulIrKY9dG5OU
 7tY2SHBYYk00a7oK1aPOzB85VPZd2xs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1NyBTYWx0ZWRfX4+d0iMzuS8LH
 cgNM+stEt3akpp/mlmV1E5zDtB/ogL2qBQtWCJPTJHuyHRBhHjEys8lYmbL/+4927laYgHeGZJh
 ZBFn9rAbtPKsRZBLESUO6brscLyQbcjcvTilSpAxVec3HWuPXcNOV+7Lf1I+6X2Gy8pcGfGVZV/
 h9w0kpqum8f0ZX893vJcMsAcKqHD8yPHx9xyW49QiZR9leka77AWwmt55oKMHADlys0cp/hO4To
 TGZQRPlvY8sZ99y3oU1kAyWIxc7DEy6e37KXcTh86k6hltbv9um5+slMLh+dAWk4RYsmpy5Hwjk
 TFlqgrwds06M5tsGUe1ZnkDV4RTy+AtN80XFufcEgn9sCf1vMAh9yns/F2CJsoTMrB7vAbEs/R1
 Yb4ainHFInPG5zLN1m1WH/nu//DdIYR5VrZO9EkNa1zHHbI19CsDwFUyv5Op8cR/XErnCrqtKxR
 BsgD+fqiD8Dox78Sccg==
X-Proofpoint-ORIG-GUID: 9iadzhMNUpqDh0fgP070_K0KuAO3Va-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290057
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

Newer DSP firmware implements a PD (Protection Domain) notification
framework that sends PD state notifications upon request. The PD exit
notification is unconditionally sent by the DSP with a fixed sentinel
0xABCDABCD in the context field.

fastrpc_rpmsg_callback() treats every inbound message as an invoke
response, so the sentinel is masked and shifted like any real response
((0xABCDABCD & 0xFF0) >> 4 == 188) and looked up in the channel's
context idr.

This is not merely cosmetic. In the common case idr slot 188 is empty,
the lookup fails, and the driver only logs a spurious "No context ID
matches response" error on every teardown. But the context idr is shared
by every protection domain and the listener thread on the channel and is
filled cyclically over [1, FASTRPC_CTX_MAX]. If slot 188 holds a live
context when the sentinel arrives, the sentinel's return value is written
into that unrelated in-flight invocation and it is completed early.

Since neither the fastrpc library nor the driver supports the DSP PD
notification framework, it is safe to drop the PD exit notification
before it is ever turned into a context lookup. This removes both the
log spam and the mis-completion race. A genuine response can never be
masked: a real context is (idr_index << 4) | pd (at most 0xFF3) and
can never equal the sentinel.

Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Resend by rebasing on Srini's fastrpc for-next branch

Changes for v2:
- Update per Ekansh's input about PD state notification (Thanks Ekansh!)
- Link to v1: https://lore.kernel.org/all/20260727130940.577721-1-shengchao.guo@oss.qualcomm.com/

 drivers/misc/fastrpc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a859edb75499..dd51d475a74e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -51,6 +51,17 @@
 /* Sequence number occupies bits 63:16 of the ctxid / message context */
 #define FASTRPC_CTXID_SEQ_SHIFT	16
 #define FASTRPC_CTXID_SEQ_MASK	GENMASK_ULL(63, 16)
+
+/*
+ * Newer DSP firmware implements a PD (Protection Domain) notification
+ * framework that sends PD state notifications upon request. The PD exit
+ * notification is unconditionally sent by the DSP with this fixed sentinel
+ * in the context field rather than the context of an outstanding invocation.
+ * Since the fastrpc driver does not support the DSP PD notification framework,
+ * this message must be dropped rather than matched against the context idr.
+ */
+#define FASTRPC_DSP_PD_NOTIFY_CTX	0xABCDABCD
+
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
@@ -2710,6 +2721,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (!cctx)
 		return -ENODEV;
 
+	/*
+	 * A PD exit notification from the DSP PD notification framework carries
+	 * this sentinel rather than a real context. Drop it: a real context is
+	 * (idr_index << 4) | pd and can never collide with this value.
+	 */
+	if (rsp->ctx == FASTRPC_DSP_PD_NOTIFY_CTX)
+		return 0;
+
 	ctxid = FIELD_GET(FASTRPC_CTXID_MASK, rsp->ctx);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.43.0

