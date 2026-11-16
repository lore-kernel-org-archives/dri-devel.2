Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F301606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LngrPGXx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD2210E96B;
	Mon, 16 Nov 2026 19:30:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A916F10E96B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:30:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 396674676F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B301F000C4;
 Mon, 16 Nov 2026 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794857403;
 bh=3aeORa2z57tIDr+KyaKP9GFrMlJXrmsYX1a/Xr4e2EQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=LngrPGXxBFYioPVMg4Q0N2NfoXQo2BXfAhYqXx9UPMUrr/87yTNaje4wHv2IuZ/hJ
 vs8hkZM6gAQqLto2LzGiZf9zqARV7uAEhRwT/CQhoR2D5ZogrB/Dqf+qfkX5nqmG3q
 skP+AwCZUG0d0VuU3dqr1Nlc+fb3ozRZgWcXNW7wwbbDECepxOcb1nQjkN7wRWuP/0
 T5Gy5XOB2wV3wIuFhhOx9UAz+4LTMgoFdeLQFF4FN0gEeBUXP58YZ17zThOZHm5A+1
 CRHbLZkTGYRfWPDA3+aOvenI16KNjIRm03htCDTRa44qik8d6yQa+re0Wpils0wXqG
 pAc7e2rbRe4zw==
Message-ID: <sashiko-outbox-217562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: linux-next: manual merge of the drm tree with the drm-fixes tree
To: "Mark Brown" <broonie@kernel.org>, DRI <dri-devel@lists.freedesktop.org>
In-Reply-To: <avtUOSIWVojTuTvx@sirena.org.uk>
References: <avtUOSIWVojTuTvx@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:30:02 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/xe: missing Signed-off-by trailer and unresolved template
  placeholders
- [High] drm/xe: undeclared fields and enum in xe_info_init_early() and
  descriptors
- [High] drm/xe: conflicting prototype for xe_pm_suspend() against
  xe_pm.h
- [High] drm/xe: calls to undeclared PM helpers in xe_pm_suspend() and
  resume paths
--

commit 9589bfc1c2e1387822d0222f3ab550943b103833
Author: Mark Brown <broonie@kernel.org>

> linux-next: manual merge of the drm tree with the drm-fixes tree
>
> Hi all,
>
> Today's linux-next merge of the drm tree got conflicts in:
>
>   drivers/gpu/drm/xe/xe_pci.c
>   drivers/gpu/drm/xe/xe_pm.c
>
> between commit:
>
> ???
>
> from the drm-fixes tree and commit:
>
> ???
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

[Severity: High]
The commit message is missing a Signed-off-by: trailer, leaves literal
"???" placeholders for the conflicting commits, and applies standalone
merge-resolution hunks without the underlying drm tree commits.

> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index 12ff5c9025478..3bd68ed9daa81 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -417,16 +417,17 @@ static const struct xe_device_desc bmg_desc =3D {
>  	.dma_mask_size =3D 46,
>  	.has_display =3D true,
>  	.has_fan_control =3D true,
> +	.has_fixed_vram_channels =3D true,
>  	.has_flat_ccs =3D 1,
>  	.has_mbx_power_limits =3D true,
>  	.has_mbx_thermal_info =3D true,
>  	.has_gsc_nvm =3D 1,
>  	.has_heci_cscfi =3D 1,
>  	.has_i2c =3D true,
> -	.has_late_bind =3D true,
>  	.has_pre_prod_wa =3D 1,
>  	.has_soc_remapper_telem =3D true,
>  	.has_sriov =3D true,
> +	.late_bind_mask =3D BIT(XE_LB_FW_FAN_CONTROL),
>  	.max_gt_per_tile =3D 2,
>  	MULTI_LRC_MASK,
>  	.needs_scratch =3D true,
> @@ -487,6 +488,8 @@ static const struct xe_device_desc cri_desc =3D {
>  	.has_sriov =3D true,
>  	.has_sysctrl =3D true,
>  	.has_temp_sentinel =3D true,
> +	.late_bind_mask =3D BIT(XE_LB_FW_FAN_CONTROL) |
> +			  BIT(XE_LB_FW_OCODE),
>  	.max_gt_per_tile =3D 2,
>  	MULTI_LRC_MASK,
>  	.require_force_probe =3D true,

[ ... ]

> @@ -798,6 +803,7 @@ static int xe_info_init_early(struct xe_device *xe,
>  	xe->info.has_device_uid =3D desc->has_device_uid;
>  	xe->info.has_drm_ras =3D desc->has_drm_ras;
>  	xe->info.has_fan_control =3D desc->has_fan_control;
> +	xe->info.has_fixed_vram_channels =3D desc->has_fixed_vram_channels;
>  	/* runtime fusing may force flat_ccs to disabled later */
>  	xe->info.has_flat_ccs =3D desc->has_flat_ccs;
>  	xe->info.has_mbx_power_limits =3D desc->has_mbx_power_limits;
> @@ -806,7 +812,6 @@ static int xe_info_init_early(struct xe_device *xe,
>  	xe->info.has_heci_gscfi =3D desc->has_heci_gscfi;
>  	xe->info.has_heci_cscfi =3D desc->has_heci_cscfi;
>  	xe->info.has_i2c =3D desc->has_i2c;
> -	xe->info.has_late_bind =3D desc->has_late_bind;
>  	xe->info.has_llc =3D desc->has_llc;
>  	xe->info.has_mert =3D desc->has_mert;
>  	xe->info.has_page_reclaim_hw_assist =3D desc->has_page_reclaim_hw_assis=
t;
> @@ -819,11 +824,13 @@ static int xe_info_init_early(struct xe_device *xe,
>  		desc->has_sriov;
>  	xe->info.has_sysctrl =3D desc->has_sysctrl;
>  	xe->info.has_temp_sentinel =3D desc->has_temp_sentinel;
> +	xe->info.require_force_probe =3D desc->require_force_probe;
>  	xe->info.skip_guc_pc =3D desc->skip_guc_pc;
>  	xe->info.skip_pcode =3D desc->skip_pcode;
>  	xe->info.needs_scratch =3D desc->needs_scratch;
>  	xe->info.needs_shared_vf_gt_wq =3D desc->needs_shared_vf_gt_wq;
>  	xe->info.multi_lrc_mask =3D desc->multi_lrc_mask;
> +	xe->info.late_bind_mask =3D desc->late_bind_mask;

[Severity: High]
Does this break the build by referencing undeclared struct members and
enum constants?

Neither struct xe_device_desc nor struct intel_device_info defines
has_fixed_vram_channels or late_bind_mask, struct intel_device_info has no
require_force_probe member, and enum xe_late_bind_fw_id does not define
XE_LB_FW_OCODE.  Removing the initialization of has_late_bind also leaves
xe->info.has_late_bind zero, causing xe_late_bind_init() to skip late-bind
firmware initialization.

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index d95f0d128ed49..e73192b03074a 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -166,13 +166,19 @@ static void xe_rpm_lockmap_release(const struct xe_=
device *xe)
>  			 &xe_pm_runtime_d3cold_map);
>  }
> =20
> +static bool xe_pm_needs_bo_evict(struct xe_device *xe, bool hibernate)
> +{
> +	return IS_DGFX(xe) || hibernate;
> +}
> +
>  /**
> - * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
> + * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle /=
 S0->S4
>   * @xe: xe device instance
> + * @hibernate: true if preparing for S4 hibernation, false for < S4 susp=
end
>   *
>   * Return: 0 on success
>   */
> -int xe_pm_suspend(struct xe_device *xe)
> +int xe_pm_suspend(struct xe_device *xe, bool hibernate)

[Severity: High]
Does adding the hibernate parameter to xe_pm_suspend() without updating
drivers/gpu/drm/xe/xe_pm.h break compilation?

xe_pm.h still declares int xe_pm_suspend(struct xe_device *xe), causing a
too-many-arguments error in __xe_pci_suspend() and a conflicting-types
error in xe_pm.c.

> @@ -186,17 +192,19 @@ int xe_pm_suspend(struct xe_device *xe)
>  	if (err)
>  		goto err;
> =20
> -	xe_late_bind_wait_for_worker_completion(&xe->late_bind);
> +	xe_late_bind_pm_suspend(&xe->late_bind);

[ ... ]

> @@ -249,7 +257,7 @@ int xe_pm_resume(struct xe_device *xe)
>  		xe_wa_apply_tile_workarounds(tile);
> =20
>  	for_each_gt(gt, xe, id)
> -		xe_gt_idle_disable_c6(gt);
> +		xe_gt_resume_early(gt);
> =20
>  	xe_display_pm_resume_early(xe);
> =20
> @@ -290,7 +298,7 @@ int xe_pm_resume(struct xe_device *xe)
>  	if (IS_VF_CCS_READY(xe))
>  		xe_sriov_vf_ccs_register_context(xe);
> =20
> -	xe_late_bind_fw_load(&xe->late_bind);
> +	xe_late_bind_pm_resume(&xe->late_bind);

[ ... ]

> @@ -707,7 +721,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>  			xe_wa_apply_tile_workarounds(tile);
> =20
>  		for_each_gt(gt, xe, id)
> -			xe_gt_idle_disable_c6(gt);
> +			xe_gt_resume_early(gt);
> =20
>  		xe_display_pm_resume_early(xe);
> =20
> @@ -755,7 +769,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>  		xe_sriov_vf_ccs_register_context(xe);
> =20
>  	if (xe->d3cold.allowed)
> -		xe_late_bind_fw_load(&xe->late_bind);
> +		xe_late_bind_pm_resume(&xe->late_bind);

[Severity: High]
Are xe_late_bind_pm_suspend(), xe_late_bind_pm_resume(), and
xe_gt_resume_early() missing from the tree?

None of these helpers are declared in xe_late_bind_fw.h or xe_gt.h or
defined anywhere in the tree, so compiling xe_pm.c fails with implicit
function declaration errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/avtUOSIWVojTuTvx@si=
rena.org.uk?part=3D1
