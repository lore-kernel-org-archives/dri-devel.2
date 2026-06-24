Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB39CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B3910EF90;
	Wed, 24 Jun 2026 15:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="IDggzKwH";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9BAE810EF90
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 15:19:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A5AB2308;
 Wed, 24 Jun 2026 08:19:05 -0700 (PDT)
Received: from [10.57.80.146] (unknown [10.57.80.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C401B3F905;
 Wed, 24 Jun 2026 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782314350; bh=yMU1xAW7VCLIeDPTW+Y/l8HNR8dMHkFt4p4XaemorO4=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=IDggzKwHyOv+/3e1mWxdEbYynKeessxJnubIw91Kperm7fXpM7lNSsQE1g5FzhP9B
 gr9FwCxr4Rj0H4s9Oponq6VpSUUlt18B+eJ4+duI0MPZBEEJgn6GkS1ayL9gIZolYR
 oqCZBwPQLG+zwtnOWuev5zopPr+mHcXWB3aGrqLA=
Message-ID: <2d4c1f13-f3c5-4a45-82d6-7d6441957eb0@arm.com>
Date: Wed, 24 Jun 2026 16:19:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: include panfrost_drv.h for
 panfrost_transparent_hugepage
To: Ben Dooks <ben.dooks@codethink.co.uk>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
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

On 23/06/2026 11:46, Ben Dooks wrote:
> The panfrost_transparent_hugepage variable is declared in panfrost_drv.h
> but the panfrost_drv.c does not incldue this header. Fix the following
> sparse warning by including panfrost_drv.h :
> 
> drivers/gpu/drm/panfrost/panfrost_drv.c:958:6: warning: symbol 'panfrost_transparent_hugepage' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 784e36d72c2b..36cc2e67a308 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -21,6 +21,7 @@
>  #include <drm/drm_utils.h>
>  
>  #include "panfrost_device.h"
> +#include "panfrost_drv.h"
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
>  #include "panfrost_job.h"

