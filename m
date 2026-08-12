Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04863C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2935F10F04F;
	Wed, 12 Aug 2026 15:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BWu0nTFz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6003510F04F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:11:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 052AA435CF;
 Wed, 12 Aug 2026 15:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F711F000E9;
 Wed, 12 Aug 2026 15:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786547487;
 bh=t+BYApoyaK1YcvJYNOvrfshFcrU8KV8lFaQFTUwYD6A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BWu0nTFzLriBED4FknSmRLTSClLhXlSXYhbEBfBNKFjaUqFqs3r6NcV+Vtt91yK5q
 Sv40AHKfruYzlUv0YshZ7YHUT5eV27hlacHDfce4uZCvv5bpOqHlS68yztmkh+ENOb
 1l4/yQWVXjcCoj54kSzK5ZsjpJxw5ifmeOLRiVEiy0Hdr+ne0UvB3a9NMMjHK073c/
 dI/rgQejHve7B7UPtzDMPvcwbAEIjCwC5UU3185DhmwLqunYeUgWTlf5V+YJTzeECd
 OYyjkhzNpw5KOlzJ+QcsWRBLgd2XSbwkTLQo5G1tHFxNNVnHMEy31EvhoKu4qRuj6B
 X1pA4O7wcoWtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86: apple-gmux: add MacBookPro15,1
 dGPU power sequence
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812144221.35877-2-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812144221.35877-1-dev@deq.rocks>
 <20260812144221.35877-2-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:11:27 +0000
Message-Id: <20260812151127.B0F711F000E9@smtp.kernel.org>
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
- [High] Connecting an external GPU (eGPU) overwrites the internal discrete=
 GPU reference, permanently breaking internal GPU power management.
--

--- Patch [1]: [PATCH v2 1/3] platform/x86: apple-gmux: add MacBookPro15,1 =
dGPU power sequence ---
commit 469501c98c440969c62cc4d684e58812e4f65cfa
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/x86: apple-gmux: add MacBookPro15,1 dGPU power sequence

The discrete GPU on the MacBookPro15,1 does not return after the legacy
GMUX power-on sequence. Evaluate the firmware PWG1 and PWG3 link methods
around the GMUX transition and wait for PCI configuration space before
completing power-on.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index fbc30f1f8abdf..ce926a10131e8 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -549,11 +607,16 @@ static enum vga_switcheroo_client_id gmux_get_clien=
t_id(struct pci_dev *pdev)
>  	 */
>  	if (pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL)
>  		return VGA_SWITCHEROO_IGD;
> -	else if (pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA &&
> -		 pdev->device =3D=3D 0x0863)
> +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA && pdev->device =3D=3D 0x0=
863)
>  		return VGA_SWITCHEROO_IGD;
> -	else
> -		return VGA_SWITCHEROO_DIS;
> +
> +	if (apple_gmux_data->use_pwg_power_sequence &&
> +	    apple_gmux_data->discrete_pdev !=3D pdev) {
> +		pci_dev_put(apple_gmux_data->discrete_pdev);
> +		apple_gmux_data->discrete_pdev =3D pci_dev_get(pdev);
> +	}
> +
> +	return VGA_SWITCHEROO_DIS;
>  }

[Severity: High]
Does connecting an external GPU (eGPU) overwrite the internal discrete GPU
reference here and break internal GPU power management?

When an eGPU is connected via Thunderbolt, its audio controller is probed by
the snd_hda_intel driver. This driver unconditionally calls
vga_switcheroo_register_audio_client(), passing the eGPU as the bound VGA
device.

vga_switcheroo then invokes the gmux_get_client_id() callback with the eGPU=
's
pdev to resolve the audio client's ID. Because the eGPU is not an integrated
GPU, this new check executes and overwrites apple_gmux_data->discrete_pdev
with the eGPU's pci_dev.

If this happens, subsequent power state changes might attempt to evaluate A=
CPI
methods like PWG1 and PWG3 on the eGPU instead of the internal dGPU, which
could leave the internal dGPU in an undefined power state and break hybrid
graphics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812144221.3587=
7-1-dev@deq.rocks?part=3D1
