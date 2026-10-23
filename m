Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBC606A327
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QDh9NdB2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8817E10E56F;
	Fri, 23 Oct 2026 06:39:45 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903C310E529
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:39:39 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso359661f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737578; x=1793342378; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w4cL4G9eHUbqDzKnbCFLNqMjngYxYEBxYMlVjjbvdqE=;
 b=QDh9NdB25X3ho2IeAoU5s9yz3rsTQFySPn7xBbjgGTAKf8sVRCswrdoqRs4S/ffBYj
 P46ocjqFVkEWEWgCefvOnd4EeuCKtCgBlMlFpzvdMHKuaNkbfixBpcIZY4ei6DsATAiC
 sy7vogjSSWMdhEa66O0I08aeGMjOex31v0RpJxkzK2oYwY0oE1Ab9LrC1tpcuwX4cEwg
 1/uZ1fZ5Lpc1VRa+M6Pnk9GINk0N2T8OUQwpN7mf82qtspDuTEL6ph01BcpppiBNatfV
 XE0G0yJsfS0DoeQzgam6gvGhaev7xn2ZVpY6rz02S5vir2KXuZymqe1lKI5a8YDb0HI8
 7ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737578; x=1793342378;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w4cL4G9eHUbqDzKnbCFLNqMjngYxYEBxYMlVjjbvdqE=;
 b=0NEBvW5sWwzOWqZBX8osKBMtQa+CGJz7fdyMtZIvBS+XdP0TyooliER+EpDFbpIb7E
 wEhrTyxDlSDsh3s5lMub1peEcLuBCIwUkVnlYpCrpoIOsQSEpi5KWohT2b1KowLromfM
 bVB2G3rYnJNDcJMLL/4VWg6or/dqb9eT2SZHZUbLaCLkbZziw+7gUptu8lW/m2JR2YFS
 Jrao6eb2IhrWcXfPU51h4XqCNYtMjC3yEDqyDmvPJtV92h2vncvNkeY4Bd6Q3VyoKdPj
 8uT6NWBH47ljRu5Q+nyPFP8B3IBI/GmiKfD7QyPixvMGY8gBOrOFT8Q81cE42qPl6odD
 KdYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPfh8NsFlG1JQ0nEphpF0pbpt1X+KNIVGittIu0T1t32jifKAvjidxT9YVIDGalmWqF3sGYJ8TChM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJR7gWGdL+gAR5LSst+zqdk6LF0B7NJv+0xvXcDu7BBmHEaXWZW
 myvOrHBQl2VKDK2pxazVk940uTqlMtLfI3S3IoOJfV3Eal2lpIgOWHzz
X-Gm-Gg: AYBFou1bLCt9lhyBlezWQy6svq+XZif8RJ8j1vaExRltWSQhlaHYl/66U1r+udbDelJ
 q0F9DovpR7bSiWA5zP+XyHqYpjxoKn5iuIt3JB5hAYSAjmlTHnrw2/b8rM/Cp2xVoV2PaOh/7NU
 N2wR2qJRynChZEnxkOAD2Mac3xh4FqOkz2A8aEYyEQS0SqPnc80UCyKdOTqaFvT/QM+ekBOP7hT
 WtaQ7e/ywm66akPHL/xRRriXS2qDOO9tdpiMNXOfCpbwsRbrPrTz2yy7LdWpZdSlxx3ytZc4sKY
 jXMql0hpbkLL6yQX9wBX/3Ww9HYEyz5fuDBiciPjhWw8cQRhr1TbyMVXO2Lii4c7MxzG1HROPd4
 YsdrgXLq2TYbXkVG+CaqZ972tW1FcXDxwe5TR5usZ/1PQSSw3s35XeoS+/DkqcS8qlB8CbulE5I
 VoxCBVd5WoKKlZ3zw5sdyo+4CVCfOuXYv1HAyGd/ltD+tLfLe9YDF2piLv2JZ0uSzevciiQ0s/K
 1Lu1970fj+88ywriiqH3BORdwgmS5pLz7/agZOXb/FjqlTY24HnrH10ICJMGC4sGa/e9LtLD6af
 4xfhFY86A2Yd76aEk1FKWfLzTamxbjqWVgVYyUDE3/QYi62Kuz1xszXOScGvkfYUgU/ee4ZgzF7
 OZ9I=
X-Received: by 2002:a5d:5f41:0:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e3859498fmr1687114f8f.14.1792737577617; 
 Thu, 22 Oct 2026 23:39:37 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:39:34 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: [PATCH v3 00/16] New DRM accel driver for Texas Instruments' C7x DSPs
Date: Fri, 23 Oct 2026 08:39:25 +0200
Message-Id: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB0B22oC/2WMQQ6CMBBFr0JmbU3bwZK64h7GRQOjzAJq2tqoh
 LtbWBgTlm/mvzdDpMAU4VzNEChzZD8VwEMF3eCmOwnuC4OW2kilUKTBjRQFYq1043RvVQ9l/Ah
 049cWulwLDxyTD++tm9V63SWyElJYi1aWh8Wma5Mf6Zn546M/TpRgDWX9L9c/WReZbO2MQUPyJ
 Pfysixfz8MqRN8AAAA=
X-Change-ID: 20260113-thames-334127a2d91d
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a new DRM accel driver that supports the C7x DSPs
inside some Texas Instruments SoCs such as the J722S (the only SoC
currently supported). These can be used as accelerators for various
workloads, including machine learning inference.

This driver attaches to the DSPs through remoteproc and talks to the
firmware running on them through shared memory and a mailbox. The
firmware is the accelerator's command processor: the driver pushes Jobs
onto a per-core Ring in shared memory and rings a mailbox doorbell; the
firmware runs each Job's Kernel in the DSP's user mode on the client's
own page table, moves a Fence when the Job is done and rings back.

The kernel driver itself allocates buffers, manages contexts and submits
jobs to the DSP firmware. It also populates the per-client page tables
with io-pgtable-arm.

No carveout holds buffers any more: every buffer is the kernel driver's,
page-backed and mapped through the DSP's MMU in the client's own page
table, which answers Andrew F. Davis's question on v2. The one reserved
region the driver uses is the first 256 KiB of the IPC pool, where the
handshake, the Ring and the Context table live. A buffer that a DMA
transfer names must be physically contiguous, since the DRU does not
go through the MMU; the client asks for that at creation.

If there is more than one C7x DSP core, the driver will load balance
jobs between them with drm-gpu-scheduler.

The firmware isolates clients by using its MMU to protect their memory
and by running their kernels at a lower privilege level.

Besides executing user-generated DSP kernels, the firmware can also
execute DMA transfers at the request of userspace. These don't go via
the MMU, so are validated by the kernel driver.

The source code for the firmware running on the DSP is available at:
https://gitlab.freedesktop.org/tomeu/thames-firmware/ mostly under the MIT
license. The ABI with the firmware is defined in a shared header with
versioning.

Known limitations of this version:

- Runtime power management is not implemented (system suspend and
  resume are).
- The J722S EVM does not resume from s2idle with TI's shipped
  system-controller firmware, so the resume path ran only in the
  driver's own tests; the suspend path ran on the board.
- The submit IOCTL waits on no sync object, which a Vulkan driver will
  need.
- The 4D block move is the only DMA transfer type accepted.
- One firmware image serves both cores; a core found running another
  firmware is left out after the handshake's five seconds.
- The DRU channel stride is stated for the J722S instead of queried.
- The J722S is the only SoC this version runs on.

Three additions were needed in the device tree bindings:

- power domain references for the two SoC timers the DSP firmware
  drives, which the remoteproc driver does not hold;
- a second mailbox doorbell, since remoteproc's own serves rpmsg and
  this firmware rings the Ring's; and
- reg entries for the AUX SRAM and the DMA engine's registers, which
  the driver maps into every client's page table.

Everything else is done in userspace, as a Gallium driver (also called
thames) that is part of the Mesa3D project: https://docs.mesa3d.org/teflon.html

Userspace portion of the driver: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39298

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
Changes in v3:
- Shared-memory ring and mailbox doorbell replace rpmsg
- The kernel driver writes the client page tables
- Buffers are bound at userspace-chosen DSP addresses
- Kernels run in the DSP's user mode; faults reported per job
- DRU transfers submitted by userspace, checked and translated by the kernel driver
- System suspend and resume
- Versioned firmware ABI; hardware ID reported and checked against the SoC
- Firmware rewritten bare-metal, MIT
- Link to v2: https://lore.kernel.org/r/20260114-thames-v2-0-e94a6636e050@tomeuvizoso.net

Changes in v2:
- Add thames_accel.h UAPI header (Robert Nelson).
- Link to v1: https://lore.kernel.org/r/20260113-thames-v1-0-99390026937c@tomeuvizoso.net

To: Bjorn Andersson <andersson@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Suman Anna <s-anna@ti.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Oded Gabbay <ogabbay@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Christian König <christian.koenig@amd.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Tero Kristo <kristo@kernel.org>
Cc: linux-remoteproc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-hardening@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

---
Tomeu Vizoso (16):
      dt-bindings: remoteproc: k3-dsp: Add the L2 auxiliary and DRU regions
      dt-bindings: remoteproc: k3-dsp: Allow a second sub-mailbox
      dt-bindings: remoteproc: k3-dsp: Allow referencing the timers' power domains
      accel/thames: Add header with IPC definitions
      accel/thames: Add driver for the C7x DSPs in TI SoCs
      accel/thames: Create a context per client on device open
      accel/thames: Add IOCTLs for BO creation and mapping
      accel/thames: Add support for submitting DMA operations
      accel/thames: Add IOCTLs for job creation and submission
      accel/thames: Recover from faults and timeouts
      accel/thames: Add IOCTL for memory synchronization
      accel/thames: Install memory mappings populated and dirty
      Documentation: accel/thames: Add initial docs
      arm64: dts: ti: k3-j722s: Add the AUX L2 SRAM and DRU regions
      arm64: dts: ti: k3-j722s: Add second submailbox to the C7x cores
      arm64: dts: ti: k3-j722s: Reference the power domains of the C7x timers

 Documentation/accel/index.rst                      |    1 +
 Documentation/accel/thames/index.rst               |   47 +
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml       |   33 +-
 MAINTAINERS                                        |    9 +
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi          |   16 +-
 .../boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi      |   27 +-
 arch/arm64/boot/dts/ti/k3-j722s.dtsi               |    4 +
 drivers/accel/Kconfig                              |    1 +
 drivers/accel/Makefile                             |    3 +-
 drivers/accel/thames/Kconfig                       |   27 +
 drivers/accel/thames/Makefile                      |   12 +
 drivers/accel/thames/thames_abi.h                  |  238 ++++
 drivers/accel/thames/thames_core.c                 |  867 +++++++++++++
 drivers/accel/thames/thames_core.h                 |  120 ++
 drivers/accel/thames/thames_device.h               |   97 ++
 drivers/accel/thames/thames_drv.c                  |  554 ++++++++
 drivers/accel/thames/thames_drv.h                  |   67 +
 drivers/accel/thames/thames_gem.c                  | 1077 ++++++++++++++++
 drivers/accel/thames/thames_gem.h                  |   77 ++
 drivers/accel/thames/thames_job.c                  | 1319 ++++++++++++++++++++
 drivers/accel/thames/thames_job.h                  |   81 ++
 drivers/accel/thames/thames_trace.h                |   77 ++
 drivers/accel/thames/thames_transfers.c            |  405 ++++++
 drivers/accel/thames/thames_transfers.h            |   52 +
 include/uapi/drm/thames_accel.h                    |  843 +++++++++++++
 25 files changed, 6043 insertions(+), 11 deletions(-)
---
base-commit: 1ecab8b0bad393750c60cc3819ce9c256595463c
change-id: 20260113-thames-334127a2d91d

Best regards,
--  
Tomeu Vizoso <tomeu@tomeuvizoso.net>

