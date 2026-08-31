Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940EBC624CF
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB18E10E31E;
	Mon, 31 Aug 2026 17:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MOZYmt12";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7136610E31E
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:14:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 410ED40A76
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030701F000E9;
 Mon, 31 Aug 2026 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788196486;
 bh=6mb2JLvoKARx25MU9XBg/DIH6cnzAwsWsk4I1TsXUi0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MOZYmt128h2yBPC/+HatiEWRCc60N7cbFhlUHoErSjjHMwmQaQUoJmeBHVyH1VCPB
 F05E9yTcVGcylwkSAObbIf3jDp90U2FxGTTVMIllv7YW/VZ5wGJwdnAUTEnGQ+MB6W
 KtZU1eE8I0C4cYRRI7yT4vNN97s6qcTJ9vJeuymce3pgtI1ffAn/fXJqOHN8FDIONW
 0QlHmXYhfi6QEETAidsA+Yfmv17imeIOm7XrHZRAupN1RnemAnyzLszc+AWmlDC/FR
 hAZpZI39Qdl52a3YYCmsV+Y4qhdaxuGwrh6Ca88CSYxTpPC/UZ+q0KVgl3uOaHbbcd
 god3+cxfdSMhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amdgpu: Bound GPIO I2C table entry
 count from VBIOS
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-569-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-569-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:14:45 +0000
Message-Id: <20260831171446.030701F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Out-of-bounds read in VBIOS parsing due to missing bounds checks o=
n `data_offset` against `bios_size`.
- [High] Memory and resource leak of `struct amdgpu_i2c_chan` objects and I=
2C adapters during driver teardown.
- [High] Unchecked VBIOS size subtraction causes unsigned underflow and unc=
onstrained loops in other ATOM parser functions.
--

commit 07534aa5f05a4ba05838a80933016849ebced1e1
Author: Candice Li <candice.li@amd.com>

drm/amdgpu: Bound GPIO I2C table entry count from VBIOS
   =20
This commit caps the parsed GPIO I2C table entry count to AMDGPU_MAX_I2C_BUS
to prevent array overruns and unbounded iteration on corrupt VBIOS metadata.

[ Upstream commit a99cd231cd924b7160fecb9fb3a94b801522323b ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index 763f2b8dcf13a..b8f7e3a18d324 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
[ ... ]
> @@ -127,8 +141,7 @@ void amdgpu_atombios_i2c_init(struct amdgpu_device *a=
dev)
>  	if (amdgpu_atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_=
offset)) {
>  		i2c_info =3D (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);

[Severity: High]
This isn't a bug introduced by this patch, but does this code potentially
dereference an out-of-bounds pointer if the parsed data_offset exceeds the
size of the VBIOS allocation?

If the VBIOS data is malformed and data_offset is larger than the actual
allocation, ctx->bios + data_offset could result in an out-of-bounds read
when i2c_info is dereferenced.

The unvalidated data_offset originates from:

drivers/gpu/drm/amd/amdgpu/atom.c:amdgpu_atom_parse_data_header() {
	...
	int offset =3D index * 2 + 4;
	int idx =3D CU16(ctx->data_table + offset);
	...
	*data_start =3D idx;
	return true;
}

> -		num_indices =3D (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
> -			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
> +		num_indices =3D amdgpu_atombios_gpio_i2c_num_entries(size);

[ ... ]

I also noticed a pre-existing resource management issue during driver teard=
own:

drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c:amdgpu_i2c_create() {
	...
	i2c =3D kzalloc(sizeof(struct amdgpu_i2c_chan), GFP_KERNEL);
	if (i2c =3D=3D NULL)
		return NULL;
	...
	ret =3D i2c_bit_add_bus(&i2c->adapter);
	...
}

drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c:amdgpu_i2c_fini() {
	int i;

	for (i =3D 0; i < AMDGPU_MAX_I2C_BUS; i++)
		if (adev->i2c_bus[i])
			adev->i2c_bus[i] =3D NULL;
}

[Severity: High]
This is a pre-existing issue, but does this code leak the struct
amdgpu_i2c_chan object and the bit-banging I2C adapter registration?

When amdgpu_i2c_fini() cleans up the I2C buses, it sets adev->i2c_bus[i] to
NULL but does not appear to call kfree() on the struct amdgpu_i2c_chan, nor
does it call i2c_del_adapter() for the adapters registered with
i2c_bit_add_bus(), which aren't managed by devres.

Could this leave dangling I2C adapters and permanently leak the kzalloc'd
memory?


Another pre-existing issue in the same file involves a similar underflow:

drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:amdgpu_atombios_lookup_gpio() {
	...
	if (amdgpu_atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_off=
set)) {
		gpio_info =3D (struct _ATOM_GPIO_PIN_LUT *)(ctx->bios + data_offset);

		num_indices =3D (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
			sizeof(ATOM_GPIO_PIN_ASSIGNMENT);
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code overflow
num_indices if size is less than 4 bytes?

Since size is a u16 and sizeof(ATOM_COMMON_TABLE_HEADER) is 4, a size small=
er
than 4 will cause the subtraction to underflow in an unsigned context.

Could this result in a massive num_indices value, causing the subsequent lo=
op
to read far beyond the bounds of the VBIOS allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-569-sashal@kernel.org?part=3D1
