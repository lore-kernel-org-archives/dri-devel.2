Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C6606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in01Ju3q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC19610F700;
	Tue, 17 Nov 2026 13:12:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7685910F701
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:12:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF43C6347B;
 Tue, 17 Nov 2026 13:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184881F000C5;
 Tue, 17 Nov 2026 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794921134;
 bh=iJBQqRQzoXZT7PfdBPjYwSNCpOqgJZva0MpxKAl1fCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=in01Ju3qLR3T6hfnJlSnS+nq81QNlcX84Wzx8Go2ErJtbvaZUQ6bmlXQ2T01ZBFdG
 QZpIMKm8dyI06357sBFbLPeqJqg3Qhq06xkxjg3ZqYQNOfzE9BGccdIStUAar0pA+4
 a5RtOYHLlWAYtupOEfLENgoeYagaNibuOHs0BIDX38P/MGGw+BbSg8/QjqQKgaqimj
 SxcFQn11xs65WLPrQoYIFzPNXeBCOvf/7ya+FESQmZuDZsw+J0vRgqsueT4u61risS
 6x+A+legurLCCLSlsc4brtpJZgCmEt7qQuLbU0hPcbforWolfe+vcB0JfBZHuskvzr
 ic9TWTz9T9l0Q==
Message-ID: <sashiko-outbox-218843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/11] arm64: dts: qcom: sm8250-lge-timelm: enable
 USB Type-C
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-11-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-11-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:12:13 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] arm64: dts: qcom: username handle used in Signed-off-by trailer
- [High] arm64: dts: qcom: sm8250-lge-timelm: missing OF graph ports in
  usb-c-connector
- [High] arm64: dts: qcom: sm8250-lge-timelm: PDO_BATT in sink-pdos
  breaks 9V PD current
- [Medium] arm64: dts: qcom: sm8250-lge-timelm: swapped supplies in
  usb_1_qmpphy
--

commit 81ec31057ff34acf5ea3063aab5a376e5f194531
Author: rofikkerneldev <rofikcoga@gmail.com>

> arm64: dts: qcom: sm8250-lge-timelm: enable USB Type-C
>
> Enable the PM8150B Type-C controller as a sink-only port. Keep the
> primary DWC3 controller in peripheral mode for now; host mode and VBUS
> sourcing can be enabled after OTG power delivery is validated.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
Under Documentation/process/submitting-patches.rst, the Developer's
Certificate of Origin requires a real human name rather than an account
handle in the Author header and Signed-off-by trailer.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/=
boot/dts/qcom/sm8250-lge-timelm.dts
> index a094aa81ad225..6b57c658cf918 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> @@ -535,6 +535,24 @@ &sdhc_2 {
>  	no-mmc;
>  };
> =20
> +&pm8150b_typec {
> +	status =3D "okay";
> +
> +	vdd-pdphy-supply =3D <&vreg_l2a_3p1>;
> +
> +	connector {
> +		compatible =3D "usb-c-connector";
> +
> +		power-role =3D "sink";
> +		data-role =3D "device";
> +		self-powered;
> +
> +		op-sink-microwatt =3D <15000000>;
> +		sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +			     PDO_BATT(5000, 9000, 15000)>;

[Severity: High]
Should the second entry in sink-pdos use PDO_VAR() or PDO_FIXED() instead
of PDO_BATT()?

PDO_BATT(5000, 9000, 15000) encodes 15000 mW in bits [9:0] in 250 mW units
(value 60).  When connected to a standard USB-PD adapter advertising a 9V
PDO_TYPE_FIXED source PDO, tcpm_pd_select_pdo() matches that 9V source PDO
against this sink PDO by voltage range, and tcpm_pd_build_request() then
checks the source PDO type:

drivers/usb/typec/tcpm/tcpm.c:tcpm_pd_build_request() {
	...
	type =3D pdo_type(pdo);
	...
	if (type =3D=3D PDO_TYPE_BATT) {
		mw =3D min_power(pdo, matching_snk_pdo);
		ma =3D 1000 * mw / mv;
	} else {
		ma =3D min_current(pdo, matching_snk_pdo);
		mw =3D ma * mv / 1000;
	}
}

Because the source PDO is PDO_TYPE_FIXED, min_current() calls
pdo_max_current(matching_snk_pdo), which interprets bits [9:0] in 10 mA
units.  That clamps the requested current at 9V to 600 mA (5.4 W instead
of 15 W) and sets RDO_CAP_MISMATCH.

> +	};
> +};

[Severity: High]
Is the connector node missing its ports subnode linking port@0 to
usb_1_dwc3_hs_out and port@1 to usb_1_qmpphy_out (along with the matching
remote-endpoint properties on those nodes)?

In qcom_pmic_typec_port_set_polarity(), the PM8150B TCPC driver does not
program SuperSpeed lane polarity itself and leaves orientation switching to
usb_1_qmpphy, which registers a Type-C orientation switch and mux in
qmp_combo_probe().  Without the OF graph endpoints under connector,
fwnode_typec_switch_get(), fwnode_typec_mux_get() and
fwnode_usb_role_switch_get() find no matches and return NULL.  When a
Type-C cable is plugged in with reversed (CC2) orientation,
typec_set_orientation() is a no-op and usb_1_qmpphy stays stuck in
TYPEC_ORIENTATION_NORMAL, breaking SuperSpeed USB.  Omitting port@0 also
violates Documentation/devicetree/bindings/connector/usb-connector.yaml.

> +
>  &usb_1 {
>  	status =3D "okay";
>  };

[Severity: Medium]
Just below &usb_1, are vdda-phy-supply and vdda-pll-supply swapped in
&usb_1_qmpphy (introduced earlier in this series in commit "arm64: dts:
qcom: add LG V60 ThinQ 5G (timelm) support")?

&usb_1_qmpphy currently sets:

	vdda-phy-supply =3D <&vreg_l9a_1p2>;
	vdda-pll-supply =3D <&vreg_l18a_0p9>;

On SM8250 QMP PHYs, vdda-phy-supply is the 0.9V core rail (vreg_l18a_0p9)
and vdda-pll-supply is the 1.2V PLL rail (vreg_l9a_1p2).  Because
qmp_phy_vreg_l in drivers/phy/qualcomm/phy-qcom-qmp-combo.c requests
21800 uA on vdda-phy and 36000 uA on vdda-pll, swapping the supplies
programs inverted load votes on the two LDOs when &usb_1 brings the PHY up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D10
