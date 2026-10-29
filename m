Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DC606A335
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOqBrbBi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6C6112162;
	Thu, 29 Oct 2026 09:58:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BD410E7C5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:58:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 342BD601FE;
 Thu, 29 Oct 2026 09:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8444B1F01828;
 Thu, 29 Oct 2026 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793267903;
 bh=Ehad/V6Xbh5JId3uEy79I5nAeDepddQdYNwUbSw35YQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AOqBrbBi1Cm+XWBBqmePq72TskRADhH1xnlA2zy1SJwy2BOYe828/clupJ1f81wDG
 DHWTpp3NJR5LSslc1nXspp/VraMBsqaycO3ZysDz3pw3vhcCUx9cJAUlojcmujKDew
 6pqnYy2uQj00mtvaNYEH4Fsj0OyjIhngGsBsDGGH8e+nbrN83AxCnwPvqGz2krozw2
 ZmSq97eDnlQADoY6Yd/d2372rRVkkDVgmeXLzln8eTvrZe/pJsEI1eHFTynMBXU6a0
 FTE1amNS+rSJv5sR43XLMbR9t5jxSNSULfHMThivHt+cEwQrNtZDmjrrwI7mqjgVSg
 jb7Zmq9KEzLEQ==
Message-ID: <sashiko-outbox-189075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20261029-q8b-dts-v3-3-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
 <20261029-q8b-dts-v3-3-655696dfec45@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:58:23 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: missing pinctrl properties on uart2 in dragon-=
q8b
--

commit 806aef47629e5a5fdf23480747e829d1b21764d6
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

This commit adds initial device tree support for the Radxa Dragon Q8B
single-board computer based on the Qualcomm Snapdragon 8cx Gen 3 SC8280XP
platform.

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts b/arc=
h/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> new file mode 100644
> index 0000000000000..fd1e29ce83b27
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> @@ -0,0 +1,2049 @@

[ ... ]

> +/* E-key Bluetooth */
> +&uart2 {
> +	uart-has-rtscts;
> +	status =3D "okay";
> +
> +	port {
> +		uart2_ep: endpoint {
> +			remote-endpoint =3D <&wlan_uart_ep>;
> +		};
> +	};
> +};

[Severity: Medium]
Should the &uart2 node in arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8=
b.dts
include pinctrl-0 and pinctrl-names properties?

In arch/arm64/boot/dts/qcom/sc8280xp.dtsi, the base uart2: serial@988000 no=
de
does not define default pinctrl properties:

    uart2: serial@988000 {
        compatible =3D "qcom,geni-uart";
        reg =3D <0 0x00988000 0 0x4000>;
        ...
        status =3D "disabled";
    };

Instead, the pin configuration state qup_uart2_default (for gpio121 CTS,
gpio122 RTS, gpio123 TX, and gpio124 RX) is defined separately under &tlmm =
in
sc8280xp.dtsi for board device trees to reference.

When qcom_geni_serial probes uart2 for the M.2 E-key Bluetooth interface and
activates resources via pinctrl_bind_pins() and geni_se_resources_on() ->
pinctrl_pm_select_default_state(), the TLMM pins for UART2 will not be muxed
to the qup2 function or configured by Linux without:

    pinctrl-0 =3D <&qup_uart2_default>;
    pinctrl-names =3D "default";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v3=
-0-655696dfec45@radxa.com?part=3D3
