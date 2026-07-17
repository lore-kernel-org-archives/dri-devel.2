Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE8FC44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6269210F4C8;
	Fri, 17 Jul 2026 09:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cKAjkLIS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EFF10F4C6
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:23:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E2DA60A5E;
 Fri, 17 Jul 2026 09:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E031F000E9;
 Fri, 17 Jul 2026 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784280184;
 bh=6fxUl6vZHOXNAFKDrRG9N1/wTZD/wLlZazvwSSdIeoI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cKAjkLISdVBTGZfQ/3PFeiZqL57qjk9h/XyCQtdZJoUTTG6mhyjwADMbulRNWKdxw
 smpAvntFNjar+Rc9XJN+kZseb7Zzl3clul65JRZwWZvo2BLhywvi9FkrtlDq9vtL3U
 wuBv/6gVecTGTYH3WVpcCxMl9Ai4+z29MHt/s+uW28D19u44EjWQJU+5dxKjACxvkG
 Q3+Ym8+syCHgRhyPFi9GnmpClEdYFA5ClO1rO/ksG8nfQoVknR/AK0dnYiEa53Urlj
 ySAGtzxVVi8uMMnG8H+CwYpiDVOz2/agCo2O9wmexRyUOLPWnvDmbGt9OBz87I+Vu4
 HRJqRi6hzXTxA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/9] iommu/rockchip: skip orphaned-fault banks in
 CMD_ENABLE_STALL dispatch
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260717085220.3212274-6-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-6-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:23:03 +0000
Message-Id: <20260717092303.C4E031F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Missing reset_control_put() causes a resource leak on PM domain =
removal.
- [Medium] rk_iommu_disable_stall() unconditionally times out if all MMU ba=
nks are in the orphaned-fault state.
- [Low] Relaxing the global 'required' list breaks validation for RK3588 NP=
U.

Pre-existing issues:
- [High] On multi-bank IOMMUs (num_mmu > 1), rk_iommu_disable_stall and rk_=
iommu_disable_paging return success prematurely when disabling, potentially=
 leaving banks active.
- [High] The `rk_iommu_probe` function contains a critical flaw in how it p=
opulates and handles errors in the `iommu->bases` array, leading to a guara=
nteed kernel panic on malformed device trees and a sparse array bug resulti=
ng in `ERR_PTR` dereferences.
--

--- Patch [5]: [RFC PATCH 5/9] iommu/rockchip: skip orphaned-fault banks in=
 CMD_ENABLE_STALL dispatch ---
commit e1850eec170c4af87cf79a1f7f05257d02a8ccf8
Author: Jiaxing Hu <gahing@gahingwoo.com>

iommu/rockchip: skip orphaned-fault banks in CMD_ENABLE_STALL dispatch

Sending CMD_ENABLE_STALL to a bank that carries an orphaned firmware
fault (PAGE_FAULT_ACTIVE & !STALL_ACTIVE & IDLE) causes the command to
be silently dropped by that bank.  The dropped command also interferes
with the other banks' stall transition, delaying them past the poll
timeout even though they would otherwise stall within a few
microseconds.

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index ad462cee6bd89..7dbcc978ede79 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -436,7 +436,21 @@ static int rk_iommu_enable_stall(struct rk_iommu *io=
mmu)
>  	if (!rk_iommu_is_paging_enabled(iommu))
>  		return 0;
> =20
> -	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL);
> +	/*
> +	 * Do not send CMD_ENABLE_STALL to orphaned-fault banks
> +	 * (PAGE_FAULT_ACTIVE & !STALL_ACTIVE & IDLE): the command is ignored
> +	 * by such a bank but its presence on the shared bus delays the other
> +	 * banks from reaching STALL_ACTIVE within the poll timeout.
> +	 */
> +	for (i =3D 0; i < iommu->num_mmu; i++) {
> +		u32 status =3D rk_iommu_read(iommu->bases[i], RK_MMU_STATUS);
> +
> +		if ((status & RK_MMU_STATUS_PAGE_FAULT_ACTIVE) &&
> +		    !(status & RK_MMU_STATUS_STALL_ACTIVE) &&
> +		    (status & RK_MMU_STATUS_IDLE))
> +			continue;
> +		writel(RK_MMU_CMD_ENABLE_STALL, iommu->bases[i] + RK_MMU_COMMAND);
> +	}
> =20
>  	ret =3D readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
>  				 val, RK_MMU_POLL_PERIOD_US,

[Severity: Medium]
Does rk_iommu_disable_stall() unconditionally timeout if all MMU banks are =
in
the orphaned-fault state?

Looking at rk_iommu_is_stall_active(), if all banks are orphaned, the loop
skips evaluating them:

drivers/iommu/rockchip-iommu.c:rk_iommu_is_stall_active() {
...
	for (i =3D 0; i < iommu->num_mmu; i++) {
...
		if ((status & RK_MMU_STATUS_PAGE_FAULT_ACTIVE) &&
		    !(status & RK_MMU_STATUS_STALL_ACTIVE) &&
		    (status & RK_MMU_STATUS_IDLE))
			continue;

		active &=3D !!(status & RK_MMU_STATUS_STALL_ACTIVE);
	}

	return active;
}

Since 'active' starts as true, it remains true and does not reflect their
bypassed state, meaning a fully-skipped IOMMU reports as stalled.

Then in rk_iommu_disable_stall():

drivers/iommu/rockchip-iommu.c:rk_iommu_disable_stall() {
...
	ret =3D readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
				 !val, RK_MMU_POLL_PERIOD_US,
				 RK_MMU_POLL_TIMEOUT_US);
...
}

The polling loop waits for !rk_iommu_is_stall_active(), which will
unconditionally exhaust its timeout if all banks are orphaned and continual=
ly
report as stalled.

[Severity: High]
This is a pre-existing issue, but do rk_iommu_disable_stall() and
rk_iommu_disable_paging() return success prematurely when disabling on
multi-bank IOMMUs?

Because of the bitwise AND reduction in rk_iommu_is_stall_active():

drivers/iommu/rockchip-iommu.c:rk_iommu_is_stall_active() {
...
	for (i =3D 0; i < iommu->num_mmu; i++) {
...
		active &=3D !!(status & RK_MMU_STATUS_STALL_ACTIVE);
	}

	return active;
}

The function returns false (indicating no stall) if ANY single bank has
finished its stall transition, ignoring banks that are still active.

Then in rk_iommu_disable_stall():

drivers/iommu/rockchip-iommu.c:rk_iommu_disable_stall() {
...
	ret =3D readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
				 !val, RK_MMU_POLL_PERIOD_US,
...
}

The poll condition !val incorrectly succeeds as soon as any single bank
unstalls, potentially leaving other hardware banks active.

[Severity: High]
This is a pre-existing issue, but is there a risk of a kernel panic in
rk_iommu_probe() due to how the iommu->bases array is handled?

If the device tree has 0 resources, or if devm_ioremap_resource() fails for=
 an
early resource but succeeds for a later one in a multi-MMU configuration, t=
he
array is populated sparsely:

drivers/iommu/rockchip-iommu.c:rk_iommu_probe() {
...
	for (i =3D 0; i < num_res; i++) {
		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
		if (!res)
			continue;
		iommu->bases[i] =3D devm_ioremap_resource(&pdev->dev, res);
		if (IS_ERR(iommu->bases[i]))
			continue;
		iommu->num_mmu++;
	}
	if (iommu->num_mmu =3D=3D 0)
		return PTR_ERR(iommu->bases[0]);
...
}

If zero resources are provided, devm_kcalloc() returns ZERO_SIZE_PTR, which=
 is
then invalidly dereferenced at index 0. Also, if an early resource fails
mapping, the array is populated sparsely using loop index 'i' instead of
'num_mmu', but runtime logic expects contiguous valid pointers, leading to a
dereference of ERR_PTR during register reads.

[Severity: Medium]
Does rockchip_pm_remove_one_domain() miss freeing reset controls on
PM domain removal?

When the PM domain is removed (e.g., during driver unbind) or if probing
fails for a later power domain:

drivers/pmdomain/rockchip/pm-domains.c:rockchip_pm_remove_one_domain() {
...
	clk_bulk_unprepare(pd->num_clks, pd->clks);
	clk_bulk_put(pd->num_clks, pd->clks);
...
}

This teardown function misses the reset_control_put() call to free the
reset controls retrieved during addition, causing a resource leak.

[Severity: Low]
Does relaxing the global 'required' list break validation for RK3588 NPU?

Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml:
...
  - reset-names
  - npu-supply

additionalProperties: false
...

The 'sram-supply' property was removed from the global 'required' list here.
Will DT schema validation fail to flag missing 'sram-supply' for RK3588
devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717085220.3212=
274-1-gahing@gahingwoo.com?part=3D5
