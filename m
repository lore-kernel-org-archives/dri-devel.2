Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49313C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 20:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9132210E008;
	Sat, 26 Sep 2026 20:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vhmr3DQC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E20610E008
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 20:26:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E34BF4362D;
 Sat, 26 Sep 2026 20:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722131F000FF;
 Sat, 26 Sep 2026 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790454417;
 bh=MDpB++OXgphrlXMIsBfhJXooDzyrXgiN7rbftC+knj4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vhmr3DQCmCHnJ6jQrVFyuI2WHqxmADEzd+EnLqoPlvYV/T/BFAESrSfl0Q7Wxm+uM
 jOi+XuycAbRPEriCR7t1lC7Fwdvpdq5mwRh3pVT6P7KwP7y0d0v0CWrgWBT48C7rpc
 ChoqPtOvEOP9z45m91aXPFq8wXUE693YvhF37h5dD7Rv4VEwD8KLAaJtmt/URtGBmp
 3B8rpe8PPY7L2WFSgoccsqa86+bJAEqygqCXbN/t/2LqP8Wq50aXTBy6LDqNfjmdbn
 DhzALNwFIWXXKiFTLB+qbCaXF1jzBX0ZtWKJ/KFngMPP1i9+/aTJ3xsavjStFmIh/4
 tg5JMlP/sDqgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/virtio: Reset device before deleting virtqueues
 on freeze
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260926202040.1313385-1-oss.patchbox@gmail.com>
References: <20260926202040.1313385-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 20:26:56 +0000
Message-Id: <20260926202657.722131F000FF@smtp.kernel.org>
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

> virtgpu_freeze() waits for the control and cursor queues to drain and
> then deletes the virtqueues, but nothing tells the device to stop first.
> del_vqs() frees the vring backing, but does not provide a generic device
> quiesce operation. In particular, modern virtio-pci keeps enabled queues
> active until the device is reset, so the device is left DRIVER_OK with
> its queues pointing at memory that has been freed and may be reused while
> the guest is suspended. virtio_device_restore() only resets the device
> later, on resume.
>=20
> Reset the device before deleting the virtqueues, the way
> virtio_gpu_deinit() already does on removal.
>=20
> Fixes: cad6a879a7fb ("drm/virtio: Freeze and restore hooks to support sus=
pend and resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926202040.1313=
385-1-oss.patchbox@gmail.com?part=3D1

