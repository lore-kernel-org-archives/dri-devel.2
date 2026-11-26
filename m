Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhRqzIcX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999E61122EE;
	Thu, 26 Nov 2026 11:19:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E824C1122EE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:19:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E5EB40E23;
 Thu, 26 Nov 2026 11:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B911F000D1;
 Thu, 26 Nov 2026 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795691990;
 bh=VAR8gkfhvzjtmiIUWRuljNagcujq0JUW5zFyHuJjL30=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hhRqzIcXsJUNsPkvlhFHBSqGX7W1w8H+CP5HIofgQamjHu0ePrsF50LON/0HsS8MM
 ONHbX5r9RReCwiXod3J6XiXql6qd8keR5NQAzkZCVKWCLR68/Z/nLAX1JpJIQIg1vW
 B60nDrf0Ns/65C2W6ywSin9whPQP6ILPulSQHeDLRJQN7dKyzFUzEu4XxU+AI9xSq/
 OuOjzyxK25MOc8lche/IjN7Z+JLYvVk35GDKbPrIPpinyQqGc/4GCnU9ZZFsXG4iej
 tiUg8z+Rd4FwGVR2qP1WpW3EoChpBY3U7jCk/n+elUFs+pcR9mAZe/nwJOLYlKReLH
 pIhhele3WF8GQ==
Message-ID: <sashiko-outbox-235364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] drm/syncobj: Use scoped cleanup in
 drm_syncobj_array_find and callers
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261126111117.67342-7-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-7-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:19:48 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/syncobj: __free() variables not initialized at declaration
  site
--

commit d2db4e35813dabf4fb7e2f45ff5acb392b0b03ac
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/syncobj: Use scoped cleanup in drm_syncobj_array_find and callers

This commit converts drm_syncobj_array_find() and its ioctl callers to
use scoped cleanup (__free) and moves the syncobj array allocation and
maximum handle count checks into the callers.

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index da90ae11382e3..6b4df322b12a8 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1252,59 +1252,38 @@ static int drm_syncobj_array_wait(struct drm_devi=
ce *dev,
>  	return 0;
>  }
> =20
> -static int drm_syncobj_array_find(struct drm_file *file_private,
> -				  void __user *user_handles,
> -				  uint32_t count_handles,
> -				  struct drm_syncobj ***syncobjs_out)
> -{
> -	uint32_t i, *handles;
> +struct syncobj_array {
>  	struct drm_syncobj **syncobjs;
> -	int ret;
> +	unsigned int count;
> +};
> =20
> -	if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
> -		return -EINVAL;
> +static void syncobj_array_free(struct syncobj_array *a)
> +{
> +	for (unsigned int i =3D 0; i < a->count; i++)
> +		drm_syncobj_put(a->syncobjs[i]);
> +}
> =20
> -	handles =3D vmemdup_array_user(user_handles, count_handles,
> -				     sizeof(*handles));
> -	if (IS_ERR(handles))
> -		return PTR_ERR(handles);
> +DEFINE_FREE(syncobj_array, struct syncobj_array, syncobj_array_free(&_T))
> =20
> -	syncobjs =3D kvmalloc_objs(*syncobjs, count_handles);
> -	if (syncobjs =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> -		goto err_free_handles;
> -	}
> +static int drm_syncobj_array_find(struct drm_file *file_private,
> +				  void __user *user_handles, unsigned int count,
> +				  struct syncobj_array *array)
> +{
> +	u32 *handles __free(kvfree) =3D NULL;
> +	unsigned int i;
> =20
> -	for (i =3D 0; i < count_handles; i++) {
> -		syncobjs[i] =3D drm_syncobj_find(file_private, handles[i]);
> -		if (!syncobjs[i]) {
> -			ret =3D -ENOENT;
> -			goto err_put_syncobjs;
> -		}
> +	handles =3D vmemdup_array_user(user_handles, count, sizeof(*handles));

[ ... ]

> @@ -1312,10 +1291,11 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, vo=
id *data,
>  		       struct drm_file *file_private)
>  {
>  	struct drm_syncobj_wait *args =3D data;
> -	struct drm_syncobj **syncobjs;
> +	struct drm_syncobj **syncobjs __free(kvfree) =3D NULL;
> +	struct syncobj_array array __free(syncobj_array) =3D {};
>  	unsigned int possible_flags;
>  	ktime_t t, *tp =3D NULL;
> -	int ret =3D 0;
> +	int ret;
> =20
>  	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>  		return -EOPNOTSUPP;
> @@ -1329,11 +1309,17 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, vo=
id *data,
> =20
>  	if (args->count_handles =3D=3D 0)
>  		return 0;
> +	else if (args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
> +		return -EINVAL;
> +
> +	syncobjs =3D kvmalloc_objs(*syncobjs, args->count_handles);
> +	if (!syncobjs)
> +		return -ENOMEM;
> =20
> +	array.syncobjs =3D syncobjs;

[Severity: Low]
This isn't a bug, but cleanup.h recommends defining and initializing
__free() variables in a single statement at their allocation site rather
than declaring them with =3D NULL at the top of the function and assigning
them later.  Doing that for handles in drm_syncobj_array_find() and for
syncobjs (and array) in drm_syncobj_wait_ioctl() and the other five
ioctl callers in this patch also ensures reverse-acquisition cleanup
order naturally without relying on manual declaration ordering at the
top of each function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126111117.6734=
2-1-tvrtko.ursulin@igalia.com?part=3D6
