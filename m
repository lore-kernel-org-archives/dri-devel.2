Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C1FF419BB
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EDD10E6E0;
	Wed, 15 Apr 2026 13:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nw1IkhAX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AAD610E6E0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776261254; x=1807797254;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=coLVlYR6NEY7VBueTqak62GHfbDwf6EkVP+t/bPcVJ4=;
 b=Nw1IkhAXmTXZujZcDPRtOa6x6lFGXSuiP9IO2INU56WtGN8YNFXbMhEq
 6vHFpI1TNc8KmvSbrZSpAkPOtRdYtnxlRBWtwpcEAqSSTZ5dyOWcex8ac
 BprQJyyiysbXVxN/4cHED0vsYAovVWDoumnwuacyrHyPbVMUKJCWWDqlC
 9cc4a6WGir5YN5nDzajUXqQSS+R6sjUGnjFVKT6lELpWd2tgB/u4rq4QA
 jhqjO9Sqbu9XjhU+VPQJoQHZ1PVMtx08xNPBXf0vvSwd5AFy5A0GMEulT
 YwSJjRVGzO+QVeF6OcutOUBAofYL2YaVptJJ91xdE5tOGsC40jjsXrbSJ A==;
X-CSE-ConnectionGUID: WrZgYWvjT2KC3+WRJPlPvg==
X-CSE-MsgGUID: 3XyqS74uTVaitAleUsC19g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88687040"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="88687040"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 06:54:14 -0700
X-CSE-ConnectionGUID: RD6rgY1UQMqoG4yXLUt1bA==
X-CSE-MsgGUID: +DsdquomRgCUS7/gLA8aGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="229399969"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.25])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 06:54:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 6/6] drm/panthor: Bump the driver version to 1.9
In-Reply-To: <20260415112900.681834-7-adrian.larumbe@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-7-adrian.larumbe@collabora.com>
Date: Wed, 15 Apr 2026 16:54:06 +0300
Message-ID: <65fecdade3d25886c2c110d399517408b7a8ea34@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 15 Apr 2026, Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wro=
te:
> Bump the driver version to reflect the new MMU info query ioctl
> parameter and the VM_BIND map sparse flag.

You're not actually bumping the version, just adding to the comment.

Does the version actually work for you for checking stuff? Do you have
userspace checking it? Should it be some capability thing instead?

BR,
Jani.

>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index a8090bc4e33c..c8fb63ede62c 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1787,6 +1787,8 @@ static void panthor_debugfs_init(struct drm_minor *=
minor)
>   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
>   *       - adds drm_panthor_gpu_info::selected_coherency
>   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
> + * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
> + *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
>   */
>  static const struct drm_driver panthor_drm_driver =3D {
>  	.driver_features =3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |

--=20
Jani Nikula, Intel
