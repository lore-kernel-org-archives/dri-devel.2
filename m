Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A612DC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 04:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A9F010E0BA;
	Sun, 27 Sep 2026 04:29:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2E810E0BA
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 04:29:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05614437D1;
 Sun, 27 Sep 2026 04:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9A11F000FF;
 Sun, 27 Sep 2026 04:29:28 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: drop the dedicated vbuf kmem_cache
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260927042035.19956-1-ngocthang2710.1999@gmail.com>
References: <20260927042035.19956-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 04:29:28 +0000
Message-Id: <20260927042928.9C9A11F000FF@smtp.kernel.org>
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
> "virtio-gpu-vbufs" for every device and destroys it from
> virtio_gpu_release(), which only runs once the last drm_device
> reference is dropped. If a reference outlives the PCI removal (for
> instance an open /dev/fbN), a rescan probes the device again while the
> old cache still exists:
>=20
>   kmem_cache of name 'virtio-gpu-vbufs' already exists
>   WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
>   Call Trace:
>    virtio_gpu_alloc_vbufs
>    virtio_gpu_init
>    virtio_gpu_probe
>    ...
>    pci_rescan_bus
>    rescan_store
>=20
> kmem_cache_create() then fails and the new device does not probe.
>=20
> A vbuf is 216 bytes and lands in kmalloc-256 anyway, so the dedicated
> cache buys nothing. Use kzalloc()/kfree() and drop the per-device cache.
>=20
> Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1b129b44597a126d2d79
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927042035.1995=
6-1-ngocthang2710.1999@gmail.com?part=3D1

