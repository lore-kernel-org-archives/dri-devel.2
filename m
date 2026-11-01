Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3A606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g+Rhihmo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dcffSxgN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4FB610E32E;
	Sun,  1 Nov 2026 17:49:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F8210E20C
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:49:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HQFvI2044113
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yywh0hDJ/pj
 pr1YR/EkxrAqjq95tRwDr0CnZD4CFXzM=; b=g+RhihmoOTsgP4hvhBu5oyBIo6b
 8AT8EQk/67JJs23ySehvLA3TJk+R/kH3LjiL9jz+dysMXOc6dS50YaNIJBfygA/I
 rZd3Rfz9R0+K4MSfDzpzIyqZWjqUNqeGAQyl3enTsRxoWXksFO+BiTK623o4UwEd
 dOGRfIrgDpWn9xrQTs+UFKaCgcAr6otilS4SyVnj4LohD6G1/oNJE22BM0T0sT7L
 zBby7d6e7iiGFyHLkFcUCVO5dIxtY7RrQEfHOZW41VfmJj+VjSZnk4avZxBqRSWC
 QOf8re4XJfV+Oop58a3i+J8lq8283G7rN59kxsbVXuSPThGKGgnr402IwAQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7wxkvvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:49:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e942b1cc86so25575435ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555361; x=1794160161;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yywh0hDJ/pjpr1YR/EkxrAqjq95tRwDr0CnZD4CFXzM=;
 b=dcffSxgNnuNQGffSIIPkIuig45sijkcJ3UmTRTElLecWnW0KXN+dXJF7idRI9Yxe+K
 5XfL4FzcEFClqfI+S6WP/7p5NkeUH948XoJr5cBL37H0PWT/VrKOxxpVexJ5V3WUJ51k
 csTQ4XYAshlH2ScIsVnH1XNohrzdG9LMFMnhVSoD7RT/NcYwvCgvOb2G5g8TDucxFRM7
 QcHv1xFOEE8xwOT+3/zBgDOAS9aqwZJwjXQygC24mAlvDz9v0angxnh8AigAhyoyKolh
 Gwaed9KXnlo1OadZZ5Iv0Ruc3s2VJoKvannmMBRzfEWDWcrR9X/rmngK7chA4Cvm3i89
 Hmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555361; x=1794160161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yywh0hDJ/pjpr1YR/EkxrAqjq95tRwDr0CnZD4CFXzM=;
 b=HR2/bEtwy0J0P5+cXQgzk0BkGuj3nWmCuT8Yb49HKlEKbbrbD37zPgjLIDyD2s9YrS
 WidyBkGPvs8QoBUdcL0y8p33mkFYmIvWHAQzl/fFN5V1+BpV2dAynWDa7v6H2hpiAor2
 +sZH4cqfKkGFgGNNSBjFOXjYo8J7wvyaCieVSBoGvyXwrzcalR9ve/nBxC8h2q9amKa5
 Z/9reSx+RcnB+KECXbtpAxrNn2ymUyLUoTxTX1eM+dXn5RQrOkmkyqG8np6awKZXFcfT
 /Wt89mYDmnYIH+9P99JmpMGyq419xEgtG0jk5igK5wWwbq8HZ2ltC/EirihG6ZA5rNGc
 ADgA==
X-Gm-Message-State: APuU4Z/Sq3+ZFmTp0UmCUrGeORXvFoETZdEtcTp9bK5mrBl39tVh8YkE
 O3o7iuTFJWHUCsfj2Ow9iLhArvJ8z3agie5Sx8jdi9K/WHIo8bgrAwKkZUtw6yBUQZnN5OrssLM
 oUSWGjVeLZFmHjWSN7PeSMPg5Hno1sBcSB3tPDT+6+vy4GEKoqrM5dsgJ3L6t84/3hdRNmXIChD
 LpdnHHAw==
X-Gm-Gg: AYBFou2bVw1UijTRsWZaFXNA9qsPOF2IL8wxRhOYgREi8KVJgn/kFg+vhz5Qvjz489D
 8EDMR2GTu+R9+f+Whz/1+thNQGzn7KMDAyAL3lLtxwBP8jBJ0T5cIU4AcMSXPum9+kLao0Ej1Zy
 82wyNP/Ebchx3GznGpRl6c+QydTfz9OeTStisaVF9D/nLn4S1/gW1/KNhhVR5r4xbqkIjajvVX7
 jNXsh4hDScjSR0EFcgUYuRs4g/kr+Ev79OSW0DCfJEK2mGA5eb4uBP4bkIFRcKR5CvAwnrQBNvr
 Iwvh9P/WQr8j4BvDQde7qFFX6XURqrAAHQLOseQR2hc+HhJHzsxXXcQBFvIZ1YrmC95fdGCKrdq
 GMwHf1YimJElh6oVtVQvHi+AvluPGUQJ0CGT68cqZ+xfE+3GXL9sM0V5miFEAlagAgt6jwU+eZa
 VjGDRLTlfcToKYpN2RsQeEbco=
X-Received: by 2002:a17:903:1251:b0:2e9:8510:6aee with SMTP id
 d9443c01a7336-2eb36331b0bmr73784455ad.0.1793555361133; 
 Sun, 01 Nov 2026 09:49:21 -0800 (PST)
X-Received: by 2002:a17:903:1251:b0:2e9:8510:6aee with SMTP id
 d9443c01a7336-2eb36331b0bmr73784255ad.0.1793555360662; 
 Sun, 01 Nov 2026 09:49:20 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb09703b2asm2121905a12.19.2026.11.01.09.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:49:20 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm/gem: Fix VM_BIND range check
Date: Sun,  1 Nov 2026 09:49:09 -0800
Message-ID: <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ejxu0cQJFc0j55mPL78b59PzZwgn9R9t
X-Proofpoint-ORIG-GUID: Ejxu0cQJFc0j55mPL78b59PzZwgn9R9t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX2+oklVkvDULF
 vSMak9O/x4Pz+rNmXlnidwm43KRjtWwpbF7r8LplGHOYjXIWYaWFau7sUTxfAOmoTTPJviR4EoW
 R6AftzKwRjLuhrBvqbyLzYMs1V8y8W8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX1jqX3UZq8jXS
 a1dcfd3glplMespUVJARe5n4MwboC2MiNrISOjQGTLhTFRMqeJoIZAlgFjzm4fLZItnjx9NVpa3
 CKwgswgxVQKSFEHARpbzDyXnJvBuBKYF1MeR5Az1HVmaQzNOnxD5HLm9iNhcMRfdiuBjrHGl5Y5
 KaPm5vQRUrFBqOMfm/FsJySV/HkaCWrqh6Xac0DbrU0y+yqwWg0Qnhxv5Ur4n3tTq50Inb24gJK
 NASW6/6Zf1kBcgTFN0yh4W9r3YSQtuQ4N3CPXxOpBD75tLYyJ1Wf9v46l4f+Z+yDYQAtarPwqxR
 rmgJe1GJL5zpeI2ZVVT/k96sCU1bVjNw6RmRBLcewSQPanYp4yIlBaz44HfbhEwu/CJ3EOKd8uY
 JQbT65ee0urZtMvCWxNSixDwppsx6+22fEsXM33S9bk9ND0fiLdDXyPMSXjdL+d5zv+01vWleRQ
 djaVSUOB4E8co4WFqjw==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6ae77ba2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=IPD_lQuv09rAGqqMs-UA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010070
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

Use size_add() to guard against overflow.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f687a629629d..16b3870d5e90 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		op->obj = obj;
 		cnt++;
 
-		if ((op->range + op->obj_offset) > obj->size) {
+		if (size_add(op->range, op->obj_offset) > obj->size) {
 			ret = UERR(EINVAL, dev, "invalid range: %016llx + %016llx > %016zx\n",
 				   op->range, op->obj_offset, obj->size);
 			goto out_unlock;
-- 
2.56.0

