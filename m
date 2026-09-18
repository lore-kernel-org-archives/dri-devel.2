Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8F8C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F7D10F3E5;
	Fri, 18 Sep 2026 14:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kX89Q7Qr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519E510F3E5
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:48:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2145A42A43
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED431F000FF;
 Fri, 18 Sep 2026 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789742919;
 bh=SQ0s7TFs7ZHxg59LpzSL+RiftlZTon0txyf6JAmSGNM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kX89Q7QrnmKHY3BxrbxoSAUZ1yB8MIVwEFq/lFkc5wOMrkEkYGmmbjaA577CFKrA4
 1VYxK7nEWtd8WieyLIYeb+0YrSEDxyvGo8KBV7DNOPNB7XZtETeTNmqfjin0EFnNku
 gtCyYXWZTJoHrjl9UQjFlvbx7mNNjkxpWRLbhLaQeZy6nOSASh9Rm5GJ3AozUaRIrU
 i+iMfHdXmHCTiOuVCWJmciTteZQs/EB8cXDxqgz+er7escLWj9h1PNGR+47710W8EW
 nHd0skhtYesf4/nCBRF5CeijYlloHWs4tmNIc/SU04kPBNukeirzGZmsDEANTHVkOY
 p/5+SokThFHJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918-drm-reset-state-flag-v4-11-5ad106370f05@kernel.org>
References: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
 <20260918-drm-reset-state-flag-v4-11-5ad106370f05@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:48:38 +0000
Message-Id: <20260918144838.CED431F000FF@smtp.kernel.org>
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
- [High] drm/atomic: TOCTOU race leading to NULL pointer dereference in DRM=
_MODE_ATOMIC_RESET
--

commit 03ae8ccf607b3a82a4b17b4343d5b86063dc861c
Author: Sebastian Wick <sebastian.wick@redhat.com>
Date:   Fri Sep 18 14:18:00 2026 +0000

    drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag

    This commit introduces the DRM_MODE_ATOMIC_RESET flag for the atomic io=
ctl.
    When set, it resets all KMS object states to their defaults by dynamica=
lly
    allocating and setting default states before applying user properties.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1eebcf6f5e05b..237c7ff823523 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c

[ ... ]

> @@ -1688,6 +1695,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	fence_state =3D NULL;
>  	num_fences =3D 0;
> =20
> +	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
> +		if (!drm_atomic_implements_create_state(dev)) {
> +			ret =3D -EOPNOTSUPP;
> +			goto out;
> +		}
> +
> +		ret =3D drm_atomic_commit_fill_with_defaults(state);

[Severity: High]
Could this lockless check introduce a Time-Of-Check to Time-Of-Use (TOCTOU)=
 race
condition?

The initial validation in drm_atomic_implements_create_state() iterates ove=
r the
dynamic connector list without locks. If a hardware hotplug event (such as =
DP
MST) occurs right after this check returns true, the MST workqueue might
asynchronously add a new connector that lacks the .atomic_create_state hook
(like mst_connector_funcs) without taking connection_mutex.

When drm_atomic_commit_fill_with_defaults(state) is subsequently called, it
will encounter the newly added connector and unconditionally dereference the
missing function pointer:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults() {
    ...
    drm_for_each_connector_iter(connector, &conn_iter) {
        ...
        connector_state =3D connector->funcs->atomic_create_state(connector=
);
        ...
    }
}

Is there a way to protect the connector list during validation, or safely h=
andle
the missing hook during the fill operation to prevent a NULL pointer
dereference?

> +		if (ret)
> +			goto out;
> +	}
> +
>  	for (i =3D 0; i < arg->count_objs; i++) {
>  		uint32_t obj_id, count_props;
>  		struct drm_mode_object *obj;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-drm-reset-=
state-flag-v4-0-5ad106370f05@kernel.org?part=3D11
