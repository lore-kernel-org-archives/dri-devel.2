Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8614606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izWHorUB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BCB10E323;
	Tue, 27 Oct 2026 16:29:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F66D10F742
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:29:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B34FA6021D;
 Tue, 27 Oct 2026 16:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5831F01825;
 Tue, 27 Oct 2026 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793118558;
 bh=0cX8mLNFdUfu20DOss9HA1/tThwdeiqSiuRXIR5nzrM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=izWHorUBUZSwooY+QkjQ5IqNMMfKlogl5D8ihSV4t3tiUK1JqiSs4ZqslSLxSqea7
 dmD0o45La4rP7+GK+Pa+vd0hVQTOpGaqBGH8zTD8J8AjbQliIrZJs9H1ZVRNheunSb
 hv8/PSKd6SqxvkSyBV74HBw8/rCqrN0GlVgviKCEgA0YLN4GoTTUVOS10l19GPqBsc
 pdIsoZJIDJQZI2AzyGA5xhGevQ/J2+UqOwT20f9goIyEWUCWRehnfWLB5mC9GjQdi+
 aKkDuVRp6M0H7Nzumrve2pw1RYO7lkROqZRKa79gCSfavMSTVrWV63RsWAv2FkOR91
 69+rKXMfKbRFw==
Message-ID: <sashiko-outbox-186915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/syncobj: Use scope-based cleanup for
 eventfd_ctx
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027-efd-autofree-v3-2-caa2442e1beb@arm.com>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261027-efd-autofree-v3-2-caa2442e1beb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:29:17 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/syncobj: mixing __free() and goto cleanup in drm_syncobj_eventf=
d_ioctl()
--

commit 235e12bb4f2858e1c0f1b573b50d4958dd229203
Author: Bence Csokas <bence.csokas@arm.com>

drm/syncobj: Use scope-based cleanup for eventfd_ctx

This commit converts ev_fd_ctx in drm_syncobj_eventfd_ioctl() to use
__free(eventfd) and no_free_ptr(), removing the err_kzalloc error label.

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index f1d4da1685457..40bedd30b2fc0 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1429,9 +1429,9 @@ int
>  drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *file_private)
>  {
> +	struct eventfd_ctx *ev_fd_ctx __free(eventfd) =3D NULL;
>  	struct drm_syncobj_eventfd *args =3D data;
>  	struct drm_syncobj *syncobj;
> -	struct eventfd_ctx *ev_fd_ctx;
>  	struct syncobj_eventfd_entry *entry;
>  	int ret;
> =20
> @@ -1457,10 +1457,10 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev,=
 void *data,
>  	entry =3D kzalloc_obj(*entry);
>  	if (!entry) {
>  		ret =3D -ENOMEM;
> -		goto err_kzalloc;
> +		goto err_fdget;
>  	}
>  	entry->syncobj =3D syncobj;
> -	entry->ev_fd_ctx =3D ev_fd_ctx;
> +	entry->ev_fd_ctx =3D no_free_ptr(ev_fd_ctx);
>  	entry->point =3D args->point;
>  	entry->flags =3D args->flags;
> =20
> @@ -1469,8 +1469,6 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, v=
oid *data,
> =20
>  	return 0;
> =20
> -err_kzalloc:
> -	eventfd_ctx_put(ev_fd_ctx);
>  err_fdget:
>  	drm_syncobj_put(syncobj);
>  	return ret;

[Severity: Low]
In drivers/gpu/drm/drm_syncobj.c, drm_syncobj_eventfd_ioctl() declares
ev_fd_ctx with __free(eventfd) =3D NULL at the top of the function while
retaining goto err_fdget to clean up syncobj.

When kzalloc_obj(*entry) fails, jumping to err_fdget runs
drm_syncobj_put(syncobj) before scope exit calls eventfd_ctx_put(ev_fd_ctx),
which reverses the teardown order relative to acquisition:

	syncobj =3D drm_syncobj_find(file_private, args->handle);
	if (!syncobj)
		return -ENOENT;

	ev_fd_ctx =3D eventfd_ctx_fdget(args->fd);
	if (IS_ERR(ev_fd_ctx)) {
		ret =3D PTR_ERR(ev_fd_ctx);
		goto err_fdget;
	}

	entry =3D kzalloc_obj(*entry);
	if (!entry) {
		ret =3D -ENOMEM;
		goto err_fdget;
	}

The documentation in include/linux/cleanup.h notes that __free() variables
should be defined and initialized in one statement rather than grouped at t=
he
top with =3D NULL, and states that goto cleanup and scope-based cleanup hel=
pers
should not be mixed in the same function:

 * Given that the "__free(...) =3D NULL" pattern for variables defined at
 * the top of the function poses this potential interdependency problem
 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.
 *
 * Lastly, given that the benefit of cleanup helpers is removal of
 * "goto", and that the "goto" statement can jump between scopes, the
 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function. I.e. for a given routine, convert all
 * resources that need a "goto" cleanup to scope-based cleanup, or
 * convert none of them.

Should drm_syncobj_eventfd_ioctl() either convert syncobj to scope-based
cleanup as well (or restructure the acquisition order so goto err_fdget is =
no
longer needed), and define ev_fd_ctx at the point where eventfd_ctx_fdget()
is called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-efd-autofr=
ee-v3-0-caa2442e1beb@arm.com?part=3D2
