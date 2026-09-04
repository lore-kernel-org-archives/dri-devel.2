Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5029EC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA4710FAC3;
	Fri,  4 Sep 2026 11:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="omOoktca";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B912810FAC2
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:34:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C82F4086F;
 Fri,  4 Sep 2026 11:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9FB1F00A3D;
 Fri,  4 Sep 2026 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788521673;
 bh=KmhpZIJvI8AxL+k7qTOj8ToEGRZ0/1AA974rwkS+BUI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=omOoktca5+tOn6jGGT9edR4XOp55QePzlmIpWiG8kcQlYMUZQqYlJQ/PUgT+fh0AL
 iltRvC/KXOqey0Zuq4Px77WFNcOIpl/042AaXI6m06xKx7gU9smpQlVPV8JqsCM98V
 qDbZKN94MpjKTbM/aHOlErTojk1wP3tZZRKFsEp4d1rRQQO+W6i28uTMGs//imiqCy
 SVIPP8sm4wioHs0Opzq+LCYuCq0bflY/kcbulgxMho2ciuxSH8SN1ZXCDBwVql0sQp
 VXPlAwu0QBqlIKpa+wtfXhl2ul5ks3/cnPzLFNI7wDzzAjIl2lU2k2Q0nzLFu8YfG2
 txnufBKXXTaTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/12] dma-buf: heaps: Add debugfs support
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org,
 devicetree@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-8-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-8-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:34:32 +0000
Message-Id: <20260904113432.BD9FB1F00A3D@smtp.kernel.org>
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

New issues:
- [Medium] Incomplete resource cleanup in the newly added `dma_heap_exit()`=
 leaves dynamically allocated heaps, character devices, and sysfs devices a=
ctive but orphaned.

Pre-existing issues:
- [High] Race condition in `dma_heap_add` error path leads to a critical Us=
e-After-Free of `struct dma_heap` due to premature device exposure.
--

commit e23fa30f3769a236faddd443565a8ccf6a9af125
Author: Thierry Reding <treding@nvidia.com>

dma-buf: heaps: Add debugfs support

This commit adds a callback to struct dma_heap_ops to show heap state in
debugfs. It creates a top-level dma_heap directory where individual heap
files are registered. A new dma_heap_exit() function is also introduced to
clean up the class and debugfs directory on module exit.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 8a6c2b6e0cc60..65c80dac65009 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c

[ ... ]

> @@ -299,6 +334,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
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
This isn't a bug introduced by this patch, but is it possible for a concurr=
ent
userspace process to trigger a use-after-free during the error path of
dma_heap_add()?

Earlier in dma_heap_add(), the character device is exposed to userspace bef=
ore
the name uniqueness check is performed:

	ret =3D cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
	...
	dev_ret =3D device_create(dma_heap_class, ...);
	...
	/* check the name is unique */
	list_for_each_entry(h, &heap_list, list) {
		if (!strcmp(h->name, exp_info->name)) {
			...
			goto err3;
		}
	}

If another driver attempts to register a heap with a duplicate name, could a
userspace process open the device before the uniqueness check fails? This w=
ould
store the heap pointer in the open file descriptor. When the uniqueness che=
ck
then fails, the error path executes kfree(heap), leaving the open file
descriptor pointing to freed memory.

[ ... ]

> @@ -335,6 +377,16 @@ static int dma_heap_init(void)
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
> +	class_destroy(dma_heap_class);

[Severity: Medium]
Does this successfully tear down the resources if there are dynamically
allocated heaps still registered?

The dma_heap_exit() function destroys the sysfs class by calling
class_destroy(), but it doesn't appear to iterate over heap_list to cleanly
tear down the individual registered heaps.=20

Can this leave dangling references and lead to sysfs issues, since
device_destroy() and cdev_del() are never called for any active heaps before
the class is destroyed?

> +	unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
> +}
> +__exitcall(dma_heap_exit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D8
