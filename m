Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB51CCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 18:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4D811237E;
	Fri, 29 May 2026 18:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="iKvGZWeA";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B3D11237E
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=JqoWqM560NgOyBoJArt872roHXO7vVZ5JRvRtTr4UX4=; b=iKvGZWeASddt48GOlMPuIIeRMZ
 pfRwHJhRCcNkLDl4TjmaSF9g/aqPjeOQfTwHYyBHseFaK0nhg5yZZHqmguq8+MziFtOkOBgEv/ymk
 ibVly8UMhek/4Sgti3OKZaJeHAD44KEzRA73Rc6qjODs71Vw6VBDj5Rs24WjyJ+zBCzdc7APjRGQf
 Y6IDAMppRYBry5Ak6UJfvA/CgRJfuy8fuIo3WBM2z5w5hQh0+JPllz99Q37n/6ZFMm0ICd1WSHec7
 V6UkD99MOfO3g6Al/p6FSrl9cdWxZWYClOyhnrUDPQBJDD2lxmNsyEkXfp8VRJjD+WizBk8dZFxls
 VN+eTiaw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 MidG971 <midgy971@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Midgy BALON <midgy971@gmail.com>
Subject: Re: [PATCH v2 0/4] accel: rocket: Add RK3568 NPU support
Date: Fri, 29 May 2026 20:04:17 +0200
Message-ID: <9739310.nlapOpYt14@phil>
In-Reply-To: <20260529155824.3099831-1-midgy971@gmail.com>
References: <20260529155824.3099831-1-midgy971@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi,

Am Freitag, 29. Mai 2026, 17:58:20 Mitteleurop=C3=A4ische Sommerzeit schrie=
b MidG971:
> From: Midgy BALON <midgy971@gmail.com>
>=20
> This series adds Rockchip RK3568 support to the upstream Rocket accel
> driver (drivers/accel/rocket/), tested on a Radxa ROCK 3B board running
> Linux 6.19-rc5.
>=20
> The RK3568 carries a single NVDLA-derived NPU core (0.8 TOPS), the same
> IP family as the three-core RK3588 NPU already supported by the driver.
> The hardware register layout (pc/cna/core regions, interrupt, IOMMU) is
> identical; the differences are:
>=20
>   - 32-bit DMA address limit (NPU AXI bus and IOMMU page walker are 32-bi=
t)
>   - Requires explicit PVTPLL initialisation via two TF-A SCMI calls before
>     the NPU NOC bus can be de-idled
>   - Requires explicit PMU writes to power on the NPU domain (because the
>     RK3568 power domain RK3568_PD_NPU is always_on so the generic
>     pm-domains callback is a no-op) and de-idle the NPU NOC bus
>=20
> Patch 1 introduces a per-SoC rocket_soc_data abstraction (dma_bits and
> optional noc_init callback) plumbed via of_device_get_match_data(), and
> adds RK3568 SoC support on top of it.  The DMA mask for the parent
> DRM facade device is chosen based on the narrowest core present
> (32-bit if any RK3568 core is in the system).
>=20
> Patch 2 documents the new rk3568-rknn-core compatible and the
> rockchip,pmu phandle that RK3568 requires; the sram-supply property
> becomes conditional (RK3588-only).
>=20
> Patches 3-4 add the RK3568 NPU and IOMMU nodes to rk356x-base.dtsi and
> enable them on the Radxa ROCK 3B.
>=20
> Verified on Radxa ROCK 3B (RK3568, 8 GB RAM):
>   - /dev/accel/accel0 created at boot
>   - dmesg: "Rockchip NPU core 0 version: 0"
>   - IOMMU domain attached per open()
>   - Job submission path complete: regcmd reaches the NPU's program
>     controller, PC processes all 135 regcmd entries, broadcasts to
>     sub-units, and advances to BSP-equivalent completion state
>     (PC_TASKST=3D0x11000)
>=20
> Status of end-to-end inference: NOT YET WORKING.  After 12 days of

what about the iommu side, aka the parts mentioned in
https://lore.kernel.org/linux-rockchip/5663593b-2c53-4632-ad2c-db9efa8e9ab2=
@rock-chips.com/

does that is in some way responsible for the not-yet-working state?


Also in general, we don't want to merge partially working code.
Either things work, or they don't, especially as right now you wouldn't
even know if it's your code that is wrong, or some other part that needs
changes.

Also please reduce those novel-sized (generated) texts.
=46or the cover-letter alone I'd need a fireplace, an armchair and a
hot cocoa to fully parse it.


Heiko

> investigation comparing rocket's behaviour against the vendor BSP RKNPU
> driver, the NPU's MMIO state at submission time matches BSP byte-for-byte
> (CNA configs, sub-unit OP_ENABLE registers, CBUF_CON0, etc.) but no
> sub-unit transitions to its EXECUTER state and the completion IRQ never
> fires.  The kernel driver and DT infrastructure in this series stand on
> their own =E2=80=94 the driver loads, IOMMU domain is attached, regcmd re=
aches
> the NPU, PC state machine matches BSP =E2=80=94 but a mesa-side regcmd is=
sue
> (or another piece we have not yet found) blocks the final conv firing.
>=20
> I am sending this series now because the kernel and DT pieces are
> self-contained, verifiable, and ready for review.  A separate RFC on
> mesa-dev will follow with the userspace findings.  Detailed investigation
> notes are available on request; relevant highlights for the maintainer:
>=20
> 1. Mesa rocket userspace (src/gallium/drivers/rocket/) targets RK3588.
>    For RK3568, several encoded values need adjustment.  Most notably,
>    sub-unit OP_ENABLE register offset on RK3568 is 0x_00c, not 0x_008.
>    Mesa emits writes at 0x1008/0x2008/0x3008/0x4008/0x5008 =E2=80=94 BSP =
regcmd
>    captures show no writes at these offsets across two distinct conv
>    shapes (YOLOv5s 6x6/s2 and MobileNet 3x3/s2).  BSP writes OP_ENABLE
>    at offset 0x_00c with multi-bit values (CMAC=3D0x1, ACCU=3D0x0, DPU=3D=
0x108,
>    DPU_RDMA=3D0x13f), not bit-0 booleans.  This and a handful of other
>    shape-independent value differences will be filed as a mesa RFC.
>=20
> 2. The vendor BSP RKNPU driver writes the userspace task_base_addr to
>    PC_DMA_BASE_ADDR (PC offset 0x34); the rocket driver did not.  PC's
>    TASK_DMA engine reads struct rknpu_task descriptors from there.  With
>    task_pp_en=3D1 in TASK_CON and a kernel-allocated descriptor BO,
>    PC's task counter state machine advances from "stuck at 0xf000" to
>    the BSP completion state.  This is the most invasive piece of the
>    investigation and is held back for a follow-on patch (not in this
>    series); the current series gets the driver to a working /dev/accel/
>    node and an attached IOMMU domain, which is the right shape for v2.
>=20
> 3. The NPU's master AXI port is 32-bit, but dma_alloc_coherent() through
>    the dma-iommu framework silently ignores GFP_DMA32 even with a 32-bit
>    dma_mask set on the device.  When BOs for the NPU are allocated kernel-
>    side, __get_free_pages(GFP_DMA32 | __GFP_ZERO, order) + dma_map_single=
()
>    is the working pattern.  Not in this series, but might be a useful
>    documentation note for other 32-bit AXI accelerators using dma-iommu.
>
> This series builds against current v6.19-rc5 with no checkpatch warnings,
> the dtb builds, and dtbs_check passes.  The April v1 series included a
> fifth patch ("Use of_find_matching_node() instead of for_each_of_allnodes=
")
> which is no longer required =E2=80=94 upstream rocket already uses
> for_each_compatible_node() since v6.19-rc5.
>=20
> Changes since v1 (April 2026, never sent on-list):
>   - Rebased to v6.19-rc5
>   - Patch 1 absorbed v1 patch 1 (obsolete) and now includes the
>     rocket_soc_data abstraction needed to support both RK3568 and
>     RK3588 cores in the same driver
>   - Cover letter expanded with current investigation status
>=20
> Assisted by Claude Sonnet/Opus 4.x throughout the investigation.  All
> findings empirically verified via BSP register captures and side-by-side
> rocket execution traces on the same board.
>=20
> Midgy BALON (4):
>   accel: rocket: Add support for Rockchip RK3568
>   dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568 support
>   arm64: dts: rockchip: rk356x: Add NPU and its IOMMU
>   arm64: dts: rockchip: rk3568-rock-3b: Enable NPU
>=20
>  Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml | 1=
8 ++++++++++++++--
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                        | 3=
1 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts                      |  =
9 ++++++++
>  drivers/accel/rocket/rocket_core.c                                   | 2=
1 +++++++++++++++++-
>  drivers/accel/rocket/rocket_core.h                                   | 1=
8 ++++++++++++++--
>  drivers/accel/rocket/rocket_device.c                                 | 2=
3 +++++++++++++++++--
>  drivers/accel/rocket/rocket_drv.c                                    | 7=
9 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  7 files changed, 192 insertions(+), 7 deletions(-)
>=20
>=20
> Midgy BALON (4):
>   accel: rocket: Add support for Rockchip RK3568
>   dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568 support
>   arm64: dts: rockchip: rk356x: Add NPU and its IOMMU
>   arm64: dts: rockchip: rk3568-rock-3b: Enable NPU
>=20
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 18 ++++-
>  .../boot/dts/rockchip/rk3568-rock-3b.dts      |  9 +++
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 31 ++++++++
>  drivers/accel/rocket/rocket_core.c            | 18 ++++-
>  drivers/accel/rocket/rocket_core.h            | 16 +++++
>  drivers/accel/rocket/rocket_device.c          | 25 ++++++-
>  drivers/accel/rocket/rocket_drv.c             | 71 ++++++++++++++++++-
>  7 files changed, 182 insertions(+), 6 deletions(-)
>=20
>=20




