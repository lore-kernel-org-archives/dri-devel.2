Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B066C55173
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 18:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861BC10E384;
	Sat,  1 Aug 2026 18:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBbJuUWu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C28rCMgn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BBA10E381
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 18:21:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 671FagTM3612507
 for <dri-devel@lists.freedesktop.org>; Sat, 1 Aug 2026 18:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:reply-to
 :subject:to; s=qcppdkim1; bh=quM45oRV1E0D0EZHxomja/jcIXyUYHi8Tfm
 52Stde1Q=; b=CBbJuUWuqBwPEViutLwXjqZweygrBwEzPvMME1Gno78FDS5Oe8F
 BIyW5UFnMmdS3gkWpfZZ1fyDk52gpLDK1jX7URyaD9NwFp5kT3+RuUIhJg+zEFLX
 +0GnxHuQ9qWckORBdpsnFbku85yivoPpyjv2BYWdYjt2Pp9+4TFYofgWlj3eir//
 t3r5tiUob42/gthKmfok7g/zoYUpe1YVVXSVZ90z+I19LAOs0JPpE8pV1q+xA972
 8Mq/YgAh5PvI2ftdgcdBPEsZzdVOLEAyMdcaPKbK4URgJQHJizNu7CvDOZFkqlMr
 4AJSuNeDnICOmCo0e+I37L21hwKEqtc47Rg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8q51g28-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 18:21:16 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-43cce86b0c4so3036803fac.3
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 11:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785608476; cv=none;
 d=google.com; s=arc-20260327;
 b=NZ8Pw6b3t1CqqkHvE9bFWhnQxhVrq04ke1MqtDO+p7QV9ZsDH7zlsVZgxFgrNDdzAQ
 S7TvxaCug30KdDVrlWg6hQrV5H5u/eFmTMuEiz6VwXMkbImP2qJyNotYprGaHUcRt6U/
 GXRLIhVevs+uW09XpMlpikbAO8QpU8ACVzOeSHcZSqWgssDESSMMRjYbGSUUKoT3YgJt
 7jbsvKaVU3st2wlY1+xx5Nj8jB6ez1uU+x0fPvjlxirNzaXI4neIQJACQcmwmAn9lGx8
 Vy/CDDSfkGjjrG2clSJ80+WRuFcOrDEp9vZgHknbxkHpXvMgnDrXrnCOtY3/BwDjBxGw
 Le1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=quM45oRV1E0D0EZHxomja/jcIXyUYHi8Tfm52Stde1Q=;
 fh=clP5otieQdioyjYVtAEEb7JREOhkmgJhgNXNlt6LZlA=;
 b=YiB/31HZpiwHnt+AM1tZDnX5WoXTvy0n3Ulc11x9origfA7W66VhohSBjy1rZFMoGA
 5yy7FtJnPTamVAf58jpSm+aAwsmDBIdmqhTeredNcQiBUNxevkPxc12ColJt34s3UXLH
 PmjdfNGvZ2YuCeM6WwPNFNpzjdHi/k1j0kJzYGKkFb4dnFXiyDifyEz1X4lLVl+Kp3tM
 4TpQvxxdjRVFpXCp7hnqymz53lK4TUib1HFt0XjMomxzGmhpmDApw4jNqFq01ODs5cg7
 PtOO/tW899Jx7Q8Ecx4R5ufgE4E9srTwt2mk4/f9WS1Zkogd/FD+ShGDnapI7vKy7kTS
 1qnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785608476; x=1786213276;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=quM45oRV1E0D0EZHxomja/jcIXyUYHi8Tfm52Stde1Q=;
 b=C28rCMgnCcBX1R2IWp7kB49CrIxIISiSvJmrQQHswYyUHw9FhHpsltqrxM+2ImSfDz
 FgR9O9e3BA6WA0tcAyeX56zF+KJsNgJQuGoJkPANnevEPEqIGNtxzjW3YBQvcjDIiwCj
 WbgqNnNvtdz0GCdq5J8lpiYI1DLUJyV2XhsGHcu4FYoSUZisHFrkKKMXYXXeXoLCmY7F
 wu0lwOByULYhoevsO+oFC10MP+I27MuQA26BUP2DEVziBUDAAxREZ659lGwODlbxxMie
 LkbCK1rEnPRqM0ZcqNKYNPr58uF17Wo0Fws+zltoko1obKSQTdWmU3eYPQjDkOFP706/
 +Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785608476; x=1786213276;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=quM45oRV1E0D0EZHxomja/jcIXyUYHi8Tfm52Stde1Q=;
 b=AUcfxRZMygpQJZhWV/zsumzLb8jEUXC6tFihF17kYXxQjSgA7pyrDEAmpVcp2k0zhv
 ECihU0/wsGxY7xI0kqQ9hpntPrm/m+YKLB25veBQ8ZFpisKlhx60UIyAk/jcnKAgQDnT
 qZ+9Yj0ba4nRYNpkiUYSdhtK0iWLHquHZqdIF1Bcme/SWRLRXtIkuYzzewbCW4DXyNlb
 TwUid8vjZGLrxV8bhS4BAZ5eYpqf+tFZQs8B7fqFr5s6hvYEyMbdqkdp/WEQKT8ckOJh
 GAWV58QCvifPVpwAexF1Sygc9cYS9N5Ki+fzMDoPyEq8mxQmzJBHqhtLWnwD/KXb+MR1
 iRXA==
X-Gm-Message-State: AOJu0YzZ/R1KCnW68/53YYkabf6Zni5sfOZucllSdUarY6LvuVztxcqo
 kIDOVXyPIk45QDWMbiNots+6QkgXM63RiMpYT/Z/bC+Tm8GhJCdmtGzWWlY3rNnOPb4zhCH3PeZ
 cBkMqa6jC8aYs0lbgs4lmi86OGOucOChsf95FMBsUQyB9qv0gbXT0peiuUPH5rqKxoiKnUHjnap
 HJNKIdhXCR9nkhslPuGNeXFhXLAxQ+XEYVXs+QULu4Ixtshg==
X-Gm-Gg: AR+sD1168GdWJ5Q00TOTbOW0zi56fyZ+BKYKim/kOgo5GVdKJ4udCpL2eJbPeuFrEoX
 9kRZPmRzxVC6RwE1GVVDHwZjiOCRuW3ljsCP9ZKJNW5SDnN0UrGXDp2Map2S1PsHfKbyWrJW9V2
 sJ4geV6y1AZyGuiSZ9g8e0ACAW76Ms5zku9xaLGKjbusUzvxkTow+6c2Qm
X-Received: by 2002:a05:6871:289:b0:448:c1f5:90f7 with SMTP id
 586e51a60fabf-45905d8a225mr7766337fac.19.1785608475782; 
 Sat, 01 Aug 2026 11:21:15 -0700 (PDT)
X-Received: by 2002:a05:6871:289:b0:448:c1f5:90f7 with SMTP id
 586e51a60fabf-45905d8a225mr7766321fac.19.1785608475263; Sat, 01 Aug 2026
 11:21:15 -0700 (PDT)
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 1 Aug 2026 11:21:04 -0700
X-Gm-Features: AUfX_mxTQiCLwp1y0wPs9jZKarneeilUr564IQmRuzBYnYufSwg8tO68YnIKdrU
Message-ID: <CACSVV00Qo3Ercwm5NOcDtifB8JV36No7zQnShNZSj=OBfW=9cg@mail.gmail.com>
Subject: drm/msm: drm-msm-next-2026-08-01 for v7.3
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0OCBTYWx0ZWRfX7NI9tm0FHtp6
 6ahrTd1vNi4pU16FcUYPNx17JjeIMrkriUOR9M49VAVrIuAHhAUtbADyRD+duLgWfDQu1AkGo8q
 NdNazUFmW44EmZE3mNqGl4RN5fO/C1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0OCBTYWx0ZWRfX9WArW3nX6oej
 szLgJnMm9h5oXKL29kO0kuZqFdMmjKZCAVe15TCYa8HeV7lOxw4awQNWFMzi5OeBXBKnyBOYjGX
 1gLwcwmcjngo5rf2p8DzZZceWjeaDXY0A8EmHEcpLN1YKcc6oswpFK4JN3Q9+MuGPEqIAjDOi9O
 Z6pOc9nPH9/4dBdW6s3GdVmAWHqe1Ucyexvn6ARV9YXxm2Eg+yUOs4k3JDYabA+ZiB5UqM7ZehH
 i8Kra5iAr6+k3omH2BnM/IMnxRba4hKKSJB4n2rE2tMqgn3sw4gfjtAHt/0RXIBfXVINWaZHLrs
 f8JNeJDM7jtL+tqidYbAg7QdBqKweyl8/4Ber+Tevtnw3O0Q9M0rpGwQiQDYv2OLNkZIDqpVEAN
 TlTmnuAgi32z2fWR4MAEumai2iVD6Vf3AW4YDBjZJ839nqgylvc/QoakLm0OMoMJHhocCfaOiTk
 v3QIMxMrZ3s/dTlnA0w==
X-Proofpoint-GUID: oSVoInLpYcQifIlppglefnfQeLnfkXBs
X-Authority-Analysis: v=2.4 cv=IYC3n2qa c=1 sm=1 tr=0 ts=6a6e391c cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8 a=ghuELz35WMKWYDI3F1sA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: oSVoInLpYcQifIlppglefnfQeLnfkXBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010148
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

Pull for v7.3, as described below.

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
