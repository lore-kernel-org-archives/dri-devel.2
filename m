Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC0606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1ujNcTh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D754510E1CD;
	Wed, 18 Nov 2026 12:36:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999EA10FB6B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:36:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69ED3406C5;
 Wed, 18 Nov 2026 12:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BFF1F000C4;
 Wed, 18 Nov 2026 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795005389;
 bh=1eNcJwo2E7LTdexS+CZsvtImmjxHxDOzOBiWc5uB548=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h1ujNcThk8/H5Ge9XBxWFalVldtuE8wTpsBAB4vTYvTny5GNzWi1qkMCQgNFX6RJ0
 2pZhhi2ApvRt2/rNzePNJ8oty7eB2cQt4cEWbhjZDDg0msmGuI0Toxltg9We+3T7es
 ZKlzbBXLxygFmcuADhSqz2H0SqeQ4ceNi1FCsG5bcAICu2SvZb85Xquip1CHt23f86
 KVY7SiiCoix/R5WSdZijnKgr6gK1HOF2LQfQZwutzXxcnqiPXeUVFxkdhbp/x0A7Rz
 OYNf3aVTDANOek/9IXYfBWXR36tXd9D0bvXGDxzFsE68Z2HwNy2IICLsK7Cv0OsOse
 mYhC3RZo1YAkg==
Message-ID: <sashiko-outbox-220917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm)
 support
To: "Abdur Rofik" <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261118120714.31505-3-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
 <20261118120714.31505-3-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:36:28 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] arm64: dts: qcom: invalid smps6 in regulators-1 aborts
  rpmh_regulator_probe()
- [Medium] arm64: dts: qcom: conflicting reg and memory-region on
  simple-framebuffer
- [Medium] arm64: dts: qcom: missing board-specific firmware-name on
  cdsp and gpu_zap_shader
- [Low] arm64: dts: qcom: duplicate sdc2_sleep_state node and redundant
  pon status
- [Low] arm64: dts: qcom: non-power-of-two pmsg-size in ramoops is
  rounded down
--

commit 3fe02ddb83035271fb02be5f0c325bb78269f75e
Author: Abdur Rofik <rofikcoga@gmail.com>

arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support

This commit adds the initial device tree and MAINTAINERS entry for the
SM8250-based LG V60 ThinQ 5G (timelm) smartphone.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/b=
oot/dts/qcom/sm8250-lg-timelm.dts
> new file mode 100644
> index 0000000000000..1b2b67486fee7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
> @@ -0,0 +1,615 @@
[ ... ]
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		framebuffer@9c000000 {
> +			compatible =3D "simple-framebuffer";
> +			reg =3D <0x0 0x9c000000 0x0 (1080 * 2460 * 4)>;
> +			width =3D <1080>;
> +			height =3D <2460>;
> +			stride =3D <(1080 * 4)>;
> +			format =3D "a8r8g8b8";
> +			memory-region =3D <&cont_splash_mem>;
> +		};
> +	};

[Severity: Medium]
Should framebuffer@9c000000 drop memory-region (or drop reg and the unit
address) instead of specifying both?

When both properties are present, simplefb_get_memory_of() in simpledrm
and simplefb_parse_dt() in simplefb emit a boot warning ("preferring
"memory-region" over "reg" property") and ignore the exact framebuffer
size in reg in favor of the full 0x1200000-byte cont_splash_mem region,
allowing fb_mmap() on /dev/fb0 to map the trailing reserved memory beyond
the framebuffer.

[ ... ]

> +		ramoops: ramoops@b0000000 {
> +			compatible =3D "ramoops";
> +			reg =3D <0x0 0xb0000000 0x0 0x280000>;
> +			record-size =3D <0x40000>;
> +			console-size =3D <0x40000>;
> +			ftrace-size =3D <0x40000>;
> +			pmsg-size =3D <0x1c0000>;
> +			no-map;
> +		};

[Severity: Low]
Is pmsg-size =3D <0x1c0000> intended here?  ramoops_probe() requires
pmsg_size to be a power of two and rounds 0x1c0000 down to 0x100000 via
rounddown_pow_of_two(), shifting the buffer offsets and leaving the
remaining 0xc0000 bytes to dump_mem_sz.

[ ... ]

> +	regulators-1 {
> +		compatible =3D "qcom,pm8150l-rpmh-regulators";
> +		qcom,pmic-id =3D "c";
[ ... ]
> +		vreg_bob: bob {
> +			regulator-name =3D "vreg_bob";
> +			regulator-min-microvolt =3D <3008000>;
> +			regulator-max-microvolt =3D <4000000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		vreg_s6c_0p88: smps6 {
> +			regulator-name =3D "vreg_s6c_0p88";
> +			regulator-min-microvolt =3D <348000>;
> +			regulator-max-microvolt =3D <1000000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +		};

[Severity: High]
Does defining smps6 under regulators-1 cause rpmh_regulator_probe() to
fail with -ENODEV?

On SM8250 with PM8150L (qcom,pmic-id =3D "c"), SMPS6C is an ARC level
resource (ebi.lvl) rather than a VRM resource, so cmd_db_read_addr() in
rpmh_regulator_init_vreg() returns 0 for "smpc6" and aborts probing
regulators-1 before smps8 (vreg_s8c_1p35) and ldo1..ldo11 are registered.
That leaves the parent supplies for PM8150 and PM8009 LDOs as well as the
UFS, SDHC2, and USB PHY rails unregistered.

As on other SM8250 boards, vreg_s6c_0p88 should be a top-level
regulator-fixed node at 880000 uV, and the 348000..1000000 uV rail under
regulators-1 should be smps7 (vreg_s7c_0p35).

[ ... ]

> +&cdsp {
> +	status =3D "okay";
> +};
[ ... ]
> +&gpu {
> +	status =3D "okay";
> +
> +	zap-shader {
> +		firmware-name =3D "qcom/sm8250/a650_zap.mbn";
> +	};
> +};

[Severity: Medium]
Should &cdsp and the GPU zap-shader specify board-specific firmware-name
paths?

Enabling &cdsp without firmware-name causes qcom_pas_probe() to fall back
to bare "cdsp.mdt", and using the generic reference-board path
"qcom/sm8250/a650_zap.mbn" fails PAS authentication on fused retail
devices that require OEM-signed firmware (and zap-shader can be referenced
directly via &gpu_zap_shader).

[ ... ]

> +&pon {
> +	status =3D "okay";
> +};
[ ... ]
> +	sdc2_sleep_state: sdc2-sleep-state {
> +		clk-pins {
> +			pins =3D "sdc2_clk";
> +			drive-strength =3D <2>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins =3D "sdc2_cmd";
> +			drive-strength =3D <2>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins =3D "sdc2_data";
> +			drive-strength =3D <2>;
> +			bias-pull-up;
> +		};
> +	};

[Severity: Low]
This isn't a bug, but sdc2_sleep_state duplicates the identical node
already defined in sm8250.dtsi, and &pon is already enabled in
pm8150.dtsi.  Also, the commit message mentions "High-Speed USB on
PM8150B", whereas &usb_1_hsphy is the SoC-internal HS PHY supplied by
PM8150.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118120714.3150=
5-1-rofikcoga@gmail.com?part=3D2
