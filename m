Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2261C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E2210FAD3;
	Fri,  4 Sep 2026 11:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UGvk209N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01C310FAD3
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:54:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 88D5A4183D;
 Fri,  4 Sep 2026 11:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E41F00A3D;
 Fri,  4 Sep 2026 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788522871;
 bh=5FtP551ertCbjVglA9tJ1Khd6CYq2d6Vnx4Z1uC4NgE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UGvk209Nwfgf5Nat92NaedZtdNnq3AnxFCnGGdky4dUMNamu0y0bjwfZJsGbTE6Ux
 KJSA8BQn+ooDEZx+IsfGB2L/CfhZHeHxeZQcT9CdvK5kT4pCcDXhjo+AhmaNbI/SkB
 G9J1iQ0Yxel31i115cowJq/yvyW9Oo8/BFwwsR/3/Dbfski87OEVGacIqX5wGi77Fg
 5Ek2swVSks9lnsKoQ+T08HF4DDmL29HnXvk5qZYlSODHTkPWKF7+aa9EGlvE/53J4u
 9NFqOHTJDepX+qsrsuU0yef7nzXi+zAYoGo350/e2TYIP+bnlyR35Z7cOEo+FFuris
 VjRIhg8UsqsTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/12] arm64: tegra: Add VPR placeholder node on
 Tegra234
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: media-ci@linuxtv.org, devicetree@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, robh@kernel.org, conor+dt@kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-tegra-vpr-v6-10-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-10-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:54:30 +0000
Message-Id: <20260904115430.EB4E41F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The newly introduced `cma_alloc_at()` API does not validate if=
 the requested allocation range exceeds the bounds of the CMA region and mi=
smatches bit/page units, leading to an out-of-bounds read and write in the =
CMA bitmap.
- [High] The `tegra_vpr_set()` function passes 64-bit physical addresses an=
d sizes to a 32-bit SMC call, which truncates them, misconfiguring hardware=
 protection.
- [High] Missing mutex lock in `tegra_vpr_debugfs_show_chunks()` when itera=
ting over the `vpr->buffers` list.
- [High] A negative left shift occurs in `tegra_vpr_setup_chunks()` if the =
configured VPR size is small, leading to undefined behavior.
--

commit 4d64d0d8b755f60422c65bdb111c671e4013a472
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Add VPR placeholder node on Tegra234

This node contains two sets of properties, one for the case where the
VPR is resizable (in which case the VPR region will be dynamically
allocated at boot time) and another case where the VPR is fixed in size
and initialized by early firmware.

> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index 5e29316a4d759..6c4739efc8a5d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -29,6 +29,45 @@ aliases {
>  		i2c8 =3D &dp_aux_ch3_i2c;
>  	};
> =20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		vpr: protected {
> +			compatible =3D "nvidia,tegra-video-protection-region";

[Severity: High]
Is it possible for the shift operand to become negative when the VPR size is
small?

If the VPR size configured in the device tree is small (e.g., 4KB or 8KB),
get_order(vpr->size) is 0 or 1. Since vpr->num_chunks is hardcoded to 4,
ilog2(4) is 2. The shift operand can evaluate without bounds checking:

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_setup_chunks() {
	...
	max_size =3D PAGE_SIZE << (get_order(vpr->size) - ilog2(vpr->num_chunks));
	...
}

Can this evaluate to a negative number (e.g., 0 - 2 or 1 - 2) and cause a
negative shift during driver initialization based on device tree inputs?
On arm64, a negative shift count often wraps around, resulting in a very
large max_size.

[Severity: High]
Could passing these 64-bit addresses to the SMC32 call cause truncation?

The 64-bit parameters base and size are passed directly into an SMC32 call:

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_set() {
	...
	arm_smccc_smc(ARM_SMCCC_VENDOR_SIP_TE_PROGRAM_VPR_FUNC_ID, base, size,
		      0, 0, 0, 0, 0, &res);
	...
}

The ARM_SMCCC_VENDOR_SIP_TE_PROGRAM_VPR_FUNC_ID uses ARM_SMCCC_SMC_32,
meaning the SMC instruction adheres to the 32-bit calling convention, nativ=
ely
truncating the upper 32 bits of base and size inside the secure monitor. Si=
nce
CMA regions on arm64 frequently reside above the 4GB boundary, can this
misconfigure hardware protection by locking down the wrong physical memory?

[Severity: High]
Is it safe to iterate the vpr->buffers list here without acquiring a lock?

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_debugfs_show_chunks() {
	...
	list_for_each_entry(buffer, &vpr->buffers, list) {
	...
}

This iteration accesses a shared, mutable linked list without acquiring
vpr->lock. If another process performs a DMA-BUF allocation or release
concurrently, it modifies the vpr->buffers list under vpr->lock. Can this
result in list corruption or a use-after-free if modified or freed nodes are
encountered mid-traversal?

[Severity: Critical]
Are the offset and count units mismatched when calling cma_range_alloc()?

The exported cma_alloc_at API passes page-based offset and count to
cma_range_alloc():

mm/cma.c:cma_alloc_at() {
	...
	page =3D cma_alloc_at_frozen(cma, offset, count, no_warn);
	...
}

In cma_range_alloc(), this sets the max limit for the bitmap scan to end
without bounds checking:

mm/cma.c:cma_range_alloc() {
	...
	bitmap_maxno =3D (end > start) ? end : cma_bitmap_maxno(cma, cmr);
	...
}

cma_alloc_at_frozen() passes offset and offset + count (which are in pages)
to cma_range_alloc(), but cma_range_alloc() incorrectly assumes end is alwa=
ys
passed in bits instead of pages. Any driver calling cma_alloc_at() with an
offset + count exceeding the CMA region size could bypass length validation.

Will this scan past the end of the allocated CMA bitmap and allow bitmap_se=
t()
to write out-of-bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D10
