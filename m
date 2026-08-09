Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AA7C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE061895B9;
	Sun,  9 Aug 2026 13:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c47ZoYqw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1103310E571
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:30:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F9CE600AB;
 Sun,  9 Aug 2026 13:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA231F000E9;
 Sun,  9 Aug 2026 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786282252;
 bh=YOIZYT1JUWE6dmJnBVuVCrZihRjIkZn2PProRU6Gvwg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c47ZoYqwx5Rfc89PGY+LxIUiWlyv6XrR5lwtwp4l713cFGVFLSzzf0eHssMIm1rSn
 bLIgGn/IDqU5xTwSS6YwEyMShO97uhunVr07nKhZNpocuBf2Mczw7vpl74w7tyvYE9
 MsWKaRpNmqjyLW+QWRVaSbAB309zaaFkg0B8ylOs07gv3HpsukP3jBLe0W029cfmu/
 OkxYuw7Ob8LLGSgzWkvsXRyBo8SeAF4anTrpToBATuNrZGHd7Hcf1n8T3R8u4hB/0s
 atlSUvzikW+7SWbg4APV1l9fY20OH0mFbDIsoZu3hBSvwAWnITMh236bxwEXMDYm5C
 cEi/XMcfS40ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/17] riscv: dts: spacemit: k3-pico-itx: enable the
 DisplayPort output
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com
In-Reply-To: <20260809-k3-display-v2-15-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-15-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:30:51 +0000
Message-Id: <20260809133051.EEA231F000E9@smtp.kernel.org>
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
- [Low] Missing `dp-connector` node and `remote-endpoint` link for the exte=
rnal DisplayPort output, leaving the `dp1_out` graph endpoint disconnected.
--

--- Patch [15]: [PATCH v2 15/17] riscv: dts: spacemit: k3-pico-itx: enable =
the DisplayPort output ---
commit 524eda119bdbf5fa2382226e4f89b196aad432d5
Author: Cody Kang <codykang.hk@gmail.com>

riscv: dts: spacemit: k3-pico-itx: enable the DisplayPort output

This commit enables the second DPU and the associated DisplayPort controller
to provide output to the external DisplayPort connector on the Pico-ITX boa=
rd.

> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/bo=
ot/dts/spacemit/k3-pico-itx.dts
> index b89c1521e6649..6c31460990a75 100644
> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts

[ ... ]

> @@ -221,3 +222,13 @@ hub@1 {
>  &usb2_phy {
>  	status =3D "okay";
>  };
> +
> +&dpu1_crtc0 {
> +	status =3D "okay";
> +};
> +
> +&dp1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&dp1_1_cfg>;
> +	status =3D "okay";
> +};

[Severity: Low]
Does this device tree need a dp-connector node and a remote-endpoint link=20
for the external DisplayPort output?

Since dp1 is enabled here without describing the physical downstream connec=
tor=20
or linking it to the output port, it appears to leave the dp1_out graph=20
endpoint disconnected.

Even though the display driver might handle this missing topology gracefull=
y=20
by falling back to an internal connector initialization, could this omissio=
n=20
trigger dtbs_check graph warnings for the dangling endpoint?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D15
