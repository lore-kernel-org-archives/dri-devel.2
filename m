Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4F606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/xI5RH6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C20310E102;
	Thu, 26 Nov 2026 11:22:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA3410E102
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:22:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13D2841778;
 Thu, 26 Nov 2026 11:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDC11F01562;
 Thu, 26 Nov 2026 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795692127;
 bh=PWF5lKywOjBm23wyzCL1xPIx5Yo1c1s1QwrOwKmvKHU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=V/xI5RH6rurDrx5hMhnu/RBGvRWt5E6hFUuw8oLYUZkvs7LkKGiRMcsEs0r34fyON
 xyWGfT7ILiyoEoGue0LwUcUAjyXcqTpZVcfo3gGMop2vGZmN/ZQL4UKjioTQ+ILZOk
 ZlEN7AcioC6kbxAerK9TFaVSSwx7i0yg9qlq3ggJ2xvOtBx/oWthSCyfv4SwjrxQrU
 3Ov8oPRJWL/tCbYFR/fo8rXWZtVW5TWnt9P4PG47XBeaQ+VFn68qMbZv/waBgkOsSv
 b6JIrtBbHHRMLnFk4FN+RyITGIBukXpF243zyf6YpDgFIQFqiI7PGtzRYyKO+oy1zg
 10SCNam8Ei6lw==
Message-ID: <sashiko-outbox-235371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/syncobj: Add temporary array allocation fast paths
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261126111117.67342-8-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-8-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:22:07 +0000
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
- [Medium] drm/syncobj: unconverted handles allocation in
  drm_syncobj_array_find()
--

commit 9cfbb7c668583619e7699957c17e9063e116a22e
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/syncobj: Add temporary array allocation fast paths

This commit adds stack-backed fast-path macros for temporary syncobj array
allocations up to four elements and converts the syncobj wait, reset,
signal, and query paths to use them.

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 6b4df322b12a8..cde7835744177 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -214,6 +214,53 @@
> =20
>  #include "drm_internal.h"
> =20
> +/*
> + * Empirically vast majority of ioctls pass in a single syncobj (96%) an=
d never
> + * more than three points. Therefore implement a fast path with a small =
stack
> + * array to avoid going into the allocator sometimes several times per
> + * userspace rendered frame.
> + */
> +#define DRM_SYNCOBJ_FAST_PATH_ENTRIES 4
> +
> +#define DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(_type, _name)	\
> +	_type _name##_stack[DRM_SYNCOBJ_FAST_PATH_ENTRIES];	\
> +	_type * _name##_heap __free(kvfree) =3D NULL;		\
> +	_type * _name
> +
> +#define DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(_name, _src, _count) ({		\
> +	int __ret =3D 0;							\
> +									\
> +	if ((_count) > ARRAY_SIZE(_name##_stack)) {			\
> +		if (_src) {						\
> +			_name##_heap =3D vmemdup_array_user((_src),	\
> +							  (_count),	\
> +							  sizeof(*(_name))); \
> +			if (IS_ERR(_name##_heap)) {			\
> +				__ret =3D PTR_ERR(no_free_ptr(_name##_heap)); \
> +			} else {					\
> +				_name =3D _name##_heap;			\
> +			}						\
> +		} else {						\
> +			_name##_heap =3D kvzalloc_objs(*(_name), (_count)); \
> +			if (!_name##_heap)				\
> +				__ret =3D -ENOMEM;			\
> +			else						\
> +				_name =3D _name##_heap;			\
> +		}							\
> +	} else {							\
> +		size_t __size =3D (_count) * sizeof(*(_name));		\
> +									\
> +		_name =3D _name##_stack;					\
> +		if (_src) {						\
> +			if (copy_from_user(_name, (_src), __size))	\
> +				__ret =3D -EFAULT;			\
> +		} else {						\
> +			memset(_name, 0, __size);			\
> +		}							\
> +	}								\
> +	__ret;								\
> +})

[Severity: Medium]
Was drm_syncobj_array_find() meant to be converted to use the fast-path
array macros for its temporary handles array as well?

The commit message notes that drm_syncobj_array_find() is called with one
to three objects in almost all calls, and commit "drm/syncobj: Use scoped
cleanup in drm_syncobj_array_find and callers" converted handles to scoped
cleanup, but drm_syncobj_array_find() still unconditionally allocates and
frees handles on the heap on every syncobj array ioctl:

drivers/gpu/drm/drm_syncobj.c:drm_syncobj_array_find() {
	u32 *handles __free(kvfree) =3D NULL;
	unsigned int i;

	handles =3D vmemdup_array_user(user_handles, count, sizeof(*handles));
	if (IS_ERR(handles))
		return PTR_ERR(no_free_ptr(handles));
    ...
}

Note that if drm_syncobj_array_find() is converted to
DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(), a runtime NULL user_handles pointer
(args->handles =3D=3D 0) must still return -EFAULT rather than taking the
!_src zero-initialization branch and looking up handle 0 (-ENOENT).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126111117.6734=
2-1-tvrtko.ursulin@igalia.com?part=3D7
