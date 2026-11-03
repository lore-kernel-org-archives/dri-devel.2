Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4251606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjeXB49v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029AB10E533;
	Tue,  3 Nov 2026 16:28:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E207B10F70F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:28:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12D4760416;
 Tue,  3 Nov 2026 16:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B553A1F0093A;
 Tue,  3 Nov 2026 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793723327;
 bh=FFcyEUjF3pXHEmthb/hfCNLR/jdGo6Z5SDQNn4ZRPmw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RjeXB49vvThbSMnBNn3aXtAG8NNi51Lq9HJIM0/XEecm0aU0VmubdU3xkpA7ekTsJ
 Qnt2KojifvtbEXN9NTSre55CJKRIQ8I8xy7WLbao4z8lO4ldkO03jDxvtRgZ0/vZwk
 y399a9XTXs9Jml0xdWex3OBIZz94WwyedAfIEx5KKv1mYg2YP0qmIAJL8ulT4YWGFH
 QDQS6Ov0smUYb4BoVFEIMRaE6OoXclBf0ZSkhOIE7imUlTQS1XRIdhi2zKFObnlwmy
 KqAMjbFfqaMOkpmc//wxWSDTLfraXnhDaQmDtPvNM3dKjD/X01L30BoCfjMYjxyCw4
 4jhnR3DC1T51w==
Message-ID: <sashiko-outbox-195725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] drm/amdgpu: add the OMNI13B1 (OV13B10) ISP sensor
To: "Seifelden Abdelmonem" <saif.elden.hatim@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261103155313.114347-4-saif.elden.hatim@gmail.com>
References: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
 <20261103155313.114347-4-saif.elden.hatim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:28:46 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/amdgpu: missing gpiod_remove_lookup_table() in isp_v4_1_1_hw_i=
nit()/fini()
--

commit a5133602b5141a1308e409981d3e875c2a078846
Author: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>

drm/amdgpu: add the OMNI13B1 (OV13B10) ISP sensor

This patch adds the OMNI13B1 ACPI ID to isp_sensor_ids so amdgpu detects
the OmniVision OV13B10 camera sensor on ISP 4.1.1 platforms. It also
defines and registers the GPIO lookup tables required by the ISP capture
and ov13b10 sensor drivers during ISP 4.1.1 hardware initialization.

> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/am=
d/amdgpu/isp_v4_1_1.c
> index 363266f3e0a3e..7d6072e279468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -65,6 +65,14 @@ static struct gpiod_lookup_table isp_sensor_gpio_table=
 =3D {
>  	},
>  };
> =20
> +static struct gpiod_lookup_table isp_ov13b10_gpio_table =3D {
> +	.dev_id =3D "i2c-ov13b10",
> +	.table =3D {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "reset", GPIO_ACTIVE_LOW),
> +		{ }
> +	},
> +};
> +
>  static int isp_poweroff(struct generic_pm_domain *genpd)
>  {
>  	struct amdgpu_isp *isp =3D container_of(genpd, struct amdgpu_isp, ispgp=
d);
> @@ -240,10 +248,13 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *is=
p)
>  		return 0;
>  	}
> =20
> -	/* add GPIO resources required for OMNI5C10 sensor */
> +	/* add GPIO resources required for the sensor */
>  	if (!strcmp("OMNI5C10", acpi_device_hid(acpi_dev))) {
>  		gpiod_add_lookup_table(&isp_gpio_table);
>  		gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +	} else if (!strcmp("OMNI13B1", acpi_device_hid(acpi_dev))) {
> +		gpiod_add_lookup_table(&isp_gpio_table);
> +		gpiod_add_lookup_table(&isp_ov13b10_gpio_table);
>  	}

[Severity: High]
When isp_v4_1_1_hw_init() matches OMNI13B1 (or OMNI5C10), it links the stat=
ic
isp_gpio_table and isp_ov13b10_gpio_table structures into the global
gpio_lookup_list via gpiod_add_lookup_table().

However, neither the error paths in isp_v4_1_1_hw_init() (if pm_genpd_init(=
),
memory allocations, or mfd_add_hotplug_devices() fail) nor
isp_v4_1_1_hw_fini() removes these tables:

drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c:isp_v4_1_1_hw_fini() {
	device_for_each_child(isp->parent, NULL,
			      isp_genpd_remove_device);

	mfd_remove_devices(isp->parent);

	kfree(isp->isp_res);
	kfree(isp->isp_cell);
	kfree(isp->isp_pdata);
	kfree(isp->isp_i2c_res);
	kfree(isp->isp_gpio_res);

	return 0;
}

If the PCI device is unbound and rebound, or if isp_v4_1_1_hw_init() is
retried after a failure, won't calling gpiod_add_lookup_table() again on the
already-linked static list_head nodes corrupt gpio_lookup_list? Furthermore,
if amdgpu is built as a module and unloaded, won't leaving isp_gpio_table a=
nd
isp_ov13b10_gpio_table linked in gpio_lookup_list cause a use-after-free in
gpiolib when subsequent GPIO lookups traverse the freed module memory?

Should isp_v4_1_1_hw_init() on failure and isp_v4_1_1_hw_fini() on teardown
call gpiod_remove_lookup_table() to unregister the lookup tables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155313.1143=
47-1-saif.elden.hatim@gmail.com?part=3D3
