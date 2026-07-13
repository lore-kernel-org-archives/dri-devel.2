Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180BEC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB9D10E53F;
	Mon, 13 Jul 2026 05:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEFQol0W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5InvaaJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB18110E53F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D3A2TD038754
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rX2n8/wl/aZ
 5m0mAvSyZH/8f/EcwdRtpFwxFW/vqR7A=; b=cEFQol0WXB/xTarzSmKHeJ9Fcf4
 DcOs4JPBkm6j/bzteyJ036g4nZIh4g1Rq+moFWD1v1nzDq2GfPrhgm7wwmwobaBz
 MLlUTwV0g6xH6mP6iui2XCNibGyswNimG/wLwMHDILUGCNYBFFbXFXJtBBmWoDC2
 N2dIfAkrA1OhxcxvlRZuDsFo7qpuywlKPVWM5xm5taZyZAiR8AszmNf3xO/mfIVP
 HC1ONrGez4+TT5RjqtwzsEhI14lSFyR50PGwCAu1WqVUoSn50xzfBCDnyqr3wMoZ
 ytCmKWxinkJKB8J2pFUwkHFDp7Q8tk+3JiK5mkW373X0wOSQiUZ0QX4lJkg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9mfky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8485d853b08so6742968b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 22:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783920170; x=1784524970;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rX2n8/wl/aZ5m0mAvSyZH/8f/EcwdRtpFwxFW/vqR7A=;
 b=S5InvaaJzsZwGZMMmLzn1v6ECQa0pS0uglXKVhiOOdVCFTSzBs0T051nl5evKBMaFD
 r+Hc+vbXXUMZXGqmdoZWwVuCyo+/Q2839iCBjrv5PC1HvwGlkRupXQjdxKZ0A5zigt8H
 TZQPMXIPMvJV+J9R31CqwTPELNRcaTUUXWnzb8reh6pg03bre1hJCxguDOaCRpQL/Mad
 eHQDt2j/fVycEqZkaHbOsW9aSnt6SyR2zDDVvIHeMEWKqIVZtjRxaeS7CAZdoyKi1iUH
 +osRgn1PVRhRlsneOo0vptqEnm71NzltAJQxw2WmRpbkwxcEsoSt+8A3BeuJeBk1VKOw
 krDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783920170; x=1784524970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rX2n8/wl/aZ5m0mAvSyZH/8f/EcwdRtpFwxFW/vqR7A=;
 b=CxHZ98xmSwdcZ//WRoor5vtUveS5gA7Si9KVhvoLqM9TwEFyKulxjp8MAvOnYE4HYr
 cvQEy4J9e0AMEuELppdvD9meaa/+cPPkvqouVCxRiebbA07Lff/ZxcdKUuad1whxyYhk
 o3oDRgyAqcRHSolPT3Z26tN+2ZGXZ9hawW5tuxtCDOQIjgOxhLZjnOK+o9rZyDapcnI8
 F1LlA+AA1hbor75xuW/Lhu0nRBN5nviitK/7Vjm82CrZBp9PWD/oDeAkljS3/wHn3NnH
 lrKc/ttS2olzMCakLth17JCIloj89tXEWL1cecsh3gTJHK9DuKabU0IpR2MzQqRYqORi
 cGVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpURSmNnkcVml99ExcvuaVazIOgF3lcE8DE3/Y6w1Az2xmutD5SUeqHaeLoR7TpKQhCU1ZP3G6/fOw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFIAY031AMou3JmNxVVVOl3a1A+qj28N+7Ac/cUNKqagjET2d7
 iaeLjJ2Vz5+8Sl/1TlBOqk3aKBjffT0dgGlZiAs7L0VPW0CV7+YtV6qnYKBogWVhsjaia6+0ocz
 sft8naAyj1dGdwBZLOUdFJi6TUH8P5kQ+IfQ9cuJ0ERKHz42N70r/Syep0FS6RponJ4IkoNU=
X-Gm-Gg: AfdE7ckbu8aOfKJskoOgwuTF/zG9XBzdiUXMaxrKn+Qnefqc9BoMhbtosa8pVLnHUpb
 kkeUho1/Nn24eaq812uUJnsNcaXNWNA8shiuFDxRxWi4WRJQd5M9URrpdo9416kX8Fl2j1ep8wB
 7ib0ki1h3NnchEva9zpxHRATAYQbQ09xbREcS1KKL9TsD3DAvLRK3/0bgTaZ/lryDSch9Ll31Cw
 o+xYepNYegRfac3n9KIkF4SCuDXz7YYuE/1+uqnbeIfBeWE0pZPuWqL1wfFUS1FURQnMwEXnQaj
 1y5zs7dYUvLSLInR3E/P4VyqJtnInx9DCErP6SUbYlQy4UPlavtdSlQslUjXGoRtqoSd/dTHjdg
 2cdB3bH5bu+HK1/BZY2qQpanp94/2MmjoybbBMDLsWOI=
X-Received: by 2002:a05:6a00:139c:b0:848:4c3d:659f with SMTP id
 d2e1a72fcca58-8488990d0b4mr7089165b3a.75.1783920169873; 
 Sun, 12 Jul 2026 22:22:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:139c:b0:848:4c3d:659f with SMTP id
 d2e1a72fcca58-8488990d0b4mr7089134b3a.75.1783920169350; 
 Sun, 12 Jul 2026 22:22:49 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca75ef0c30dsm6245605a12.17.2026.07.12.22.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 22:22:48 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v13 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Date: Mon, 13 Jul 2026 10:52:34 +0530
Message-Id: <20260713052236.3033744-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1MiBTYWx0ZWRfXyEznC+I5e1pX
 AhHtWFHvN+NodvINU4Te7QJWn0UyBho+AnR6LuPlSy4rNEzDzGZw4bshSLk7xB442iUwq0QSlNF
 8XJTuSKn8EYtoLZVMW7C2OsLDkM0XHg=
X-Proofpoint-GUID: 6pR4f163YusX7ZYnLuBUtMoJKyncIvzs
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a54762b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1MiBTYWx0ZWRfX14phvdN8+IJb
 LvEUtBGMdBYj7f3gdYY1tChdYs7UmBMtn6CaqqW2HCm/smLabdz1Czjubxqs/USJrO/mL0RDKS/
 vqrJ7zXWhmcZmpUTBctg8NeVU/w5F35GqK8gqL0h5amSB8LlQBIs4pdIT4BgCOtwzSFq9tSt+r7
 JtvvDdMPT4c/dgYqg3qZZoiAgvdrUVNEGfFsYFaO27/K5CEX+u1CA9hpCKT9SCit1vifgn8E64i
 IQUBn4DYIngyiuKbt3JBVH40fuyR8zxMkiDVNxVk22UE5mu3VRqPORDAYTJLxA82jSe0XeV+CrY
 vs0dU00ZKFYz9ZOYGHc54pYw8odmtzK8uc56f+yuvG6sVymvBOh6DZNXFNqMy4oaXkjuLK9QF+c
 GIp+bji+5Psf+T3i7muYaMgyN/UkDlkcego0aZAbCSy+eze3sRru+3uzVO4ikhXiwYkLKO8j8lV
 UUZZYsqkeo2RECGSwmQ==
X-Proofpoint-ORIG-GUID: 6pR4f163YusX7ZYnLuBUtMoJKyncIvzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130052
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

Replace the hardcoded context ID mask (0xFF0) with GENMASK(11, 4) to
improve readability and follow kernel bitfield conventions. Use
FIELD_PREP and FIELD_GET instead of manual shifts for setting and
extracting ctxid values.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 02c2765e1188..41c2ec0bc628 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -23,6 +23,7 @@
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/bits.h>
+#include <linux/bitops.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -37,7 +38,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK (0xFF0)
+#define FASTRPC_CTXID_MASK GENMASK(11, 4)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
@@ -566,7 +567,7 @@ static void fastrpc_context_free(struct kref *ref)
 	fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
+	idr_remove(&cctx->ctx_idr, FIELD_GET(FASTRPC_CTXID_MASK, ctx->ctxid));
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
@@ -704,7 +705,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 		spin_unlock_irqrestore(&cctx->lock, flags);
 		goto err_idr;
 	}
-	ctx->ctxid = ret << 4;
+	ctx->ctxid = FIELD_PREP(FASTRPC_CTXID_MASK, ret);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kref_init(&ctx->refcount);
@@ -2547,7 +2548,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (!cctx)
 		return -ENODEV;
 
-	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
+	ctxid = FIELD_GET(FASTRPC_CTXID_MASK, rsp->ctx);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
-- 
2.34.1

