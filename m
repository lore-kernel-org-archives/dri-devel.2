Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ED9E9DE6E
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808DF10E740;
	Thu,  9 Apr 2026 09:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="kUp408rw";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 54A6B10E740
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:16:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33EE94453;
 Thu,  9 Apr 2026 02:15:59 -0700 (PDT)
Received: from [10.1.29.18] (e122027.cambridge.arm.com [10.1.29.18])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD4D93F641;
 Thu,  9 Apr 2026 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775726164; bh=qljerWHdGjcRsoj8DYS4rLm4G3wOF5JV8ZcQ53p18mw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kUp408rwWPUzuKyMrMFDSczoe1VWnC43mIyA1OgM2Oz0F6HFW5yHa9UXhWizci6hH
 CMWOOjvo4WIsWPrzN9oFTmbV8NDWvEQCcfAscbJI8SZmvpD5Yk84iyU4L3G9YUbbrB
 1fjvWYENiu7Gg4p9kcPMSuXhpsUTt4lBoFLQlfsA=
Message-ID: <33e62b90-b9ab-4913-a2cd-aa18e35c7378@arm.com>
Date: Thu, 9 Apr 2026 10:15:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panthor: Fix outdated function documentation
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260408191228.537625-1-adrian.larumbe@collabora.com>
 <20260408191228.537625-2-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260408191228.537625-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 08/04/2026 20:12, Adrián Larumbe wrote:
> 'vm' is no longer allowed to be NULL.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

And for completeness:

Fixes: 8a1cc07578bf ("drm/panthor: Add GEM logical block")

Thanks,

Steve

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 69cef05b6ef7..13295d7a593d 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1264,7 +1264,7 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
>  /**
>   * panthor_kernel_bo_create() - Create and map a GEM object to a VM
>   * @ptdev: Device.
> - * @vm: VM to map the GEM to. If NULL, the kernel object is not GPU mapped.
> + * @vm: VM to map the GEM to.
>   * @size: Size of the buffer object.
>   * @bo_flags: Combination of drm_panthor_bo_flags flags.
>   * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those

