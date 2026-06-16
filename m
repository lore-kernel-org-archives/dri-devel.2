Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B054FCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2B210E4A3;
	Tue, 16 Jun 2026 13:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="auA0kVu/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563CA10E4A3
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 13:17:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0FDE600AB;
 Tue, 16 Jun 2026 13:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7321F000E9;
 Tue, 16 Jun 2026 13:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781615828;
 bh=7ffGynRchUjiG8bT7Fjmp7HDPZY+6GZ3xz0JomWQ/2o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=auA0kVu/UiJVZErZZWVqqSp1SWUkP551/BCM/l70k1DKY8Bvh55msBDuLMbIegm8b
 K2cbDHu7S9h3oLltwZPBXlBFU4RMvG2hkR22ehswljS6fAC1VmiHsAdt8k2HEK2tOu
 VNNWHPjAoFjPt5My9UwHgPLEI9xiVPMJG7WMMKG2f3TPy2QthMu2KTdI85EnW/XWey
 CLlgAGrDip2MC7SUX90U9fTmxkqrFRwxE1hTAfSVQ1H+PwF7GdDjZVI73DGR2kiH0F
 5rzmBrodK1C3N15jDa+5bafAYyQ+0lP4QxuXwv81ESXzpdo4KI8WARinVXbE9a2UhQ
 eBgUcXnClJ4Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] drm/amdgpu: delay ttm buffer func enablement on
 xgmi
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
References: <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 13:17:07 +0000
Message-Id: <20260616131708.5B7321F000E9@smtp.kernel.org>
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

New issues:
- [High] Asynchronous enablement of TTM buffer functions creates a data rac=
e with userspace, potentially causing divide-by-zero or NULL pointer derefe=
rences.

Pre-existing issues:
- [Critical] Lockless iteration over `hive->device_list` in the asynchronou=
s reset worker exposes the list to concurrent modifications and use-after-f=
ree.
- [High] Ignoring the return value of `amdgpu_reset_do_xgmi_reset_on_init` =
and unconditionally enabling buffer functions can cause hardware hangs.
--

commit 1c14f2e51df95b3cf38be6f03564ce97cfb88996
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
drm/amdgpu: delay ttm buffer func enablement on xgmi

This commit delays SDMA engine initialization when amdgpu_init_minimal_xgmi
is used. It moves the amdgpu_ttm_enable_buffer_funcs() call to the
amdgpu_xgmi_reset_on_init_work() worker to avoid initialization failures.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index faac80a8a6eb2..c0dca209335e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c

[ ... ]

> @@ -1663,6 +1663,8 @@ static void amdgpu_xgmi_reset_on_init_work(struct w=
ork_struct *work)
>  		if (r && r !=3D -EHWPOISON)
>  			dev_err(tmp_adev->dev,
>  				"error during bad page data initialization");
> +
> +		amdgpu_ttm_enable_buffer_funcs(tmp_adev);

[Severity: Critical]
This isn't a bug introduced by this patch, but inserting this function call
here highlights a lockless iteration issue.

Earlier in amdgpu_xgmi_reset_on_init_work(), we drop the hive_lock:

    mutex_unlock(&hive->hive_lock);
    amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);

    list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
        ...
        amdgpu_ttm_enable_buffer_funcs(tmp_adev);
    }

If a device is unbound from the driver concurrently (e.g., via sysfs), could
amdgpu_xgmi_remove_device() acquire hive->hive_lock and delete the device
from the list?=20

If so, this loop could traverse a corrupted list or access a freed tmp_adev
pointer. Does the list traversal need to be protected?

[Severity: High]
This is also a pre-existing issue, but does this loop execute safely if the
hardware reset fails?

Right before this list iteration, the reset executes but the return value is
ignored:

    amdgpu_reset_do_xgmi_reset_on_init(&reset_context);
    mutex_unlock(&hive->hive_lock);

If the ASIC fails to respond or times out, we proceed to call
amdgpu_ttm_enable_buffer_funcs() on dead hardware. Could this result in
immediate job timeouts and scheduler hangs when TTM buffer moves are
directed to the SDMA engines?

[Severity: High]
Since amdgpu_xgmi_reset_on_init_work() executes asynchronously, could
userspace already have access the device before this worker finishes?

If drm_dev_register() has exposed an earlier device in the hive, a
concurrent thread could trigger buffer moves. When
amdgpu_ttm_enable_buffer_funcs() runs, it sets the enabled flag without
memory barriers:

    adev->mman.num_move_entities =3D num_move_entities;
    ...
    adev->mman.buffer_funcs_enabled =3D true;

Could a concurrent operation see adev->mman.buffer_funcs_enabled =3D=3D true
but read a stale value of 0 for adev->mman.num_move_entities?=20

This looks like it might cause a divide-by-zero kernel panic in
amdgpu_move_blit() when it calculates the entity:

    e =3D atomic_inc_return(&adev->mman.next_move_entity) %
        adev->mman.num_move_entities;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616125040.9977=
-1-pierre-eric.pelloux-prayer@amd.com?part=3D2
