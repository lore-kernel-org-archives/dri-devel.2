Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6B606A686
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fnz7BvFs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FsiQnr2j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F385B112D2D;
	Fri, 27 Nov 2026 19:45:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6C610E514
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJTQqW524996
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zVbFrdZijJJ17Cd4PBjOYe
 7BHGSlYdmG1P+3qcPUEfs=; b=fnz7BvFsGxAPE40ps7jpbPRQD2vLhzVMmdMFZ7
 WOXprvraAkxAHAeug0moTlmkCPKBZIkywUzvZI3V9gYvBFEjv/FBHylfDo5MMxFP
 WHSq6BJfSaX+7ALDyfDXc6Q68ry9nI6tKAO1i9tqOPO02qjRsLEsj0aGHj8nFBSv
 Ckvb+3V/0j2UG/v4/iCLRGkB0EJz/gNIAfmuRbcEa/NycAlN+Dy92LU+R1U86q6f
 2/mj7Rj5A2RChW2VE53b0CxAG5QzDP6uY7LllpzryXj784+OULJVCLc1SRCz1BYP
 /7HBoXsUTWVSyjcpLZtLAmgUJmF8r0NzajhNkC4yQavXKNgw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g2dr110-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f6f4fe531so1250189385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808691; x=1796413491;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zVbFrdZijJJ17Cd4PBjOYe7BHGSlYdmG1P+3qcPUEfs=;
 b=FsiQnr2jHcmf7W8RCZI/YPiw8sk3nzDQD6IVpH+6qijRm05MfbV1Vs33vcNy2MqVGy
 sazghcRDeP/Qx68V3+onV0eD4pICdlbC2TGxk1Vyx83JbxMR9cmnl0NV1cdTQQdF3Gnt
 U7VZbcSwJc80S5r6b/yeZyk2PflybkwE5Pzk580AaZLnWoFEUaA/WUsPlrCrsqRf/gP/
 XSNE62hwKlJntFQAzaTP5+F9cEPwTRq1+aTvjlVkPfdv72oKE9NyAD7z7RDzw10kONr6
 BVYkbJy19aVFAhz43o/rg5qrMs+FaL64dgMDuQEr+25PMnO7QVaAklSSRnb/ltw7rEmD
 QPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808691; x=1796413491;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zVbFrdZijJJ17Cd4PBjOYe7BHGSlYdmG1P+3qcPUEfs=;
 b=EmM8lAFlM9cxY75DIuXqtr0sHlTI23DN6GxdzhrFPd/5ojhPoiY8fJ9HzvfZs3vkIt
 gQ3StLzo5kih4QU0wDeOY5f6hOUpoL0/Yqm4mewX87NBinC3zLXM1p8IkoovDTqFByL7
 Bqqp4locD4BJAsiXWfsJ7lxrk+n2SWEAfKHMaaJ1ZAdGJdDRW6ig1BoyU9nPBxkS4VUd
 ksDHsAtnUV26DNIhecG6Lsy/z+zq1sYRw/G9u9CkcxhIVb8cySLwAEqHajY3zyhcnsCo
 0NHkgK3JiAQQDCMcztjaVpzH2FJJJqE1U78BehIG+7tnEBFAuTyr8YegxVFKCZFDKaJX
 x75w==
X-Forwarded-Encrypted: i=1;
 AL+hErE1iEpT7T9kCvCNYJ7P9M2bjMpjLXrUa8wc5OxzgSPSMypGuYrPxY76w89QUUmn4Gut90394VPWkZY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z97NY9U3tOXMWQM94OMV5072wH5tEqQOZ9fnkQrAtD1qMrW2uXF
 C8QcUDLOIX1Y69SEbfnBfGfUdy52tAsJ9d4l4CKxW3a+rusF4bO0JhEMu/IkBKCsIIIq2PYj/+d
 mkmAALR8zYpMEBFbajHvi6bCkuzVf9NBlHRK5J8Af+GC26sqlb4e5EaRJYt7yyqMSbvc0wao=
X-Gm-Gg: AZFdTZfXtOt2qB8J4CBpJj93su8CuDEPwZHIogLv1ezEfteB/LPVzcwfTk3LBoacBUz
 cc7Fgsd5oUm/FCsOfbStKM1fEhJ5GQXkUfYJ4Ibb19T4P9Pyvbt7N2PEy9RyZi4HvG/gCtvBp/K
 L6vKuAuQhL0DGveyJKsH9/Zy262R1/jCv8s5N76JBRO1b7Rq944dqj/U6KzzWi7FFFmZVedtvoo
 aYX78N9Sjlr9hF01upc7QW4C04mLNo8GYejuYOH+4QDAnVXQy5K03N/xvjRGPqX/9mgwToLEBZd
 Lm/qtyq3jypborgqYxZRIRYyvljQGUjfYIu2hdTmgNyTMHCkS+kjAzOmHGR+tT6NGu5YS1f6567
 OxWoRovPqB07/UsZqah05BHNBLibHeUxeRuBZx0GRTkeoceoR+/ADvTEItiphQJmeNavI3Yw0m7
 t3AXcxspxtvfZcPVp5NIYC2vcodeczHPDqVa1dNvGt+93wIwEiCVfq4mkRuSZz4A==
X-Received: by 2002:a05:620a:17ab:b0:949:7f50:29d7 with SMTP id
 af79cd13be357-949ba9555cdmr4524737685a.25.1795808691180; 
 Fri, 27 Nov 2026 11:44:51 -0800 (PST)
X-Received: by 2002:a05:620a:17ab:b0:949:7f50:29d7 with SMTP id
 af79cd13be357-949ba9555cdmr4524731785a.25.1795808690647; 
 Fri, 27 Nov 2026 11:44:50 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:44:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 00/14] drm/msm: fix the error handling of the KMS init
Date: Fri, 27 Nov 2026 21:44:13 +0200
Message-Id: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3dCWsC/3XNMQ7CMAwF0KugzAQ5TmmAiXsghrRxIUAIxKUCo
 d6dtCwMdLH0Zfv9t2BKnlhsZm+RqPPs4zWHYj4T9dFeDyS9y1kgYAlrDTJwkOfA0hG3Kb5k45/
 EEhooKuX0ulppkX9vicZFft3tv5kf1YnqdsCGi6PnNqbXWNyp4W7sUAB6oqNTEiRBiZVxloxpt
 pF5cX/YSx1DWOQhhqoOfzCcxDBjK23Q1ArRkZnA9C9WTGE6Y2VpNSgEuyT7B+v7/gO+geUFbQE
 AAA==
X-Change-ID: 20260930-msm-kms-destroy-fixes-0f04b1d39b83
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6722;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HQ6M5C+Vc65ymJthbzS2F9tF7DbwzzWqAh1l6pyd0bs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2R/ioR3yjiiZa7aqcgMfq1dnIMzoIo8VVwz
 9cn3LqYt0SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndkQAKCRCLPIo+Aiko
 1ZKdB/4g6h+nm/DHyyS66I52Br8hOQdazzkdNt4IG23U9f3snkrloUcl7kaf4fx/FxPwy1rY/Oi
 e/fgklu4CBSjRAwNkJmoq96oKIe6s1ikVqOGX5efON00FVBH0AWamXgteHcA7mDYQssPQTayslX
 REaBHU0DbJ+GJIcRodzNBCBTJSfTaOt/XwsfoiDMhSmPTy1+FrU+dgMgaLqB8e7TaZX1RykDEMm
 arG7Le0pglfL7im9/GUQDf0lVm7hn1laEeRulf4UDweAJdqgF7SniMUpGuRmJQC86VWb8oakhgT
 iL4FiwqWk/NGRLUH7pm2Kk8nCaL3Hxn53qtG1klgnGK8nmZC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX0OHFvlOSNHOA
 9wWsqEpoqge9d+IRgkVcUMByMvAXdivUOfO8pz8sJiK/vlwRRKAHM1WH12wzItgAdI7evrV2gL4
 Lk6LCDxGZM/wcmhCTpOBsLVlHa7UWQvKl5WlECWIEOMcauBNd7RHZkBDPg76v1HqHJkEZH23i1I
 NzlZljAPIOeC/WfdPxGiylVFut0l/88RcoUI9pKQP2eEeiVyLr6ryu6a5KW1t8OES8+OyGI9SjI
 2k0RklW0xtDDw7zkmZpBd0LxTxo9TsbhT8yAJGaLJfc2zeNDJvDxh83hsOiKnUObrIvXQHNA99p
 hgPm1xc9o9ZRVxIyje0ca+PDaHUD6a8R7LF65JtvHr+2xhUdCJYGQyWIoAhVwTNvY9HySsYInQ/
 /KPD2e/g7XzkgPUlya7ybYl5tWjBjcZzljC+BBnexSGc4QRJT6EVGisLqwaKxq8Xc+Prd+mW+OQ
 UNy5PozFR6ExxbzNz9A==
X-Proofpoint-GUID: kUNomh6PkQ7pQPJ9L_ygcklc_cnL7X9T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX5GOVz/REkLCD
 /p/FZ6bnjqccilCpAbjXXoxLBPnVktnYl/iPlhBzUoDpnR9gdh3D+nLzRgKG3QOmhPVVi53qPNR
 j7NjWQdc8zCIGIJyh1Dgt5oaM3I5x64=
X-Authority-Analysis: v=2.4 cv=dJEzC+Zb c=1 sm=1 tr=0 ts=6b09ddb4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=LpQP-O61AAAA:8 a=COk6AnOGAAAA:8 a=e5mUnYsNAAAA:8 a=FoPEBnDcYiGibjaZs98A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=pioyyrs4ZptJ924tMmac:22 a=TjNXssC_j7lpFel5tvFf:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: kUNomh6PkQ7pQPJ9L_ygcklc_cnL7X9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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
Changes in v4:
- snapshot init: don't double-destroy dump_mutex (Konrad)
- tear the snapshot worker down before the KMS on the init error path (Konrad)
- dropped Konrad's Ack on patch 10 (teardown reordered there)
- Link to v3: https://patch.msgid.link/20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com

Changes in v3:
- Rebased on msm/msm-next, fixing the conflict.
- Link to v2: https://patch.msgid.link/20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com

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

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Archit Taneja <architt@codeaurora.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Kalyan Thota <quic_kalyant@quicinc.com>
To: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

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
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 14 ++++--
 drivers/gpu/drm/msm/msm_atomic.c             |  1 +
 drivers/gpu/drm/msm/msm_drv.c                | 29 +++++++----
 drivers/gpu/drm/msm/msm_kms.c                | 59 ++++++++++++----------
 drivers/gpu/drm/msm/msm_kms.h                | 19 +++++---
 11 files changed, 193 insertions(+), 127 deletions(-)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20260930-msm-kms-destroy-fixes-0f04b1d39b83

Best regards,
--  
With best wishes
Dmitry

