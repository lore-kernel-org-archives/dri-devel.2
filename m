Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225F5CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561D910EDD0;
	Mon,  8 Jun 2026 07:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lDqoPIPL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEDF10EDCA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:00:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC68C40211;
 Mon,  8 Jun 2026 07:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F801F00893;
 Mon,  8 Jun 2026 07:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780902024;
 bh=54JH6oQEsqXAe2uRzJ+QJIjaTrcR8lWjBghY7iGxU3w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lDqoPIPL7y8wjrH5Lw/5HUbsEuRM26iovjFGmqQJ90xRv6KOHgBx8jgObIdNVWmE2
 gi+7nl0Sy5UoBSNIZKXkLb7Y88rsQC4+nrreVyRC2Y3V5W+5bq4pVDUgGcZMRAAvDU
 LgTMpsY0XBIFi7i12yNhBH7J0Qc63NGG8hRKFH1owsUWGFGzgIvapL3s2h0R9MTBey
 e7lMNGIu7RWMlWgDLNqVPa9tSTwdD9tdRYXW1MSFnwQ+6M6NO9cbLbCx97RC/Zqs1Y
 EMUZLNmU5uQvjN0ScxDKD/Z3P/Lg3KELwTaFS8jX6zNF9SZhZ6XezzJdzAy7KirtaD
 Rro+6ElbzpDbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/radeon: avoid double free in r600 DPM cleanup
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608063638.24-1-ruoyuw560@gmail.com>
References: <20260608063638.24-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:00:23 +0000
Message-Id: <20260608070024.64F801F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The return value of `radeon_dpm_init(rdev)` is ignored, leadin=
g to Use-After-Free and Double Free when initialization fails.
- [High] Stale array count fields lead to NULL pointer dereferences in down=
stream code.
--

commit ba5366568de66db75291f2bdbc278766341645c9
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/radeon: avoid double free in r600 DPM cleanup
   =20
r600_parse_extended_power_table() uses manual kfree() calls for some
early allocation failures, but the freed pointers are left in the
dynamic power-management state. If device teardown later calls
r600_free_extended_power_table(), those stale pointers can be freed
again.

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

[Severity: Critical]
This is a pre-existing issue, but does the error handling in
radeon_pm_init_dpm() properly handle failures when these tables are freed?

It appears that the return value of radeon_dpm_init(rdev) is entirely ignor=
ed
in radeon_pm_init_dpm(). If initialization fails (e.g., in ci_dpm_init()
where it frees rdev->pm.dpm.priv via kfree()), the error is discarded and
the driver proceeds to execute radeon_dpm_setup_asic(rdev).

Downstream functions like ci_read_clock_registers() then retrieve the priv
pointer and write to it, resulting in a Use-After-Free:

drivers/gpu/drm/radeon/ci_dpm.c:ci_read_clock_registers() {
    struct ci_power_info *pi =3D ci_get_pi(rdev);
    ...
    pi->clock_registers.cg_spll_func_cntl =3D RREG32_SMC(CG_SPLL_FUNC_CNTL);
    ...
}

Additionally, upon driver removal, ci_dpm_fini() unconditionally calls
kfree(rdev->pm.dpm.priv), causing a double free.

[Severity: High]
This isn't a bug introduced by this patch, but does setting the entries
pointer to NULL without clearing the corresponding count field introduce a
NULL pointer dereference?

Because radeon_pm_init_dpm() ignores initialization failures, the driver
continues and calls functions like ci_populate_smc_initial_state() which
iterate based on the stale count field:

drivers/gpu/drm/radeon/ci_dpm.c:ci_populate_smc_initial_state() {
    ...
    for (level =3D 0;
         level < rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk.count;
         level++) {
        if (rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk.entries[level]...
    ...
}

Could the count fields also be set to 0 when freeing the entries? For examp=
le:
	dyn_state->vddc_dependency_on_sclk.count =3D 0;

>  	kfree(dyn_state->vddci_dependency_on_mclk.entries);
> +	dyn_state->vddci_dependency_on_mclk.entries =3D NULL;
>  	kfree(dyn_state->vddc_dependency_on_mclk.entries);
> +	dyn_state->vddc_dependency_on_mclk.entries =3D NULL;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608063638.24-1=
-ruoyuw560@gmail.com?part=3D1
