Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68057C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A201010E7EF;
	Tue, 28 Jul 2026 07:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8SPRHGS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCI+Tq0E";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0029210E7EF
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:39:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S63htZ1388806
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=b7ykTAQzF/9shSFaKwSl1cQA3MvJJh+AbxX
 2Guk3G5o=; b=O8SPRHGS8fZhRHZRQF+sszQr1uo6PWwmAd+qEYvwkZyqWMrmXPk
 T8k0w7TS/y+4jYvgpTl7HeHAF+hRH5n4MHZXtFsdVcAj2d+urdgZ0vF7zyuLI1O4
 oSxt5DSnF1/bHs4mWtKmT4TgUrRcNkQp+itID9MDYAmUfu19r81QP3/9YHIOoxUc
 11Q0gW3tndvn+gaPJoURGpkFflKP7vb4DRN9VA75zSaVGtH/rpJ2ynLNi6PuSvH/
 nDL9jZXzWexZFK2lEy344dWpQenA0PaJkl9iMSBjMUIndowtdgVU4dHMSjEl1/3d
 3tXZIfu9Hblgi/gBdkxfAzawCk7xsNHiq4Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fppttrcns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:39:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e024d2129so6554490b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785224363; x=1785829163;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b7ykTAQzF/9shSFaKwSl1cQA3MvJJh+AbxX2Guk3G5o=;
 b=JCI+Tq0EUCWzxg3Xti0dl7N7uymQqNTTCrgcab/jS6MhKplr223E7fCQf/2N+BPTyE
 LWOq8TjRwwpIE1mYsURc/6fU8SIi+iyOBJEgGb8+RsiIPtRe2jqg9eeQ3QncyertT38J
 y1V8tYwG82rd178eWp1ex/D8O59cEw6NzPx+Ya5Ir1XlU6XairZXJHJ7lBA5O6VIyqp3
 aM3Yh7jQOoXVu3APN7oTsMtOacLYTSZWC5isv1qxCQNcdtaJsAPQU86mWyasMSt1mmkD
 H/1OgrP0E9Z8AR1s2GW4z7AD9hwyHihcoLqJgNGVrBjafjiYSJCwKxguAhWXGz81h7se
 0prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224363; x=1785829163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b7ykTAQzF/9shSFaKwSl1cQA3MvJJh+AbxX2Guk3G5o=;
 b=HngXzjaQyYPEtOU/7NUKwvwlOSjclHUSkKgXTjbBG/l42JkCvjgix6JFHuUVA1mBD/
 +2ceE9ce+M96pwh+sNtMGGK7yUs0j6GnOZA2kcIpx50uREv46z8UM6Et/J7YA0SQtvTM
 iVhcnEY6X0MI4pxbrpV9RyD9Dlj+z+gqnE3cxT+rpzxK6AYyoS/MrAuxMAUidtaMPcm+
 rLrjKnzYiSZ2lzv+cLFLJsS9mFR31xtzPla7gNnFymwV+tLwJVysjpEkm9JdOJD2N9VU
 VEvFgSnJi1qBGSsglroAr67sudotcqPbyghySwOQyFIOMXuXynjI0a2XTRDevAK3lIhf
 qBMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNNuOuKgBW63hfvlwnH+Mhy3A///D6gSsZ1Qcb0BLnpDpViBfP+rp1e3pSTWs50ed2S4cE3HiF2+k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFRTuZ2pkT35biJT1k6k2Je8AsKH7e/aRvlSNzCBz0vrg8IC10
 3/DOyUuqG8Ne3gKaXS7OnZ8A7SpjMmGeHePrhyUjkoiZwqn9Rt8t7DdhzCyklmbjLRZjxhHshzw
 E4CRPykn6zycp7I46e1JAFckIPeUwyUnnMaFFF1Oxt4uXinjhm7IGh8Rhy4cDl7UzfSjHQtE=
X-Gm-Gg: AR+sD13wglk4/2fRDjrvtZsHrOJn6ahmsRW9W21AzukQ+e7wJ5kvu1r9s12RD4EcZ0h
 3q8lpMKJe3dNT9cON85JkUbzSdT5/rGCwsyedpNW01KCOl4Q7AKUYNybMnoauK+JwMgUpRmrOAC
 9613hOkNTEKmnbz5eDozWvyB56h1ZLrcuORlUntjONhyKaDWRGnU4hFwnmTEvtMc8pdTmFg6zZw
 faqlrxQwJE0BBRQXy5xk/aiV9539GtOoguoMo/LS0sJOnW95rmjQ/fTfoZVb+spCrBW8CKoiN1a
 /knwg2SgvjvVV/ShliV1BfN6Bnt0sCSCKYvOHJSX5mRLxncL3zry60F8XBIS+qf6BKybXcYwWCP
 jqDtW2sJBM/l96hKALo40XCn+W/Lhc3D+n+5Vyo2nPCpa4WLS+oz/X+5pDax3
X-Received: by 2002:a05:6a00:9093:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84e931b4f60mr1440135b3a.4.1785224363485; 
 Tue, 28 Jul 2026 00:39:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:9093:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84e931b4f60mr1440111b3a.4.1785224363029; 
 Tue, 28 Jul 2026 00:39:23 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com.
 [199.106.103.52]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53425989sm4024164b3a.48.2026.07.28.00.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:39:22 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2] misc: fastrpc: Drop unhandled DSP PD exit notification
Date: Tue, 28 Jul 2026 15:38:51 +0800
Message-ID: <20260728073851.682023-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NCBTYWx0ZWRfX42783DRj/dV8
 7nCHQhDLaPvxchiJ2t95q5g+WtjJpFJyTtdd3gClRvVrC8s/uPezzICOa+gwZ34VNUojDKcnIYV
 ZsFIl6joBlLSOWnLYRWY95MXJ5uUU3k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NCBTYWx0ZWRfX/ZaPmJvk+F7U
 7Sm9O5lucs3VuGhPuNUTs5Wtp2CcPvi7aQ6k3KN4PUXcsqAXicnIbbsqmucIY8IZPvCNozIBXvt
 KH8+ab3KuRkIWysUPMfA/cNVJ3WIMxA4z7B2QXslBYInvVAsWAeUNV+gQ77PdhENzcxuN7JQj17
 4GHK5JbwkY8gjqcvvDupkZOgG5QUZwWiA3OlV85YkHpmlE2Apb7Qt8l77779tb3wws3TkRMKi3w
 FxkkZUxkBO0p7Nm0J8hxmdEoxFHjdcQFqmCVKgeeWfBLfoMjoZTXJ1u/VUlfbgu9TWwbcLMH5qD
 Z38aABIvgaBrHDwPcG0iNiFE9HrZQFpwpDoGniowox8+XPfLSaoPB/oR98a4rqlga5OxPAdflhG
 qk+xeJKmStAn0MZg1C0ewCfpB8PxbqHytTRb1ukNkII6rioHqF/ELqdOvBm9FfCLdu+nxpzhRrZ
 UOY4m4P9Ym9SRLQ6OoA==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a685cac cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=G6LYrpz0uQ56CJO9uQMA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: JEt0XxK-k-hunvJiqi8ferTW9XaiOc3G
X-Proofpoint-ORIG-GUID: JEt0XxK-k-hunvJiqi8ferTW9XaiOc3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280064
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
Changes for v2:
- Update per Ekansh's input about PD state notification (Thanks Ekansh!)
- Link to v1: https://lore.kernel.org/all/20260727130940.577721-1-shengchao.guo@oss.qualcomm.com/

 drivers/misc/fastrpc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..97c60271f94a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -38,6 +38,17 @@
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
 #define FASTRPC_CTXID_MASK (0xFF0)
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
@@ -2552,6 +2563,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
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
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.43.0

