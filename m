Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E755606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnbQ7Rb/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F3310E469;
	Fri,  6 Nov 2026 20:37:07 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B9A10E469
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:37:01 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-93f2049ea7aso87294385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 12:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793997420; cv=none;
 d=google.com; s=arc-20260327;
 b=ccji+eu/l5cdjeDlA7FXt2j0O94NiRWAdjoL3QfXOaO2Ild4A5q6XBGMVUwvUGn2NH
 28xiuDukKeSvW+mhaW7KaSUeeoPhUfVJuyiGVPuVDf9n9zH5XToCfwfUs8QXaTYKL5Gi
 6vmkzOVmsUZhjVuwFSTtk5lNe+06J97FxQgBfL1uhcIUAC2g13Wh6itHc1eMPfpKeQJf
 EuMI7cmphhCq7niMRf5jo4qa2q+7Mmra7KAPvGlIkIp0oYlNVxoFeGNN0P+kIUQzvOYp
 gQfTDoxUks9F++8uTjQZeSggS+Xolk6G8YqYoQMCq2Wz9lG4a68LO3zuKzQlKBL0leES
 lBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=fQQwGWUF3g0/8cOPjoVHS0rKrLN6G5Et09AmY1qnp+4=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=p/dcClK/vo2j6Q4cgASNe06s/mkP+r0iY2v9jyZtSSBUPjHU+ylFuTfmZM5sRQolum
 mhFDuRTjcHIJJt590rKOW9tPa2yCbdb5Ao7xAZziAZmFOVucSEx6hnOLmVBQPzs1YuIK
 y0cqwvzJL7wc0Z++6z8h+gAQkB5IBlaKt7KhXW6CksgimLHXtLcBmErnWiO9CiuaVaGR
 NlOq8yuGZgs0/0tRb/pQ2XpHLDP6mWxTEZTW2qFP83ugdT4nMFqYVgqlmuT7EJvYpB3L
 2/eb13xP4c2j2CLan6qcpoKipJSM26ZN8wfvORMR5oKo68BhDJLTlUXb1YPpWbVQ2C/g
 9UHg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793997420; x=1794602220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fQQwGWUF3g0/8cOPjoVHS0rKrLN6G5Et09AmY1qnp+4=;
 b=WnbQ7Rb/CJRbYuHtDvystn+MSXct5XJ844fcj3tYsR++FOzi+3V4y5eH82CR6MJyrX
 m3oIK8z7u352/8fHsZCgAZBk5BGwPuD56rR2IgkOv1cjNj6+Avwkjns0GSVAAtmaGnsA
 BCzpmnB5fIzwFKh2wIDxKILJ12NQi9ThqsqiqWAWL9WSFGWomt5I4yQc63p4WdtAvY1w
 gbdqOSuWgyE4ZKY7CIJ0OfpSnAS+lnv71JLQtJUtj+de5APszq0loxDhEVH+5+K+bEwA
 7NUTn/P/PVkpcDRlOUSydefEdmCORbFDzHQbbDHjo++FjZw9WYq0r9oY6YtlCCt9E1xk
 OQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793997420; x=1794602220;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fQQwGWUF3g0/8cOPjoVHS0rKrLN6G5Et09AmY1qnp+4=;
 b=iUkAhdmzm0lJKcxzc4CTiFeJPJT74vrenB5Ic8gWcPUW9uC3lnzpjD/dGz7abjzYPZ
 MkOGSdvzntOR2jrfMObd6viFgwG8MqhMENkfJJTSdZjMOCCBVnNhAPRHBOSmg5U2QJca
 g0oF+zNmCwIKA9xNUn2raLSGq+aRpfb2AZeJc3Wq0GrnFIosEg2UWp1BpOyFue1rYsk/
 UNemDclUu1WxnaaI6H/ac9FBp2pJ7viV6X5jfnucgu7dmU7YG18Bdxphm2JaqsxHQyNX
 dY1WRYQUhC2zZ+dNG2kQdG2qppnNofmgf+FqMQdHSzzy1fHFpmbhAsbp8h4O0OxBOxpT
 fnnA==
X-Gm-Message-State: APuU4Z/t+goXuW5Qr8Xvi4OKDy7+2omnjefUpi57BjcLeNlZamJhJ9Di
 m/ac87IynXNcRW9enGmOK3ZozR9PjMrJ3LiYHlGRMll/Wce2BaL0it54E8TmlQg/Xd7+rVQIkmG
 t9Ti7QNEV9mcI8q9/I34l8hwHbTtjlZg=
X-Gm-Gg: AYBFou1jNKUvETBiMhDoNMBwrMazPPWmWqOZPEYxHltTeqCuAEa6vII8wpoRs4OL5hs
 6MktUBrGg4aSnulv7Btwfee7wC7EUCrf0bt8ITJ3bxpQYtwdW6QT7/3Ye/giS2h+wSdBjYradod
 zco1rVY6dhqkHsEiMtUE1oRv35WnI6do6/5lVkdssdVJIlslmIQ4RRZf2PKNUiUSCY7bYM6WrXm
 IoTKIdoD3L4TD2CVG+dfCHUUknVWbZ2KqDGU90rjAF9QkNmKxp2kvVoi+xXeWh+K8KNctcTHUuT
 dvL5XcXuotSCU6wR4Y0XSZ0kDU/aaRnkHA1acoDggsy1CnmeiR80SdMkG1PYeu5gPhE3LIqs1Po
 6y1m7WN9Rj8SjUZBMfWPkbdpVTu5gTDb651qKWt2/djc6ag0lAbjfljGFUmAGIzkT/4v6SN2PUX
 9paROTig+4WNnFkqBW160dGw==
X-Received: by 2002:a05:620a:2b97:b0:943:faab:a15b with SMTP id
 af79cd13be357-945f3511afamr561119585a.32.1793997419785; Fri, 06 Nov 2026
 12:36:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 7 Nov 2026 06:36:45 +1000
X-Gm-Features: AclHuK_wdGmxrzTQn_UlkE7TQTv7WxNPYWt-xeVVF7zb7NBqA10sotD50lCDnJ8
Message-ID: <CAPM=9tz9wWFUO4Ua84DF3V3GWHSL1k_t2UhShUHS4MkGpXR+Mw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.4-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

This is the weekly drm fixes, amdgpu leading the way with some i915,
nouveau and other fixes.

There should be a bunch of xe fixes, but their tree got screwed up so
I guess I'll send those next week once they cleanup whatever happened.

Dave.

drm-fixes-2026-11-07:
drm fixes for 7.4-rc2

atomic:
- Fix CRTC dma-fence handling

drm:
- Add parsing for additional HDMI 2.2 FRL rates

bridge:
- nwl-dsi: Fix LCDIF handling

dma-buf:
- Fix IOVA offset
- Restore the scatter-list entry count before freeing

dp:
- Keep MOT set between messages when no_zero_sized is set

panel:
- visionox-r66451: Set brightness MSB first; Increase reset waiting time

panic:
- Fix display loop
- Fix line parsing

sched:
- Fix out of bounds entity priority check
- Adjust run-queue when changing priority at runtime

amdgpu:
- UALink fixes
- RAS fixes
- GEM_OP fix
- Parse IB fixes
- CS user fence fix
- GPU reset fixes
- Multi-media idle work handler cleanup fixes
- UserQ fixes
- CRC fix
- SR-IOV fixes
- IP discovery fix
- HDMI 2.2 FRL fixes
- DDC pin fix
- HUBP fix
- SPM fix
- DCN 3.2 fixes
- VRR/freesync fix
- Seamless boot fix
- SMU 13.0.7 fix
- Backlight fix
- dma-buf fixes
- GPUVM fixes
- Move DMCUB back to VRAM
- Non-DC audio fix
- BACO fix

amdkfd:
- Fix WPTR BO eviction fence handling
- GPUVM locking fix

i915:
- Fix GitLab #8991 where tiled displays (LG UltraFine 5K) broken on PTL
- Limit NVL TRANS_VTOTAL.Vtotal skip display workaround to A-step
- Single scaler per pipe number to 1 and disable pipe joiner on WCL
- Add quirk to force backlight type on some TUXEDO devices
- Fix "CMTG: A disable timeout" splat
- Fix intel_vrr_dcb_vmin_vblank_start
- Bunch of PSR fixes
- Static checker fixes

etnaviv:
- Fix NULL dereference in etnaviv_unbind()
- Flush the tile status cache through both the PE and BLT

imagination:
- Align rogue_fwif_hwrtdata to 64 bytes

loongson:
- Fix BO handling in several places

nouveau:
- Map Kepler video engine contexts non-privileged
- Clear use.enabled when subdev init fails
- Avoid running VBIOS twice
- Fix CE channel creation on pre-Kepler GPUs

v3d:
- Initialize job timedout_batches
- Fix cache_clean_lock

vc4:
- Move output fence and BO unreserve out of job_lock
- Power down PYH when output is disabled
- hdmi: Fix scrambling
The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4=
:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-07

for you to fetch changes up to 19e67d977d3d4d0c54f03906ef578578190db9e1:

  Merge tag 'amd-drm-fixes-7.4-2026-11-05' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
(2026-11-06 10:43:59 +1000)

----------------------------------------------------------------
drm fixes for 7.4-rc2

atomic:
- Fix CRTC dma-fence handling

drm:
- Add parsing for additional HDMI 2.2 FRL rates

bridge:
- nwl-dsi: Fix LCDIF handling

dma-buf:
- Fix IOVA offset
- Restore the scatter-list entry count before freeing

dp:
- Keep MOT set between messages when no_zero_sized is set

panel:
- visionox-r66451: Set brightness MSB first; Increase reset waiting time

panic:
- Fix display loop
- Fix line parsing

sched:
- Fix out of bounds entity priority check
- Adjust run-queue when changing priority at runtime

amdgpu:
- UALink fixes
- RAS fixes
- GEM_OP fix
- Parse IB fixes
- CS user fence fix
- GPU reset fixes
- Multi-media idle work handler cleanup fixes
- UserQ fixes
- CRC fix
- SR-IOV fixes
- IP discovery fix
- HDMI 2.2 FRL fixes
- DDC pin fix
- HUBP fix
- SPM fix
- DCN 3.2 fixes
- VRR/freesync fix
- Seamless boot fix
- SMU 13.0.7 fix
- Backlight fix
- dma-buf fixes
- GPUVM fixes
- Move DMCUB back to VRAM
- Non-DC audio fix
- BACO fix

amdkfd:
- Fix WPTR BO eviction fence handling
- GPUVM locking fix

i915:
- Fix GitLab #8991 where tiled displays (LG UltraFine 5K) broken on PTL
- Limit NVL TRANS_VTOTAL.Vtotal skip display workaround to A-step
- Single scaler per pipe number to 1 and disable pipe joiner on WCL
- Add quirk to force backlight type on some TUXEDO devices
- Fix "CMTG: A disable timeout" splat
- Fix intel_vrr_dcb_vmin_vblank_start
- Bunch of PSR fixes
- Static checker fixes

etnaviv:
- Fix NULL dereference in etnaviv_unbind()
- Flush the tile status cache through both the PE and BLT

imagination:
- Align rogue_fwif_hwrtdata to 64 bytes

loongson:
- Fix BO handling in several places

nouveau:
- Map Kepler video engine contexts non-privileged
- Clear use.enabled when subdev init fails
- Avoid running VBIOS twice
- Fix CE channel creation on pre-Kepler GPUs

v3d:
- Initialize job timedout_batches
- Fix cache_clean_lock

vc4:
- Move output fence and BO unreserve out of job_lock
- Power down PYH when output is disabled
- hdmi: Fix scrambling

----------------------------------------------------------------
Alex Hung (1):
      drm/amd/display: Avoid closing unowned DDC pins

Andr=C3=A9 Draszik (2):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      drm/drm_crtc: fix race with dma_fence_signal() in ::get_driver_name()

Animesh Manna (1):
      drm/i915/cmtg: Disable CMTG after encoder disable in hsw_crtc_disable=
()

Bas Nieuwenhuizen (1):
      drm/amdgpu: Check cs flags.

Calvin Owens (1):
      Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"

Ce Sun (1):
      drm/amdgpu: skip RAS error count reset in debug mode

Christian Gmeiner (2):
      drm/etnaviv: Fix NULL dereference on unbind without PPU flop reset
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Dariusz Marcinkiewicz (1):
      drm/amdgpu: check amdgpu_vm_ready() in dma-buf move notify

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2026-11-05' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-11-05' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.4-2026-11-05' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes

Davidlohr Bueso (1):
      dma-buf: validate the attachment before asserting its reservation loc=
k

Devin Wittmayer (2):
      drm/panic: Fix kmsg screen hang on a long log line
      drm/panic: Accept a trailing newline in panic_screen

Dom Cobley (1):
      drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled

Erhan Bilgili (2):
      drm/amdgpu: Fix duplicate dependency fence releases
      drm/amdgpu: Report MES ring wait timeouts.

Esben Haabendal (2):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override

Evanshenf (3):
      drm/loongson: Fix framebuffer selection in async cursor updates
      drm/loongson: Fix double free on BO initialization failure
      drm/loongson: Handle buffer mapping failures when clearing a BO

Fangzhi Zuo (2):
      drm/edid: Parse HDMI 2.2 FRL rates from the SCDS
      drm/amd/display: Accept HDMI 2.2 FRL rates from the sink EDID

Finn Zeruhn (1):
      drm/dp: keep MOT set between messages when no_zero_sized is set

Hugo Sales (1):
      drm/amdgpu: Clamp the ATIF backlight curve to its 99 points

Ilia Mirkin (1):
      drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts

Jesse Zhang (11):
      drm/amdgpu: sign extend the addresses GEM_OP(GET_MAPPING_INFO) return=
s
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdkfd: use the queue's process info for the WPTR BO eviction fen=
ce
      drm/amdgpu/userq: validate the moved individual BOs on restore
      drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM VMID
      drm/amdgpu: drop the dma-buf reference when a KFD import fails
      drm/amdgpu: unlock the VM and BO when attaching a KFD BO fails
      drm/amdgpu: rewrite all PTEs of the BOs after a VM reset
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdgpu: don't drop the gang dependency fence twice

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Jouni H=C3=B6gander (5):
      drm/i915/psr: Clear selective fetch area when duplicating plane state
      drm/i915/display: Add enabled pipe planes into state for selective fe=
tch
      drm/i915/psr: Disable linked plane sel fetch as well
      drm/i915/psr: Fix SFF and CFF CTL register bit definitions
      drm/i915/psr: Don't clip plane state destination rectangle

Karl Mehltretter (1):
      dma-buf: keep the DMA flags in the DMABUF_DEBUG copy

Kent Russell (1):
      drm/amdgpu: Ensure that harvest information gets set

Kevin Wang (1):
      drm/amd/pm: populate unique ID for smu 13.0.7

Konstantin Sinyuk (1):
      MAINTAINERS: Update habanalabs maintainer contacts and status

Kylie C (1):
      drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on seamless boot

Leo Liu (1):
      drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce=
/jpeg

Leon Romanovsky (1):
      dma-buf: Restore the scatterlist entry count before freeing

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

Lucas Tanure (2):
      drm/vc4: hdmi: always cancel the scrambling work synchronously
      drm/vc4: hdmi: enable scrambling before the TMDS clock starts

Mario Limonciello (1):
      drm/amd/pm: track BACO state in the SMU v11 ArmD3 sequence

Matthew Schwartz (1):
      drm/amd/display: Keep the nominal vtotal while VRR is inactive

Ma=C3=ADra Canal (3):
      drm/vc4: Publish the output fence outside of job_lock
      drm/vc4: Drop the BO reservations outside of job_lock
      drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence

Melissa Wen (1):
      drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR

Michal Wilczynski (1):
      drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes

Mikhail Gavrilov (1):
      drm/amd/display: set allow_freesync before validating a new stream

Milan Milicevic (2):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10=
_ih
      drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

Misha Nasledov (1):
      drm/amd/display: Drop clock requirements on DCN32 when no
displays are active

Mitul Golani (1):
      drm/i915/display: Allow port sync on PTL

Mukul Joshi (1):
      drm/amdgpu: only tear down an active UALink accelerator

Munique Feitoza (1):
      drm/nouveau: Fix CE channel creation on pre-Kepler GPUs

Prike Liang (7):
      drm/amdgpu/mes: skip unmap queue notification during GPU reset
      drm/amdgpu/uvd: don't allocate or lock BOs in the direct IB test
      drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queu=
es
      drm/amdgpu: finish GPU recovery callbacks before restarting scheduler=
s
      drm/amdgpu: stop the schedulers before preparing the GPU reset
      drm/amdgpu/vce: don't allocate a scheduler fence in the direct IB tes=
t
      drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle work

Roman Demidov (1):
      drm/amd/display: Fix NULL deref in dcn401_update_clocks_update_dtb_dt=
o

Roman Li (1):
      drm/amd/display: Reset DET of HUBPs without a plane before
outstanding updates

Rosen Penev (2):
      drm/nouveau/fifo: map Kepler video engine contexts non-privileged
      drm/nouveau/nvkm: clear use.enabled when subdev init fails

Suraj Kandpal (1):
      drm/i915/display: Limit NVL TRANS_VTOTAL.Vtotal skip to A-step

Tvrtko Ursulin (2):
      drm/sched: Fix out of bounds entity priority check
      drm/sched: Adjust run-queue when changing priority at runtime

Vidya Srinivas (2):
      drm/i915/display: Single scaler per pipe on WCL
      drm/i915/display: Disable pipe joiner on WCL

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/vrr: Fix intel_vrr_dcb_vmin_vblank_start()

Vladimir Zapolskiy (2):
      drm/panel: visionox-r66451: Send the brightness value MSB first
      drm/panel: visionox-r66451: Wait longer after the panel reset

Wayne Lin (1):
      drm/amd/display: add missing CRC engine 1 registers

Werner Sembach (1):
      drm/i915/display: Add quirk to force backlight type on some TUXEDO de=
vices

Yili Zhang (1):
      dma-buf: Fix IOVA offset when linking phys vecs to sgt

luyuantao (1):
      drm/panic: Fix the loop that causes kmsg to not display correctly

renpanpan (1):
      drm/amdgpu: Only enable HDMI audio if display supports it

 .mailmap                                           |  2 +
 MAINTAINERS                                        |  6 +-
 drivers/dma-buf/dma-buf-mapping.c                  |  8 +-
 drivers/dma-buf/dma-buf.c                          |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 17 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 21 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 41 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 44 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           | 25 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 19 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            | 11 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 36 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 16 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               | 13 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             | 27 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             | 28 +++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             | 27 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             | 28 +++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           | 27 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           | 27 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           | 27 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           | 28 +++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           | 28 +++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           | 27 +++---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             | 41 ++++++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              | 15 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              | 13 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              | 16 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              | 17 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              | 15 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            | 15 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            | 15 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            | 15 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            | 16 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            | 16 +++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c | 11 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c | 27 +++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  6 ++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       | 30 +++++++
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |  3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  6 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  | 31 +++++++
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  3 +
 .../display/dc/link/protocols/link_dp_capability.c |  6 +-
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |  7 ++
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h | 18 ++++
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h | 22 ++++-
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.h   | 18 ++++
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h | 11 +++
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h | 11 ---
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.h   | 12 +++
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |  2 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h |  2 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c | 15 +++-
 .../amd/display/dc/resource/dcn32/dcn32_resource.h |  6 ++
 .../display/dc/resource/dcn401/dcn401_resource.h   |  6 ++
 .../drm/amd/display/modules/freesync/freesync.c    |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 20 ++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 20 +++++
 drivers/gpu/drm/bridge/nwl-dsi.c                   | 17 ++--
 drivers/gpu/drm/display/drm_dp_helper.c            |  3 +-
 drivers/gpu/drm/drm_crtc.c                         | 18 ++--
 drivers/gpu/drm/drm_edid.c                         | 12 +++
 drivers/gpu/drm/drm_panic.c                        |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           | 40 ++++-----
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  6 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 19 +++--
 .../gpu/drm/i915/display/intel_display_device.c    |  5 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  4 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  | 22 ++++-
 drivers/gpu/drm/i915/display/intel_plane.c         | 11 +++
 drivers/gpu/drm/i915/display/intel_psr.c           | 96 ++++++++++--------=
----
 drivers/gpu/drm/i915/display/intel_psr_regs.h      |  4 +-
 drivers/gpu/drm/i915/display/intel_quirks.c        | 24 ++++++
 drivers/gpu/drm/i915/display/intel_quirks.h        |  1 +
 drivers/gpu/drm/i915/display/intel_vrr.c           | 12 ++-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  2 +-
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h       |  2 +-
 drivers/gpu/drm/loongson/lsdc_gem.c                | 14 ++--
 drivers/gpu/drm/loongson/lsdc_plane.c              |  2 +-
 drivers/gpu/drm/loongson/lsdc_ttm.c                | 14 ++--
 drivers/gpu/drm/loongson/lsdc_ttm.h                |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  7 +-
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c   | 13 +++
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c    | 20 +++++
 drivers/gpu/drm/panel/panel-visionox-r66451.c      |  4 +-
 drivers/gpu/drm/scheduler/sched_entity.c           | 29 ++++---
 drivers/gpu/drm/v3d/v3d_gem.c                      |  5 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |  2 +
 drivers/gpu/drm/vc4/vc4_gem.c                      | 14 +++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 10 +--
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c                 |  5 ++
 122 files changed, 1123 insertions(+), 470 deletions(-)
