Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72F606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Em7RNhvu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PAiUTZok
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0B210E697;
	Fri, 23 Oct 2026 15:33:07 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6F810E63D
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6reR1492220
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=kDlqVW0McES5V3a/+nyRYC
 xkrvMkRIcQh+e7PBBpZos=; b=Em7RNhvupOZAMXGTj+n77Rq5sGycH0GWO06z4f
 cWLMU0gv4M0dMe6VVSqme5Aky/ZcZpS4AktwuVnxMZ9ZEFarNRdACYG6K4U3Va7X
 rAGmxH1dxdYEHIkI3nQAr6quSHzjm+K7fbKdcGZ4qntbzFRBO64ThLXehvuVD2VA
 GkDQcJzHr0z3TtfG/yaQyKEBJ66l4yyIhSH8dZ1DmRVwS0Y+yhtPvyxkIDmL3iPR
 v/X3kis3aw3oHESVHSgwR5AFpVU9ycSULtvQ7Md44INitmWIVFqoI6BVI/K514y1
 em3yG9LxuFvz+XA3A7R9sx8emzZpE+Ssi/VAoRrJbe4vfqQg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmausac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:44 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc099197b9so909637137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769504; x=1793374304;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kDlqVW0McES5V3a/+nyRYCxkrvMkRIcQh+e7PBBpZos=;
 b=PAiUTZokGq4zideCZD3PQW+oZCA/qpLMHKqn9S/opxmdAcAfODRGuLPwfcyaA0gzMc
 KcL5Npcfd655En1mTH/6YbkQexlnoJnkOmu53qNAN3a8PO2wvGwbbZk+vENd7NjY3gKn
 8xbpTIqaSiTSAaAn2XKFJJUzzbrYFIS255IpyIXhAfwrXjsz0abqbWtDNrxKEuK7L5l9
 /1kuyLOX199y4SZ1nu7g7x/hYobTAyUBRyCiMxBW0f26wZjSKYw67Iw6knd49sLMwrw4
 uSFHosaugtwWVAfhjNhCRsq9psSiIMYkHAtNm2TO/hggH1YsGX90LiCsf7hMZzTkZYOX
 g0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769504; x=1793374304;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kDlqVW0McES5V3a/+nyRYCxkrvMkRIcQh+e7PBBpZos=;
 b=Z+UkVjKBjZzRs5fV24V/WhfdwTYiSqdILSj+gvKDQ83kYZiaDmHC1lEJwjnuUJRJok
 EPSxwsa18ngwN+77rBu9WTM2SO3ATRyPrJz9HLA8iVwANm92W7SbcKGMExbEgi1xkgyi
 BalH+1jifyySwsrUPN2FRQcLrxNaXfAu+KBEkRMbtv9O+bMlHHRjA29Vfe8MLBVN6zJd
 y8pkys4JZJio2yemC5Be98scXC0TVDhCMIZNP3V8FRxSByI/ONExN3sWJLMNvvk2mtPj
 Od1souJk8yBneK0E8dHsJR/T9U9sF4gnHZWDQaCPFovqGP/jiVHiPFe2F4DWj8UDIor0
 PVJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKF2Rkpmig+stw56U3sECLtqaDqjS2hg4hxVxWbahWSE+U/RCzrPRuHYhhv6z8RTErWqBXSqFgzKo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/ejnxoJtGR56dDJfOC7bLscClmbdu7fYw6b4NS6oX40v/ESad
 U/6mI0Gxnct4BRfGiH3WiVQJu1lFjIHA0J099d4Yt7z6WSLuSdlbXE74MEQOwVd+l8N8R7FFlm+
 6y/DkY+k36pjmSYXqE9aH5REw8T7RJHI0qEcKuCu9jR9/DtPifmSHmsRjxvnKMl8AymxQVGo=
X-Gm-Gg: AYBFou0UQTkHUeKsyBHvnD+LoOC47P2heKB7zv7PhO6x4kmgGeGOw2/3CNTlA2graKE
 huNnORdGDEoV2uDzmKY6igqSD/WpllhtB+eTMlYB00qq9OlbAOFrbu6eMlrQ4OkWRahJ+JYbve3
 3grYk6RqguM9KP85CMsPft1IZGY95Zt6mE41UkyzlG1aYPYcSCUu1UiylC3NNKKvVqq2LZK/dTY
 7maB3UTnomMno2n5U5jxbT6lBJvNsGVRwubWTzu9ruDCww4ikxGLbufKiVr1CHv7bsdtusecFkT
 bUI9sTSMpe8kgJa+eBdJZ4dsFRwCJPIKCSunJPNO+ADBjhigyyCBlPkItu+zcJv29XDnkVng99C
 a+1KhtIOJoOs7sgweKsOU2c6NiyjhSEUxHJEiQLmBDeTGpTTmbG8lYnchrRH0LABGqxo12VEI+o
 +Nf2kjNuf47EVk
X-Received: by 2002:a05:6102:3fa1:b0:7cc:56a:58d2 with SMTP id
 ada2fe7eead31-7ccc3355b61mr1118694137.31.1792769503735; 
 Fri, 23 Oct 2026 08:31:43 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa1:b0:7cc:56a:58d2 with SMTP id
 ada2fe7eead31-7ccc3355b61mr1118674137.31.1792769503096; 
 Fri, 23 Oct 2026 08:31:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 00/14] drm/msm: fix the error handling of the KMS init
Date: Fri, 23 Oct 2026 18:31:15 +0300
Message-Id: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMN922oC/3WNQQ6CMBBFr0K6dsjQGhBX3sOwoHSQqqXaASIh3
 N2CazeTvMz//y2CKVhicU4WEWiybH0fQR4S0XR1fyOwJrKQKHMsFYJjBw/HYIiH4Gdo7YcYsMW
 jzowq9UmJ2H0F2h+xeq1+zKO+UzNsY1uiszz4MO/iKdtyuyNDVH8cUwYIhLnUhampKNqLZ07fY
 /1svHNpPKJa1/ULSf8PyNMAAAA=
X-Change-ID: 20260930-msm-kms-destroy-fixes-0f04b1d39b83
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5493;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=M57gplkG0ukSxOkKtxGJllo7AI+MFjzExO5iAjYAzzI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233JNZ06M0UW3zkKIvHjcFm/9braXahFmAvgZ
 uDUZbWa27CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt9yQAKCRCLPIo+Aiko
 1etnCAC0H5DhqB4biySXjyXXEIO/R9vuQ1xdKIgFrGzYHtyNtj10lc8t0q7F/qSRplazmqbU7tn
 FnfpyONSvB0rKR37xuPoCcHe1zCPd5KU0KpA7h7Z8lbqJLbCMsNnt6c9PE1XHJ/2+WegRFNEL+H
 jx8pztjMsEFUbwuC06T8PKUeuV0uoQ4zMAUJP6AUDseNaHwd9wuB5TbPRyGAfzW5cCv1A8cZPay
 q1l8WdNMULe1kBYFwo9Qx7eL21EoYul5+FhAz7tSMIKWdSzPqMq06zefPRcp60s6Dh/aTyXRwB9
 xLuxZGSQb3bM6Ym2tUkITWUGA+kYqCZCJRly3+x7t6lsRLiz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb7de1 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=SeckFaocyGfTZ33SJHoA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX/iRRbCZbGMUG
 lfWGGsvGqiHeotICjhCBJekdml/uqsVAB44g9mWYYQce2kHnuaQchti2FSoG3jPhs1MgrS9Oof2
 7UmyL3hrvZXOJ8XGJNBprTPgCqGvWaY=
X-Proofpoint-GUID: B7hp599LxHQLu4Npx0F9z3bkOOGEvbov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXxZ/9W0OuQHDF
 C4LU5Z4CI5oChpjUAPnGNAn8Pz8CTgES/cUPxt30SYKLg5Mmea/YzJkKuTUivPuB8IPNH44H7de
 Dq5nvA5pkAFg5zlsc+yjbVDHenpStRTWM+GMazM8+Onc5zTYAP2/TeMTn5Np3QzZzxvth/9cdKa
 ymbBC3M6W3MaqhVBypxNhL6C4DTb0jRwPfM7OoYvh9+hqvqRlDAbgqi4Qf9nloNb1E3jeo8TyLX
 37S5lsSPkkSLtluzuGgrCixAexsyhME0JMPxd4Cz+44xrM2p43X0r1q+U+N8RRkQwk/Zk+eGxGt
 tHOTM9UlE9zlPg2k50ErsUcqb0nxZw2QPDE6yPYHFv15CwfTEdGNEk14R4SuETn9oUU5Y3jblZp
 5OU/qBQYxtxEBH2R21jkNSwwS4EoCSfWeIp7NRrubM3PXNRHsTEuFY3p5RVelEuwK4YYjgUT/gb
 xToM2cc4kv8P7t4glrw==
X-Proofpoint-ORIG-GUID: B7hp599LxHQLu4Npx0F9z3bkOOGEvbov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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
   create its worker;

 - the IOMMU fault handler and the DPU interrupts can queue a display
   snapshot on its worker after it has been destroyed, or against a KMS
   which is still being set up;

 - the MDP5 driver appends its hardware blocks to the arrays in
   mdp5_kms on every bind and overflows them on the next bind;

 - the DPU never cleans up its self-refresh helpers, whose delayed work
   then commits to a KMS which has been torn down.

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
converted. The last patches fix the teardown of the DPU self-refresh
helpers and follow up on the new rules: they unwind the DPU hardware
setup step by step, disable the MDP4 vdd regulator on teardown, and drop
the runtime PM flags which ->destroy() no longer needs.

Tested on DB820c (MSM8996) with both the MDP5 and the DPU drivers, with
failures injected into the msm_kms_init(), the MDP5 kms_init(), the DPU
hardware setup and after a successful kms_init(): each of them now fails
the bind cleanly, without warnings, and a later bind attempt succeeds.
Unbinding and rebinding the driver works as well, except that with MDP5
the HDMI output does not come back after a rebind (its extp clock fails
to enable), which is not affected by this series. MDP4 is build-tested
only.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Added patches which register the KMS fault handler late, reset the
  MDP5 hardware block counts and clean up the DPU self-refresh helpers
- The unwind of dpu_kms_hw_init() now clears the drmm-allocated hw block
  pointers, dpu_kms outlives them into the next bind (Sashiko)
- kms->vm, kms->wq and the timer workers are cleared on teardown too
- Moved the MDP5 counts fix to the front, merged the error exits of
  msm_drm_init(), clarified the fault handler and self-refresh commit
  messages
- Link to v1: https://patch.msgid.link/20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com

---
Dmitry Baryshkov (14):
      drm/msm: fail the snapshot init when its worker cannot be created
      drm/msm/mdp5: forget the hardware blocks of a previous bind
      drm/msm: unwind msm_drm_kms_init() on failure
      drm/msm: order the display snapshot sources around its worker
      drm/msm: clean up after a failed msm_kms_init()
      drm/msm: let the kms drivers clean up a failed kms_init()
      drm/msm/mdp5: unwind a failed mdp5_kms_init()
      drm/msm/mdp4: unwind a failed mdp4_kms_init()
      drm/msm/dpu: don't tear down a failed hw_init twice
      drm/msm: tear down only a successfully initialised KMS
      drm/msm/dpu: clean up the self-refresh helpers on teardown
      drm/msm/dpu: unwind a failed dpu_kms_hw_init() step by step
      drm/msm/mdp4: disable the vdd regulator on teardown
      drm/msm: drop the runtime PM flags from the KMS teardown

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c      | 73 ++++++++++++++++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h      |  1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c     | 68 ++++++++++++++++----------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h     |  2 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c     | 52 ++++++++++++--------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h     |  2 -
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 12 ++++-
 drivers/gpu/drm/msm/msm_atomic.c             |  1 +
 drivers/gpu/drm/msm/msm_drv.c                | 29 +++++++----
 drivers/gpu/drm/msm/msm_kms.c                | 55 +++++++++++----------
 drivers/gpu/drm/msm/msm_kms.h                | 19 +++++---
 11 files changed, 190 insertions(+), 124 deletions(-)
---
base-commit: 5e4a3f7b262060d70cfdc7889cfe0f4aba9ea3fc
change-id: 20260930-msm-kms-destroy-fixes-0f04b1d39b83

Best regards,
--  
With best wishes
Dmitry

