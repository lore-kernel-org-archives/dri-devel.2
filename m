Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4145BCCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1AC210ED9E;
	Mon, 19 Oct 2026 14:28:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1EF10ED96
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:28:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9FF060136
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B61F000C4;
 Mon, 19 Oct 2026 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792420087;
 bh=RJmNDmsr4YwHE+ATKjotigOt9g+eBnaGQi8idXNBBD4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RYy+sEBoa0pw1WWrC/NUJXNUR9lV/Bo5hjcKh77wpAmbcHa4s8wvxtbAQRZ72KKWK
 KerfeOfalBKxq/1ucdmFVoxg1mT4ObQ7/sRmXTvIC5OIFxYY93VBMmwqrMsALGJCBq
 GmEkaEDDxQA9VPn2wC9jA7SaTJzEWO9Ml3UvDa6oLPwOjMsjRaXUDGM9dqJytJDsFt
 hlwqgjTVwFDiZ553JT8fqSB8pMKiQHszFkt7pL0fczbeQ6Re7DFdMUjBDMll1AyDdO
 iJFf9JXs9v8Z6mM/ABMlZNFCZ2KLok96AyLtaXYjwRYOP+QHQyZck7h8SnA6fOF6sF
 KSRbfKEyQ5ZpQ==
Message-ID: <sashiko-outbox-177391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/amd/pm: Validate legacy hwmgr PP
 table offsets
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-51-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-51-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:28:06 +0000
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
- [High] drm/amd/pm: unvalidated subtable offsets in init_clock_voltage_dep=
endency()
- [High] drm/amd/pm: missing subtable bounds checks in pp_tables_initialize=
()
- [High] drm/amd/pm: weak clock info size and level checks in pp_tables_get=
_entry()
--

commit c5c1e3659fd69a3025883887b44b7fe3a2082d39
Author: Yang Wang <kevinyang.wang@amd.com>

drm/amd/pm: Validate legacy hwmgr PP table offsets

This commit adds bounds helpers to drivers/gpu/drm/amd/pm/powerplay/hwmgr/p=
rocesspptables.c
to validate offsets and entry sizes against hwmgr->soft_pp_table_size before
dereferencing variable-length PowerPlay subtables during hwmgr initializati=
on
and table entry lookup.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/d=
rivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> index f06b29e33ba45..f1009b2973574 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c

[ ... ]

> @@ -104,10 +138,13 @@ static uint16_t get_vce_clock_voltage_limit_table_o=
ffset(struct pp_hwmgr *hwmgr,
>  {
>  	uint16_t table_offset =3D get_vce_clock_info_array_offset(hwmgr,
>  							powerplay_table);
> +	u16 table_size;
> =20
> -	if (table_offset > 0)
> -		return table_offset + get_vce_clock_info_array_size(hwmgr,
> -							powerplay_table);
> +	if (table_offset > 0) {
> +		table_size =3D get_vce_clock_info_array_size(hwmgr, powerplay_table);
> +		if (table_size)
> +			return table_offset + table_size;
> +	}
> =20
>  	return 0;
>  }

[ ... ]

> @@ -206,10 +256,13 @@ static uint16_t get_uvd_clock_voltage_limit_table_o=
ffset(
>  {
>  	uint16_t table_offset =3D get_uvd_clock_info_array_offset(hwmgr,
>  						     powerplay_table);
> +	u16 table_size;
> =20
> -	if (table_offset > 0)
> -		return table_offset +
> -			get_uvd_clock_info_array_size(hwmgr, powerplay_table);
> +	if (table_offset > 0) {
> +		table_size =3D get_uvd_clock_info_array_size(hwmgr, powerplay_table);
> +		if (table_size)
> +			return table_offset + table_size;
> +	}
> =20
>  	return 0;
>  }
> @@ -218,21 +271,12 @@ static uint16_t get_samu_table_offset(struct pp_hwm=
gr *hwmgr,
>  			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
>  {
>  	uint16_t samu_table_offset =3D 0;
> +	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
> =20
> -	if (le16_to_cpu(powerplay_table->usTableSize) >=3D
> -	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
> -		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =3D
> -			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
> -		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
> -			const ATOM_PPLIB_EXTENDEDHEADER  *extended_header =3D
> -				(const ATOM_PPLIB_EXTENDEDHEADER *)
> -				(((unsigned long)powerplay_table3) +
> -				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
> -			if (le16_to_cpu(extended_header->usSize) >=3D
> -			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V4)
> -				samu_table_offset =3D le16_to_cpu(extended_header->usSAMUTableOffset=
);
> -		}
> -	}
> +	extended_header =3D get_extended_header(hwmgr, powerplay_table,
> +					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V4);
> +	if (extended_header)
> +		samu_table_offset =3D le16_to_cpu(extended_header->usSAMUTableOffset);
> =20
>  	return samu_table_offset;
>  }
> @@ -254,21 +298,12 @@ static uint16_t get_acp_table_offset(struct pp_hwmg=
r *hwmgr,
>  				const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
>  {
>  	uint16_t acp_table_offset =3D 0;
> +	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
> =20
> -	if (le16_to_cpu(powerplay_table->usTableSize) >=3D
> -	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
> -		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =3D
> -			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
> -		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
> -			const ATOM_PPLIB_EXTENDEDHEADER  *pExtendedHeader =3D
> -				(const ATOM_PPLIB_EXTENDEDHEADER *)
> -				(((unsigned long)powerplay_table3) +
> -				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
> -			if (le16_to_cpu(pExtendedHeader->usSize) >=3D
> -			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V6)
> -				acp_table_offset =3D le16_to_cpu(pExtendedHeader->usACPTableOffset);
> -		}
> -	}
> +	extended_header =3D get_extended_header(hwmgr, powerplay_table,
> +					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V6);
> +	if (extended_header)
> +		acp_table_offset =3D le16_to_cpu(extended_header->usACPTableOffset);
> =20
>  	return acp_table_offset;
>  }
> @@ -290,21 +325,12 @@ static uint16_t get_cacp_tdp_table_offset(
>  				const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
>  {
>  	uint16_t cacTdpTableOffset =3D 0;
> +	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
> =20
> -	if (le16_to_cpu(powerplay_table->usTableSize) >=3D
> -	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
> -		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =3D
> -				(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
> -		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
> -			const ATOM_PPLIB_EXTENDEDHEADER  *pExtendedHeader =3D
> -					(const ATOM_PPLIB_EXTENDEDHEADER *)
> -					(((unsigned long)powerplay_table3) +
> -				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
> -			if (le16_to_cpu(pExtendedHeader->usSize) >=3D
> -			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V7)
> -				cacTdpTableOffset =3D le16_to_cpu(pExtendedHeader->usPowerTuneTableO=
ffset);
> -		}
> -	}
> +	extended_header =3D get_extended_header(hwmgr, powerplay_table,
> +					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V7);
> +	if (extended_header)
> +		cacTdpTableOffset =3D le16_to_cpu(extended_header->usPowerTuneTableOff=
set);
> =20
>  	return cacTdpTableOffset;
>  }
> @@ -341,22 +367,13 @@ static uint16_t get_sclk_vdd_gfx_table_offset(struc=
t pp_hwmgr *hwmgr,
>  			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
>  {
>  	uint16_t sclk_vdd_gfx_table_offset =3D 0;
> +	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
> =20
> -	if (le16_to_cpu(powerplay_table->usTableSize) >=3D
> -	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
> -		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =3D
> -				(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
> -		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
> -			const ATOM_PPLIB_EXTENDEDHEADER  *pExtendedHeader =3D
> -				(const ATOM_PPLIB_EXTENDEDHEADER *)
> -				(((unsigned long)powerplay_table3) +
> -				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
> -			if (le16_to_cpu(pExtendedHeader->usSize) >=3D
> -			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V8)
> -				sclk_vdd_gfx_table_offset =3D
> -					le16_to_cpu(pExtendedHeader->usSclkVddgfxTableOffset);
> -		}
> -	}
> +	extended_header =3D get_extended_header(hwmgr, powerplay_table,
> +					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V8);
> +	if (extended_header)
> +		sclk_vdd_gfx_table_offset =3D
> +			le16_to_cpu(extended_header->usSclkVddgfxTableOffset);
> =20
>  	return sclk_vdd_gfx_table_offset;
>  }

[Severity: High]
Can init_clock_voltage_dependency() still read past hwmgr->soft_pp_table
when using the offsets returned by these helpers?

In get_vce_clock_voltage_limit_table_offset() and
get_uvd_clock_voltage_limit_table_offset(), the new check verifies that the
preceding VCEClockInfoArray or UVDClockInfoArray fits within
hwmgr->soft_pp_table_size, and then returns table_offset + table_size. If
that clock info array ends at hwmgr->soft_pp_table_size (or leaves fewer
bytes than the voltage limit table requires), the returned offset is
non-zero and points at or near the end of soft_pp_table.

When pp_tables_initialize() -> init_clock_voltage_dependency() uses those
offsets, it does not call get_vce_clock_voltage_limit_table_size() or
pp_table_has_space():

drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c:init_clock_voltage=
_dependency() {
	vce_clock_info_array_offset =3D get_vce_clock_info_array_offset(
						hwmgr, powerplay_table);
	table_offset =3D get_vce_clock_voltage_limit_table_offset(hwmgr,
						powerplay_table);
	if (vce_clock_info_array_offset > 0 && table_offset > 0) {
		const VCEClockInfoArray *array =3D (const VCEClockInfoArray *)
				(((unsigned long) powerplay_table) +
				vce_clock_info_array_offset);
		const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *table =3D
				(const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *)
				(((unsigned long) powerplay_table) + table_offset);
		result =3D get_vce_clock_voltage_limit_table(hwmgr,
				&hwmgr->dyn_state.vce_clock_voltage_dependency_table,
				table, array);
	}
}

Then get_vce_clock_voltage_limit_table() and
get_uvd_clock_voltage_limit_table() dereference table->numEntries and
table->entries[i] without bounds checks, and also index
array->entries[table->entries[i].ucVCEClockInfoIndex] and
array->entries[table->entries[i].ucUVDClockInfoIndex] without verifying
that the index is less than array->ucNumEntries.

Similarly, get_samu_table_offset(), get_acp_table_offset(),
get_cacp_tdp_table_offset(), and get_sclk_vdd_gfx_table_offset() now
validate the extended header via get_extended_header(), but neither those
helpers nor their sole caller init_clock_voltage_dependency() verify that
the returned subtable offsets and their entry arrays fit within
hwmgr->soft_pp_table_size before dereferencing them.

[ ... ]

> @@ -896,49 +940,128 @@ int pp_tables_get_entry(struct pp_hwmgr *hwmgr,
>  	const NonClockInfoArray *pnon_clock_arrays;
> =20
>  	const ATOM_PPLIB_STATE *pstate_entry;
> +	u16 state_array_offset;
> +	u16 clock_info_array_offset;
> +	u16 non_clock_info_array_offset;
> +	size_t clock_info_offset;
> +	size_t non_clock_info_offset;
> +	size_t state_entry_offset;
> =20
>  	if (powerplay_table =3D=3D NULL)
>  		return -1;
> +	if (!pp_table_has_space(hwmgr, 0, sizeof(*powerplay_table)))
> +		return -1;
> =20
>  	ps->classification.bios_index =3D entry_index;
> =20
>  	if (powerplay_table->sHeader.ucTableFormatRevision >=3D 6) {
> +		state_array_offset =3D le16_to_cpu(powerplay_table->usStateArrayOffset=
);
> +		if (!pp_table_has_space(hwmgr, state_array_offset,
> +					sizeof(pstate_arrays->ucNumEntries)))
> +			return -1;
> +
>  		pstate_arrays =3D (StateArray *)(((unsigned long)powerplay_table) +
> -					le16_to_cpu(powerplay_table->usStateArrayOffset));
> +					state_array_offset);
> +
> +		if (entry_index >=3D pstate_arrays->ucNumEntries)
> +			return -1;
> =20
> -		if (entry_index > pstate_arrays->ucNumEntries)
> +		pstate_entry_v2 =3D get_state_entry_v2(hwmgr, pstate_arrays,
> +						     state_array_offset,
> +						     entry_index);
> +		if (!pstate_entry_v2)
> +			return -1;
> +
> +		clock_info_array_offset =3D
> +			le16_to_cpu(powerplay_table->usClockInfoArrayOffset);
> +		if (!pp_table_has_space(hwmgr, clock_info_array_offset,
> +					sizeof(*pclock_arrays)))
>  			return -1;
> =20
> -		pstate_entry_v2 =3D get_state_entry_v2(pstate_arrays, entry_index);
>  		pclock_arrays =3D (ClockInfoArray *)(((unsigned long)powerplay_table) +
> -					le16_to_cpu(powerplay_table->usClockInfoArrayOffset));
> +					clock_info_array_offset);
> +		if (!pclock_arrays->ucEntrySize)
> +			return -1;
> +
> +		non_clock_info_array_offset =3D
> +			le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset);
> +		if (!pp_table_has_space(hwmgr, non_clock_info_array_offset,
> +					sizeof(*pnon_clock_arrays)))
> +			return -1;
> =20
>  		pnon_clock_arrays =3D (NonClockInfoArray *)(((unsigned long)powerplay_=
table) +
> -						le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset));
> +						non_clock_info_array_offset);
> +		if (!pnon_clock_arrays->ucEntrySize ||
> +		    pnon_clock_arrays->ucEntrySize < ATOM_PPLIB_NONCLOCKINFO_VER1 ||
> +		    (pnon_clock_arrays->ucEntrySize > ATOM_PPLIB_NONCLOCKINFO_VER1 &&
> +		     pnon_clock_arrays->ucEntrySize < ATOM_PPLIB_NONCLOCKINFO_VER2) ||
> +		    pstate_entry_v2->nonClockInfoIndex >=3D pnon_clock_arrays->ucNumEn=
tries)
> +			return -1;
> =20
> +		non_clock_info_offset =3D non_clock_info_array_offset +
> +			offsetof(NonClockInfoArray, nonClockInfo) +
> +			pstate_entry_v2->nonClockInfoIndex * pnon_clock_arrays->ucEntrySize;
> +		if (!pp_table_has_space(hwmgr, non_clock_info_offset,
> +					pnon_clock_arrays->ucEntrySize))
> +			return -1;
>  		pnon_clock_info =3D (ATOM_PPLIB_NONCLOCK_INFO *)((unsigned long)(pnon_=
clock_arrays->nonClockInfo) +
>  					(pstate_entry_v2->nonClockInfoIndex * pnon_clock_arrays->ucEntrySiz=
e));
> =20
>  		result =3D init_non_clock_fields(hwmgr, ps, pnon_clock_arrays->ucEntry=
Size, pnon_clock_info);
> =20
>  		for (i =3D 0; i < pstate_entry_v2->ucNumDPMLevels; i++) {
> -			const void *pclock_info =3D (const void *)(
> -							(unsigned long)(pclock_arrays->clockInfo) +
> -							(pstate_entry_v2->clockInfoIndex[i] * pclock_arrays->ucEntrySize)=
);
> +			const void *pclock_info;
> +
> +			if (pstate_entry_v2->clockInfoIndex[i] >=3D
> +			    pclock_arrays->ucNumEntries)
> +				return -1;
> +
> +			clock_info_offset =3D clock_info_array_offset +
> +				offsetof(ClockInfoArray, clockInfo) +
> +				pstate_entry_v2->clockInfoIndex[i] * pclock_arrays->ucEntrySize;
> +			if (!pp_table_has_space(hwmgr, clock_info_offset,
> +						pclock_arrays->ucEntrySize))
> +				return -1;
> +
> +			pclock_info =3D (const void *)
> +					((unsigned long)(pclock_arrays->clockInfo) +
> +					(pstate_entry_v2->clockInfoIndex[i] *
> +					 pclock_arrays->ucEntrySize));
>  			res =3D func(hwmgr, &ps->hardware, i, pclock_info);
>  			if ((0 =3D=3D result) && (0 !=3D res))
>  				result =3D res;
>  		}
>  	} else {
> -		if (entry_index > powerplay_table->ucNumStates)
> +		if (entry_index >=3D powerplay_table->ucNumStates ||
> +		    !powerplay_table->ucStateEntrySize ||
> +		    !powerplay_table->ucNonClockSize ||
> +		    powerplay_table->ucNonClockSize < ATOM_PPLIB_NONCLOCKINFO_VER1 ||
> +		    (powerplay_table->ucNonClockSize > ATOM_PPLIB_NONCLOCKINFO_VER1 &&
> +		     powerplay_table->ucNonClockSize < ATOM_PPLIB_NONCLOCKINFO_VER2) ||
> +		    !powerplay_table->ucClockInfoSize)
> +			return -1;
> +
> +		state_array_offset =3D le16_to_cpu(powerplay_table->usStateArrayOffset=
);
> +		state_entry_offset =3D state_array_offset +
> +			entry_index * powerplay_table->ucStateEntrySize;
> +		if (!pp_table_has_space(hwmgr, state_entry_offset,
> +					powerplay_table->ucStateEntrySize))
>  			return -1;
> =20
>  		pstate_entry =3D (ATOM_PPLIB_STATE *)((unsigned long)powerplay_table +
> -						    le16_to_cpu(powerplay_table->usStateArrayOffset) +
> +						    state_array_offset +
>  						    entry_index * powerplay_table->ucStateEntrySize);
> =20
> +		non_clock_info_array_offset =3D
> +			le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset);
> +		non_clock_info_offset =3D non_clock_info_array_offset +
> +			pstate_entry->ucNonClockStateIndex * powerplay_table->ucNonClockSize;
> +		if (!pp_table_has_space(hwmgr, non_clock_info_offset,
> +					powerplay_table->ucNonClockSize))
> +			return -1;
> +
>  		pnon_clock_info =3D (ATOM_PPLIB_NONCLOCK_INFO *)((unsigned long)powerp=
lay_table +
> -						le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset) +
> +						non_clock_info_array_offset +
>  						pstate_entry->ucNonClockStateIndex *
>  						powerplay_table->ucNonClockSize);
> =20
> @@ -947,12 +1070,23 @@ int pp_tables_get_entry(struct pp_hwmgr *hwmgr,
>  							pnon_clock_info);
> =20
>  		for (i =3D 0; i < powerplay_table->ucStateEntrySize-1; i++) {
> -			const void *pclock_info =3D (const void *)((unsigned long)powerplay_t=
able +
> -						le16_to_cpu(powerplay_table->usClockInfoArrayOffset) +
> +			const void *pclock_info;
> +
> +			clock_info_array_offset =3D
> +				le16_to_cpu(powerplay_table->usClockInfoArrayOffset);
> +			clock_info_offset =3D clock_info_array_offset +
> +				pstate_entry->ucClockStateIndices[i] *
> +				powerplay_table->ucClockInfoSize;
> +			if (!pp_table_has_space(hwmgr, clock_info_offset,
> +						powerplay_table->ucClockInfoSize))
> +				return -1;
> +
> +			pclock_info =3D (const void *)((unsigned long)powerplay_table +
> +						clock_info_array_offset +
>  						pstate_entry->ucClockStateIndices[i] *
>  						powerplay_table->ucClockInfoSize);
> =20
> -			int res =3D func(hwmgr, &ps->hardware, i, pclock_info);
> +			res =3D func(hwmgr, &ps->hardware, i, pclock_info);
> =20
>  			if ((0 =3D=3D result) && (0 !=3D res))
>  					result =3D res;

[Severity: High]
Are the checks on pclock_arrays->ucEntrySize, powerplay_table->ucClockInfoS=
ize,
and the DPM level loop counts in pp_tables_get_entry() sufficient to prevent
out-of-bounds accesses in the clock info callbacks?

Unlike pnon_clock_arrays->ucEntrySize and powerplay_table->ucNonClockSize
(which are checked against ATOM_PPLIB_NONCLOCKINFO_VER1 and
ATOM_PPLIB_NONCLOCKINFO_VER2), pclock_arrays->ucEntrySize and
powerplay_table->ucClockInfoSize are only checked to be non-zero. If either
field is between 1 and 8 bytes at the end of hwmgr->soft_pp_table,
pp_table_has_space() succeeds, and when func is
smu7_get_pp_table_entry_callback_func_v0() in
drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c:

	const ATOM_PPLIB_CI_CLOCK_INFO *visland_clk_info =3D clock_info;
	...
	engine_clock =3D visland_clk_info->ucEngineClockHigh << 16 | visland_clk_i=
nfo->usEngineClockLow;
	memory_clock =3D visland_clk_info->ucMemoryClockHigh << 16 | visland_clk_i=
nfo->usMemoryClockLow;

it casts clock_info to const ATOM_PPLIB_CI_CLOCK_INFO * (9 bytes) and reads
up to 8 bytes past hwmgr->soft_pp_table.

In addition, the DPM level loops in pp_tables_get_entry() iterate i up to
pstate_entry_v2->ucNumDPMLevels or powerplay_table->ucStateEntrySize - 1
without bounding i against
hwmgr->platform_descriptor.hardwareActivityPerformanceLevels. When func is
smu8_dpm_get_pp_table_entry_callback() in
drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c:

	smu8_ps->levels[index].engineClock =3D table->entries[clock_info_index].cl=
k;
	smu8_ps->levels[index].vddcIndex =3D (uint8_t)table->entries[clock_info_in=
dex].v;

or smu10_dpm_get_pp_table_entry_callback() in
drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c:

	smu10_ps->levels[index].engine_clock =3D 0;

	smu10_ps->levels[index].vddc_index =3D 0;
	smu10_ps->level =3D index + 1;

can an uncapped index overflow smu8_ps->levels[SMU8_MAX_HARDWARE_POWERLEVEL=
S]
or smu10_ps->levels[SMU10_MAX_HARDWARE_POWERLEVELS] (both 8 entries)?

[ ... ]

> @@ -1705,6 +1888,10 @@ static int pp_tables_initialize(struct pp_hwmgr *h=
wmgr)
>  	hwmgr->need_pp_table_upload =3D true;
> =20
>  	powerplay_table =3D get_powerplay_table(hwmgr);
> +	PP_ASSERT_WITH_CODE((powerplay_table),
> +			    "Missing PowerPlay Table!", return -1);
> +	PP_ASSERT_WITH_CODE(pp_table_has_space(hwmgr, 0, sizeof(*powerplay_tabl=
e)),
> +			    "Invalid PowerPlay Table!", return -1);
> =20
>  	result =3D init_powerplay_tables(hwmgr, powerplay_table);
> =20

[Severity: High]
Does checking only sizeof(*powerplay_table) in pp_tables_initialize() leave
the remaining initialization helpers vulnerable to out-of-bounds reads when
powerplay_table->usTableSize or subtable offsets exceed
hwmgr->soft_pp_table_size?

After verifying pp_table_has_space(hwmgr, 0, sizeof(*powerplay_table)),
pp_tables_initialize() calls init_thermal_controller(),
init_overdrive_limits(), init_clock_voltage_dependency(),
init_dpm2_parameters(), and init_phase_shedding_table(). Those helpers check
powerplay_table->usTableSize against sizeof(ATOM_PPLIB_POWERPLAYTABLE3),
sizeof(ATOM_PPLIB_POWERPLAYTABLE4), or sizeof(ATOM_PPLIB_POWERPLAYTABLE5)
without verifying that hwmgr->soft_pp_table_size is large enough for those
structures or their subtables:

1. init_thermal_controller() checks powerplay_table->usTableSize >=3D
sizeof(ATOM_PPLIB_POWERPLAYTABLE3) and dereferences
powerplay_table3->usFanTableOffset up to ATOM_PPLIB_FANTABLE5 without
calling pp_table_has_space().

2. init_overdrive_limits() -> init_overdrive_limits_V2_1() and
init_dpm2_parameters() bypass get_extended_header() and directly dereference
usExtendendedHeaderOffset (and usPPMTableOffset in init_dpm2_parameters())
without bounds checks.

3. init_clock_voltage_dependency(), init_dpm2_parameters(), and
init_phase_shedding_table() dereference usVddcDependencyOnSCLKOffset,
usVddciDependencyOnMCLKOffset, usVddcDependencyOnMCLKOffset,
usMaxClockVoltageOnDCOffset, usMvddDependencyOnMCLKOffset,
usCACLeakageTableOffset, and usVddcPhaseShedLimitsTableOffset, along with
their variable-length entries[] arrays, without checking
pp_table_has_space().

!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-51-sashal@kernel.org?part=3D1
