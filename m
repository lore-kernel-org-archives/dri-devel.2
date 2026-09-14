Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FBAC88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819B110EEAB;
	Mon, 14 Sep 2026 13:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i3bYdQjn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABD010EEAB
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:55:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6171B60120;
 Mon, 14 Sep 2026 13:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6C91F000FF;
 Mon, 14 Sep 2026 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789394103;
 bh=cFHRW6Mkpe8zxs9hq8A+O/vVbKtmJOneTtXHl771nM0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i3bYdQjnCruL2C/KC+wZvMI1fIW3UOfIHmLvoJoIf26zCXGPE54z27rOi9jFmzrwm
 uaGiK0kQaOlrUjIeeUw6Z6bifFuKLOSHANxZ8IVsB6wWEBrzEdg9gj1VSZUFekUHLG
 UgDCMqO4ymXqw/wp2VelmVlCnn8iY8y9xt8WMlWTJbWKOAipKiSN3rCPm7FhHLnIUJ
 yjpAznTNYNAj+9JnXJSZtp8EiVmn5kZoj2EgcNjUXaIn5mWp+KA/XHi2XS0mejAULh
 TjNTS36PODNPQaD+PE+Vh+Yi7qBR6vfguQ345c+DAp47K5T7fM52/XUVabJtv5kJtW
 6a91FcYymDCRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/pm: bound SCLK FCW range entries to the table size
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914132920.10127-1-harimishal1@gmail.com>
References: <20260914132920.10127-1-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:55:02 +0000
Message-Id: <20260914135502.ED6C91F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated VBIOS array sizes and offsets cause out-of-bounds memo=
ry reads in atomctrl_get_leakage_vddc_base_on_leakage().
- [High] Missing VBIOS table size check in `atomctrl_get_avfs_information` =
allows out-of-bounds memory reads.
- [Medium] Fallback path uses uninitialized `smu_data->range_table` if the =
VBIOS table was successfully loaded.
- [Medium] The function `get_edc_leakage_table` correctly calculates the of=
fset but incorrectly returns a pointer to the base table.
--

commit 79900a4165725430ba1e1ef41665d1982912cab7
Author: Hari Mishal <harimishal1@gmail.com>

drm/amd/pm: bound SCLK FCW range entries to the table size

This patch limits the number of entries read from the VBIOS SMU_Info table
into pp_atom_ctrl_sclk_range_table to MAX_SCLK_RANGE. It prevents a stack
buffer overflow caused by an unchecked ucSclkEntryNum count from the VBIOS.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index 4b796d60b03d4..3217ad3c1d17e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -1025,6 +1025,9 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwm=
gr *hwmgr, struct pp_atom_ctr
>  	if (!psmu_info)
>  		return -EINVAL;
> =20
> +	if (psmu_info->ucSclkEntryNum > MAX_SCLK_RANGE)
> +		return -EINVAL;
> +
>  	for (i =3D 0; i < psmu_info->ucSclkEntryNum; i++) {
>  		table->entry[i].ucVco_setting =3D psmu_info->asSclkFcwRangeEntry[i].uc=
Vco_setting;
>  		table->entry[i].ucPostdiv =3D psmu_info->asSclkFcwRangeEntry[i].ucPost=
div;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing VBIOS bounds
checking in ppatomctrl.c, I noticed another potential out-of-bounds read in
atomctrl_get_avfs_information():

drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c:atomctrl_get_avfs_infor=
mation() {
	profile =3D (ATOM_ASIC_PROFILING_INFO_V3_6 *)
			smu_atom_get_data_table(hwmgr->adev,
					GetIndexIntoMasterTable(DATA, ASIC_ProfilingInfo),
					NULL, NULL, NULL);
	if (!profile)
		return -1;

	param->ulAVFS_meanNsigma_Acontant0 =3D le32_to_cpu(profile->ulAVFS_meanNsi=
gma_Acontant0);
	...
}

Does this code fail to validate the size of the ASIC_ProfilingInfo table?

If a corrupted or older VBIOS provides a smaller table, could this lead to
reading past the end of the table mapping since the size parameter passed
to smu_atom_get_data_table() is NULL?

[Severity: High]
This is a pre-existing issue, but I found another unvalidated VBIOS array s=
ize
used in atomctrl_get_leakage_vddc_base_on_leakage():

drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c:atomctrl_get_leakage_vd=
dc_base_on_leakage() {
	...
			for (i =3D 0; i < profile->ucElbVDDC_Num; i++) {
				if (vddc_id_buf[i] =3D=3D virtual_voltage_id) {
	...
							*vddc =3D vddc_buf[j * profile->ucElbVDDC_Num + i];
	...
}

Can this loop iterate out-of-bounds if a malicious or corrupted VBIOS provi=
des
an excessively large ucElbVDDC_Num?

The count and unvalidated offsets might lead to out-of-bounds memory reads.

[Severity: Medium]
This isn't a bug introduced by this patch, but get_edc_leakage_table() seems
to return the wrong pointer:

drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c:get_edc_leakage_table()=
 {
	...
	temp =3D (char *)table_address;
	table_address +=3D offset;

	return (AtomCtrl_EDCLeakgeTable *)temp;
}

Is this returning a pointer to the base table instead of the calculated off=
set?

Since table_address is incremented but temp is returned, might this cause
callers to read incorrect data from the beginning of the GFX_Info table rat=
her
than the intended offset?

[Severity: Medium]
This is a pre-existing issue, but there seems to be an uninitialized memory
issue in the fallback path after loading the range table:

drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c:polaris10_get_sc=
lk_range_table() {
	...
		}
		return;
	}
	...
}

drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c:polaris10_calcul=
ate_sclk_params() {
	...
		if (clock > smu_data->range_table[i].trans_lower_frequency
		&& clock <=3D smu_data->range_table[i].trans_upper_frequency) {
	...
}

If atomctrl_get_smc_sclk_range_table() succeeds,
polaris10_get_sclk_range_table() returns without initializing
smu_data->range_table.

If a subsequent divider calculation fails, could
polaris10_calculate_sclk_params() use this uninitialized range_table in its
fallback loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914132920.1012=
7-1-harimishal1@gmail.com?part=3D1
