Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8842ACA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C703E10E1CD;
	Tue, 29 Sep 2026 07:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XTuTHVLV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA5310E1CD
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:16:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B9A241F9B;
 Tue, 29 Sep 2026 07:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E67C1F00898;
 Tue, 29 Sep 2026 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790666213;
 bh=/SdbbcPpSAU3qNhopsqNbdN09LfadPeBo0E9CzGhLgk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XTuTHVLVvcPsvwAB2u22IXamiM9zWz7tOHPxrIMFM+D1HcJDwzhfVmxdxpl5wbhxP
 P6W0yW65qVU12SsyotLazDyapZO96meCinWwJHTXnguJNy+OFjEM9jpr/o76JynYwO
 T6dU1wRf6gBIjwTuWJFvz07g5zMTpBNa823AfMeUz0dGIa/nNxxVSajkcHVus+kbQK
 ADbUEroao//nXDs+G0lqf465iz38PQ6ZZn4sk2jVk1MbB24BAiUVaanrayMsTftCCM
 Vi+3ajgkRTjoNy3yv/Wp0hbkDNLyE4v789irPcxGHxFPNdjZf7jdinT0aoMRdGL3Kj
 UnxC3CYvu7Q4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Destroy obj_restore_lock on the final
 drm_dev_put()
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260929070714.169412-1-abhinjoses@gmail.com>
References: <20260929070714.169412-1-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:16:52 +0000
Message-Id: <20260929071653.1E67C1F00898@smtp.kernel.org>
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

> virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
> deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
> objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
> alive, and the fbdev DRM client holds a drm_device reference. When the
> fd is finally closed, the buffer is freed and takes the destroyed lock:
>=20
>   fb_release()
>     drm_fbdev_shmem_fb_destroy()
>       drm_client_buffer_delete()
>         virtio_gpu_free_object()
>           virtio_gpu_remove_from_restore_list()
>             mutex_lock(&vgdev->obj_restore_lock)
>=20
>   DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
>   WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec
> [ ... ]
> Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring vi=
rtio_gpu_objects")
> Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D3590d97d8a586fa955c2
> Assisted-by: LLM
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929070714.1694=
12-1-abhinjoses@gmail.com?part=3D1

