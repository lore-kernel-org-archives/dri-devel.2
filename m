Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4976DCC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AF910F083;
	Thu,  2 Apr 2026 05:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gGYVLTx7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3xL22IW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BC110F083
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:49:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631M4Axl1128979
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 05:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=f3tzm5JBMwO
 w31Vut+2DEjfXxJ0rtenkMsmzXkmycbw=; b=gGYVLTx7Zby8UkIW7dM1Jd/DZuA
 ainZAqX99Czs+QMXlZ2RKPUQfWTbnC7gBnlVSRdTCXeST1wwu97JyZMfpYgmox3u
 UxrPWmTaabx54Y7xDNLw34Eyf/3DhHhWTKKnW91tgHgZg77JplFu2/aSQK6B02PV
 Erlzr9b+BDvDePtV/sy/OEdn8Df5ZHeW9bzUKCKqzRTWDJmzAbklrmwkNeZvmnvp
 M/3Tf87Mg0rcbq6cX6r3+prYc20NXp5VYWliw8+EqT/YGvctJbyP8KjqYQ8Hrh3h
 6LD0ojrMwM14IfqPwX8p+8alH30EPTjc7N9H9flLNHNGXCtppqzTWF1khJQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96k9aef8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:49:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c7651644975so325393a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775108980; x=1775713780;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3tzm5JBMwOw31Vut+2DEjfXxJ0rtenkMsmzXkmycbw=;
 b=g3xL22IW4aU/fUO6brVAKmUVu9PxA8ZqpUZ2qky9elArdp0IJCirdaYTVP/LUs1/fg
 8ed2VautpusIHcuLFsRFLNhTongpu7GV8r6bjxJOjXl0v6OAj8yweSEyc+JKAt5AwqYg
 lKWcCe+JYT/oH43WnJxIEw6M8+s7CiHz469/q0OPi85zeuZ13F74lzPodEp7IDVABQhr
 YqmXNZf8mwY7IVqB4EyNGz/bcfmxlViRCCzZf7V3D6um3+n/H1lFyV4xhr0ZjMWmw3UF
 ksl0KgG9UP0HukG1addApR2p1cgqbyTwwLIsxxm+MrYSb0v9t7M0AyHG/e0BJ3iRBFoe
 iABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775108980; x=1775713780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3tzm5JBMwOw31Vut+2DEjfXxJ0rtenkMsmzXkmycbw=;
 b=pP/gIexrEyy7JfWAAcO2huto51Htw1qvEdJjndw0oRVIFBzK5cjspno7epdBW455Rg
 KNJYBGk868FL3tLD21+BrNqpPh3vQgqWoFvX425lplA3PeuDeIWWjUcsNlV4GGCK8pHu
 pz1Qwynas0Cj/gDb+hr0rbUPlHJWRctQFNvROd24idnFl+jnsh43eKNnYa5mFkX13EdI
 Azd6y8TJSZUN3b/xvUY3kvDL7EttaNffIcjq90/3vrjnBVdm0R4KjPRrrPUlTrFBKM19
 bGgPAUKlP//l3tjibfxPG/HJVj2O8apfnSxu3pOhtz17/JCrJwvHpXicAbqrQWPHumAX
 uVzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYjK53uHS5l0TG50xGbWKiEkM9aLv9f6TCFBXZANU19kAJxv74zEiFAm/NJrfME9mhcIy+PiYgOz4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypOE3XrsOo2eeobqhjHlSKRHf8pMxUYV+1qO2lPnNriTxJqTo6
 fsbfHqCA2HpW3UF9f3HCnJBDnT9gJ5ZiRhnuATEddFPK/GknXg0BYpqIMUA3p1RTVQcKYcKHmkk
 5j2ll3h8UtNm1sbDWG3QdQ96M+SzRh0/2z8+LB81nE49+oxjHGWDLeXCYHQAkLms3qsAeN/c=
X-Gm-Gg: ATEYQzy0FWorBB35ZyRPyDSPklG5v1fp7AZfPiWz63qwlNpISlGyM830WMwnYaxs1Su
 7X0RDy4377Fezptw9m2QSnAqAMXgIp8oxaokqLuxwNtO8MBpUUAvqbYuwOIF6iLV3v/ctsghz+U
 pRJk/YLMTRVDXzUFewy37zGLicWuFyxrQoBkrVaK6VYBnxgYhkO0PzuFz7wpKdHDpEW0wifiUtz
 0AudYzzL7PtIMQHQZ0XWPOXbYhWGliWWGrfpo0/FfMl+pnfWecdSdubKDr9AaNKyTBsnjTVrbby
 Ms6zhq7qMDK+tzYTVF/eRm65KTi0DpXZtpQ623KLGp14ZRMh1LtU06KqhGDjzP+3wD5YhNHaRyi
 KBEKEppOnDyIDmNjcBp/sC2+BLnTiNVjLJDLCgbqnuVdQmd4Wnlz75w==
X-Received: by 2002:a05:6a00:3c87:b0:81f:be3c:9c9e with SMTP id
 d2e1a72fcca58-82ce89975dfmr5757629b3a.33.1775108979378; 
 Wed, 01 Apr 2026 22:49:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c87:b0:81f:be3c:9c9e with SMTP id
 d2e1a72fcca58-82ce89975dfmr5757597b3a.33.1775108978879; 
 Wed, 01 Apr 2026 22:49:38 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b5fb22sm2167747b3a.26.2026.04.01.22.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 22:49:38 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konrad.dybcio@oss.qualcomm.com
Subject: [PATCH v7 2/4] misc: fastrpc: Replace hardcoded ctxid mask with
 GENMASK
Date: Thu,  2 Apr 2026 11:19:21 +0530
Message-Id: <20260402054923.3061925-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
References: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=doLWylg4 c=1 sm=1 tr=0 ts=69ce0374 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: bCTC3vEoDQQ7Ac-vNzWGbJxL0nhb0s5N
X-Proofpoint-GUID: bCTC3vEoDQQ7Ac-vNzWGbJxL0nhb0s5N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0OCBTYWx0ZWRfX4UO+G4P81R/P
 UFBMQU3AsPiUs0NmAJnjQJ/ypJleJ1KjbqWBxJA3NPyPltPPzMlSnyc4KX2R6mkqJEyKQhS+4R3
 n/Llo4mXrno7cGREdI6f2tkNc1D85+TQV9LuZF7p3MtwGeyl4nr2ajH6zG1W3dzFiqYP21OBJ3C
 ZoXhe738/jrcpvB/oiUzSx7vcZ3zdwfQ4IYicyezFqA94z0WoAFxb71q0BLf3erXNa+icPvDbVN
 fWca55JMwxingHHixDjUv7ZEUVvsptPS8HiZeeunEeo8R5vxVaPPFGP53vUnxtApsjXziAdaehv
 47lq3961B4d4Ti0D1m0DSzMt1jCdUidtOLkOdU3jlgXeql1kw5euBUE7iQkAyPsPauip9R9zgqz
 rZITakBkcwjOfCpiE/+H+L8QosGGcGjeCi7xbFLsGKey/9ncD94kBxDSihmACvCuPyV+qlf8WW0
 c1nleh2GP1eQW+kQNdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020048
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
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 11f4ae749e51..ce4874b9480e 100644
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
@@ -515,7 +516,7 @@ static void fastrpc_context_free(struct kref *ref)
 		fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
+	idr_remove(&cctx->ctx_idr, FIELD_GET(FASTRPC_CTXID_MASK, ctx->ctxid));
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
@@ -649,7 +650,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 		spin_unlock_irqrestore(&cctx->lock, flags);
 		goto err_idr;
 	}
-	ctx->ctxid = ret << 4;
+	ctx->ctxid = FIELD_PREP(FASTRPC_CTXID_MASK, ret);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kref_init(&ctx->refcount);
@@ -2505,7 +2506,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
+	ctxid = FIELD_GET(FASTRPC_CTXID_MASK, rsp->ctx);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
-- 
2.34.1

