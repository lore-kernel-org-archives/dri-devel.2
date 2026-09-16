Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172C7C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F37410E03C;
	Wed, 16 Sep 2026 16:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nhw4UNJk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gG06qqXN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67FF10E03C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:48:21 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeNJA3709115
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:reply-to
 :subject:to; s=qcppdkim1; bh=ndtfDnMzOItYaqfMXX9EhB8LCDaP/lEclZx
 u5jQm/Do=; b=Nhw4UNJk9MfuvR/7n3Hn2bV+QbhaBXbbBSdhh0EubtD0cyv/ax/
 af+8CrYyALzykkvyHHLJs0LC2kL9gRqPyYFfrp2KxbHXc3wE2j5gSP34MvN5EI3e
 dJA7YBBD61mC2EuG5h5+C9N4uHr6z0gUO00diznoyCOmYmJhg7/RDl+x1pbielTa
 wau7zkVlgH9Kq0GTlwSaD/m6yOGL1milfbuxNc/HKKBrJLSq+LJ1Qh8srQ8T+kTy
 0FiueGfV2C5OxOZeCf1IGfLVFofO1zfK374JtIOwU9MJo74vgVQ5h5SGimJobd13
 bnPxAJMRjKq+XAjyj+srzz7wteSOWBQ7hTg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqfvfky9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:48:20 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-46524220c5aso6753729fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789577299; cv=none;
 d=google.com; s=arc-20260327;
 b=UiHBEwwziemzM13qrF3yYHQk126jTS1BPt03fN3cFTS1ZvYzB5f788Q7DjLRRQ1xEy
 KJZPFa5ELtog1z9mbnTjNB0BjAA6fAIXDj/BxcROIMo5NZw1Pap+5Wi/cDCs5LhWA70t
 iynTfqYCW4AgcUuJauAWSobAe1J5KU7QqWPgUmBr7dpfpjff0XHZeN508hZ1t5FofH1f
 8ixuCt/6u0S6Mq4pcwtkZqkbUfPxVf2v0nC4bxsVeOEAkKb3ITnzeOFx/PYFCetykbc6
 ucdymTh2r+AVGS+AWMKbGXIFsf8B9uGz9eLYBhUtXEHH5qxLVc0mzLGNAJjH7l6OJzQW
 Bkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=ndtfDnMzOItYaqfMXX9EhB8LCDaP/lEclZxu5jQm/Do=;
 fh=clP5otieQdioyjYVtAEEb7JREOhkmgJhgNXNlt6LZlA=;
 b=lofNmexxAQ8mgDbJiWjnprgmNT6Pycv2LSVQAnJuC4HX8N1DimvzrfuXxrINqmxpSI
 s04h++JUcVdcYs/RVOo6k/pHyK3Cu3KU0DxVkRC89sf8nWIikehyis/oS3sv2xa3tx5Y
 SnQGEXdRR5JgESzypKb9EtG9yFekU3JKFbHnyIFVELSVNK3E6XehIvBO2fJtfhzWzFFH
 7UOxEYZGx01qB9rnAoSOCYmZJeatygUsjEY4jV4GIt3xeoyaHMbhIn5rcEIfk3c2y3aH
 64jpftFE9mIBeai0riysYwitzpVAPbxDba9Qw5nP35E5FFJrHWw5KxWxtG2Vlu8VL1XP
 rLNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789577299; x=1790182099;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ndtfDnMzOItYaqfMXX9EhB8LCDaP/lEclZxu5jQm/Do=;
 b=gG06qqXNPyUDBpDAAJpzrBj2e1CZx3b41sXxhNaXVTjMYatDs4Ori4RO+UmuPDyL4L
 C3pxUW4SfM/NnoEaVIk1qR+Lkoh7nXzqoC+52t80fDqmSUxrGacT9DiM/iiNQQKkE4QK
 VFLwzf7V7a7YFa6Gm6bwIWpwiO1RRG2HTwqMSiEY0dOtanBczYZkcBbe5/KWex/nn6ZG
 Pn6ZxuV60SSyEgFriPwJ7sxAi6vMxUslChwVF2RjiI6vLplRaj/4WBWPULucJPrK9Vo3
 zCVkBmOtp+fnZRNdc/to1/B6oEkBG7ZdTUYmdUioBNkv1D98wUzHbRPeZNa2+tIfHHGg
 O1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577299; x=1790182099;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ndtfDnMzOItYaqfMXX9EhB8LCDaP/lEclZxu5jQm/Do=;
 b=Qr17tPenkYLqdJ5DPrbl6QifUYF4hKy3zwsa6WcawOrZBVWo8lQzFOcPzWuhvQb8fg
 BrJUixRuNOExki2KFsBVb8osernolz1df2elb5jpLCGPMT/X28znLQ56DhtGAm/K7YJw
 FRomWTkyVAMf56oV1or4bm70saU9OVMw532iG3NeqfbBhuXodSaGpEN6B9FgwVSCKobI
 DI00OdQ7sZz0YXe+V87UOPFp3IfCKG/OEmdjicS2rML9e6qfPLM870wvMkZoxycuQD4a
 UKx338cbuHGWMCwoZT9NPqTpvzMn0ghC6g9XFIUw/lsho6vtg4RS5DelDsZEjchNDDQm
 5dzA==
X-Gm-Message-State: AFuF++mPjpjI0rNZdqsA+l+Or/oqA88Aa/rwRz+A0PGTgr2/gYxdi+ht
 Z23J8R/n/VlvoFMqrOibPAaCCKHxe2hrjo8wUMEEemnz+iRs+/z29QD5+Ebw7PiTkyi2cazY/17
 +2MbQUym/bl71s0fXon29aE5AzqNPFOzLAfladTw71cMh+Fn8wWb9u7E8ZJLvBODzE7UOnNrM1s
 kyOjWpS4hI5DAcKHL8iRXyOC85lA55kshxtSVS9q8sJ5JyYQ==
X-Gm-Gg: AYBFou2v34UqCWj4yOJrDtFQ9/VMtDU0Y70KdvmxBdCaq8+jVK19tuLxhTyDdE2jKAf
 y14hJKR1O+qJTx3rM6bbxpEDvO2m0REjrHDvfsypxPR2k37XrySOqJNDi8vxo6Z+S2zfh1cFHF7
 BC2L2p8DMVjYlFBGLD6QQrOX4LvT8R++5GcbHuvmcJ8msiUw19S0CWB/6c
X-Received: by 2002:a05:6820:2918:b0:6bd:7732:adc6 with SMTP id
 006d021491bc7-6c7d1ad0f1fmr3608881eaf.17.1789577299433; 
 Wed, 16 Sep 2026 09:48:19 -0700 (PDT)
X-Received: by 2002:a05:6820:2918:b0:6bd:7732:adc6 with SMTP id
 006d021491bc7-6c7d1ad0f1fmr3608859eaf.17.1789577298933; Wed, 16 Sep 2026
 09:48:18 -0700 (PDT)
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:48:08 -0700
X-Gm-Features: AcwNN1Xs2qsK7N5X5y4rnsKq3hyloIUXdh_jq5FWdCG-lVMbMqzchSg9OgBCCag
Message-ID: <CACSVV021rZsjmiPEyR_LR7L=k7=DRV0QdsA50BF_Gd0s2DXaCw@mail.gmail.com>
Subject: [pull] drm/msm: drm-msm-fixes-2026-09-16 for v7.3-rc4
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=JYkpPkKV c=1 sm=1 tr=0 ts=6aaac854 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8 a=8FDDF9oY24P6SjVuP7IA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyOSBTYWx0ZWRfXzv4hSq2MVXYZ
 mVcX+25IOUtj2a+XLT51bHVfSXWPPn49sW8lx8Ye/pkEKWPoadiJuBW7ZquOLf2BUxO4j9wjy6L
 nOzMoXiAuVHV1th+ev0ZkGCBu9QhWQSqt8h4RqoOAPPN/30ugc1oWX9yoe1kdqm6qWAQYg1WUmX
 3vizMkPipqYbKyzmrj3cl550/z0fWSXuCvBEfR0CsiMVd1sHm7kFxz2Tq93IlZLMANzvWlBsLFe
 nMq3ArgIl1y75vwBGeNZyZzGjSPfGquTaKOcrdu/IStAGQV1tO0+CTg8of3ZND6Zey9uyhiHO2z
 FIjiH/pZYns9EghxHq0dv6UAIhelg+JCWLE4DOtAhY0uYRvpaqUkr4mfP85ghgmQWGPRnnSHmh9
 fRqCip4wuoouvmN3LKbrHrmMuwvK0W6eIwH4FshidRD1tf0KPVT7i8KbZtZD3WCwOPC9YJpcr0W
 j9VhLU1Ci9s37/EpRtQ==
X-Proofpoint-GUID: STgvucLWC43YuIEoAkzYOhIBVjiLFTtD
X-Proofpoint-ORIG-GUID: STgvucLWC43YuIEoAkzYOhIBVjiLFTtD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyOSBTYWx0ZWRfX91MeIzGkmp8p
 DWQBk9T0N/rFi8SYF0MwD+a87Bunju55wtlUVb5Stm9rYU5kGKOZ//Z+JgqPV5zwR3HlulGDJ3D
 6E/q8zrQ32Lj9dDMJ5XKcpwl3FOzefg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160229
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

Fixes for v7.3 as described below.

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/msm.git tags/drm-msm-fixes-2026-09-16

for you to fetch changes up to a15fac810c76397ec9f62a6fc26c4d7ab6e238a7:

  dt-bindings: display/msm: Use consistent indentation in the example
(2026-09-15 02:09:28 +0300)

----------------------------------------------------------------
Fixes for v7.3-rc4:

DT:
- Corrected indentation

Core:
- Marked fbdev as system memory

GPU:
- Fixed autosuspend cleanup on teardown
- a750: fix timestamps
- Increase GMU fw init timeout
- Misc fixes/cleanups

DPU:
- Fixed clock rounding, unbreaking newest platforms
- Cleared pending flush state

DP:
- Skip PUSH_IDLE when link was never enabled
- Fixed bandwidth checks

HDMI:
- Fixed runtime PM cleanup on probe failure

----------------------------------------------------------------
Dmitry Baryshkov (2):
      drm/msm: mark the fbdev framebuffer as system memory
      drm/msm/dsi: round the byte clock rate after reparenting to the PHY PLL

George Emmanuel Thomas (1):
      drm/msm: remove stale perf counter XML TODO

Guangshuo Li (2):
      drm/msm/adreno: fix autosuspend cleanup during teardown
      drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure

Jesse Casco (1):
      drm/msm/dp: skip PUSH_IDLE when the link was never enabled

Jonghyuk Kim(MalHyuk) (1):
      drm/msm: RCU-free the scheduler-containing ring and VM objects

Karl Mehltretter (2):
      drm/msm: Fix the separate_gpu_kms parameter description
      drm/msm/adreno: Fix the skip_gpu parameter description

Krzysztof Kozlowski (1):
      dt-bindings: display/msm: Use consistent indentation in the example

Neil Armstrong (2):
      drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
      drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs

Paul Hollinsky (1):
      drm/msm/adreno: Only check for PAS when a zap shader is present

Rob Clark (2):
      drm/ci: Update xfails for kms_cursor_legacy regression
      drm/msm/a6xx+: Increase GMU FW init timeout

Saim Shujah (1):
      drm/msm/dpu: clear pending peripheral flush state

William Bright (1):
      drm/msm/dp: fix link bandwidth check when wide bus is enabled

 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    |  6 +-
 .../bindings/display/msm/qcom,sar2130p-mdss.yaml   |  4 +-
 .../bindings/display/msm/qcom,sm6150-dpu.yaml      | 14 ++---
 .../bindings/display/msm/qcom,sm8350-mdss.yaml     |  2 +-
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 68 +++++++++++-----------
 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt    |  7 +++
 drivers/gpu/drm/msm/Makefile                       |  1 -
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 12 +++-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            | 15 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c                | 21 ++++++-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 | 36 ++++++------
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                |  8 ++-
 drivers/gpu/drm/msm/msm_drv.c                      |  2 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |  1 +
 drivers/gpu/drm/msm/msm_gem.h                      |  3 +
 drivers/gpu/drm/msm/msm_gem_vma.c                  |  2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c               |  2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |  1 +
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml  |  2 +
 22 files changed, 128 insertions(+), 84 deletions(-)
