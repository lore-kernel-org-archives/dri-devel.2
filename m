Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845C606A33C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NJfkeRG7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DlVQZe61
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AB810FF7C;
	Thu,  5 Nov 2026 20:41:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49C811201A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:41:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HePkJ924196
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MLNc8w9O9Js
 SERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=; b=NJfkeRG7fXXps78czwVSHql1SEz
 +yEjvlAKxpCDE4dtWezDUWS67mbjFPotDaP03r77m2BeDrikshF7d0W9leSRFaiQ
 pKuNAAaBUsXC++KU4urbgzonp9Opf7X6djvuKkR5DsSc/N6MHrxILWDb4kb53GPK
 wvcWq9yS8MlmmPifV4CkNtxFPbBpJN7Z+v7B9fXrNohpsMSnZMMkjeat6CV91uOT
 EAca5RSTbKfaKhJNg+fWamJCUQjXRgIOgzW3LuGhKV72C47tsS103kqxbC4qB5k3
 jRoqH/59NbTlfg+j9KECvFVawSLDpBWO8xJS5ynmo+RRM/OJZvTVKfJ7tFg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhktshh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:41:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so2584138a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911288; x=1794516088;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MLNc8w9O9JsSERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=;
 b=DlVQZe61esyEawn5WZP/4cZ/TsTfTBwNxAKQ6K/GbEC98lswGjsro0q9jCgwLvqzF+
 AJk3pr5EqD/SgPSU+TB1BRL+WTOrmVkB4GQjZwdgUnaEwSPhrE5xGDU1dOc/whcz5tmq
 qrCU840I2mZvJF2j8hA/5STaHOTHbqCa7gWs7F3Vf1fBT+vzgLbaH5Voxn07URN5v0El
 Qn3nm5XO/KZ2s7yi2CC7KnlRfFoOxm5F18Sjac1gOC62hCC6GuoNR9trSXMpp0LSNOLb
 LR7nyXHPvIMjOI+Brf8fMO/mGYOWtuNnWrvvku0F2Z1/7+n+ullxDZ5MByqMP9tbELWG
 kLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911288; x=1794516088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MLNc8w9O9JsSERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=;
 b=n6VeiRlvBZLjcyyB1YApo/UnXnu7W+ydlNlpgVp8LcM2lLpB4ZGK8b/bPhjzbFQ6v4
 tJmHLTo7dMo++ju5udKMa2pho2CtwjxrMdH00zSDA3ep3CaCPKkmhxzX/WMtcmL+olu2
 xA6iLE3oyzjZcCZzIauUv83m+6lk1aBnuEAxEA5XwteMEHxx960wzTEYPWOZPb/zk3Ue
 nuVQhRPxDfH0uf7rPYN6Vd5/F8ZlWVqIkZDNPmoI4FRixjKs343mOHhQqKE8N5lr/uLM
 zMJN5qCXVTzLDoYHrEd+//YJ8P6EiK+RJfRnnFuOp+djL66Ke4Qg7gyfFk1jeffrdpgy
 V32Q==
X-Gm-Message-State: APuU4Z+3H7lZspJFj4DrNvKoFKJpv9IEEi6Rd5yAphW4BtdC610LdHpe
 6+8CM6PhgevbK3abHO8mwYE/AN9HdLKzM1HyynzTYFFen4ixlgJAUjfO1OgZGeJ/X4SSICIeD52
 Xjggx35SyGx+FqjXX/TLaQPA6Gf2wu4K0jdFtMd176Fuv2am2B4g0tnhTANyMkKU1/bvUR2ZwLT
 02NhYdAg==
X-Gm-Gg: AYBFou0/7Rv9ORpDl+CnOeNyAWftygbgFt77HJ6+pP0QZJbaUWlUd9xFopx2M6ttODp
 cQ++gQcZ47q6Y79hEF8P7eAVplmEDvVvkblgp/tkBdMw56DTF4US2VlM7tVNC+4kA5+6BNP0BHB
 6N1XKm9VClS2Zt9ZDpkgCAYgcVMFWx3t9PfpHqRTDa5MDDinbCaiuBu2kbNzfPi6U7w6pwlni29
 KivgQcaT0sp9AqEUGUD9ReGFLubpfcUJNt2n1a7/5Ts5Pv952IoLqlLjWsZhYYuWUVgDBETofGZ
 NaqalpGiquY1bZhrnDE6W7UVSLPIytEsfGqhlArMnTJKwpFJFujuGz8gZvd90mSFROWjM3sp/9k
 NPVq4nIHpPy1vpSEAESK8OGJf0hXQMY2puSAI9w/EcpLvUsyK1+hhneeZXjvdd9sslVlXpscRu2
 ymmsGhGz7BtOD45OK/8IPopSZ+fT8oNzhBIKKm8LeLGifK15T/wlVXk0WNxOAg
X-Received: by 2002:a17:90b:54cc:b0:3ac:9925:72ae with SMTP id
 98e67ed59e1d1-3b0db705cedmr138271a91.31.1793911288247; 
 Thu, 05 Nov 2026 12:41:28 -0800 (PST)
X-Received: by 2002:a17:90b:54cc:b0:3ac:9925:72ae with SMTP id
 98e67ed59e1d1-3b0db705cedmr138248a91.31.1793911287831; 
 Thu, 05 Nov 2026 12:41:27 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b90def97sm4817238a91.7.2026.11.05.12.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:41:26 -0800 (PST)
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
Subject: [PATCH v6 15/15] drm/msm/adreno: Remove temporary __maybe_unused
Date: Thu,  5 Nov 2026 12:29:41 -0800
Message-ID: <20261105203057.66520-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX3NAmoDEaxrcE
 1mLk3KyBBv3Fo5iXH6Cx1wBfHBDxerTTH/2klUM+3UXtdcxHri/q8d/eDALKXCIoqeqtw2ewxOV
 8fG39OqyReo93cWpP4VYDvsgb6KCbn2RgU/XGMdGOLJz90UJ/Ig4UTZRq3XPlFb/4W4Br2t/6Pc
 gziSHUxE+qZbwfxE/ZE9hqFuG4FmM3wy0vDugkc5tPLeroHncdloBXgcgo4QdCB8uQT6EGImJCn
 kyyRhu0CvQX6F9QJHcLi+ecOmzsxnF7DdTBOSz07wz2OBDRkgZ7yqcGeRp1vIv6lBUUfIv0O7gN
 wC8jLohz5mwya1LoQEn4j3yFhfBkIuVucz142d+UDHVEn9rB6kabP5LeT/O+rds0d2Yaq19luLF
 0+rJaPuEG64+z+h5cbG8gm3NTu6e3yONu+5Hgg3U1K3dEyEzhqOiUe1LSXfolgRtRTytZuvsHQ2
 28ALtiRoJ79SypXd7zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX3HFyVp+iGlTI
 dEuvdhmCUdtK05Ty2Zh8ZlyoVeEBH4Y4uCzTBj89+/+9Tuypet+TDTZSerKd9sarEVMtsmLrnSz
 pWm6NPOTj85C7ckO205sWE5JFnv3cqU=
X-Proofpoint-ORIG-GUID: EZOofTbo6EzvhwzO0onLQwUb-z1DSF9Y
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aece9f8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: EZOofTbo6EzvhwzO0onLQwUb-z1DSF9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050082
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

