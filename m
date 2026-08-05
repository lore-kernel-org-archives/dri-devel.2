Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4730FC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D4710EDF7;
	Wed,  5 Aug 2026 11:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gIkreivZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E092710E15B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785929281; x=1817465281;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=H+1YnhIQAneUZwC0Y1Yb7xsyru1/OSp0XgmQJ0ad2Zs=;
 b=gIkreivZTv5YNc7JoUxMp8VWm3QH8yMFlH6i1A9dUEpmhUYhN8a9zaXy
 2XWyE9+ZzuQU/BCTgvi2cc1pOCJzDNWHrXSPNQymrDUAWhh+X1NppY/yp
 F9H0uvBuKlQdaBgWdojLP0VHMreYfGRIRBKV85AXQ3lasD5BYQCHRcbBx
 LOJf/4Crw9G/jWmKLAlS7T2KKYiDa9f8T9vZiUcZ7UY0apEzWATepet5/
 HRKijUzYL7geNw3tI/+iQLV8+Esn2j4tuKhF6hRjr+j01KQ/oALtMn+L+
 cG3TarDYEMFuHnKs1yzkTbRHJ9UfKSr5iodeG55ktFGMK0KfxozBSEdIx w==;
X-CSE-ConnectionGUID: W94pK8HGSeSmcqW6htODgA==
X-CSE-MsgGUID: iwwdFknXRfewvsq8HIKkHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="74035140"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="74035140"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:27:58 -0700
X-CSE-ConnectionGUID: 6L/m8W8VSKmfx5sJiD6tnQ==
X-CSE-MsgGUID: MUzCAaBSRjSNm/eqhNT/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="263778077"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:27:54 -0700
Date: Wed, 5 Aug 2026 13:27:51 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for drm_ras
Message-ID: <anMeN5B8LbaM41jz@black.igk.intel.com>
References: <20260805094949.536651-2-rodrigo.vivi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805094949.536651-2-rodrigo.vivi@intel.com>
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

On Wed, Aug 05, 2026 at 05:49:50AM -0400, Rodrigo Vivi wrote:
> DRM RAS interface provides a standardized way for GPU/accelerator
> drivers to expose error counters and other reliability nodes to
> user space via Generic Netlink.
> 
> Since this is cross-driver infrastructure carrying its own uAPI, add a
> dedicated MAINTAINERS entry covering the implementation, headers,
> netlink spec and documentation, maintained through drm-misc.
> 
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: David Airlie <airlied@redhat.com>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Raag Jadav <raag.jadav@intel.com>
> Cc: Riana Tauro <riana.tauro@intel.com>
> Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114e6db7307..51be7ad24528 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9039,6 +9039,19 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	drivers/gpu/drm/drm_privacy_screen*
>  F:	include/drm/drm_privacy_screen*
>  
> +DRM RAS
> +M:	Raag Jadav <raag.jadav@intel.com>

This one should be 'R' and not 'M'.

Raag

> +M:	Riana Tauro <riana.tauro@intel.com>
> +M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
> +R:	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Supported
> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:	Documentation/netlink/specs/drm_ras.yaml
> +F:	Documentation/gpu/drm-ras.rst
> +F:	drivers/gpu/drm/drm_ras*
> +F:	include/drm/drm_ras*
> +
>  DRM TTM SUBSYSTEM
>  M:	Christian Koenig <christian.koenig@amd.com>
>  M:	Huang Rui <ray.huang@amd.com>
> -- 
> 2.55.0
> 
