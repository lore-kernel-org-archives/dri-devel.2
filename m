Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96854C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F1710E401;
	Wed, 12 Aug 2026 12:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QrNygAZy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0488510E401
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:39:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF63B40254;
 Wed, 12 Aug 2026 12:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EC81F00A3A;
 Wed, 12 Aug 2026 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786538340;
 bh=Mj3CRUWadVVer9+iThW5QZMn2o4xXSwt8auYSCRJSIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QrNygAZyWjTLMW2AT/oYqDPSIM90QxjLpMtf/UvsVYqNLm7XJuN4nu6NMcAraTpEt
 lf1tQpaIJV2y4ojwT5yfmrks02sBqme3s9ABAZNGGihubsteSEzl1M5WnikICGpsz2
 pBPruTpzYhqPK3+w20yVGlrXZQnSyRNFWMg8KAiSsDIP3O6yfh6dUoc39thtmKSUGl
 ncUNhBhxRke9gGCqK3sk/qijGThb0ucHf9nguPjlsGxig8i06IgaYwknQBMBy4GGah
 WcweybvO/eSPaeaknuYP4TCYLBwRxifV3M1Uh258LMQ1EMh71qyrdo1W3In/39+zbr
 11q0NONaZJnmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] platform/x86: apple-gmux: add MacBookPro15, 1 dGPU
 power sequence
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812122206.193680-2-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812122206.193680-2-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:38:59 +0000
Message-Id: <20260812123900.67EC81F00A3A@smtp.kernel.org>
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
- [Medium] The `discrete_pdev` pointer caches the discrete GPU `pci_dev` bu=
t is not updated when the client is unregistered and a new device is regist=
ered, preventing power switching from functioning if the PCI device is resc=
anned.
--

--- Patch [1]: [PATCH 1/3] platform/x86: apple-gmux: add MacBookPro15,1 dGP=
U power sequence ---
commit 35744aea76b96c0341cb3a18f76cff6290e2d999
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/x86: apple-gmux: add MacBookPro15,1 dGPU power sequence

This commit introduces a dGPU power sequence for MacBookPro15,1 devices.
It introduces ACPI method evaluation during gmux transitions and verifies
PCI configuration space accessibility before completing power-on.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index fbc30f1f8abdf..1771c6bb756ef 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -549,11 +615,14 @@ static enum vga_switcheroo_client_id gmux_get_clien=
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
> +	    !apple_gmux_data->discrete_pdev)
> +		apple_gmux_data->discrete_pdev =3D pci_dev_get(pdev);

[Severity: Medium]
Does this caching mechanism properly handle the PCI device being removed and
rescanned?

If an administrator logically removes the discrete GPU via sysfs (for examp=
le,
echo 1 > /sys/bus/pci/devices/.../remove) and rescans the PCI bus, the GPU
driver will re-register with vga_switcheroo.

Because of the !apple_gmux_data->discrete_pdev check, discrete_pdev won't be
updated when the new device is registered. The power switching could break
permanently by returning -ETIMEDOUT, because it will attempt to read the
configuration space on the stale, disconnected pci_dev.

Should there be a way to clear or update the cached discrete_pdev when a
client is unregistered?

> +
> +	return VGA_SWITCHEROO_DIS;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812122206.1936=
80-1-dev@deq.rocks?part=3D1
