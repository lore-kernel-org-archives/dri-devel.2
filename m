Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B83CDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD4010F3AA;
	Thu, 25 Jun 2026 22:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9FEKbYs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iDY3GxxU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09AAB10F3A8
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe6Ps2192044
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UhRPqBPtVcz
 hZaFi2XBpS+shrYhW3crlCtWaN/PGJnQ=; b=j9FEKbYsqGek9p/xF1e2n+le2BM
 ZuuU0Kyskzn0t3W7r9giUcqb/ZatXEkG2pASCI41rYD0YmAeu884us7ZYLPVi0aB
 xOeE+mL5eQV7l2/cGAynGCdGYV65iH9ddTIGp7p0tnELGmbFCNR8gtpetZJBkzk2
 mkYIlWHhJSpzYHn3WdE2G0YpuEKq9FW5rhvLGGtzMqxlJIdp/52pRfsckRm+ODLp
 Duvq8VheQM7gWAaO1osEpi2Ng9I9t4Vpp5pA+DfSs3OUo9w1HTvrmZIrLZRYrQwx
 /0JFA8CBqoWt/AOX7tbcUkK+hqrFd6WBqttnsFabZP4uiZads1HS5Nlnhxg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uudmeec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-845bdb194ccso255179b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426476; x=1783031276;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhRPqBPtVczhZaFi2XBpS+shrYhW3crlCtWaN/PGJnQ=;
 b=iDY3GxxUndsglb2rBL2sEqSgAeqTq0/7Qq85SumOeKzo0SoqsrzBFf3Ymny98RISYI
 sMe0F4Fis+78IlQxBj69dndAakyU2wXIUqDK9vGLzaAYGjmB6mp8BagwL39spzsqUTlO
 QPWYh5cFpMjAYVb7E5uTmIgtrfU6XmIxim2hDhOM9ZvtojYvGwo+6wkOVTqe4wJjm51H
 2f1BtRCqqEGg4Rmgd9I7IZwpDyEg7lLELstQnYuUoZwaTPwl2ckM9W2F1GoORgUj3WT5
 jJ0PUobRbkVN/pctScf0BcZ7TkAcHtEblHRgK4e8X9RdDaFUNG1z3/ElNgn+fdgyia7C
 8bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426476; x=1783031276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UhRPqBPtVczhZaFi2XBpS+shrYhW3crlCtWaN/PGJnQ=;
 b=UXIOeng6KQmMZJc29btVrG4Of6Mm3psan1wSxeMQAc2vdYboOF6dbPXV4cWddQvNxE
 Mhc/cEGdjk8r+lkuo8ATZPwebDaZriQIyEZ0IMTJhqXcoXxHrIP2hmldpvViMdktqLQD
 nbTwIHsju6jTP2Yzxg4RJEJqBm8YX2VMWotsTahBfXscP5/JXjics/ks2BHgY+9G+kiE
 t2DD/LqhF1fhf8UC5VMkAcJCAutKVd3QOeM7bs/fYMSxl4s4hOVazNA7rPqu0vpgBFiN
 rSw4bj119nJJtLo/RJcrSumP+EeZGqiTGFSwPLccUQ/03HekXzlcsSklWCw1CJhK97GG
 o1WQ==
X-Gm-Message-State: AOJu0YxFQdtRlBFyKQVo64+k8csl8a1j9T/Y1JOxeV3SiijWEEmDVELh
 TkYKAZ1hkeJDGX2M/6mRuwt9Y5Ou+KGL8HVUXwSjrt8egHB+fKuk0aTVGDM+N2IIitmpotiCCwz
 hK+d8Z3p59gZw2z9PILhBB+vqlO4fTljrOGUtQUig2u+qhXR7fHC6O2ENy4VSoBrYwHnX7a3rtj
 G3NXo=
X-Gm-Gg: AfdE7cnCrYjxo5D3j12ZgbVjFnhWOv0F103tyW0gxe0QulaW2f+FJqUuQtEKSjeo0oH
 4t7X2wd8+EuMrvuLy3qkTxFkTfxLnQiLx36x0cuNHV6LUle11zH0wIqUPEuKKLoOwaSPEWymTay
 FijkTsMPuZY2r8mq1gCZbRxhOtf35/xgJ7JQWypFUPRKRT3P3qQww1yDST/N/lViCVeqZNX8CIP
 erRG8RrVjyKI9Mk3736Yc1xI4PCx2nNRDqAEe0DuxghWJukDMik0xXPqXE4Gt49/Q8YmiL360Az
 w3QUA2nWNu76VeHnNVhybhBoC3Yks/Bey71BGkwdcMrRAVoZVKHTm/0NTZiwXPmpanYoaaduxoC
 KQqstBPUfnVxhRPRhEwASR/I205L0z/Eol2242wiTw2FNtax7ig8yvuywAQ==
X-Received: by 2002:a05:6a00:919d:b0:845:beb1:f05b with SMTP id
 d2e1a72fcca58-845beb1f4c6mr2206050b3a.45.1782426475783; 
 Thu, 25 Jun 2026 15:27:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:919d:b0:845:beb1:f05b with SMTP id
 d2e1a72fcca58-845beb1f4c6mr2206022b3a.45.1782426475388; 
 Thu, 25 Jun 2026 15:27:55 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fcc773sm5625925b3a.11.2026.06.25.15.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:27:54 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/4] drm/msm: Validate lazy VM in GEM_NEW
Date: Thu, 25 Jun 2026 15:27:42 -0700
Message-ID: <20260625222744.22254-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
References: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX8m1TatCFKed6
 ghVQMLMAqQJgz3oHnbGQ20E4C8a+KNcjPhZUkf0Nlj/wDecCHhfituKoWQsv819+P3PKbMUwJzC
 geQ1milUxkOw9yHyo2HLzemLBkLVsbc=
X-Proofpoint-ORIG-GUID: eLv_Sy1GwGzSW_sHXKYl1xasegcXplr-
X-Proofpoint-GUID: eLv_Sy1GwGzSW_sHXKYl1xasegcXplr-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX7zUs4+qxvVVk
 Eld5LPFafNrHTtqHEvhY13FydWGzNVg/q7Ehrw56lwGQgrVhQ3z0SiSatARjpp9Rf28LXpy0TTO
 i5KQ/dDWWvZ8QIaUL5npA/qAqLldLss8Am1Xczc97td7HAiP1WCS26kCeH+YAMypNT+1LLG8b2f
 cOZskUo6l2JKg/gO+45V4EPN9eoEVN3+08/sxjGQobCR5L0Jah5bWnwE68EIAa15KsDylZNCWyO
 4fvqmreXWH4ZdQperhF1mmvDjyGu2qb4R0RslghmYOanQ7BETOm5iQLU0Es3spzBhJwKGA0W/UI
 DWab37WbqeUQIMGtkvTcdTnH92F/iWcYXjmzzsTxdsTHirv1Fl0Woh6X9iVE+1GnPR+IL/jVcyZ
 ClQU6ZrUY6RO3K/Z4BbMAHSlqZj2WOKPqc0v/3dwqBeJo2xyYSFbhNg+QKLnyb954/vBbdg7PU0
 ZPeA/Ibunw4/paqteug==
X-Authority-Analysis: v=2.4 cv=HdckiCE8 c=1 sm=1 tr=0 ts=6a3dab6c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mcLY6QNbnPi337aWdgEA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
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

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index efd3d3c9a449..3ff0399c020e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1147,7 +1147,14 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 
 	if (flags & MSM_BO_NO_SHARE) {
 		struct msm_context *ctx = file->driver_priv;
-		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(ctx->vm);
+		struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
+
+		if (!vm) {
+			ret = UERR(EINVAL, dev, "not supported with shared VM");
+			goto out_put;
+		}
+
+		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(vm);
 
 		drm_gem_object_get(r_obj);
 
@@ -1157,6 +1164,7 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	ret = drm_gem_handle_create(file, obj, handle);
 
 	/* drop reference from allocate - handle holds it now */
+out_put:
 	drm_gem_object_put(obj);
 
 	return ret;
-- 
2.54.0

