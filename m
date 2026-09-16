Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A713EC982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1021510E0E3;
	Wed, 16 Sep 2026 14:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MXYDnN82";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817EB10E0E3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:37:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EA6643C4E;
 Wed, 16 Sep 2026 14:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9125F1F000FF;
 Wed, 16 Sep 2026 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569430;
 bh=WmD7+JkdWSw5bXD8OLAxj69nU9CDDrx2HTygqDjUwHo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MXYDnN82sgfKyS0kVNgDXOfkvg76I+iXYBnnbYS62lYTWaWczLaRP+cNZC0xVJ1IP
 skOFzs1/i9uHZ27QZsrbg3SZrbaDX+aYl5CcOI5+lu5sJVBpU66RfNPiAk+Z2/8qYv
 Ohvy6pIGr7VG376dHibYR0FxhgQ0K4D+i8pox1ZqDdZJahZ0SKw2n9xXlhvsWW9Uhj
 SMJXK3T4e4WDL43JlpmwaLKyAGds4k+sMIAedJSHZMpGpWUIvEYVISFvHph82LfQug
 QPHTe+xMqHif9J31QUkXL5IFy5AB86p3XDHn7jXvGcooV5+ihlrdoEhWlUAxcsjpyQ
 TLASaUIdo33+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/19] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
 mfd@lists.linux.dev, lee@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-msm8952-initial-support-v2-19-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-19-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:37:09 +0000
Message-Id: <20260916143709.9125F1F000FF@smtp.kernel.org>
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
- [Medium] dts: console UART (blsp1_uart2) is left disabled
- [Medium] dts: TUSB320 interrupt configured as rising edge causes missed e=
vents
--

commit eeb150c49a7166233f7744c010edc1dd2b105149
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: generalmobile-shamrock: new device

Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed similar to
L9300. Downstream reference is [1].

Link: https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob=
/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi

> diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts =
b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> new file mode 100644
> index 0000000000000..e6c92ebcbf214
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
[ ... ]
> +	aliases {
> +		mmc0 =3D &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 =3D &sdhc_2; /* SDC2 SD card slot */
> +		serial0 =3D &blsp1_uart2;
> +	};
[ ... ]
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";

[Severity: Medium]
Will the kernel be able to probe the UART device intended for the console?

This configures the kernel console to use serial0, which maps to blsp1_uart=
2.
However, blsp1_uart2 is left with status =3D "disabled" in the included
msm8952.dtsi and is never explicitly enabled with status =3D "okay" in this
board DTS.

Since the driver will not probe, this breaks standard serial output and
serial debugging.

[ ... ]
> +	tusb320: tusb320@67 {
> +		compatible =3D "ti,tusb320";
> +		reg =3D <0x67>;
> +		interrupts-extended =3D <&tlmm 45 IRQ_TYPE_EDGE_RISING>;

[Severity: Medium]
Does this configure the tusb320 interrupt incorrectly for an active-low
open-drain pin?

Any Type-C event triggers an active-low interrupt from the TUSB320, which
would be missed by this rising-edge configuration. The INT_N line will rema=
in
low indefinitely because the interrupt is never serviced and cleared,
breaking USB Type-C plug/unplug detection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D19
