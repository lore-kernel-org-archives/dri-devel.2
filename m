Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADD3CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5FA10ECD9;
	Thu, 11 Jun 2026 06:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dTTB6sTM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4833710ECD9
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:04:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 816DA60208;
 Thu, 11 Jun 2026 06:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197F71F00893;
 Thu, 11 Jun 2026 06:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781157888;
 bh=jIPoOq4t826X4M/qcAVhDos7j0IOhlQVaEh9o8Wlx+E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dTTB6sTM3FL7xsOP27cEaVG9Wyi3KX0TCXqjXX2yEUmvEyL4fXx78o4mnMxB2KMdd
 ivrtC7YBTFqYtcd+57c7Y00EXtCgBmoG005vzSozaeILhPG1g+SoClMrN16pTyGu+4
 WaoRsXKSQi411VlWtN7a3s2FpGWz6e2cLqcrD05s4lNMlVllvAuVcOOpQSNaECq7vh
 U6EVYEYbO1b6b09OOBe5OKVEZ2dPG9zlLbkBxDr1zAxOuDa5UyV+kDRcEGVC8V3UcA
 IL7qXfunap2lHCSC3bqP585TZWAqG3teq2uC/kaXOY0bxNm3NO49fntRhYNyPha8yU
 DfvpCNltuzVwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: use kmem_cache for IPC rx_msg allocations
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611055214.948748-1-karol.wachowski@linux.intel.com>
References: <20260611055214.948748-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:04:47 +0000
Message-Id: <20260611060448.197F71F00893@smtp.kernel.org>
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
- [Medium] Duplicate kmem_cache name on multi-device systems
--

commit 41c16409be6704d2ef5ab21270390fee65dcf7aa
Author: Karol Wachowski <karol.wachowski@linux.intel.com>

accel/ivpu: use kmem_cache for IPC rx_msg allocations

This commit introduces a dedicated kmem_cache for allocating IPC rx_msg
objects to reduce allocator overhead in IRQ handlers.

> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c

[ ... ]

> @@ -490,10 +490,18 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
>  	struct ivpu_ipc_info *ipc =3D vdev->ipc;
>  	int ret;
> =20
> +	ipc->rx_msg_cache =3D kmem_cache_create("ivpu_ipc_rx_msg", sizeof(struc=
t ivpu_ipc_rx_msg), 0,
> +					      SLAB_HWCACHE_ALIGN, NULL);

[Severity: Medium]
Will this cause a name collision if there are multiple ivpu devices in the
same system?

Since this is initialized per-device in ivpu_ipc_init(), calling
kmem_cache_create() multiple times with the same hardcoded string
"ivpu_ipc_rx_msg" can trigger a kernel WARN in kmem_cache_sanity_check()
when CONFIG_DEBUG_VM is enabled.

Furthermore, if SLUB merging is disabled via boot parameters or config,
the duplicate name causes a sysfs kobject collision, leading to a sysfs
warning and a failure to register the cache in sysfs.

Should this cache name be made unique per device using dev_name(), or=20
should the cache be a global singleton?

> +	if (!ipc->rx_msg_cache) {
> +		ivpu_err(vdev, "Failed to create rx_msg_cache\n");
> +		return -ENOMEM;
> +	}
> +
>  	ipc->mem_tx =3D ivpu_bo_create_global(vdev, SZ_16K, DRM_IVPU_BO_WC | DR=
M_IVPU_BO_MAPPABLE);
>  	if (!ipc->mem_tx) {
>  		ivpu_err(vdev, "Failed to allocate mem_tx\n");
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto err_destroy_cache;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611055214.9487=
48-1-karol.wachowski@linux.intel.com?part=3D1
