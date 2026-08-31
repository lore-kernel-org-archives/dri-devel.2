Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9217C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E9510E524;
	Mon, 31 Aug 2026 16:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dmuBBn2v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D9510E524
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:46:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE09941366
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671701F000E9;
 Mon, 31 Aug 2026 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788194813;
 bh=OM9LZqTe5oWrT/bfnt+26LVRj6sHcEU9iAq1MOo2Kvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dmuBBn2v+UFOAXUiZCYGMhxYIGsEiFl/ZW2u7FSbTqo9JOd9fVTpimQfQeiUMtQJk
 3oS4wdFN1XB5LsqRkz0zRyRQP5m3vLKWcMDiNE9HAX3tscKQVN+O8VP1x9Ssfge0kE
 cO0FZ251hqRHEYhl0BxR8lZhKmzHE8PltcDdTmSGurqUY+xVaePXKzTFcz0jO9QHCv
 ZOeG/Kl5uOgLpn+kh4VuEzqzhXGSINuGhDSih2CKEm3SgSt8UaVpI7KFLHFJi3tK7G
 WgWTGLeI4LZF0+ciTkf8rOXbq2p229Q9sl31pVYGCZfaQZjGS338QPIZW6ZnbUAF1H
 dACHF38GGENjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/amd/pm: bound
 pp_dpm_set_pp_table() memcpy
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-496-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-496-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:46:53 +0000
Message-Id: <20260831164653.671701F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless read of pp_table in sysfs read path leads to a data race =
and potential Use-After-Free.
--

commit cc5f41b8e67512361c9df1ffb3561029e8d4a97e
Author: Asad Kamal <asad.kamal@amd.com>

drm/amd/pm: bound pp_dpm_set_pp_table() memcpy

This commit adds a bounds check to pp_dpm_set_pp_table() to prevent a heap
overflow when uploading a powerplay table via sysfs. It rejects writes where
the provided size exceeds soft_pp_table_size.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/pm/powerplay/amd_powerplay.c
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -665,6 +665,9 @@ static int pp_dpm_set_pp_table(void *handle, const ch=
ar *buf, size_t size)
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> =20
> +	if (size > hwmgr->soft_pp_table_size)
> +		return -EINVAL;
> +
>  	if (!hwmgr->hardcode_pp_table) {
>  		hwmgr->hardcode_pp_table =3D kmemdup(hwmgr->soft_pp_table,
>  						   hwmgr->soft_pp_table_size,
>  						   GFP_KERNEL);
>  		if (!hwmgr->hardcode_pp_table)
>  			return ret;
>  	}
>=20
>  	memcpy(hwmgr->hardcode_pp_table, buf, size);

[Severity: High]
This is a pre-existing issue, but does this sysfs write path race with
concurrent readers?

Looking at the sysfs read path in amdgpu_get_pp_table() in
drivers/gpu/drm/amd/pm/amdgpu_pm.c, the table is read locklessly after brie=
fly
holding the mutex to fetch the pointer:

drivers/gpu/drm/amd/pm/amdgpu_pm.c:amdgpu_get_pp_table() {
        ...
        mutex_lock(&adev->pm.mutex);
        size =3D amdgpu_dpm_get_pp_table(adev, &table);
        mutex_unlock(&adev->pm.mutex);

        if (size >=3D PAGE_SIZE)
                return -EIO;

        memcpy(buf, table, size);
        ...
}

If a privileged user concurrently writes a new table via sysfs, this write
path in pp_dpm_set_pp_table() executes memcpy() and mutates the buffer while
the reader is copying it, resulting in corrupted data to userspace.

Furthermore, in the SMU path, this race can result in a use-after-free. If a
larger table is written concurrently, the old table is freed:

drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:smu_sys_set_pp_table() {
        ...
        kfree(smu_table->hardcode_pptable);
        smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
        ...
}

Since the reader in amdgpu_get_pp_table() continues to execute
memcpy(buf, table, size) using the now-freed pointer without holding any
locks, can this lead to kernel memory corruption or an information leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-496-sashal@kernel.org?part=3D1
