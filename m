Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74F606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3yLB0Gp
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96BACCF2E5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137A010E462;
	Mon, 19 Oct 2026 14:48:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E533910E462
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:47:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AAD4543A92
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D35B1F000C4;
 Mon, 19 Oct 2026 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792421276;
 bh=tTzjIJw9TKku8XIIInVb5+g73isJlH+XVR5gPAKMEjg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q3yLB0GpLwO81aJDHd+xmU8SUuWIxwMY43x6ozKV1LfqNefs+zUeQrwljj1gDVJb5
 MPG2WzD8zXOSpqLQVb5t1FLWQuzWwYnqNUdmiURfeG1i2CkmoD9jKDHoSa/e8wnyDV
 1IsaoXWmAqGDUXNd/+AN2Di77oFJvey5UhRNHmDOzwIPTH3anQ1WMCxe5iHND4egKX
 dhyR0/xJ21iNXKXr6vsbH3W8htwfLQNfsH8BlKlazDSALJpY+AkobmSRF9yVZIn0PZ
 r+YzO1bVXc4dW1XbuZV3Bby+20iavVEovbA/L3rIh9/ed9N7aIDBVHf5fsFUlhzyc7
 CPA+F5d7L6xsQ==
Message-ID: <sashiko-outbox-177502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] drm/amd/pm: Validate Tonga PPTable
 subtable bounds
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-192-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-192-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:47:56 +0000
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
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/amd/pm: NULL vdd_dep_on_sclk deref in get_pcie_table() and get=
_gpio_table()
- [Medium] drm/amd/pm: 1-byte OOB read in get_tonga_sclk_dependency_table()=
 and PCIE
- [Medium] drm/amd/pm: missing PPTable and state array bounds in check_powe=
rplay_tables()
- [Medium] drm/amd/pm: unchecked ppt_get_vce_state_table_entry_v1_0() error=
 in get_powerplay_table_entry_v1_0()
- [Medium] drm/amd/pm: memory leak in pp_tables_v1_0_initialize() on subtab=
le error
--

commit f47b28bb12da9445f349f0b309395380a9db541f
Author: Yang Wang <kevinyang.wang@amd.com>

drm/amd/pm: Validate Tonga PPTable subtable bounds

This commit adds bounds validation helpers for Tonga PowerPlay subtables
to validate fixed subtable headers, dynamic entry arrays, and
revision-specific layouts before consuming VBIOS or user-supplied PPTable
data.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0=
.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> index 6cfef1b295abb..a4cdae8ac73cf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -150,6 +150,368 @@ static const void *get_powerplay_table(struct pp_hw=
mgr *hwmgr)
>  	return table_address;
>  }
> =20
> +static bool tonga_pp_table_has_space(struct pp_hwmgr *hwmgr, size_t offs=
et,
> +				     size_t size)
> +{
> +	size_t table_size =3D hwmgr->soft_pp_table_size;
> +
> +	return offset <=3D table_size && size <=3D table_size - offset;
> +}

[Severity: Medium]
Can the new get_tonga_*_table() helpers and check_powerplay_tables() read
out of bounds past hwmgr->soft_pp_table when hwmgr->soft_pp_table_size is
smaller than sizeof(ATOM_Tonga_POWERPLAYTABLE), or when usStateArrayOffset
and state_arrays->ucNumEntries exceed hwmgr->soft_pp_table_size?

In drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c,
get_powerplay_table() caches hwmgr->soft_pp_table_size from
smu_atom_get_data_table() without checking that it is at least
sizeof(ATOM_Tonga_POWERPLAYTABLE):

	if (!table_address) {
		table_address =3D (ATOM_Tonga_POWERPLAYTABLE *)
				smu_atom_get_data_table(hwmgr->adev,
						index, &size, &frev, &crev);
		hwmgr->soft_pp_table =3D table_address;	/*Cache the result in RAM.*/
		hwmgr->soft_pp_table_size =3D size;
	}

All of the new get_tonga_*_table() subtable helpers dereference offset
fields directly from powerplay_table (up to usGPIOTableOffset at the end
of ATOM_Tonga_POWERPLAYTABLE) before calling tonga_pp_table_has_space().

In addition, because the prerequisite Tonga state-array bounds validation
from the upstream series is not present on this branch,
check_powerplay_tables(), get_number_of_powerplay_table_entries_v1_0(), and
get_powerplay_table_entry_v1_0() still compute and dereference state_arrays
without checking hwmgr->soft_pp_table_size:

static int check_powerplay_tables(
		struct pp_hwmgr *hwmgr,
		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table
		)
{
	const ATOM_Tonga_State_Array *state_arrays;

	state_arrays =3D (ATOM_Tonga_State_Array *)(((unsigned long)powerplay_tabl=
e) +
		le16_to_cpu(powerplay_table->usStateArrayOffset));
	...
	PP_ASSERT_WITH_CODE((0 !=3D powerplay_table->usStateArrayOffset),
		"State table is not set!", return -1);
	PP_ASSERT_WITH_CODE((0 < powerplay_table->sHeader.usStructureSize),
		"Invalid PowerPlay Table!", return -1);
	PP_ASSERT_WITH_CODE((0 < state_arrays->ucNumEntries),
		"Invalid PowerPlay Table!", return -1);

Should the base ATOM_Tonga_POWERPLAYTABLE size and state_arrays bounds also
be validated against hwmgr->soft_pp_table_size before dereferencing them?

[ ... ]

> +static int get_tonga_sclk_dependency_table(struct pp_hwmgr *hwmgr,
> +		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +		const PPTable_Generic_SubTable_Header **sclk_dep_table)
> +{
> +	const PPTable_Generic_SubTable_Header *header;
> +	u16 table_offset;
> +	size_t entries_offset;
> +	size_t entry_size;
> +	u8 num_entries;
> +	int ret;
> +
> +	table_offset =3D le16_to_cpu(powerplay_table->usSclkDependencyTableOffs=
et);
> +	ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +				 sizeof(*header), (const void **)&header);
> +	if (ret)
> +		return ret;
> +
> +	if (header->ucRevId < 1) {
> +		const ATOM_Tonga_SCLK_Dependency_Table *table =3D
> +			(const ATOM_Tonga_SCLK_Dependency_Table *)header;
> +
> +		entries_offset =3D offsetof(ATOM_Tonga_SCLK_Dependency_Table, entries);
> +		entry_size =3D sizeof(ATOM_Tonga_SCLK_Dependency_Record);
> +		num_entries =3D table->ucNumEntries;
> +	} else {
> +		const ATOM_Polaris_SCLK_Dependency_Table *table =3D
> +			(const ATOM_Polaris_SCLK_Dependency_Table *)header;
> +
> +		entries_offset =3D offsetof(ATOM_Polaris_SCLK_Dependency_Table, entrie=
s);
> +		entry_size =3D sizeof(ATOM_Polaris_SCLK_Dependency_Record);
> +		num_entries =3D table->ucNumEntries;
> +	}
> +
> +	ret =3D validate_tonga_table_entries(hwmgr, table_offset, entries_offse=
t,
> +					   num_entries, entry_size);
> +	if (ret)
> +		return ret;
> +
> +	*sclk_dep_table =3D header;
> +
> +	return 0;
> +}
> +
> +static int get_tonga_pcie_table(struct pp_hwmgr *hwmgr,
> +		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +		const PPTable_Generic_SubTable_Header **pcie_table)
> +{
> +	const PPTable_Generic_SubTable_Header *header;
> +	u16 table_offset;
> +	size_t entries_offset;
> +	size_t entry_size;
> +	u8 num_entries;
> +	int ret;
> +
> +	table_offset =3D le16_to_cpu(powerplay_table->usPCIETableOffset);
> +	ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +				 sizeof(*header), (const void **)&header);
> +	if (ret)
> +		return ret;
> +
> +	if (header->ucRevId < 1) {
> +		const ATOM_Tonga_PCIE_Table *table =3D
> +			(const ATOM_Tonga_PCIE_Table *)header;
> +
> +		entries_offset =3D offsetof(ATOM_Tonga_PCIE_Table, entries);
> +		entry_size =3D sizeof(ATOM_Tonga_PCIE_Record);
> +		num_entries =3D table->ucNumEntries;
> +	} else {
> +		const ATOM_Polaris10_PCIE_Table *table =3D
> +			(const ATOM_Polaris10_PCIE_Table *)header;
> +
> +		entries_offset =3D offsetof(ATOM_Polaris10_PCIE_Table, entries);
> +		entry_size =3D sizeof(ATOM_Polaris10_PCIE_Record);
> +		num_entries =3D table->ucNumEntries;
> +	}

[Severity: Medium]
Does reading table->ucNumEntries in get_tonga_sclk_dependency_table() and
get_tonga_pcie_table() cause a 1-byte out-of-bounds read past
hwmgr->soft_pp_table when table_offset equals hwmgr->soft_pp_table_size - 1?

In drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h,
PPTable_Generic_SubTable_Header is only 1 byte:

typedef struct _PPTable_Generic_SubTable_Header {
	UCHAR  ucRevId;
} PPTable_Generic_SubTable_Header;

Both get_tonga_sclk_dependency_table() and get_tonga_pcie_table() pass
sizeof(*header) (1 byte) to get_tonga_subtable(), and then immediately
cast header to the concrete subtable type and read table->ucNumEntries at
table_offset + 1 before calling validate_tonga_table_entries().

If usSclkDependencyTableOffset or usPCIETableOffset is
hwmgr->soft_pp_table_size - 1, get_tonga_subtable() succeeds for the 1-byte
header and table->ucNumEntries reads 1 byte past the end of
hwmgr->soft_pp_table.

[ ... ]

> @@ -821,29 +1177,58 @@ static int init_clock_voltage_dependency(
>  	pp_table_information->pcie_table =3D NULL;
>  	pp_table_information->gpio_table =3D NULL;
> =20
> -	if (powerplay_table->usMMDependencyTableOffset !=3D 0)
> -		result =3D get_mm_clock_voltage_table(hwmgr,
> -		&pp_table_information->mm_dep_table, mm_dependency_table);
> +	if (powerplay_table->usMMDependencyTableOffset !=3D 0) {
> +		result =3D get_tonga_mm_dependency_table(hwmgr, powerplay_table,
> +						       &mm_dependency_table);
> +		if (!result)
> +			result =3D get_mm_clock_voltage_table(hwmgr,
> +				&pp_table_information->mm_dep_table,
> +				mm_dependency_table);
> +	}
> =20
> -	if (result =3D=3D 0 && powerplay_table->usPowerTuneTableOffset !=3D 0)
> -		result =3D get_cac_tdp_table(hwmgr,
> -		&pp_table_information->cac_dtp_table, pPowerTuneTable);
> +	if (result =3D=3D 0 && powerplay_table->usPowerTuneTableOffset !=3D 0) {
> +		result =3D get_tonga_power_tune_table(hwmgr, powerplay_table,
> +						    &pPowerTuneTable);
> +		if (!result)
> +			result =3D get_cac_tdp_table(hwmgr,
> +				&pp_table_information->cac_dtp_table,
> +				pPowerTuneTable);
> +	}
> =20
> -	if (result =3D=3D 0 && powerplay_table->usSclkDependencyTableOffset !=
=3D 0)
> -		result =3D get_sclk_voltage_dependency_table(hwmgr,
> -		&pp_table_information->vdd_dep_on_sclk, sclk_dep_table);
> +	if (result =3D=3D 0 && powerplay_table->usSclkDependencyTableOffset !=
=3D 0) {
> +		result =3D get_tonga_sclk_dependency_table(hwmgr, powerplay_table,
> +							 &sclk_dep_table);
> +		if (!result)
> +			result =3D get_sclk_voltage_dependency_table(hwmgr,
> +				&pp_table_information->vdd_dep_on_sclk,
> +				sclk_dep_table);
> +	}
> =20
> -	if (result =3D=3D 0 && powerplay_table->usMclkDependencyTableOffset !=
=3D 0)
> -		result =3D get_mclk_voltage_dependency_table(hwmgr,
> -		&pp_table_information->vdd_dep_on_mclk, mclk_dep_table);
> +	if (result =3D=3D 0 && powerplay_table->usMclkDependencyTableOffset !=
=3D 0) {
> +		result =3D get_tonga_mclk_dependency_table(hwmgr, powerplay_table,
> +							 &mclk_dep_table);
> +		if (!result)
> +			result =3D get_mclk_voltage_dependency_table(hwmgr,
> +				&pp_table_information->vdd_dep_on_mclk,
> +				mclk_dep_table);
> +	}
> =20
> -	if (result =3D=3D 0 && powerplay_table->usPCIETableOffset !=3D 0)
> -		result =3D get_pcie_table(hwmgr,
> -		&pp_table_information->pcie_table, pcie_table);
> +	if (result =3D=3D 0 && powerplay_table->usPCIETableOffset !=3D 0) {
> +		result =3D get_tonga_pcie_table(hwmgr, powerplay_table,
> +					      &pcie_table);
> +		if (!result)
> +			result =3D get_pcie_table(hwmgr,
> +				&pp_table_information->pcie_table, pcie_table);
> +	}
> =20
> -	if (result =3D=3D 0 && powerplay_table->usHardLimitTableOffset !=3D 0)
> -		result =3D get_hard_limits(hwmgr,
> -		&pp_table_information->max_clock_voltage_on_dc, pHardLimits);
> +	if (result =3D=3D 0 && powerplay_table->usHardLimitTableOffset !=3D 0) {
> +		result =3D get_tonga_hard_limit_table(hwmgr, powerplay_table,
> +						    &pHardLimits);
> +		if (!result)
> +			result =3D get_hard_limits(hwmgr,
> +				&pp_table_information->max_clock_voltage_on_dc,
> +				pHardLimits);
> +	}
> =20
>  	hwmgr->dyn_state.max_clock_voltage_on_dc.sclk =3D
>  		pp_table_information->max_clock_voltage_on_dc.sclk;
> @@ -864,9 +1249,13 @@ static int init_clock_voltage_dependency(
>  		result =3D get_valid_clk(hwmgr, &pp_table_information->valid_sclk_valu=
es,
>  		pp_table_information->vdd_dep_on_sclk);
> =20
> -	if (!result && gpio_table)
> -		result =3D get_gpio_table(hwmgr, &pp_table_information->gpio_table,
> -				gpio_table);
> +	if (!result && powerplay_table->usGPIOTableOffset) {
> +		result =3D get_tonga_gpio_table(hwmgr, powerplay_table,
> +					      &gpio_table);
> +		if (!result)
> +			result =3D get_gpio_table(hwmgr,
> +				&pp_table_information->gpio_table, gpio_table);
> +	}
> =20
>  	return result;
>  }

[Severity: High]
What happens in init_clock_voltage_dependency() if a malformed PPTable has
usSclkDependencyTableOffset =3D=3D 0 while usPCIETableOffset !=3D 0 or
usGPIOTableOffset !=3D 0?

In init_clock_voltage_dependency(), pp_table_information->vdd_dep_on_sclk
is initialized to NULL and is only populated when
powerplay_table->usSclkDependencyTableOffset !=3D 0 (as anticipated before
get_valid_clk(), which checks NULL !=3D pp_table_information->vdd_dep_on_sc=
lk).

However, when usPCIETableOffset !=3D 0 or usGPIOTableOffset !=3D 0,
get_pcie_table() and get_gpio_table() are called and unconditionally
dereference pp_table_information->vdd_dep_on_sclk->count:

get_pcie_table():
	pcie_count =3D (pp_table_information->vdd_dep_on_sclk->count) + 1;

get_gpio_table():
	if (pp_table_information->vdd_dep_on_sclk->count <
			atom_gpio_table->ucVRHotTriggeredSclkDpmIndex)

Can this trigger a NULL pointer dereference on a table with
usSclkDependencyTableOffset =3D=3D 0?

[Severity: Medium]
Also in init_clock_voltage_dependency(), init_dpm_2_parameters(), and
init_thermal_controller(), if one of the new get_tonga_*() subtable bounds
checks fails after earlier subtables have been allocated, does
pp_tables_v1_0_initialize() leak hwmgr->pptable,
hwmgr->dyn_state.cac_dtp_table, and the already-allocated subtable arrays
in pp_table_information?

When pp_tables_v1_0_initialize() returns a non-zero result:

pp_tables_v1_0_initialize() {
	...
	result =3D init_clock_voltage_dependency(hwmgr, powerplay_table);

	PP_ASSERT_WITH_CODE((result =3D=3D 0),
			    "init_clock_voltage_dependency failed", return result);

	result =3D init_dpm_2_parameters(hwmgr, powerplay_table);

	PP_ASSERT_WITH_CODE((result =3D=3D 0),
			    "init_dpm_2_parameters failed", return result);
}

its caller hwmgr_hw_init() in drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
jumps to err, bypassing err1 where pptable_fini()
(pp_tables_v1_0_uninitialize()) would otherwise free those allocations:

	ret =3D hwmgr->pptable_func->pptable_init(hwmgr);
	if (ret)
		goto err;
	...
err1:
	if (hwmgr->pptable_func->pptable_fini)
		hwmgr->pptable_func->pptable_fini(hwmgr);
err:
	return ret;

[ ... ]

> @@ -1290,13 +1683,15 @@ static int ppt_get_num_of_vce_state_table_entries=
_v1_0(struct pp_hwmgr *hwmgr)
>  {
>  	const ATOM_Tonga_POWERPLAYTABLE *pp_table =3D get_powerplay_table(hwmgr=
);
>  	const ATOM_Tonga_VCE_State_Table *vce_state_table;
> +	int ret;
> =20
> =20
>  	if (pp_table =3D=3D NULL)
>  		return 0;
> =20
> -	vce_state_table =3D (void *)pp_table +
> -			le16_to_cpu(pp_table->usVCEStateTableOffset);
> +	ret =3D get_tonga_vce_state_table(hwmgr, pp_table, &vce_state_table);
> +	if (ret)
> +		return 0;
> =20
>  	return vce_state_table->ucNumEntries;
>  }
> @@ -1305,18 +1700,39 @@ static int ppt_get_vce_state_table_entry_v1_0(str=
uct pp_hwmgr *hwmgr, uint32_t i
>  		struct amd_vce_state *vce_state, void **clock_info, uint32_t *flag)
>  {
>  	const ATOM_Tonga_VCE_State_Record *vce_state_record;
> -	ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record;
> +	ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record =3D NULL;
> +	ATOM_Polaris_SCLK_Dependency_Record *polaris_sclk_dep_record =3D NULL;
>  	ATOM_Tonga_MCLK_Dependency_Record *mclk_dep_record;
>  	ATOM_Tonga_MM_Dependency_Record *mm_dep_record;
>  	const ATOM_Tonga_POWERPLAYTABLE *pptable =3D get_powerplay_table(hwmgr);
> -	const ATOM_Tonga_VCE_State_Table *vce_state_table =3D (ATOM_Tonga_VCE_S=
tate_Table *)(((unsigned long)pptable)
> -							  + le16_to_cpu(pptable->usVCEStateTableOffset));
> -	const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table =3D (ATOM_Tonga_=
SCLK_Dependency_Table *)(((unsigned long)pptable)
> -							  + le16_to_cpu(pptable->usSclkDependencyTableOffset));
> -	const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table =3D (ATOM_Tonga_=
MCLK_Dependency_Table *)(((unsigned long)pptable)
> -							  + le16_to_cpu(pptable->usMclkDependencyTableOffset));
> -	const ATOM_Tonga_MM_Dependency_Table *mm_dep_table =3D (ATOM_Tonga_MM_D=
ependency_Table *)(((unsigned long)pptable)
> -							  + le16_to_cpu(pptable->usMMDependencyTableOffset));
> +	const ATOM_Tonga_VCE_State_Table *vce_state_table;
> +	const PPTable_Generic_SubTable_Header *sclk_dep_table_header;
> +	const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table;
> +	const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table;
> +	const ATOM_Tonga_MM_Dependency_Table *mm_dep_table;
> +	int ret;
> +
> +	if (!pptable)
> +		return -EINVAL;
> +
> +	ret =3D get_tonga_vce_state_table(hwmgr, pptable, &vce_state_table);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D get_tonga_sclk_dependency_table(hwmgr, pptable,
> +					      &sclk_dep_table_header);
> +	if (ret)
> +		return ret;
> +	sclk_dep_table =3D (const ATOM_Tonga_SCLK_Dependency_Table *)
> +		sclk_dep_table_header;
> +
> +	ret =3D get_tonga_mclk_dependency_table(hwmgr, pptable, &mclk_dep_table=
);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D get_tonga_mm_dependency_table(hwmgr, pptable, &mm_dep_table);
> +	if (ret)
> +		return ret;
> =20
>  	PP_ASSERT_WITH_CODE((i < vce_state_table->ucNumEntries),
>  			 "Requested state entry ID is out of range!",
> @@ -1325,10 +1741,27 @@ static int ppt_get_vce_state_table_entry_v1_0(str=
uct pp_hwmgr *hwmgr, uint32_t i
>  	vce_state_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
>  					ATOM_Tonga_VCE_State_Record,
>  					entries, vce_state_table, i);
> -	sclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
> -					ATOM_Tonga_SCLK_Dependency_Record,
> -					entries, sclk_dep_table,
> -					vce_state_record->ucSCLKIndex);
> +	PP_ASSERT_WITH_CODE((vce_state_record->ucSCLKIndex <
> +			     sclk_dep_table->ucNumEntries),
> +			    "Invalid PowerPlay Table!", return -EINVAL);
> +	PP_ASSERT_WITH_CODE((vce_state_record->ucVCEClockIndex <
> +			     mm_dep_table->ucNumEntries),
> +			    "Invalid PowerPlay Table!", return -EINVAL);
> +	PP_ASSERT_WITH_CODE((mclk_dep_table->ucNumEntries !=3D 0),
> +			    "Invalid PowerPlay Table!", return -EINVAL);

[Severity: Medium]
When ppt_get_vce_state_table_entry_v1_0() returns early on one of these new
validation checks, how does the caller get_powerplay_table_entry_v1_0()
handle the failure?

In get_powerplay_table_entry_v1_0():

	hwmgr->num_vce_state_tables =3D i =3D ppt_get_num_of_vce_state_table_entri=
es_v1_0(hwmgr);

	if ((i !=3D 0) && (i <=3D AMD_MAX_VCE_LEVELS)) {
		for (j =3D 0; j < i; j++)
			ppt_get_vce_state_table_entry_v1_0(hwmgr, j, &(hwmgr->vce_states[j]), NU=
LL, &flags);
	}

ppt_get_num_of_vce_state_table_entries_v1_0() only validates
get_tonga_vce_state_table() (and does not check ucNumEntries <=3D
AMD_MAX_VCE_LEVELS). If ppt_get_vce_state_table_entry_v1_0() fails on
get_tonga_sclk_dependency_table(), get_tonga_mclk_dependency_table(),
get_tonga_mm_dependency_table(), or the ucSCLKIndex / ucVCEClockIndex range
checks, its return value is ignored and hwmgr->num_vce_state_tables remains
set to i while hwmgr->vce_states[j] is left unpopulated or retains stale
data after a sysfs pp_table update.

Similarly, if i > AMD_MAX_VCE_LEVELS, the loop is skipped while
hwmgr->num_vce_state_tables remains set to i, which
pp_dpm_get_vce_clock_state() in
drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c then uses to bounds-check
hwmgr->vce_states[idx]:

	if (idx < hwmgr->num_vce_state_tables)
		return &hwmgr->vce_states[idx];

Should get_powerplay_table_entry_v1_0() check the return value of
ppt_get_vce_state_table_entry_v1_0() and reset hwmgr->num_vce_state_tables
to 0 when i > AMD_MAX_VCE_LEVELS or when entry parsing fails?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-192-sashal@kernel.org?part=3D1
