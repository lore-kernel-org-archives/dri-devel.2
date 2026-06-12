Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB45CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C627110E9A8;
	Fri, 12 Jun 2026 08:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iPgGccYC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC23210E9A8
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:23:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAD9F435A9;
 Fri, 12 Jun 2026 08:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B78C1F000E9;
 Fri, 12 Jun 2026 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781252621;
 bh=5QnAAYK5C4mJuONvZFBLTu/yv6lt+0AN9q7ra6wq49k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iPgGccYCIEhVvMykeee0/KgTqGezqs1GSyAiUqfT24MOCX83acIF4ld3A0RIOp03K
 Kt8+kS5rEDi5DFbgjoWuWbGWi4tiwDdYkygh/VzSaCgYCOZL6Edimw9utsWTDYlMTt
 /S+iZmiuhNHR6BwUhJBnx7aLBwo/sINthhvOiddBiByVUVyVV3by0Z1CagpviC9u2C
 dafPTaP2QCAsSKn/oMVIv72LhYZB1WYswWCrRTqxLI525eNS8HhF6X//VwOh03BeoD
 YSPyQdnej+kNcbe810yu+CzILzzbuT92THAy+0H3QUGhHdyypvpk7DVqBe36kjVIeY
 eJLfY4z7MuKCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] drm/xe/ras: Add debugfs entry to inject punit error
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612080722.26726-14-mallesh.koujalagi@intel.com>
References: <20260612080722.26726-14-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 08:23:40 +0000
Message-Id: <20260612082341.1B78C1F000E9@smtp.kernel.org>
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
- [Medium] Unconditional registration of the `inject_punit_error` debugfs f=
ile exposes PF-only hardware operations to Virtual Functions (VFs) and igno=
res sysctrl capability checks.
- [Low] Missing forward declaration of `struct dentry` in `xe_ras.h` when `=
CONFIG_DRM_XE_DEBUG` is disabled.
--

commit 185b28acb4e5add829b3fd14f6a6416e4d2a9fe3
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe/ras: Add debugfs entry to inject punit error
   =20
Add a write-only debugfs file 'inject_punit_error' under the DRI device
root that allows triggering punit_error_handler() manually for testing.
Writing 1 to the file invokes the handler, which suppresses spurious
Surprise Link Down AER events on slots and declares the
device wedged for a cold reset recovery.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 15c2fa0d323a6..281ef4dce2188 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> +void xe_ras_debugfs_register(struct xe_device *xe, struct dentry *root)
> +{
> +	debugfs_create_file("inject_punit_error", 0200, root, xe,
> +			    &inject_punit_error_fops);

[Severity: Medium]
Could this expose PF-only hardware operations to Virtual Functions (VFs)?

Writing to this debugfs file executes punit_error_handler(), which
manipulates the physical AER configuration on the Upstream Switch Port (USP)
via PCI config space and triggers a PCIe cold reset. According to SR-IOV
constraints, VFs must not access PF-only hardware resources like physical
PCIe bridge configurations.

Additionally, this doesn't check if the device actually supports sysctrl
before allowing the error injection. Should this function include an early
return guard like if (IS_SRIOV_VF(xe) || !xe->info.has_sysctrl) before
creating the file?

> +}
> +#endif /* CONFIG_DRM_XE_DEBUG */
[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> index 8d106c708ff19..c9f84ef238c42 100644
> --- a/drivers/gpu/drm/xe/xe_ras.h
> +++ b/drivers/gpu/drm/xe/xe_ras.h
> @@ -16,4 +16,11 @@ void xe_ras_counter_threshold_crossed(struct xe_device=
 *xe,
>  void xe_ras_init(struct xe_device *xe);
>  enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe);
> =20
> +#ifdef CONFIG_DRM_XE_DEBUG
> +struct dentry;
> +void xe_ras_debugfs_register(struct xe_device *xe, struct dentry *root);
> +#else
> +static inline void xe_ras_debugfs_register(struct xe_device *xe, struct =
dentry *root) {}

[Severity: Low]
Does this cause a compiler warning when CONFIG_DRM_XE_DEBUG is disabled?

The forward declaration of struct dentry is inside the #ifdef block, but the
#else block uses struct dentry * in the parameter list of the static inline
function. In C, this scopes the struct declaration to the function prototype
itself if it wasn't previously declared.

Should the struct dentry; forward declaration be moved outside the #ifdef
block to ensure it is visible to the inline stub?

> +#endif
> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612080722.2672=
6-8-mallesh.koujalagi@intel.com?part=3D6
