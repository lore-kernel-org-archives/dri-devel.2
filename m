Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A74606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WwUKLnKN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dV0lMv7i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A8B10E5D2;
	Tue, 20 Oct 2026 20:48:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28F210F7C0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtkim2278761
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2h2stUViSIN
 xP5B7dXQjREMT+lAKurPPQoFmUpl9jSw=; b=WwUKLnKNOn8wKVLRNQZsNCxIPpA
 a9W0Ab0JzUbeaylgYMX9g1dhnGA53wG10T+OmyeeMsJrVEjn+ylwD2xKFaPzuFx4
 9+TCzmZPzvYfoPCSOavfLNBYRTfzT33O4B676xiXXXvkxbXS+jKJC4ko+wNaktqO
 RvyXpwnw+0A9keCVH+LUIXKZH3AXOQoJBjPfOhZ3ce1xwUT36mjTonNXpPkdzETh
 G0G1N2T9wOpXc5lRp7QdBpq036kWmG1EQicGyVqpbpDQ4ILAJ0m8WnDCpO+C6tHw
 KvRl9dSc8CjYU6VMoIXN1aGe/blQ80x7eWa5GPnm5gdER/0Os8MC4DcjyJQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2a3tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a8ae5154e7so140536a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529276; x=1793134076;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2h2stUViSINxP5B7dXQjREMT+lAKurPPQoFmUpl9jSw=;
 b=dV0lMv7izo3S1QngrkEoG+5OHIUZq8iGdUndqSXO3kqjOFx11gp7XFNATSslHJkMUn
 PdcTHn+6qxUnhaVSnMVmZqgzPXsLna+nCmS1sam/d0IxOrJc0jhrCtixPopqDywcAeZn
 UtASLlbmc9gtEsFUOEv0A49/yF4pDIoRlCD+9vuvuM1+5xJZ8z261ikKlglmZaSzaLm5
 9pbq7s+6V7LyzdA9kv67JqhVxMvpog9cW3BrqWmpYXcpbRkyb/iQSYvx1ZJ+eU6yaWe6
 CjmTgSGZTvemB38Dua3aeUE/0rq8mszmfenRsP0GF2MhUNeVsKXl5spAcFOwGwPpGwfs
 gV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529276; x=1793134076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2h2stUViSINxP5B7dXQjREMT+lAKurPPQoFmUpl9jSw=;
 b=iLrzxeZLnOz6prZGl8n7kqZ3QWBm1PGWkEvQ443M5ZpK1wzKpREYICwDrzeQk5x4Qa
 M/vfJCZ4s4YC9bnj+vQnZyMBRk8Q3bMl8vThz1/KDCjMpq+969EI+9I3kkEj+SVZYClf
 ZoO9PSjIMb0UJL2bYCeex+cxak/T5o9rUIABtbA35oixanypkvPnR9keHwRRlDpRZkgs
 Df70v/q7G/OOtlazBEzdr1Kcj9v14RYGwqJHhe9Zj/BptQZ9a27acdZT72SSmRtwL4rN
 MWrltu+Kh8nfJpDcZMKRhO8JVQK6Cxhv7EH7sdy9lshj7rPo1k89oJZR8nQc72d3hYPt
 G9zA==
X-Gm-Message-State: AFq9FYLLSFtvfJB7FdWL72daFJSygR4Rn3H5kbVPQ+UeucH8TO7vSPLO
 N/pdQDtqeZCERRHXNiBEwFuIuZMJDDRZ9aVXSMowvkWgq0/SDVmVLbUkVtAQCzJi7NcYm5oB1BA
 Of/6NfgTcOqXRvZVPTL8uATEndMOyCQcxZqU9szD7cuGXQApRIwV51Vw4AWijcvbpgmUUkaLqIO
 Q/954=
X-Gm-Gg: AYBFou1kvNyi+XbOsQmFqMKlTkB76dHBiXrq+fiAXdOOyZtZNUrPFVh6i+aZAfQjqXl
 e/xhilaBg9utAtunHYa7nx8NCxyRAzL81CacYXjskvE+z27lreQmP+Keh4n0c0iEhFbAqPznyJ8
 iszhTjpLhCz2SG1Uh2AJtfMgt1m+tvBu40lBlMSfRCwZh/lS9L4aEgiLjNgb6LxDPCRIVVsR4oL
 PwISL4pvGt95j7uBPF2xp8ZpIs1K+1CuGeqE4uLM+sbxqJfJPt5r9NT21iFCk+FNuGUsEGaBIC+
 GVwWvaHf7sh86zNfQnZmxI03cH+KZf5xg1TamhXkllLwxA6n7AIXxJgLHocUt90glZv8RSYzGa6
 Y+oononjDHr8143oIpFHrOG/e1uQ8OpM2GOxVxN8Sjs3M6ZKL
X-Received: by 2002:a17:90b:3b4c:b0:3ac:9463:83e6 with SMTP id
 98e67ed59e1d1-3ad86cd5f36mr107548a91.10.1792529275496; 
 Tue, 20 Oct 2026 13:47:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4c:b0:3ac:9463:83e6 with SMTP id
 98e67ed59e1d1-3ad86cd5f36mr107525a91.10.1792529275060; 
 Tue, 20 Oct 2026 13:47:55 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad8021d29bsm1052180a91.4.2026.10.20.13.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:47:54 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/12] drm/msm/adreno: Fix PROTECT span length
Date: Tue, 20 Oct 2026 13:46:20 -0700
Message-ID: <20261020204728.28844-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6noJpkkt0iy9J3HLJfpVdRCuTpIsY_tk
X-Proofpoint-ORIG-GUID: 6noJpkkt0iy9J3HLJfpVdRCuTpIsY_tk
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7d37c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX+PsBb0suHs5I
 5lUciuzkvzklZJrh4Ltz2zHHvw+adAM4Ga1Ly6KwQiPmjx6QClLBoJd7QcTzcpTyI9KEOsbq4ag
 kc86femXaegQV7IpFMgcJFFj1+oqrHo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfXzCfLcm37ChYf
 Hn0gLbXX3D10i/N3IJLgCuTqUqvtYILi3XvzOWH2t9f5LNkmP7wQJXKBOOqVXuxnBRqOrexY78m
 eZTk5gsV+Kup3mpMXDlkQyBcvO1/CWfae+Mb6xvDOobtbJdp2P5YEbrot7tSX6hUDw+iFiTOM1g
 43m4MUWbG14s1STDKdg8OhCelt8PwneHxCRru8cEliE8KpsjjW1B+tv3Hc1VTqZz8BpHSwnzabF
 sFv6upUBl8RpZvAP1bhwr35aJfsycIb9InRy16AypIOC1RETX8E8PVyc9NJK147TEiPNWDv3U8I
 hFPGxcuL0hIMt4b+V7cFjTIb5SzZ3lBeGqPAmLDIwPxQGteLXihdZZvNSxz37qVXFrlQnkDesBz
 BTY4fqssI5cLAEK5yQzJ/DYuZSuu7y2QlirCjhXt2+Mh4kcb4dpdLTX5xsmNNsrk3UN4ev+WWDs
 YfiQJ6s1jW7iJLaNg1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200082
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

Don't let the length bleed into b31.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index d60cbfaa0d8e..5e1f35c83d63 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
  */
 #define A6XX_PROTECT_NORDWR(_reg, _len) \
 	((1 << 31) | \
-	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 /*
  * Same as above, but allow reads over the range. For areas of mixed use (such
@@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
  * single register
  */
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
-	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
 extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
-- 
2.56.0

