Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F608C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A387C10E708;
	Sat, 12 Sep 2026 12:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFKsH+4m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ONTHP363";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12A610E708
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdZkd3757943
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3fdU3zA0kEiuqx4voQsN2c
 ygEglGYO5We2HH28Bi7MQ=; b=DFKsH+4mdc8BSHs3A0Q3d/TAcoebngghKR3ZXP
 Czb6aG32Q1bXfkiAgU7PnK0KoCsO9TVFtFtC170rf57JVMtgTuWrRcjngn1WxNx7
 rgvTqNRHDwlJwfLC1eLZe5nEKIQty0ivNV8iVVGTkK8wNV1SB/pzCJWkLvfZK6jX
 ig6hiL8Of4UUuryCd/4J8DFtJSNMzkSnDXhvS1DE8+aJkBQKN9DNLYSQoQ/yg2rS
 nhEy3bTDG/9cNb4/5qdwMHRo8L8Nawzno00dzp/hmUayeQ3Sr06TFiTkKyXfyi+/
 JHIXkqlRt3AI9iVJKGvtb9Dwf/f2n7MAXsKfWBppEJRqRSfA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c8ybj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:30 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78a686d205cso1380178137.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217310; x=1789822110;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3fdU3zA0kEiuqx4voQsN2cygEglGYO5We2HH28Bi7MQ=;
 b=ONTHP363G7vGTxPa9j4NzF8XynNQbZp86eJu7BpJfsDvB9GdMQJy+XpWXh22j646FJ
 oyiAraFCL9XV4Jk8/AWxE7p+8nxOnIWUzKF06m3LfEC1cO3mhmy6ZwOl8lxCPn1BKJ31
 r/Dx7VXXm0rDW0r/J5nkCvatuTzXE1qlx0eIwpzJrndBFV1HWdvFxzGRZsIxmWR1iavM
 qmMRl7Ds1gx/KJN3VhrlItdu8wx0PChhI2KRr6mD62Xcv3PkAjDoogDMaejkd0M7pvSu
 kPk9tU/mmibzvXPW89iZKAVg41aLXoketdqh23LpNBGEDAugG27+KPXQtnuLuIYak6PY
 /PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217310; x=1789822110;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3fdU3zA0kEiuqx4voQsN2cygEglGYO5We2HH28Bi7MQ=;
 b=C6iS2ejsC1dvUveSgpvPLL62feAi5bJb+oeXbjLmlNgeBNi37+vNLMshPR18+8jn8w
 cClim/IP+DAmzYxhAoT8S8HYEuvXIcMaZezqdhSrGgDfeJv2WQWnUjE/E7Ml7ZvnnByA
 g3iNfkj8vmGsMoSECg3pOjSWHFcpe5h1FYCbcAGIinnAG4cu5+9NpEnjvCr5TMg4Sek7
 99kdWLaDIdx+mlwU1w1VdyCGW4bZ0isK3UReUap5mrKTR4nyABFOvSd1eKNe3HR+sTFi
 VpoNIxVh3tlxmw/UoGLQwjAZudrK402JBo3lMRU0nKgNpIAUiW0kbyKTb547AXFUG5uI
 Xucw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCA57Cb2r0O0fX5tMJP3UZ5Vf7WUWMzYeNDIJEnCJblJgAPjo88lGP81/1POJFhJerwofRBugUV6M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k91gp/MxRli2n9wy6wafTUj+pB0fXsMF58FGoyijZZHeeJseXW
 OBmvpT6wl8bdn4OGQlYjYyf+WK6uLYWoaUxLZ0L4iMwSX1HNY0LHEmuTINSjxkZ+tXG/xpAoxhA
 CJbMRXY46GR4fCsxHaaiPUN1PeW5m+L/KIDMmH5FYbHpYCHGdyAegflTBS6PF3hcX/PL57QI=
X-Gm-Gg: AYBFou28BEYqlqCQh58yeZ2TWx/fzxmrpcvZ4UM8+gG/y8iT1Mx0MuKta+GaXqiCCg6
 vhDlg8lp7cAOcGByIA96zDAy/DHb04l83perawdZ8HcnEM5YZFxdoLvzw0v1NCKFSh46uEwemmt
 9Q0hhJyjEtlKPLsXY9+r6KKJ6RnPQ3YEW/+9yXrzaQjCmQmkZP8l7GeQ92j8gzlrFE54ux/Jzw6
 Uh9mvPAarw2iTMTjHswliFIah2iaSMiWA11oQntuaGm+fFmOGbwv+hZYiG1/J2zj+KpjbSJc1CE
 DKgJ5fCFsgoMv0JcqaZZmghaw0G2RtdLCuvS8snuUFznV9303MZkfh0M/ThfOegpUd54+VjsPBO
 mrgO3ijOK+OqyXN6noDKZxEJrmmqnWpzE7XMyAGsRHArbwFq7t+Ng1BmLXBkQY0GAS77UVy7L6k
 8IZw6iKO9mo2k6
X-Received: by 2002:a05:6102:32c6:b0:790:9e43:1236 with SMTP id
 ada2fe7eead31-792aad5521cmr9876552137.9.1789217306129; 
 Sat, 12 Sep 2026 05:48:26 -0700 (PDT)
X-Received: by 2002:a05:6102:32c6:b0:790:9e43:1236 with SMTP id
 ada2fe7eead31-792aad5521cmr9876534137.9.1789217305617; 
 Sat, 12 Sep 2026 05:48:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/8] drm/msm: fix SMMU fault dumps
Date: Sat, 12 Sep 2026 15:48:20 +0300
Message-Id: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRKpWoC/22OwQ6CMBBEf8X0bElbam09+R/GQ6FFqhakC0RD+
 HcLajTByyazO/tmBgQ2OAtotxpQsL0DV1dRpOsVyktdnSx2JmrECBNEEYYLgy8ecOHuGLzvMDM
 807rggmQExa9bsPE2Ew/Hl4YuO9u8nTBvR7BNF6Par6100NbhMffo6bT9RKaLyJ5iggWRhjCuq
 BBiXwMkTaevee19EgeakD37xcglhkWMShWVdLPlTMs/mHEcn3pbbbUjAQAA
X-Change-ID: 20260902-fd-kms-fix-smmu-2d4baaf460b0
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4924;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=acXpo3fnBBm44TAaGvVzO4K2+eb1q1qZfnXA9/f95ts=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoWM5RjmZcTLZVo531LPjHKZK6O2gy6icUYD
 w6ifwDOn2mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFgAKCRCLPIo+Aiko
 1T3oB/97ujHCP024sgmssO5D99l7RPN0tf56l9TAcYMPtkxRfoK7obZMI2SdLdzeB1R/5/Vm6xW
 jPAtK966iQJT6B9E37k4Wr1xFHkarjT+03irz+ICbjCyngiEMtPE+Q0b4krKmawobdPkVcWK2Qc
 BRwx5UjhrTYshdWPUxlKdvMIkJK1VxLOTGoKNLBZWesUtG/OxLnQhaeeTkrGSwrotTq4pYXauwr
 A4aqz/yZ8RL/UknvcsxwDHBnpgEzu7TFnBOOl5bAj70rsSdDe1/TC5GTnoBDnUyovRo8Y57u+D9
 2ACKou4tFkRE9EV9NY+qyPN/maw8LuufJr67JOu8DXqNZVZD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX9uMuBQaksEsE
 Rt6sQFtY36mHt7NadTsTWrzOVordWcbfur/07nIaqeB9fBcYk/WLDIjpZI17UFKLgpNQZK4cwY4
 DjWvyk23QrDr+1hUwkHU62DnPP0BJeo=
X-Proofpoint-GUID: EjfRmHWsHJkBJkJwCqA-8aHQhAag3zeN
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa54a1f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=COk6AnOGAAAA:8 a=QX4gbG5DAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8
 a=hPlEVOE2XIimEfz4Pi4A:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=-BPWgnxRz2uhmvdm1NTO:22 a=TjNXssC_j7lpFel5tvFf:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: EjfRmHWsHJkBJkJwCqA-8aHQhAag3zeN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX+Bumk3tap4t4
 oDmk3LwnTjoaPVx47DPLOFK0MhM9zPURdPzg9uymAyDNhcnEL10q5LV8YO6o+0zNNLrm4qB9+Uz
 EAQMM58d7gklYdS1tsEv6EZGcN4QjRdNs1SK+9MsvUcrWvY6oC8+DTQcOpReJD1TOZ5Xni3aXcg
 q0ijypKrZZSZFnOryVFwmzABxpWf4cYL7W0nbMKcT2lfzTLDLpf56Hqfgiq7bnQ9QDXhGj4QIRY
 mSosPrCNh/CpEorvAB7UW4dxH9lkOJOPFpl4NwMnd1XeeM5OIStOP4KFb0Vij84tyhkrXquHmWt
 NWSQaP+A5QIjGwGlLZ9LHP8ATb0PA1ZLwH9dw3OiD9JXpCiZopb/4e5bBh1bVb66CCbqQwefY4q
 1Evg75J4U4FhNH0ZAXRDLFzi2sRjNnnn+CGZz1Siby6VrPltTtzDdS0mivu6/uqQENtvkDUINyB
 iUr1fbqcsQHd8B6LBMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120184
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

In several cases the drm/msm can cause an SMMU fault on modesetting (due
to the display controller still scanning the BO which is being
unmapped). Fix the cases which I stumbled upon, together with the issues
found while chasing them: hardware block pointers surviving the
reservation which handed them out, and the teardown of a KMS which was
never fully set up.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Initialise the framebuffer's lock and dirtyfb count before
  drm_framebuffer_init() publishes the framebuffer (Sashiko)
- New patch: unwind msm_drm_kms_init() on failure rather than handing a
  half-initialised kms to msm_drm_kms_uninit() (prompted by Sashiko)
- Drop the pin count from the deferred unpin work rather than from
  ->cleanup_fb(), so a framebuffer scanned out by several crtcs stays
  pinned until the last of them has passed a vblank (Sashiko)
- Defer each retired framebuffer with its own drm_vblank_work, as i915
  does for cursor framebuffers, instead of a per-crtc drm_flip_work: the
  release no longer takes a detour through kms->wq, and nothing needs
  setting up or tearing down in the kms init path
- Release the framebuffers still pending on a crtc by hand when its vblank
  is switched off; its interface is already disabled by then, so no
  further vblank arrives to run the work
- New patch: clear the DSC blocks left by a previous reservation, the same
  bug as the DSPP one (Sashiko)
- Link to v2: https://patch.msgid.link/20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com

Changes in v2:
- New patch: lock the framebuffer pin state, it was updated locklessly
  (Sashiko)
- Do not defer the release on an inactive crtc, it was leaked there
  (Sashiko)
- Flush retired framebuffers from msm_drm_kms_uninit(), before kms->vm is
  dropped, and only for crtcs which have a vblank work (Sashiko)
- Clean the flip works up after destroy_workqueue() (Sashiko)
- Fixed the long-standing issue of the msm driver roguely setting
  allow_modeset, which started to manifest in timeouts and SMMU errors.
- Link to v1: https://patch.msgid.link/20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Antonino Maniscalco <antomani103@gmail.com>
To: Kalyan Thota <quic_kalyant@quicinc.com>
To: Federico Amedeo Izzo <federico@izzo.pro>
To: Helen Koike <helen.fornazier@gmail.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---
Dmitry Baryshkov (8):
      drm/msm: serialise framebuffer pin state
      drm/msm: fix framebuffer pin refcount leak on prepare failure
      drm/msm: unwind msm_drm_kms_init() on failure
      drm/msm: release scanout framebuffers only after a vblank
      drm/msm/dpu: clear the DSPP pointer when no DSPP is assigned
      drm/msm/dpu: clear the DSC blocks left by a previous reservation
      drm/msm/dpu: only reassign resources when the encoder is reprogrammed
      drm/ci: mark pixel-format tests as passing on SC7180

 .../xfails/msm-sc7180-trogdor-kingoftown-fails.txt |   2 -
 .../msm-sc7180-trogdor-lazor-limozeen-fails.txt    |   2 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  34 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   7 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   2 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |  17 +--
 drivers/gpu/drm/msm/msm_drv.c                      |  27 +++-
 drivers/gpu/drm/msm/msm_drv.h                      |   4 +-
 drivers/gpu/drm/msm/msm_fb.c                       |  78 +++++++++--
 drivers/gpu/drm/msm/msm_kms.c                      | 151 +++++++++++++++++++--
 drivers/gpu/drm/msm/msm_kms.h                      |  16 +++
 16 files changed, 283 insertions(+), 68 deletions(-)
---
base-commit: 140b13475302601368c0cf4e193e66126a49feb3
change-id: 20260902-fd-kms-fix-smmu-2d4baaf460b0

Best regards,
--  
With best wishes
Dmitry

