Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDE0C5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF12510E679;
	Mon, 17 Aug 2026 06:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XR7J7ifh";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A378410E322
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 15:20:44 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso17328945e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786893643; x=1787498443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hA6ZcSIXBspwUlSfeLJa7+a0Uc2KtuRzGYFFOPOHJWU=;
 b=XR7J7ifhH/25v/Jn55NIxoWUB0uE5pFIoLhRNq2gk4neXihCHDB298xYJBsNPo64qI
 shLpXal3UHDtfJ3FweuebtY2b/2fKRXDd8BgnAQW0pqqlM1Ln+FY3o3zjlo4qd8c5mjy
 OdVI/vaEM1HTJ+0y6WMPrHmnN9tjlaenYiSA+v0JZ7FUjaBpR+EI8LOVUCrWh4AH5rkM
 cOGeCYxRYKx0NRImtd2xw9gZjrYJXrHo1V7NhGE4vqZ1vGDoSjuJM+Czly11OciRzNLW
 1GWEcqzKjye6gcMHB4ZMHmwqhUpgMgtzZNL1kcr1219iz2HSnJrqZfn/ltcz/avmdYO/
 XJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786893643; x=1787498443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hA6ZcSIXBspwUlSfeLJa7+a0Uc2KtuRzGYFFOPOHJWU=;
 b=Vkx6iduejMz8hqUdAGoK/HD7hAltjmYV/w+stBTzL+6vbXEIebt/sRTchS+bmvmPZa
 AYI7jck9SR2B4oqXptNf/FwuKxUyqStHYIUAvTd7vjr1JD0VVjE+y0FKQMr7GhAyqL2H
 VGI2Jyaxw3w+sNDOxpvUA3A7DRl+HvKLpUblGFJfhk+D5qpACkKJZqIrRDbeZEyNElDT
 xPe7khyU8p5DkqayBvT5kErgOMBCVF/kMCS9QJIBiwzp7G7rls2Zd2atN12VbFq2n3xL
 ySH6QtNvM5l/GOPKUiYRyeqQFtRfIXkY1iBGMaK6GWUtb0EnQKY6+xQRrjjPB5uiDrtU
 QIfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCBYk6ttZ3HYQnRP5gDPV+9JX/0jWP8YPcB6alf5iMW3NbW7SkP94LCkSUnZ2uM4EFzGAxqbKMep8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0LLPTqLvtYaRzZ07PyUEjy3U5P3ilFhidxX/d9YV/SumIPywP
 Qciwq7u42WesGrq5jBpsXirIq/J9NLX510Az8JIiONz9YmTZsyUblzqd
X-Gm-Gg: AR+sD12M06CumCACb8foEmf9YO+gRiiS3zK8zT/Ziosu852nEsnYU6P271H7VRniH04
 oIsvu1exmvlzb0nZx5kWU+D1KOIfjUhyD/s9PH1YNHg1YhX3ZK1DhqxSBBhj2VzMF4jIEiSbkYV
 m6y1f0gxrbdKcxN46SzZ0R/63JAxIMscOd+v4X1Z1v2begkw+WcGHYsu/1sutyUIVW7dJgJJUAD
 v1aBOdPcqbg7yiV+/FCCTsBIPSbgdj4BD3woSkOaaKgqcsbWhYhkNak9zuxnYuFzogWDeYYB71M
 /l0jLN51HqiElC5ytXF/e7/6oZASSILbCdBCX/8fbzUDPYuFBJTEqYr7V0aWIXshgRmOh4OleVY
 okBVrf86OncLnpLuolpZxRbZJ0UbVgrGU1VJS7N8DV5aXcTUv8jKdajzdVmEVqOQG7w/D8E0FlD
 aOeR/mpKehQBhvaooRc0UrX22367Lov6q+JAfHmW0g6+t6ym01Dqo5cTloVUOHLfLbyUoFKVual
 xHD04TBuQUwWa/pgH7Gpw==
X-Received: by 2002:a05:600c:4e8a:b0:499:7a4f:d13d with SMTP id
 5b1f17b1804b1-499879441bdmr265663485e9.4.1786893642518; 
 Sun, 16 Aug 2026 08:20:42 -0700 (PDT)
Received: from cachyos-x8664 ([45.141.148.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm73425265e9.4.2026.08.16.08.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 08:20:42 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	linux-sound@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: AMD Phoenix 1002:1640 Radeon HDA WALLCLK becomes 5.76 MHz after
 s2idle resume
Date: Sun, 16 Aug 2026 20:17:54 +0500
Message-ID: <20260816151754.7555-1-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 06:55:17 +0000
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

Hello,

I am investigating an AMD Phoenix/Hawk Point laptop with an integrated Radeon GPU and a reproducible audio-timing failure after s2idle resume.

Hardware:

  GPU:        0000:6e:00.0, PCI ID 1002:1900
  Radeon HDA: 0000:6e:00.1, PCI ID 1002:1640
  Analog HDA: 0000:6e:00.6
  Parent:     0000:00:08.1, Phoenix internal GPP bridge
  DCN:        3.1.4
  NBIO:       7.7.0, nbio_v7_7_funcs
  MP1/SMU:    13.0.10, smu_v13_0_0

The internal eDP panel is active. No external HDMI/DP sink is connected; Radeon HDA ELD entries report no monitor present and invalid ELD.

After cold boot, Radeon HDMI/DP playback is normal. After a reproducing s2idle cycle, playback stutters in Firefox, Telegram/AyuGram, and mpv. The failure reproduces with direct ALSA, without PipeWire; with hardware decoding enabled or disabled; and with Vulkan or OpenGL rendering. The Ryzen analog HDA remains smooth.

With mpv, normal A/V synchronization, display-resample, and display-vdrop stutter. --video-sync=desync makes video smooth while A/V drifts by seconds.

Direct HDA controller measurements were taken through the existing kernel MMIO mapping. The active stream used S32_LE, 8 channels, 48000 Hz, buffer_size 32768 frames. Expected transport rate is 1,536,000 bytes/s.

GOOD cold boot:
  WALLCLK approximately 23,999,690 Hz
  LPIB approximately 1,535,987 bytes/s
  approximately 47,999 frames/s

BAD after s2idle:
  WALLCLK approximately 5,759,926 Hz
  LPIB approximately 368,638 bytes/s
  approximately 11,519 frames/s

The BAD/GOOD ratio is approximately 0.24, close to 6/25. System monotonic timestamps advance normally, so this is not merely an ALSA timestamp or hw_ptr accounting error.

HDA PM-boundary probes show:

  GOOD cold boot: hda_intel_init_chip() -> approximately 24 MHz
  BAD resume:     hda_intel_init_chip() -> approximately 5.76 MHz

A complete runtime suspend/resume of 0000:6e:00.1 produced:

  runtime-suspend-entry:       approximately 5.76 MHz
  after controller shutdown:   0
  runtime-resume-entry:        0
  after azx_init_pci():        0
  after hda_intel_init_chip(): approximately 5.76 MHz

The bad source clock therefore survives the local HDA controller power cycle.

The following did not restore 24 MHz:

  snd_hda_intel unbind/bind of 0000:6e:00.1
  PCI PM reset of 0000:6e:00.1
  full runtime suspend/resume of 0000:6e:00.1
  amdgpu MODE2 GPU recovery followed by SMU resume

MODE1 was attempted once, but GFX/MES resume failed. No post-MODE1 HDA WALLCLK measurement was obtained, so no conclusion about MODE1 HDA recovery is drawn.

The HDAU ACPI power resource performs OFF -> ON successfully. Radeon HDA normal resume is ordered after completion of the amdgpu parent resume.

The active AMDGPU resume path in the v7.1.8 tree is:

  amdgpu_pmops_resume()
    -> amdgpu_device_resume()
       -> amdgpu_device_ip_resume()
          phase1: soc21_common_resume, gmc_v11_0_resume, ih_v6_0_resume
          phase2: smu_resume, gfx_v11_0_resume, sdma_v6_0_resume,
                  vcn_v4_0_resume, jpeg_v4_0_resume, mes_v11_0_resume
          phase3: dm_resume

On normal non-SR-IOV resume, PSP is excluded from the IP resume phases. For S0ix, PSP is also intentionally skipped during suspend because the source describes it as always-on hardware whose firmware/TMR state is reused.

The active smu_v13_0_0_ppt_funcs has no gfx_state_change_set member, so the generic D0-entry call has no ASIC-specific implementation on this path.

The active NBIO discovery dispatch is:

  IP_VERSION(7, 7, 0) / (7, 7, 1)
    -> adev->nbio.funcs = &nbio_v7_7_funcs

soc21_common_resume() invokes soc21_common_hw_init(), which calls nbio_v7_7_init_registers() during resume as well as cold initialization.

Read-only NBIO snapshots of the registers referenced by the active implementation were bit-identical at pre-s0ix, post-resume-pre-atomic, and post-atomic-restore:

  BIF0_PCIE_MST_CTRL_3
  BIF0_CPM_CONTROL
  BIF0_PCIE_CNTL2
  BIF0_PCIE_TX_POWER_CTRL_1
  RCC_DEV0_EPF5_STRAP4

The logged DCN audio DTO and clock-manager state did not show a corresponding 6/25 change. These display-side DTO registers are distinct from the PCI HDA WALLCLK register.

The v7.1.8 tree contains BacoAudioD3PME and EnableAudioStutterWA definitions, but BacoAudioD3PME is not mapped in the active smu_v13_0_0 message map and the active PPT implementation has no set_azalia_d3_pme callback. EnableAudioStutterWA has no active Phoenix mapping or callback. Neither is being presented as a known fix, and neither was sent.

The evidence establishes that the Radeon HDA WALLCLK itself changes from approximately 24 MHz to approximately 5.76 MHz after s2idle; the stream DMA follows the same ratio; the state survives local HDA recovery and MODE2 recovery; and it is not explained by the logged DCN DTO or NBIO state. The remaining hypothesis is a platform- or firmware-owned reference-clock mux/divider or power-domain state affecting GP17/HDAU that is not restored correctly across S0ix. This is a hypothesis, not a demonstrated register-level root cause.

I would appreciate guidance on whether Phoenix/Hawk Point PMFW has a documented HDA/Azalia clock restore sequence, whether an audio-specific SMU message is expected for this ASIC, and whether PSP or platform firmware is expected to restore the GP17/HDAU reference clock during S0ix resume.

No kernel workaround has been added, and no undocumented SMU message has been issued.

======================================================================
Appendix A: Representative GOOD/BAD HDA measurements
======================================================================

HDA controller timing samples (PCI 0000:6e:00.1, PCM8, S32_LE, 8ch, 48000 Hz)

GOOD cold boot:
  WALLCLK_Hz=23999690
  LPIB_Bps=1535987
  frames_per_sec=47999
  configured_rate=48000

BAD after s2idle + AC wake:
  WALLCLK_Hz=5759926
  LPIB_Bps=368638
  frames_per_sec=11519
  configured_rate=48000

BAD/GOOD ratio: approximately 0.24 (approximately 6/25).

======================================================================
Appendix B: HDA PM-boundary measurements
======================================================================

Radeon HDA PM-boundary WALLCLK measurements (0000:6e:00.1, 1002:1640)

GOOD cold-boot initialization:
  hda_intel_init_chip(): approximately 24 MHz

Failing system resume after s2idle:
  hda_intel_init_chip(): approximately 5.76 MHz

BAD runtime suspend/resume:
  runtime-suspend-entry:       approximately 5.76 MHz
  after controller shutdown:   0
  runtime-resume-entry:        0
  after azx_init_pci():        0
  after hda_intel_init_chip(): approximately 5.76 MHz

======================================================================
Appendix C: NBIO/DCN state snapshots
======================================================================

NBIO 7.7.0, implementation nbio_v7_7_funcs.

Read-only NBIO snapshots were bit-identical at:

  pre-s0ix
  post-resume-pre-atomic
  post-atomic-restore

Registers:
  BIF0_PCIE_MST_CTRL_3
  BIF0_CPM_CONTROL
  BIF0_PCIE_CNTL2
  BIF0_PCIE_TX_POWER_CTRL_1
  RCC_DEV0_EPF5_STRAP4

Relevant DCN phase state:
  xtalin=24000, dccg_ref=24000
  audio_dtb_dto=00000001/00000000
  audio_dto_src=00000030
  dtb_p=00000492

The visible DCN audio DTO state did not change by the 6/25 ratio across the failing resume. These display-side DTO registers are distinct from the PCI HDA controller WALLCLK register.

Thanks,
Akhmed Zhitaev
