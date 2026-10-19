Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D5606DA74
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVDV+q6K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37DB10EA4F;
	Mon, 19 Oct 2026 15:33:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1241410ED79
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:33:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3418A60DD2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E351F031CF;
 Mon, 19 Oct 2026 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423982;
 bh=IqhzRSHkmOdXqmT+YpksD6QKQK4dECrOWN3hlFWRoV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AVDV+q6KzEOwj//RJ/C3ChnVqWFIimqtqfbqWlQ1qU8eNhLpGhtZ4iJKI9RIwJ4xf
 EQgvFMCjLbmt6cn8qHk7YXgAFs4dXRkJLIAfJE0Mxi/440YIBwB3fjIjIMDFJA/S8z
 YubyazgT2faGtd17nI4zh4nxzawjypQ4CwbrjyKLLb9ba40yinvgL9cODTzFg+Txf1
 8RGsD7fGI72FOMgCDNy7RXPzp7VN7ZI+9YZL3llPCCUswgJhkAUl4tAZmd5jCcllVW
 BSnrDAbNo9VaSF3To1Ke2znv+1ygilJD40P2q5+rRavlF1AnNiQBulxoenSvcEFTEl
 EsmUwHXrLlgwA==
Message-ID: <sashiko-outbox-177753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/radeon: avoid double free in r600
 DPM cleanup
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-499-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-499-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:33:02 +0000
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
- [High] drm/radeon: NULL deref from unreset count in r600_free_extended_po=
wer_table()
--

commit 562fae6c1a6edce2a058cd93a6a7a25a9b89c369
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/radeon: avoid double free in r600 DPM cleanup

This commit replaces manual kfree() calls on early error paths in
r600_parse_extended_power_table() with r600_free_extended_power_table() and
clears the freed table pointers to NULL so repeated cleanup does not
double-free them.

> diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r=
600_dpm.c
> index 81d58ef667dd4..2bc0bdfd11590 100644
> --- a/drivers/gpu/drm/radeon/r600_dpm.c
> +++ b/drivers/gpu/drm/radeon/r600_dpm.c

[ ... ]

> @@ -1298,17 +1295,29 @@ void r600_free_extended_power_table(struct radeon=
_device *rdev)
>  	struct radeon_dpm_dynamic_state *dyn_state =3D &rdev->pm.dpm.dyn_state;
> =20
>  	kfree(dyn_state->vddc_dependency_on_sclk.entries);
> +	dyn_state->vddc_dependency_on_sclk.entries =3D NULL;
>  	kfree(dyn_state->vddci_dependency_on_mclk.entries);
> +	dyn_state->vddci_dependency_on_mclk.entries =3D NULL;
>  	kfree(dyn_state->vddc_dependency_on_mclk.entries);
> +	dyn_state->vddc_dependency_on_mclk.entries =3D NULL;
>  	kfree(dyn_state->mvdd_dependency_on_mclk.entries);
> +	dyn_state->mvdd_dependency_on_mclk.entries =3D NULL;
>  	kfree(dyn_state->cac_leakage_table.entries);
> +	dyn_state->cac_leakage_table.entries =3D NULL;
>  	kfree(dyn_state->phase_shedding_limits_table.entries);
> +	dyn_state->phase_shedding_limits_table.entries =3D NULL;
>  	kfree(dyn_state->ppm_table);
> +	dyn_state->ppm_table =3D NULL;
>  	kfree(dyn_state->cac_tdp_table);
> +	dyn_state->cac_tdp_table =3D NULL;
>  	kfree(dyn_state->vce_clock_voltage_dependency_table.entries);
> +	dyn_state->vce_clock_voltage_dependency_table.entries =3D NULL;
>  	kfree(dyn_state->uvd_clock_voltage_dependency_table.entries);
> +	dyn_state->uvd_clock_voltage_dependency_table.entries =3D NULL;
>  	kfree(dyn_state->samu_clock_voltage_dependency_table.entries);
> +	dyn_state->samu_clock_voltage_dependency_table.entries =3D NULL;
>  	kfree(dyn_state->acp_clock_voltage_dependency_table.entries);
> +	dyn_state->acp_clock_voltage_dependency_table.entries =3D NULL;
>  }

[Severity: High]
Should r600_free_extended_power_table() also reset the corresponding
table->count fields to 0 when clearing the entries pointers to NULL?

When r600_parse_extended_power_table() parses an early table (for example v=
ia
r600_parse_clk_voltage_dep_table()), it allocates table->entries and sets
table->count:

drivers/gpu/drm/radeon/r600_dpm.c:r600_parse_clk_voltage_dep_table() {
	...
	radeon_table->count =3D atom_table->ucNumEntries;

	return 0;
}

If a subsequent allocation in r600_parse_extended_power_table() or in the
caller's *_dpm_init() path fails, r600_free_extended_power_table() now sets
each table's entries pointer to NULL while leaving its count field non-zero.

Because radeon_pm_init_dpm() ignores the return value of radeon_dpm_init()
and continues into radeon_dpm_setup_asic() and radeon_dpm_enable():

drivers/gpu/drm/radeon/radeon_pm.c:radeon_pm_init_dpm() {
	...
	mutex_lock(&rdev->pm.mutex);
	radeon_dpm_init(rdev);
	rdev->pm.dpm.current_ps =3D rdev->pm.dpm.requested_ps =3D rdev->pm.dpm.boo=
t_ps;
	if (radeon_dpm =3D=3D 1)
		radeon_dpm_print_power_states(rdev);
	radeon_dpm_setup_asic(rdev);
	ret =3D radeon_dpm_enable(rdev);
	...
}

downstream DPM routines such as kv_init_graphics_levels() and
btc_apply_voltage_dependency_rules() check only whether table->count is
non-zero before indexing table->entries[i]:

drivers/gpu/drm/radeon/kv_dpm.c:kv_init_graphics_levels() {
	...
	if (table && table->count) {
		u32 vid_2bit;

		pi->graphics_dpm_level_count =3D 0;
		for (i =3D 0; i < table->count; i++) {
			if (pi->high_voltage_t &&
			    (pi->high_voltage_t <
			     kv_convert_8bit_index_to_voltage(rdev, table->entries[i].v)))
				break;
	...
}

drivers/gpu/drm/radeon/btc_dpm.c:btc_apply_voltage_dependency_rules() {
	...
	if ((table =3D=3D NULL) || (table->count =3D=3D 0))
		return;

	for (i =3D 0; i < table->count; i++) {
		if (clock <=3D table->entries[i].clk) {
	...
}

Can this cause a NULL pointer dereference on table->entries when DPM setup =
or
enable runs after a partial parse failure?

 Resetting the paired count fields to 0 alongside clearing entries in
r600_free_extended_power_table() would keep the table state consistent.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-499-sashal@kernel.org?part=3D1
