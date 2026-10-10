Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CEFCA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 15:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A6F10E068;
	Sat, 10 Oct 2026 15:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gg1wSic9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E197510E068
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:12:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E9A541151;
 Sat, 10 Oct 2026 15:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300681F000FF;
 Sat, 10 Oct 2026 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791645164;
 bh=H+P/wL3zitAeIyoU57JVhuwa5yX/h6XhvME6dOVmtEw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gg1wSic9JR75K1uNkVBtoDMziIp/RvbGa6sra6KA25/17zO1J8Ppxmh2Urt1Ojnu/
 drD/NqDe7QCQ7jWZWPpQ1ah76WMDPGHIu51HaPBxCxUZPCDlNSQR9sNn+Xf5IstkOu
 NlkhQXam5r6EWUQkLASi5JCIC9i3ny4JN/LzIwxW4xoDnVsNC+qnYhS/td0mJQa1Ql
 4AUXEymwLgPjDxCQvRf4dxX7uSH0g7IAGsBPy5tF0W6RTRMcITG7Hdacd3F2G+7fFf
 Ibubrwk/0Quo7M6Z76TC1wIqiej6ENeaWsMhuGa9kHAYo31o4Dc6CKy5PBl0fhO005
 pPxJlMNQalZJw==
Message-ID: <sashiko-outbox-166686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/virtio: share one vbuf cache across all devices
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
References: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 15:12:43 +0000
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

> virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
> "virtio-gpu-vbufs" for every virtio-gpu device and destroys it from
> virtio_gpu_release(), which only runs once the last drm_device
> reference is dropped.
>=20
> Two live virtio-gpu devices are enough to hit this: the second
> kmem_cache_create() call finds the name already taken and
> kmem_cache_sanity_check() WARNs. This reproduces at plain boot with
> two "-device virtio-gpu-pci" on the QEMU command line, no sysfs
> remove/rescan or held-open fd needed.
>=20
>   kmem_cache of name 'virtio-gpu-vbufs' already exists
>   WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
>   Call Trace:
>    virtio_gpu_alloc_vbufs
> [ ... ]
> at module init and destroy it at module exit instead of per device.
>=20
> Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1b129b44597a126d2d79
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010150429.1703=
6-1-ngocthang2710.1999@gmail.com?part=3D1

