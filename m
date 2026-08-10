Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40086C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E7A10E1EB;
	Mon, 10 Aug 2026 12:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="klveaIZI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B30B10E1EB
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 12:23:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EA1B60254;
 Mon, 10 Aug 2026 12:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD671F000E9;
 Mon, 10 Aug 2026 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786364633;
 bh=mojgExAPQssSf/5aU+hHSgquWpN6TvTrUbHavoffcLk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=klveaIZI2u3U2Vct6+x/a2jvGKuoIp8IWNfK2fxeoO9FgN0f4owr5lAiLcZfm57RX
 HuI2UQFhGUU99bZe6Vvmw1aeafP7u6AbaZvGxqRCuwgiS/2FLPTzzKi1ryWwO46xJF
 aIObr7jsz9kF9bRlBCr2qSFVJZpoQsh90HcqCJLDSJdXDLWN3ehJHmwy7N0+ID3ng5
 RHjJtnfBzVZQ6vfsvBXJMBR8QOn5iNaw4//76j/p5z/BMfZGm9GDR5ITN16FaiZZdb
 iiOFh6QXOc6/JojL5ek+XJvCqA98CckMq86saD8igNtbXPn4/I8/I9VKxXkXFh4BNP
 0MOum+ase0bzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/amdgpu: delay ttm buffer func enablement on
 xgmi
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810120218.23000-2-pierre-eric.pelloux-prayer@amd.com>
References: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
 <20260810120218.23000-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:23:52 +0000
Message-Id: <20260810122352.DFD671F000E9@smtp.kernel.org>
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

New issues:
- [High] `amdgpu_ttm_enable_buffer_funcs` is called asynchronously without =
locks, racing with device teardown.

Pre-existing issues:
- [High] Iterating over `hive->device_list` without holding `hive->hive_loc=
k` causes a data race and potential use-after-free.
--

--- Patch [2]: [PATCH v3 2/3] drm/amdgpu: delay ttm buffer func enablement =
on xgmi ---
commit 9b07616fd6cac22b50c5fa10e4c312c149b74bbd
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: delay ttm buffer func enablement on xgmi

This commit delays SDMA engine init and ttm buffer func enablement until
after the reset lock is dropped for XGMI devices.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 2725230aa5e39..45e31b3daf065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1380,6 +1380,9 @@ static void amdgpu_xgmi_reset_on_init_work(struct w=
ork_struct *work)
>  	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
> =20
>  	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {

[Severity: High]
This is a pre-existing issue, but does iterating over hive->device_list
without holding hive->hive_lock cause a data race and potential
use-after-free?

If a device is hot-unplugged or unbound while this async work is
running, couldn't another thread mutate the list (e.g., via
amdgpu_xgmi_remove_device), causing list corruption or accessing a freed
device?

> +		/* Enable ttm buffers funcs after the reset lock has been dropped. */
> +		amdgpu_ttm_enable_buffer_funcs(tmp_adev);

[Severity: High]
Does calling amdgpu_ttm_enable_buffer_funcs() asynchronously without
device locks introduce a race condition with device teardown?

If a device is unbound while reset_on_init_work is queued, the teardown
path calls amdgpu_device_fini_hw() -> amdgpu_ttm_disable_buffer_funcs().
Since buffer_funcs_enabled is still false, it returns early.

If this async work runs afterward, it calls
amdgpu_ttm_enable_buffer_funcs() which allocates memory and sets
buffer_funcs_enabled to true:

amdgpu_ttm_enable_buffer_funcs() {
    ...
	adev->mman.clear_entities =3D kcalloc(num_clear_entities,
						sizeof(struct amdgpu_ttm_buffer_entity),
						GFP_KERNEL);
    ...
}

Will this cause memory allocations to leak because teardown has already
completed, or potentially execute on an already-freed tmp_adev?

> +
>  		r =3D amdgpu_ras_init_badpage_info(tmp_adev);
>  		if (r && r !=3D -EHWPOISON)
>  			dev_err(tmp_adev->dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810120218.2300=
0-1-pierre-eric.pelloux-prayer@amd.com?part=3D2
