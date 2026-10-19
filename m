Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179E607BF35
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q49t1DnA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BF710EE40;
	Mon, 19 Oct 2026 15:31:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D9B10EE40
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:31:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EDD1447EA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F3E1F0180C;
 Mon, 19 Oct 2026 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423861;
 bh=HRbMdPJln7BkkzvAOaZzDxEAXh+CfYVq7SUvxKkhgH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q49t1DnAvsxjT3jA1DAK1dCuz62OAfy66UMbC2oGzjYTwrHTqusQ+8HxvXz3bWsA1
 BM4I9cRqmU15GODWyL0m9oPF7w9JtNcNuK13pmndmikGkYOmf1diisfghzOXS14HJk
 yoT0/p+nbPBh5zrhSg+J4bVRsGPaRTZ86ikgklV9GoEKJpCu9ofqaf+3xi/au048e9
 PGS1d7w/+DE8+G7duKW7XM5yZrwTzjZW0iuMb673T3LfDJOdsks/JtZ9egJpo4TlMc
 87p49ZRqvain/XHpzVR98KxFweB7jQJ6b879oa8irHVJzHH5GG/jM+PRTR+7Z7zPaD
 VbwDSE1AqvgVA==
Message-ID: <sashiko-outbox-177744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/amd/pm: Validate pp_table header
 before reading size
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-449-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-449-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:31:00 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/amd/pm: incomplete pptable size validation in smu_sys_set_pp_t=
able()
- [High] drm/amd/pm: slab out-of-bounds read in smu_sys_get_pp_table() afte=
r short upload
- [High] drm/amd/pm: use-after-free in amdgpu_get_pp_table() on concurrent =
write
--

commit a5e9db819c7d60216c2e0063bdbfde9a7dd36030
Author: Yang Wang <kevinyang.wang@amd.com>

drm/amd/pm: Validate pp_table header before reading size

This commit adds a header size check in smu_sys_set_pp_table() before
dereferencing ATOM_COMMON_TABLE_HEADER, and replaces the conditional buffer
reallocation with kmemdup().

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 244b8c364d45f..329a669a60ddc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -636,25 +636,28 @@ static int smu_sys_set_pp_table(void *handle,
>  {
>  	struct smu_context *smu =3D handle;
>  	struct smu_table_context *smu_table =3D &smu->smu_table;
> -	ATOM_COMMON_TABLE_HEADER *header =3D (ATOM_COMMON_TABLE_HEADER *)buf;
> +	ATOM_COMMON_TABLE_HEADER *header;
> +	void *hardcode_pptable;
>  	int ret =3D 0;
> =20
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
> =20
> +	if (!buf || size < sizeof(*header))
> +		return -EINVAL;
> +
> +	header =3D (ATOM_COMMON_TABLE_HEADER *)buf;
>  	if (header->usStructureSize !=3D size) {
>  		dev_err(smu->adev->dev, "pp table size not matched !\n");
>  		return -EIO;
>  	}

[Severity: High]
Is checking size < sizeof(*header) sufficient to prevent out-of-bounds reads
when parsing the uploaded powerplay table?

Since header points directly to the user-supplied buf, header->usStructureS=
ize
is also controlled by the writer. If a 4-byte buffer with
header->usStructureSize =3D=3D 4 is written to pp_table, smu_sys_set_pp_tab=
le()
allocates a 4-byte buffer via kmemdup(), installs it into
smu_table->power_play_table, and calls smu_reset().

During smu_reset() -> smu_hw_init() -> smu_smc_hw_setup() ->
smu_setup_pptable(), smu_v11_0_setup_pptable() in
drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c preserves the existing
smu_table.power_play_table pointer without verifying its size:

	if (!smu->smu_table.power_play_table)
		smu->smu_table.power_play_table =3D table;
	if (!smu->smu_table.power_play_table_size)
		smu->smu_table.power_play_table_size =3D size;

Subsequent ASIC callbacks such as navi10_store_powerplay_table() and
navi10_check_powerplay_table() in
drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c then cast
table_context->power_play_table to struct smu_11_0_powerplay_table * and re=
ad
past the 4-byte allocation:

	memcpy(table_context->driver_pptable, &powerplay_table->smc_pptable,
	       sizeof(PPTable_t));

and:

	table_context->thermal_controller_type =3D
		powerplay_table->thermal_controller_type;
	...
	smu->od_settings =3D &powerplay_table->overdrive_table;

Previously, if smu_table->hardcode_pptable was already allocated at the full
table size, a short write would not shrink the buffer because reallocation
only occurred when smu_table->power_play_table_size < size. With unconditio=
nal
kmemdup(), a 4-byte write shrinks smu_table->hardcode_pptable to 4 bytes.

> =20
> -	if (!smu_table->hardcode_pptable || smu_table->power_play_table_size < =
size) {
> -		kfree(smu_table->hardcode_pptable);
> -		smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
> -		if (!smu_table->hardcode_pptable)
> -			return -ENOMEM;
> -	}
> +	hardcode_pptable =3D kmemdup(buf, size, GFP_KERNEL);
> +	if (!hardcode_pptable)
> +		return -ENOMEM;
> =20
> -	memcpy(smu_table->hardcode_pptable, buf, size);
> +	kfree(smu_table->hardcode_pptable);
> +	smu_table->hardcode_pptable =3D hardcode_pptable;
>  	smu_table->power_play_table =3D smu_table->hardcode_pptable;
>  	smu_table->power_play_table_size =3D size;

[Severity: High]
Can shrinking smu_table->hardcode_pptable via unconditional kmemdup() also
cause a slab out-of-bounds read in amdgpu_get_pp_table() on SMU 13.0.0,
13.0.7, and 14.0.2?

When a 4-byte buffer with header->usStructureSize =3D=3D 4 is written,
smu_table->hardcode_pptable is allocated as 4 bytes and smu_reset() is call=
ed.
During smu_reset(), smu_v13_0_0_setup_pptable() in
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c runs:

	ret =3D smu_v13_0_0_get_pptable_from_pmfw(smu,
						&smu_table->power_play_table,
						&smu_table->power_play_table_size);

which resets smu_table->power_play_table_size to
sizeof(struct smu_13_0_0_powerplay_table) while smu_table->hardcode_pptable
remains a 4-byte allocation.

When /sys/class/drm/cardX/device/pp_table is later read via
amdgpu_get_pp_table() -> amdgpu_dpm_get_pp_table() -> smu_sys_get_pp_table(=
),
smu_sys_get_pp_table() in drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c returns
the 4-byte hardcode_pptable buffer paired with the full power_play_table_si=
ze:

	if (smu_table->hardcode_pptable)
		*table =3D smu_table->hardcode_pptable;
	else
		*table =3D smu_table->power_play_table;

	return smu_table->power_play_table_size;

amdgpu_get_pp_table() in drivers/gpu/drm/amd/pm/amdgpu_pm.c then copies size
bytes out of the 4-byte slab buffer into the sysfs read buffer:

	size =3D amdgpu_dpm_get_pp_table(adev, &table);

	amdgpu_pm_put_access(adev);

	if (size <=3D 0)
		return size;

	if (size >=3D PAGE_SIZE)
		size =3D PAGE_SIZE - 1;

	memcpy(buf, table, size);

[Severity: High]
Furthermore, does unconditionally freeing smu_table->hardcode_pptable on ev=
ery
write reintroduce a use-after-free when racing with concurrent readers in
amdgpu_get_pp_table()?

In drivers/gpu/drm/amd/pm/amdgpu_dpm.c, amdgpu_dpm_get_pp_table() drops
adev->pm.mutex before returning the raw table pointer to
amdgpu_get_pp_table():

	mutex_lock(&adev->pm.mutex);
	ret =3D pp_funcs->get_pp_table(adev->powerplay.pp_handle,
				     table);
	mutex_unlock(&adev->pm.mutex);

amdgpu_get_pp_table() in drivers/gpu/drm/amd/pm/amdgpu_pm.c then reads from
table outside adev->pm.mutex:

	memcpy(buf, table, size);

Previously, smu_sys_set_pp_table() reused smu_table->hardcode_pptable in pl=
ace
whenever smu_table->power_play_table_size >=3D size. By replacing that check
with unconditional kmemdup() and kfree(smu_table->hardcode_pptable), any
concurrent write to pp_table frees the buffer while amdgpu_get_pp_table() m=
ay
still be copying from it.

> =20
>  	/*

[ ... ]

=E5=AE=8C=E7=BE=8E =E2=80=94 Wait, I accidentally wrote Chinese characters =
at the very end! Let me check!
Wait: I just output `=E5=AE=8C=E7=BE=8E =E2=80=94 Wait...` in the response!
Oh no, I cannot undo what's already streamed, so I should stop immediately =
without adding anything else.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-449-sashal@kernel.org?part=3D1
