Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E242C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E07C10E1EF;
	Mon, 10 Aug 2026 16:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aMW6No3k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6759710E1EF
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:30:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 621D260052;
 Mon, 10 Aug 2026 16:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79121F000E9;
 Mon, 10 Aug 2026 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786379401;
 bh=hQFdk9edjydwzvKSVfLkbgSGxgUMzPD8nyU+/VvM8ig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aMW6No3kpZMxLG0WR7rjlwh3fnK/yH5XvPbpGRqs7Ucj3oYQTc5ITULxBqnvoo+9m
 9KPh81tSWq5HRYVgM647KsFrhv5VVevvFx2Bw9I4Wlkp1ehecPsQE9pf5XFeys0qbc
 uvTA5j09FLnPJ09iecxZkZwwOfQCiUGifnIrLB4cj58JjRtiwm1/QS1Uoo1cBgXZz4
 AF3scc29TsxDRJrbye6+PHsHfhwwTdoBKkJOYu7cFZSe8R0yTVnbcCzCeiAotmhU1L
 6a4jlHbu9BIcnDBEzEawGxUDghy7CmEHScaMUflIcKK/n/2ZswpF56HZ5UJ/AyQ4lS
 skxKIyaZyyJrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/amdgpu: enforce UVD handle ownership on destroy
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260811-amdgpu-fixes-v1-4-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
 <20260811-amdgpu-fixes-v1-4-4954a417b8ff@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:29:59 +0000
Message-Id: <20260810163000.D79121F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] TOCTOU race condition in UVD destroy ownership check allows bypass=
ing the security check.
- [High] Partial driver state modification during UVD destroy message valid=
ation leads to a permanent firmware resource leak.
- [Medium] Un-rate-limited DRM_ERROR in user-triggerable path allows kernel=
 log flooding.

Pre-existing issues:
- [High] Flawed loop logic and lockless design in UVD handle creation allow=
s clients to create duplicate handles and shadow existing sessions.
- [High] Integer overflow in amdgpu_uvd_cs_msg_decode allows bypassing buff=
er size validation, leading to out-of-bounds DMA writes by firmware.
--

--- Patch [4]: [PATCH 4/5] drm/amdgpu: enforce UVD handle ownership on dest=
roy ---
commit 51bb2295b5cb365884456f0b29a575d54bdae4a7
Author: Junrui Luo <moonafterrain@outlook.com>
Subject: drm/amdgpu: enforce UVD handle ownership on destroy

This patch updates the UVD command submission to validate handle ownership
during destroy operations, similar to the decode path. It checks that the
file pointer associated with the handle matches the submitting client. The
mapping release is also hoisted above the loop to prevent reference leaks on
error.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index e8b0c62f72be2..8d3e5435cf528 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -918,9 +918,19 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ct=
x *ctx,
> =20
>  	case 2:
>  		/* it's a destroy msg, free the handle */
> -		for (i =3D 0; i < adev->uvd.max_handles; ++i)
> -			atomic_cmpxchg(&adev->uvd.handles[i], handle, 0);
>  		amdgpu_bo_kunmap(bo);
> +
> +		for (i =3D 0; i < adev->uvd.max_handles; ++i) {
> +			if (atomic_read(&adev->uvd.handles[i]) !=3D handle)
> +				continue;
> +
> +			if (adev->uvd.filp[i] !=3D ctx->parser->filp) {

[Severity: High]
Does this check introduce a time-of-check to time-of-use race condition?

In the case 0 (create) path, the slot is claimed via atomic_cmpxchg before
filp[i] is updated:

drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:amdgpu_uvd_cs_msg() {
    ...
    if (!atomic_cmpxchg(&adev->uvd.handles[i], 0, handle)) {
        adev->uvd.filp[i] =3D ctx->parser->filp;
        return 0;
    }
    ...
}

If a victim thread is preempted right after the atomic_cmpxchg but before
updating filp[i], filp[i] still retains its old value. If an attacker
concurrently submits a destroy command and their filp matches that old valu=
e,
can they pass this new ownership check and destroy the victim's newly alloc=
ated
session?

> +				DRM_ERROR("UVD handle collision detected!\n");

[Severity: Medium]
Is it possible for a user to flood the kernel log with this error message?

Since this path is entirely controlled by user inputs, an attacker could
repeatedly submit destroy messages for handles they do not own, triggering
this un-rate-limited DRM_ERROR in a tight loop.

> +				return -EINVAL;
> +			}
> +
> +			atomic_cmpxchg(&adev->uvd.handles[i], handle, 0);

[Severity: High]
Can returning -EINVAL here cause a permanent leak of UVD hardware sessions?

If multiple slots happen to contain the same handle, this loop will clear t=
he
first matching slot using atomic_cmpxchg. When it reaches the second matchi=
ng
slot (owned by a different client), the filp check fails and the function
returns -EINVAL.

This aborts the command submission before the destroy command is sent to the
firmware. However, because the first software slot is already zeroed out,
amdgpu_uvd_free_handles() will never clean it up, leaving the hardware
session leaked permanently.

> +		}
>  		return 0;
> =20
>  	default:

[Severity: High]
This is a pre-existing issue, but does the loop logic in the case 0 (create)
path allow clients to create duplicate handles and shadow existing sessions?

drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:amdgpu_uvd_cs_msg() {
    ...
    for (i =3D 0; i < adev->uvd.max_handles; ++i) {
        if (atomic_read(&adev->uvd.handles[i]) =3D=3D handle) {
            ...
        }

        if (!atomic_cmpxchg(&adev->uvd.handles[i], 0, handle)) {
            adev->uvd.filp[i] =3D ctx->parser->filp;
            return 0;
        }
    }
    ...
}

The loop exits early upon finding a free slot, bypassing duplicate checks f=
or
the remaining slots. If an attacker creates a handle that is already owned =
by
a victim, and the attacker obtains an earlier slot index, subsequent operat=
ions
by the victim will hit the attacker's slot first and fail the ownership che=
ck.

[Severity: High]
This is a pre-existing issue, but does the 32-bit multiplication of
user-controlled dimensions in amdgpu_uvd_cs_msg_decode() overflow?

drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:amdgpu_uvd_cs_msg_decode() {
    ...
    image_size =3D (ALIGN(width, 16) * ALIGN(height, 16) * 3) / 2;
    ...
}

The width and height dimensions read from the UVD message do not seem to be
checked against upper bounds. By providing extremely large values, this
calculation can overflow 32-bit arithmetic to a very small value, bypassing
buffer size validation and allowing the firmware to perform out-of-bounds D=
MA
writes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-amdgpu-fix=
es-v1-0-4954a417b8ff@outlook.com?part=3D4
