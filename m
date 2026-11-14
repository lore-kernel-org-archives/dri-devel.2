Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9C606A898
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHXwyMRa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC0B10EC15;
	Sat, 14 Nov 2026 03:31:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130B489091;
 Sat, 14 Nov 2026 03:31:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3510467BE;
 Sat, 14 Nov 2026 03:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8031F000C4;
 Sat, 14 Nov 2026 03:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794627101;
 bh=TD324dSPzOSVtrbAGqBfjsp768XIuMRBD3uusT7REdY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OHXwyMRa206h6ZkNJjQA7hlH7xCJDqcqjhj1x1VxNe0bSf0rgD0d5isvhXK4XTRIq
 maJmDw9SzueW7/O2FYT7mEVu36mQMJufKsnvTdRLbkKxxNyeKhuwN09gsS+wFHu5pi
 zbq+u7vPuDlUBp7Oo1Zw54doPL+nxYZ/Bo6lnIguxXMJthJLtxs25giHoU0EJMAulC
 hFD9S08hOKJLxoFrrDB3swSfDpI2Z54BLznu9awEPF0q635nq1f4ALKLO+3BSOq7iZ
 rhgRPZPgH/olLMGZh5JaO69Bb3ogR36KiKdVuKbfM6YIXfXc3bAZ5ZloLxxQp9wnEr
 KNn183s+bv8BA==
Message-ID: <sashiko-outbox-214116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/amd/pm: allow editing the smu8 overdrive sclk
 table
To: "Joshua Horne" <hornejd@etsu.edu>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261113-smu8-overdrive-v1-4-763f07bdfca9@etsu.edu>
References: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
 <20261113-smu8-overdrive-v1-4-763f07bdfca9@etsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:31:41 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amd/pm: stale SclkHardMin level after
  smu8_od_upload_sclk_table()
- [Medium] drm/amd/pm: fractional boundary clocks rejected in
  smu8_od_edit_sclk_level()
--

commit f271cff6b522292ee10f53b957a90f73690433ee
Author: Joshua Horne <hornejd@etsu.edu>

drm/amd/pm: allow editing the smu8 overdrive sclk table

This commit implements pp_od_clk_voltage editing, reset, and commit
commands for the SMU8 SCLK OverDrive table on Carrizo and Stoney.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 93a7e7e176f37..c6045234965c0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -860,10 +860,86 @@ static void smu8_populate_umdpstate_clocks(struct p=
p_hwmgr *hwmgr)

[ ... ]

> +static int smu8_od_upload_sclk_table(struct pp_hwmgr *hwmgr)
> +{
> +	struct smu8_hwmgr *data =3D hwmgr->backend;
> +	const struct phm_odn_clock_levels *od =3D &data->od_edit_sclk;
> +	struct phm_clock_voltage_dependency_table *vddc_table =3D
> +				hwmgr->dyn_state.vddc_dependency_on_sclk;
> +	struct phm_clock_voltage_dependency_table *vdd_gfx_table =3D
> +				hwmgr->dyn_state.vdd_gfx_dependency_on_sclk;
> +	struct pp_power_state *ps;
> +	uint32_t i;
> +
> +	data->od_update_pending =3D false;
> +
> +	/* the power states refer to the levels by clock, update them first */
> +	ps =3D hwmgr->ps;
> +	for (i =3D 0; i < hwmgr->num_ps; i++) {
> +		smu8_od_update_power_state(hwmgr, ps);
> +		ps =3D (struct pp_power_state *)
> +			((unsigned long)ps + hwmgr->ps_size);
> +	}
> +	smu8_od_update_power_state(hwmgr, hwmgr->current_ps);
> +	smu8_od_update_power_state(hwmgr, hwmgr->request_ps);
> +
> +	/* the NB voltages (GnbVid) of the levels are left untouched */
> +	for (i =3D 0; i < od->num_of_pl; i++) {
> +		vddc_table->entries[i].clk =3D od->entries[i].clock;
> +		vdd_gfx_table->entries[i].clk =3D od->entries[i].clock;
> +		vdd_gfx_table->entries[i].v =3D
> +			convert_to_vid(od->entries[i].vddc);
> +	}
> +
> +	smu8_populate_umdpstate_clocks(hwmgr);
> +
> +	/*
> +	 * The SMU switches to the new clock and voltage of a level the next
> +	 * time it enters that level.
> +	 */
> +	return smu8_upload_pptable_to_smu(hwmgr);
> +}
> +
>  static int smu8_set_power_state_tasks(struct pp_hwmgr *hwmgr, const void=
 *input)
>  {
> +	struct smu8_hwmgr *data =3D hwmgr->backend;
>  	int ret =3D 0;
> =20
> +	if (data->od_update_pending) {
> +		ret =3D smu8_od_upload_sclk_table(hwmgr);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	smu8_update_sclk_limit(hwmgr);

[Severity: Medium]
Does smu8_update_sclk_limit() skip updating PPSMC_MSG_SetSclkHardMin on
the SMU after smu8_od_upload_sclk_table() modifies
vddc_dependency_on_sclk?

smu8_update_sclk_limit() resolves hwmgr->display_config->min_core_set_clock
against vddc_dependency_on_sclk via smu8_get_sclk_level(), but only sends
PPSMC_MSG_SetSclkHardMin when data->sclk_dpm.hard_min_clk differs from
min_core_set_clock:

drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c:smu8_update_sclk_limit(=
) {
	...
	clock =3D hwmgr->display_config->min_core_set_clock;
	if (clock =3D=3D 0)
		pr_debug("min_core_set_clock not set\n");

	if (data->sclk_dpm.hard_min_clk !=3D clock) {
		data->sclk_dpm.hard_min_clk =3D clock;

		smum_send_msg_to_smc_with_parameter(hwmgr,
						PPSMC_MSG_SetSclkHardMin,
						 smu8_get_sclk_level(hwmgr,
					data->sclk_dpm.hard_min_clk,
					     PPSMC_MSG_SetSclkHardMin),
						 NULL);
	}
	...
}

When committing an OverDrive edit while min_core_set_clock is unchanged,
data->sclk_dpm.hard_min_clk already equals clock, so the SMU keeps the old
DPM level index even if the edited frequencies shift which level satisfies
min_core_set_clock, allowing SCLK to drop below the display minimum or
staying pinned higher than needed.  Invalidating
data->sclk_dpm.hard_min_clk in smu8_od_upload_sclk_table() would force
smu8_update_sclk_limit() to resend the updated level.

[ ... ]

> @@ -2057,6 +2133,145 @@ static void smu8_dpm_powergate_vce(struct pp_hwmg=
r *hwmgr, bool bgate)
>  	}
>  }
> =20
> +/* the engine clock that the PLL produces for @clk */
> +static uint32_t smu8_od_real_sclk(struct pp_hwmgr *hwmgr, uint32_t clk)
> +{
> +	pp_atomctrl_clock_dividers_kong dividers;
> +
> +	if (atomctrl_get_engine_pll_dividers_kong(hwmgr, clk, &dividers) ||
> +	    !dividers.real_clock)
> +		return clk;
> +
> +	return dividers.real_clock;
> +}
> +
> +static int smu8_od_edit_sclk_level(struct pp_hwmgr *hwmgr,
> +				   struct phm_odn_clock_levels *od,
> +				   long level, long mhz, long mv)
> +{
> +	struct smu8_hwmgr *data =3D hwmgr->backend;
> +	struct amdgpu_device *adev =3D hwmgr->adev;
> +	uint32_t min_clk, max_clk, clk;
> +
> +	min_clk =3D data->od_default_sclk.entries[0].clock;
> +	max_clk =3D hwmgr->platform_descriptor.overdriveLimit.engineClock;
> +
> +	if (level < 0 || level >=3D od->num_of_pl) {
> +		dev_info(adev->dev,
> +			 "OD sclk level %ld is out of range [0 - %u]\n",
> +			 level, od->num_of_pl - 1);
> +		return -EINVAL;
> +	}
> +
> +	if (mhz < min_clk / 100 || mhz > max_clk / 100) {
> +		dev_info(adev->dev,
> +			 "OD engine clock is out of range [%u - %u] MHz\n",
> +			 min_clk / 100, max_clk / 100);
> +		return -EINVAL;
> +	}
> +
> +	if (mv < data->od_min_vddc || mv > data->od_max_vddc) {
> +		dev_info(adev->dev, "OD voltage is out of range [%u - %u] mV\n",
> +			 data->od_min_vddc, data->od_max_vddc);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * OD_SCLK shows whole MHz, so keep the exact clock of a level that is
> +	 * written back unchanged. Otherwise use the clock the PLL produces.
> +	 */
> +	clk =3D mhz * 100;
> +	if (clk =3D=3D od->entries[level].clock / 100 * 100)
> +		clk =3D od->entries[level].clock;
> +	else
> +		clk =3D smu8_od_real_sclk(hwmgr, clk);
> +
> +	if (clk < min_clk || clk > max_clk) {
> +		dev_info(adev->dev,
> +			 "OD engine clock %u.%02u MHz is out of range\n",
> +			 clk / 100, clk % 100);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Can smu8_od_edit_sclk_level() reject the minimum MHz shown in OD_RANGE when
min_clk has a non-zero fractional MHz part (min_clk % 100 !=3D 0)?

On Carrizo and Stoney, VBIOS clocks are stored in 10 kHz units and often
have fractional MHz values (such as 30476 for 304.76 MHz), while OD_RANGE
and OD_SCLK print truncated whole MHz (min_clk / 100).  Once level 0 is
edited to another frequency, writing back mhz =3D min_clk / 100 no longer
matches od->entries[level].clock / 100 * 100, so clk =3D (min_clk / 100) * =
100
is passed to smu8_od_real_sclk().  Because that input is already strictly
less than min_clk and ComputeMemoryEnginePLL rounds down to the nearest PLL
step, the resulting clk is below min_clk and fails the clk < min_clk check
with -EINVAL.  Similarly, when max_clk % 100 !=3D 0, writing max_clk / 100
after an edit passes (max_clk / 100) * 100 < max_clk to smu8_od_real_sclk()
and cannot reach the max_clk PLL step.

Checking data->od_default_sclk.entries[level].clock (as well as min_clk and
max_clk) for a whole-MHz match before calling smu8_od_real_sclk() would
allow restoring a level's default or boundary clock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-smu8-overd=
rive-v1-0-763f07bdfca9@etsu.edu?part=3D4
