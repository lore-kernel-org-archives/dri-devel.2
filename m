Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84018CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA19310E619;
	Tue, 26 May 2026 11:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BhXad65q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ozmnr2cy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6A510E619
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:54 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8UOuq4117577
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GExpfkrACNf
 d8AgKb7pzoxx6CS0kiv0JrtZqZXX3hVQ=; b=BhXad65qnuPXa4pCQ3qTvcSghZV
 6Ins+HEiNdbggsV1CBXqoSw21PEY8mu/L4CEXHVnYiGnujqPsa/gvuc5xXIjV8Fx
 UJT9UGh0VW94qVRrmUAGphoK9ndcAYH4hBUG0lEtauXjoSpDplQpu3llj+aMOQNu
 Im6Dyq7SKwTnZ0NMyJFRbXv4cVOGI/tB9hsCNFFK4q7XVGf5siYwf4opu218fUNA
 UjNuv88twTY3CnjhrBEbepNCX9afHh+KIo3KePKnc+d0ItD4X3q3ZvHczamGJ8lk
 MWhizXqWgJguYgsTGSepdbesPvDZoRBgYEHOzmZyZQMDbtsKD4swYh3SOGQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqudbjus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3662e7756f0so8345256a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779793913; x=1780398713;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GExpfkrACNfd8AgKb7pzoxx6CS0kiv0JrtZqZXX3hVQ=;
 b=Ozmnr2cy7RpW0D782C4lDuRwGfgs9isMhNUaTDw5xvp56okyT5+ZJWT9eHHHVCfX1e
 BayFfG3nFvOdagNhXwsQMYpjsWpxOMgf4ToK0e8mVpclpvoh7bZnKdCPlqcOuGmMuIsC
 bpfGpopBXLM9Vwz7AVUcCP7sS9AF+hJXLnkHVlDBfwyN/AzeP9ynoijCdfp/HSxinmPu
 9dCjKfTSNEFbHNPBCWR0RWpQTrmj1PcpDlyam1KdJFvT/WSZHMLrxBSxoeOzsLzTgcqJ
 Tn8NbldXtujI6iUW8gQN7UbqP2VHtPy96eKEvHT5Zx+mke4ZmY19qFU+uxTqcT+y6jGG
 vI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793913; x=1780398713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GExpfkrACNfd8AgKb7pzoxx6CS0kiv0JrtZqZXX3hVQ=;
 b=eE9/ujOB2f0JAoAS77Ri4wWt3F70cFdE2KR8FWWPntFzXMFgF2tB7EETik+MYeqnfo
 SIgbjj6NYNzNf2sjpRwSPQCjsdZjfsWRcqyPzXgoIQl0J77xXbixpH6yRccwBxk+cVEV
 Vu9vN4EkJ82LfltLLC2jnmzQH4OPHLvLI0oAdlMzLWlnfF1wbrYKNTPoIOrypNp3Fz+f
 UGpLaTmjR7qKnv9cGq8oJccPd/DD59axA4Ruzgh/6NxoKBQfpKPmZx4CRHaYy2wMe04y
 ecuhZ9IrGPUCH7u0p/RcE4Qz/5TjYckMa5m+SdGFzxlpDcmVyjKCI8rKT53AfC7hJOxC
 PFyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yGcl/ZMoHqZQhZMQrQsuq5OkOX91sQvvWnK9SwJjp7YhmNoFyIYDwUklmf5E9wJfpM4uXGICZRVc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYYnvuANaU5X2IVJtpEKZmc0eM4l/V4iyG2hICdiJNweI4iWUw
 C2mD+cdLJ6j91KabYE/mDaKSgln3OtjriwoeIwOCyfWmJkJ6so70R6Qt/+Scwy/v7equEJBBOF7
 D7O5+eF9TBvRSOsc9H63OMkU1y3XucLgjjjln2jeruC+xRvszWxg1TwpqKNm7HCNbDtWuk1o=
X-Gm-Gg: Acq92OG1HLY5zIM2AqUxIbQoyrdkZzWjE2DX2sDo1iqLWwwgEQSau+YswRRuAXOr8o8
 o5hPeEcefNvCFMGQnjlFpiXsJJRGro0NmftFnenQt9CbotH6EAwZx98NHExByKCIlLi+sCuXZXD
 0/qNDoCSYQ1lEZQS+luKFEImjF3BACtZ+M5xSV86HwHHvygBdHf1ebqkY6V3ahYCj9AfkX5RUlh
 BcA99AeCMAu4cdzv0Alxpmqhx18DzAWpGWBNQR3ODFOvAjRBqkANCVo/IdIRKlBRLK9CA+FPntW
 qphHdaOja/LXWVZ59Mf3kFqFeBcU+7cRUq35tW0672kshPDZciIo27CCxY67oA8pu/JT+coOLPp
 Wix1FU1CJTW4MQ9t74zysDuBL70tus5wnuCemD7P0ReOwTKx/0iJvie52yhYYE+fNq0grDBqpJZ
 qgXzUbjJ+4GzelINAIPg==
X-Received: by 2002:a17:90b:3f4f:b0:368:1566:1ba5 with SMTP id
 98e67ed59e1d1-36a6745c264mr18435942a91.7.1779793913029; 
 Tue, 26 May 2026 04:11:53 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4f:b0:368:1566:1ba5 with SMTP id
 98e67ed59e1d1-36a6745c264mr18435910a91.7.1779793912579; 
 Tue, 26 May 2026 04:11:52 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c4ce6bsm12104253a91.11.2026.05.26.04.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:11:52 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v6 3/5] misc: fastrpc: Fail Audio PD init when reserved memory
 is missing
Date: Tue, 26 May 2026 19:11:22 +0800
Message-Id: <20260526111124.515-4-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
References: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SHwImIqvp5Yzn0S8y0pcdEBZGM1Eo6t3
X-Proofpoint-GUID: SHwImIqvp5Yzn0S8y0pcdEBZGM1Eo6t3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfX17DY/D6JlGIt
 UGM8w+FmBRsWSwlL1ycnVSa1yKsuB4IH7nqdrT6kzDne0JVo8nfb7Wq2xY1CWFWugoVX4NoKDwi
 kQJ/bsvFPcAmLPzF0Xnq5xAv8GWSy1c0fIllbuRPN6EVFuqbtNH81I/3IooM2Ye0DCXPbwSr08S
 PsXb7Rf7F56xgeHE5TrM8hAmEtTW8z1hDmaPsNxa59MTi3tT5gKC5XG98NEiqkrZofke2dh8K4F
 6Asmr+KJMZkmI1T23LZzSS7r1V3NwHXEa5Qk4qY/yvn0OtLmcXXHGh/CBw4JG29J1u7JeWR4iPL
 PcIdxj/e0vDGSu69VtnIV0zmZImOLoRe/p/EsZmDaD+S+/0KzB/eUrFGIWuLO/LlaY1+ka732gz
 sQUSM/2fXg7N/5FXvPKgRatN/w2qzj7ajceCAGCLgKoCipHCv4Z6xwfaMhup4JsdA5OzijZyHrV
 rKlCvknZqmxLVZpDaFQ==
X-Authority-Analysis: v=2.4 cv=C9jZDwP+ c=1 sm=1 tr=0 ts=6a157ffa cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cwMOb1EeFLyGxYfGK4oA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260097
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

