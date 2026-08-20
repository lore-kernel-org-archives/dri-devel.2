Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D003FC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80B210E5D5;
	Thu, 20 Aug 2026 13:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+vJvRi8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YDiecHWB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF09910E5D5
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:24:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KA2sQt3132160
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:reply-to
 :subject:to; s=qcppdkim1; bh=RvpLiPc2wHlGh/SWBZPyn8zXSSvK4L6cVmw
 wpxvtQ34=; b=S+vJvRi8jzCqEZmnnbCfkurgHCL4UMnKc8JEisJFQszWI+pk2uG
 cwB/okdy9MqEKSJTqidBPwJfLevIxi7kIZBZj0qn8qPdhyEAgnRXva/zfo2XfVFA
 AFfxeBzYhThunOtdSfbE4pWHlv44T2poJmmD08CliwxWFi8u8swXBmfCxpdhwXR4
 JDTKapfRu0KtBlRgq5DEsFVRf3uG5PdfWI3dJilczRhpuc/uf9L/MdOCarhfGzBi
 Coi4FVN6D347KhlxU6yHc2G6HY7NpnbAHD39dwYC/NcD3KToww8gJpRe9M3wFBBJ
 tV3Sb0bFpDtfQa6ldmNlCgt2ImXQUmcCk4A==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg18q4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:24:35 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-451d80641efso2446558fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787232275; cv=none;
 d=google.com; s=arc-20260327;
 b=akd+HQdgjug4Me8+RCtfndXI9MNpkxn21fzsIoa+S1bFXYVOIvql1no5Fkcp+RfvAA
 G+GsyVQioKds/l1W4zbnTesVZpz3G3mDYY/0LR7N4kU5VdWcIEwQA+70azL0ySoRneKU
 I9fBew+z2PpakWgmI2lVNP+GieZC131fgy4zjJ61nWuA9tpkiZshk2S8jdoNLUWaInQr
 Zqtlh5dKV0eVuULyPO35l4C2BFu00TqwgZNQvM6ANLfxATiVXe0DtYB7vP2JpDkCPzQN
 PpUMC2j9P3VnmtEGSyo5pD9im3L27LpmrAxl4+ZeajWPao1rQ1gEcWNIn4T3YfgkaHTw
 kY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=RvpLiPc2wHlGh/SWBZPyn8zXSSvK4L6cVmwwpxvtQ34=;
 fh=s+YGV0z06TMkTRvBPkwwGxctyCjK9j3TuIE2UUa9n+o=;
 b=icY1JjDV8IciyBOWoBZTIq3WhiOUf4K8IxQDHwwDFsp82PDfnej/fHbP36JHRz0l0E
 QN4nVWp0ee/ylhPHNqlxLsEgZ3sTA2DNIhsWPTh4sfj04q+XSpLZOHxWZ0YC8l9JurDD
 qGF0JuCcUWFLl3LwQ+4g28sJIeugSsW140wu1nmp0e3ZR+RqcB8LOSEex9QmnTQNSWaO
 ri6b++SNPKs4SFfdFcC0PQ+G7GN0mgnDUDPRqHbxBRjjTVZGNGjZvyh+QJYgMk3d9m2Z
 kkkONn2c2itW7Nm1lxdaVZKnjhzedLYy0U265E5xBr7okacPWyxWLNuKLLzdp47KsfPS
 wwaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787232275; x=1787837075;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RvpLiPc2wHlGh/SWBZPyn8zXSSvK4L6cVmwwpxvtQ34=;
 b=YDiecHWBuBg/0VRzMDIWNto3byOon0NOEASrSxSNH/K+IuAYh9d1LjqgAhz+tvNExU
 l1J6s89Sw6QcZkZFNwsLHkA/lak/pIoIFk0ivdjrvqMoUhhBY9YcWaKrdE67MGgI0roX
 Z2JyEDQtg8NjmHdT8MlbEwteh+lR6FPS7IvNKcVf7bX9US0bQknSCTNBtGpOArjcAN9c
 r+M7A1oUx+AZfjWd4xxr2Cly4eeBaph0Y4/CZla9XtA+9wzz/3syNrS+GRShW+8GGgCN
 XkWWToyE9CqBdakDh+tXpeha5JUZD2GauMFeVWvd6BLsgtoN3tCIpmGA3oXbIX9mtF+q
 wEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787232275; x=1787837075;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RvpLiPc2wHlGh/SWBZPyn8zXSSvK4L6cVmwwpxvtQ34=;
 b=RhlJjFbPxnS2n5J5JmHFCV1fzUwL27bZ4HJeNDRIrVGIJo2zPLSRVl6hVhZq8jIgyj
 CsCKPp+0GAje+e60KHYdWCwycVSDEf3YcqsZkTuGJ0Xr6eA9FvXj658dEvuk1hO6vXNe
 crCj6ixyXNtVcjibLMw2gkOudZ93w0SqQXOqxT2JVRgfRK2LCVOsLRBVQtE/7dUdBn7m
 Mni+h+bcnu+d5Iaiy7zmHhqToMVlZ7VRoDEY0dEQagQcgPpo9PY2Hzq6lLa8iDFVaDhs
 FQJmipBEQJuf3rXcE4CYWOy/dZQo/7DqRx+ThpH82Dt9nSZvvba8Gb+sFDpLCGLB840D
 QZzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4ceZhrX2KkPrdHPedMJb/zK9OwKnahKN2Sxa4kHA9C6ojxUro1Wt3JypUwbbTLdWM2xQxSWAEf+E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxv0u3sjCyfA8Wf0mDWuZoFEJEr+FqBlVpVdET/cpdQE5iLU1yv
 v3vYQ3Rmha4336kqTL2w0wbLinx6crffO113Kb/gfvgCT9k9QVYTzsVGa6llgo/SvudiSzCkwPH
 gn/yKjfUHmduL0Cj7sMTUwwoTj9FX5fNJPlC9Q2lDAuNf8Rt9e2V2KmZHP0RQ7EbWviu5HD5vuI
 +GhDEm44N6qYSuuLLsznK2/jHzadY8PdqgjqwH89Iq/4Q0hA==
X-Gm-Gg: AR+sD10AQcq8DXZtZ616gB64ZPR2wigBXOOao3gFttR6tVh0VWjryDzZ/tdql+b6aKa
 633p6GFxhe6/3HfNVvupmf1NzhNF2slIo7vJEWg4DApuv0c08E89G+ciJbk4ot1Adr5yUzpxJaL
 rCFEEhteKrvitXH8h8r1w19MS0CJZHzDv8ldJ7jQKLUf9RsJ8RZTkOb718
X-Received: by 2002:a05:6870:8261:b0:441:f3f6:622b with SMTP id
 586e51a60fabf-462f637e5bbmr12743399fac.5.1787232274769; 
 Thu, 20 Aug 2026 06:24:34 -0700 (PDT)
X-Received: by 2002:a05:6870:8261:b0:441:f3f6:622b with SMTP id
 586e51a60fabf-462f637e5bbmr12743335fac.5.1787232274218; Thu, 20 Aug 2026
 06:24:34 -0700 (PDT)
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 06:24:23 -0700
X-Gm-Features: AcwNN1U20ZuM0i8qBrFIYpMXIcV1fWkS0CwyIDx4euntVqWYn83XRIbIP5C_tZE
Message-ID: <CACSVV02Kp=J+w_RjEJbBbQnBYRb+SWdwMvVbCaAL70bq9EBagQ@mail.gmail.com>
Subject: [RESEND pull] drm/msm: drm-msm-next-2026-08-01 for v7.3
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: 1Q4qz9D_YqzSIhSlpntE2YiJfSdk52eF
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a870013 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8 a=ghuELz35WMKWYDI3F1sA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 1Q4qz9D_YqzSIhSlpntE2YiJfSdk52eF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwMCBTYWx0ZWRfXxG/zJWyajggG
 EeXj+kHi2Ls7p6x7HLyAgfHFmsZgDS6fTw8tXyy/J6xvoDSDbBol+kvrJaKtF5hC6BFxIcezhEh
 PWgvKvxBCPzFfKI1sUcGrg7gxEv27iM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwMCBTYWx0ZWRfX8UU1VCnoKCeD
 Nnk3QFTYCgc8CddKVXnLpztTgqgj4Bg5GW9jhdz1HaYXCt9d+vXbTdEHNW7n4IXm5OcdBmEmbtc
 Zcr1oxfAVyZ8L1Oi2L7MrS8nuiLWNzn1rRzP8tkBm8Sa6BLYPNkKCDOhN20K5gnl/tF2nRseR8O
 XArTnKj+bXucrnqUhSSl/sSN9H1E2v1fuNCr6+am7gUe39eIvHH8RZQ/0XtCHouYyCsQ5NVwTMy
 eaIUo9bp9o5QoEO08MXWsJpRPiI90xkWWqppBrm3sWuxWxLx8iXh+j2DCHaGeBeiMy7GxE0UY6H
 fsLGpaWQ2rQHZfiN0sneGyjIgtTEsDp9tNIDu4T3WrGxt3GLSTXYFsJz6nhbWgTvWpr68ecK+vj
 jgZa9VZ/FOzesFPAyok4XeAAPV4LUcgwMPqdJ4mzGAS+qalWaNyFXW2jlKK36kFxC+uriTZPIm8
 z2R8KoVa7gAXGNNEWOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200100
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

Somehow my pull req for 7.3 disappeared into the either so resending.

Pull for v7.3 as described below.

The following changes since commit a1c81cb05273077219fa809424330fdaa4346d5b:

  Merge tag 'drm-intel-gt-next-2026-07-16' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
(2026-07-17 11:48:25 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/msm.git tags/drm-msm-next-2026-08-01

for you to fetch changes up to 140b13475302601368c0cf4e193e66126a49feb3:

  drm/msm: detach the ARM DMA mapping before attaching our own domain
(2026-07-31 17:08:01 +0300)

----------------------------------------------------------------
Changes for v7.3

Bindings:
- Added Shikra support
- Document a840, a704, a722

Core:
- Use drm_client buffers for fbdev emulation
- teardown fixes
- ARM32 DMA fixup
- Remove objects from evict list when re-validated
- Bunch of corner case and error path fixes

DPU:
- Dropped dev_pm_opp_set_rate(0) preventing burnout
- Fixed SSPP offsets of Kaanapali

DP:
- Dropped dev_pm_opp_set_rate(0) preventing burnout
- Cleaned up core code in preparation for MST support
- Fixed prepare() to let Pipewire continue in case of the unplugged cable

GPU:
- Add support for a704
- Add support for a722

HDMI:
- Simplifed register access

----------------------------------------------------------------
Abhinav Kumar (5):
      drm/msm/dp: break up dp_display_enable into two parts
      drm/msm/dp: re-arrange dp_display_disable() into functional parts
      drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
      drm/msm/dp: split dp_ctrl_off() into stream and link parts
      drm/msm/dp: make bridge helpers use dp_display to allow re-use

Aditya Sherawat (2):
      drm/msm/adreno: Add support for A704 GPU
      dt-bindings: display/msm/gpu: Add support for A704 GPU

Akhil P Oommen (3):
      dt-bindings: display/msm: gpu: Document Adreno 840
      drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX- variant register
      dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC

Alexandre MINETTE (1):
      drm/msm/a3xx: Drain VBIF before GPU suspend

Anna Maniscalco (1):
      drm/msm: remove objects from evit list after pinning them

Bibek Kumar Patro (1):
      dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC

Dan Carpenter (1):
      drm/msm/adreno: fix use after free on error path in a6xx_gpu_init()

Dmitry Baryshkov (5):
      Revert "drm/msm: dsi: fix PLL init in bonded mode"
      drm/msm: don't tear down KMS twice when KMS init fails
      drm/msm/dp: reject YUV420-only modes without VSC SDP support
      drm/msm/dp: do not reject wide-bus modes while a YUV420 mode is active
      drm/msm: detach the ARM DMA mapping before attaching our own domain

Hans de Goede (1):
      drm/msm: Fix stale comments in uapi/drm/msm_drm.h

Jens Glathe (1):
      drm/msm/dp: add missing drm_edid_connector_update() before
add_modes on cached EDID

Jie Zhang (5):
      drm/msm: Recover HW before retire hung submit
      drm/msm/a6xx: Fix A663 GPUCC register list for state capture
      drm/msm/a6xx: Fix A621 GPUCC register list for state capture
      drm/msm/a6xx: Fix IRQ storm during msm_recovery test
      drm/msm: Fix task_struct reference leak in recover_worker

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Konrad Dybcio (3):
      drm/msm/dpu: Drop sneaky dev_pm_opp_set_rate(0)
      drm/msm/dp: Drop dev_pm_opp_set_rate(0)
      drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

Krzysztof Kozlowski (2):
      drm/msm/hdmi_bridge: Simplify register bit updates
      drm/msm/hdmi_hdcp: Simplify register bit updates

Kumar Anurag (1):
      drm/msm/dp: return 0 from audio_prepare when cable is disconnected

Nabige Aala (1):
      dt-bindings: display: msm: qcm2290: Add Shikra MDSS

Puranam V G Tejaswi (3):
      drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in a730_hwcg
      drm/msm/a6xx: Add Adreno 722 support
      dt-bindings: display/msm: Document Adreno 722 GPU and GMU

Rob Clark (18):
      Merge remote-tracking branch 'drm/drm-next' into msm-next-backmerge
      drm/msm: Fix barriers accessing ctx vm
      drm/msm: Rework queuelock
      drm/msm: Synchronize VM creation on ctxlock
      drm/msm: Synchronize set_sysprof on ctxlock
      drm/msm: Move nr_cmds initialization
      drm/msm: Remove redundant SIZE_MAX check
      drm/msm/a6xx: Access VM directly in submit path
      drm/msm: Add helper to check for per-process pgtables VM
      drm/msm/gem: Fix dma_buf import error paths
      drm/msm/gem: Remove useless locking in GEM import
      drm/msm/gem: Extract bookkeeping init helper
      drm/msm/gem: Set resv before exposing obj
      drm/msm/gem: Validate lazy VM in GEM_NEW
      drm/msm: Allow lazy VM creation to fail
      drm/msm: Don't fallback to shared VM for VM_BIND
      drm/msm: Fix per-process-pgtables check
      drm/msm: Fixup invalid overflow check

Rosen Penev (1):
      drm/msm/dpu: fix parameter name in
dpu_core_perf_adjusted_mode_clk kernel-doc

Ruoyu Wang (1):
      drm/msm: Only fini scheduler after successful init

Shivam Rawat (1):
      drm/msm/a6xx: Fix stale rpmh votes after suspend

Thomas Zimmermann (6):
      drm/msm: Do not declare msm_framebuffer_init() as static
      drm/msm: fbdev: Inline msm_alloc_stolen_fb()
      drm/msm: fbdev: Fix error reporting
      drm/msm: fbdev: Calculate buffer geometry with format helpers
      drm/msm: fbdev: Use a DRM client buffer
      drm/msm: Make msm_framebuffer_init() an internal interface again

Yongxing Mou (10):
      drm/msm/dpu: Fix DMA SSPP REC block offsets on DPU v13
      drm/msm/dp: remove cached drm_edid from panel
      drm/msm/dp: drop deprecated .mode_set() and use .atomic_pre_enable
      drm/msm/dp: move mode setup into msm_dp_panel_init_panel_info()
      drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and
stream parts
      drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
      drm/msm/dp: split link setup from source params
      drm/msm/dp: move the pixel clock control to its own API
      drm/msm/dp: simplify link and clock disable sequence
      drm/msm/dp: pass panel to display enable/disable helpers

 .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
 .../devicetree/bindings/display/msm/gmu.yaml       |   1 +
 .../devicetree/bindings/display/msm/gpu.yaml       |   4 +
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |   6 +-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    |  19 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   4 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |  36 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   5 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  40 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  24 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  14 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  86 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  17 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   7 +-
 .../gpu/drm/msm/adreno/adreno_gen7_17_0_snapshot.h | 428 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  17 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 .../drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |   6 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  12 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |  24 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |  11 +-
 drivers/gpu/drm/msm/dp/dp_audio.c                  |   4 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 395 ++++++++++---------
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |  30 +-
 drivers/gpu/drm/msm/dp/dp_display.c                | 311 +++++++--------
 drivers/gpu/drm/msm/dp/dp_display.h                |   9 +
 drivers/gpu/drm/msm/dp/dp_drm.c                    |  52 ++-
 drivers/gpu/drm/msm/dp/dp_drm.h                    |  12 -
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  75 +---
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  17 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |   2 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  14 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  18 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |  19 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  98 ++---
 drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c               |  85 ++--
 drivers/gpu/drm/msm/msm_drv.c                      |  26 +-
 drivers/gpu/drm/msm/msm_drv.h                      |  17 -
 drivers/gpu/drm/msm/msm_fb.c                       |  98 ++---
 drivers/gpu/drm/msm/msm_fbdev.c                    |  86 +++--
 drivers/gpu/drm/msm/msm_gem.c                      |  94 +++--
 drivers/gpu/drm/msm/msm_gem.h                      |   5 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |   2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |  31 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |  14 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |  10 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   4 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |  22 ++
 drivers/gpu/drm/msm/msm_ringbuffer.c               |   7 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |   1 +
 drivers/gpu/drm/msm/msm_submitqueue.c              |  24 +-
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml      |   2 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   2 +-
 include/uapi/drm/msm_drm.h                         |   6 +-
 57 files changed, 1553 insertions(+), 825 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/adreno_gen7_17_0_snapshot.h
