Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09854C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 04:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CCC10E0C2;
	Sun, 27 Sep 2026 04:19:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F7810E0C2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 04:19:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0060060120;
 Sun, 27 Sep 2026 04:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F241F000FF;
 Sun, 27 Sep 2026 04:19:13 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: put GEM objects when dropping a vbuf on unplug
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
References: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 04:19:10 +0000
Message-Id: <20260927041913.55F241F000FF@smtp.kernel.org>
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

> virtio_gpu_queue_ctrl_sgs() drops the command when drm_dev_enter() fails
> or when vqs_released is set. It unlocks the reservation and frees the
> vbuf, but never releases the references that the caller handed over in
> vbuf->objs. Those references are normally dropped from the dequeue path,
> which never sees a command that was not queued.
>=20
> If a framebuffer flush races with device removal, the GEM object backing
> the fbdev buffer keeps a stale reference, is never freed, and its node is
> still in the vma offset manager when the drm_device is released:
>=20
>   Memory manager not clean during takedown.
>   WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown
>   Call Trace:
>    drm_managed_release
>    drm_dev_put
>    virtio_dev_remove
>    virtio_pci_remove
>    pci_device_remove
>    remove_store
>=20
> Drop the object references together with the vbuf on both early-exit
> paths.
>=20
> Reported-by: syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd93b9064fe5f74af3aa3
> Fixes: b7170f9457f2 ("drm/virtio: return virtio_gpu_queue errors")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927040655.1453=
1-1-ngocthang2710.1999@gmail.com?part=3D1

