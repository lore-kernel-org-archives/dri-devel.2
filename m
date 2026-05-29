Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C664CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 17:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7751122A9;
	Fri, 29 May 2026 17:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WM+BvkeK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FECD1122A9;
 Fri, 29 May 2026 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780074632;
 bh=ZuWhak9qN2sQ+tzY00zjhZkVc1vvwe4ZkcNwHcngSxQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WM+BvkeKUOSrgN1rt+hTrXbLAWcWn4Pc3kfn5lBBQmBuOR+IQPLBMNiWP3QgYU8oC
 mq58Zx3JmkPY2NqM65Y+/dWq6RF7Gti3EbZBQ0fp/Jcu0OgBJmCP6AqyjrI/CseU/t
 4JDG9p+eE4Yk2DUQ1sHKe0LNDwf8Ij1kzsRTJVetQY7wDRfsfplQi3VC3f4Gf0YJTW
 egr2mE+VOPb2gnymq1gExh9RSg0vXcNFHyZXiNlCdmbvkrI9/Uw8f/cZtBLZO+C+UK
 4SeFusWJCyN65gPOD1OlJlcvkY2OCJ1yCtpkSu5NoVWqlhQeM3SO0qxipt09XxzHNu
 /0d+v5xH45avQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C8C917E0566;
 Fri, 29 May 2026 19:10:32 +0200 (CEST)
Date: Fri, 29 May 2026 19:10:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: dakr@kernel.org, steven.price@arm.com, liviu.dudau@arm.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH] drm: Remove DRIVER_GEM_GPUVA feature flag
Message-ID: <20260529191027.40e1ec5b@fedora>
In-Reply-To: <20260421084701.24227-1-laura.nao@collabora.com>
References: <20260421084701.24227-1-laura.nao@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi,

On Tue, 21 Apr 2026 10:47:01 +0200
Laura Nao <laura.nao@collabora.com> wrote:

> The DRIVER_GEM_GPUVA feature flag is currently only used to control two
> behaviors within the DRM core:
> - calling  drm_gem_gpuva_init() during
>   GEM object initialization
> - creating the "gpuvas" debugfs entry
> 
> drm_gem_gpuva_init() is a plain INIT_LIST_HEAD() and therefore is cheap
> to run for every GEM object. The DRM_DEBUGFS_GPUVA_INFO macro is only
> referenced by GPU-VA capable drivers, so clearing the feature bit does
> not cause any unrelated drivers to get the "gpuvas" debugfs node. The
> flag doesn't have any relevant purpose (e.g. gating ioctl handlers or MM
> logic) and doesn't provide any practical benefit.
> 
> Remove the flag definition and drop it from all drivers that use it,
> call drm_gem_gpuva_init() unconditionally and clear the driver features
> bit in DRM_DEBUGFS_GPUVA_INFO.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem.c             | 3 +--
>  drivers/gpu/drm/imagination/pvr_drv.c | 2 +-
>  drivers/gpu/drm/msm/msm_drv.c         | 2 --
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 1 -
>  drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
>  drivers/gpu/drm/xe/xe_device.c        | 2 +-
>  include/drm/drm_debugfs.h             | 2 +-
>  include/drm/drm_drv.h                 | 6 ------
>  include/drm/drm_gem.h                 | 3 ---
>  9 files changed, 5 insertions(+), 18 deletions(-)

I took the liberty to queue this one to drm-misc-next even though it
was lacking R-b/A-b from Nouveau/Pvr maintainers because

- it's pretty trivial
- it's been posted more than a month ago
- we need it to make progress on the Tyr side
- if it's broken (I honestly doubt it), we still have a full release
  cycle to revert

Regards,

Boris
