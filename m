Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B0606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gup/VRh2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5534710E1CA;
	Sat, 14 Nov 2026 16:29:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CAF10F048;
 Sat, 14 Nov 2026 16:25:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0496440A6;
 Sat, 14 Nov 2026 16:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464151F000C5;
 Sat, 14 Nov 2026 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794673525;
 bh=R3XPIyYXAb6KQStsWHNbBRDUXG8RLg5+C3CYbZ/olow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gup/VRh2GbJDwnbQneoJj8gB6Gqxtqh64fsnS/rl0WistQ+NPgppFu5ahhkWx6RRD
 07ZQGUNXJLHYsRJLdcEQhgMqqa6PFhN8SRTOoIpI2zRzg527VvSrH3TPHZULdCrHXr
 vXSbQb56ggJ5E/x8emSfnQIl/6AHIhm39bG7y6MuGIr65BXLSDbkwlzA9y7gTQlrQV
 /Nb0LSrq2mFqwSR2824EW+FJDkKjSW45avNdK2r6zDcjLdUgOSR/WbOdiuW3piCaaz
 jmp+rhp3RZjjc3Dtt5UGLCsSlHBoc53PKMuHw41v4Rbivrz5cfdCgLX4/syEbZoAa7
 YXRcVZTv0S43w==
Message-ID: <sashiko-outbox-214747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] platform/apple-gmux: Write switch state to EFI
 on MMIO devices
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?=
 <amd-gfx@lists.freedesktop.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-6-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-6-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:25:24 +0000
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] platform/x86: apple-gmux: premature teardown in gmux_shutdown()
- [Medium] platform/x86: apple-gmux: unconditional EFI write in
  gmux_shutdown()
- [Medium] platform/x86: apple-gmux: redundant NVRAM writes in
  gmux_switchto()
- [Low] platform/x86: apple-gmux: malformed Co-developed trailer in
  commit
--

commit d3f4b4e97cdb8c1cdd8c1017127d8aa165b31134
Author: Andre Eikmeyer <dev@deq.rocks>

> platform/apple-gmux: Write switch state to EFI on MMIO devices
>
> On T2 devices (MMIO), the T2 coprocessor reads gpu-active efi
> variable, and macOS seems to write it, so to properly communciate
> to the T2 coprocessor, we write gpu-active.
>
> Tested-by: Sebastian Zygadlo <szgit@icloud.com>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Co-developed: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

[Severity: Low]
This isn't a bug, but the Co-developed: trailer should be
Co-developed-by:.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 37ba207793a2e..c4a953b5b3e2d 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -489,6 +490,32 @@ static void gmux_write_switch_state(struct apple_gmu=
x_data *gmux_data)
>  		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
>  }
> =20
> +#define APPLE_GPU_VARS_GUID EFI_GUID(0xfa4ce28d, 0xb62f, 0x4c99, \
> +				     0x9c, 0xc3, 0x68, 0x15, 0x68, 0x6e, 0x30, 0xf9)
> +
> +static efi_char16_t gmux_gpu_active_name[] =3D L"gpu-active";
> +
> +static void gmux_write_switch_state_efi(struct apple_gmux_data *gmux_dat=
a)
> +{
> +	efi_guid_t guid =3D APPLE_GPU_VARS_GUID;
> +	u32 active =3D gmux_data->switch_state_display =3D=3D VGA_SWITCHEROO_IG=
D;
> +	efi_status_t status;
> +
> +	if (!efivar_is_available() ||
> +			!efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
> +		return;
> +
> +	status =3D efivar_set_variable(gmux_gpu_active_name, &guid,
> +				     EFI_VARIABLE_NON_VOLATILE |
> +				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +				     EFI_VARIABLE_RUNTIME_ACCESS,
> +				     sizeof(active), &active);
> +	if (status !=3D EFI_SUCCESS)
> +		pr_warn("writing gpu-active failed: 0x%lx\n", status);
> +	else
> +		pr_debug("gpu-active: %u\n", active);
> +}
> +
>  static int gmux_switchto(enum vga_switcheroo_client_id id)
>  {
>  	apple_gmux_data->switch_state_ddc =3D id;
> @@ -497,6 +524,8 @@ static int gmux_switchto(enum vga_switcheroo_client_i=
d id)
>  		apple_gmux_data->switch_state_external =3D id;
> =20
>  	gmux_write_switch_state(apple_gmux_data);
> +	if (apple_gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +		gmux_write_switch_state_efi(apple_gmux_data);
> =20
>  	return 0;
>  }

[Severity: Medium]
Does gmux_switchto() write the non-volatile gpu-active EFI variable to
NVRAM even when switch_state_display has not changed?

Whenever the discrete GPU runtime-suspends,
vga_switcheroo_runtime_suspend() calls
vgasr_priv.handler->switchto(VGA_SWITCHEROO_IGD) regardless of the
current display mux state.  Calling efivar_set_variable() with
EFI_VARIABLE_NON_VOLATILE when switch_state_display is already id causes
redundant NVRAM flash wear and extra runtime suspend latency on every
discrete GPU wake/suspend cycle.

> @@ -1240,6 +1269,15 @@ static void gmux_remove(struct pnp_dev *pnp)
>  	kfree(gmux_data);
>  }
> =20
> +static void gmux_shutdown(struct pnp_dev *pnp)
> +{
> +	struct apple_gmux_data *gmux_data =3D pnp_get_drvdata(pnp);
> +
> +	gmux_write_switch_state_efi(gmux_data);

[Severity: Medium]
Should gmux_shutdown() check gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO
before calling gmux_write_switch_state_efi(gmux_data), matching
gmux_switchto()?  Without that check, every shutdown or reboot on
non-MMIO (PIO and indexed) gmux systems writes the T2-specific
gpu-active variable to NVRAM.

> +
> +	gmux_remove(pnp);
> +}

[Severity: High]
Can calling gmux_remove(pnp) from gmux_shutdown() cause a NULL pointer
dereference when pci_device_shutdown() runs for the discrete GPU?

PCI devices are registered in subsys_initcall(acpi_init), before PNPACPI
devices are registered in fs_initcall(pnpacpi_init).  During shutdown,
device_shutdown() walks devices_kset in reverse registration order, so
pnp_device_shutdown() -> gmux_shutdown() -> gmux_remove() runs before
pci_device_shutdown() on the discrete GPU.

gmux_remove() calls vga_switcheroo_unregister_handler(), which clears
vgasr_priv.handler to NULL, and frees gmux_data.  When
pci_device_shutdown() then calls pm_runtime_resume() on a
runtime-suspended discrete GPU, vga_switcheroo_runtime_resume() ->
vga_switcheroo_power_switch() dereferences vgasr_priv.handler:

drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_power_switch() {
	...
	if (!vgasr_priv.handler->power_state)
		return;
	...
}

In addition, pnp_device_shutdown() does not unbind the driver, so
freeing gmux_data here leaves a dangling drvdata pointer in pnp->data
that will be used and freed again if pnp_device_remove() is called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D5
