Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2156C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E30F10EC97;
	Tue,  8 Sep 2026 15:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i1e473dj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CH/YuLU8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8257510EC97
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:24:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1SWx3237215
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QQP9xZA0DIBu9yTvo0EnII
 J/cPZDZ1G3rrVHZCeKk5c=; b=i1e473djRNxt9irLfG52L0C///QTqQKtQ/pVy5
 oZNlvE+a90/gQMP2S/9d75/ZaK/qwHszaeo3pGAyZnLQxB3UD5Al5gL5MfSfx1H7
 AXNqn4c3JKq/V8DG//jfJn20zoSHUXExbGbC4Lu2YqYdb8D0XmWWks3diGLy7fzW
 tP0BLLognjWneqm+kNhVIotDJ0YGeX7AbmxXZSEDUv6V69o31h+TzlkglRIe/QtV
 gIVLd6k2CzAXv62XyNOdutm2t9mNQ7NKXF2uL+t9J33OdGLXmY9J2uVZsrypZM8B
 CaQXtSeNiSMY7pu+pDOl9lf5s9CyOAU9WY9mQCTaG8RwIVhg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjf1chq8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:14 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c664914e69so5073177e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881054; x=1789485854;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QQP9xZA0DIBu9yTvo0EnIIJ/cPZDZ1G3rrVHZCeKk5c=;
 b=CH/YuLU8CIhEcpiaOkLWfwdJyZCxIXnSfJxZvXVbp5ognnCo8PwPvOuMFlknaUGaLA
 ZILixArgK87LE5MDlT/FWSNTMAVI5DFf2IoEUnxfhtplWtJ4pZuFCGYigtvmIvYfHkla
 +PuuGdLOgUtj7aXzkAH4CAl3Z7A0NuVA59kt8y2RroIZNpPCY94il/r5kqXiNutPyPTu
 CDq+nfOUHUKBRw99Ij8K2QiRH0H6TOtgx4Qq4es6YCMgQXKEaGWNwm6Ui1Yj3ll+rG5M
 5dYoEAReAnHgfMf9tvRjAZGmqAalKtKGgRVYNPf1J/0UQUlJwCLiPK0eEVahctm0jkj7
 TAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881054; x=1789485854;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QQP9xZA0DIBu9yTvo0EnIIJ/cPZDZ1G3rrVHZCeKk5c=;
 b=sKLt18b2NbCynIX7OBHdLuh9eq/Qm3D0PUZ5WR9nytsgBMA7CT4Y9WN2rfDNlYPBhz
 NCsjb+W9BFAf7Div7tyWs4n4Txz19hBECGMucdrTvhWL5OM7GaEb428dCa0Trr5NQpQJ
 AGD2bnnx7UcW07VyLw8fImNiNIbMaFXAFYfDcPaJC17JTZpfWtCt9E8nRtPZfdILsibU
 ikT4d70Tr6S0D/yyh7HzcnTFhamhQtxbGAIiqBS7SPy1nlrIrdhTVLu/VTeMuY8KUVl2
 3Pz+WFbsUu88c29bDP7ShoroQhm4D+YEsbEqrMzwk8CaEZEYGtGTX4K0Oqrs+OlDndeo
 +2bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwN2bXd/kiwlHE/9CntQWeo8r0a58YOowumb2n46voS+ktCnOkTjz+4++uyHkGK3fREnuDj1/Qww4o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nTzVgQlaZfvzp3khkrpLFBNUjySWzbXuYy2s4f0hjmdcigNeMc
 +gdJht0i7z74xIVBjjaNd3kGDXcYIpy03oFuvL8W55DHw+KqFvIn82HOloVHHL4ph+fxltxFL6K
 tdncS2D6qGkuo8I+s+83HK/MacagIuRCOmZBLgEiCrJLZ86QhwuFC1OyFaRzKAuE6ast2ZyU=
X-Gm-Gg: AYBFou3Puwdf16Jkqj+LrSo/s7J8bzc6P5Tun4stNoBE/4+oc7c71RdLqzIWoSKrgLS
 jotpsv1eCZvTy3Ybknl5aWP2+ul04gFNLO5UlbfuhdmNTH618XJzDp588Gb1kOsZYOvCsDB8+YD
 /YElkMw2N+u1CtnerhLbSvCwqYFtr7ZKfjmKRczajkeitl/xtG2unkGfM4h+4SDyPh9VcJEk2mP
 sZSTskIIawerHyCDKAUh45wCoX5QuXQfKnA2x9Us2FK0G7s8sTvu0SkAR0h02vsOv2WQnZdjX+X
 sEOwqZU92527Y5NYpz4LnCXUE0N3OfDe5Dio2AUA5Vim1kWy6NtQWcSCTluYAunOAhAafyqBOeN
 EYAIZru6KL3HZImNSU5Gr6XkNclEJM85dmrTlDC5G6lzFiGCKSitABq1+1N0psZMnp5pjUews9e
 jTWrkgh8ptYpT4
X-Received: by 2002:a05:6122:2088:b0:5c8:228:5ea6 with SMTP id
 71dfb90a1353d-5c802286397mr9419993e0c.5.1788881053708; 
 Tue, 08 Sep 2026 08:24:13 -0700 (PDT)
X-Received: by 2002:a05:6122:2088:b0:5c8:228:5ea6 with SMTP id
 71dfb90a1353d-5c802286397mr9419925e0c.5.1788881053156; 
 Tue, 08 Sep 2026 08:24:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe10asm3103722e87.47.2026.09.08.08.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:24:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/6] drm/msm: fix SMMU fault dumps
Date: Tue, 08 Sep 2026 18:24:08 +0300
Message-Id: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJgooGoC/2WOwQ6CMBBEf4X07JKlkkY8+R+GQ6FFqpZClxIN4
 d8tqPHgZZPZnZ03MyPtjSZ2TGbm9WTIuC4KvktY3cruosGoqBlHLrBADo2CmyVozAPI2gBc5ZW
 UTS6wQha/eq/jbUs8l29NobrqelxjPg6vhxBR48/WGhqdf249pmzdfpH7P+SUAYLAg0KeF5kQ4
 uSI0iHIe+2sTeNg5bIsL/lGPiTcAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rpTHwGs2zVtIX29Hf4f8KNNEO8Xrccsx6BFDzdIrL80=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqoCiaw9RBogKdJLJxAJEkFZtSNdlcsQvN6MLAz
 BIbwHna2LWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqAomgAKCRCLPIo+Aiko
 1V9vCACUqE0klKsbtF7B4tbJInBmjGTJOGwmZumwwVtB3ixyaxgM/EXPmP875waq3vqc5hrvVrx
 dhP28h0kakuVhmw1Cha40vhIhGt4oAkFnezY4BfFvinjKAOmwN5rvo5kInl1SLKwhCo4g2fr7Rc
 t8fVV69F+jrknh70UyzUUrvrpwCssbv00q/MHTMnIKFUlSf09qpYPINy903pYTlYAjPluDRVjW3
 Za56nKDQY59FeRpS1htivu6nUhEfdFxuN4u5fiLDa5bdUddCv5lNtWb7W6Gxv8w+8bI+oeZPCux
 dzRUMgTvHUgZw+Yupmk/8+qjGE8e9Tl6a7tCP4bH6ja/fgNh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VN3tWdPX c=1 sm=1 tr=0 ts=6aa0289e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=COk6AnOGAAAA:8 a=QX4gbG5DAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8
 a=pP-i1W5VvTVjX-mheSwA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=-BPWgnxRz2uhmvdm1NTO:22 a=TjNXssC_j7lpFel5tvFf:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: I4MfgM3uUylLiar6lC7XMwJ8Qe0tL58K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX9jnfgwMQF94a
 Xj0dvJBeFXW7w2/Cf988M/Z0o6B0iNedHwfBSUtdiyy9sYqVwB+vntEat4EZqX5J6hJiPl9LFZ0
 gzcXW2xBJjDpB6qZIMQs6dN+mRoNMR8=
X-Proofpoint-GUID: I4MfgM3uUylLiar6lC7XMwJ8Qe0tL58K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX206aFOtl77Ib
 SD/vYMvVc3cgXDYkhWTxwxGyHVTk87zELJib0o46/PSVCS7Jt2V1Tc+hJdWffaR7Wg60UqkPxPI
 QdfIs5GFL5NAx1OKFqWyzSzhjBLlgs3o3du1Au8Jd9YHFdFV8aojt3RJ/C+tJfe6yIAMErYvKNX
 glrYNEA59Dw1/1uGDagEMi8PVxU3Puf2xHH6os/QclFt9Rwhw+AtFZt1VVXIeb6xYaR2mrmGfmu
 VpiCruXTTHJJl0XS+3XtDxumkzYIuWnNQW1RhU2v5sbKiflSmITT4cfivcBe/Gb7RoSJMnkRkQ2
 TH7oQyp+TSyU8gCJGF1hoSMfdn06PL6iU9aHekoLWMYj68/hlykCA6WPVLlTLjTSJH1dOFiW4YF
 +4aqt6XLVS4jfMWBEBv3SN2km8YRfXMhJudb7ruWwiPIz6uzUrRBq5IpfY6j1uQ8bEtHqdUXNA4
 y5g3X0B9aweV3LxIHGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080166
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
unmapped). Fix three cases which I stumbled upon.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
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
Dmitry Baryshkov (6):
      drm/msm: serialise framebuffer pin state
      drm/msm: fix framebuffer pin refcount leak on prepare failure
      drm/msm: release scanout framebuffers only after a vblank
      drm/msm/dpu: clear the DSPP pointer when no DSPP is assigned
      drm/msm/dpu: only reassign resources when the encoder is reprogrammed
      drm/ci: mark pixel-format tests as passing on SC7180

 .../xfails/msm-sc7180-trogdor-kingoftown-fails.txt |   2 -
 .../msm-sc7180-trogdor-lazor-limozeen-fails.txt    |   2 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  34 ++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   2 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |  17 +---
 drivers/gpu/drm/msm/msm_drv.h                      |   3 +-
 drivers/gpu/drm/msm/msm_fb.c                       |  63 ++++++++++---
 drivers/gpu/drm/msm/msm_kms.c                      | 103 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_kms.h                      |  27 ++++++
 14 files changed, 221 insertions(+), 43 deletions(-)
---
base-commit: 140b13475302601368c0cf4e193e66126a49feb3
change-id: 20260902-fd-kms-fix-smmu-2d4baaf460b0

Best regards,
--  
With best wishes
Dmitry

