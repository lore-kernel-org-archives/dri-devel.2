Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7516C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185C510F4C6;
	Fri, 17 Jul 2026 09:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J9ttQivl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB13910F4C6
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:32:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 568DC60A5E;
 Fri, 17 Jul 2026 09:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B291F1F000E9;
 Fri, 17 Jul 2026 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784280735;
 bh=Q//o8vGbXXq+0kgHfmQL5NBT5qItyGKywaDEhIwEYTA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J9ttQivlNgFOfgnbrYI8ZAgRp9WxEPl0QfdqIBbGyw741pmTU3/XszBtnillNvgvD
 mt3HbuPGFKPQNQt7JQLl+dBflnd9DpS/FK/XBs5HqvtBFdBtQRa22oLCINVeQUVvcp
 VHRk6ZZGhbim9N2LetPPciGzkR3/xEer/XZlOdKqgb3A6cAgeajFIACaGsZgSVbJS1
 RIXbl+bgrlGA7j6PRR8rovYVxueo3YEmbLKyMinWbnEdTMPEGBlKRBGHqlN8J7FNSQ
 1jtw9h4/Z394jC0VvRnaRnieOP/DiSZq0lfd2u6dK+TKEO6OEmsCDENjoOfSZXYa0C
 X9s7iYjs4AA4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 9/9] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260717085220.3212274-10-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-10-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:32:14 +0000
Message-Id: <20260717093214.B291F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional call to `devm_pm_domain_attach_list()` breaks probe =
on single power-domain platforms (e.g., RK3588).
- [Medium] Devicetree binding schema violation: `power-domains` has multipl=
e items.
--

--- Patch [9]: [RFC PATCH 9/9] arm64: dts: rockchip: rk3576-rock-4d: enable=
 NPU ---
commit b202e27a2b4bfe1725b5bf2c08f62041f816c518
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576-rock-4d: enable NPU

This commit enables rknn_core_0 and rknn_mmu_0 on the Radxa ROCK 4D. It
supplies the NPU rail and configures the power domains.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64=
/boot/dts/rockchip/rk3576-rock-4d.dts
> index 272af1012ab03..09d2fc98bb4c1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts

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

[Severity: High]
Does the driver's handling of the multi-PD list break probe on single-PD
platforms like RK3588?

The comment here notes that rocket attaches the multi-PD list. When a device
has exactly one power-domains entry, the driver core automatically populates
dev->pm_domain before rocket_core_init() runs.

If the driver unconditionally calls devm_pm_domain_attach_list():

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
    ...
		err =3D devm_pm_domain_attach_list(dev, NULL, &pd_list);
		if (err < 0)
			return dev_err_probe(dev, err,
					     "failed to attach NPU power domains\n");
    ...
}

In this scenario, devm_pm_domain_attach_list() returns -EEXIST because
dev->pm_domain is already set. Since -EEXIST is less than 0, won't this abo=
rt
the probe via dev_err_probe(), fatally failing initialization for platforms
with only one power domain?

[Severity: Medium]
Will this multiple power domain configuration cause dtbs_check validation
errors?

The schema currently restricts the power-domains property to a single item:

Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml:
  power-domains:
    maxItems: 1

Since this adds both RK3576_PD_NPU0 and RK3576_PD_NPU1, could the schema
be updated to support maxItems: 2 before adding this configuration to avoid
build-time tooling errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717085220.3212=
274-1-gahing@gahingwoo.com?part=3D9
