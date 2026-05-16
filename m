Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47E0CD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB06910E17D;
	Sat, 16 May 2026 11:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MPbcEsl3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F1210E17D;
 Sat, 16 May 2026 11:37:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CDC043F06;
 Sat, 16 May 2026 11:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD8CC19425;
 Sat, 16 May 2026 11:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1778931444;
 bh=8LMT1TIsNVvknyrLg69MYjeZewa0zQXqnKxuS28eL+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MPbcEsl37NrIoi6gkugdu76RGm+1B1heXb0avm7x3+5zUv3BKP6/+DAud92stKTIy
 kVV9us91F1CU39b8ftDkbwPgqSfZj9wdQ9o3dELEOwiFS9+rHKDvQMw0oRxHPIFE8N
 CasPNjOXD9veE4YohlCf8+S1cGeUkKhoENg/gaYk=
Date: Sat, 16 May 2026 13:37:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Julian Orth <ju.orth@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH 12/12] misc/syncobj: add new device
Message-ID: <2026051653-walmart-morally-3be7@gregkh>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <20260516-jorth-syncobj-v1-12-88ede9d98a81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516-jorth-syncobj-v1-12-88ede9d98a81@gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, May 16, 2026 at 01:06:15PM +0200, Julian Orth wrote:
> This device makes the DRM_IOCTL_SYNCOBJ_* ioctls available via a
> dedicated device. This allows applications to use syncobjs without
> having to open device nodes in /dev/dri, on systems that don't have any
> such nodes, or on systems whose devices don't support the
> DRIVER_SYNCOBJ_TIMELINE feature.
> 
> Wayland uses syncobjs as its buffer synchronization mechanism. Most
> compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a pure
> CPU wait for syncobj point. DRM devices are not involved in this process
> except insofar that a DRM device needs to be used to access the ioctl.
> 
> Similarly, a software-rendered client might perform rendering on a
> dedicated thread and use the wayland syncobj protocol to submit frames
> before they finish rendering. Again, this does not involve DRM devices
> except insofar ... as above.
> 
> As an added benefit, this device removes the need to translate between
> file descriptors and handles.
> 
> Signed-off-by: Julian Orth <ju.orth@gmail.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
>  drivers/misc/Kconfig                               |  10 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/syncobj.c                             | 404 +++++++++++++++++++++
>  include/uapi/linux/syncobj.h                       |  75 ++++
>  5 files changed, 491 insertions(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 331223761fff..5e140ae5735e 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -395,6 +395,7 @@ Code  Seq#    Include File                                             Comments
>                                                                         <mailto:michael.klein@puffin.lb.shuttle.de>
>  0xCC  00-0F  drivers/misc/ibmvmc.h                                     pseries VMC driver
>  0xCD  01     linux/reiserfs_fs.h                                       Dead since 6.13
> +0xCD  00-0F  uapi/linux/syncobj.h
>  0xCE  01-02  uapi/linux/cxl_mem.h                                      Compute Express Link Memory Devices
>  0xCF  02     fs/smb/client/cifs_ioctl.h
>  0xDD  00-3F                                                            ZFCP device driver see drivers/s390/scsi/
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 00683bf06258..c1e7749bd356 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -644,6 +644,16 @@ config MCHP_LAN966X_PCI
>  	    - lan966x-miim (MDIO_MSCC_MIIM)
>  	    - lan966x-switch (LAN966X_SWITCH)
>  
> +config SYNCOBJ_DEV
> +	tristate "DRM syncobj device (/dev/syncobj)"
> +	depends on DRM

If this is a drm-only thing, then please put it in the drm subdirs, not
in drivers/misc/ as that would imply that I have to maintain this, not
the DRM developers :)

thanks,

greg k-h
