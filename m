Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99479CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA7E10EC8D;
	Tue,  2 Jun 2026 07:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZZ5KSwYM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AFLmtmG3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A06710EC8D
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:18:16 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65218wt33430710
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 07:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GExpfkrACNf
 d8AgKb7pzoxx6CS0kiv0JrtZqZXX3hVQ=; b=ZZ5KSwYMKZBdV2J7rA+BKaZVSuY
 kJFouZjz6jCJZi/iK3YsFL+fbQ+DTKEfBqyDlULM8aLXhwfih66W2eYPiYHm8+Nn
 I9ZXzC6UncyYH3dH4pvWoMjOAZa7ORpPsuj5RnKVxO770UnmGOtgwYogZH6nnIUv
 vyl69sWA+GjmvwmgLrsLootw3pvSvJsgwYdyqSDP7HDNMQVbwkdTIkE1obBs99p9
 o0y+yfRFEf3+EmlswYIA0WYi5G90IeGvD60iNE+nnKgRIR5qlhCoS9lNDbB1RWMH
 TewUoF3xx6+URUz/Tvx/kAE81KU+sRfnFjnfOh67Mmjt0UntQ5ZVrJbwaOg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mh7cn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 07:18:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36b982ec338so5054256a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780384695; x=1780989495;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GExpfkrACNfd8AgKb7pzoxx6CS0kiv0JrtZqZXX3hVQ=;
 b=AFLmtmG3UgmpF2M44GZBBAXvz/pOf4QUIpoCMU245YM2PuNGb4o+CYFjA/+bloxFee
 tSveVo44Pvgc5sgIsL0jgpcDW0HfKvkr0RBB7VwlKH2OCqsbkyvn9VfCCDOUmyclSg9w
 bsawClaRJH3e6MZOCKLcvSkrP65pZ4zxV1rqKdI5XAml1xgwQV4wcKoZnK13tceBvUoS
 ENPHMYs0hIaJbPTBAMbyslJwQibFYPF2riG4hU5m3/l3niOTl/KZzYuAQtapk8VfOMwA
 +tVBwwjmBVCSwPYnr3WB9cf/uZs0nje+Ytk1HzlnuLxqIqo7vX05n6AbDnPmH5N/A0ty
 RLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384695; x=1780989495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GExpfkrACNfd8AgKb7pzoxx6CS0kiv0JrtZqZXX3hVQ=;
 b=TdTJzmd8z00NhwZXfP9axMOIg/AMpTwmugKwa1m032uOqgxL7nQPjExRpBBDjLdKu+
 t94EPlJpR7I2Jh/wEIWlAXLKtBCs23lfFgvd9q6ib8P41C2pU8K8oMGxyFy8GrMTUHG/
 ngUGW/wFdG2uShXxpxDyekGH5edOd1+P66JLZWD2kD13AqoWmijma7BXDpIe5dcr8lk5
 eK1b4mjn562/lWg3s58DyualicjFbui1HdBL/NZklY3FeWbzX/51gvEXopb2xByBjMF0
 EATSGmZwqZlxJ8XlAoR8u2HKwjYqg29mkFx7xiToCwmF0Phgbz9Zkh5Olkt5Fo85uhcE
 UnFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Qy3ywOrkm/GaE5mb+aRpp++eDKTdM/pawEhh416El4tOQKPaCGZK6qJbSum3u134an4ZLf7owpaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzadHxMm3y0TuefTN3z4u5d4ohRSaugEbOEWJlfnT2jYvCbfhXt
 UakHhS1oKyM0VrBdkPBqI6ypzkYLQpt+wCOLXxVwkMuIkFbs0EdnSO7xeXh6ESWYuZLGjUIDjlZ
 wcbmmYCQsUvn9pjGDTcB9nmQ4SRBSBrJkqxA8aPM/9z0kYpWuC9wqPDQJ1CNAxzRMvo+CX8E=
X-Gm-Gg: Acq92OF6DFWog28+QrK7w/PZKzcY3Mv+QBNN54Z4G8ur1RqNbVll7k/PFEy3L235w0h
 0OrGPK/VspQcjBtDFLMaqFyPNOHpHiZHDKJUvXWE1PSV4ZHUbbap7vNEfgRf0pz9RGbHx6Kz6Hz
 KFMeXFvAcO/nEwHIgT2EvOGJIGKgI1XKtVW6MYZvGt/nvYVr1OhpDvWQVGMMSUBJG+MvlPuUtXZ
 0/kzFR5sMHG2Ol5xQ+2+oTZ79YXIZlzUUAVyJxFSFtv/GYTm5bJDfKHODJmySGNYffaDHXA9Kpg
 S0U1PoPH1UFgO3KR//sEH8ORhFLTFimok1FkXfY1cNXoRvZVgP48mZpWgBaQz6s1qpO9Cu2C2Zm
 8TOWca/AJwLbQf/6l5eATuuq4bCv8OddGheF4lIy1hmN8lIML8bgA5vkIKU2CU2ieSSDIUIRwIb
 Cr+jxVgvj517EZPFYqbscrls715h7+PQ==
X-Received: by 2002:a17:90b:4a4d:b0:36d:dd4a:1e59 with SMTP id
 98e67ed59e1d1-36ddd4a24e2mr2251881a91.23.1780384694923; 
 Tue, 02 Jun 2026 00:18:14 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4d:b0:36d:dd4a:1e59 with SMTP id
 98e67ed59e1d1-36ddd4a24e2mr2251844a91.23.1780384694470; 
 Tue, 02 Jun 2026 00:18:14 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd91c9991sm1766279a91.7.2026.06.02.00.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:18:14 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v7 3/5] misc: fastrpc: Fail Audio PD init when reserved memory
 is missing
Date: Tue,  2 Jun 2026 15:17:48 +0800
Message-Id: <20260602071750.526-4-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfX0ejA9mu8umRy
 zsicLekIEbqBHK2hHhPePQtsEj/AJwV8c0ufA47vYsGEXwxp2Ni9xriQxQitLPXq36vMPn9P+Jz
 /Lw4ni+Pist7nuq+Fop6+6M51Gu3FwuC8AYMx3EnaLSKbpqen1ZVxb+XblVoQdWGuv4URH+P1cF
 BrFRrWTtm7BpOQGNMpYB5Cjhdk3ss43Ez4AryObUBN2i3wT98r/Vm3L8wIeYxDBTOGgHJFDtSBr
 vi/rMYpKdGRiciKHicZqEDoQZPEfD4nUbZzFWgyN8T/7vfQ3CKLncaP/Ic4Xwr2LSB9z0UNKq0j
 qhjKkYbqs3ESWtnR3R3HIlnUqwSgaHaAsHfZLZYYpT3ydEwatLbb7tqQMht0wtO/vbWtV+R6rtx
 V4IlmR7TlTVf40/Pa+mjG/Xlwgf/l7FlJ/zm9w0wBoohQNWmH0QGXZlLwocsSGFfLdyg+pJ2lN3
 ue1tsxiLQQvxxhvSmEQ==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1e83b7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cwMOb1EeFLyGxYfGK4oA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xSfGsuMhDi81_WEMDYJKxOuAPGNl2hM_
X-Proofpoint-GUID: xSfGsuMhDi81_WEMDYJKxOuAPGNl2hM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020066
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

Audio PD static process creation assumes that a reserved-memory
region is defined in DT and exposed via cctx->remote_heap.

If reserved-memory is missing or incomplete, the driver may pass
invalid address/size information to the DSP, leading to undefined
behavior or crashes.

Add explicit validation for remote_heap presence and size before
sending the memory to DSP, and fail early if the configuration is
invalid.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a8a58f889d07..f46a8f53970d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1354,6 +1354,13 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	} inbuf;
 	u32 sc;
 
+	if (!fl->cctx->remote_heap ||
+	    !fl->cctx->remote_heap->dma_addr ||
+	    !fl->cctx->remote_heap->size) {
+		err = -ENOMEM;
+		dev_dbg(fl->sctx->dev, "remote heap memory region is not added\n");
+		return err;
+	}
 	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
 	if (!args)
 		return -ENOMEM;
-- 
2.43.0

