Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DCAFEC11B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 21:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DB010E170;
	Tue, 24 Mar 2026 21:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIZk3100";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izjdSYlz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF03B10E496
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:40:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCttF2807988
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=bdfpF/yCAOLPD8Ocb2NjP1KqYiyPEETUTSx
 GqoUqFu0=; b=hIZk3100jZEvSvQHfoD50BAdccD9YpqNR+8YajQcF/NaIVjyJvJ
 xqZTeFx8O0cql0VGThVAwP3DVwjUoQV11lFG/FPkeJGYE97fRQt2alsWMAaOfZj4
 Wt4BG+lBY6xfOlV/haIF9o0BJy9+0EbbAl42tnGXxSvjGJIrNGf5UI30DYjDaPuh
 wNA7ug1ws/wSgUTXC1w4MZPNbBuYbb4ikMy3drdGSFf7alMgPKEi8LNDL2rUNYg3
 g84nwS6/4AmmvzrItgYNLW1+ZFylaEwUF2sIKNxFsBq7LZzw7MnCDWyl+hYJ23ty
 gyK2Akp2zV8z5sLDc4r7knivXwgSwRAPZJw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3t9ej6dp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:40:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b05a3c2421so22242665ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774388439; x=1774993239;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bdfpF/yCAOLPD8Ocb2NjP1KqYiyPEETUTSxGqoUqFu0=;
 b=izjdSYlzbncN+sJhseITgWeo75LTd+9JmaABt8iWiECGCFAX9Qo7Io+Kbbkmkb/0hX
 FLAPlMGPwVB/PXii+DY/664qSF20OAfsZX0Y37OZNwz08qNRy90tK0rYcYe4eM52IC8B
 csQBJTdnTatbou9ISdAva2LzLIEYA3Vmwqu60cQ9VIEdrYKamw3al/2Y5bmrsTSbxjrC
 rei7D386KmBIKRNclTXdW8njylgPdhVA/L+EEysYq1Aeq2Q/fpFm+r8uAWcXfcyJHtla
 +oBZK6Vfv3nDQ26EeW86XtR1TmruE0zbz/+0oGRrPBv3fwu08E/3RLIkS0F9c3oLWP1D
 8t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774388439; x=1774993239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdfpF/yCAOLPD8Ocb2NjP1KqYiyPEETUTSxGqoUqFu0=;
 b=o9nuaIGj8NNRVNZo+eHPvW6t3eXxKha/QI5bmlFV7kiiofQWrzjPbsr+vWxTMtVZ31
 KAD05KwPstpt3GUY0pGWeLKzZh3WaZrAzKuyxbxWghSmdwSZDzXtLkpho3+bMDtnRqtA
 EHpzYqQ00rujeI3gYNVoVnWLZLG9e9JjQf7Fl0nMOTOI/ihz8rCCBfRakoooymcPhDTG
 J72ibk1AilHpSB89e3nQxCcwJp8oW4f2kQBMCy7RiwCYet36PLHmlkEdKf/ekUcwjYXP
 nwVocc2S+zZQzkKoy/mRn6LINbutq4L92eGqm7TZiaOrWePsFrSQ3aHEaZkoNrm3tDng
 493Q==
X-Gm-Message-State: AOJu0YyR8LZUZqR9cxN+dwEODT9pqRJGEWjSmR2+7RoYBS2anXv4lzLw
 FNV7z3n6KUKRh2N30UEfEK9DegK/ZZPygT7OPQyQ1ttRbcn/m33IEt6JSfuEn1oFAlAnA0NJvOR
 SqvEqcnevwSs8UnZrRVF4A4st3CCaYMGwP5pTr+o0YGJ0Eb08NljdnvXmWqOQxtAW67Y0NQETXX
 6LMgs=
X-Gm-Gg: ATEYQzyX0qt3DAqVFdtEDBLTez4pUsPTzAQ8sMA3uEQGBd0x1H7WApq8zSy3DYyOPiY
 5861lgg3LLf+G8JhU7HKqk9Vx1n8f3wFW8jrzM34yCYvghsZIXpwFtoAFzoIg9RmmgOWDFtVZ8a
 Wq+HcqmW4QU7aG+UggAqlXvInpVvdodaPitkK6rX+XduNMH8b9AseYbJ/JyqKEd+qhjPD6g4KdM
 aTeuwhsRo1K0FECD5SWjG+jakP0bLl0xaBwvviOqEcn1N4qaynnOZENCiutTFnEMaMpDhMK4n7T
 MEuVNgDdh9vD9+icT6C7AFN/b5Z/i2orjnQJhvake7z9sxj9zjyEkwaL0TJRNpbey/A8Oi5Gdnk
 nB951Ha+NS54Xlr/c17B2MCIyH8md4pay
X-Received: by 2002:a17:903:183:b0:2b0:62dd:3a9f with SMTP id
 d9443c01a7336-2b0b0a7504dmr11689455ad.34.1774388439396; 
 Tue, 24 Mar 2026 14:40:39 -0700 (PDT)
X-Received: by 2002:a17:903:183:b0:2b0:62dd:3a9f with SMTP id
 d9443c01a7336-2b0b0a7504dmr11689135ad.34.1774388438860; 
 Tue, 24 Mar 2026 14:40:38 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c56bsm222384605ad.57.2026.03.24.14.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 14:40:38 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Disallow foreign mapping of _NO_SHARE
Date: Tue, 24 Mar 2026 14:40:31 -0700
Message-ID: <20260324214033.1219113-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5TKM7LwfGpp-UZtnDgJoQvTLH_ut68Lq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2NyBTYWx0ZWRfX7SdO6qzklF1E
 erNJMdoUz2yPvOB0G73l7cVOZxHP6GGQFtuOspI307Ky/Kn/ZTBRsm7BaCaQSWY5U6llEk1RtL/
 azhb45gUzcv705uvU7mmcotuzhcImon7BugiJEkss/+clWlBzOAbVSSxoCbgLY24EgjBYY7itVt
 Es4UeeM7MdbzsdTdZwAjEHafuyIDw70h/rmXdAFsU6/JUGc/yFhP+/ejXXHm0Vc5UoVp++48BCD
 HF790mXu8nvy8bfTEyb3eC6Qv4ELChh28Apsv8gcyLn6ZhMaFpy6M/r0awWitoMl1jnlkKYza1z
 m91jrGDbrMx+igi65k9H6No2KTOGO5Cv4qaN4XJK7iKxXnCw9dEgxmLhVjjPBnhKGx1UnWTmjLz
 WTXfPBEZ1HKxxmhF0uke5X4VX0o6t8XfddwQxvO6cr1DrhajQFoyEuDK0lnc5SEd4cLWrKaS4rg
 kJ4RboE7U/BoSn4VNQA==
X-Authority-Analysis: v=2.4 cv=DdAaa/tW c=1 sm=1 tr=0 ts=69c304d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=h5gromtfd8Ev_kILMJ0A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 5TKM7LwfGpp-UZtnDgJoQvTLH_ut68Lq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240167
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

This restriction applies to mapping of _NO_SHARE objs in the kms vm as
well as importing/exporting BOs.  Since the DPU has it's own VM, scanout
counts as "exporting" a BO from outside of it's host VM.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1c6b0920c0d8..68a8f8f592fb 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -373,6 +373,12 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
 	struct msm_gem_vma *vma;
 	int ret;
 
+	/* _NO_SHARE objs cannot be mapped outside of their "host" vm: */
+	if ((to_msm_bo(obj)->flags & MSM_BO_NO_SHARE) &&
+	    GEM_WARN_ON(obj->resv != drm_gpuvm_resv(gpuvm))) {
+		return ERR_PTR(-EINVAL);
+	}
+
 	drm_gpuvm_resv_assert_held(&vm->base);
 
 	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
-- 
2.53.0

