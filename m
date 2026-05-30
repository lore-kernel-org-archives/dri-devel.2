Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08F2CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02EC10E1B0;
	Sat, 30 May 2026 14:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="apDGgKFg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dELnJ7qD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF4710E1B0
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:30:31 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64UEPe473073455
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:reply-to:subject:to; s=qcppdkim1; bh=94b4SABWIooMk
 oPG6h1xSaYZTz0yIkKTaXGuZQGnqrU=; b=apDGgKFgmgIcdad8LN3uFv7xgc+GR
 MvCBtRQ0UdziUiVKqKQzG0lHC0ewV5GMNrMU9Sq2lDNU5zl/PA/2I3hUwXta6e4v
 as4aPzsusQxY3zTM3K9SQROCfKCptLpEcoe5K66sOhv48gUgloXIbOW4o12ZqGdt
 GLFOtgz3/AuHPhUPYunTC7W0XN7RpVymu23SX7vJB0ygFY8n1eJGVrWEbozqDFjh
 5XYFb45IxRvpZ9sVZIWNxVsebkgCYlPvGEF3Z6qyeOeRRuXdAhrCKcX0UsDA7fFQ
 tZdsp72SP0qDWYaQnbBFfIB1ZgUFov7QFzKkJ9N9F/WNZRR9se8Wp3bLA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efn8phqpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:30:30 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-439ba95ef42so8413343fac.1
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 07:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780151430; cv=none;
 d=google.com; s=arc-20240605;
 b=gSH21RqYhLy144z1tmvsk8zylGyNGPzpQ2vBrF7HCmfUKpQRBixdyDlNjzx69YxxJ/
 cJpdrCnw2ETz4/zVgKpPJLMeq2nGjtXD4SZci5ixtX2icOIpNI90IU4Qcve63SVrxheP
 pfopvBb0AFzvfLtCCMcLKo2pOESbNtej1MnVxXhG9f9QsVHnLl5jy9H4JGYI34gQttQX
 5+9lutXpsdv7ma7Gr+TtcnFvefvRhxQE3tShpQI6ldNcKwzxaCncnG5No3aRNO6k231n
 xg2GhnFYQ5w7zbiHVgu+6C88ZMc9f3rjwNWDYTLSkcvBOF1efAgUZPQzs5P/v/XMHr9t
 cSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:mime-version:dkim-signature;
 bh=94b4SABWIooMkoPG6h1xSaYZTz0yIkKTaXGuZQGnqrU=;
 fh=lUa31pXghKJJA2PenM0whbt+5Zk//abQDn787iXH3eQ=;
 b=QY+HOnNTSNmS0CdxiE5LmrjO/LlI3ENMACcLHbAV7F5R+tqd6W3j5kFaUNq9f9m9Z9
 /XoLFwbNrsGgt/woihAyq+ILAq2+srxADMgzVQE5R62wcfWB60SDXfcPtGkLp4ENR08A
 qb6bc1YNEPO+LQieI6LqmVwfQCuT722ZNQi+cPZA+jRAgUWn3AnuNnomUrOJL+NaoQfo
 JPsnvp4DdW4HY/PbO7lfmad2u231uddJFE289bFeSZ1KSWY0x2FpVV3N5EruZJavKl8T
 NAa1Y7cMbroI4+KzEcbKpkiAvDu0ALCTFGxHkaY72PpAw3jwvxbhPhxnaFBnWR8ld6hF
 OEjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780151430; x=1780756230;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=94b4SABWIooMkoPG6h1xSaYZTz0yIkKTaXGuZQGnqrU=;
 b=dELnJ7qDLdSz2KI8zEvSy7AbcSkpX7FRAt+cCO/b7h7J0j5CNY1PC99lW2sJI+rRbZ
 ZGyPhjDWDbmWmhJmWQuGRu1SuNlSZ5dWCZAqJ51YnGdIxTs+yVIyCPSMMjhqFSQuYRqp
 rJkSaA/2ygmo+s6WZILrDy4bytk/AkR28Z+KZh1GAx4UJxPryAnlprr2WZ1cUbgsZzp3
 h/p0DkOLjaKa0rj7Hz1gYJ2yBuGTT6XBYrbSHVg5VAh8h5BKZI1hjejY5SXZ8QW11jCo
 x0+peuPwAjIEjCli10yjxzh92LpYNCs+YyIgWG295mfs5IgIogT/r4vR0VN89ae6tLlK
 v1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780151430; x=1780756230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=94b4SABWIooMkoPG6h1xSaYZTz0yIkKTaXGuZQGnqrU=;
 b=MmcEVfgseojYDRtNOXifdHtdqFm5Kn91UMJYYVtiakg0HiEcixrrPwKZ7s/+dXqHNM
 h5/n9tmd06sRUrsoDNtpzWuNxNnDbT0UYLYT3+iwma/uh7rsBIfPM3KZUcdhFkwFnSKO
 rWYCsjChxwUpkr7wH0ObkWGP1rP9S4sWB86fVFvou/QTdb8IzhnOjxpoRqMYIacziMnC
 joc4IOGTwtREpQ9YgevO5aANEQTrWiBtRg517luERMLb9z3qOLu8lx2U8IaRMvJ36IKm
 F2vb/AcbKOd5VwPxpDfnZNIxipiD+oPKPorvlno3Kq50tRWmiBQfQEWXjpv9TvRpdjc1
 ONhQ==
X-Gm-Message-State: AOJu0YwX/QXV3Bsvn/VEoH6kzD6BGB2V2kjNh7W+TKiL5SqWkLOpdGop
 9j7QCZ+M8GcARNZ7mT65PKFnL1mg2teATshtVVNSCM0fLByLSN1HdaKvf1ExLfWS5JSU0ghSwNb
 vLFC44nJIJaIIDhuizsry5lv1nFb1mPMs0QC5mrvW3zUNpwzTCa6JSHUf/CZ5/DDeG5LltHg2j7
 6eEp8ryV3ywZK4+52iTOBjntXabrfD9jeSnk8PkpIknUoP0Q==
X-Gm-Gg: Acq92OFZqB5MTtG3LtpT6+ivMvyn6Zen+2sLAtDNCgiC2b0DCSNR3Mi7oN4J7Ovu1rt
 N6BIottfQ5/GJ85LYmbzxMey0VFLDPz8zr1eripuJsXA1FMce1DqSfH9j1XrH+ttpHNrMSdJtM2
 jC9Bl7kIdgKyoIZ54zPfjNJKKn2CMrtvq7eh3lnG7n1WSxJftjV08xaaGbr0dUM6sVsxZ7U5xHn
 6Q1pDBL2iRL4o1/80AqDuDMyb3k0peOketckvuRaJJ+J4UB
X-Received: by 2002:a05:6820:1621:b0:69d:e72b:6e11 with SMTP id
 006d021491bc7-69e10563f35mr1741778eaf.28.1780151430045; 
 Sat, 30 May 2026 07:30:30 -0700 (PDT)
X-Received: by 2002:a05:6820:1621:b0:69d:e72b:6e11 with SMTP id
 006d021491bc7-69e10563f35mr1741766eaf.28.1780151429528; Sat, 30 May 2026
 07:30:29 -0700 (PDT)
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 30 May 2026 07:30:18 -0700
X-Gm-Features: AVHnY4I69VxBE6ImxeNb_L-JHy74X4T7NUKevkyadIKj1fkuh1bi7M6PQGlaGW4
Message-ID: <CACSVV00DXZcvFH2-C3fouve5DGs0DGa-vvsJPuaRmUZZVNKOfg@mail.gmail.com>
Subject: [pull] drm/msm: drm-msm-next-2026-05-30 for v7.2
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <dri-devel@lists.freedesktop.org>, 
 "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <freedreno@lists.freedesktop.org>, 
 "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <linux-arm-msm@vger.kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: HqZlEWW3-0JP9HUQbXJPFz2E8TclbJ8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE1NiBTYWx0ZWRfX80BYP87t0pZP
 yTilKwlvYtp8YvK26GeceujuRtkPUqBDL7WRBEIrk94Uxwtg8atMFZDYnpRtWon5Wi/qfDHoSZH
 cbsNSidlnRmwE6/yVYxTh5UX/hLDrh8Pk676vBt15/DaZqNX58qf7vu5/0KnwW1A3CJGU4E5OTJ
 k+B01FJWjdPMOf/iy2RRyKozERnibnrCp686kQ2n0LBhU3LtfBHxrV3Ep0iNoLGhoOxVRQs5oEC
 eIvIInm69pJI5EdFSRecZ9Gf/zrrIuCh8kRGT6yKfCNi6wYQ+23xNwSoaAzNuMpHrM03agN5LFQ
 vw7/ffVyRAnGc2W5ym/3jAfCT6i5ecxqWu+7nRzr/NIzBlSrWEboP0QcdUnnkz4fU+Or43h3/wp
 DXMRODGGWSxywItUkqnrq+7g9viDBElGCxxbFFZaWmfofLzNC1tyKpOlxUsGzLgvxARujg4XkkC
 182PNYUOnxHCylCEKrw==
X-Authority-Analysis: v=2.4 cv=NvvhtcdJ c=1 sm=1 tr=0 ts=6a1af486 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Nj4kNrkhgOgHlvf3R2wA:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: HqZlEWW3-0JP9HUQbXJPFz2E8TclbJ8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300156
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

Pull for v7.2, as described below.

There is a new ioctl for perfcntr support.  Corresponding mesa MR for that =
is:

  https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41158

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731=
:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/msm.git tags/drm-msm-next-2026-05-30

for you to fetch changes up to 9a967125427e03c7ebc24d7ad26e9307e8403d4e:

  drm/msm/adreno: add Adreno 810 GPU support (2026-05-29 07:07:31 -0700)

----------------------------------------------------------------
Changes for v7.2

Core:
- Fixed documentation for msm_gem_shrinker functions
- IFPC related enablement/fixes for gen8
- PERFCNTR_CONFIG ioctl support

GPU
- Reworked handling of UBWC configuration
- a810 suppport

MDSS:
- Added Milos platform support
- Reworked handling of UBWC configuration

DisplayPort:
- Reworked HPD handling, preparing for the MST support

DPU:
- Added Milos platform support
- Reworked handling of UBWC configuration

DSI:
- Added Milos platform support

----------------------------------------------------------------
Akhil P Oommen (4):
      drm/msm/a8xx: Make a8xx_recover IFPC safe
      drm/msm/a6xx: Limit GXPD votes to recovery in A8x
      drm/msm/a8xx: Fix RSCC offset
      dt-bindings: display/msm: gpu: Document Adreno X2-185

Alexander Koskovich (7):
      drm/msm: Fix GMEM_BASE for A650
      dt-bindings: display/msm/gmu: Document Adreno 810 GMU
      dt-bindings: display/msm/gpu: Document Adreno 810 GPU
      drm/msm/adreno: rename llc_mmio to cx_misc_mmio
      drm/msm/adreno: set cx_misc_mmio regardless of if platform has LLCC
      drm/msm/a8xx: use pipe protect slot 15 for last-span-unbound feature
      drm/msm/adreno: add Adreno 810 GPU support

Chen Ni (1):
      drm/msm/a6xx: Check kzalloc return in a8xx_hfi_send_perf_table

Daniel J Blueman (1):
      drm/msm: Fix shrinker deadlock

Dmitry Baryshkov (30):
      drm/msm/dsi: don't dump registers past the mapped region
      drm/msm/dpu: don't mix devm and drmm functions
      drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
      drm/msm/snapshot: fix dumping of the unaligned regions
      soc: qcom: ubwc: define UBWC 3.1
      soc: qcom: ubwc: define helper for MDSS and Adreno drivers
      soc: qcom: ubwc: add helper controlling AMSBC enablement
      Merge branch
'20260507-ubwc-rework-v4-4-c19593d20c1d@oss.qualcomm.com' of
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into HEAD
      drm/ci: disable mr-label-maker-test
      drm/msm/mdss: correct UBWC programming sequences
      drm/msm/adreno: use qcom_ubwc_version_tag() helper
      drm/msm/mdss: use qcom_ubwc_version_tag() helper
      drm/msm/adreno: use new helper to set min_acc length
      drm/msm/mdss: use new helper to set min_acc length
      drm/msm/adreno: use new helper to set macrotile_mode
      drm/msm/mdss: use new helper to set macrotile_mode
      drm/msm/mdss: use new helper to set UBWC bank spreading
      drm/msm/adreno: use new helper to set ubwc_swizzle
      drm/msm/dpu: use new helper to set ubwc_swizzle
      drm/msm/mdss: use new helper to set ubwc_swizzle
      drm/msm/adreno: write reserved UBWC-related bits
      drm/msm/adreno: set fp16compoptdis for UBWC 3.0 formats
      drm/msm/adreno: use new helper to set amsbc
      drm/msm/adreno: use version ranges in A8xx UBWC code
      drm/msm/mdss: use new helper to set amsbc
      drm/msm/dpu: drop ubwc_dec_version
      drm/msm/dpu: invert the order of UBWC checks
      drm/msm/dp: drop event data
      drm/msm/dp: turn link_ready into plugged
      drm/msm/dp: clear EDID on display unplug

Felix Gu (1):
      drm/msm/adreno: Fix a reference leak in a6xx_gpu_init()

Jessica Zhang (7):
      drm/msm/dp: fix HPD state status bit shift value
      drm/msm/dp: Fix the ISR_* enum values
      drm/msm/dp: Read DPCD and sink count in bridge detect()
      drm/msm/dp: Move link training to atomic_enable()
      drm/msm/dp: Drop EV_USER_NOTIFICATION
      drm/msm/dp: rework HPD handling
      drm/msm/dp: Add sink_count to debug logs

Konrad Dybcio (1):
      drm/msm/adreno: Trust the SSoT UBWC config

Krzysztof Kozlowski (5):
      dt-bindings: display/msm: dp-controller: Correct SM8650 IO range
      dt-bindings: display/msm: dp-controller: Allow DAI on SM8650 and othe=
rs
      dt-bindings: display/msm: sm8650: Correct VBIF range in example
      dt-bindings: display/msm: sm8750-mdss: Correct DPU and DP ranges
in example
      dt-bindings: display/msm: qcom,eliza-mdss: Correct DPU and DP
ranges in example

Lad Prabhakar (1):
      dt-bindings: display/msm: Fix typo in clock-names property

Luca Weiss (7):
      dt-bindings: display: msm-dsi-phy-7nm: document the Milos DSI PHY
      dt-bindings: display: msm-dsi-controller-main: document the
Milos DSI Controller
      dt-bindings: display: msm: document the Milos DPU
      dt-bindings: display: msm: document the Milos Mobile Display Subsyste=
m
      drm/msm/dsi: add support for DSI-PHY on Milos
      drm/msm: mdss: Add Milos support
      drm/msm/dpu: Add Milos support

Mahadevan P (1):
      drm/msm/dpu: Fix Kaanapali CWB register configuration

Mikko Perttunen (1):
      drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN

Nathan Chancellor (1):
      drm/msm: Restore second parameter name in purge() and evict()

Neil Armstrong (1):
      drm/msm/dpu: fix UV scanlines calculation for YUV UBWC formats

Rob Clark (18):
      drm/msm/a6xx: Restore sysprof_active
      drm/msm: Correct modparam description
      drm/msm: Remove obsolete perf infrastructure
      drm/msm: Allow CAP_PERFMON for setting SYSPROF
      drm/msm/adreno: Sync registers from mesa
      drm/msm/registers: Sync gen_header.py from mesa
      drm/msm/registers: Add perfcntr json
      drm/msm: Add a6xx+ perfcntr tables
      drm/msm: Add sysprof accessors
      drm/msm/a6xx: Add yield & flush helper
      drm/msm: Add per-context perfcntr state
      drm/msm: Add basic perfcntr infrastructure
      drm/msm/a6xx+: Add support to configure perfcntrs
      drm/msm/a8xx: Add perfcntr flush sequence
      drm/msm: Add PERFCNTR_CONFIG ioctl
      drm/msm/a6xx: Increase pwrup_reglist size
      drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
      drm/msm/a6xx: Allow IFPC with perfcntr stream

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      drm/msm: Don't use UTS_RELEASE directly

 .../bindings/display/msm/dp-controller.yaml        |   28 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |    2 +
 .../devicetree/bindings/display/msm/gmu.yaml       |   30 +
 .../devicetree/bindings/display/msm/gpu.yaml       |   19 +
 .../bindings/display/msm/qcom,eliza-mdss.yaml      |   20 +-
 .../bindings/display/msm/qcom,milos-mdss.yaml      |  286 +++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |    3 +-
 .../bindings/display/msm/qcom,sm8650-mdss.yaml     |    2 +-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     |   16 +-
 .../devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml  |    1 +
 drivers/gpu/drm/ci/gitlab-ci.yml                   |    4 +
 drivers/gpu/drm/msm/Makefile                       |   29 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |    7 -
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   16 -
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |    3 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   27 +-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  298 +++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   89 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  363 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   30 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |    2 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c          |    2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  104 +-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c          |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   10 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   19 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   10 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_2_milos.h |  279 +++
 .../drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |   12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   29 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |   39 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |    3 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |   28 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   16 -
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |    1 -
 drivers/gpu/drm/msm/dp/dp_display.c                |  722 +++----
 drivers/gpu/drm/msm/dp/dp_display.h                |    3 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                    |   63 +-
 drivers/gpu/drm/msm/dp/dp_drm.h                    |    2 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |    8 +
 drivers/gpu/drm/msm/dp/dp_panel.h                  |    2 +
 drivers/gpu/drm/msm/dp/dp_reg.h                    |    4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |    1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |    2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |    1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |   23 +
 drivers/gpu/drm/msm/msm_debugfs.c                  |    6 -
 drivers/gpu/drm/msm/msm_drv.c                      |    2 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   13 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |   40 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |  123 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |  104 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |    5 +-
 drivers/gpu/drm/msm/msm_mdss.c                     |  125 +-
 drivers/gpu/drm/msm/msm_perf.c                     |  235 ---
 drivers/gpu/drm/msm/msm_perfcntr.c                 |  670 +++++++
 drivers/gpu/drm/msm/msm_perfcntr.h                 |  155 ++
 drivers/gpu/drm/msm/msm_ringbuffer.h               |    2 +
 drivers/gpu/drm/msm/msm_submitqueue.c              |    3 +-
 .../drm/msm/registers/adreno/a2xx_perfcntrs.json   |  109 +
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml      |    8 +-
 drivers/gpu/drm/msm/registers/adreno/a5xx.xml      |  141 +-
 .../drm/msm/registers/adreno/a5xx_perfcntrs.json   |  128 ++
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      | 1300 ++++++------
 .../drm/msm/registers/adreno/a6xx_descriptors.xml  |   71 +-
 .../gpu/drm/msm/registers/adreno/a6xx_enums.xml    |    3 +
 .../drm/msm/registers/adreno/a6xx_perfcntrs.json   |  112 ++
 .../drm/msm/registers/adreno/a7xx_perfcntrs.json   |  228 +++
 .../drm/msm/registers/adreno/a8xx_descriptors.xml  |   96 +-
 .../drm/msm/registers/adreno/a8xx_perfcntrs.json   |  241 +++
 .../drm/msm/registers/adreno/a8xx_perfcntrs.xml    | 1929 ++++++++++++++++=
++
 .../gpu/drm/msm/registers/adreno/adreno_common.xml |   42 +
 .../gpu/drm/msm/registers/adreno/adreno_pm4.xml    |   50 +-
 drivers/gpu/drm/msm/registers/gen_header.py        | 2079 +++++++++++-----=
----
 include/linux/soc/qcom/ubwc.h                      |   22 +
 include/uapi/drm/msm_drm.h                         |   48 +
 80 files changed, 7624 insertions(+), 3133 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_2_milos.h
 delete mode 100644 drivers/gpu/drm/msm/msm_perf.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.jso=
n
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.xml
