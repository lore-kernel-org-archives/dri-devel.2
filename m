Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4AECA9ECA
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 19:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA0A10E03C;
	Sun, 11 Oct 2026 19:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZlE9biYu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hnYrgWBe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969BC10E03C
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 19:27:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69BIQDhD026002
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 19:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:reply-to
 :subject:to; s=qcppdkim1; bh=hx9WS1z5UPv15wgxUK+UOiFQICa1zaBdNIm
 cKXdKysw=; b=ZlE9biYuN5xQv1O7PtXX3oKV7eg2S4n32z6iFnVNVyk3aCDd13A
 cROZdQoRGaaMq3BIEUYWmZT2WpjEqmZAr1GT7s9BlKvRvxV/TEyOy1sl/7xBDjhe
 7b0ezaAUAJEkDllOBGEa/vM3ldiSUqfZwf+EAC75XAivkhzQfQqAdLmaywgif5rl
 +cOTT0vegg5J6BmueLNCwZfHN7NHtwwsaJBDuSPydvYUTgTVMoCMb2ZZezzqqazD
 V2MuyscdlI4jSzp+Gi5T0wlfpLfYyWWWHBlvAayIxQC7h89c0taaOz9PjqyooGwJ
 AVc5CxgQ/CRBO36/tU47+qC2aefmRiUadoA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk23mj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 19:27:05 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-821de0b7baaso2617508a34.1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 12:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791746820; cv=none;
 d=google.com; s=arc-20260327;
 b=hkFa95lNAHSNl9xnZecuPkJtXMNZNSnjGdiwl/SwlqcdoIVBhfsAuea7VHh1UFPL5e
 s+V/VPmtq7++WH16T+HDyCmKI48VqGRSUCqUmb7Rh713s+JrMn1ON1A59n1hymrETSRu
 Is040mLsEXY+mckOVqHfKNEhxkvC449Woxzzo4lWExSQfpFf3ClO3R6MhR6TUUjJ70AC
 +eIriqGSdXgYvCwtA/PE2s8E1wKOoNGzwIxWsUl6smlv2MEmBlYLriUUNlfM4NPmwChQ
 XYOQ+64MOw8aw4b77NNJGTPVHZhZwypuCaoPmzaz2ZMCkgUeJjQh3QeZOFPw42PGJ6Iy
 MECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=hx9WS1z5UPv15wgxUK+UOiFQICa1zaBdNImcKXdKysw=;
 fh=L9JMCOEXmLq+GYBvJNL6JMJn3uFnGhHMLJlQPdTGOkE=;
 b=BDSl0z2WqvejFhP3jIzQiuQbKltFB06D+VR5bZZIJRP3LpYI04ZxWy4Exq1CQToCKR
 DPwCwL+KszaeWqsupi2oKhbs8t4pmZlQVSqyWmdqtL4iMcfi+ZhXcle8iCWXRdcjVSLR
 z7n9Ktcj8gvY9cKANWo17Bz3Ex/rqLSrdKHQhrGP5RAH1ExvRql2z/H9YWreeCP0yHvn
 e0qoBUJ1Yw+RZNbtxisPvGZlf6W+M0ECzMkgqAH53MZT5/MQ5cvKVwK9TxSrkqLd01mG
 xb9Ss4SZgaDGSmgN81N15xQjgDRnjnJlyHifbv1w9RYfLHjt5XCrisUbs0L8MZJkI0Z1
 /8jg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791746820; x=1792351620;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hx9WS1z5UPv15wgxUK+UOiFQICa1zaBdNImcKXdKysw=;
 b=hnYrgWBeA5+pxcMxDmNzixG9r5P7rUnJAFcC6qH5dett453jdOkUpC6U1NMNCWm3Cw
 20NXcHLRlBXtBub6wJQLSU5hdlfr5tMfvfp9KS+qIL+u/zMEynIUis9oFsTar874bdQL
 mYksiHAT+DtSRWAsNw1m+4p66Ey4vcWSio01rNDLOgD3INNYazsyqSloRSKc+Uz50M2L
 89IJheCZyWRQaJS3DtCtjkmy4MI+8Wzc+hzbpUxPJmPDTXk1WmqBW5BuSPPuGcUjQlie
 CCnl9NvPVKM6FdSwkUZA2YPFBAqpkagVhwCEyDm+jCH5Fl3nEXQ0IIr9rOVoRFmtgKaP
 B4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791746820; x=1792351620;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hx9WS1z5UPv15wgxUK+UOiFQICa1zaBdNImcKXdKysw=;
 b=LAQFRKKWZG+LfbKL7rXxvWaMnbydt4JOhsay7ssxLqP/2wXUNLs2fjjrCjUZlJacF/
 bSSUVMpXSjZ7cvRXb2pqZRioetUAsaBWg1reOtWUu/lNcQm/jCv2aeOGb5cmNfM5gvsZ
 Y+C3N9OmY1pvmbE9MY8HPZQ8uFh3K2hmi0b0dsyR6CSmIpXD6zeXtqt6QyadN6UEAI3N
 v0Jnx01Q0fnLp0cvKk/sZIMumX58KfmT9iD/y3FN5l79j7ZjlBLQyRi5k6uHUCq0AGCI
 zbRYKWTLO/uApOsvx8KF02ZNScxIS//vZwHPmQL+DIN7jXIoaBAXb+2YXTvxcrgQd5np
 y+iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWWky/Ul7k0svL1w84VB0khmtOiNCwKtEXVHHi/AGVUlTdKmPsf8x0cMp0hBJcFvd35rymqWo5daY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJlu6dC6KQduFXXAsa7x7X7vCGHQOusRPwDnbN83RebbC2Q+Azu
 YKuXQqT7ofVopfuI2+kMSZ/Yi34rWp+MXn0J09Ow/T381wmM7jHavu94fRc9Wia5gKkbxNvD6dm
 9iDSBaosHf/mpnhAUM7jcBJMcdVY97Irv3XMMGcqctz7bYefKuM8tvvtKjUexlFAupJwHbPSO5M
 j/rEDkpMyoaVFo/vX9sBGQUhGdUoA5CqpKaUvz/P14wszDmQ==
X-Gm-Gg: AYBFou1FkEHVJs//e/C00NCQvh7ikElt8R/gKqE9usIFvkQwfN8ztJMrh9P7P/Gewtl
 Oa+wL3/pnXnvGSmbIzAzNrZVWCm1o54pJpG82uUoz9VYvVrwVw4DT+F0wF6OK9z9xLv7NAsQfC4
 nYFptpEEaO5YPfJdPl7aYTFVQCA2sxnUHvhlJhQ2UJ9LcF0GuRpFPjivAMIw==
X-Received: by 2002:a05:6820:a28c:20b0:6f5:6ba1:aeff with SMTP id
 006d021491bc7-6f56ba1b18amr655432eaf.37.1791746820007; 
 Sun, 11 Oct 2026 12:27:00 -0700 (PDT)
X-Received: by 2002:a05:6820:a28c:20b0:6f5:6ba1:aeff with SMTP id
 006d021491bc7-6f56ba1b18amr655423eaf.37.1791746819486; Sun, 11 Oct 2026
 12:26:59 -0700 (PDT)
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 12:26:48 -0700
X-Gm-Features: AclHuK-wXtAQszxLAiJzWStuKUtS-jSj0vu8__CELnWePjfHAgcPQ7n0ultvhNY
Message-ID: <CACSVV02V-FOzGj71G0ZL7khkYEKWFW4q4biOZR8B8vyWy20PdQ@mail.gmail.com>
Subject: [pull] drm/msm: drm-msm-next-2026-10-11 for v7.4
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: JInitgDcAVxx8F7RPFAmwbnWOj7aWiDw
X-Proofpoint-GUID: JInitgDcAVxx8F7RPFAmwbnWOj7aWiDw
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acbe309 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8 a=gcM9zsgL9M5nzF_IVqQA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA3NyBTYWx0ZWRfX9tkKlcRGoP16
 WZf2AUoHLZc/eHjLKW7DyZ6nT4E5MKaZ/2DEw4WIYBy2TVTSu8RN/5NiydHl0tRs3e02JJAvLsj
 EINOLZSWje6qmJmOc0zFrIkIctrkVpGYK35ZUHIBegEgDnIALrt80kO9gApQwOl5k/YX4es+W4t
 mBZh6h5H3/Zpyr9KBCZRTIia01btIxxXSC3NZSifJHup2Gr0299LeH6yY1YEXgrflxcqYGF1skx
 fE+FVmK+jo1l06R4osGoZSyD2TABRZDD8+xxyP+mE1TGr/HlaEMQh4+/cAXevHrc+Y9gPDqAKNW
 z+TDuyIeJPMkAkOi+4xaAvK5dBIvvP7zRAv7G0sUCSYicJ72huXmqEwNp7Ybti1smX7zxg5sHqt
 US7HOCfA0lHhN2UO+ryvDDVQdIzZ1abiBj/cLBejzG38jPiIeoj9iThnP1yGBM3pDYJAXFq1hys
 ZlP0MuQXSzJmma+HKYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA3NyBTYWx0ZWRfXyi8FwK4ZJjaG
 o0pgJSlOZJ++istWTcuM5IwNuE2SjofwblnNCVzv0/OF41v3D0xMr6G+4eI8rziuXkGxTStvcU9
 SLtkDFNJ1fiNt1NR+JjMw1ZeSO5OOgE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110077
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Dave, Simona,

Pull request for v7.4, as described below.

The following changes since commit d33622598496c8994c35ba0a8a913de064dfc1a4:

  Merge tag 'qcom-drivers-for-7.4' into
msm-next-merge-qcom-drivers-for-7.4 (2026-09-26 07:53:04 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/msm.git tags/drm-msm-next-2026-10-11

for you to fetch changes up to d024361c631b3f020a26c07d683e5103404b0fbf:

  drm/msm/a6xx: Split out a7xx/a8xx device tables (2026-10-10 15:00:45 -0700)

----------------------------------------------------------------
Changes for v7.4

CI:
- Dropped sc7180 trogdor lazor from the CI

Core:
- Fixed msm_ioremap for resources without a name
- Changed msm.separate_gpu_kms to default to auto selection

GPU:
- Enable CLX (Current Limit eXtension) for gen8 to avoid
  exceeding limits on CX/GX rails
- New GPUs: a830 (Pakala), a845 (Maili), a850 (Hawi),
  x2-85 (Mahua)
- Fix VBIF halt mask on a306, which was preventing runpm
  suspend
- Enable THP support for GEM buffers
- Add modparam to disable waiting on fences in shrinker
- Drop use of drm_prime_sg_to_page_array()
- a5xx: don't read the GPMU registers on GPUs without a GPMU
- a2xx/a3xx/a5xx: hangcheck progress detection
- a6xx: gmuwrapper runpm fix
- Calculate reported GMEM size based on active slices
- Split a6xx/a7xx/a8xx catalog

DP:
- Picked up some preparation patches for the MST support
- Fixed reported status of the link training

DPU:
- Fixed CRTC bandwidth computation
- Fixed DSC programming
- Fixed encoder disablement path

DSI:
- Fixed VM leak in error path
- Indention fix

MDP5:
- Added MSM8952 configuration
- Dropped incorrect cursor pipe on MSM8976/56

HDMI:
- Small fixes

Notes:
- Merged qcom-drivers-for-7.4 to pick up UBWC_7_0 support
  (needed for Hawi/Maili) which in turn depended on
  qcom-arm64-for-7.4

----------------------------------------------------------------
Abhinav Kumar (3):
      drm/msm/dp: move link-level teardown from display_disable to
display_unprepare
      drm/msm/dp: introduce stream_id for each DP panel
      drm/msm/dp: add support for programming p1/p2/p3 register blocks

Akhil P Oommen (12):
      drm/msm/a6xx: Add HFI support for CLX feature
      drm/msm/a6xx: Enable CLX feature on A840
      drm/msm/a8xx: Enable CLX feature on Adreno X2-85
      drm/msm/a6xx: Honor perfmode_bw threshold on A8x
      drm/msm/a6xx: Fix secondary rail vote in ARC votes
      drm/msm/a6xx: Fix RPMH dependency votes
      drm/msm/a6xx: Factor out RPMh arc-vote helpers
      drm/msm/a6xx: Add BX rail support to GMU dependency votes
      drm/msm/a6xx: Clamp MX dependency vote
      drm/msm/a8xx: Add Adreno 850 support
      drm/msm/a6xx: Send THINMEM config to GMU for A850
      dt-bindings: display/msm: Document A850 GPU and GMU

Bhaskar Reddy Valluru (2):
      drm/msm/a8xx: Add Adreno 845 support
      dt-bindings: display/msm: Document A845 GPU and GMU

Dmitry Baryshkov (5):
      drm/msm/mdp5: drop cursor pipe for msm8x76
      drm/msm/a5xx: don't read the GPMU registers on GPUs without a GPMU
      drm/msm/a2xx: Add hangcheck progress detection
      drm/msm/a3xx: Add hangcheck progress detection
      drm/msm/a5xx: Add hangcheck progress detection

Jie Zhang (5):
      drm/msm/a8xx: Add support for Adreno 830 GPU
      dt-bindings: display/msm: Document Adreno 830 GPU/GMU
      dt-bindings: display/msm/gmu: Fix Glymur's compatible
      drm/msm/a8xx: Add Mahua GPU support
      dt-bindings: display/msm: gpu: Document Mahua GPU/GMU

Joonhoe Kim (3):
      drm/msm/dpu: disable the slave encoder before the master
      drm/msm/dpu: compute the CRTC bandwidth from the state being checked
      drm/msm/dpu: round up the compressed INTF width

Krzysztof Kozlowski (7):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during
.atomic_pre_enable()
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      drm/msm/hdmi_bridge: Drop redundant initialization in
msm_hdmi_bridge_init()
      drm/msm: Properly handle msm_ioremap() without name
      drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid()
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies

Mahadevan P (1):
      drm/msm: default separate_gpu_kms to auto selection

Muzaffer Kadir (2):
      dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
      drm: msm: mdp5: Add MDP5 configuration for MSM8952

Oleg Keri (1):
      drm/msm/dp: don't report link training success after a reinit

Rahul Pon (1):
      drm/msm/a8xx: report the GMEM size of the active slices

Rob Clark (14):
      drm/msm: Enable THP for GEM buffers
      drm/msm/gem: Add modparam to disable shrinker blocking
      drm/msm/dpu: Fix GAMMA LUT for sm8750 related DPUs
      drm/msm: Sync registers from mesa
      drm/msm/gem: Add helper to check if resident
      drm/msm/gem: Mmap imported dma-bufs via the exporter
      drm/msm/gem: Use get_pages() directly in vmap path
      drm/msm/gem: Stop exposing a page array
      drm/msm/gem: Stop calling get_pages() for imported dma-bufs
      drm/msm/gem: Drop use of drm_prime_sg_to_page_array()
      Revert "dt-bindings: display/msm: Document A845 GPU and GMU"
      Revert "dt-bindings: display/msm: Document A850 GPU and GMU"
      drm/msm/a6xx: Move a702/a704 to a6xx list
      drm/msm/a6xx: Split out a7xx/a8xx device tables

Roman Demidov (2):
      drm/msm/a6xx: fix use-after-free of OPP in a6xx_pm_resume
      drm/msm/a6xx: check pm_runtime_resume_and_get during resume

Sam Day (1):
      drm/msm/a3xx: fix VBIF halt mask for A306/A306A

Vignesh Raman (1):
      drm/ci: Remove sc7180-trogdor-lazor-limozeen job

Wentao Liang (2):
      drm/msm: Fix vm_bo use-after-free in with_vm_locks()
      drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()

Xilin Wu (2):
      drm/msm/dp: Serialize HPD state updates
      drm/msm/dp: Initialize the debugfs connector pointer

Yongxing Mou (4):
      drm/msm/dp: Pass panel to msm_dp_ctrl_config_msa()
      drm/msm/dp: drop redundant config_ctrl_link() from msm_dp_ctrl_on_stream()
      drm/msm/dp: add MST stream register definitions
      drm/msm/dp: add stream-aware link register accessors

 .../devicetree/bindings/display/msm/gmu.yaml       |    8 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |    3 +
 .../devicetree/bindings/display/msm/hdmi.yaml      |    4 +-
 .../devicetree/bindings/display/msm/qcom,mdp5.yaml |    1 +
 drivers/gpu/drm/ci/build.sh                        |    1 -
 drivers/gpu/drm/ci/test.yml                        |   10 -
 .../msm-sc7180-trogdor-lazor-limozeen-fails.txt    |   22 -
 .../msm-sc7180-trogdor-lazor-limozeen-flakes.txt   |   20 -
 .../msm-sc7180-trogdor-lazor-limozeen-skips.txt    |   30 -
 drivers/gpu/drm/msm/Makefile                       |    2 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   18 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   30 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   76 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |    2 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 1440 +--------------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  231 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |    1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   42 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   17 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   96 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |    1 +
 drivers/gpu/drm/msm/adreno/a7xx_catalog.c          |  502 ++++++
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c          | 1846 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   21 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    6 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    3 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   35 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |   17 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   10 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |    4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |    2 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |   14 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |   81 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  164 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |    8 +-
 drivers/gpu/drm/msm/dp/dp_debug.c                  |    1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |  115 +-
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  193 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |   17 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |   56 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |    2 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |    2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |   34 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                |   16 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   89 +-
 drivers/gpu/drm/msm/msm_drv.h                      |    6 +-
 drivers/gpu/drm/msm/msm_gem.c                      |  107 +-
 drivers/gpu/drm/msm/msm_gem.h                      |   10 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |    9 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |    9 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |    8 +-
 drivers/gpu/drm/msm/msm_io_utils.c                 |    6 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |   15 +
 drivers/gpu/drm/msm/registers/adreno/a2xx.xml      |   25 +-
 drivers/gpu/drm/msm/registers/adreno/a5xx.xml      |   17 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   89 +-
 .../gpu/drm/msm/registers/adreno/adreno_pm4.xml    |   41 +-
 57 files changed, 3771 insertions(+), 1864 deletions(-)
 delete mode 100644
drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
 delete mode 100644
drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
 delete mode 100644
drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-skips.txt
 create mode 100644 drivers/gpu/drm/msm/adreno/a7xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_catalog.c
