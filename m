Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB6D6AB0A
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 20:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DCB10F342;
	Thu,  2 Apr 2026 20:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UUmingpm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A0110F28B;
 Thu,  2 Apr 2026 20:14:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BC8A42BAD;
 Thu,  2 Apr 2026 20:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F6FC116C6;
 Thu,  2 Apr 2026 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775160892;
 bh=HNTeodBqDVGRGqH73B5AhKGxKZ8pTeccNAxLgIKy6X8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UUmingpm59+E+zJvRBvxXziPXDTybVJowAXF6BtM8uE2u64oB1chE5JsseklIn4sD
 DVhwxYXn+n7jg0pzkRmNx9+JfbprGgcC25Q4mvBvOI/S9MvaEugP5dl+DP83sStRMs
 4c7WJgXedQkWXu8C6eRUFY/ym/kQTi9yReZRGrMTWShgJEhZ08Da5hddghrwR6qhFH
 YhTCHBqOLFW09Nmmw4rLZnaswqXLtUFuaxE2nsVWQMu3pQmdtSwD+LpxlcJ6hP6P9j
 7pxYxs01fxKWMKBoEPkPtZ2YWzRikvBFz+XxB0k5og5R8Qe0ZZPLEfGtLlO+Vn9BSm
 1z2zNy0umzhpw==
Date: Thu, 2 Apr 2026 15:14:50 -0500
From: Rob Herring <robh@kernel.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org, mripard@kernel.org,
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v12 68/69] accel/ethosu: call DRM_CLASSMAP_USE
Message-ID: <20260402201450.GA966967-robh@kernel.org>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
 <20260326185413.1205870-69-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326185413.1205870-69-jim.cromie@gmail.com>
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

On Thu, Mar 26, 2026 at 12:54:12PM -0600, Jim Cromie wrote:
> ethosu.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
> to tell dynamic-debug what classmap enables them.
> Also include drm/drm_print.h explicitly.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---

Didn't I ack this already? It is up to you to add tags when you send a 
new version.

Or did it change? I can't tell as there is no changelog here.

>  drivers/accel/ethosu/ethosu_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> index 9992193d7338..a0b8cb81a359 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -17,12 +17,15 @@
>  #include <drm/drm_gem.h>
>  #include <drm/drm_accel.h>
>  #include <drm/ethosu_accel.h>
> +#include <drm/drm_print.h>
>  
>  #include "ethosu_drv.h"
>  #include "ethosu_device.h"
>  #include "ethosu_gem.h"
>  #include "ethosu_job.h"
>  
> +DRM_CLASSMAP_USE(drm_debug_classes);
> +
>  static int ethosu_ioctl_dev_query(struct drm_device *ddev, void *data,
>  				  struct drm_file *file)
>  {
> -- 
> 2.53.0
> 
