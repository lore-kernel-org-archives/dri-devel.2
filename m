Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AA60A7E63
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1di2PSM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516F510E6E1;
	Mon, 19 Oct 2026 15:20:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DF710E6E1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:20:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CA06602BE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950871F000C4;
 Mon, 19 Oct 2026 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423245;
 bh=808ueFRvOPDCBUsl7tuj1nNWPRyuYmr9fWsfaM1wGhA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I1di2PSMcHQQyUtGHsza1peWauCEmIVNwvpsJo8XYV84mWwRsSWHpJmTJ+iqj1i2Y
 GsUWaRsRfyBfkDbTuhwuwqvCdzn88YDN16oqqrssWo5Kb6o4Ur+m+XMcFsgTNpXd1t
 5m0yx7P8UOzbVMmzfJp4vERwPE2D3a+CtPDNdYZK7b0Jx4MnaaWdN/CdsjrKSiJTD8
 QrgsXbemMT8/ihdiAVsNGXyNPC4hpdXwLpZvK0n+w0M1EukvteFdojK9aO4PjHM/oX
 ik/ZmtY/JQzH2GrKIby16b1rUSHTPjk+4IJK7gnxTLeGOW9Q7kcSIRt+fJUjdQNmsc
 pJWAsQL1ybS9w==
Message-ID: <sashiko-outbox-177685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] drm/amd/pm: Guard VBIOS AC timing
 table walk
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-423-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-423-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:20:45 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amd/pm: unchecked index table walk in atomctrl_set_mc_reg_ad=
dress_table()
--

commit a6c602ed4f05fc0e3395f511194128fee6bac1cc
Author: Xiang Liu <xiang.liu@amd.com>

drm/amd/pm: Guard VBIOS AC timing table walk

This commit rejects AC timing blocks with a stride smaller than a dword and
bounds the data-block and END marker reads in atomctrl_retrieve_ac_timing()=
 by
the returned VRAM_Info table size.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index ce166a7f8e420..85bf1527c6f44 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c

[ ... ]

> @@ -157,6 +170,7 @@ int atomctrl_initialize_mc_reg_table(
>  	}
> =20
>  	if (0 =3D=3D result) {
> +		table_end =3D (uint8_t *)vram_info + size;
>  		reg_block =3D (ATOM_INIT_REG_BLOCK *)
>  			((uint8_t *)vram_info + le16_to_cpu(vram_info->usMemClkPatchTblOffset=
));
>  		result =3D atomctrl_set_mc_reg_address_table(reg_block, table);
>  	}
> =20
>  	if (0 =3D=3D result) {
>  		result =3D atomctrl_retrieve_ac_timing(module_index,
> -					reg_block, table);
> +					reg_block, table_end, table);
>  	}

[Severity: Medium]
The commit message notes that the reads are bounded by the returned VRAM_In=
fo
table size so malformed index/data sizes do not push the timing walk past t=
he
table.

However, in both atomctrl_initialize_mc_reg_table() and
atomctrl_initialize_mc_reg_table_v2_2(), table_end is only passed to
atomctrl_retrieve_ac_timing(). Prior to that call, reg_block is computed fr=
om
vram_info->usMemClkPatchTblOffset and passed directly to
atomctrl_set_mc_reg_address_table() without checking whether reg_block or i=
ts
index table fits within table_end:

drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c:atomctrl_set_mc_reg_add=
ress_table() {
	uint8_t i =3D 0;
	uint8_t num_entries =3D (uint8_t)((le16_to_cpu(reg_block->usRegIndexTblSiz=
e))
			/ sizeof(ATOM_INIT_REG_INDEX_FORMAT));
	ATOM_INIT_REG_INDEX_FORMAT *format =3D &reg_block->asRegIndexBuf[0];

	num_entries--;        /* subtract 1 data end mark entry */

	PP_ASSERT_WITH_CODE((num_entries <=3D VBIOS_MC_REGISTER_ARRAY_SIZE),
			"Invalid VramInfo table.", return -1);

	/* ucPreRegDataLength bit6 =3D 1 is the end of memory clock AC timing regi=
sters */
	while ((!(format->ucPreRegDataLength & ACCESS_PLACEHOLDER)) &&
			(i < num_entries)) {
...
}

In atomctrl_set_mc_reg_address_table(), there are a few issues when handlin=
g a
malformed VBIOS table:

First, reg_block->usRegIndexTblSize is dereferenced and format->asRegIndexB=
uf
is walked without validating against table_end.

Second, the while loop condition evaluates format->ucPreRegDataLength before
checking i < num_entries, which reads one entry past num_entries when
ACCESS_PLACEHOLDER is not encountered earlier.

Third, casting le16_to_cpu(reg_block->usRegIndexTblSize) /
sizeof(ATOM_INIT_REG_INDEX_FORMAT) to uint8_t truncates the 16-bit entry co=
unt
before decrementing num_entries and comparing against
VBIOS_MC_REGISTER_ARRAY_SIZE.

Should reg_block and atomctrl_set_mc_reg_address_table() also be bounded by
table_end, and should i < num_entries be checked before dereferencing forma=
t?

> =20
>  	return result;

[ ... ]

> @@ -198,6 +213,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
>  	}
> =20
>  	if (0 =3D=3D result) {
> +		table_end =3D (uint8_t *)vram_info + size;
>  		reg_block =3D (ATOM_INIT_REG_BLOCK *)
>  			((uint8_t *)vram_info + le16_to_cpu(vram_info->usMemClkPatchTblOffset=
));
>  		result =3D atomctrl_set_mc_reg_address_table(reg_block, table);
>  	}
> =20
>  	if (0 =3D=3D result) {
>  		result =3D atomctrl_retrieve_ac_timing(module_index,
> -					reg_block, table);
> +					reg_block, table_end, table);
>  	}
> =20
>  	return result;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-423-sashal@kernel.org?part=3D1
