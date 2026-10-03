Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F6CCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C5810E6FE;
	Sat,  3 Oct 2026 00:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d84gb3nL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVcEsiyY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EECE10E6F2
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne2sZ1503811
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6I+4tIDQ+8/sqCH9j4z8H5
 jdVNNAL5C2YjWEtdn/+rk=; b=d84gb3nLh7RyFzY18RBY9hRmmdhYrhAEBFZLe8
 Q1QhBphkwsu9q3rWol+3Zvt//4zcrlim7knGYAxnRl+Rev/Z0CBLyaqyLa9BpGjp
 EQjXC/q+deqYEeRYSmwbDbv5VlLi1mgGCD+yLvGGvxccZlfYXkC8z3NIbh7jCeav
 ZPu5wfwTkYNw2Hnssjjmn0aHAifXqIc+QoUiUiNXCXL+R8cx/SOYALKAAn2il+KU
 s8/Yvv0U+9QoiNg6rnTiSHSL5/OC57RLeuJYYZlCmfwu6MNw9s920v2PtTKFGT4a
 gULcKztyg8cigDyMS17nSyrJAfCfxiLbC9BrD/0ahDKHdmvA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2n2rrcr0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9123be39eeaso8133176d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987235; x=1791592035;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6I+4tIDQ+8/sqCH9j4z8H5jdVNNAL5C2YjWEtdn/+rk=;
 b=ZVcEsiyYVyT/EsS2lOmsaUXd4wXMYFfKeCFBIVSw9tgoCdmxzJpB9nD5s66XxRt/9L
 sxrZeKNPr5K6OiQ10idc5aNMw0uNH72bcDdbsOiZ42hBHkLiEquDStzvSwCs/6oLEx5j
 8i+eJYf0UTwvBql/HlLBfCSdPuNA23KmmvG/a2yIhwT78w6lD9zaVCEqn5q5YDXnVrVw
 PZWF8A/CbsDkg6Uf08l+Q7cdthGyjQgq+f99ZBF+3XB7SRHJILx92RUL6mv8tKHW0i9i
 b+Pip1tXyQuQfeXtM8cMqJXLhRfN3i15b+DoG98N134VUPSQoQ5hJYjMESJyEQ5dX2TP
 6Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987235; x=1791592035;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6I+4tIDQ+8/sqCH9j4z8H5jdVNNAL5C2YjWEtdn/+rk=;
 b=LNJjV9OyL0rckIxioKHwqbmYv5LEIwaqsz8FFTSxK8QQc6kIYlO4wMvjlokHTc5exD
 dopqEEVXxg/uEfd7siOOtbxhzh4a2dvN8e9O7OrgPwWKX+kCqGvp3KofzJhyAyzweXxC
 lxy9/V6L3Nl0ClMJFfMVkrSZWp2tXy9cQSSJulzjciURGIDLcmoQWy0a4MI1Vkubyihd
 ftD8C2fpjDFFgRXLy+D9SWwkK2PLhZ1oq1Rtk9W9CYMXCdYlkGx+4UiQQo4aHW5vAGFa
 MYxM1SjY9QwYQhcCjRBZYjYaPAba0CSGqRymmiSY/6YIhRCP4RChC8vyWVVnqyxxUtf3
 gjpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBynMUNo8THm/+wOYDobO3JiFJiwevgsC1tQT75PZ/bgwugh/yBRCirsWAWQ5QR6ATwM+A8RyECG/us=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ksqbrj41mtqrAuI4rsxeLrkAPDkKSVc22/rMHkvBMAuocACNmy
 TeN/x1aHYjZJWMCzJ3qksnccDeVhPRwdVp81ScwpEtU7OX7oEhsREI4NoUjeSesh1rzPRSysA0Y
 B1U7fjkvuryQeiNaXmOiCRoXkqzphPr2aw0JYV+NZfHmncAsbwNH+kU5a+4PoJgB1czq55SQ=
X-Gm-Gg: AYBFou2dFoFEYSWsQGC+fYKQ89+6wdGlmr//4p9cRfFGGEsdotpEAmbWCaA+0IRhGzE
 qJBBZSSICdTyzdTgskjuYq0qZlD6PMnzgnOvOH23DL+tCjwyLF053QUGgSHZNg1ZNitRUBbOiwA
 fhUbexoPsXCn1V/Y5XWGKKnM+TgXKFYM8G9tq4+Y6jc4URtLImYnK+yj2NimUqr48WJ90OhRdA9
 gBXpY//tFSiRrTUGwVjgd4G5whJbKCJ1EKNzpg2ixeUQs8si+iOzUM26dErY3LtN7rdQkWzOtHw
 6lV+MErDa/3i/tkAFdW2zNCdT2VhfH6zYzsrWR1J6mm+B0rp5kHQuFKwGkFQ+3QQ/pTojsCULN1
 7jOs71iyOOSjydYpJbegxHnqJtay0ha08colv0YcnlxWqSYxr0ZU6b5AT9SpK7ksQq7p+F6yCDe
 Q4Hnj5LpwMKWKG
X-Received: by 2002:a05:620a:2855:b0:93b:c350:a31e with SMTP id
 af79cd13be357-93cf19d7c43mr902504385a.38.1790987235372; 
 Fri, 02 Oct 2026 17:27:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2855:b0:93b:c350:a31e with SMTP id
 af79cd13be357-93cf19d7c43mr902500585a.38.1790987234860; 
 Fri, 02 Oct 2026 17:27:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 00/11] drm/msm: fix the error handling of the KMS init
Date: Sat, 03 Oct 2026 03:27:08 +0300
Message-Id: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1LwGoC/yXMQQqDQAyF4atI1gaiI6V6leLCcaKNMlomtiji3
 R3r8uPxvx2Ug7BClewQ+Ccq8xSRpQm072bqGcVFQ075g0pD6NXj6BUd6xLmDTtZWZE6KmzmTGm
 fBmL7CfwfYvqqb+vXDtwu1xkcxwk9hNgLeQAAAA==
X-Change-ID: 20260930-msm-kms-destroy-fixes-0f04b1d39b83
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3900;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8vBOKHWuLr/9BOjuKKDaDSg8Rie4eNeOOmctMKqw2iE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvfDIFRGGnsvtZ1Y8MrI6hNIc0fOjZ0bJdd3
 tX4wY12xCOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL3wAKCRCLPIo+Aiko
 1bBoB/9X0dEj3+Z0pCYjxTrjNGwtZm7lDy2WloyGD0DgIF5gjJasJxHB9OS8UrB0nkTgtZsC3rr
 rbzyMH36e+IEB9fvX67mBV7WMYI+wzQqOGYLf2yYsJHR265zX8VD0s8H88NYAtOGZQNNyAwitVL
 HvjgVOugSFWaexbE/lmV9ZANR6erix4H0lzYptc41bWZnRmPdFVAJXoTSUReZnJE8T1lXPaCuV2
 zIbnpaJ3fVyefXmJYscbcvNBA8B2nurbxnl/0pfhaK/SeZNHX5DXeRAugDImyn1Av6FnAAu6/1S
 MILUeJg/CVPZWWBdpUdTcIHPft7M7/U1yDAuzP5tehP+JPWx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=d/VgWhjE c=1 sm=1 tr=0 ts=6ac04be4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=w1plCvtmiwo6cpt_-wcA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: gXGms6EKWkURJA2yRe6oGr84GwjsfHlC
X-Proofpoint-GUID: gXGms6EKWkURJA2yRe6oGr84GwjsfHlC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXxDYR6vbauGxe
 GJ6coXqwDKVXMzN4xiLYaKXrFcj8CneO1jSBcYloSKlLQY2JlyvCG6rkNaDfNbncb3fMxsOaXVh
 MyS98xM28zk5f2nOmFiZ8mLGUpbBWe0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXxByc2+UeMWEu
 nW1OxdEqJD4CCwqekoUrMgqD2a8ZfFYMwNINGcUqA/BYUjnIOBeqUA9tCo5XblonkUrT3mFnEC5
 E9tc0klQ1Ci6abC2raAOP14wx1B2zJKxio429zwRFRLklQg70ncb0pVg4H+om/JqrWSBc5nVM/j
 C7mDkZLM6q7GQF2JAOwEe4DHv+gMUpfWXPhHdOmYNdaSJ+NJsi2LTtwEp9uNa9NgDMwfZ18bnIl
 XewtqpsE6MPEAZPvIZPPXFjn0ex0DASK0Tjo5MzFMEJt30x4hAsW4bqMPvCWkwWEguhNgXM9sRi
 Tb8UE5dEDMEEPuw1NIKrPyoMOHP36Zrnwfl0SpLdTjYoktVrOp30vbLWJw9LvlIyOZvD3JSXo5D
 JMVHk9JIWbXPpRE+WVGjjzjIaApC7VpmZVaOMb2KTPvPeS/utrgOlVlOpGZAc3w1fVsO31GFZvo
 1a8LEmRF11kEv4+cZ1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030001
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

When setting up the KMS fails, msm_drm_kms_init() cleans up by calling
the ->destroy() callback of the kms driver. That makes ->destroy()
responsible for tearing down a KMS in any state, from "not initialised at
all" to "fully initialised", and the drivers get it wrong in several
ways:

 - dpu_kms_hw_init() and mdp5_init() already clean up after their own
   failures, and ->destroy() then finalises the global state object a
   second time;

 - mdp4_destroy() dereferences mdp4_kms->dev, which isn't set yet when
   mdp_kms_init() fails;

 - msm_kms_init() leaves a NULL workqueue behind when it fails to
   allocate it, which msm_kms_destroy() passes to destroy_workqueue();

 - msm_drm_kms_init() hands a half initialised KMS to the full teardown
   of msm_drm_kms_uninit(), and the snapshot init ignores the failure to
   create its worker.

Most of these were pointed out by Sashiko while reviewing the "drm/msm:
fix SMMU fault dumps" series, which has been carrying the first fixes.
Rather than teaching ->destroy() about ever more partial states, this
series switches the KMS init to the usual kernel convention: every init
function undoes its own steps when it fails, and ->destroy() only ever
tears down a KMS which was initialised successfully. This reverses the
approach of commit 93c125e4ea98 ("drm/msm: don't tear down KMS twice when
KMS init fails"), which moved all of the cleanup into ->destroy().

To keep every step safe and bisectable, the drivers are converted one at
a time: a temporary flag tells msm_drm_kms_init() that a driver cleans up
its own failures, and both the flag and ->hw_init(), which gets folded
into the drivers' kms_init(), are removed once all the drivers have been
converted. The last patches are follow-ups which the new rules allow:
unwinding the DPU hardware setup step by step, disabling the MDP4 vdd
regulator on teardown, and dropping the runtime PM flags which
->destroy() no longer needs.

Tested on DB820c (MSM8996) with both the MDP5 and the DPU drivers, with
failures injected into the msm_kms_init(), the MDP5 kms_init(), the DPU
hardware setup and after a successful kms_init(): each of them now fails
the bind cleanly, without warnings. MDP4 is build-tested only.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (11):
      drm/msm: fail the snapshot init when its worker cannot be created
      drm/msm: unwind msm_drm_kms_init() on failure
      drm/msm: clean up after a failed msm_kms_init()
      drm/msm: let the kms drivers clean up a failed kms_init()
      drm/msm/mdp5: unwind a failed mdp5_kms_init()
      drm/msm/mdp4: unwind a failed mdp4_kms_init()
      drm/msm/dpu: don't tear down a failed hw_init twice
      drm/msm: tear down only a successfully initialised KMS
      drm/msm/dpu: unwind a failed dpu_kms_hw_init() step by step
      drm/msm/mdp4: disable the vdd regulator on teardown
      drm/msm: drop the runtime PM flags from the KMS teardown

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c      | 55 ++++++++++++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h      |  1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c     | 63 +++++++++++++++++-----------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h     |  2 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c     | 47 +++++++++++----------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h     |  2 -
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 12 +++++-
 drivers/gpu/drm/msm/msm_drv.c                | 27 +++++++++---
 drivers/gpu/drm/msm/msm_kms.c                | 43 ++++++++++---------
 drivers/gpu/drm/msm/msm_kms.h                | 17 +++++---
 10 files changed, 159 insertions(+), 110 deletions(-)
---
base-commit: a15fac810c76397ec9f62a6fc26c4d7ab6e238a7
change-id: 20260930-msm-kms-destroy-fixes-0f04b1d39b83

Best regards,
--  
With best wishes
Dmitry

