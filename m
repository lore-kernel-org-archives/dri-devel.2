Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D960874B4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIZhrVfM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1051C10EE50;
	Mon, 19 Oct 2026 15:09:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62EB10EE50
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:09:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D820E6025F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6141F000C4;
 Mon, 19 Oct 2026 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792422580;
 bh=roqFsrmWh5KsYM1BDHdV1UCk4WdBCkWuUMHIXEdcXhQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KIZhrVfMsmCZGonAaNlX9pNjF/qVfuqUPpCGiu8wujhWOK7HCxD54oNL/gZdRPXYr
 g4GdDQ5CKcJWNYHqaB/HQRRePDIO87AYzY4Ls7HtcG/rG71n2KuAkXEk2ec3X7g/Sa
 aJEgcVNQQPtPuaSDRiPv6gdEdcC6wqUcA3ZHLxmShQwsHWAfSZqfAAD49/ABFqfyUQ
 68ODfYEEHOQS2f2/3CperFC8mCLBFV0U2cLTD+LQ72GAbVIxbrr+wPsxCti0CBLbgy
 HpqCqt5DEsC+fwnscSNsLRHSAsmVfjepfqbDHh2WdDbzVuc4S54FYZio6xePfT5E9o
 kLUD0AazzkOcw==
Message-ID: <sashiko-outbox-177626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/amdgpu: Gate debugfs MMIO access
 on kernel lockdown
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-351-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-351-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:09:39 +0000
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: init-only lockdown check in amdgpu_debugfs_regs_init=
() bypassed
--

commit d191beaf95739f7c453353f0fddff9c76024a56e
Author: Asad Kamal <asad.kamal@amd.com>

drm/amdgpu: Gate debugfs MMIO access on kernel lockdown

This commit skips creating hardware register debugfs nodes in
amdgpu_debugfs_regs_init() when kernel lockdown (LOCKDOWN_PCI_ACCESS) is
active during initialization.

>     drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
>    =20
>     [ Upstream commit 17ac73b24006700f50972d37e297dec1f523c14a ]
>    =20
>     amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow
>     arbitrary MMIO read/write via RREG32/WREG32 without checking
>     security_locked_down(). On kernel_lockdown=3Dintegrity systems
>     this bypasses the same restrictions as /dev/mem and PCI config
>     space sysfs.
>    =20
>     Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
>     debugfs handler that performs direct register access.
>    =20
>     v2: Use consistent check as per previous check to use
>     LOCKDOWN_DEBUGFS(Lijo)
>    =20
>     v3: Do not create any entry from amdgpu_debugfs_regs_init() if
>     LOCKDOWN_PCI_ACCESS is active and log once. (Lijo)
>    =20
>     Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>     Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index a70651050acff..5dac8f0f34143 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c

[ ... ]

> @@ -1646,6 +1647,12 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device =
*adev)
>  	struct dentry *ent, *root =3D minor->debugfs_root;
>  	unsigned int i;
> =20
> +	if (security_locked_down(LOCKDOWN_PCI_ACCESS)) {
> +		drm_info(adev_to_drm(adev),
> +			 "amdgpu: HW debugfs nodes disabled (kernel lockdown)\n");
> +		return 0;
> +	}
> +
>  	for (i =3D 0; i < ARRAY_SIZE(debugfs_regs); i++) {
>  		ent =3D debugfs_create_file(debugfs_regs_names[i],
>  					  S_IFREG | 0400, root,

[Severity: Medium]
Can this lockdown check be bypassed when kernel lockdown is enabled at
runtime after the driver has already probed?

If amdgpu initializes before lockdown is enabled (for example, when built-in
or loaded from initramfs) and userspace later enables integrity or
confidentiality lockdown by writing to /sys/kernel/security/lockdown via
lockdown_write() -> lock_kernel_down(), amdgpu_debugfs_regs_init() has
already created the debugfs_regs files with mode 0400:

security/lockdown/lockdown.c:lockdown_write() {
	...
		if (label && !strcmp(state, label))
			err =3D lock_kernel_down("securityfs", level);
	...
}

Because amdgpu_regs, amdgpu_regs_didt, amdgpu_regs_pcie, amdgpu_regs_smc,
amdgpu_wave, and amdgpu_gpr have mode 0400 and their file_operations structs
do not define .unlocked_ioctl, .compat_ioctl, or .mmap, opening them with
O_RDONLY is permitted by debugfs_locked_down() without consulting
security_locked_down(LOCKDOWN_DEBUGFS):

fs/debugfs/file.c:debugfs_locked_down() {
	if ((inode->i_mode & 07777 & ~0444) =3D=3D 0 &&
	    !(filp->f_mode & FMODE_WRITE) &&
	    (!real_fops ||
	     (!real_fops->unlocked_ioctl &&
	      !real_fops->compat_ioctl &&
	      !real_fops->mmap)))
		return 0;

	if (security_locked_down(LOCKDOWN_DEBUGFS))
		return -EPERM;

	return 0;
}

Subsequent read() calls then reach amdgpu_debugfs_process_reg_op() and its
sibling handlers with no security_locked_down(LOCKDOWN_PCI_ACCESS) check,
allowing arbitrary RREG32() reads as well as MMIO writes to bank and index
selection registers such as GRBM_GFX_INDEX via amdgpu_gfx_select_se_sh() and
SRBM_GFX_CNTL via amdgpu_gfx_select_me_pipe_q(). In addition, any file
descriptor opened O_RDWR before lockdown was activated retains unrestricted
MMIO write and ioctl access (WREG32() / amdgpu_mm_wreg_mmio_rlc()) after
lockdown is enabled.

Also, the commit message body still states:

  "Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
   debugfs handler that performs direct register access."

Should security_locked_down(LOCKDOWN_PCI_ACCESS) also be checked in the
debugfs file operations handlers (or should the commit message be updated to
match the v3 implementation)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-351-sashal@kernel.org?part=3D1
