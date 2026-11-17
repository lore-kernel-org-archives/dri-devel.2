Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8D606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFrkNRPC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531BC10F6F7;
	Tue, 17 Nov 2026 13:09:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E805210F6F7
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:09:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BBE66256D;
 Tue, 17 Nov 2026 13:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F9C1F000C4;
 Tue, 17 Nov 2026 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794920954;
 bh=tqwfXbj3ZR7mRZUcNEreZ1uIDndR1OB4dKoeTEFs4pc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QFrkNRPCLNgFrdbcUQ0CR0aOhr8TILgrCZCB9zl1CeqvFgJ9Pd8VYouqAp+b1j4Fv
 D3pLWlJPzbWTpiC3BMjY5RFWDXZRL6iE8LK5Z6/g9F0TenC3TkjL7/2lCNpN0Y3DYp
 MyWgT36FnxjBWJU5zGK9t6cX4xtjdUgCUM6ppDWj62eEXalVQtapTl7rquzdK+zmO0
 nZs2/EV8yXFaRx+IA5GDOPZBJkNXcwc+pmlCRMYSQpvQoKP3LCpAwE4S0zVilWMy/J
 OeslIAdIZPMeLlizPzZzl6Wa1IbS2ho+tYdYDoqRv6vpkF2hNrxG++vF/uC8DO+t7u
 tzohtIbAuLCjA==
Message-ID: <sashiko-outbox-218840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/11] arm64: dts: qcom: sm8250-lge-timelm: add
 QCA6390 Bluetooth
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-12-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-12-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:09:13 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] arm64: dts: qcom: non-real-name handle in Signed-off-by trailer
- [High] arm64: dts: qcom: sm8250-lge-timelm: under-volted QCA6390 PMU
  supplies
--

commit c689e882729fccea2deb0c720da66bf756537580
Author: rofikkerneldev <rofikcoga@gmail.com>

> arm64: dts: qcom: sm8250-lge-timelm: add QCA6390 Bluetooth
>
> Describe the QCA6390 power sequencer and its PMU regulators. Enable the
> Bluetooth HCI controller on GENI UART6 with the supplies provided by the
> PMU.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use an account handle
(rofikkerneldev) instead of a known real human name, which does not meet
the Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/=
boot/dts/qcom/sm8250-lge-timelm.dts
> index 6b57c658cf918..38816268fcf53 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> @@ -95,6 +95,67 @@ key-assistant {
>  		};
>  	};
> =20
> +	qca6390-pmu {
> +		compatible =3D "qcom,qca6390-pmu";
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bt_en_state>, <&wlan_en_state>;
> +
> +		vddaon-supply =3D <&vreg_s6a_0p6>;
> +		vddpmu-supply =3D <&vreg_s6a_0p6>;
> +		vddrfa0p95-supply =3D <&vreg_s6a_0p6>;
> +		vddrfa1p3-supply =3D <&vreg_s8c_1p2>;
> +		vddrfa1p9-supply =3D <&vreg_s5a_1p9>;
> +		vddpcie1p3-supply =3D <&vreg_s8c_1p2>;
> +		vddpcie1p9-supply =3D <&vreg_s5a_1p9>;
> +		vddio-supply =3D <&vreg_s4a_1p8>;

[Severity: High]
Does wiring vddaon-supply, vddpmu-supply and vddrfa0p95-supply to
vreg_s6a_0p6, and vddrfa1p3-supply and vddpcie1p3-supply to vreg_s8c_1p2,
under-volt the QCA6390 PMU?

pwrseq-qcom-wcn only enables these regulators without calling
regulator_set_voltage(), so the RPMh regulator driver initializes them to
their regulator-min-microvolt constraints when enabled.  In this board DT,
vreg_s6a_0p6 has regulator-min-microvolt =3D <600000> and vreg_s8c_1p2 has
regulator-min-microvolt =3D <1200000>, with no other consumer voting a high=
er
voltage.  That drives the 0.95V PMU inputs at 0.6V (below the PMU's own
0.8V and 0.85V LDO outputs) and the 1.35V inputs at 1.2V.  Should the
minimum voltages on smps6 and smps8 be raised to ~950000 uV and ~1350000 uV
like on other SM8250 QCA6390 boards?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D11
