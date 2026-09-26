Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4513CC98318
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 10:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A783F10E0B7;
	Sat, 26 Sep 2026 10:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J3oIPEG2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3EB10E0B7
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:31:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28EA66020C;
 Sat, 26 Sep 2026 10:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A14E1F000FF;
 Sat, 26 Sep 2026 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790418682;
 bh=LLef3BXvnTIHTJWFVKMlQ6gJmE84fRwYU3GoxcATQTs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J3oIPEG2NAuog3wqosi8YS1dOdZ4nROegEVJ6YXcal4nVnj3wMgnn+oFG0Obi1Yx+
 hmN4/cH54YpGc6GIWPkvlnXewVwgB9oKCbt6qFJ1OF4+hPX/SGhScxiAw8qUDLMshk
 WfVCDwRzfiyjbssGl+uGojDdXSYt7p6ORIY7LXFiBoywxd3679nWgMNuMq7ePGaGHG
 aCnhOBvW2vpJft1kFIx8dVWpglrvsn3uCMWHYaPYdbGyUuDzvtMiDu2/7WIhJjbcP4
 pzAzbNylQuTHWsO9k0tRsCrS7vvGUjMZf90hVP5C4d0wwX2vAZ6s/mPR+1LFI3C2NP
 ITq8BWFaQURIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP &
 MPSS
To: erebion <erebion@erebion.eu>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260926-pdx213-upstream-3-v1-3-1609c18b5c1d@erebion.eu>
References: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
 <20260926-pdx213-upstream-3-v1-3-1609c18b5c1d@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 10:31:22 +0000
Message-Id: <20260926103122.8A14E1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] arm64: dts: qcom: sm6350: mpss reg size artificially truncated
--

commit 33df29a70738e5d1e7f7a275ffc6f578951ece81
Author: erebion <erebion@erebion.eu>

arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP & MPSS

This commit enables the ADSP, CDSP, and MPSS (Modem) nodes for the Xperia 10
III. It configures the respective firmware names and updates the status of
these nodes to okay.

> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts =
b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts

[ ... ]

> @@ -321,6 +333,13 @@ touchscreen@48 {
>  	};
>  };
> =20
> +&mpss {
> +	firmware-name =3D "qcom/sm6350/sony/pdx213/modem.mbn";
> +	reg =3D <0x0 0x04080000 0x0 0x100>;

[Severity: Low]
Is this reg property artificially truncating the mpss node's MMIO region?

The reg size here is 0x100 (256 bytes), whereas the standard on-SoC mpss
node usually has a size of 0x10000 (64KB). Since the device tree describes
hardware that does not shrink across boards, could truncating this size
cause an out-of-bounds access or page fault if a future or downstream driver
attempts to ioremap and read beyond the first 256 bytes?

> +
> +	status =3D "okay";
> +};
> +
>  &pm6150l_flash {
>  	status =3D "okay";
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-pdx213-ups=
tream-3-v1-0-1609c18b5c1d@erebion.eu?part=3D3
