Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4A606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7stuwK+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hsi+W2p5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768C511303E;
	Fri,  6 Nov 2026 23:23:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8180A11303E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:23:29 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo8qh149043
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MLNc8w9O9Js
 SERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=; b=b7stuwK+HVYAdAW6thWiwzyjFuY
 4ltk3YWAT3xXILLdbuRx1suBodg3lw1cSkZbejWhF3QunqaV9m8nBTMrn/BFt2lA
 GiMdvgOqbFJwyLR6EI6Lc+H7Gsq0KnR/oaY9IKnSKX/vCwZcKFh59STHNUvtC50J
 +ZggkgeO6r7p32BqWaASJUEDhr/64RQTDxqdtfPkKtpM+6CMGI4PModPZ+0TfcE2
 TEES6HQrXFdv+RFhJlt/EZ03hoL+mn2hp4PTPoncsYiMEMtpuie4qqKu+oHhCn0E
 v/4hbwNCI9xyxxNPRMnksSncxqXy7gFIDepc99FFkCC1egIDN6ptJnCdBVw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyk0s0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:23:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdb061cc4dbso90825a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007408; x=1794612208;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MLNc8w9O9JsSERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=;
 b=hsi+W2p5PWSBU3jiMKK+G6j96M/+xsK7zzlu27Wxn37H3NkoQXleJ+pK/aCPD+QDDV
 LQpgoOjW7Y5fPxT5w0Un3R92XMEfIApFApDyG97JRSUg1O2jKIeCUgyK+A8PdrfbxbRI
 v9PGyPk7Gfbsuin3DStpj8IJpNBXR07yfTn7LolZhy0l2HinYHG/GKc5/GJLk4fzyKQt
 URjGvbXEXn9Kb6O/RRlqbA8IVlu1ro4EzZcFeF0IHvkjoqm4iiguJluxTq8AW5eTN7VE
 8SaQYewcZc0hELWx6XgJUZ7bU4O8Av6B2Ty6cqxTiIZdQQLV8B0fc4Q2xO+7JOZmey6+
 +0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007408; x=1794612208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MLNc8w9O9JsSERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=;
 b=0yEjeY7L4brD+AgVYeRJCVuqMzAKluqJpA1S8w20/5YLlbl9iAyJW8/sAtkx7OosFh
 htG11jXicWGaPI848DZDc/kfIVv9yJS7nCudSKgOhFIbDHyAipN4dqdqjjVwd1wJkkPV
 ilTPnQKejoNU2DA48L4CHksbReCABqI0OtXYC8QhYqu0rOzLuuI20TRvCDj3XnI3crVP
 SIq4TY1U4HBfXofIvhu3SRpO2lGFYuZvgGkIiEzeRKDCkKVkIe+mLMix9ktdEb1BaBPf
 aG0TAG3wv7D6C0D+QL/A/Wh5/Y3C6/PyfY36Ay6HsJ6wHQOBk4qhK1vxtk28XNzpSHYx
 k/5Q==
X-Gm-Message-State: APuU4Z+c/6aOjCIiZ3ypn4aAxXcek6cSo2MtkqSDNi5s7Lsb0h6MA0Xp
 kU1k5jym4ikdEa+yb3cGxAZ1Dl1mwcvuKYDy1mF3TSmCXusscbiy/V/LW2fQO84WSNywselAJcU
 wfgEFYaUYM0m5VgtJtvf3iuh7iZ5k7hX+fyByWVFp6hdx5T+SpN+QOrQODOAHa2oymKAFLaEdgQ
 I7SLzURQ==
X-Gm-Gg: AYBFou38ihebTFloYQmwJIc+YmOksKjHrrc5rQRm/8eTolxwO02OwQixxMWXU2Kde2w
 oP+AzHMZ4oEWXX7OSY3/93B7Vq1ga8X9Mg6wLumWHErGx9hlCxaGaBeZBsnh5jihi0jJ51E0NVi
 LxcJichY5GLWLL7T9T/6ocNbDeMUZRGLdST2quA6kI17/bFq7Lj3M1OGLjGdUa71igFWdQxvHbP
 BinCkwQlp97R/7vs1gQ+GaErXASZPhNH74ykgw1zHH0lTHm6DL+kWzWY5/5LaP/co8lmhzY9+b8
 fqzEeBid1KHAtmMl8juh25Md4hpr+gkIdU7iZaAwIg2JcT/Q8zzLst0ie+RA0rFITPzm2BXopuI
 Yw3APfu9fy/YJQezP5nbvpihFQ0xHBKeVaL6EMDXCjob/xX5LvNXT7lfaJg09UndaR1lbYR04jN
 wgbvBz8e+1p8iEAL4AOvmlDdalyMJQBmoMcWJHi3wZPRDs9/KctsHfNXTH2FjTWg==
X-Received: by 2002:a17:90b:3f87:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3b10637b0f9mr310976a91.28.1794007408296; 
 Fri, 06 Nov 2026 15:23:28 -0800 (PST)
X-Received: by 2002:a17:90b:3f87:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3b10637b0f9mr310966a91.28.1794007407850; 
 Fri, 06 Nov 2026 15:23:27 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0fc27e829sm855983a91.0.2026.11.06.15.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:23:27 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 15/15] drm/msm/adreno: Remove temporary __maybe_unused
Date: Fri,  6 Nov 2026 15:21:07 -0800
Message-ID: <20261106232220.47602-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4oy93ypyTMNR2QyYNMrrvskqa5jwVlev
X-Proofpoint-ORIG-GUID: 4oy93ypyTMNR2QyYNMrrvskqa5jwVlev
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX3zk6jFZUcqtN
 PUInVy4IRa82m6dTUvsbioroOHnXqMUyYC4ioZu6NHraU5h7yJ2YZlmtufYip8PLByR0teJB9R3
 rAMcw78/sVeiG/7XGxwg6rYT3VjfEC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfXyAaqGNaWzhxj
 Yt+Ua0Ht0TdYyMjWQLkKdhLc+G4soWjVZKSGjjSFpjDOywOkpCGpHr2l4SVsVs3MpQAzqoYZ/9Z
 5HoA04TVKYMfI7Ew2C9YULDccPnUEuj0vjfr3JqoPk1TgIWK2XGqk1jC7NpCG9DKiJkkAaa7AMJ
 oC3BVfxDDctRJK7xUeIZddkJqC5x3LetOllt4zMnKdOy17mOYx9wuUQEpxw5Uj8jnsY7dGe1gIC
 DQVwLSe4apbH1TC5J2vOBYTBiR5bVOoapwsC5Ew7jusSx2kSujUysQZLyDQVZazjvVQzL0fXUXp
 wtaT0AjOHd2NV31aq8csdFQWsI3WWu7ISVXdbL4c5vlKsBL4DVBpOzd3Xhmdjp5TVuidSVyMLFC
 leIoNBvZRquRCMDfr+bhKs4hWMyheHmnD6wItffAKUEdsE2VhBwwZVGZP2k1gAHRAG6dSAC/3wL
 09CZD/e8rZHWbe0ZyLg==
X-Authority-Analysis: v=2.4 cv=I5Tw19gg c=1 sm=1 tr=0 ts=6aee6170 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060093
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

Now that is unneeded.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 4c4b904a8657..c5c928c1b084 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -170,7 +170,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name __maybe_unused = {		\
+static const struct adreno_protect name = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

