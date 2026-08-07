Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D676FC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9FD10F55F;
	Fri,  7 Aug 2026 16:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QR+s6NTa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE35010F55F
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 16:19:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91AEF4120E;
 Fri,  7 Aug 2026 16:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EBE1F000E9;
 Fri,  7 Aug 2026 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786119566;
 bh=v1AheZj13W95DsaCkP6WXDk3r5NDpTnC+pUtKXy5oj4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QR+s6NTaVRR5a9es5VyMuBqcaf5NvjeofOCM7EQJ0FSuWQyB33w1bH4uXpW333V/+
 Qo3+XbediqmD0xzTEdhw16WmjIHAConT4VbzjBtiQCihODLl91FIqucmbRtv2arCm2
 YV27ZN7svNrCb23AyJgZaBr4yUKeMSKTjjolJW0nqG3xcGa9k0Vj+KWsur4HxFJDqy
 0mOzkhGUJBJS5aFIZNulcTpoZxuaMFwV+ZaGjgrifyhXJxscThm77r8kroQP4F1iQt
 W2+KeHSA3hPldGy+sAOAQLAgIe27va8ETjfzbsRp8/BWMRlYkTUO9KqLaJzljxzW1e
 Lro01H5mXqT8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] dma-buf: heaps: Add debugfs support
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, media-ci@linuxtv.org, robh@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807-tegra-vpr-v4-6-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-6-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:19:24 +0000
Message-Id: <20260807161925.B0EBE1F000E9@smtp.kernel.org>
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
- [Medium] If debugfs_create_dir() fails, dma_heap_debugfs_dir remains NULL=
, causing subsequent debugfs files to be erroneously created in the debugfs=
 root directory.
- [Low] The newly added dma_heap_exit function performs partial cleanup by =
removing debugfs entries but leaks the character device region and class.

Pre-existing issues:
- [Critical] Missing provider module pinning and absence of a heap unregist=
er function causes a Use-After-Free if a dynamically loaded heap provider f=
ails module initialization.
--

--- Patch [6]: [PATCH v4 06/10] dma-buf: heaps: Add debugfs support ---
commit 1c3871b543fe35314ecde7429a59aac59e23b5b3
Author: Thierry Reding <treding@nvidia.com>

dma-buf: heaps: Add debugfs support
   =20
Add a callback to struct dma_heap_ops that heap providers can implement
to show information about the state of the heap in debugfs. A top-level
directory named "dma_heap" is created in debugfs and individual files
will be named after the heaps.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3937dd41bb0f6..389cddd07c8d3 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c

[ ... ]

> @@ -225,6 +226,46 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> =20
> +#ifdef CONFIG_DEBUG_FS
> +static int dma_heap_debug_show(struct seq_file *s, void *unused)
> +{
> +	struct dma_heap *heap =3D s->private;
> +	int err =3D 0;
> +
> +	if (heap->ops && heap->ops->show)
> +		err =3D heap->ops->show(s, heap);
> +
> +	return err;
> +}
> +DEFINE_SHOW_ATTRIBUTE(dma_heap_debug);
> +
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

[Severity: Medium]
If debugfs_create_dir() fails and returns an error pointer, this check
returns early and leaves dma_heap_debugfs_dir as NULL.

Later, when dma_heap_add() attempts to create files, it will pass NULL
as the parent directory. Does this cause the debugfs files to be erroneousl=
y=20
created in the debugfs root namespace?

If dma_heap_debugfs_dir was allowed to hold the error pointer instead,
debugfs_create_file() would safely abort child creation.

[ ... ]

> @@ -299,6 +340,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
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

[Severity: Critical]
This is a pre-existing issue, but registering debugfs files and character=20
devices without a corresponding unregister function seems to expose a=20
use-after-free vulnerability.=20

If a dynamically loaded heap provider module successfully registers its fir=
st=20
heap via dma_heap_add() during module_init, but fails to register a second=
=20
heap, the module loader will abort the load and free the module's memory.

Since there is no dma_heap_remove() function to undo the first registration=
,=20
the first heap remains in heap_list and exposed via its debugfs file.

If a user later accesses this debugfs file (or the chardev), will the kernel
dereference the freed heap->ops->show pointer in dma_heap_debug_show()?

[ ... ]

> @@ -335,6 +383,14 @@ static int dma_heap_init(void)
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
The new dma_heap_exit() function only cleans up the debugfs entries. Does=20
this leak the character device region and the device class allocated earlie=
r=20
in dma_heap_init()?

Even though the subsystem is currently built-in only, omitting the cleanup
might become a hazard if it is ever converted to a loadable module.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D6
