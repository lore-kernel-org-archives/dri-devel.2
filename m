Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7080C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 11:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2517010E184;
	Sun,  5 Jul 2026 11:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K3tj8DPj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C74710E184
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 11:09:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 278206001A;
 Sun,  5 Jul 2026 11:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78C71F000E9;
 Sun,  5 Jul 2026 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783249786;
 bh=ws4mDTatUMSjj8h6RWmmfz44LojRieB/oKoT6gSuIek=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K3tj8DPjnMa/UVe7UigT7llDQkYuzBUJGjA04w3oy1JVoOUzvY+cS7RvNslcVoZE3
 rKsLLOBihXCHN2PAHGBIlTk1Xlz6Ng/lg8nXAHY+tR7z3v6TLzx+WERjTDkgLdEyUL
 Hra1H5ba7yfxbAPs/BHw73nNLDsUpJYTwTS3ClJAQ6p/NfUASI3dD+qKK3U05dxQWN
 9Jwb8X9lYmh3zT4SjThRPfGJiddOUi7XfDsWx8nlWdC5KlQ7FGQq7L9GPh1ZbU/veD
 7bbAATgGIKMtqWnK0CLhBxqUHQmg5EIRW/NH7fazodq5EkBUu5Gifngm0fbQl4pZpU
 1BVb5aP46Wp7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/exynos: vidi: use memdup_user() instead of
 kmalloc() and copy_from_user()
To: mdshahid03@gmail.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260705110221.153481-1-mdshahid03@gmail.com>
References: <20260705110221.153481-1-mdshahid03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 11:09:46 +0000
Message-Id: <20260705110946.A78C71F000E9@smtp.kernel.org>
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
- [High] Concurrent executions of `vidi_connection_ioctl` can cause a memor=
y leak of the `drm_edid` object due to a time-of-check to time-of-use (TOCT=
OU) race condition when checking and updating the connection state.
--

commit 6f3818ed77cd21c4ace5a636e3cf596ff721c935
Author: Mohammad Shahid <mdshahid03@gmail.com>

drm/exynos: vidi: use memdup_user() instead of kmalloc() and copy_from_user=
()

This patch simplifies the driver by replacing an open-coded sequence of=20
kmalloc() and copy_from_user() with a single call to memdup_user().

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/e=
xynos/exynos_drm_vidi.c
> index 67bbf9b8bc0ef..183671de711e2 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -273,14 +273,9 @@ int vidi_connection_ioctl(struct drm_device *drm_dev=
, void *data,
> =20
>  		size =3D (hdr.extensions + 1) * EDID_LENGTH;
> =20
> -		edid_buf =3D kmalloc(size, GFP_KERNEL);
> -		if (!edid_buf)
> -			return -ENOMEM;
> -
> -		if (copy_from_user(edid_buf, edid_userptr, size)) {
> -			kfree(edid_buf);
> -			return -EFAULT;
> -		}
> +		edid_buf =3D memdup_user(edid_userptr, size);
> +		if (IS_ERR(edid_buf))
> +			return PTR_ERR(edid_buf);
> =20
>  		drm_edid =3D drm_edid_alloc(edid_buf, size);
>  		kfree(edid_buf);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for concurrent
ioctl calls to leak the drm_edid object allocated here?

Looking at vidi_connection_ioctl() in drivers/gpu/drm/exynos/exynos_drm_vid=
i.c,
the connection state is checked under ctx->lock, but the lock is then relea=
sed
before allocating the EDID:

    mutex_lock(&ctx->lock);
    if (ctx->connected =3D=3D vidi->connection) {
        mutex_unlock(&ctx->lock);
        ...
    }
    mutex_unlock(&ctx->lock);

If multiple threads call vidi_connection_ioctl() concurrently with
vidi->connection =3D 1 while ctx->connected is 0, won't they both pass the
initial check, allocate a new drm_edid object from userspace data, and then
sequentially re-acquire the lock to assign it?

    mutex_lock(&ctx->lock);
    ctx->raw_edid =3D drm_edid;
    mutex_unlock(&ctx->lock);

Does this unconditionally overwrite ctx->raw_edid, leaking any previously
allocated drm_edid from the racing thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705110221.1534=
81-1-mdshahid03@gmail.com?part=3D1
