Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7250BCD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 781F410E5AB;
	Thu,  4 Jun 2026 08:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SQHjIXSc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0AA10E5AB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 08:22:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC4104386E;
 Thu,  4 Jun 2026 08:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787D21F00893;
 Thu,  4 Jun 2026 08:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780561346;
 bh=qLESv79Gs9i/g3fBG1Ar34reaAJiM2FZ8YIohVIqRUw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SQHjIXScgJXDMfdK5itfyUkXp+9Cw8vo5GPX2aWf9CosmbKN9v8hZrfbSCVzBsRK9
 LMt1VQn6YCO/Itla9b+u01m5hewVzPAAggChb6Ug1pC3PB83HURSnIjxgYmJXHqCpD
 ARQSmjqmJlG5ZE231wrX0NqDa1Uuae6/xhRxo86cCyoXmaa/otBBd/2hfoiG+Q6iFS
 3QZpRvbiPfTfvpbup1rInNJM4x2bWIMpX6M9SVymg1q98rQf5H2x/TT/NM8CeooCPR
 6w3AkhqRSesYg/kpSlmZI1zJ9lwMu6pA6XRgmOel17q5rzQ/6KKI1zpBryNc1lzG8y
 tYRsN8G8T+Lcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add Glymur-based Lenovo Yoga Slim
 7x Gen11
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-topic-yoga_submission-v1-3-57c70c23d0d6@oss.qualcomm.com>
References: <20260604-topic-yoga_submission-v1-3-57c70c23d0d6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 08:22:25 +0000
Message-Id: <20260604082226.787D21F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing `vdd-micb-supply` in `lpass_vamacro` node breaks DMIC capt=
ure.
- [Low] Missing `key-volume-up` subnode in `gpio-keys` despite claiming its=
 pinctrl.
- [Low] The `nvme_sec_reg_en` pinctrl node is defined but never referenced.
--

commit cf25549a8fd93e158d3d638230deeb2a24306da5
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

arm64: dts: qcom: Add Glymur-based Lenovo Yoga Slim 7x Gen11

This commit introduces the device tree for the Lenovo Yoga Slim 7x Gen11
laptop. It defines nodes and configurations for several supported hardware
features such as audio, GPU, keyboard, and networking.

> diff --git a/arch/arm64/boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts b/arc=
h/arm64/boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts
> new file mode 100644
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts
[ ... ]
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		pinctrl-0 =3D <&key_vol_up_default>, <&hall_int_n_default>;
> +		pinctrl-names =3D "default";
> +
> +		switch-lid {
> +			label =3D "lid";
> +			gpios =3D <&tlmm 92 GPIO_ACTIVE_LOW>;
> +			linux,input-type =3D <EV_SW>;
> +			linux,code =3D <SW_LID>;
> +			wakeup-source;
> +			wakeup-event-action =3D <EV_ACT_DEASSERTED>;
> +		};
> +	};

[Severity: Low]
Does this code miss a subnode for the volume up key?

The pinctrl state for key_vol_up_default is claimed by the gpio-keys node
here, but without a corresponding child node, the input subsystem will not
register the volume up button.

[ ... ]
> +&lpass_vamacro {
> +	pinctrl-0 =3D <&dmic01_default>, <&dmic23_default>;
> +	pinctrl-names =3D "default";
> +	qcom,dmic-sample-rate =3D <4800000>;
> +};

[Severity: High]
Should this node include a vdd-micb-supply property pointing to vreg_l1b_e0?

The audio routing connects the digital microphones to the vdd-micb DAPM
widget. Without a vdd-micb-supply property here, the lpass-va-macro driver
falls back to a dummy regulator.

Since the physical supply (vreg_l1b_e0) has no consumers and lacks a boot-on
or always-on property, the kernel regulator core will disable it. Will this
leave the microphones without bias power and result in silent audio capture?

[ ... ]
> +&pmh0110_f_e1_gpios {
> +	nvme_sec_reg_en: nvme-reg-en-state {
> +		pins =3D "gpio14";
> +		function =3D "normal";
> +		bias-disable;
> +	};
> +};

[Severity: Low]
Is this pinctrl state needed?

It is defined here but does not appear to be referenced by any device node's
pinctrl properties. Could this be leftover dead code from a reference desig=
n?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-topic-yoga=
_submission-v1-0-57c70c23d0d6@oss.qualcomm.com?part=3D3
