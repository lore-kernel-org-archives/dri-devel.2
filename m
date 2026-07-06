Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5F9C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E1510E357;
	Mon,  6 Jul 2026 10:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ZAGgHBHy";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 718CE10E357
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:58:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A68AE1576
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:58:29 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 C63EC3F85F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783335514; bh=FcabjikKPQe1tvCPKjTLPI5nA3T+6QR9xzkU0EJ/khE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZAGgHBHyFZbHLsH/5nqy2px7nz5ZYPi0YB3O4S3WKWxx6GUv1wZXytGssdAXf5yBp
 yv0v9q5IwaP5spomlsRVqVK//o0Pso2znghbjpSmaFPQISpqxO2jkcWfyaQqFDG0RJ
 y0fiOxSDDBy+xAk0VlK0QbONcMyT/c1+80RmYkf4=
Date: Mon, 6 Jul 2026 11:58:23 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drm/panthor: Fix comment to reflect actual struct
 field name
Message-ID: <akuKT8elJUXcXw1v@e142607>
References: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
 <20260704-vm_bind_checks-v4-3-4705b6ca9f8a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260704-vm_bind_checks-v4-3-4705b6ca9f8a@collabora.com>
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

On Sat, Jul 04, 2026 at 05:46:46AM +0100, Adrián Larumbe wrote:
> The mismatch would pop up when building the kernel with W=1.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 662a2c13b467..d09d5641e6c0 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -306,7 +306,7 @@ struct panthor_vm {
>  		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel BOs. */
>  		u64 start;
>  
> -		/** @kernel_auto_va.size: Size of the automatic VA-range for kernel BOs. */
> +		/** @kernel_auto_va.end: End of the automatic VA-range for kernel BOs. */
>  		u64 end;
>  	} kernel_auto_va;
>  
> 
> -- 
> 2.55.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
