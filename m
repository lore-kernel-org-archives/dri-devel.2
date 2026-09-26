Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C944C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AB510E050;
	Sat, 26 Sep 2026 16:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OgbOxHbL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE90710E050
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:33:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5221A43FBE;
 Sat, 26 Sep 2026 16:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFAB1F000FF;
 Sat, 26 Sep 2026 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790440391;
 bh=DC49a69vTi4kk21TyRDDzbBEZH85eWAv5sh8dSCrfdc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OgbOxHbLZUdcSTawsuZoGHTTTr+bEyxkdN/wws2u61lY8gnovN8j9YAZydOvFPAbB
 ZEf1DuOy5XKXqBt96Kzuck5MFbBiUfbkxMyZLuhN47BotNEUs1pE3VnwDTxrLRJl6b
 sZGpvJ/P8RhAZZLvr2dmQxjLcRdoJ7nVX8ltr80k98mmTle50oWNyfE9Ki83pkwC2N
 cwG6yO7vUaabOa0+7moyjrpFXNbwIobQinV68gEOwrEp8abSoV86zSoMDvIZV1ROtz
 rJTXquHPDRsSg7T3Wi4RNtcUCDc08dgRrjS+HBUaYYTRQ3BhhfvcU1n0x42I8fTBg4
 P44yTz+d74o4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
In-Reply-To: <20260926162452.136863-1-ngocthang2710.1999@gmail.com>
References: <20260926162452.136863-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:33:10 +0000
Message-Id: <20260926163310.DDFAB1F000FF@smtp.kernel.org>
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
> The vbuf size is the same for every device, so create the cache once
> at module init and destroy it at module exit instead of per device.
>=20
> Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1b129b44597a126d2d79
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926162452.1368=
63-1-ngocthang2710.1999@gmail.com?part=3D1

