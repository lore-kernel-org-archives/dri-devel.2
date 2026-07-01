Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21595C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6989F10F00D;
	Wed,  1 Jul 2026 16:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PcDH3ssh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFD710F00D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D75F96001D;
 Wed,  1 Jul 2026 16:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F132C1F000E9;
 Wed,  1 Jul 2026 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782923249;
 bh=C71zmEENUUiDRRoYW052MW6KSTKMKDP4q3Wwg+f/qT0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PcDH3sshnIKB1nOl15CKxBrQaDGKTvXUeZs4vJ3Wet58t661luZDNYqdCg31Jt+Yv
 kHtqE8JjxsstmBaYsAFH/WhmZNv3AML+DGXxuBIl8YAYgu/YQpZYOwmoiIVFylso6M
 MwZLG6QIfVNq0YvcO9P9AuY4SKXXaUk6+QwN/RGBVowHCidmevGSxfEirXTXn4HEOM
 9mIgmfUDbyL8Z+C1+ksSd2ypqfyuYnBIYTt8sry1N7+kw061PRbLVYehF4KgvC7c+9
 LvfkbVH+5q7f/9b11a75PcOpa6MekU1t2JavKepjsTZTc96A+grkoClJtd95Zt1gzB
 3/JswJ9P7i8bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/11] dma-buf: heaps: Add debugfs support
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 conor+dt@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-7-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-7-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:27:28 +0000
Message-Id: <20260701162728.F132C1F000E9@smtp.kernel.org>
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
- [Low] debugfs_create_dir failure handling causes namespace pollution.
- [Low] Incomplete resource teardown in newly added dma_heap_exit() functio=
n.

Pre-existing issues:
- [High] Use-After-Free due to character device exposure before uniqueness =
validation completes.
--

commit be3535d09b01d53c055d9d5fb7c60f03232a5ac7
Author: Thierry Reding <treding@nvidia.com>

dma-buf: heaps: Add debugfs support

Add a callback to struct dma_heap_ops that heap providers can implement
to show information about the state of the heap in debugfs. A top-level
directory named "dma_heap" is created in debugfs and individual files
will be named after the heaps.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index a76bf3f8b071a..1ceb6ee8c05a2 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -224,6 +225,46 @@ const char *dma_heap_get_name(struct dma_heap *heap)

[ ... ]

> +static struct dentry *dma_heap_debugfs_dir;
> +
> +static void dma_heap_init_debugfs(void)
> +{
> +	struct dentry *dir;
> +
> +	dir =3D debugfs_create_dir("dma_heap", NULL);
> +	if (IS_ERR(dir))
> +		return;
> +
> +	dma_heap_debugfs_dir =3D dir;
> +}

[Severity: Low]
If debugfs_create_dir() returns an error, this early return leaves
dma_heap_debugfs_dir as NULL.

Later, when dma_heap_add() calls debugfs_create_file() with this NULL paren=
t,
won't it create the heap files directly in the debugfs root directory inste=
ad
of failing safely?

[ ... ]

> @@ -298,6 +339,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
export_info *exp_info)
> =20
>  	/* Add heap to the list */
>  	list_add(&heap->list, &heap_list);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	if (heap->ops && heap->ops->show)
> +		debugfs_create_file(heap->name, 0444, dma_heap_debugfs_dir,
> +				    heap, &dma_heap_debug_fops);
> +#endif
> +
>  	mutex_unlock(&heap_list_lock);
> =20
>  	return heap;

[Severity: High]
This is a pre-existing issue, but doesn't the current design of
dma_heap_add() allow a use-after-free?

The character device is made live and exposed to userspace early:

	cdev_init(&heap->heap_cdev, &dma_heap_fops);
	ret =3D cdev_add(&heap->heap_cdev, heap->heap_devt, 1);

But then, if the uniqueness check fails:

	list_for_each_entry(h, &heap_list, list) {
		if (!strcmp(h->name, exp_info->name)) {
			...
			goto err3;
		}

The error path frees the heap without revoking the live character device:

err0:
	kfree(heap);

If userspace opens the device concurrently before the uniqueness check fail=
s,
could it access the freed heap object?

[ ... ]

> @@ -334,6 +382,14 @@ static int dma_heap_init(void)
>  	}
>  	dma_heap_class->devnode =3D dma_heap_devnode;
> =20
> +	dma_heap_init_debugfs();
> +
>  	return 0;
>  }
>  subsys_initcall(dma_heap_init);
> +
> +static void __exit dma_heap_exit(void)
> +{
> +	dma_heap_exit_debugfs();
> +}
> +__exitcall(dma_heap_exit);

[Severity: Low]
Does this exit function omit teardown steps?

It cleans up debugfs but seems to be missing calls to
unregister_chrdev_region() and class_destroy() that were set up in
dma_heap_init().

If this subsystem is ever built as a loadable module, won't this leak those
resources on unload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D7
