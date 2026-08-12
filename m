Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E86C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFD910E17C;
	Wed, 12 Aug 2026 15:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mjNBVHUN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C01F10E17C
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:07:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8222260AA9;
 Wed, 12 Aug 2026 15:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA751F00A3A;
 Wed, 12 Aug 2026 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786547248;
 bh=f6zWn3tNj2t7breiwR6oQDbNwhHW7lfGdJjhbzKf5Q8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mjNBVHUNAb7ovYmniP1T7OvSeSrU+gmhwi4Td5E/jWVnS77WaLLL/aH/aMlnY9W77
 1sNwobbWJxZ7BlyfMhxSehyDPbflYFIGjtACBNd+jIjYkDOf0RAliEgdJVoHN7h4Ig
 KyzAeg089h5o/P/Yv6n9pos67nFzkI9Il2FZ9xYPSJ++ax9I9ZmwRXyQaLafHr3O90
 4SBBW+6PJ6EbUAE+1WMempUaHCSicdFKXea7n/JuA3GK0lVlurwEVUIJ2YI7ArarXY
 cPy1A4CzJhtTv5Mry13zr0e35U1/l2aZwrKvN7uRN2aH7N5miK0SRNNs8JR6TM6bL3
 W9eC9dQUns46w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] platform/x86: apple-gmux: add MacBookPro15,1
 dGPU power sequence
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812144750.36797-2-dev@deq.rocks>
References: <20260812144221.35877-1-dev@deq.rocks>
 <20260812144750.36797-1-dev@deq.rocks>
 <20260812144750.36797-2-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:07:27 +0000
Message-Id: <20260812150728.1BA751F00A3A@smtp.kernel.org>
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
- [High] The discrete GPU's PCI device pointer (`discrete_pdev`) fails to i=
nitialize if the `apple-gmux` module is reloaded, breaking the discrete GPU=
 power-on sequence on MacBookPro15,1.
--

--- Patch [1]: [PATCH v3 1/3] platform/x86: apple-gmux: add MacBookPro15,1 =
dGPU power sequence ---
commit 82f7efe17d405f437532909cef38c118380b2e3f
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Subject: platform/x86: apple-gmux: add MacBookPro15,1 dGPU power sequence

This commit adds a specific power-on sequence using PWG1 and PWG3 ACPI
methods for the discrete GPU on MacBookPro15,1. It evaluates these link
methods around the GMUX transition and waits for PCI configuration space
before completing power-on.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index fbc30f1f8abdf..2b6363aab8d15 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -510,14 +541,49 @@ static int gmux_switch_ddc(enum vga_switcheroo_clie=
nt_id id)
>  static int gmux_set_discrete_state(struct apple_gmux_data *gmux_data,
>  				   enum vga_switcheroo_state state)
>  {
> +	int ret;
> +
>  	reinit_completion(&gmux_data->powerchange_done);
> =20
>  	if (state =3D=3D VGA_SWITCHEROO_ON) {
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
> +		if (gmux_data->use_pwg_power_sequence &&
> +		    gmux_data->discrete_pdev) {

[Severity: High]
If discrete_pdev fails to initialize during module reload, won't this check
silently fall back to the legacy power sequence?

If the legacy sequence is used on this model, could the discrete GPU fail to
power on properly, causing subsequent PCI accesses to read 0xFFFFFFFF and
potentially crash the system?

[ ... ]

> @@ -549,11 +615,16 @@ static enum vga_switcheroo_client_id gmux_get_clien=
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
If the apple-gmux module is unloaded and reloaded, will this initialization
actually happen?

Looking at vga_switcheroo_enable() in the vgasr core, it intentionally skips
get_client_id() for clients that already have a known ID:

vga_switcheroo.c:vga_switcheroo_enable() {
    ...
    if (!client_is_vga(client) ||
         client_id(client) !=3D VGA_SWITCHEROO_UNKNOWN_ID)
        continue;

    ret =3D vgasr_priv.handler->get_client_id(client->pdev);
    ...
}

Since clients retain their IDs from the first load, won't get_client_id() be
skipped entirely on module reload, leaving discrete_pdev as NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812144750.3679=
7-1-dev@deq.rocks?part=3D1
