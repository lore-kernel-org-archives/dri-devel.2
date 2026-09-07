Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1794C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509FD10E6DC;
	Mon,  7 Sep 2026 20:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QyoFFKDb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F76610E6DC
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 548E3601FB;
 Mon,  7 Sep 2026 20:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD791F00A3A;
 Mon,  7 Sep 2026 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788813197;
 bh=S7wpAkRRieFkRYQfhUE/qctBJU6j8bYHiV1gN4g8zLo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QyoFFKDbzA7pJ/JfP9mMdbGzvlinfm8S5SbD3sp2tFNCc/TsaFT9wY0HQnoSpU5y+
 cC9NdJolYmHWnTakKnyfHRu/OHU4qPhOIZJVAH9b9BSFbVAswY2AoV244xdsNPTGPG
 nMEyOmGI+GoJyz4pFKJX23oXzMSEHK0h6Y1+74Z9eE94EojRdn7qzSSu+2wv9rvyBu
 EfRf3SHZdtVGKbuUpw1VCJrOcXx7R3l3HqN5NY4t0GUIBi055ZctTHOkXFRGpxOxr0
 PxkHvP9QDFX9amUOr/x+lVNpuZGLXSKmmco4nBrC36RtgKyxkURXFdwEPOVrPBjoQu
 ya1mt2SAeHYCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/16] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-16-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-16-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:33:17 +0000
Message-Id: <20260907203317.9BD791F00A3A@smtp.kernel.org>
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
- [Medium] The newly added `pad` field in `struct drm_panfrost_perfcnt_dump=
` is not validated for being zero, breaking future extendability.
- [Medium] The `state` output field in `struct drm_panfrost_perfcnt_dump` i=
s not initialized to zero before being returned to userspace on the success=
 path.
--

commit 206ab1a1901fc21e7df0dcb1254dbaded4f7ae19
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Bump driver minor to reflect new DUMP IOCTL req field

Expose expanded PERFCNT_DUMP IOCTL interface to user mode.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 571a26b841269..de9b1c115181b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driv=
er_fops =3D {
>   * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
>   *	   PANFROST_IOCTL_QUERY_BO_INFO and
>   *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
> + * - 1.7 - adds PERFCNT_DUMP req state field

[Severity: Medium]
Since this exposes the new PERFCNT_DUMP fields to userspace, does the IOCTL
handler need to validate that the new padding field is zero?

In the newly expanded struct drm_panfrost_perfcnt_dump, a pad field was add=
ed:

include/uapi/drm/panfrost_drm.h:
    struct drm_panfrost_perfcnt_dump {
        __u64 buf_ptr;
        __u32 state;
        __u32 pad;
    };

But in panfrost_ioctl_perfcnt_dump(), it doesn't appear this field is check=
ed:

drivers/gpu/drm/panfrost/panfrost_perfcnt.c:panfrost_ioctl_perfcnt_dump() {
    ...
    ret =3D panfrost_unstable_ioctl_check();
    if (ret)
        return ret;

    mutex_lock(&perfcnt->lock);
    ...
}

If userspace leaves this uninitialized, the kernel currently accepts non-ze=
ro
values, which might prevent safely repurposing the pad field for new featur=
es
in the future.


[Severity: Medium]
Also regarding the new state field, is req->state guaranteed to be initiali=
zed
to zero before being returned to userspace?

Looking at panfrost_ioctl_perfcnt_dump(), the state field is passed directl=
y:

drivers/gpu/drm/panfrost/panfrost_perfcnt.c:panfrost_ioctl_perfcnt_dump() {
    ...
    ret =3D panfrost_perfcnt_dump_locked(pfdev, &req->state);
    if (ret)
        goto out;
    ...
}

And in panfrost_perfcnt_dump_locked(), *state is only conditionally modified
or OR'd:

drivers/gpu/drm/panfrost/panfrost_perfcnt.c:panfrost_perfcnt_dump_locked() {
    ...
    if (perfcnt->reset_happened) {
        *state =3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
        perfcnt->reset_happened =3D false;
    }
    ...
    /* Either sample finished or reset happened */
    if (ret > 0) {
        ...
        if (perfcnt->reset_happened)
            *state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
        if (!perfcnt->owns_as_ref)
            *state |=3D PANFROST_PERFCNT_SESSION_DEAD;
    }
    ...
}

If a userspace program calls the IOCTL with uninitialized memory for req->s=
tate,
and the happy path is taken where neither condition hits, does this leave t=
he
state field uninitialized on success, returning the user's garbage data back
to them and potentially causing them to falsely detect a GPU reset or dead
session?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D16
