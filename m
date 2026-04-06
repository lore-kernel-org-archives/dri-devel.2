Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7ABFB5171
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6B510E2E3;
	Mon,  6 Apr 2026 22:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtOFeecX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U22dxcGy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0449710E2E2
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 22:14:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQNcu3537365
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 22:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EumurGm868mUc3WSikFqcK
 cfbgvr1fOR4UqmCi3WbQY=; b=gtOFeecX8LB9k383vAyrgqTdvzuG7StUpAFg04
 hpxfqDMZz4JaOplsmW1Qo7q0CBUo+WKhR1rahgZYyI5KVOaiQlmOV5HSsm8zj+pg
 KH7ASRXHXCxhaSH07imyu/GtBKMgYqMqnR9HaqmmXDcQhVKTMzHOyj5ALzt8buvz
 KNSH4M+5YXU5MXiAAJF9V/vRMUjXxh/hdBPJkPDp8a3oHYRh6aOsAWiF9JTt5jfP
 kNX4zzoDpd1S2CpY7HFEkHYTnZjETRE7BZlvNUV5pDa42UzXXE/aDkHE6xbopsYT
 i/dNQEGRZqmtsspGd1EKf+tdXT5ujQD8HdAdZiZB10zNdIJQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra0371-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 22:14:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso101858031cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775513689; x=1776118489;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EumurGm868mUc3WSikFqcKcfbgvr1fOR4UqmCi3WbQY=;
 b=U22dxcGyrXBTsw0fOtG5Iwyl0RRzr7OrLROnd/TOhHq0xv9vBZKGKEfYvtT5tKLPMB
 Ia/1UiMYg+qvLvynKMVLgkkeH4jDQvrkVY8HzMPYagBElut0ufdYI5eLPpC7K9aRXIEA
 A8xpKD3WnOjMrocJHWIgW1w7qVvuvLQa3XvnJDrwVbLmWSapdnFQ/1+c9lNogzn6oT6h
 JslTWxN7ud4A/qZBuR2ScCZrT/4+D7ZRvjMvSwjZhvHJOyRvAbxDPzfnXve4AcurWzaO
 P1L2XCJISDZ3zlrdjpu9MDwZIF009dbswo/UCLqh7xoh06wEC8gx56h3O6zRJKyQbh1o
 6zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775513689; x=1776118489;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EumurGm868mUc3WSikFqcKcfbgvr1fOR4UqmCi3WbQY=;
 b=HpWwwo5IjYRd1pNgXpH9HsgVdU1q671TRNJuRBoHWdIO9m301706riwgsmQ2woqOYE
 GUehypkhDkJQ4+IGB8ioH7rG0G0z/ZRWiKFJnya+bIX1M9oeCbZlhrRz9TWbAfvet0lJ
 sawd+wfcFOW3B5jYmQndoEx2Q9vaiCPKIGYdMVbux02W0Zd9XI1zSstUZyLmEZGOC+Zu
 +HP7ypSXL9pgZZr/aFWJou00UoWW+lqgJbQcUuYwpP9lFxHdLi48iWFQqPNtoIutYs8q
 aIlOzJ18HROYDXqgSqncbR9kxr3gzJWtcl2yhUh0UI+n0sDK8pm51J0fqavuS49C1Hen
 8akg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXppOu3cINJUMnhsHSX8m2Pj2klX7gGXF9LlcgVNcrATCI/xrQ3Gp2YNsFNQCeZn8nCXI0CtKWfXrA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTWcbQdFLdavE2TYFXBAzXl21Rw5cV1072+8BI9KWV547EuXS6
 odWP7X4Yh1jtVvAVh3qcqvah5Q684AcYP38hCF8ojtH3/tkAaOlQtJLlKea99NV31B5HYBcJX42
 ZWgrqp27B6jI06/5dn7/I5zoKT5kYLlQGMmoaLcRR4CIkuXmJDrFouu6oPDOa+HqP2OLJFVs=
X-Gm-Gg: AeBDiesXkRoMw31eTzaZFysz6D/a1I34o8uI6Opv6XIDSkxUl0feZ/RSkUzS8Bul70K
 kLbge1w7ovxiIRMm71JiblfjR5k/sRJQz8yQSLx7UTnBg8wZPomK0fqLXbBu2TrmAzY5NLWtywY
 NgGb8X+flD9QTL1tCKIuk1EhMGA2+w+jJlFk0elLgGB1e2T791zM7936KBYobBjOFD9plgcxdNI
 HEZsfKM/C1zpX2NE8RA6DqY0uB+KMuWWGlEltEDrwzlKBD1MXFyuw2TOFPYImRkZUyryRCvqqEj
 DGve7OT7N7ZRZ727oeU0+md70CsceTr7A6qThl0pbpLNRpaf4FnKXXersVOzZPUmS59OX8agKfQ
 MuyPFnuOlBlduCB7hC0ilRH+CSql4FHcHhODuEOG4TQmhtjR3kHOD/XPKoaEHq/Zsg8OBYwB05F
 98ncbdYhHda3dkFR0VSZfz3mDfarAEYL9JNX8=
X-Received: by 2002:ac8:5dcc:0:b0:50d:714a:327a with SMTP id
 d75a77b69052e-50d714a37eemr183759851cf.10.1775513689270; 
 Mon, 06 Apr 2026 15:14:49 -0700 (PDT)
X-Received: by 2002:ac8:5dcc:0:b0:50d:714a:327a with SMTP id
 d75a77b69052e-50d714a37eemr183759421cf.10.1775513688754; 
 Mon, 06 Apr 2026 15:14:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cc60b2sm3727087e87.38.2026.04.06.15.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 15:14:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 01:14:44 +0300
Subject: [PATCH] drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-adreno-fix-ubwc-v1-1-bb2b09450b87@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFMw1GkC/yXMywqAIBCF4VeJWTegUga9SrRQm2paWGg3iN49q
 +XH4fwXRApMEersgkA7R559gswzcKPxAyF3yaCE0qIQFZoukJ+x5xM3ezjURpW6qKQgJSG9lkB
 p+4pN+ztudiK3vhm47wcZ1uhUcwAAAA==
X-Change-ID: 20260407-adreno-fix-ubwc-6a2564710e21
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iOwuvALQIxMbLYv7A9rd+WY0kqRMtLoK0llPgfx8U1s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp1DBVMGuNvEWzn24DV3+IqffS84tw+zeK0/bjp
 MPQSyKN/d2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadQwVQAKCRCLPIo+Aiko
 1XYaB/0f7EZ0LEcOnLO+p250YjjW58iR2HHQkFHfm2HaRzfPcYArqZKuit0fMJQEeix/B3FrWuF
 pC0Hg12DreYcAsqcDt0+AModK9M2hcgMDsx0i1eh2HNNj8mBzS/mRAmSRaIlKvvQNSWZIRNAHa2
 U0z4c71wfCW4v7vdmQ1h5lNqupCk+8+pPomMalg0lybWESOzHd1mPOMg1hRcciukKtLCY7lQd9X
 2v/I2+d9H9BI+jehSC9I506XK4VhrZCti4K1WsdW9ZUYr6x1QckGyTakbt/rHjlOIEBZntehDI0
 YtHkzrd7CEgQICkAP+ny20d7gdNsUuC0rlGvFnj5rpM6fnVA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: g4KvbPb3B_QqUNMxuuO0GtNsIkg03a2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIxOCBTYWx0ZWRfX7Rvm9CYYh3wJ
 qycj3BqeevEMQKfHf/EnIZbXfIjRMa0zMxYl76IQw1IXiFaGbp2uQL4GeIjhi/GgggK9woJJgcK
 xbpsvPUqGVa/MHaJF8zxbwLjMqAYAX1ynaUSfO/rqFM3EnPxF3qcXEagoaCLYu9QJ0iD97TwMtd
 HGzlKpuQBLkvIR7ZwNGuvhrX9l+YsnHcDvl8agNAjx1vanQv39UQ/bziyNm1D67QroHskFdpl6N
 xm1QCxJCmR9he7KAeD2DlP7zP2QNZaATUrgiROUs24Oyza9irHe0E7i44Z8GGbLOlqJ+fKdapwN
 JyRzR5R2vMXe+0emIeD8niegyrNKLY0SBlcc7zugMyulXiPhD7f/HKbahZHxc34he9S9pJWXdFL
 I9DYbhi4gQPLJe3T5bflZddpjS/ulpek/xT7PLCcNXgQ0gu6N0OLZL6NEOEjFTURSm3JdjKdCFc
 A94lB/iENXa+W7RdjWg==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4305a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=5ICTkH4HVDsf0thFk5wA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: g4KvbPb3B_QqUNMxuuO0GtNsIkg03a2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604060218
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

Before a5xx Adreno driver will not try fetching UBWC params (because
those generations didn't support UBWC anyway), however it's still
possible to query UBWC-related params from the userspace, triggering
possible NULL pointer dereference. Check for UBWC config in
adreno_get_param() and return sane defaults if there is none.

Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config struct")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d5fe6f6f0dec..7dc95c0a17f7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -426,16 +426,25 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = vm->mm_range;
 		return 0;
 	case MSM_PARAM_HIGHEST_BANK_BIT:
-		*value = adreno_gpu->ubwc_config->highest_bank_bit;
+		if (!adreno_gpu->ubwc_config)
+			*value = 13;
+		else
+			*value = adreno_gpu->ubwc_config->highest_bank_bit;
 		return 0;
 	case MSM_PARAM_RAYTRACING:
 		*value = adreno_gpu->has_ray_tracing;
 		return 0;
 	case MSM_PARAM_UBWC_SWIZZLE:
-		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
+		if (!adreno_gpu->ubwc_config)
+			*value = 0;
+		else
+			*value = adreno_gpu->ubwc_config->ubwc_swizzle;
 		return 0;
 	case MSM_PARAM_MACROTILE_MODE:
-		*value = adreno_gpu->ubwc_config->macrotile_mode;
+		if (!adreno_gpu->ubwc_config)
+			*value = 0;
+		else
+			*value = adreno_gpu->ubwc_config->macrotile_mode;
 		return 0;
 	case MSM_PARAM_UCHE_TRAP_BASE:
 		*value = adreno_gpu->uche_trap_base;

---
base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
change-id: 20260407-adreno-fix-ubwc-6a2564710e21

Best regards,
--  
With best wishes
Dmitry

