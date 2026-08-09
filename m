Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD662C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 09:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EE610E532;
	Sun,  9 Aug 2026 09:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lNrBQ7/J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BFD10E4CB
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:11:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4C9760008;
 Sun,  9 Aug 2026 09:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBCE1F000E9;
 Sun,  9 Aug 2026 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786266687;
 bh=TlmjOAMYRoLARnygbODrulTQWh6Dc13+9Ozx9RDjFpE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lNrBQ7/JHGKppV/LSbgVQfoOVyZ1jw05Bvo2ru/6La9QnpxU96kaWTKtjC92cXzI/
 j0sOzhmMd0bw/CS3b4hc4YjFxBiWxSBeBQ6Hid0cMlRRjykmjDE1eqkf49OTbU9ek8
 UVxNdL7n2oYWF0HNPi02h9O8p7eifYI3ELzzHsSm+CqmqssLDEtbgr1TwH6D5WzbgN
 wx8oAh066dCl1/UQqP5lTYLDz+TPl0emoDVMoIgCtcUC7JPbEfBQFsnt0Evz/QJ0kd
 QV8XZ3KEJVm+cN8jWlK2Ebm/ywvH0toUX9eXWs6mW/KqnwZDX47IV5EYRz9AuJV7aX
 Sly9YZEs24YRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] drm/amdgpu/aca: Fix inverted validation logic
 and list cleanup
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809084735.9743-4-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
 <20260809084735.9743-4-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:11:26 +0000
Message-Id: <20260809091127.5BBCE1F000E9@smtp.kernel.org>
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
- [High] Invalid memory free causing SLUB corruption.
- [Low] Build failure due to missing `lock` member in `struct aca_handle_ma=
nager`.

Pre-existing issues:
- [High] TOCTOU race in `amdgpu_aca_get_error_data` and lockless list trave=
rsal in `aca_dispatch_bank`.
--

--- Patch [3]: [PATCH v4 3/6] drm/amdgpu/aca: Fix inverted validation logic=
 and list cleanup ---
commit 248bb6795a4ccf19c8da116fbb952cdd7829d1fb
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/aca: Fix inverted validation logic and list cleanup

This patch fixes inverted logic in aca_handle_is_valid() so that registered
handles evaluate as valid. It also modifies remove_aca_handle() to unlink=20
nodes under a lock and explicitly free the handle.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index c76664af9902e..c35f6be2ef774 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device=
 *adev, struct aca_handle *h
> =20
>  static bool aca_handle_is_valid(struct aca_handle *handle)
>  {
> -	if (!handle->mask || !list_empty(&handle->node))
> -		return false;
> -
> -	return true;
> +	return handle && handle->mask && !list_empty(&handle->node);
>  }
> =20
>  int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_han=
dle *handle,
> @@ -599,8 +596,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *han
>  	if (!handle || !err_data)
>  		return -EINVAL;
> =20
> -	if (aca_handle_is_valid(handle))
> -		return -EOPNOTSUPP;
> +	if (!aca_handle_is_valid(handle))
> +		return 0;

[Severity: High]
This is a pre-existing issue, but does adding the lock in remove_aca_handle=
()
actually prevent background queries from referencing destroyed mutexes?

The commit message notes that unlinking under a lock stops background queri=
es
from referencing destroyed error cache mutexes. However, since
amdgpu_aca_get_error_data() still calls aca_handle_is_valid() locklessly, a
background thread can evaluate !list_empty(&handle->node) to true and get
preempted.=20

Concurrent driver teardown in remove_aca_handle() can then unlink the handle
and destroy its mutexes. When the background thread resumes and enters
__aca_get_error_data(), won't it still lock a destroyed mutex?

Furthermore, aca_dispatch_bank() iterates mgr->list locklessly, which seems
like it will still race with list modifications in remove_aca_handle().

> =20
>  	if ((type < 0) || (!(BIT(type) & handle->mask)))
>  		return  0;

[ ... ]

> @@ -716,9 +713,13 @@ static void remove_aca_handle(struct aca_handle *han=
dle)
>  {
>  	struct aca_handle_manager *mgr =3D handle->mgr;
> =20
> -	aca_fini_error_cache(handle);
> -	list_del(&handle->node);
> +	mutex_lock(&mgr->lock);

[Severity: Low]
Does struct aca_handle_manager actually have a lock field?=20

Looking at drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h, the struct only contains
a list head and nr_handles. Attempting to lock mgr->lock appears to cause a
build failure.

> +	list_del_init(&handle->node);
>  	mgr->nr_handles--;
> +	mutex_unlock(&mgr->lock);
> +	aca_fini_error_cache(handle);
> +	kfree(handle);
> +

[Severity: High]
Is it safe to call kfree(handle) here?=20
   =20
Looking at amdgpu_ras_bind_aca() in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c,
the handle is passed as an interior pointer to the embedded aca_handle field
of struct ras_manager:

amdgpu_ras_bind_aca() {
    ...
    return amdgpu_aca_add_handle(adev, &obj->aca_handle, ...);
}

Calling kfree() on an embedded struct rather than a standalone heap allocat=
ion
will trigger a SLUB invalid-free kernel panic during driver teardown.

>  }
> =20
>  static void remove_aca_sysfs(struct aca_handle *handle)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809084735.9743=
-1-sreekuttan2156239@gmail.com?part=3D3
