Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A3CC5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 22:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7ABF10E10F;
	Thu, 30 Jul 2026 22:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NgLN2qWh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B5088130
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 22:03:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B828B40E21;
 Thu, 30 Jul 2026 22:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C961F000E9;
 Thu, 30 Jul 2026 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785448987;
 bh=V9xy9+yWjCnqodVuv477m+hNUfablM7pFd8TcrD78v0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NgLN2qWh8C5O7o8bhBTPQG7txGN3paC14aPTT8pRDg7+5YFqCazupxFa2x2sIbt2P
 1So816mkQ+AbOiSB9n33ZYhuf9WdSDkFoVFMqneXFvdrfcph7E32DXTIX5sJSd00uM
 33BgRBHYQxZDqnuq933F1ZLLBYfpWlmCKRaHVOOC+iYX37b59TXWqie7GDmayYh9Hw
 BcHD+Rj0ozJZdyFIG8kMGOhJdSu8kY2RE6HQWi4HcjbYE2JmW9nIoLIlKtdm+h+VcD
 k8akRds2nDMwW99osGBiZVLFAPfLCPm+So7VlVRvq8K0hsvXjk+d9jXAfJgmODsHxX
 YpU9xM3sav1Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250: add device tree for the
 Xiaomi Mi Pad 5 Pro 5G
To: =?utf-8?b?RGF3aWQgV3LDs2JlbA==?= <me@dawidwrobel.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-4-ed6d8fb99668@dawidwrobel.com>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
 <20260730-sm8250-xiaomi-enuma-v1-4-ed6d8fb99668@dawidwrobel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 22:03:06 +0000
Message-Id: <20260730220307.61C961F000E9@smtp.kernel.org>
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
- [Low] The newly added device tree source `sm8250-xiaomi-enuma.dts` fails =
to compile because it references an undefined label `&wifi_0`.
- [Low] The root `compatible` string violates the `qcom.yaml` schema expect=
ations and will fail `make dtbs_check`.
- [Low] The display panel `compatible` string violates the `novatek,nt36523=
.yaml` schema expectations and will fail `make dtbs_check`.
--

--- Patch [4]: [PATCH 4/4] arm64: dts: qcom: sm8250: add device tree for th=
e Xiaomi Mi Pad 5 Pro 5G ---
commit 3ad8e67e479446954f8eea3da616a9b04bf046b8
Author: Dawid Wr=C3=B3bel <me@dawidwrobel.com>

arm64: dts: qcom: sm8250: add device tree for the Xiaomi Mi Pad 5 Pro 5G

This patch adds a new device tree for the Xiaomi Mi Pad 5 Pro 5G (enuma),
which is the modem-equipped variant of the Mi Pad 5 Pro. It describes the
board using the common device tree along with its own board ID, panel
compatible, and WiFi board data variant.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts b/arch/arm6=
4/boot/dts/qcom/sm8250-xiaomi-enuma.dts
> new file mode 100644
> index 0000000000000..7cc9ed7d12b28
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts
> @@ -0,0 +1,26 @@
[ ... ]
> +/ {
> +	model =3D "Xiaomi Mi Pad 5 Pro 5G";
> +	compatible =3D "xiaomi,enuma", "xiaomi,elish", "qcom,sm8250";

[Severity: Low]
Does this root compatible string violate the qcom.yaml schema expectations?
It looks like it contains 3 items instead of the strictly expected 2, and
"xiaomi,enuma" is not documented in the schema, which could cause
make dtbs_check to fail.

> +
> +	/* Platform type differs from elish; msm-id is inherited unchanged. */
> +	qcom,board-id =3D <0x2e 0>;
> +};
> +
> +&display_panel {
> +	compatible =3D "xiaomi,enuma-csot-nt36523", "xiaomi,elish-csot-nt36523",
> +		     "novatek,nt36523";

[Severity: Low]
Does this display panel compatible string violate the novatek,nt36523.yaml
schema expectations? It appears to contain 3 items instead of 2, and
"xiaomi,enuma-csot-nt36523" is not listed in the schema, which could cause
a make dtbs_check failure.

> +	status =3D "okay";
> +};
> +
> +&wifi_0 {

[Severity: Low]
Is wifi_0 defined in any of the included files? It looks like this block
references an undefined label &wifi_0, which triggers a fatal dtc compile
error during make dtbs.

> +	qcom,calibration-variant =3D "Xiaomi_Pad_5Pro_5G";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-sm8250-xia=
omi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com?part=3D4
