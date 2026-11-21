Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3D606A330
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YF0Ft1G/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7367810E1D7;
	Sat, 21 Nov 2026 07:40:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEFF10E1D7
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 07:40:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 88E1F404D4;
 Sat, 21 Nov 2026 07:40:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795246852;
 b=uHryogzQBQpZ0QWwkLIVR/alRIlOWbB/LoGuAoNJrSwgj48pUOBNnOTdbqh53FrInF7s
 L4pgpCulmqrooJltWNYZPF0TMlwR48q/kEBA/nRPY+1BFBOAYAX8IepNgNkHGVM21I7XD
 RMiN4/6YuyExAV1jgDkVfm9qI3xR14Mf3czsBynxq4jqAJ0Gl/3ElBuzAlONAt7chLwmf
 7zBsBLFsadi3RG75mrg5Ams7ExBYIrudQXGzXY9MTlAI7lGVWiVPzFWNG0oCgEsJZy74D
 /9eVl/NBpqrKM+FzDanpa7zA11Zn8lDT2eTSGvqZqP4xE6pvDXYr7t0LwjMZzOIKAvg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795246852;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=TJmaTOA2mRrvZ/3WasT1DqFvu7PC6IfImVmxq2kMMkQ=;
 b=S/kKfJWE2+Hx1hWCNYxRMS+8pft3KSKrQQ4PlpLGvkNl5hzxG2PRQx3aNGWioKSEUo2p
 FBharl0cb1LVeMLGygRPruMpHbUpME4mptvTZvEFaY5cviMAzTITOppLM341dhQYn3QG9
 ZF1z/EUzOFCZrPEpmO54Kn2cW1zQh1uqbPSyNj7pV9JcqA8gvLHi7gtIvQxMeeByyL+1U
 fzrpT+AucYRTjQgX6fgCpzMzJYX1Uc0O1DxXyWSZf1qEJRb60ExhqDFZQf5QnL45rTVPd
 3LVRIy8pY+n+5sbySIckvvS8NAhHYY4JYksB76UJ0jFT6XbzdhMfQFVubQK9MsdS9hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EAF051F000C6;
 Sat, 21 Nov 2026 07:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795246852;
 bh=TJmaTOA2mRrvZ/3WasT1DqFvu7PC6IfImVmxq2kMMkQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=YF0Ft1G/BxhXtvC6ThpNbMP7KFt4gyvjMWygMEe4udslPjVvIeEtnrNzidaGWZBy+
 nWcM7D27XvQEmbVXUe6g1TODr7Yr4D2EFOkfdmf4dGVrKzG9obHQnNUs0mkdq4azVj
 nQpwJl57dyBvO6Fw+gHKyVdMacugdZkFbt6sFYKP+XEtu8jRPZOCOuYX0V3OAntcjP
 RGLzSKcyCVU9V71WdDyJ5cUJTtBZIjfw4/I0cQhpwRD0ZKJ2Mo5YnR0WOxquz/h24U
 UVM8CYpFSmrOhd/FJGTUZimY+ErWYJDQ8YvBKMzoUJf8t7/lnyDbOxXH8J1H0njGaN
 wPBGGAnBNnQWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4855E4BB4C;
 Sat, 21 Nov 2026 07:40:50 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Subject: [PATCH v3 00/17] drm/spacemit: add SpacemiT K3 display support
Date: Sat, 21 Nov 2026 15:40:39 +0800
Message-Id: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPdKAWsC/1WNyw6CMBBFf4V0bU07VQqu/A/josAURuURio2E8
 O9SNBGXJ7nn3Ik57AkdO0UT69GTo7ZZQO0illemKZFTsTADAbHQUvG74gW57mFGjom1WMQaUxW
 zReh6tPRaY5frh90zu2E+hEJYVOSGth/XNy/D7huGwzbsJRfcAhgpzBGSWJ/L2tBjn7c1C2EPP
 zUR6Z8Ki6pAFzqVIrNabtV5nt+eaXDv8QAAAA==
X-Change-ID: 20260713-k3-display-e8ffed67e936
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Sarah Emery <sarah.emery@canonical.com>, 
 Ze Huang <ze.huang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Cody Kang <codykang@vsit.ai>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795246844; l=9241;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=4Tvkhj/vuL6p65/H6W0t9kromXy0tFDd3ANMqOSeoj0=;
 b=NXfGNC3e5f145p1uzzbCkhlZmfGzxyaJjwQH50Jq5iOUDn1EflVyEpt0lk7XoHRHKkqxCsfKg
 Ey5CN+KGnUHDx5Gla0HqgzaPQ44nb7cJ0tN2QJIrN/27yyyXvg7jS1K
X-Developer-Key: i=codykang.hk@gmail.com; a=ed25519;
 pk=Osn6/cs9Su/mHHw4P19cmVc3v2FMQfiWahjsN0vEkuk=
X-Endpoint-Received: by B4 Relay for codykang.hk@gmail.com/codykang with
 auth_id=895
X-Original-From: Cody Kang <codykang.hk@gmail.com>
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
Reply-To: codykang.hk@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds display support for the SpacemiT K3 [2], a RISC-V SoC:
a new DRM driver, a new PHY driver and three new bindings.

The display path is three blocks deep:

  Saturn DPU -> Innosilicon DP/eDP controller -> Innosilicon DP PHY

New readers will find an introduction to this hardware in the v2 cover
letter [3].

In v3, two major changes, thanks to Thomas Zimmermann for the review
that led to these:

- The DPU driver lost its internal layers: the callback tables, the
  tracepoints and the command-list grouping are gone.
- Page-flip events go through the vblank machinery, and the DPU is
  powered through runtime PM.

The rest of the v3 changes please see below, with details in each patch's
changelog.

v2 ships in the Ubuntu 26.10 RISC-V kernel [4]. Thanks to Sarah Emery
for two fixes found there.

Thanks to Ze Huang for testing v2 on the K3 Pico-ITX. The Tested-by is
not carried, because the DRM driver changed too much in v3.

Ze, Sarah: if you have time to run v3, a retest would be very welcome.

Sashiko AI review contributed total review comments: 51 items, which I
accepted: 19 items.

v3 repeated the full v1 test matrix on both boards, in built-in and
modular configurations, with the module load/unload rounds of v2, plus
page-flip and DPMS rounds and unloading the modules while a client is
running.

About the series:

The DPU driver arrives as five staged patches (7 to 11) to keep each one
a reasonable size. It becomes buildable with patch 11. Bisect safe.

This series supports a single primary plane per CRTC and linear RGB
scanout (no plane scaling, rotation, YUV or writeback). It does not
support DSI, DSC or DP audio, and link rates are capped at HBR2.

Based on v7.4-rc1.

Testing this series needs a SpacemiT u-boot carrying display support:
the branch at [1], or a later official release.

Tested on two K3 boards:

  - Pico-ITX: an eDP panel and an external DisplayPort monitor.
  - CoM260-IFX: DisplayPort only, no eDP.

Note: The eDP panel DTS enablement is not part of this series; a separate
      series will follow showing how eDP can be verified.

[1] https://github.com/spacemit-com/uboot-for-k3-display-verify/tree/k3-br-v1.0.y
[2] https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3
[3] https://lore.kernel.org/r/20260809-k3-display-v2-0-327d7910bf71@gmail.com
[4] https://launchpad.net/ubuntu/+source/linux-riscv/7.2.0-5.5.2

Changes in v3:
- drop the tracepoints, the hardware callback tables and the
  constant-fill path; the Saturn register code is called directly
  (Thomas Zimmermann)
- one command list per channel, allocated once and submitted by its
  owner; the grouping, sorting and chaining of lists is gone (Thomas
  Zimmermann)
- deliver the commit's event through the vblank machinery, armed from
  the CFG_RDY interrupt (Thomas Zimmermann)
- power the DPU through runtime PM, and stop the boot loader's pipeline
  at probe instead of at the first modeset (Thomas Zimmermann)
- add prepare_fb: the display MMU table is built once per GEM object
  and the buffer's fences are waited for (Thomas Zimmermann)
- program the plane from the clipped rectangles, and size its line
  buffer in atomic_check (Thomas Zimmermann)
- wrap only the hardware access in drm_dev_enter() (Thomas Zimmermann);
  release the drm_device when the aggregate unbinds
- map scanout buffers write-combining; fail AUX transfers fast when HPD
  is low (Sarah Emery)
- reject modes above 3840x2160, and bound framebuffers by what the RDMA
  registers can address (Icenowy Zheng)
- let the panel supply the modes on eDP (Guodong Xu)
- leave the DPU's pixel clock at the rate it has; on DP and eDP the PHY
  PLL is the pixel clock (Guodong Xu)
- do not advertise a gamma table (Guodong Xu)
- DT: order the display nodes by unit address; the Pico-ITX message
  names the Type-C receptacle's DP alternate mode (Icenowy Zheng)
- clk: the commit message names the binding that documents the two
  clock inputs (Jerome Brunet)
- MAINTAINERS: add Guodong Xu as maintainer; list Cody Kang with the
  vsit.ai address
- rebased onto v7.4-rc1: atomic_create_state replaces .reset
- commit messages of patches 5, 7, 8, 9, 11, 12, 14 and 16 reworded
- picked up Rob Herring's Reviewed-by on patch 4
- Link to v2: https://patch.msgid.link/20260809-k3-display-v2-0-327d7910bf71@gmail.com

Changes in v2:
- unbind: keep the online IRQ alive until the teardown commits have
  drained; module unload no longer rides two watchdog timeouts
- bridge teardown on devres: reset via
  devm_reset_control_get_exclusive_deasserted(), pxclk disable as a
  devm action ordered against the PHY child (Philipp Zabel, Yao Zi)
- all five DPU reset lines behind one reset_control_bulk_* pair
  (Philipp Zabel, Guodong Xu)
- bindings: port@1 is now required; the CoM260 board describes its DP
  receptacle with a dp-connector node; redundant minItems dropped
  (Rob Herring)
- possible_crtcs derived from the input endpoint only
- EDID reads through the AUX I2C adapter; write-1-to-clear interrupt
  acks by plain write; assorted dead code dropped
- picked up Rob Herring's Reviewed-by on patches 1-3
- Link to v1: https://lore.kernel.org/r/20260725-k3-display-v1-0-6de34d80e86c@gmail.com

Signed-off-by: Cody Kang <codykang@vsit.ai>
---
Cody Kang (17):
      dt-bindings: display: spacemit: add K3 Saturn DPU controller
      dt-bindings: phy: add SpacemiT K3 Innosilicon DP PHY
      dt-bindings: display: spacemit: add K3 Innosilicon DP/eDP controller
      dt-bindings: soc: spacemit: allow eDP/DP PHY PLL pixel clocks on K3 APMU
      phy: spacemit: add Innosilicon DP TX PHY driver
      clk: spacemit: k3: parent eDP/DP pixel clock to the PHY PLL
      drm/spacemit: add Saturn DPU register model
      drm/spacemit: add Saturn DPU core types, cmdlist and display MMU
      drm/spacemit: add Saturn DPU hardware backend
      drm/spacemit: add Saturn DPU KMS pipeline
      drm/spacemit: add Saturn DPU DRM device driver
      drm/spacemit: add Innosilicon DP/eDP controller bridge driver
      MAINTAINERS: add SpacemiT K3 display driver entry
      riscv: dts: spacemit: k3: add display nodes
      riscv: dts: spacemit: k3-pico-itx: enable the DisplayPort output
      riscv: dts: spacemit: k3-com260-ifx: enable the DisplayPort output
      riscv: defconfig: spacemit: k3: enable display driver

 .../display/spacemit/spacemit,k3-inno-dp.yaml      |  141 ++
 .../display/spacemit/spacemit,k3-saturn-dpu.yaml   |  132 ++
 .../bindings/phy/spacemit,k3-inno-dp-phy.yaml      |   48 +
 .../bindings/soc/spacemit/spacemit,k1-syscon.yaml  |   21 +-
 MAINTAINERS                                        |   11 +
 arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts     |   27 +
 arch/riscv/boot/dts/spacemit/k3-display.dtsi       |  166 ++
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts       |   11 +
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi       |   22 +
 arch/riscv/configs/defconfig                       |    2 +
 drivers/clk/spacemit/ccu-k3.c                      |    4 +-
 drivers/gpu/drm/Kconfig                            |    1 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/spacemit/Kconfig                   |   37 +
 drivers/gpu/drm/spacemit/Makefile                  |   15 +
 drivers/gpu/drm/spacemit/dpu/dpu_saturn.c          |  353 ++++
 drivers/gpu/drm/spacemit/dpu/dpu_saturn.h          |   36 +
 drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c      |  670 ++++++
 drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c       |   66 +
 drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.h       |   16 +
 drivers/gpu/drm/spacemit/dpu/saturn_regs/dpu_int.h |   25 +
 drivers/gpu/drm/spacemit/dpu/saturn_regs/ops_hee.h |   47 +
 .../gpu/drm/spacemit/dpu/saturn_regs/reg_map_hee.h |   65 +
 .../drm/spacemit/dpu/saturn_regs/saturn_fields.h   |  312 +++
 drivers/gpu/drm/spacemit/spacemit_cmdlist.c        |  198 ++
 drivers/gpu/drm/spacemit/spacemit_cmdlist.h        |  133 ++
 drivers/gpu/drm/spacemit/spacemit_crtc.c           |  589 ++++++
 drivers/gpu/drm/spacemit/spacemit_crtc.h           |  133 ++
 drivers/gpu/drm/spacemit/spacemit_dmmu.c           |  119 ++
 drivers/gpu/drm/spacemit/spacemit_dmmu.h           |   80 +
 drivers/gpu/drm/spacemit/spacemit_dpu_ids.h        |   26 +
 drivers/gpu/drm/spacemit/spacemit_dpu_reg.h        |   99 +
 drivers/gpu/drm/spacemit/spacemit_drm.c            |  204 ++
 drivers/gpu/drm/spacemit/spacemit_drm.h            |   62 +
 drivers/gpu/drm/spacemit/spacemit_inno_dp.c        | 2186 ++++++++++++++++++++
 drivers/gpu/drm/spacemit/spacemit_inno_dp.h        |  328 +++
 drivers/gpu/drm/spacemit/spacemit_planes.c         |  332 +++
 drivers/phy/spacemit/Kconfig                       |   13 +
 drivers/phy/spacemit/Makefile                      |    1 +
 drivers/phy/spacemit/phy-k3-inno-dp.c              |  951 +++++++++
 40 files changed, 7680 insertions(+), 3 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260713-k3-display-e8ffed67e936

Best regards,
--  
Cody Kang <codykang.hk@gmail.com>


