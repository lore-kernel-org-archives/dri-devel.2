Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAF606A331
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ3PdbvX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB32610F6D4;
	Tue, 17 Nov 2026 12:56:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C4610F6D4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:56:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD6EE43E10;
 Tue, 17 Nov 2026 12:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4233F1F000C4;
 Tue, 17 Nov 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794920188;
 bh=7vsiONFVWdrbmVygvYmrT2Iwf/VJLJ6R2Ay7M90Ttno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EQ3PdbvXHf+m42BTDypbhdvcNktzmIxq8Bk9aDNKwLeZnwSIpPrSP7SbLQSpkDw6o
 T5QdCbCM/zSS3iySF1la7gFPb0H/ijpqZ5HWWGZybnBWZtx2t3d23oI564VZ3vlmDV
 UWwhuhKJ3xbUXuwMJ++nB/+3J7PakH+obMyO+Yu1KOFHjwe4n5eHwAFeltpHMHeihO
 Dty/VLsQXrKAvSu8RfnT4fqJeHLNYOYUZsyN11RiPejImTY3dcejnwO+8Z6eQ2jU5z
 ENyluKdnY54dFJrH++A5V3iXlbQOp0sofmlGvK5vnyJJ2w7ooEX9srFSQ3VgxMUKQ3
 efdI2NLKn5fjQ==
Message-ID: <sashiko-outbox-218812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/11] arm64: dts: qcom: sm8250-lge-timelm: add
 SW42902 touchscreen
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-10-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-10-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:56:27 +0000
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
- [High] arm64: dts: qcom: Signed-off-by and Author use handle instead
  of real name
- [Low] arm64: dts: qcom: sm8250-lge-timelm: i2c13 and tlmm nodes out of
  order
--

commit c8220e43d297448ae1467ca0fc69fcaa8385a92a
Author: rofikkerneldev <rofikcoga@gmail.com>

> arm64: dts: qcom: sm8250-lge-timelm: add SW42902 touchscreen
>
> Describe the SW42902 on GENI I2C13 with its interrupt, reset,
> power-enable GPIOs, pinctrl, and native 1080x2460 touch area.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
Both the commit Author and the Signed-off-by trailer use the account
handle "rofikkerneldev" instead of a real human name.  Under the
Developer Certificate of Origin in
Documentation/process/submitting-patches.rst, patches must be authored
and signed off using a known real name rather than a pseudonym or
username.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/=
boot/dts/qcom/sm8250-lge-timelm.dts
> index fca48472f5dfe..a094aa81ad225 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> @@ -596,3 +596,39 @@ &mdss_dsi0_phy {
>  	phy-type =3D <PHY_TYPE_DPHY>;
>  	status =3D "okay";
>  };
> +
> +&i2c13 {
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +
> +	touchscreen@28 {
> +		compatible =3D "lg,sw42902";
> +		reg =3D <0x28>;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&touch_reset_default &touch_irq_default>;
> +		interrupt-parent =3D <&tlmm>;
> +		interrupts =3D <39 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios =3D <&tlmm 38 GPIO_ACTIVE_LOW>;
> +		vcl-gpios =3D <&tlmm 67 GPIO_ACTIVE_HIGH>;
> +		vdd-gpios =3D <&tlmm 68 GPIO_ACTIVE_HIGH>;
> +		touchscreen-size-x =3D <1080>;
> +		touchscreen-size-y =3D <2460>;
> +	};
> +};
> +
> +&tlmm {
> +	touch_reset_default: touch-reset-default-state {
> +		pins =3D "gpio38";
> +		function =3D "gpio";
> +		drive-strength =3D <6>;
> +		bias-pull-up;
> +	};
> +
> +	touch_irq_default: touch-irq-default-state {
> +		pins =3D "gpio39";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-pull-up;
> +	};
> +};

[Severity: Low]
This isn't a bug, but &i2c13 and &tlmm are appended at the bottom of the
file after &mdss_dsi0_phy rather than in alphabetical order (&i2c13
after &gpu and &tlmm before &uart12) as expected by
Documentation/devicetree/bindings/dts-coding-style.rst and the rest of
this board file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D9
