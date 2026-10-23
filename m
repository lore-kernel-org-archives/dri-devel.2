Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE39606A320
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kfdOx1yW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vyf+z6Hy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421E910E732;
	Fri, 23 Oct 2026 23:20:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D362E10E701
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:19:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvat63471096
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=g/gKhJm8D+3RUy70YA+6RE
 MKGfetc5twJCUNtCBa9Ig=; b=kfdOx1yWsKH5kO8t2nKjIKyFi+wwE2Ajv8a6/O
 lzDxzTN+KKnFtBEBpQjz5V6/WZPacGHgWLJt9IFdP5RfTT0iD+PmQNWbRltibQ8J
 I49LFVoP6yNgbcRfCOJ3zfstDI8PKvo55gH8zAYZq/TUq2NZZiS9JWdd99mFGzEZ
 SmUb+N1Jz5PLjd/GpgbRFW5s7KYjIHIZU1/YDURd+BSLvcQkxZR8HW99qiPWagJu
 sM4KXAiPhFgegKIS4E2y3wH04oXmo+GUpq6FUXW/T3m7TglEvUm4qaj2UrfiP1ik
 HsrMphpr898vjU0l8OT0PSI4rRbHTworzaFsxjiYsEBx+Fig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrugujw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:19:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93dd3c3badbso356911185a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797596; x=1793402396;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g/gKhJm8D+3RUy70YA+6REMKGfetc5twJCUNtCBa9Ig=;
 b=Vyf+z6HyETubdniOgyvuQm4BXo4189Gm89CVo99DSvfd6j4CKXvvvbaMPsF4XbY8rJ
 X7zVIN1gFawpxoja+p/74MMxIlBKuLRSU5fG1QcreA+OseQ8IboiwWdyE9M1o9K1N9U6
 E0K4DmKhGgLl5xkWblQG9w7jZwwP6XjzF0RPpNWZbmt1JGjikokw/mFNgudqsdyb1C68
 GmgcpUFIUWcc9+s8wvC3vmUVZVWwfhT6nYKcAtqv7XO3/Nf4GzdZp3vAp/93uS6EM7yJ
 vkHmnWbIkPNHsX7eYj8VA1tqWfJ1aO7B6JJMD9HyYBTeiZYCjzW8JwIsOrV+Kj6ROIeg
 Irzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797596; x=1793402396;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g/gKhJm8D+3RUy70YA+6REMKGfetc5twJCUNtCBa9Ig=;
 b=AnkBXa7JT0lgIToVD6u8H3gXUk8vr8KqJmsiDR3rod2KEyt0NVbIopAGYzzYQQerh4
 rjdDYCnjHzLOQtuyU8kTta0l59D/fFdfv0L6/MPQvYmChDrnqy/hUfwbrL3gJ42aStFC
 STtJ+4j24DV2LPBDP7A5BnVCmurUj6JD7r5aY5Gaic7ZDryHbDPbhEYqyqBQ1GzW6ZYp
 yTTI228zZ0lUll/Wdy/Ub80Yp03aTr86F2F4Esns65UDPdlGLJ2fecE0sE9VgEKB/pjy
 Jk9HcgBPdjylsV2U8PxhFMNYfW0rusHKNpt3JA2fApXrRApfO0QBAxjVU9zIEperBkjP
 TmUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6Q23IBLvpkEGmhiFyL2IZGrJgMpxrOP0N8Cf6jJ7Y82jygpgPd4/TQ4W9L8FKcp0K/dcCRVW/ffs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL2rZZZpHC1W9x5vnRIlrTbLskiquLhX/wdp3xUXa0wF+0cgl6i
 lxpdzZhr2FqcIRQf1vo1PydxUDEOoGF9PNt0dk0ng/2mkwISInsn/rO9sLpaixw3j3d4M2zy7Xr
 90gopxRNL8+bM2WYftSvbA5/aNSMabKCI87BSO8qRbodw+h6zpqjd+iegDtIJe5xEqhgrrLQ=
X-Gm-Gg: AYBFou1QgxxHvo0nITSXg+VbYqQh6BQ0Uyf+mb6Y3ESPFSqO6UCN/QDjaqB1jAfGRrg
 w8ZnGu6PJVIdVhQMTsHmntyHJYO7YjpE0mFhAQBfjO5ZkvESSj764csC+XO+qcTbc2iq5QC2fKh
 CXwJ8f5r3mufc50G2wCiEktXlWP11Qdn11wFeCqTFI3GSnR0aV3IxtrnmXcObTeLusTPKIe1Zgo
 iiE5uuCmXAiSqX+35ThzdhKMXpDZvFNWs4XiVmVGkoLLBnO9IARRWzE/1tbcBKvwUrMZUcVBlFn
 kILacoq6+VmV95aEj8V1/3VyJa0pV31shBBcaxRTmJxkhL94MDlXiYLK6yNBcGJ477lHsvvPcMT
 pjvisuLAJZ3EcG4OCGHOwxdY8gXOysXB+PEJoD0ddh289iDmdXfP2LxW/+00T8UGUMXqwRX29B1
 LxkuEQPlcSDDJT
X-Received: by 2002:a05:620a:3704:b0:93f:3193:ac02 with SMTP id
 af79cd13be357-940ef980186mr85585585a.51.1792797595962; 
 Fri, 23 Oct 2026 16:19:55 -0700 (PDT)
X-Received: by 2002:a05:620a:3704:b0:93f:3193:ac02 with SMTP id
 af79cd13be357-940ef980186mr85583285a.51.1792797595526; 
 Fri, 23 Oct 2026 16:19:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:19:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 00/14] drm/msm: fix the error handling of the KMS init
Date: Sat, 24 Oct 2026 02:19:33 +0300
Message-Id: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbr22oC/3WNQQ6CMBBFr2K6tmY6NVZceQ/jAuigVUu1A0RCu
 LsFNy5kM8nP/P/eIJiiIxaH1SAidY5dqFPQ65Uor3l9IelsygIBd5BpkJ69vHuWlriJoZeVexN
 LqGBbKKuzYq9F2j4jzY80PZ2/mdviRmUzwabG1XETYj+LOzX1ZocC0AuOTkmQBDssjM3JmOoYm
 DevNn+UwftNOmJSdfgDw0UYJtheGzSlQrRk/sDGcfwAGjs1uiABAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5666;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Y4fDxGfpbq/W/o8WwgBUX09912j7OPaz0X+wudJs32s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uJppx48xsLonjOrx30k1Ri4C1eudk/9xeMN
 VTOZLSC/+6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvriQAKCRCLPIo+Aiko
 1V7MB/sFaerdhZNYNUGblQ1JWAgjlUreKqOUHRpUXsSfYPZ42gFOgnJ2sgwP+YLzlwYER0Lcug6
 DUwP/3CeVTKy316RYuv7U6TZpKnNfVPwWtdIJzcHiW9yeL3ry0rVI6QHGWr7idrQm4kDwmsrmMd
 Kfk84BCI4PXGlexaoqezoSd6XAWsRRu61vf+j1E6tW7lB72FWX0oVAscwee27ktY1un3qJMA9fN
 upg5d6vP3QJGWNHM6SHDA+91phWrA2zkRvl0FdewBDUJB1Tml3TdpXU/KnSAVfthLxhaJocG/pc
 VXn5mWRSlbzmg2E7/LUt+pTirm8z40IFCSYaQ3Z9qZo6MLj6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX1ahBNDoX/1ch
 tFSu1kONJ6XsMKY42dq4n06ZbnPAOImQCEUhST+C6TUyRaaKx+g1nZhPvP0goI3OrrQ2dumDF0P
 r6+pqYa0QShFeWUP6MqyxvVa5+ORLM8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXy5gyRTupWAGE
 4H6n1pKwR/WhRMEnUyzuQElJ7RcthruUlMeP6T7Da/uEQ3PiehmlKFlK2pnq/BN5FW+N4Zylk9R
 3q3TTPjmmswngTHBSMyoc18WtFAT/zaRjiBse/d7Qs/2RPi/uaSNrK2wwbG9wOJ7pOE96AzQZyS
 0Bk55H/LuqCpaqB6IOQ8FD2DhYb6+GbpR56ibmhlQDJOzcQZvaE4HLIc7jAQC5iIHwSVSDmf5W9
 1uQlOrJn9xoSkom0NEAhaAPKFcpCON84nDNgF69vkH5i/L7Kpxf1oWlkWNC60L3LVOhFUJ3PT0L
 7m35/OqjmPEgPFfrraZLWv3b5ec52oJBKZw/74LmtBVs6fiE2lhgMXGTb8ys9rzBotrO0VRFUkL
 DnjCvPo4jnqk3odTam0vS3J4qEs+6eiZjuFoZQzMiQAbsRZjq/Zq3mcWQV/fhOVXOGo0XPIrN0r
 /QIp18YS/+CXmp8yGEQ==
X-Authority-Analysis: v=2.4 cv=Ju5kP84C c=1 sm=1 tr=0 ts=6adbeb9d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=SeckFaocyGfTZ33SJHoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: cQjGjUVDdh9d800Pzu3k3zhrxcsq2wIZ
X-Proofpoint-ORIG-GUID: cQjGjUVDdh9d800Pzu3k3zhrxcsq2wIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20260930-msm-kms-destroy-fixes-0f04b1d39b83

Best regards,
--  
With best wishes
Dmitry

