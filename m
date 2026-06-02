Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889F0CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F1410EC88;
	Tue,  2 Jun 2026 07:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BclFUBCe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ntbabj4h";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3123110EC88
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:18:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525toP31855124
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 07:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WnPeFnYm50V
 ptjiqnHaSpsB7Y9ad0zWN9mmwwejDdiY=; b=BclFUBCe/mC3OuKmi3W8oL9f8HL
 0bcGGnYFr9FfcI5KYrAuRnaZtPGKsFQ1zbs1mzMEsL1exYMo0S3NjTJ8bOz9UmeG
 w8dW/CYzDXllrJW7PJ893yr3esHyS50hDlUGzIScvb/WuQcp0BrkmwZozx1YaMdl
 UXnD5srtkiung+7KCIO2wej0djx9UZoi98rPN12+8nXmHBmdA4v8IEsKA1hVTo2g
 5kqFsIGtcl+IO88yyg3+kuStmGB7eJ6agbYp4zu5nfJ2bt2dL310dbixNC1mbekU
 Qjz7Qe3tc42nXdfAh15SLYaMiy4Ih2ZpWbclLmQgbjUai60uSPPubJp1sPQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf78aad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 07:18:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf08c2a24bso53754235ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780384684; x=1780989484;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnPeFnYm50VptjiqnHaSpsB7Y9ad0zWN9mmwwejDdiY=;
 b=Ntbabj4hFQZmKu3rofRPOyKZBIdppzefDYl6msqdd+71JnnBw86Ucru8L2UA8+KtOZ
 v36qy9LaqkAVFSMy4Aojo4p6t9vwcytP1B7O8UgLaAMZs0VK6fbqmTGuMs0LtCNB+QNt
 gZLJALXFKAtdploBKaBNBqKfi8HdKLCV0gtf63fO6pP7+vT8AJnmmXCEg/tw0me143bT
 C77+MXavRhn0TKvVfuBWwA4DHEcY3VdrmCML9dCxngAL1no86dyqq1Br33bgKE4sNNZx
 PADghiDeunfPln2+waDAV34L7wQkSxc4z5MdGXgZQcWswcyIMNGV/+8M4QkSTAqRbAo1
 7DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384684; x=1780989484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WnPeFnYm50VptjiqnHaSpsB7Y9ad0zWN9mmwwejDdiY=;
 b=XcWGRNm17IWIk5KO2Z/pExBi1SwOJuA+0n4zrbp93urthYADrEaVaMU2jBGaVmEX5I
 KyQPf0xHeMiwWP4UoVIl1a6+G/tPNa72xGAO5iHF9YrmRV/yEg3Q7wjnZQ4lBOnx7AMc
 LBeyzTF/BTZtxLZEK+932HoHtmuZsFkz9sb0FnVIbvQcaRzFN77z3LmqxVKephudRVKD
 vxWnb3lFB5zFZwFD/bM2mGK4ek2nWNUrYRxwUDddr8h9ad2L7SgcGshiaUyZinzSyArl
 cUBFT+gOhqieE3Fd/G6HXYYB9OGSVqmMtSkGtBH75DktNuXfvqtid4wTe3L1XAXB5/bR
 +A1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ayt3hKFxjYC+vyyp1u7r1OlAzh130ub/f1RmfRjIDHAPMft5Oqy8vWaxmuvjum+Hgu3AFHZzm8a8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUM96DAtNe15QUze0w0aV5K/YflrBH4qFGZmry4S9HNV8cUWX4
 Hc3c6tPDoSERjmVvUmCgThkQAQkLqmdwy8yISLClhqZubjRoGf5/XYtHYydVdXNrPu0JjTdxYX6
 SP8PqoQX2Yemb3xikNkl5dp4nVoih/OTl9qQ+y0IyPaYgxgXVx0nPQRoQl8cxClquFICVJdU=
X-Gm-Gg: Acq92OF8neEPazCXfQs9B5lUUHaTUNzLtca3n0UPO7w2zR6cHiFRpVC0d1+fC8PSZuV
 bkWfVmP6YCsT/ZZAB5jbI5HF0FrBKlQjpSz2GBUSU10YEGvH004bGRmbfA8P3WdM1vn95nysJp6
 mlXN3LqzGg0607f+pMsOwtDnDTnEMzD1N5rqTNcIC6Tqxu78QaBk5i4qlPd8g9iHB7xp7CLXiEC
 r82SQiG/GVT0CbH9L1Jz28nQLGULDHVt7IpDxFOB2yaHf+w9yNLehwK+YW1YZCuAuZ0LlgAvyHX
 WVYD8pNAxZq6DisyknP3r2ezSj+qpDlj4Pkqu+6dRzjrzUVeHY9SQKrNjlpfrDfaVe3Y9NLUc7R
 VOTf0g+iqaQvcySALEWjwYohoTmBxpvg5vs5OJGePIf98WXo9Liv7mN8hEgNYAe3eDXDxfcJNpz
 QTvFb8iiBfzl3QpV1T/umw9sK/4YqRJg==
X-Received: by 2002:a17:90b:2686:b0:369:e217:d110 with SMTP id
 98e67ed59e1d1-36c684a9270mr14226554a91.27.1780384684102; 
 Tue, 02 Jun 2026 00:18:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2686:b0:369:e217:d110 with SMTP id
 98e67ed59e1d1-36c684a9270mr14226519a91.27.1780384683602; 
 Tue, 02 Jun 2026 00:18:03 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd91c9991sm1766279a91.7.2026.06.02.00.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:18:03 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable@kernel.org, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v7 1/5] misc: fastrpc: Fix initial memory allocation for Audio
 PD memory pool
Date: Tue,  2 Jun 2026 15:17:46 +0800
Message-Id: <20260602071750.526-2-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WKRPmHsR c=1 sm=1 tr=0 ts=6a1e83ac cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Rm9GPb-2FwNFOyaWfJMA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 2ibbdJcdS0095AcnR0QPrM-v-A-Hj_Io
X-Proofpoint-ORIG-GUID: 2ibbdJcdS0095AcnR0QPrM-v-A-Hj_Io
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfXz+M1hltWs4+5
 xg9givXQ2EROKgik/be5jHhHLIHl2IUVDs0a56F672XafwZc9iCGnZsKwVyOhjhd9H0Q+8k16fa
 aQdSJymAKdX+nImkjWuU6lOJIW+q1pfFcORww8YJBFHxCj4D6/kCzpcDKdSObajfEjfemTaUFuQ
 bernrTUzZGoJSQpu8QE+E+HQmvo3ipkQfung6183+Jsex/srW4J9E6a6kXyRWR9xA+I/4m44TXn
 s8jRsyeqMY8Rin48xQ9ZoqiyTrR95Qr0MIXbOiKBzMwwq0a/azyTQmO5YiLJ1DvnpOsSgf2e4Oz
 NDDTgp4l7W+tT+ty/l+9yMo/u92jKFoXfQEDCOcAxPH3Hb4sJiEr0ZcXBYSGr2B0eTo3QGCUlMB
 HDO+51De8YxizXRaCC3890pv3Yd9YGeIw87NDjGFLT9uJb7A1kBDOEitUpqLC96aCKX9OzGn+5P
 iYRl9JOivD2vN4JVoYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

The initial buffer allocated for the Audio PD memory pool is never added
to the pool because pageslen is set to 0. As a result, the buffer is not
registered with Audio PD and is never used, causing a memory leak. Audio
PD immediately falls back to allocating memory from the remote heap since
the pool starts out empty.

Fix this by setting pageslen to 1 so that the initially allocated buffer
is correctly registered and becomes part of the Audio PD memory pool.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5524354f3ccc..80a636962357 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1373,7 +1373,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		err = PTR_ERR(name);
 		goto err;
 	}
-
+	inbuf.client_id = fl->client_id;
+	inbuf.namelen = init.namelen;
+	inbuf.pageslen = 0;
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
@@ -1396,12 +1398,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 				goto err_map;
 			}
 			scm_done = true;
+			inbuf.pageslen = 1;
 		}
 	}
 
-	inbuf.client_id = fl->client_id;
-	inbuf.namelen = init.namelen;
-	inbuf.pageslen = 0;
 	fl->pd = USER_PD;
 
 	args[0].ptr = (u64)(uintptr_t)&inbuf;
-- 
2.43.0

