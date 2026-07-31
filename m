Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4983C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 04:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2771410E1A9;
	Fri, 31 Jul 2026 04:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GRc4UrPG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF9A10E1A5
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:51:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11FF1600C8;
 Fri, 31 Jul 2026 04:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6741F000E9;
 Fri, 31 Jul 2026 04:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785473502;
 bh=FANfdQFw84SOwOh29+4bZB9/QnD5u3j6T4iy89+w/vY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GRc4UrPGTNu5b5F5Fuijd8PvckLq06NgxtObkGpLlh6ZkRrDHFdYbMRGCg0YAkAP/
 rfe2cwu3+TsoBYZWVCJISC17ZkbRtTd1Q2n2plEIhG7O7JCos1K1G+IZC6GUNDDLiv
 b2ImV9/KfdjTfpAEpLZbWOlJHX0EVx4T7B5XAHQKWuUSHqS4ihmOVwm7XA2n75Idye
 9o7WAM7WH8mOpngwkRKW8wJYMdK/OZzNDQFmJVkEqblyrrYfNpFg+LiA4hiedBVgY5
 3KwvJ/MjxvV+wvV8CzQA5Pdgac3us2jjuAAMWw7d1YMKe+glH4tCUaBJnha3Q8NE0E
 ebzYCxXKddnmQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 6/6] arm64: dts: rockchip: rk3576-rock-4d: enable
 NPU
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260731043507.1832277-7-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
 <20260731043507.1832277-7-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 04:51:42 +0000
Message-Id: <20260731045142.7B6741F000E9@smtp.kernel.org>
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
- [High] Missing cleanup of `poll_timer` and `poll_work` in `rocket_job_fin=
i()` leads to Use-After-Free on unload.
- [High] The driver statically requires 6 clocks for RK3576, causing inevit=
able probe failure for `rknn_core_1`.
- [Medium] Using `regulator-always-on` for the dedicated NPU regulator prev=
ents runtime power savings and bypasses genpd management.
- [Low] Board-level DeviceTree overrides SoC-internal NPU power domain topo=
logy, violating DT schema bindings.
--

--- Patch [6]: [RFC PATCH v3 6/6] arm64: dts: rockchip: rk3576-rock-4d: ena=
ble NPU ---
commit 317571d0650068ec684ea45a47d155fe5e0ea20c
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576-rock-4d: enable NPU

This commit enables rknn_core_0 and its IOMMU on the Radxa ROCK 4D. It
supplies the core from vdd_npu_s0 and assigns multiple NPU power domains
to the single NPU node.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64=
/boot/dts/rockchip/rk3576-rock-4d.dts
> --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
[ ... ]
> @@ -442,6 +442,7 @@ regulator-state-mem {
>  			};
> =20
>  			vdd_npu_s0: dcdc-reg2 {
> +				regulator-always-on;

[Severity: Medium]
Does setting regulator-always-on for the dedicated NPU regulator bypass=20
the generic power domain management? It appears this will prevent the=20
regulator from being powered down during runtime suspend, potentially=20
wasting power when the accelerator is idle.

>  				regulator-boot-on;
>  				regulator-enable-ramp-delay =3D <400>;
[ ... ]
> +&rknn_core_0 {
> +	npu-supply =3D <&vdd_npu_s0>;
> +	/*
> +	 * Power BOTH NPU domains (NPU0 + NPU1) like the vendor's single NPU no=
de,
> +	 * even though rocket computes only on core 0: the CBUF->CMAC read path=
 is
> +	 * only fully powered with NPU1 up. rocket attaches the multi-PD list.
> +	 */
> +	power-domains =3D <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;

[Severity: Low]
Will this board-level override cause a device tree schema validation=20
failure? The rockchip,rk3588-rknn-core.yaml binding strictly enforces a=20
maximum of 1 power domain:

Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml:
  power-domains:
    maxItems: 1

[ ... ]

[Severity: High]
Does rocket_job_fini() in drivers/accel/rocket/rocket_job.c leave=20
background polling active when the memory is freed?

drivers/accel/rocket/rocket_job.c:
void rocket_job_fini(struct rocket_core *core)

If the module is unloaded while a job is actively polling, the lack of=20
hrtimer_cancel() and cancel_work_sync() calls could allow the timer or=20
workqueue to execute against freed struct rocket_core memory, causing a=20
use-after-free.

[Severity: High]
Will rknn_core_1 fail to probe on the RK3576 SoC due to a strict clock=20
requirement?

drivers/accel/rocket/rocket_drv.c:rk3576_soc_data()
	.num_clks =3D 6,

drivers/accel/rocket/rocket_core.c:rocket_core_init()
	err =3D devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
	if (err)
		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core=
->index);

Because num_clks is statically defined as 6 for the entire SoC, and=20
rknn_core_1 does not possess the aclk_cbuf and hclk_cbuf clocks, this bulk=
=20
request will fail with -ENOENT when rknn_core_1 is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731043507.1832=
277-1-gahing@gahingwoo.com?part=3D6
