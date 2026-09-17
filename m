Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63224C982D1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60A710EE5C;
	Thu, 17 Sep 2026 12:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KIirLUFC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD7910EE5C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:14:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 714FE60230;
 Thu, 17 Sep 2026 12:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000711F000FF;
 Thu, 17 Sep 2026 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789647280;
 bh=z0U+h7DQm4FuuI9z3h0WmA+7YNwDm26UB7DkCEIZGT4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KIirLUFC5wNfnZ7IHTfZ+iSTG4AXMqNuTRYwQ2ge2aBk8iuuRAoKRT2fg2ub9M7WE
 Y2IhYMyPL4p42k1ghZ9POcWUZQV9aq53bEY/jqr1qkO4ixybY1UeiBdAudJCX13bza
 txS28SPrts1K0W0+WK8knwo+rufi8v6UfjcYLR2ZvAZb3pEXRvys5GgK4z4VBo7o+i
 QxRvhrpF6Ipo4KrNhl4KamKsCEvNFA/R4KpvHMjUK7o78de6p4aIDVz5V7+al4c94Q
 fN2RnfwMkr7n1r2jr3uMCtnAzJglUVoklq9+lP+9IeRRqn3lp2UWOygurniDtK4IH4
 NmVH/HivnMS6A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/2] drm: Allow drivers to report standardized memory stats
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917120444.86471-2-tvrtko.ursulin@igalia.com>
References: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
 <20260917120444.86471-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 12:14:39 +0000
Message-Id: <20260917121440.000711F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] sysfs: UAF due to empty kobj release function and synchronous =
kfree
- [High] sysfs: uninitialized memory read in unregister loop leads to out-o=
f-bounds access
- [High] drm: double-free of memstat regions on xa_store failure
- [Medium] sysfs: kobject leak in drm_sysfs_register_memstat on error path
--

commit d035e68d523234171ccd6d024a36f5efdbe545f4
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: drm: Allow drivers to report standardized memory stats

Adds a DRM driver level vfunc to opt-in into reporting standardized memory
stats via sysfs. Each region reports the total size and its current usage in
the total_mb and used_mb files.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 8c0879c336e5f..6302a72631005 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -197,10 +198,15 @@ static int drm_minor_register(struct drm_device *de=
v, enum drm_minor_type type)
>  	if (ret)
>  		goto err_debugfs;
> =20
> +	ret =3D drm_sysfs_register_memstat(minor);
> +	if (ret)
> +		goto err_kdev;
> +
>  	/* replace NULL with @minor so lookups will succeed from now on */
>  	entry =3D xa_store(drm_minor_get_xa(type), minor->index, minor, GFP_KER=
NEL);
>  	if (xa_is_err(entry)) {
>  		ret =3D xa_err(entry);
> +		drm_sysfs_unregister_memstat(minor);
>  		goto err_debugfs;
>  	}

[Severity: High]
Does this error path introduce a double-free?

If xa_store() fails, this jumps to err_debugfs, which bypasses
device_del(minor->kdev) and leaves the minor device registered.

When the caller eventually cleans up by calling drm_minor_unregister(), it
will call drm_sysfs_unregister_memstat(minor) a second time.

Since the first call doesn't set the sysfs_memstat_regions pointer to NULL,
won't this second call attempt to free the same regions array again?

> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 7b16d32b6ff65..4a8c5b0b458d5 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
[ ... ]
> +static void kobj_memstat_release(struct kobject *kobj)
> +{
> +}

[Severity: Critical]
Is it safe to use an empty release callback here?

An empty release function breaks the kobject lifecycle guarantees. If a
userspace process holds a sysfs file open (like total_mb) when the device is
unregistered, the sysfs core retains an elevated reference to this kobject.

> +
> +static const struct kobj_type memstat_ktype =3D {
> +	.release =3D kobj_memstat_release,
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.default_groups =3D memstat_groups,
> +};
> +
> +int drm_sysfs_register_memstat(struct drm_minor *minor)
> +{
[ ... ]
> +	regions =3D kmalloc_objs(*regions, info->num_regions + 1);
> +	if (!regions)
> +		return -ENOMEM;

[Severity: High]
Should this use kzalloc_objs() instead?

This allocation leaves the sentinel element at index info->num_regions
uninitialized.

> +
> +	root =3D kobject_create_and_add("memstat", &minor->kdev->kobj);
> +	if (!root)
> +		goto err_root;
> +
> +	for (i =3D 0; i < info->num_regions; i++) {
> +		regions[i].region =3D i;
> +		regions[i].drm =3D drm;
> +		ret =3D kobject_init_and_add(&regions[i].kobj, &memstat_ktype,
> +					   root, "%s", info->region[i].name);
> +		if (ret)
> +			goto err_regions;
> +	}
[ ... ]
> +err_regions:
> +	while (i-- > 0) {
> +		kobject_del(&regions[i].kobj);
> +		kobject_put(&regions[i].kobj);
> +	}

[Severity: Medium]
Does this cleanup loop leak the failing kobject?

If kobject_init_and_add() fails at index i, the code jumps to err_regions.
The while (i-- > 0) loop post-decrements i, skipping the cleanup for the
kobject at index i.

Since the kobject API requires calling kobject_put() even if
kobject_init_and_add() fails, wouldn't this leak the partially initialized
kobject and its allocated name?

[ ... ]
> +void drm_sysfs_unregister_memstat(struct drm_minor *minor)
> +{
> +	struct drm_memstat_attr *region =3D minor->sysfs_memstat_regions;
> +
> +	while (region && region->kobj.state_initialized) {

[Severity: High]
When iterating here, won't the loop read garbage memory for state_initializ=
ed
when it reaches the uninitialized sentinel element?

If the garbage memory happens to be non-zero, this could proceed to call
kobject_del() and kobject_put() on arbitrary memory.

> +		kobject_del(&region->kobj);
> +		kobject_put(&region->kobj);
> +		region++;
> +	}
> +
> +	kfree(minor->sysfs_memstat_regions);

[Severity: Critical]
Since kfree() is called synchronously right after kobject_put(), won't the
entire array be deleted even if the kobjects inside still have active
references?

This seems like it could lead to a use-after-free when userspace later reads
from the open sysfs file, since the empty release function above doesn't
delay the freeing of the memory until all references are dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917120444.8647=
1-1-tvrtko.ursulin@igalia.com?part=3D1
