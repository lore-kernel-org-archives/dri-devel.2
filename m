Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2F1CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA79311238A;
	Thu, 15 Oct 2026 14:44:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE0011238A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:44:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76C244363B;
 Thu, 15 Oct 2026 14:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A971F000C4;
 Thu, 15 Oct 2026 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792075452;
 bh=z+CDkoCSZLN1MOVhIw3dKh4lpkaRSWDSWyNkXPNjypY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TOo1oVXD7ZPUEkiTcvuKJC1vohQVa/ydz1nmAWXc4OJW4tHY3VWHAUz+CZeSzCREe
 6Ck9P3JeYcoM6wwv4Q7Y/Tw/U3yhLEOrfcmmndHN12CV93d5e0JHLBvdCJXzG1139w
 SZXYHTWOp/gSJKeChOAcsjq8KN9B+iJofNlNWs9gk15gmnWvPsMsPvmYnzsnr8wVrA
 L8fjC3GsWr5uQVN+DxNV+jyF1tc+rp0g/oYA0Ab0J2fhaXj87+lStrIeEo+Fb3ZFqT
 YmY0Wtho8uknR/7qKJqqIEN4wf/D0ppuIbRGi+Vk5XMk9vCkcT8C+BwzISOeH5lOWT
 oXMHleAfbBHig==
Message-ID: <sashiko-outbox-172976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 12/15] vfio: Support VFIO devices that access the
 CPU MMU
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20261015142552.4128028-13-ryan.roberts@arm.com>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-13-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:44:11 +0000
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
- [High] vfio: NULL pointer dereference in vfio_df_iommufd_bind() via cdev =
ioctl
- [High] vfio: NULL pointer deref when binding IOMMUFD to CPU_MMU cdev
--

commit 147c0e7516a85b91b63d3c3d8f78088a9ca5c65f
Author: Jean-Philippe Brucker <jpb@kernel.org>

vfio: Support VFIO devices that access the CPU MMU

Support devices that are attached to a CPU and perform DMA through a
MMU without an IOMMU or VFIO container. The VMM uses device-specific
knowledge to handle virtual device creation.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe3..41fee81a14cbb 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -344,7 +344,8 @@ static int __vfio_register_dev(struct vfio_device *de=
vice,
>  {
>  	int ret;
> =20
> -	if (WARN_ON(IS_ENABLED(CONFIG_IOMMUFD) &&
> +	if (type !=3D VFIO_CPU_MMU &&
> +	    WARN_ON(IS_ENABLED(CONFIG_IOMMUFD) &&
>  		    (!device->ops->bind_iommufd ||
>  		     !device->ops->unbind_iommufd ||
>  		     !device->ops->attach_ioas ||
>  		     !device->ops->detach_ioas)))
>  		return -EINVAL;

[Severity: High]
Could this bypass lead to a NULL pointer dereference for users of the
character device interface?

When CONFIG_VFIO_DEVICE_CDEV is enabled, vfio_device_add() automatically
creates a character device node (e.g., /dev/vfio/devices/vfioX) for the
registered device. If an untrusted user opens this cdev file and invokes
the VFIO_DEVICE_BIND_IOMMUFD ioctl, the request routes through the
following path:

vfio_df_ioctl_bind_iommufd()
  vfio_df_open()
    vfio_df_device_first_open()
      vfio_df_iommufd_bind()

Inside vfio_df_iommufd_bind() in drivers/vfio/iommufd.c, the code=20
unconditionally executes:

return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);

Since the updated check permits VFIO_CPU_MMU devices to be registered=20
without providing a bind_iommufd callback, this would result in an
immediate NULL pointer dereference.=20

Similarly, calling the VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl on the cdev=20
unconditionally dereferences the attach_ioas pointer in=20
vfio_df_ioctl_attach_pt(), which would also crash the kernel.

Should there be explicit checks in the cdev ioctl handlers to return
-EOPNOTSUPP for devices lacking these callbacks, or should VFIO_CPU_MMU=20
devices perhaps be excluded from cdev creation entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015142552.4128=
028-1-ryan.roberts@arm.com?part=3D12
