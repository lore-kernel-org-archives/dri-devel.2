Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C6C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 04:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D1F10E1C0;
	Fri, 31 Jul 2026 04:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CMLXs/RP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DAD10E1C0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:51:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 682D2405FE;
 Fri, 31 Jul 2026 04:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CDD1F000E9;
 Fri, 31 Jul 2026 04:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785473509;
 bh=yEhGITNsUn059RUHq6Fcf8I/vaN7gjm6w+UpbSgeMow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CMLXs/RPZMESZWm+dNRHiRGvQmY9H6OlHxszZMle9AVQOPx4kIcIKUanXjx/BqdNo
 Ux+7qEjeW+fg3GhDju8m1Z+dKlj5Ai0xAMhLEs9PT2/F6f3+nH24ry7cmCUMkTm6nJ
 RH8czdgsQD6kL8Rg99j3yMUePPQYH4v0LpRanFO5ZOklRFc90WdF1BZ61860JqDqaL
 6CbqLQNappdRrC8Zf2V/8A23fNKmaf8T7tXDSXgoYp/HoOpkUtFNgGYTfcKQuHdnQT
 zk7IHiqOY3bGYawh0ZiMsq+RaZ/2bav7irVDA2YX8bAiMrM09TQG7HEcj9Ii0kOPk9
 1YysvpoRwiduA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 5/6] arm64: dts: rockchip: rk3576: add NPU (RKNN)
 nodes
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260731043507.1832277-6-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
 <20260731043507.1832277-6-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 04:51:48 +0000
Message-Id: <20260731045148.98CDD1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] The `rknn_core_1` DT node is missing the CBUF clocks (`aclk_cbuf` =
and `hclk_cbuf`), causing a fatal probe failure.
- [High] Providing only a single power domain per core triggers the driver-=
core auto-attach, conflicting with the driver's explicit attach logic and c=
ausing a fatal `-EEXIST` error during probe.
- [High] The `rknn_mmu_1` node has an incorrect `reg` base address (`0x2770=
a000` instead of `0x27712000`), which maps the wrong physical memory for th=
e NPU1 IOMMU.
- [High] Race condition between the IRQ handler and poll_work causes premat=
ure task completion and memory corruption.
- [High] poll_work is not cancelled during a job reset, leaving a stale wor=
k item that corrupts subsequent jobs.
- [Low] The `rknn_core_0` and `rknn_core_1` nodes violate the `rockchip,rk3=
588-rknn-core` binding schema constraints.
- [Low] `rknn_mmu_0` and `rknn_mmu_1` nodes violate the `rockchip,iommu` bi=
nding schema.
--

--- Patch [5]: [RFC PATCH v3 5/6] arm64: dts: rockchip: rk3576: add NPU (RK=
NN) nodes ---
commit 844bc539be73e9227d1af3ee91d59e16d7988bfd
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes

This commit adds the two RKNN cores and their IOMMUs, alongside the NPU
power-domain resets. Both cores are disabled by default and can be enabled
by boards as needed.

> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
[ ... ]
> @@ -1832,6 +1840,72 @@ qos_npu_m1ro: qos@27f22100 {
>  			reg =3D <0x0 0x27f22100 0x0 0x20>;
>  		};
> =20
> +		rknn_core_0: npu@27700000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
> +			reg =3D <0x0 0x27700000 0x0 0x1000>,
> +			      <0x0 0x27701000 0x0 0x1000>,
> +			      <0x0 0x27703000 0x0 0x1000>,
> +			      <0x0 0x27704000 0x0 0x1000>,
> +			      <0x0 0x27705000 0x0 0x1000>;
> +			reg-names =3D "pc", "cna", "core", "dpu", "dpu_rdma";

[Severity: Low]
Does this exceed the maxItems allowed by the schema?

The schema for rockchip,rk3588-rknn-core enforces maxItems: 3 for the reg
property and maxItems: 4 for clocks. It also requires npu-supply
unconditionally and demands two resets (srst_a and srst_h), which appear to
be omitted here.

Could this trigger unconditional dtbs_check validation failures?

> +			interrupts =3D <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
> +				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
> +			clock-names =3D "aclk", "hclk", "npu", "pclk",
> +				      "aclk_cbuf", "hclk_cbuf";
> +			resets =3D <&cru SRST_A_RKNN0>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU0>;

[Severity: High]
Will specifying only a single power domain here conflict with the driver's
explicit attach logic?

Looking at rocket_core_init() in drivers/accel/rocket/rocket_core.c, the
driver sets multi_power_domain =3D true and explicitly calls
devm_pm_domain_attach_list().

Because only a single power-domains entry is specified, the driver-core will
automatically attach the domain during platform_probe(), populating
dev->pm_domain before the driver's probe runs.

This would cause devm_pm_domain_attach_list() to return -EEXIST, aborting
the probe for both NPU cores.

> +			iommus =3D <&rknn_mmu_0>;
> +			status =3D "disabled";
> +		};
> +
> +		rknn_mmu_0: iommu@27702000 {
> +			compatible =3D "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
> +			reg =3D <0x0 0x27702000 0x0 0x100>,
> +			      <0x0 0x27702100 0x0 0x100>;
> +			interrupts =3D <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
> +				 <&cru HCLK_RKNN_CBUF>;

[Severity: Low]
Does this violate the rockchip,iommu binding schema?

The rockchip,iommu.yaml schema requires exactly two clocks (aclk and iface)
and strictly mandates the clock-names property.

Here, 5 unnamed clocks are defined and the clock-names property is omitted,
which might cause dtbs_check validation failures.

> +			#iommu-cells =3D <0>;
> +			power-domains =3D <&power RK3576_PD_NPU0>;
> +			status =3D "disabled";
> +		};
> +
> +		rknn_core_1: npu@27710000 {
[ ... ]
> +			interrupts =3D <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>;
> +			clock-names =3D "aclk", "hclk", "npu", "pclk";

[Severity: High]
Are the CBUF clocks (aclk_cbuf and hclk_cbuf) missing from this node?

The rocket driver explicitly requests 6 clocks via devm_clk_bulk_get() (as
defined by .num_clks =3D 6 in rk3576_soc_data).

Since devm_clk_bulk_get() is not optional, it will fail with -ENOENT when it
cannot find the aclk_cbuf and hclk_cbuf clocks for NPU1, preventing the
device from probing.

> +			resets =3D <&cru SRST_A_RKNN1>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU1>;
> +			iommus =3D <&rknn_mmu_1>;
> +			status =3D "disabled";
> +		};
> +
> +		rknn_mmu_1: iommu@2770a000 {
> +			compatible =3D "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
> +			reg =3D <0x0 0x2770a000 0x0 0x100>,
> +			      <0x0 0x2770a100 0x0 0x100>;

[Severity: High]
Is this reg base address correct for the NPU1 IOMMU?

NPU1 starts at 0x27710000, so the corresponding IOMMU hole is typically at
offset +0x2000 (0x27712000).

Mapping this to 0x2770a000 places it inside the 0x2770xxxx memory space
belonging to NPU0. When the IOMMU driver interacts with this wrong base
address, it might configure incorrect hardware registers or trigger faults.


Additionally, looking at the related driver code in
drivers/accel/rocket/rocket_job.c:

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);

	scoped_guard(mutex, &core->job_lock)
		if (core->in_flight_job) {
			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count=
) {
				rocket_job_hw_submit(core, core->in_flight_job);
				return;
			}
...

[Severity: High]
Can a race condition occur here between the IRQ handler and poll_work?

rocket_job_handle_irq() can execute concurrently from both
rocket_job_irq_handler_thread and rocket_poll_work_fn. Because there is no
mutual exclusion protecting the initial register writes (like
OPERATION_ENABLE), one thread could complete a task, submit the next task to
the hardware via rocket_job_hw_submit(), and release the lock.

Another thread might then immediately acquire the lock, see
core->in_flight_job with next_task_idx advanced, and erroneously signal the
newly running task as complete.

Does this risk detaching the IOMMU while the NPU is actively executing and
writing to memory?


Also in drivers/accel/rocket/rocket_job.c:

drivers/accel/rocket/rocket_job.c:rocket_reset() {
static void
rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
{
	if (!atomic_read(&core->reset.pending))
		return;

	drm_sched_stop(&core->sched, bad);

	scoped_guard(mutex, &core->job_lock) {
...

[Severity: High]
Is poll_work properly cancelled during a job reset here?

When an NPU job times out, rocket_reset() resets the hardware and restarts
the DRM scheduler, but it appears to miss cancelling core->poll_timer and
flushing core->poll_work.

If a timeout occurs just as the polling timer fires, the unhandled poll_work
could persist. When the next valid job is submitted by the restarted
scheduler, the stale work item might execute, improperly cancel the new
job's timer, stop the hardware, and erroneously signal completion for the
brand-new job.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731043507.1832=
277-1-gahing@gahingwoo.com?part=3D5
