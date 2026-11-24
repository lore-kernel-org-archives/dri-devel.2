Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E2606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHimvtrA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7C310F64E;
	Tue, 24 Nov 2026 16:12:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC1D10F76A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:12:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B400043BB8;
 Tue, 24 Nov 2026 16:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EA81F000D0;
 Tue, 24 Nov 2026 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795536759;
 bh=gNy25Okrf92wqeBD3M5rZLW7dKuUygXa1dpAWhMmCnU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hHimvtrAZPWQ2aDw3pAFncGqi1luwqfx71yT56QeqPPBGktZkdZ1afRAwXwceEHpf
 YPbXYoOxirdodqooomOA/s9nRpUvomRFWpZe91r1T1tH0ImANbTljrNS0OCTe0O1H/
 hlPTqCnLtAt/iDgXdkg7Q2EKDq92vwOD0v40BXZWW0A4PkBrZtIqZm6cDgLONxIaai
 on2RVi2PHHwGyo8tjYALjXBqUx/kjsoSAmGf30bkG9SRr/GipW/h8lgLT54DMdq6LS
 LUtd2xUWicuKy8knwKNeCYusehBsoTgtr7/xh8UKZfcqLYez1hGg27J5fU4FiEOXHm
 M64xCC3VXPvGg==
Message-ID: <sashiko-outbox-231537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/18] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124-jh7110-clean-send-v8-17-de92635dd857@samsung.com>
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155431eucas1p18761b3a7bbc4e018c6840db83d1c64fb@eucas1p1.samsung.com>
 <20261124-jh7110-clean-send-v8-17-de92635dd857@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:12:38 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] riscv: dts: starfive: CMA alloc-ranges in jh7110-common.dtsi
  breaks 1 GiB RAM
- [Low] riscv: dts: starfive: duplicate 24 MHz xin24m clock node in
  jh7110.dtsi
--

commit 7ebd6a4c9bd05a6b380264edfb6e56553f4653a0
Author: Michal Wilczynski <m.wilczynski@samsung.com>

riscv: dts: starfive: jh7110: Update DT for display subsystem

This commit adds the JH7110 video output display subsystem, DC8200 display
controller, HDMI subsystem, and default CMA pool nodes to the StarFive
JH7110 device trees.

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 64de468f2c317..3eadb5732b011 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -33,6 +33,27 @@ memory@40000000 {
>  		bootph-pre-ram;
>  	};
> =20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/*
> +		 * The display controller allocates its framebuffers from CMA,
> +		 * and the default pool is too small for them. Keep the pool
> +		 * inside the range the controller can address; it fits in the
> +		 * memory every VisionFive 2 variant has.
> +		 */
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			size =3D <0x0 0x20000000>;
> +			alignment =3D <0x0 0x1000>;
> +			alloc-ranges =3D <0x0 0x70000000 0x0 0x20000000>;
> +			linux,cma-default;
> +		};
> +	};

[Severity: High]
Does pinning alloc-ranges to 0x70000000..0x90000000 break CMA reservation on
1 GiB JH7110 boards?

jh7110-common.dtsi is also included by boards that ship in 1 GiB RAM
configurations (such as Milk-V Mars and Mars CM), where DRAM starts at
0x40000000 and ends at 0x80000000.  With only 256 MiB of RAM falling inside
alloc-ranges, __reserved_mem_alloc_in_range() fails to reserve the 512 MiB
pool with -ENOMEM, leaving the system without its default CMA pool and
causing DC8200 framebuffer allocations to fail.

Even on boards with 2 GiB or more of RAM, matching the 512 MiB alloc-ranges
window to the exact 512 MiB pool size leaves no placement slack, so any
earlier memblock reservation (such as an initrd) overlapping
0x70000000..0x90000000 also causes the CMA reservation to fail.  Since
vs_dc_probe() sets DMA_BIT_MASK(32), can alloc-ranges cover the 32-bit
addressable DRAM window (for example <0x0 0x40000000 0x0 0xc0000000>) or a
smaller size that fits within 1 GiB configurations?

[ ... ]

> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 82ea63f715b0e..4c3ef68c16bb6 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -352,6 +346,13 @@ tdm_ext: tdm-ext-clock {
>  		#clock-cells =3D <0>;
>  	};
> =20
> +	xin24m: xin24m-clock {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "xin24m";
> +	};

[Severity: Low]
Does xin24m duplicate the existing osc: oscillator node in jh7110.dtsi?

The SoC 24 MHz reference crystal is already modelled as &osc (with its
24 MHz frequency set in jh7110-common.dtsi), and starfive_hdmi_phy_probe()
acquires its unnamed reference clock at index 0 and queries its parent name
dynamically via __clk_get_name(), so hdmi_phy can take clocks =3D <&osc>
directly without adding a second 24 MHz root clock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-jh7110-cle=
an-send-v8-0-de92635dd857@samsung.com?part=3D17
