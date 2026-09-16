Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB4C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A4C10E7EA;
	Wed, 16 Sep 2026 07:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tn1lMA18";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8833110E376
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:47:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E68F42B8A;
 Wed, 16 Sep 2026 07:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309571F000FF;
 Wed, 16 Sep 2026 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789544862;
 bh=Y8XJV4Gs05GEjZo728rbJMkc4NyDQWSZce11nGH4GCo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tn1lMA18bbJra7uGskmIJZ+Z2A3hQJsl76nrrm9w+2itsvyIKfHH+kSBN6/tJKeQt
 1txspDpOJxd6mJrXXg0w57McBik53kSL9iToeI/zvlLXqYilNNlrwQCmPOm22JNjel
 ITAhmxyDVqm5I1akzHAz/duzbdn/Re6khyhU/1oT6CTPFuWamq4ePtHcQde6LX0YtP
 9+PkpDFhj8QLaMVzHeKo3OWOb5hL3WJWqWxySPBbHGNFxoLCwZOdPEgpKk+hUvKt91
 bHiaJXSK+8CFq28cHdq63ELoJXtqxX2uFXjSZU2vkg6qr1CVLhmPR49u+NzySZWNOZ
 ZhSr0rxkvAQ/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Fix file reference leak in
 criu_restore_devices()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916074216.1973191-1-vulab@iscas.ac.cn>
References: <20260916074216.1973191-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:47:41 +0000
Message-Id: <20260916074742.309571F000FF@smtp.kernel.org>
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
- [High] drm/amdkfd: uninitialized pointer dereference in criu_restore_devi=
ces()
--

commit 40984d73f07608e70e87d6e7d3692de70675fb26
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/amdkfd: Fix file reference leak in criu_restore_devices()

This commit attempts to fix a file reference count leak in=20
criu_restore_devices() by calling fput() when a drm_file is already set=20
on the process device data structure.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2380,6 +2380,7 @@ static int criu_restore_devices(struct kfd_process =
*p,
>  		}
> =20
>  		if (pdd->drm_file) {
> +			fput(drm_file);

[Severity: High]
Could this lead to an uninitialized pointer dereference?

Looking at criu_restore_devices(), the variable drm_file is declared as an
uninitialized local variable inside the loop:

    for (i =3D 0; i < args->num_devices; i++) {
        ...
        struct file *drm_file;
        ...
        if (pdd->drm_file) {
            fput(drm_file);
            ...
        }
        ...
        drm_file =3D fget(device_buckets[i].drm_fd);
    }

At the point where fput(drm_file) is called in this new error path, drm_file
has not yet been assigned a value via fget().=20

If this error path is taken on the first iteration, it seems like fput()=20
would be called on uninitialized stack memory. If it happens on a subsequen=
t=20
iteration, could this result in a double-free of the reference from the=20
previous iteration?

>  			ret =3D -EINVAL;
>  			goto exit;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916074216.1973=
191-1-vulab@iscas.ac.cn?part=3D1
