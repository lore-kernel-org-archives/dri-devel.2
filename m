Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8B1C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D2310E579;
	Mon, 21 Sep 2026 09:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DsuIwllZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FB410E579
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:25:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F76042A77
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6EF1F000FF;
 Mon, 21 Sep 2026 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789982747;
 bh=2Cd10CePkTuSMxI6AYRVgSZdt92AtPEsss1i0CcFz0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DsuIwllZQAkVgYVs+HkJo5LLr0hDRu6xMNzliiK7nv6BpqeHGpwsTOk43fobKCboC
 5GrOLAWlpNzMpgJA8OlIM/gvUIi0yWh4drOExrV1ChIxVgeNg1CuMbcFI5zvJdPk22
 1TvYcM9J9oJyUWlcHYz2R5vUGVd/DYMVEdXW54+d6OJplIYVTX41p4H4CTT8BEnYBb
 hurD8pf2vnGis0/JiSjWBQW1mpHyRLdLA7FRsh9h1OkeBpIcfo9f6prquRULI1FqM6
 rPv8Zp482OWDViQOiksB8AFTpVkit8uOMpeO/5Kk7zhET8lP1c56c2bvlu3T1ee1v3
 /y8cJrCQjwbBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: gemini: Use a level-high interrupt for
 TVE200
To: "Linus Walleij" <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260921-gemini-tve200-fix-v1-2-8be03ac2a8f7@kernel.org>
References: <20260921-gemini-tve200-fix-v1-0-8be03ac2a8f7@kernel.org>
 <20260921-gemini-tve200-fix-v1-2-8be03ac2a8f7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:25:46 +0000
Message-Id: <20260921092546.9F6EF1F000FF@smtp.kernel.org>
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
- [High] drm/tve200: IRQ storm / state machine corruption from level-trigge=
red IRQ
--

commit c7049bfa3bb673960be589c51d1114e71aa6a360
Author: Linus Walleij <linusw@kernel.org>

ARM: dts: gemini: Use a level-high interrupt for TVE200

TVE200's interrupt is configured as rising-edge. On the D-Link DIR-685,
this can stop interrupt delivery after the first vertical interrupt,
causing vblank and page-flip timeouts and delaying framebuffer console
startup. The vertical interrupt can remain pending after acknowledgment. Use
level-high triggering so the pending condition is delivered again without
requiring another edge.

> diff --git a/arch/arm/boot/dts/gemini/gemini.dtsi b/arch/arm/boot/dts/gem=
ini/gemini.dtsi
> index 23e68e17ffbbd..d8f64fea0a79d 100644
> --- a/arch/arm/boot/dts/gemini/gemini.dtsi
> +++ b/arch/arm/boot/dts/gemini/gemini.dtsi
> @@ -445,7 +445,7 @@ dma-controller@67000000 {
>  		display-controller@6a000000 {
>  			compatible =3D "cortina,gemini-tvc", "faraday,tve200";
>  			reg =3D <0x6a000000 0x1000>;
> -			interrupts =3D <13 IRQ_TYPE_EDGE_RISING>;
> +			interrupts =3D <13 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
Does configuring this as a level-high interrupt break the driver's state
machine logic in tve200_irq()?

The driver assumes each interrupt corresponds to an exact hardware event and
blindly toggles the TVE200_CTRL trigger condition between VSYNC and VAI:

drivers/gpu/drm/tve200/tve200_display.c:tve200_irq() {
    ...
		/* We have an actual start of vsync */
		if (!(val & TVE200_VSTSTYPE_BITS)) {
			drm_crtc_handle_vblank(&priv->pipe.crtc);
			/* Toggle trigger to start of active image */
			val |=3D TVE200_VSTSTYPE_VAI;
		} else {
			/* Toggle trigger back to start of vsync */
			val &=3D ~TVE200_VSTSTYPE_BITS;
		}
    ...
}

If the hardware delays deasserting the interrupt line, the level-high
configuration causes the interrupt controller to immediately re-invoke the
handler.

The software state machine then incorrectly interprets this spurious
level-triggered re-fire as the next sequential hardware event, repeatedly
reversing the trigger condition and potentially causing an IRQ storm or
dropped vblank events.

>  			resets =3D <&syscon GEMINI_RESET_TVC>;
>  			clocks =3D <&syscon GEMINI_CLK_GATE_TVC>,
>  				 <&syscon GEMINI_CLK_TVC>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-gemini-tve=
200-fix-v1-0-8be03ac2a8f7@kernel.org?part=3D2
